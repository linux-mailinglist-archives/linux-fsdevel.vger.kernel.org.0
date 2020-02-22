Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA169188
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 20:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBVTaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 14:30:10 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:38015 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVTaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:30:10 -0500
Received: by mail-il1-f179.google.com with SMTP id f5so4505833ilq.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2020 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=uvdFF82qeiPVyhFdFGVMiz5rCza0i8u+CXUVrRl22aQ=;
        b=qhwCK9Wj9Ox+p4dG6cVu/CE/hQAeqYIc8fxCFTT62sx3yodhgq/tqAZkBBKMMyCxcz
         EenonGaZPDrLLbxMQ3EViaWV/TPLDySTfR0h7BbcPwmbmfNKiYmZt8GAlH2PiXHzHGzO
         KqgzMwa0QeRJDyaC65kUxa6mrwnFjCqsNP8ZxCW/7ANf3yIVx2TgcJ8lzNv6ecGSOFHk
         GwKFgi8rZL+6Af1c7/89vXInoTf1F6nV1DoPvb0uWX19WmUpKRckoCHJw0u6ntJg4xqn
         3S866DUxXjEYKU0qKExp5wGlMnGhwHkEhaSDgQJDXdLaN8YAkByaFV/N06cQTqYHRXse
         SVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=uvdFF82qeiPVyhFdFGVMiz5rCza0i8u+CXUVrRl22aQ=;
        b=fzy8YqhIp0uV8BX1zkJk7on1kwCzj6scCQUVkD203aAOjt5wnhyPFQx5dxCR4bGRQV
         Qn+Ty6tknTKmPAPKp4JphJ9G/AlimP+IvrZ92bu6ofjAoMNpFuDDse9NkVWvkxB2RMtX
         tDQEz9Cu6NwmPxWFm+3j81J8JThLa+qCPGT/phPgrTlz1DSmZTiiKOS/cfTWx8yiZPbv
         NpxoWBdkTH6FvLXL8vhelJuap9DDWIlbGbNNbtGt3t8oatefV24q/Ic1eEGC4mn0oz8q
         u02tXxodjaWL8zd/yDIAa687HczwB1i7GPaI9ry7CylYS3Y2iGLtsyoa4K4u5TznP4SH
         dCwg==
X-Gm-Message-State: APjAAAUIBW1mJmnQb4KJa1233uJv+ha9/yLWaUU4cEJ4HPA7cxG8jffi
        wU+KywGyuWM1QrXi8iTKvbkk0OtekchErAiaJAw=
X-Google-Smtp-Source: APXvYqxLSuOn9c76XDPzpNfa/bMmg+g9jk33Ew3c7I8e7+SsdSW56Hc/MwWEU+69wpKjIixDqN+Pp+iwsMNZNijGyVQ=
X-Received: by 2002:a92:4448:: with SMTP id a8mr46742359ilm.256.1582399808901;
 Sat, 22 Feb 2020 11:30:08 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Sat, 22 Feb 2020 11:29:59 -0800
Message-ID: <CACsaVZJ7V8hefM+dxY7Rgf8RR7jqcnJgZt+zgT+KM+UQwT7U2g@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     miklos@szeredi.hu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, michael+lkml@stapelberg.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg: can we take take this to stable for 5.4.22?

> Attached patch should fix it, though I haven't tested it.

Confirmed - sounds good over my system for the past 8 days of heavy
usage with 5.4.19.

Thank you very much for the fix Miklos and to you Michael for working
with him (my mail setup is incomplete - hopefully this doesn't fork
the thread...).

Tested-by: Kyle Sanderson <kyle.leet@gmail.com>

Can you land this for linux-next Miklos please.

Kyle.

On Wed, Feb 12, 2020 at 10:38 AM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:
>
> Unfortunately not: when I change the code like so:
>
>     bool async;
>     uint32_t opcode_early =3D req->args->opcode;
>
>     if (test_and_set_bit(FR_FINISHED, &req->flags))
>         goto put_request;
>
>     async =3D req->args->end;
>
> =E2=80=A6gdb only reports:
>
> (gdb) bt
> #0  0x000000a700000001 in ?? ()
> #1  0xffffffff8137fc99 in fuse_copy_finish (cs=3D0x20000ffffffff) at
> fs/fuse/dev.c:681
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>
> But maybe that=E2=80=99s a hint in and of itself?

Yep, it's a stack use after return bug.   Attached patch should fix
it, though I haven't tested it.

Thanks,
Miklos
---
 fs/fuse/dev.c    |    6 +++---
 fs/fuse/fuse_i.h |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -276,12 +276,10 @@ static void flush_bg_queue(struct fuse_c
 void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
  struct fuse_iqueue *fiq =3D &fc->iq;
- bool async;

  if (test_and_set_bit(FR_FINISHED, &req->flags))
  goto put_request;

- async =3D req->args->end;
  /*
  * test_and_set_bit() implies smp_mb() between bit
  * changing and below intr_entry check. Pairs with
@@ -324,7 +322,7 @@ void fuse_request_end(struct fuse_conn *
  wake_up(&req->waitq);
  }

- if (async)
+ if (test_bit(FR_ASYNC, &req->flags))
  req->args->end(fc, req->args, req->out.h.error);
 put_request:
  fuse_put_request(fc, req);
@@ -471,6 +469,8 @@ static void fuse_args_to_req(struct fuse
  req->in.h.opcode =3D args->opcode;
  req->in.h.nodeid =3D args->nodeid;
  req->args =3D args;
+ if (args->end)
+ set_bit(FR_ASYNC, &req->flags);
 }

 ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args)
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -301,6 +301,7 @@ struct fuse_io_priv {
  * FR_SENT: request is in userspace, waiting for an answer
  * FR_FINISHED: request is finished
  * FR_PRIVATE: request is on private list
+ * FR_ASYNC: request is asynchronous
  */
 enum fuse_req_flag {
  FR_ISREPLY,
@@ -314,6 +315,7 @@ enum fuse_req_flag {
  FR_SENT,
  FR_FINISHED,
  FR_PRIVATE,
+ FR_ASYNC,
 };

 /**
