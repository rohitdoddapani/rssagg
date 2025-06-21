package main

import (
	"net/http"

	"github.com/rohitdoddapani/rssagg/internal/auth"
	"github.com/rohitdoddapani/rssagg/internal/database"
)

type authHandler func(http.ResponseWriter, *http.Request, database.User)

func (cfg *apiConfig) middlewareAuth(handler authHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		apikey, err := auth.GetAPIKey(r.Header)
		if err != nil {
			respondWithError(w, http.StatusUnauthorized, "Unauthorized: "+err.Error())
			return
		}

		user, err := cfg.DB.GetUserByAPIKey(r.Context(), apikey)
		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "Failed to get user")
			return
		}

		handler(w, r, user)
	}
}
