Return-Path: <linux-fsdevel+bounces-76119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM9DLn5hgWn6FwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 03:46:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C7D3D89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 03:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D9A0301CD89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 02:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117E31D371;
	Tue,  3 Feb 2026 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCfko7Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B531D37B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086775; cv=none; b=PCdrWvfLjPqZ0PB0KSc+MS3LgyzHGuBITtniHhDlcoffBJRYfxNWEid9nTm7hh962eVp9bV4Q9EiLt57ojFr5ZRHtzG/Kcae2hUKnYxX0nPOSn/6yyQFDkOjVmMtAF0VMsg2pt2CVQAUQhhFK5XNi7q1r8T8qrxIv1/lSbaOzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086775; c=relaxed/simple;
	bh=pLKpdfWf56+Egv35imZ52qKZH6S+FbPr7yRwUF/1gAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iug7QmD+yLr98JNSbzVeK8jvwMqP90LL5PYVKozCnbe2p1sDgXSoFoa7WuiNkFh5nuLsQCEJAGPzYfIa7RAsJc9rQbbCtKte7NoUGjW+HAJGOqZnNwmXzcORKVfcX9oQ+rvrvL4RcDbzbej7h9LuUrdUzZI1hgELkiuiWgTzGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCfko7Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66070C2BCAF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 02:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770086775;
	bh=pLKpdfWf56+Egv35imZ52qKZH6S+FbPr7yRwUF/1gAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCfko7Lqn2mRhVfU2y0BVQG3QrFCQxDZ1hoDSVJf/Wf38nDvUn+I6FiHC3kioYOfA
	 SIg8QFbysyVfIqMiuS09xJbEchNWBv+vcKeUYGGE5sdBd6kLsC6QKi1bNwiv+FA35u
	 3VaZjgGCkYnL/XmcBMNRRy4Xg7iqiCB4DF2BdZ/FfOLXcJzO2enGQoNxhDVTeE3Vig
	 3FmxLzQRexYEfbSorRWvy9xpmpqesK7IfTs9/A9ca35WdVWlLvcFkDpd5vYTtj5yXw
	 E/79lPYpNii8DFzF2gTz/PLJ25i1lyjpzX58H7tCXfyQMxKiY1EA65rR6iVlXVMetL
	 6sYbRwXEoyyVg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso8988126a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 18:46:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfTEJYKZWIv/g9JzZSlMBoghS0C/P4OpVV7X32HTGaiWw5eB2RUI7163C+7DrmynSJ/6p6KVMpvQXZCjo0@vger.kernel.org
X-Gm-Message-State: AOJu0YyHN1ETn156w/xo4sRvBKDKz6wkoa2h5y7y8LEXlsAbqGW0O3Oi
	z9Nyi0yNKSCpywBOFOk64Kxfu029Wn4+IfNXwISkMjcCKpZyH00KEQzF+zqjs35V1Pa0VeYLuu2
	TFoNlxRGOKDSyqunqe0u4aVN6nh6Bgu8=
X-Received: by 2002:a17:907:1b1d:b0:b8a:f7fb:4f4d with SMTP id
 a640c23a62f3a-b8dff620c28mr837435166b.16.1770086773934; Mon, 02 Feb 2026
 18:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131090724.4128443-1-chenhuacai@loongson.cn> <pdivemgl5d3mqrb5erbzn2qgohcktxv76lkqqjhc65cgomnysf@tgopkp5jaonj>
In-Reply-To: <pdivemgl5d3mqrb5erbzn2qgohcktxv76lkqqjhc65cgomnysf@tgopkp5jaonj>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Feb 2026 10:46:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4PnPVumThckN8xtteXQGdBB-eAY_jW82m8i9qY=TeDUg@mail.gmail.com>
X-Gm-Features: AZwV_Qjgzgjzp3hD5_7-Wk-gd7McAKKG5KU8DU0MbOSWoJhUl8j0XtTBWPd28Aw
Message-ID: <CAAhV-H4PnPVumThckN8xtteXQGdBB-eAY_jW82m8i9qY=TeDUg@mail.gmail.com>
Subject: Re: [PATCH] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
To: Jan Kara <jack@suse.cz>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Xuefeng Li <lixuefeng@loongson.cn>, Julian Sun <sunjunchao@bytedance.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76119-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.cz:email]
X-Rspamd-Queue-Id: 311C7D3D89
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 8:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-01-26 17:07:24, Huacai Chen wrote:
> > Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> > is not enabled:
> >
> > INFO: The task sync:1342 has been waiting for writeback completion for =
more than 1 seconds.
> >
> > The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> > is not enabled, then it causes the warning message even if the writebac=
k
> > lasts for only one second.
> >
> > I believe the wakeup and logging is also useful for !DETECT_HUNG_TASK,
> > so I don't want to disable them completely. As DEFAULT_HUNG_TASK_TIMEOU=
T
> > is 120 seconds, so for the !DETECT_HUNG_TASK case let's use 120 seconds
> > instead of sysctl_hung_task_timeout_secs.
> >
> > Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing t=
he writeback of a chunk.")
> > Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceed=
s sysctl_hung_task_timeout_secs)")
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Thanks for the patch! I think if !CONFIG_DETECT_HUNG_TASK, we should just
> not print the message from wb_wait_for_completion_cb() as well. After all
> it's also a type of hung task detection and user explicitely disabled tha=
t.
> Also there would be no way to tune the timeout so there are high chances
> 120s will be too much for somebody and too few for somebody else...
OK, make sense.

Huacai

>
> > +#ifndef CONFIG_DETECT_HUNG_TASK
> > +     unsigned long hung_secs =3D 120;
> > +#else
> > +     unsigned long hung_secs =3D sysctl_hung_task_timeout_secs;
> > +#endif
> >
> >       if (work->for_kupdate)
> >               dirtied_before =3D jiffies -
> > @@ -2031,8 +2041,7 @@ static long writeback_sb_inodes(struct super_bloc=
k *sb,
> >
> >               /* Report progress to inform the hung task detector of th=
e progress. */
> >               if (work->done && work->done->progress_stamp &&
> > -                (jiffies - work->done->progress_stamp) > HZ *
> > -                sysctl_hung_task_timeout_secs / 2)
> > +                (jiffies - work->done->progress_stamp) > HZ * hung_sec=
s / 2)
> >                       wake_up_all(work->done->waitq);
> >
> >               wbc_detach_inode(&wbc);
>
> Similarly here I'd just #ifdef out the wakeup when !CONFIG_DETECT_HUNG_TA=
SK.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

