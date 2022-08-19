package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"github.com/Joris1Jansen/simplebank/util"
	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
    config, err := util.LoadConfig("../..")
    if err != nil {
        log.Fatal("Cannot load condig: ", err)
    }

    testDB, err = sql.Open(config.DBDriver, config.DBSource)
    if err != nil {
        log.Fatal("Cannot connect to db: ", err)
    }

    testQueries = New(testDB)

    os.Exit(m.Run())
}
