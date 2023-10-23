Return-Path: <linux-fsdevel+bounces-927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C67D3865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF501C209A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA161A26B;
	Mon, 23 Oct 2023 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJSw6Mcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667823DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 13:48:27 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4398191
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 06:48:26 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d0f945893so27361526d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698068905; x=1698673705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNoz4gqx6N/ZXGBPCPNo+bBkQqfT+ZPW+a7bpLJE35w=;
        b=UJSw6Mcw62jh/s1zkxr7/9iuQsLrWiAULzc5ytt0fIRDBRrmEAyXz3OBk88wulgreg
         jnki3OrSIR6y/ryG76Nw3W6TBkNHzVGQnmbU5ezXKOQRXO512n6HJcFf5f16q7J28ZkR
         dAidy6BR9jo+6tx18Jf/0i1PqIHj6UUcFyzO0x3b2m4HszqGk6BrK6mv7o8gMwohJHCa
         YQlQsBrYNFHGvdln4LCIzpI/H28qmma6TNXLZIk/pr1jU2vOhByV8GrSbejS51/UT5sa
         1h40RyIRaYo6cL48cROkPWvVyIlKDQaZviMOlC0KTLbWLNgB7yn4CtG5JFTfW6Nnpiic
         ZxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068905; x=1698673705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNoz4gqx6N/ZXGBPCPNo+bBkQqfT+ZPW+a7bpLJE35w=;
        b=Hq4qlIW2MQyE/trbIYBVYsvnvP+A7ctc64RXnAUi4FvlxbayiO2fGpiMf7PTQH+8Jr
         ReQZPe6wxFRN9YfnIwnxKf7arkDhsmmvNrguwgyL5fnefzJP+wC5/9WdCbnJac8kD3BE
         HtOG9XtLnJDXbc4TMsVGRcZoiG3/vjhGXtjFz9QLS4TrqIp2EOIbNn2el8mCweAdMxU9
         eqyUHcq/XaZe0ImM81l+UmbsHmblars+3V7Nyb26RHTdycgdfitnPdThGLxSb+v+bzvk
         N1l+gKZOKhU9A0nodybMelzdYESGJZ31e0ymFhTAFHOf+2bg0gcC7jT9ow+znu3ggyAq
         fSwA==
X-Gm-Message-State: AOJu0YwJ3gUweWZ50Rv7pploo7hzzSGWbpAYRNVNiodQ00gAma4NVuJA
	D3qVfMxjsdQApt2SeE9mQCgD9l/HtdSZZJCD9ADQ+w==
X-Google-Smtp-Source: AGHT+IHP16b/24p2cCIV7n4Q7cd5HJrsKxZKw8dnvL5mJKLZdGd3Cr+uV8BwIRWfdrTaZTzeSNp5YYJi8ZndM84+dkE=
X-Received: by 2002:a05:6214:18ec:b0:66d:593e:7722 with SMTP id
 ep12-20020a05621418ec00b0066d593e7722mr17263102qvb.3.1698068905368; Mon, 23
 Oct 2023 06:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023093359.64265-1-raven@themaw.net>
In-Reply-To: <20231023093359.64265-1-raven@themaw.net>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 23 Oct 2023 15:48:14 +0200
Message-ID: <CADYN=9JUDjj=KS=xTWXbVkkDPsCi2+GjGfWqAL8naOEHpu4nHQ@mail.gmail.com>
Subject: Re: [PATCH] autofs: fix add autofs_parse_fd()
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Christian Brauner <brauner@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"Bill O'Donnell" <bodonnel@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Oct 2023 at 11:34, Ian Kent <raven@themaw.net> wrote:
>
> We are seeing systemd hang on its autofs direct mount at
> /proc/sys/fs/binfmt_misc.
>
> Historically this was due to a mismatch in the communication structure
> size between a 64 bit kernel and a 32 bit user space and was fixed by
> making the pipe communication record oriented.
>
> During autofs v5 development I decided to stay with the existing usage
> instead of changing to a packed structure for autofs <=> user space
> communications which turned out to be a mistake on my part.
>
> Problems arose and they were fixed by allowing for the 64 bit to 32
> bit size difference in the automount(8) code.
>
> Along the way systemd started to use autofs and eventually encountered
> this problem too. systemd refused to compensate for the length
> difference insisting it be fixed in the kernel. Fortunately Linus
> implemented the packetized pipe which resolved the problem in a
> straight forward and simple way.
>
> In the autofs mount api conversion series I inadvertatly dropped the
> packet pipe flag settings when adding the autofs_parse_fd() function.
> This patch fixes that omission.
>
> Fixes: 546694b8f658 ("autofs: add autofs_parse_fd()")
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Bill O'Donnell <bodonnel@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>

Thank you Ian for finding the issue so quickly.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

I built todays next-20231023 with this patch and the kernel booted up
fine in qemu.


Cheers,
Anders

> ---
>  fs/autofs/autofs_i.h | 13 +++++++++----
>  fs/autofs/inode.c    |  2 ++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 244f18cdf23c..8c1d587b3eef 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -221,15 +221,20 @@ static inline int autofs_check_pipe(struct file *pipe)
>         return 0;
>  }
>
> -static inline int autofs_prepare_pipe(struct file *pipe)
> +static inline void autofs_set_packet_pipe_flags(struct file *pipe)
>  {
> -       int ret = autofs_check_pipe(pipe);
> -       if (ret < 0)
> -               return ret;
>         /* We want a packet pipe */
>         pipe->f_flags |= O_DIRECT;
>         /* We don't expect -EAGAIN */
>         pipe->f_flags &= ~O_NONBLOCK;
> +}
> +
> +static inline int autofs_prepare_pipe(struct file *pipe)
> +{
> +       int ret = autofs_check_pipe(pipe);
> +       if (ret < 0)
> +               return ret;
> +       autofs_set_packet_pipe_flags(pipe);
>         return 0;
>  }
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 6d2e01c9057d..a3d62acc293a 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -177,6 +177,8 @@ static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
>                 return -EBADF;
>         }
>
> +       autofs_set_packet_pipe_flags(pipe);
> +
>         if (sbi->pipe)
>                 fput(sbi->pipe);
>
> --
> 2.41.0
>

