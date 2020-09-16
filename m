Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6F26BB27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 05:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIPDyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 23:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIPDyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:54:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F2C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 20:54:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u25so5393224otq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 20:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewL7YiyUTu91D6uwYAgYAQEEe0RdVJXS9Py9EiB4OJY=;
        b=khkMPzqBl2YoARJNUZ1/oqNsz5wOstgp6fnfN7pZHuaEofGslZ0sZGCos39bhH5/YL
         Qy1zMpLNquwbqdmaxj7DL3oYRpJ2WjWG4Nn5qDNMDomJM+bOcwC2ysScgUaPPtmgUkxH
         3diZARKyf+CT0jJjtBWCXYXCFKOh+7GTAw2uObWgdtHfBW7iWynCZuaEUaNvkHv2+z/8
         6EkMTVBO0ZCI1jI1PxdASY0JxevqkvY+XH8baxFsr99K1Wt48tjuycWJVq49xFInWUQW
         Nrc7qBbTGWrq8RevKoNLjNcjGl+13nAea9YNfpUNxfQ/JHP5lC6QTxRc6CMapBNaj5hq
         RbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewL7YiyUTu91D6uwYAgYAQEEe0RdVJXS9Py9EiB4OJY=;
        b=YYd0tNQkuciKjSKdn/icZRrUWfSTVxyZoeviJqBcAXAYygXzXWZeS8Q5K6iUPG6dn3
         mYX+fcFqV8k4lcxu4W2DJhaoL2kEiqmjQ2B0nA9qwSSZ0HVowQSD/xOlMyWpxYrfdpvL
         DKbk8RI6X5z171k4lEfu6i04xG19xSB5KeCxv4m7kHwPfAlra8KD2yO3oX4MPDfSzs/G
         nm4UWjHALmmzpuRw8vccibXCKPkSX7Vhji4r3Yt+5kdojbvXJsWzO1ZpqCpYg7NUidy9
         KfxbafssqzuRLeoqXJF+SzkVLJ+4Ido8LFDOqSYa2w51DL+zrMbJb2kHat8TC1trJkdn
         +h1g==
X-Gm-Message-State: AOAM532ZLtO9lYY1IdafseaebGdolxH0SDrzqY7cO9DDSaSzatOlbsin
        +Lyg1Bz3Gt+zZ3fW7GYm6cTRl6Gao1PCpakdAea7TA==
X-Google-Smtp-Source: ABdhPJxZd0RR0PZLGpqVoV4CPOA7BB6SF3WnFq1dvEd8jWtopskPWWySU9JLig0FPuPZYaGh3cZgxFsx/Iqs3zVQKi0=
X-Received: by 2002:a05:6830:10c4:: with SMTP id z4mr14475449oto.263.1600228446425;
 Tue, 15 Sep 2020 20:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200915130245.89585-1-zhuyinyin@bytedance.com>
 <e206f1b4-1f22-c3f5-21a6-cec498d9c830@kernel.dk> <0d66eabc-3b8b-2f84-05b7-981c2b6fe5dd@kernel.dk>
In-Reply-To: <0d66eabc-3b8b-2f84-05b7-981c2b6fe5dd@kernel.dk>
From:   =?UTF-8?B?5pyx5a+F5a+F?= <zhuyinyin@bytedance.com>
Date:   Wed, 16 Sep 2020 11:53:55 +0800
Message-ID: <CAMwFJjVrY+eygYbgQWeCyeavx_nyzc2nmJw8qah-Go2KNHHELw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] io_uring: fix the bug of child process
 can't do io task
To:     Jens Axboe <axboe@kernel.dk>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>,
        duanxiongchun <duanxiongchun@bytedance.com>,
        =?UTF-8?B?5pyx5a+F5a+F?= <zhuyinyin@bytedance.com>
Content-Type: multipart/mixed; boundary="0000000000001c10f105af66384a"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000001c10f105af66384a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jens Axboe:

  Thanks for your reply.  Yeah=EF=BC=8CMy approach indeed has a problem as =
you
said. Yours is obviously better than mine.
But I think your approach is not perfect , still has a problem. Think
that same case I mentioned before, when parent
process Setup an io_uring instance with the flag of
IORING_SETUP_SQPOLL, means the sqo_thread is created,
and ctx->sqo_mm is assigned to the parent process's mm. Then the
parent process forks a child process. Of course ,
the child process inherits the fd of io_uring instance.

  Then the child process submits  an io task without ever context
switching into kernel. So the sqo_thead even doesn't
know whether the parent process has submit the io task or the child
one,  it just use the ctx->sqo_mm as its mm,
but ctx->sqo_mm is the parent process's, not child process's,  so the
problem occurred again.

Two more things=EF=BC=9A
  1=E3=80=81I think 5.9 also has this problem  -- "sqo_thread doesn't know =
who
has submit the io task, it will use wrong mm"

  2=E3=80=81Attachment of this mail is the test application. If the child
process exits quickly, the problem is occured.


On Tue, Sep 15, 2020 at 9:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/15/20 7:25 AM, Jens Axboe wrote:
> > On 9/15/20 7:02 AM, Yinyin Zhu wrote:
> >> when parent process setup a io_uring_instance, the ctx->sqo_mm was
> >> assigned of parent process'mm. Then it fork a child
> >> process. So the child process inherits the io_uring_instance fd from
> >> parent process. Then the child process submit a io task to the io_urin=
g
> >> instance. The kworker will do the io task actually, and use
> >> the ctx->sqo_mm as its mm, but this ctx->sqo_mm is parent process's mm=
,
> >> not the child process's mm. so child do the io task unsuccessfully. To
> >> fix this bug, when a process submit a io task to the kworker, assign t=
he
> >> ctx->sqo_mm with this process's mm.
> >
> > Hmm, what's the test case for this? There's a 5.9 regression where we
> > don't always grab the right context for certain linked cases, below
> > is the fix. Does that fix your case?
>
> Ah hang on, you're on the 5.4 code base... I think this is a better
> approach. Any chance you can test it?
>
> The problem with yours is that you can have multiple pending async
> ones, and you can't just re-assign ctx->sqo_mm. That one should only
> be used by the SQPOLL thread.
>
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 2a539b794f3b..e8a4b4ae7006 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -514,7 +514,7 @@ static inline void io_queue_async_work(struct io_ring=
_ctx *ctx,
>                 }
>         }
>
> -       req->task =3D current;
> +       req->task =3D get_task_struct(current);
>
>         spin_lock_irqsave(&ctx->task_lock, flags);
>         list_add(&req->task_list, &ctx->task_list);
> @@ -1832,6 +1832,7 @@ static void io_poll_complete_work(struct work_struc=
t *work)
>         spin_unlock_irq(&ctx->completion_lock);
>
>         io_cqring_ev_posted(ctx);
> +       put_task_struct(req->task);
>         io_put_req(req);
>  out:
>         revert_creds(old_cred);
> @@ -2234,11 +2235,11 @@ static void io_sq_wq_submit_work(struct work_stru=
ct *work)
>
>                 ret =3D 0;
>                 if (io_req_needs_user(req) && !cur_mm) {
> -                       if (!mmget_not_zero(ctx->sqo_mm)) {
> +                       if (!mmget_not_zero(req->task->mm)) {
>                                 ret =3D -EFAULT;
>                                 goto end_req;
>                         } else {
> -                               cur_mm =3D ctx->sqo_mm;
> +                               cur_mm =3D req->task->mm;
>                                 use_mm(cur_mm);
>                                 old_fs =3D get_fs();
>                                 set_fs(USER_DS);
> @@ -2275,6 +2276,7 @@ static void io_sq_wq_submit_work(struct work_struct=
 *work)
>                 }
>
>                 /* drop submission reference */
> +               put_task_struct(req->task);
>                 io_put_req(req);
>
>                 if (ret) {
>
> --
> Jens Axboe
>

--0000000000001c10f105af66384a
Content-Type: text/plain; charset="US-ASCII"; name="test_fork.txt"
Content-Disposition: attachment; filename="test_fork.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kf4ulgtv0>
X-Attachment-Id: f_kf4ulgtv0

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVCAqLwovKgogKiBTaW1wbGUgdGVzdCBjYXNl
IHNob3dpbmcgdXNpbmcgc2VuZG1zZyBhbmQgcmVjdm1zZyB0aHJvdWdoIGlvX3VyaW5nCiAqLwoj
aW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxhcnBhL2lu
ZXQuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5j
bHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSAibGlidXJpbmcuaCIKc3RhdGljIGNvbnN0IGNoYXIg
KnN0ciA9ICJUaGlzIGlzIGEgdGVzdCBvZiBzZW5kbXNnIGFuZCByZWN2bXNnIG92ZXIgaW9fdXJp
bmchIjsKI2RlZmluZSBNQVhfTVNHIDEyOAojZGVmaW5lIFBPUlQgICAgMTAyMDAKI2RlZmluZSBI
T1NUICAgICIxMjcuMC4wLjEiCgoKc3RhdGljIGludCByZWN2X3ByZXAoc3RydWN0IGlvX3VyaW5n
ICpyaW5nLCBzdHJ1Y3QgaW92ZWMgKmlvdikKewogICAgc3RydWN0IHNvY2thZGRyX2luIHNhZGRy
OwogICAgc3RydWN0IG1zZ2hkciBtc2c7CiAgICBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWUgPSBO
VUxMOwogICAgaW50IHNvY2tmZCwgcmV0OwogICAgaW50IHZhbCA9IDE7CiAgICBtZW1zZXQoJnNh
ZGRyLCAwLCBzaXplb2Yoc2FkZHIpKTsKICAgIHNhZGRyLnNpbl9mYW1pbHkgPSBBRl9JTkVUOwog
ICAgc2FkZHIuc2luX2FkZHIuc19hZGRyID0gaHRvbmwoSU5BRERSX0FOWSk7CiAgICBzYWRkci5z
aW5fcG9ydCA9IGh0b25zKFBPUlQpOwogICAgc29ja2ZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tf
REdSQU0sIDApOwogICAgaWYgKHNvY2tmZCA8IDApIHsKICAgICAgICBwZXJyb3IoInNvY2tldCIp
OwogICAgICAgIHJldHVybiAxOwogICAgfQogICAgdmFsID0gMTsKICAgIHNldHNvY2tvcHQoc29j
a2ZkLCBTT0xfU09DS0VULCBTT19SRVVTRVBPUlQsICZ2YWwsIHNpemVvZih2YWwpKTsKICAgIHNl
dHNvY2tvcHQoc29ja2ZkLCBTT0xfU09DS0VULCBTT19SRVVTRUFERFIsICZ2YWwsIHNpemVvZih2
YWwpKTsKICAgIHJldCA9IGJpbmQoc29ja2ZkLCAoc3RydWN0IHNvY2thZGRyICopJnNhZGRyLCBz
aXplb2Yoc2FkZHIpKTsKICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgcGVycm9yKCJiaW5kIik7
CiAgICAgICAgZ290byBlcnI7CiAgICB9CiAgICBtZW1zZXQoJm1zZywgMCwgc2l6ZW9mKG1zZykp
OwogICAgICAgIG1zZy5tc2dfbmFtZWxlbiA9IHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJfaW4pOwog
ICAgbXNnLm1zZ19pb3YgPSBpb3Y7CiAgICBtc2cubXNnX2lvdmxlbiA9IDE7CiAgICBzcWUgPSBp
b191cmluZ19nZXRfc3FlKHJpbmcpOwogICAgaWYgKCFzcWUpCgkgICAgcHJpbnRmKCJzcWUgaXMg
bnVsbCBcclxuIik7CiAgICBpb191cmluZ19wcmVwX3JlY3Ztc2coc3FlLCBzb2NrZmQsICZtc2cs
IDApOwoKICAgIHJldCA9IGlvX3VyaW5nX3N1Ym1pdF9hbmRfd2FpdChyaW5nLCAxKTsKICAgIGlm
IChyZXQgPD0gMCkgewogICAgICAgIHByaW50Zigic3VibWl0IGZhaWxlZDogJWRcbiIsIHJldCk7
CiAgICAgICAgZ290byBlcnI7CiAgICB9CiAgICBwcmludGYoInJldCBpcyAlZFxyXG4iLCByZXQp
OwogICAgY2xvc2Uoc29ja2ZkKTsKICAgIHJldHVybiAwOwplcnI6CiAgICBjbG9zZShzb2NrZmQp
OwogICAgcmV0dXJuIDE7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKICAg
IHBpZF90IHA7CiAgICBjaGFyIGJ1ZltNQVhfTVNHICsgMV07CiAgICBzdHJ1Y3QgaW92ZWMgaW92
ID0gewogICAgICAgIC5pb3ZfYmFzZSA9IGJ1ZiwKICAgICAgICAuaW92X2xlbiA9IHNpemVvZihi
dWYpIC0gMSwKICAgIH07CiAgICBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWU7CiAgICBzdHJ1Y3Qg
aW9fdXJpbmdfY3FlICpjcWU7CiAgICBzdHJ1Y3QgaW9fdXJpbmcgcmluZzsKICAgIGludCByZXQ7
CiAgICByZXQgPSBpb191cmluZ19xdWV1ZV9pbml0KDEsICZyaW5nLCAwKTsKICAgIGlmIChyZXQp
IHsKICAgICAgICBwcmludGYoInF1ZXVlIGluaXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsKICAgICAg
ICByZXR1cm4gMDsKICAgIH0KCiAgICBwID0gZm9yaygpOwogICAgc3dpdGNoIChwKSB7CiAgICBj
YXNlIC0xOgogICAgICAgIHBlcnJvcigiZm9yayIpOwogICAgICAgIGV4aXQoMik7CiAgICBjYXNl
IDA6IHsvL2NoaWxkCiAgICAgICAgcmVjdl9wcmVwKCZyaW5nLCAmaW92KTsKICAgICAgICAvL3Ns
ZWVwKDUwMDAwMCk7CglicmVhazsKICAgICAgICB9CiAgICBkZWZhdWx0OgoJcHJpbnRmKCJwaWQ6
ICVkXG4iLCBwKTsKCS8vcmVjdl9wcmVwKCZyaW5nLCAmaW92KTsKICAgICAgICBzbGVlcCg1MDAw
MCk7CiAgICAgICAgcmV0dXJuIDA7CgogICAgfQp9Cg==
--0000000000001c10f105af66384a--
