defmodule Portal.Door do
  defstruct [:left, :right]

  @doc """
  Starts transfering `data` from `left` to `right`.
  """
  def transfer(left, right, data) do
    for item <- data do
      Portal.Door.push(left, item)
    end
  end

  def push_right(portal) do
    
  end
  
  

  @doc """
  Starts a door with the given `color`.

  The color is given as a name so we can identify 
  the door by color name instead of by using a PID.
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color) 
  end
  
  @doc """
  Get the data currently in the `door`.
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Push `value` into the `door`. 
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`.
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> {:error, []}
      [h|t] -> {{:ok, h}, t} 
    end)
  end
  
end