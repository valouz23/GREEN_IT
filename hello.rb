require 'benchmark'

def liste_aleatoire_triee(taille, min, max)
  liste = []
  taille.times { liste << rand(min..max) }
  liste.sort!
end

def recherche_lineaire(element, liste)
  n = liste.length
  for i in 0..n - 1 do
    return i if liste[i] == element
  end
  -1
end

def recherche_binaire(element, liste)
  debut = 0
  fin = liste.length - 1
  while debut <= fin
    milieu = (debut + fin) / 2
    if liste[milieu] == element
      return milieu
    elsif liste[milieu] > element
      fin = milieu - 1
    else
      debut = milieu + 1
    end
  end
  -1
end

def rec_fun(debut, fin, element, liste)
  return -1 if fin < debut
  milieu = (debut + fin) / 2
  if liste[milieu] == element
    milieu
  elsif liste[milieu] > element
    rec_fun(debut, milieu - 1, element, liste)
  else
    rec_fun(milieu + 1, fin, element, liste)
  end
end

def recherche_recursive(element, liste)
  return rec_fun(0, liste.length - 1, element, liste)
end

def calcul_temps(element, liste, function)
  if function == 'rec'
    recherche_recursive(element, liste)
  end
  if function == 'lin'
    recherche_lineaire(element, liste)
  end
  if function == 'bin'
    recherche_binaire(element, liste)
  end
  sum = 0
  1000000.times{ |i| sum += i }
end

taille = 100000
nb_tests = 100
max_liste = 100000
l = liste_aleatoire_triee(taille, 0, max_liste)


petit_lin = Benchmark.realtime do
  calcul_temps(10, l, 'lin')
end
petit_bin = Benchmark.realtime do
  calcul_temps(10, l, 'bin')
end
petit_rec = Benchmark.realtime do
  calcul_temps(10, l, 'rec')
end
moyen_lin = Benchmark.realtime do
  calcul_temps(9876, l, 'lin')
end
moyen_bin = Benchmark.realtime do
  calcul_temps(9876, l, 'bin')
end
moyen_rec = Benchmark.realtime do
  calcul_temps(9876, l, 'rec')
end
grand_lin = Benchmark.realtime do
  calcul_temps(87640, l, 'lin')
end
grand_bin = Benchmark.realtime do
  calcul_temps(87640, l, 'bin')
end
grand_rec = Benchmark.realtime do
  calcul_temps(87640, l, 'rec')
end

puts "Temps d'éxecution de chaque fonction pour le nombre 10 dans une liste de taille #{taille} :"
puts "Fonction linéraire : #{petit_lin} secondes"
puts "Fonction binaire : #{petit_bin} secondes"
puts "Fonction récursive : #{petit_rec} secondes"
puts ""

puts "Temps d'éxecution de chaque fonction pour le nombre 10 dans une liste de taille #{taille} :"
puts "Fonction linéraire : #{moyen_lin} secondes"
puts "Fonction binaire : #{moyen_bin} secondes"
puts "Fonction récursive : #{moyen_rec} secondes"
puts ""

puts "Temps d'éxecution de chaque fonction pour le nombre 10 dans une liste de taille #{taille} :"
puts "Fonction linéraire : #{grand_lin} secondes"
puts "Fonction binaire : #{grand_bin} secondes"
puts "Fonction récursive : #{grand_rec} secondes"
puts ""

bin_sum = 0
lin_sum = 0
rec_sum = 0
for i in 0..nb_tests - 1 do
  e = rand(0..max_liste)
  bin = Benchmark.realtime do
    calcul_temps(e, l, 'bin')
  end
  lin = Benchmark.realtime do
    calcul_temps(e, l, 'lin')
  end
  rec = Benchmark.realtime do
    calcul_temps(e, l, 'rec')
  end
  bin_sum += bin
  lin_sum += lin
  rec_sum += rec  
end

puts "Temps d'exécution binaire moyen : #{bin_sum/nb_tests} secondes pour #{nb_tests} tests"
puts "Temps d'exécution linéaire moyen : #{lin_sum/nb_tests} secondes pour #{nb_tests} tests"
puts "Temps d'exécution binaire rec moyen : #{rec_sum/nb_tests} secondes pour #{nb_tests} tests"


