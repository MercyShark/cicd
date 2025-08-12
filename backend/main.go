package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	router := gin.Default()

	err := godotenv.Load()

	if err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	router.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
			"db_user": os.Getenv("DB_USER"),
		})
	})

	router.Run("0.0.0.0:8080")
}
