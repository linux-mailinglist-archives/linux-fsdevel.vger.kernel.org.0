Return-Path: <linux-fsdevel+bounces-2796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89C7EA126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F0E1F21BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564712231F;
	Mon, 13 Nov 2023 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nf/6rYle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5121A0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 16:19:18 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4010FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 08:19:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so4835288276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699892357; x=1700497157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMLm0/uIqfayvGe2EvWCHsRHOWuKnl2SWg2PgG1Wr7c=;
        b=Nf/6rYlesc+yi1Rl2FuWphAq0FWL41kz+O2AZbjgf25EOPYEAGJkKKa4v4vQhyYplW
         7nkFOH2jA+diwxPJQ3/9LoyxUhq4aUSt6WFtP+43KdOSvDRn7upSiozHbOqAFX2rUfO7
         krfc7CloAetfVYx9u5zLaPVgXZP/FAMgctfEbczDBlBb9kUWsvY1orEHQEz4OeM1J3Nu
         S138itj8izItUc8WS1fRAp/Qj8fP3v/xZt8BrfGqBbfJVRSn7+Q4Dm28N18tW/aICRZ/
         norMcJTqldm9D0kV1j/wWFKCV2x52zRqj0jM7XMi0xEet8ePWI4+MCUFtUmjdPRFvY0k
         /7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699892357; x=1700497157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMLm0/uIqfayvGe2EvWCHsRHOWuKnl2SWg2PgG1Wr7c=;
        b=es5psz7U5VjV5wzBTvMuK11nUjFUtLKArMdkZBgP8LVephE6DASEdRjYh+ECzvz1U3
         fIeXH8iMNsqzG5Ry+eJKAiw3vdZuy1dqqnzArlE7jwpnLK3F1C+g9r4t5gfdLenT/i1b
         Dn8waLDhljorfcUit9rd0OaNpsnzA4L0NRNWuUrqiSSuMloKM7+y3dBlfS7kTbLNDeD6
         A/ZuNJQ+tHWmnFiWc/bDLWNnDfSfd0hP4FDvKn69mgKIvZZO3LPqAzM9JXODeWbBQJen
         G/wRt4e1FheTA5goDYnRXAmHEaweKxW+FZOJZg6+2sSfDVxQH/HJhiTXe8g8tNrKof4P
         TJ8Q==
X-Gm-Message-State: AOJu0YyUrJbKbY8/zIAso86f/Des/X8o51U1g19B6icE0V41Eqji5hbb
	eCmnL8c7OnnGxQjsyp8nFSmoAdJdM2b+/qsZ7cbY
X-Google-Smtp-Source: AGHT+IGhvQblQAV/PN4e6QkZC4As9SYdhGOWFHn46SCNS1eOy2QK1wd+Bpifl046D3H/tj6mzs69d34KtuYn6gjyZPw=
X-Received: by 2002:a25:58d4:0:b0:daf:d9b7:7bad with SMTP id
 m203-20020a2558d4000000b00dafd9b77badmr1007507ybb.24.1699892356848; Mon, 13
 Nov 2023 08:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV>
In-Reply-To: <20231016220835.GH800259@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Nov 2023 11:19:05 -0500
Message-ID: <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [
> That thing sits in viro/vfs.git#work.selinuxfs; I have
> lock_rename()-related followups in another branch, so a pull would be mor=
e
> convenient for me than cherry-pick.  NOTE: testing and comments would
> be very welcome - as it is, the patch is pretty much untested beyond
> "it builds".
> ]

Hi Al,

I will admit to glossing over the comment above when I merged this
into the selinux/dev branch last night.  As it's been a few weeks, I'm
not sure if the comment above still applies, but if it does let me
know and I can yank/revert the patch in favor of a larger pull.  Let
me know what you'd like to do.

> On policy reload selinuxfs replaces two subdirectories (/booleans
> and /class) with new variants.  Unfortunately, that's done with
> serious abuses of directory locking.
>
> 1) lock_rename() should be done to parents, not to objects being
> exchanged
>
> 2) there's a bunch of reasons why it should not be done for directories
> that do not have a common ancestor; most of those do not apply to
> selinuxfs, but even in the best case the proof is subtle and brittle.
>
> 3) failure halfway through the creation of /class will leak
> names and values arrays.
>
> 4) use of d_genocide() is also rather brittle; it's probably not much of
> a bug per se, but e.g. an overmount of /sys/fs/selinuxfs/classes/shm/inde=
x
> with any regular file will end up with leaked mount on policy reload.
> Sure, don't do it, but...
>
> Let's stop messing with disconnected directories; just create
> a temporary (/.swapover) with no permissions for anyone (on the
> level of ->permission() returing -EPERM, no matter who's calling
> it) and build the new /booleans and /class in there; then
> lock_rename on root and that temporary directory and d_exchange()
> old and new both for class and booleans.  Then unlock and use
> simple_recursive_removal() to take the temporary out; it's much
> more robust.
>
> And instead of bothering with separate pathways for freeing
> new (on failure halfway through) and old (on success) names/values,
> do all freeing in one place.  With temporaries swapped with the
> old ones when we are past all possible failures.
>
> The only user-visible difference is that /.swapover shows up
> (but isn't possible to open, look up into, etc.) for the
> duration of policy reload.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c

--=20
paul-moore.com

