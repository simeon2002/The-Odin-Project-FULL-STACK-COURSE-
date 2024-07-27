array = [6, 5, 3, 1, 8, 7, 2, 4]
# array = [8, 7,6, 5, 4, 3, 2, 1]
# array = [1, 3, 2]
def bubble_sort(arr)
  swap_occurred = false
  for i in (0..(arr.length - 1))
    p "Round #{i + 1}"
    p arr
    for j in (0..(arr.length - 2 - i))
      if arr[j+1] < arr[j]
        temp = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = temp
        p temp.to_s + " and " + arr[j].to_s + " have been swapped :: " + (i+1).to_s
        swap_occurred = true
      end

    end
    if (swap_occurred == false)
      p arr
      p "end!"
      return
    end
    swap_occurred = false
  end
end

bubble_sort array
