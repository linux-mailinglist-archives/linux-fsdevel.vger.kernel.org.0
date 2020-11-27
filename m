Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AA2C660D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgK0MxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 07:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgK0MxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:53:04 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55DC0613D1;
        Fri, 27 Nov 2020 04:53:04 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id t8so4686323iov.8;
        Fri, 27 Nov 2020 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pN1PyUJpffxldlksYc4OhYw5FcKBSSXURbDzucU5uk=;
        b=svAdVyd5ghUWu3rmsV3Dbf/5zRFcGx9Oj6RK3UPz2tstDMGvBPcJ4K6U0VfonvEXJx
         og+zp2TBHr+cTUaGjUp6ym7GYsBQmT0ia8mApyh3RtE4pbfIkZqo6ULJ5l1kP4KZrIWS
         PjCdXpyheToq0tnzTfwg5NoFAUXZDyLnql21M+evpvCZrSWR9YhJf1OOhOAth8MtORhk
         KdyvOU845m3KdsiH9xGWIi0QpxKQygRUjosQ6Gtnl5SpZUT9yH3JkqaXCCNGN5I77xnm
         4QVoy5DcFwIA5/yUGFKrk1kZsYOl7kIRha0UOuGfvVNSotXrkQurLJdYRTXhI4hzeEem
         BpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pN1PyUJpffxldlksYc4OhYw5FcKBSSXURbDzucU5uk=;
        b=gNZ+w+/ksfQYmUpW81PQ+x1jF1d6To38k3f2QlwRo+BCUAP7+IsmlvsKIfOZVB9thm
         KixNLtdm4UFpoW2OfZzd5tkrSDTJmzVCxHfsGfByttHPkoUtHrJIP17CPHYcH2pUKfpe
         yiTkjpAZ4TT73b7S5N24jS54PN2AHg8ja6Kw8AXOeUYlQayKUdKhpokSa93h2deofNMg
         +aIUJd+HDS7rf5G/7QrCD1aLouCQjbvefikkyN5ecBmfO09A9EzWnt5mOVo7NhoZYDPT
         iDelOfIFobk6UvvvcYp05EyZmXVhzsYSDCOGlmQ01cQE6FPJQit8kLoAgQjk6yPaqUac
         VC0w==
X-Gm-Message-State: AOAM5309+9SONE7VmeM793qBG5tGqfXHDWkkuQK97BX2Tuk20swgajxb
        HhuhR9w9e8GoF/p2a+xeY79DIaDNzA0cPPER8ZKNeF/j
X-Google-Smtp-Source: ABdhPJzbpnadQMzJ6hpcInkVq6AeU2hAOLxqtVIYwPY7R/mXI4GgZp+HWcx1wL93Un2kltfYhX9YWNGilJGHgv1VILo=
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr7324899jaq.93.1606481583344;
 Fri, 27 Nov 2020 04:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-3-sargun@sargun.me>
In-Reply-To: <20201127092058.15117-3-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Nov 2020 14:52:52 +0200
Message-ID: <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding shortcoming
 of volatile
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:21 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This documents behaviour that was discussed in a thread about the volatile
> feature. Specifically, how failures can go hidden from asynchronous writes
> (such as from mmap, or writes that are not immediately flushed to the
> filesystem). Although we pass through calls like msync, fallocate, and
> write, and will still return errors on those, it doesn't guarantee all
> kinds of errors will happen at those times, and thus may hide errors.
>
> In the future, we can add error checking to all interactions with the
> upperdir, and pass through errseq_t from the upperdir on mappings,
> and other interactions with the filesystem[1].
>
> [1]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#m7d501f375e031056efad626e471a1392dd3aad33
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  Documentation/filesystems/overlayfs.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 580ab9a0fe31..c6e30c1bc2f2 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -570,7 +570,11 @@ Volatile mount
>  This is enabled with the "volatile" mount option.  Volatile mounts are not
>  guaranteed to survive a crash.  It is strongly recommended that volatile
>  mounts are only used if data written to the overlay can be recreated
> -without significant effort.
> +without significant effort.  In addition to this, the sync family of syscalls
> +are not sufficient to determine whether a write failed as sync calls are
> +omitted.  For this reason, it is important that the filesystem used by the
> +upperdir handles failure in a fashion that's suitable for the user.  For
> +example, upon detecting a fault, ext4 can be configured to panic.
>

Reading this now, I think I may have wrongly analysed the issue.
Specifically, when I wrote that the very minimum is to document the
issue, it was under the assumption that a proper fix is hard.
I think I was wrong and that the very minimum is to check for errseq
since mount on the fsync and syncfs calls.

Why? first of all because it is very very simple and goes a long way to
fix the broken contract with applications, not the contract about durability
obviously, but the contract about write+fsync+read expects to find the written
data (during the same mount era).

Second, because the sentence you added above is hard for users to understand
and out of context. If we properly handle the writeback error in fsync/syncfs,
then this sentence becomes irrelevant.
The fact that ext4 can lose data if application did not fsync after
write is true
for volatile as well as non-volatile and it is therefore not relevant
in the context
of overlayfs documentation at all.

Am I wrong saying that it is very very simple to fix?
Would you mind making that fix at the bottom of the patch series, so it can
be easily applied to stable kernels?

Thanks,
Amir.
