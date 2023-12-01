(defn hello-world []
  (println "Hello, World!"))

(defn advent-of-code []
  (println "Advent of Code!")
  (println "Which year?")
  (let [year (read-line)]
    (println "Which day?")
    (let [day (read-line)]
      (println "Which part?")
      (let [part (read-line)]
        (println (format "Year: %s, Day: %s, Part: %s" year day part))))))

(hello-world)
(advent-of-code)
