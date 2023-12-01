(ns aoc.core
  (:require [aoc.utils :as utils]
            [aoc.year-2022.day-01 :as day-01]))

(defn -main
  "Run the Advent of Code scripts."
  [day] ;; TODO add year
  (println (day-01/part-1 (utils/read-lines 2022 1))))
