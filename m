Return-Path: <linux-fsdevel+bounces-76454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAChEemhhGmI3wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:58:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACBF3A1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09223302C77A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DDF3E9F6E;
	Thu,  5 Feb 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LQRhCHvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FE3E8C6B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299861; cv=pass; b=fD2i0S3DJhzJNVQlXNqn1eZpA0lYsDfJZuhOlKB9tTjBWN44Z+U2yC3QXii45xSJzs036vrx0dqpzILHTF/AWLcxDYf9gO4Mg0mszp1X0CB4TilsgK5DJ7bZz9vkBOjzfvh0Yb9ILP5Z86b7Y0oRTGVWStHYfhkKB3tugoN0hW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299861; c=relaxed/simple;
	bh=oadeknu5pggRVyIIVgA4TEeGW4cY+QtMhF+tlOuYHt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvnZlBfnBWEZ3oYsv+DqRegls6R+t3b4yZ1+LoqiNsJmPXCWx2dt3FVufGlX80sA9FzcP3ohyf53/udqAUChMi4gBwaKhwz8Y2T7yKACfVOvLqkeIspyt4P9DGdzHOsaib1DGEg4fnYY0XbpitOadVXVFZBuMiup0Sge20U6YrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LQRhCHvu; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de0b7c28aso1148567e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 05:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770299859; cv=none;
        d=google.com; s=arc-20240605;
        b=Ah51rms3rusM0ucdpt4/88gE0/xxmTlQn2rCZ0KhJeHn3OTs1ib94RxvCBNegcz9s8
         Fs7dfOzhmEM44Z3bRjsT/bOLLcMmcxj3D+bVxSBiLSzlUSnC9qEuOQq94UIijBPuA9TL
         wm1cC1OxXBN/gz4NX9ahgTRyu/i2O2gOP5EkjGc3Mh8dbVcX32+Vl51DlutwMqrz6HHE
         aFGq8tEs9uVgPP7/knbvtpSdX94f1p1c8yMF7KajN3+ogy47yPl3Btah/VvKX/fnTmRU
         23Dr44KTplY6Bec27YD6KCERmAP17+l4rJ2QlmEx8XNp14zmM0HeHEI17a92eDft+FJO
         wSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        fh=Gxiva69uTSYE9NwDl+np1JJa42wJvWjMKD6Gs3oeNyg=;
        b=bpnmhGHX0llfwe3j6r/BXK39W6XW8QxstrKzIUKDBj2rI5E9+o3RPIVYwy9V2vk8D0
         rjI9O2Bw5sTQt3yFlHeoBRhyZMG2gz0zhMMyIXlRtExMoNXa7u7QLXXcmolrcRQfm+7f
         aqxfi8MjN3wT2oABykqqlsjHesVpMxEb5MXg8AqwlovyTquSCi+qsR0aE1ksv5h4Pysx
         ot1Oo/S7wVTpIiQO5RnqsJteH12UMSIo7F/VO1qaV1LfdqDhl0yFIzOYo7WB+9kf6KnR
         1KjOc95lTZYuQOa5D06LNkREfmtLjzO1TEE3tQA+QBQb6hge433VkJDb5zTY5xN08a1/
         4Wfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770299859; x=1770904659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        b=LQRhCHvubT4bCozL6wzNLq9vmqb7ideKQR2ps/qOwoO8Cz/stavSm2U788sSx3A66e
         h8xdRlO7+oFfNBYt6PWo4YUgH7kbPZnNN5tsZtglmu6exYuHpkl6VJY+015sHsgO5Sj/
         h/6+zMYGiTB+WhmhIxofspCKeStGDFEmMMrK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299859; x=1770904659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        b=gvNwJdA470pLgnUYPbTxigof5VoKEJvT56FuW6OlxUITxj6hYXmaGW/7lycPslz3T+
         CHgee+q8KYAI9FZPAXtgl86L/SMz1zoJgWl6vS2wef5gUi13c4njAvQmy4vKkodIiDJZ
         fdq2MzgL+OyTcoaGKpJwIjYnvPYiexrQUzKp2O/e876+kHWEMMoHKCqas2QpRloXY8Qz
         F1iZUfl2FocTXOOhzTv+40DhSc7Do/RyWblfIYuJZclT3g1ZsFcC4aH0rlsIwHMbifKD
         ZgjY3JGt6eRSMITxxqsGK+HUw77IVZyT71fElCpPTVNZsRu4OQ1LC7CiJ84mJa68QGGG
         3n4g==
X-Forwarded-Encrypted: i=1; AJvYcCVBdxcZc8zJwAu4CHXN2fBmHvviCZN8Rt3YKohP/mAHzhLQuspHhDhk6e3MEVyf8qynlamcr1kk5YCjcU00@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwocBXOin8mytwd/xtlGvR/t3FNW7v9BfIDZvL4dc+VA1M8lL
	QsTrEtewaTqtpw8ordAgFMR5RNTgGui4Pk+m94dzhI2fNygpoA82H+k6zYTq/e/WM4TNWmmJ3aC
	sOnK6rqtZ9ZQb8Z6wm/rCrqZ+KDTxH1NTAK4FppXnUQ==
X-Gm-Gg: AZuq6aIE8HMDTE/1Ee4RBGbjZuXSNN3CGr1bZX7YLVPX945Caal1gsrGxR3qQ9pkDVw
	OhF7eh9LQThG3WsayEXy5Kz4qw83AzXTTPpogjyDo7t7E664xNs/xeaprNrWmuIbBoKqADpRTg4
	3MobeSZTpX971cgOGJd2mW7k9vpQW8SzoVLqyQVzLg8ptHTOYEo/HyXymgCgIMITObWuTDKUNc5
	vdS69ZcZVKjxOwd2TNU4lrIlpxWszeGfZc1btZ8ByvQvI/6c2zoMn70ZwcNha+HvXF0CZREM/2R
	Onz13cbDZO8UtgK2M1Jnfdh8WP4=
X-Received: by 2002:a05:6512:acb:b0:59d:e446:c7a with SMTP id
 2adb3069b0e04-59e38c08e2dmr2659853e87.17.1770299858759; Thu, 05 Feb 2026
 05:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
 <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net> <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
In-Reply-To: <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 14:57:27 +0100
X-Gm-Features: AZwV_Qg2m06cnKHDUJ1VsUzeKU_0ovl-31-xmPMNyP6_BJpdS8SpPv67DcY3M-A
Message-ID: <CAJqdLrrqCxt4iS4m57G6fEEOPBkXsi81hmM_sb1WgQ_96K-qKg@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jlayton@kernel.org, 
	brauner@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aleksandr.mikhalitsyn@futurfusion.io, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76454-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B6ACBF3A1E
X-Rspamd-Action: no action

Am Do., 5. Feb. 2026 um 13:49 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> Am Do., 5. Feb. 2026 um 13:38 Uhr schrieb Daniel Borkmann
> <daniel@iogearbox.net>:
> >
> > Hi Alexander,
> >
> > On 2/5/26 12:27 PM, Alexander Mikhalitsyn wrote:
> > > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > >>
> > >>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > >>> index 005ea3a2c..c350857b2 100644
> > >>
> > >> [ ... ]
> > >>
> > >>> @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> > >>>        .init_fs_context = bpf_init_fs_context,
> > >>>        .parameters     = bpf_fs_parameters,
> > >>>        .kill_sb        = bpf_kill_super,
> > >>> -     .fs_flags       = FS_USERNS_MOUNT,
> > >>> +     .fs_flags       = FS_USERNS_DELEGATABLE,
> > >>>   };
> > >>
> > >> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> > >> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> > >> (at line 2268), not FS_USERNS_DELEGATABLE.
> > >>
> > >> The commit message states this flag was "recently introduced", but it is not
> > >> present in this codebase. Will this cause a build failure due to an undefined
> > >> identifier?
> > >
> > > Yeah, this should be applied on top of
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > > in vfs/vfs-7.0.misc I think.
>
> Hi Daniel,
>
> > If this goes via Christian's vfs tree, it would make sense at least to open a
> > test PR against https://github.com/kernel-patches/bpf to run this through the
> > BPF CI with the vfs branch + your patch on top to make sure the tests don't
> > break.
>
> Sure, https://github.com/kernel-patches/bpf/pull/10970#issue-3901410145

All looks good, except
x86_64 llvm-21 / test (sched_ext, false, 360) / sched_ext on x86_64 with llvm-21
which seems unrelated.

>
> Thanks for suggestion ;-)
>
> Kind regards,
> Alex
>
> >
> > Thanks,
> > Daniel

