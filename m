Return-Path: <linux-fsdevel+bounces-7712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DD829CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26DF1C217F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E74B5C3;
	Wed, 10 Jan 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP/RMFHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489E4B5B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbb4806f67so3414638b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704897718; x=1705502518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qKxvXCUQy1buHUmay9orjkI6vrhb+difzNDKFFJ078=;
        b=nP/RMFHLETobOg4FIv4MMl7lfg/oNGVjPrHB7FMUwJP0aSe8kKLa9LVscFaDj/wwVw
         WHi9SeesocfC5U8nVCMAttnNsVXqKouwui/zJZRCErI4VYGQHW23b78GL/FiqB+q8TIk
         fkrGI+LJyWVl295abnTNjlO6R1aQmio9M+A9xfHbDT8qD6nzu9ZY9Q4ArvS+3nCWOfpr
         Risp5gdZtWP/+2esCdMw7Nk80sK+0flCFcpjgjWKjs6CUJ/Uh2PBjsy0P4R5h/Zam+vF
         Y0yMRbES5j17Mw1e8rDDRcFNHttx10/N03Lyw7g32PM2IN2zSMfgdIlm5FcPQd+dF8+a
         QSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704897718; x=1705502518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qKxvXCUQy1buHUmay9orjkI6vrhb+difzNDKFFJ078=;
        b=L7oa4iAAJ9bnOKFFbuIW7xoH0YlsMHVinWHUM5Eso3GhZb3mwIWtnuPMMWAxNysczV
         XlcpRRGRiNnEHXd/ha5aa8i63Z7wvclfUael9ALuqKyJInjkIVbU99AyXtpr1LBm06pE
         RIPznivuQbPsSbQ2PWwdlQQphdWjeyJDKVsXjma7xy5BmSaJzLPGmzO/Md+Sfs5reOcV
         8n23OMkQYgHUEfbovczxwcqBrfITC8oKZynCH1w9eYi8k2YxNevbJ7xdvg0p/gqvMKF8
         Ze/EnyPbSMQFUyf3pSuK4joEQhFnJi6ObS6Uw3j892ftF1jbZam6QUCHBw0ytqRECY7I
         R+Yg==
X-Gm-Message-State: AOJu0YybU2m4QOhPAILZFkjpj9RDLB3yHc98g4SxKKnQa5m8UQePGYOc
	HvO6VUdCin+e5LTHu/fU0/w7VedprrVkHQX+RRQ=
X-Google-Smtp-Source: AGHT+IHGhv5+jq2Gd38xCBKLVX6EWRYWlZo4EweeWNByO64cWfKIwBWuEDyjovBclDroxkQolc0hsYo7zkWfkN59tec=
X-Received: by 2002:a05:6808:3023:b0:3bd:466a:afdb with SMTP id
 ay35-20020a056808302300b003bd466aafdbmr1161569oib.92.1704897718021; Wed, 10
 Jan 2024 06:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109194818.91465-1-amir73il@gmail.com> <20240110135624.kcimvdq6hrteyfb4@quack3>
In-Reply-To: <20240110135624.kcimvdq6hrteyfb4@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 16:41:46 +0200
Message-ID: <CAOQ4uxhNp57J8_W_x0siaZRCqTueY033iQGsXB2JA9o9jAJCVA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:56=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 09-01-24 21:48:18, Amir Goldstein wrote:
> > Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any ty=
pe")
> > optimized the case where there are no fsnotify watchers on any of the
> > filesystem's objects.
> >
> > It is quite common for a system to have a single local filesystem and
> > it is quite common for the system to have some inotify watches on some
> > config files or directories, so the optimization of no marks at all is
> > often not in effect.
>
> I agree.
>
> > Access event watchers are far less common, so optimizing the case of
> > no marks with access events could improve performance for more systems,
> > especially for the performance sensitive hot io path.
> >
> > Maintain a per-sb counter of objects that have marks with access
> > events in their mask and use that counter to optimize out the call to
> > fsnotify() in fsnotify access hooks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I'm not saying no to this but let's discuss first before hacking in some
> partial solution :). AFAIU what Jens sees is something similar as was
> reported for example here [1]. In these cases we go through
> fsnotify_parent() down to fsnotify() until the check:
>
>         if (!(test_mask & marks_mask))
>                 return 0;
>
> there. And this is all relatively cheap (pure fetches like
> sb->s_fsnotify_marks, mnt->mnt_fsnotify_marks, inode->i_fsnotify_marks,
> sb->s_fsnotify_mask, mnt->mnt_fsnotify_mask, inode->i_fsnotify_mask) exce=
pt
> for parent handling in __fsnotify_parent(). That requires multiple atomic
> operations - take_dentry_name_snapshot() is lock & unlock of d_lock, dget=
()
> is cmpxchg on d_lockref, dput() is another cmpxchg on d_lockref - and thi=
s
> gets really expensive, even more so if multiple threads race for the same
> parent dentry.

Sorry, I forgot to link the Jens regression report [1] which included this
partial perf report:

     3.36%             [kernel.vmlinux]  [k] fsnotify
     2.32%             [kernel.vmlinux]  [k] __fsnotify_paren

Your analysis about __fsnotify_parent() may be correct, but what would be
the explanation to time spent in fsnotify() in this report?

Jens,

Can you provide an expanded via of the perf function called by
fsnotify() and __fsnotify_parent()?

In general, I think that previous optimization work as this commit by Mel:
71d734103edf ("fsnotify: Rearrange fast path to minimise overhead when
there is no watcher")
showed improvements when checks were inlined.

[1] https://lore.kernel.org/linux-fsdevel/53682ece-f0e7-48de-9a1c-879ee34b0=
449@kernel.dk/

>
> So I think what we ideally need is a way to avoid this expensive "stabili=
ze
> parent & its name" game unless we are pretty sure we are going to generat=
e
> the event. There's no way to avoid fetching the parent early if
> dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED (we can still postpone t=
he
> take_dentry_name_snapshot() cost though). However for the case where
> dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED =3D=3D 0 (and this is th=
e case
> here AFAICT) we need the parent only after the check of 'test_mask &
> marks_mask'. So in that case we could completely avoid the extra cost of
> parent dentry handling.
>
> So in principle I believe we could make fsnotify noticeably lighter for t=
he
> case where no event is generated. Just the question is how to refactor th=
e
> current set of functions to achieve this without creating an unmaintainab=
le
> mess. I suspect if we lifted creation & some prefilling of iter_info into
> __fsnotify_parent() and then fill in the parent in case we need it for
> reporting only in fsnotify(), the code could be reasonably readable. We'd
> need to always propagate the dentry down to fsnotify() though, currently =
we
> often propagate only the inode because the dentry may be (still in case o=
f
> create or already in case of unlink) negative. Similarly we'd somehow nee=
d
> to communicate down into fsnotify() whether the passed name needs
> snapshotting or not...
>
> What do you think?

I am not saying no ;)
but it sound a bit complicated so if the goal is to reduce the overhead
of fsnotify_access() and fsnotify_perm(), which I don't think any applicati=
on
cares about, then I'd rather go with a much simpler solution even if it
does not cover all the corner cases.

Thanks,
Amir.

