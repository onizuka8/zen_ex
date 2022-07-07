defmodule ZenEx.Model.JobStatusSpec do
  use ESpec

  import Tesla.Mock
  alias ZenEx.Entity.JobStatus
  alias ZenEx.Model

  let :json_job_statuses do
    ~s({"count":2,"job_statuses":[{"id":"8b726e606741012ffc2d782bcb7848fe","status":"completed"},{"id":"e7665094164c498781ebe4c8db6d2af5","status":"completed"}]})
  end

  let :job_statuses do
    [
      struct(JobStatus, %{id: "8b726e606741012ffc2d782bcb7848fe", status: "completed"}),
      struct(JobStatus, %{id: "e7665094164c498781ebe4c8db6d2af5", status: "completed"})
    ]
  end

  let :json_job_status do
    ~s({"job_status":{"id":"8b726e606741012ffc2d782bcb7848fe","url":"https://company.zendesk.com/api/v2/job_statuses/8b726e606741012ffc2d782bcb7848fe.json","total":2,"progress":2,"status":"completed","message":"CompletedatFriApr1302:51:53+00002012","results":[{"title":"Iaccidentallythewholebottle","action":"update","errors":"","id":380,"success":true,"status":"Updated"}]}})
  end

  let :job_status do
    struct(JobStatus, %{
      id: "8b726e606741012ffc2d782bcb7848fe",
      url:
        "https://company.zendesk.com/api/v2/job_statuses/8b726e606741012ffc2d782bcb7848fe.json",
      total: 2,
      progress: 2,
      status: "completed",
      message: "CompletedatFriApr1302:51:53+00002012",
      results: [
        %{
          title: "Iaccidentallythewholebottle",
          action: "update",
          errors: "",
          id: 380,
          success: true,
          status: "Updated"
        }
      ]
    })
  end

  describe "list" do
    before(
      do:
        mock(fn %{method: :get, url: _} ->
          %Tesla.Env{status: 200, body: json_job_statuses()}
        end)
    )

    it(do: expect(Model.JobStatus.list() |> to(be_struct(ZenEx.Collection))))
    it(do: expect(Model.JobStatus.list().entities |> to(eq(job_statuses()))))
  end

  describe "show" do
    before(
      do:
        mock(fn %{method: :get, url: _} ->
          %Tesla.Env{status: 200, body: json_job_status()}
        end)
    )

    it(do: expect(Model.JobStatus.show(job_status().id) |> to(eq(job_status()))))
  end

  describe "show_many" do
    before(
      do:
        mock(fn %{method: :get, url: _} ->
          %Tesla.Env{status: 200, body: json_job_statuses()}
        end)
    )

    it(
      do:
        expect(
          Model.JobStatus.show_many(Enum.map(job_statuses(), & &1.id))
          |> to(be_struct(ZenEx.Collection))
        )
    )

    it(
      do:
        expect(
          Model.JobStatus.show_many(Enum.map(job_statuses(), & &1.id)).entities
          |> to(eq(job_statuses()))
        )
    )
  end
end
