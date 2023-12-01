(ns aoc.utils
  (:require [clojure.string :as str]
            [clojure.java.io :as io]))

(defn file-path [year day]
  (str "../../inputs/year_" year "/day_" (format "%02d" day) ".txt"))

(defn read-lines [year day]
  (line-seq (io/reader (file-path year day))))
