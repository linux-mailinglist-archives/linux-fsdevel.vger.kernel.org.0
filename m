Return-Path: <linux-fsdevel+bounces-76172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PHyCxC9gWm7JAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:17:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C063BD6AE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4484F3016EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C80396D00;
	Tue,  3 Feb 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAd5YtgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEF3939D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110217; cv=none; b=gbKj0bFGmLpjGUyhNuRC0iPOT+b0qXTPDlEpOvGoeGXn88PVp29HuZUh2T9BYf+Z0quegP8cQS4N85dvidcUdEoaVjrYkb9oWUTzk/AwGwiu5SUECAyyYuEwM44ju6v1RVmlL0EdhQQdxHlftfByb9UMkZg2tLDrwCm+bUrjNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110217; c=relaxed/simple;
	bh=Rq+CWrVm8ReYcCMyvNRUVl+rZn9GMsxprnVxUSKo7/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRMx7/hDGiCYUXoqoNt9n983IKz6OVgX8bl2jNXTM+00K2FfwYF5n7U16XsYh1m53U/qN1Tj/vihArnLGtoSk5OUh0SOA0gkObsfuhEaSC6YTA0gkNfOuOQpiY1lBHSTXjtx1vK7gNqB08Zx1aQ7R5FQbYVniTGx6WJHJhyv37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAd5YtgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B130C116D0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770110217;
	bh=Rq+CWrVm8ReYcCMyvNRUVl+rZn9GMsxprnVxUSKo7/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pAd5YtgZpZ5iFK6HBhiWZSV7gmjusW7e8sw9/lGEhIYPa40cZRB8fPZ6WWpKZjnnh
	 ac1ChM5rP6SCsJnEiAZX94f4NxMsk9Rji4bcR74A5whW90kMTSGgLcqNf+8YxIiiCZ
	 t2Xs4RasXBa28M32BV4QeAaK+oQ9h9HtHRydqDgoUvK5iu6MrXR3p0enbizh5vZGJ8
	 3gHhtc7KTm8fbJjcD1XQ5rtSY+3+N/XzM2ylwApWX+cyRUbF+RRlIPuGzooMToBajq
	 +2bGTha3XfD/ANyV7oJ1AW0nm+Lxv0ln00QN4dDcvpfbEIwxEJ8IA4J/BOaNCE8ijR
	 E06aD1JbrHjgA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso840826466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 01:16:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlYyjTVDPrpx86t/HOGmgV9inU4RvHBe1C/wtQ26MqRCd/FXIRs9OydTvXiJ8ZHoZ/fxaSDx6XpxTKvLhs@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiaDcrCWQ4XViurMn+ki5oK5pWMlmwCVj5kFlG+SOOyjYoQjM
	okTOPnQwXMueMFKqBvnL0rrPEoSqmvv2CkAcqPZndtyEQ0RofrFFYyRwKFuKFgueL2Hsfkjxnjv
	0j/JfsxRVI7clxcprz+8yQcUC6a9yxmU=
X-Received: by 2002:a17:907:7fa9:b0:b8e:7e21:132c with SMTP id
 a640c23a62f3a-b8e7e214381mr213208966b.59.1770110215886; Tue, 03 Feb 2026
 01:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203063023.2159073-1-chenhuacai@loongson.cn> <zyla6hpdipy42mohwluccjda6msrykavxofcfeuf3rigoq24t5@72kmw2rza4fs>
In-Reply-To: <zyla6hpdipy42mohwluccjda6msrykavxofcfeuf3rigoq24t5@72kmw2rza4fs>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Feb 2026 17:16:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5pj9zZ4EmJHqf3G8mQBnLNbt6AG+rt0c=bZJsaTx782g@mail.gmail.com>
X-Gm-Features: AZwV_QhZ5s-BmoXNHfMR3NFlKJjatpvMHHxHbIb_yUDyDA9P5kQv8foSwDe6MrI
Message-ID: <CAAhV-H5pj9zZ4EmJHqf3G8mQBnLNbt6AG+rt0c=bZJsaTx782g@mail.gmail.com>
Subject: Re: [PATCH V2] writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76172-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid,loongson.cn:email]
X-Rspamd-Queue-Id: C063BD6AE7
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 5:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 03-02-26 14:30:23, Huacai Chen wrote:
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
> > So guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK",
> > so as to eliminate the warning messages.
> >
> > Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing t=
he writeback of a chunk.")
> > Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceed=
s sysctl_hung_task_timeout_secs)")
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Thanks! Looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
Thanks, but don't apply because I found that
sysctl_hung_task_timeout_secs can also be 0 for DETECT_HUNG_TASK.
Please wait for V3.

Huacai

>
>                                                                 Honza
>
> > ---
> > V2: Disable wakeup and logging for !DETECT_HUNG_TASK.
> >
> >  fs/fs-writeback.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 5444fc706ac7..bfe469fff97c 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -198,13 +198,15 @@ static void wb_queue_work(struct bdi_writeback *w=
b,
> >
> >  static bool wb_wait_for_completion_cb(struct wb_completion *done)
> >  {
> > +#ifdef CONFIG_DETECT_HUNG_TASK
> >       unsigned long waited_secs =3D (jiffies - done->wait_start) / HZ;
> >
> > -     done->progress_stamp =3D jiffies;
> >       if (waited_secs > sysctl_hung_task_timeout_secs)
> >               pr_info("INFO: The task %s:%d has been waiting for writeb=
ack "
> >                       "completion for more than %lu seconds.",
> >                       current->comm, current->pid, waited_secs);
> > +#endif
> > +     done->progress_stamp =3D jiffies;
> >
> >       return !atomic_read(&done->cnt);
> >  }
> > @@ -2029,11 +2031,13 @@ static long writeback_sb_inodes(struct super_bl=
ock *sb,
> >                */
> >               __writeback_single_inode(inode, &wbc);
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK
> >               /* Report progress to inform the hung task detector of th=
e progress. */
> >               if (work->done && work->done->progress_stamp &&
> >                  (jiffies - work->done->progress_stamp) > HZ *
> >                  sysctl_hung_task_timeout_secs / 2)
> >                       wake_up_all(work->done->waitq);
> > +#endif
> >
> >               wbc_detach_inode(&wbc);
> >               work->nr_pages -=3D write_chunk - wbc.nr_to_write;
> > --
> > 2.47.3
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

