Return-Path: <linux-fsdevel+bounces-76443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHcaOsmShGk43gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:53:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD1F2D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685CE306377C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE103D412F;
	Thu,  5 Feb 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="AMOJ8QmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6E3BFE25
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295796; cv=pass; b=Q0ZQR/KhVL3W/+2NfUD78l4mE1jo5GGSrKlXwyXs0GzGdgU+ObvQQHZ4uP+PiqNYspfHsQtM0NrBKU1mubsFPbFxqre9Zum8TNJTNPKyrBBbw73YTVPv8rSQJBHA5+fpRFsmkhpLYgqAA+NW56XXxZ9vngDI66cJDXt/Le2jOs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295796; c=relaxed/simple;
	bh=0IV88BrpvTHgfPYK0mSBgTtEV2ZqRryzAk6hOcvufqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfLzkJiTa6Amv8JgGVL6tlNkebWPqyyXt0IbflIEe4ZUSPx8fZEpnvPs8iFMs1gy7Z6+3KlzaFKejQFwLPZ0wKYIB8cT3oYwcZjiUJCzChCXmQDXQTdIhEA8atHffGRRKlWQEdtBXtLCZzzj0IwwCpwszcgg3pNZMfzrJY1oUDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=AMOJ8QmY; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dea2f2ef2so1087337e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 04:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770295794; cv=none;
        d=google.com; s=arc-20240605;
        b=bf4cbwqSBWVYqf/mcwpja7v/YTVN+QTWzB5rojC6ZRthg+B7/z446222zqPSvgLwY8
         4y4bxplUg7ZWvO+BWTb8aXY0AEca+3bCNisVgsgdZ6EP2YsrVBV8ArKASwHrRSwQTgA7
         DxwaVO8sQ0+tFwUAYc2txb0bkQQpqbM8TyyfiBMK0P4Qggj2bBkGK1jX+rLk4m+Iz+Yv
         MbYS5FpmgqBlYoHnWbhqSTHVGPzAMbCRtEfrenSiGjDeYDnzEcjf5pAU3eiKkufiMkzX
         4U9Y35ltd3bb/z65Wd4wUmQvTMAJBK6bZbfVUFrAezjLcWw3K7Xz2AoersR/IXqH4qR/
         klDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        fh=Y2njxQUuuZuUDYT8GBAVor08uyPlQoanpG3QlP02mOw=;
        b=gYkgsf1/Z7UPcHMpuuW3jTIqe0KTTVp0qZmhYslE7WBzmpy9RjdzNEIMo71cEOiCcx
         QnJooxRGXgY7Yn7T2ivC5k02xuAy+FKrPgmpP7zyrq+0ZzUramuGY1zF1QA9Y2fExy9p
         d86fxZIMdYUwaIDLHA7byfjMmOdkFV8xQ2OHFH/n1FVCnpDPXNA1dIlo7c0DesWCZPLy
         4NIq82hNTdUkI/Kpqv4kOTJGzzo+43loVQ0ZJ/fA3Sz0je0JxAjtb7W+g9vXRpwG2z/e
         DGuOjCpKD97at8LvVGww5FQ6+IwIJwvdvzuStOhHNQmjKrikhLd/oW5H+SpJGNNTJSHq
         Ycbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770295794; x=1770900594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        b=AMOJ8QmY8pMPxFmJxn63DWhTbMBIESOEqGJS4IDlrWZL5PECLi+PBQ4TtaUWP7qr1F
         JtjlPV+xCKdFG0n2n0aMFNYKsFtl/0mtKeneFdUA2T7tA+qqw7znVN1zOCT5/l9Jh1s7
         7rpVCRM8A1VOmWub2IzpwoB4m0VQ6RYhdXz+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770295794; x=1770900594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        b=q1fdtsfMo05wv4nd/+pD9ndKHpYppKaZMJJWQJ9oOFWKjQfBkm1JB1HzEkPZ941k9F
         xtoVGcHmUG2CJHpmJx5AXoMatQ2pB+QLeKC0YFD6pyIJI5UQF8JjC8pAGL5uK7XvKoIT
         jot+ZUDMFHntxij9yntyQWunTq6nuaPEUBquTnjWumNntipEijRskrpzbnwAq47QWpyz
         zi4asERkMx1UlwwGavA1q27JT7RxEsQid6IEQ6gCejbFRynshEge9fBixPWPnzjKOynk
         uD+Z5ttiYMwTFEtqCEHOgpN901z6Y3Ya2n3xzNokOEN6xUU4+nOUj3SK6o3VDS5Oa/yu
         2D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV49dThdYTxjKr/OeMJk6lWNq943pRYg8AM53Ds1Qrs+6xPJ5TrCi8ZN+vs07df2Wr8zEXC2CrTq64Eg9rZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLDdOsFY3pFsBo1E/lW0vFToiI2GWAUcENhCIMscV02XS4Ek9
	ZOGsXUjDjIW1iy0O47LMj5xW8zywAOTlqWOwkjjbwcwlarIltslif5ue4SOCtoerfAIsvK/ThiY
	8u2WB9/myulVJV068jmNJSAfGXE72nDzERxqpZtfeeg==
X-Gm-Gg: AZuq6aKr6OMp4WiQH6WZMgj3MPfe7N+VJxWW9ic+ff27t3/IBYhMiEZno3j9zZTvRAw
	6xGrAXeXqwN2C2xNn50zuk0m6EfocUt+i52yMhq5Jwv3sj0mv125Ei3Evupk7lDAmIJCc9a1O6l
	8istqmoCWuquZLJOyY4d2KKhpGExOHpi6VKCyTwOaDnQe8hA/hBeSiFJgu7lWYGU2mUIpnpaECd
	WG1WglothHWcZIMWe/G9aAI350bnU1EwLOioMy977GQO/7GgHIEbi4SmE8kfuwJC0v3phJbKRNi
	VUx2Wb4uQWWjOJUfDHSqp0FVYjQ=
X-Received: by 2002:a05:6512:3c9e:b0:59d:f474:656b with SMTP id
 2adb3069b0e04-59e38c3b99amr2303693e87.42.1770295794441; Thu, 05 Feb 2026
 04:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com> <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net>
In-Reply-To: <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 13:49:43 +0100
X-Gm-Features: AZwV_QiBdeLrN6qoIZklCvfKrZACYbBqxhI-762jltOk6f5fGR71l2wgmgEW5PE
Message-ID: <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76443-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,mihalicyn.com:dkim]
X-Rspamd-Queue-Id: 4EBD1F2D6B
X-Rspamd-Action: no action

Am Do., 5. Feb. 2026 um 13:38 Uhr schrieb Daniel Borkmann
<daniel@iogearbox.net>:
>
> Hi Alexander,
>
> On 2/5/26 12:27 PM, Alexander Mikhalitsyn wrote:
> > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> >>
> >>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> >>> index 005ea3a2c..c350857b2 100644
> >>
> >> [ ... ]
> >>
> >>> @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> >>>        .init_fs_context = bpf_init_fs_context,
> >>>        .parameters     = bpf_fs_parameters,
> >>>        .kill_sb        = bpf_kill_super,
> >>> -     .fs_flags       = FS_USERNS_MOUNT,
> >>> +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >>>   };
> >>
> >> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> >> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> >> (at line 2268), not FS_USERNS_DELEGATABLE.
> >>
> >> The commit message states this flag was "recently introduced", but it is not
> >> present in this codebase. Will this cause a build failure due to an undefined
> >> identifier?
> >
> > Yeah, this should be applied on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > in vfs/vfs-7.0.misc I think.

Hi Daniel,

> If this goes via Christian's vfs tree, it would make sense at least to open a
> test PR against https://github.com/kernel-patches/bpf to run this through the
> BPF CI with the vfs branch + your patch on top to make sure the tests don't
> break.

Sure, https://github.com/kernel-patches/bpf/pull/10970#issue-3901410145

Thanks for suggestion ;-)

Kind regards,
Alex

>
> Thanks,
> Daniel

