Return-Path: <linux-fsdevel+bounces-79815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKJGLkH8rmnZKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:58:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004923D367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D0830293E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633C38F255;
	Mon,  9 Mar 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFN+k6U5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F823DBD71
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075078; cv=pass; b=s00+qcf9oKDDPdK7+Og/lO5cAES34Wz+yvygWsY5xzxeVHv5VrhU9FvU96hyaTWyfnNbkBGzqo44lIdlllKfLegOwQnWIS8kTJImhzM19wUjsTd4SQTjy75nccx3N+bGAM+pAXDdwEy+1Eud/b7neweZTq3APnaQOfsCFkPG7/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075078; c=relaxed/simple;
	bh=ZOwexnLzgRaOcJkwphfgSAD84/oNl6Z19amZw/BOZCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdctD8SHZvMLWZ9kf9Zxh3ZRKe5v96dD1G3tIGwgCYeq345QySnkm0TeVsmZo44xjeheRhARAbGaFdsCxIjzG0fi/ofZEAMuuhubyOy9Oqi4wAhAzoNDAF4KfwW8A1skst7KqRADL7wW23sBGFcBCTJrU4PGObOB0FHVi33Bguk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFN+k6U5; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so360a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 09:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075073; cv=none;
        d=google.com; s=arc-20240605;
        b=TlPUJ365aaf0MlBKRI8mKigvlPlB7AgmhffgcbB88dUCGme+/qH30Vc2I1xKOJoUHD
         pKtn1EnEHEXtVyWgTlh7qZXgxlZPLJLSUi9FfQJJjLcXM7BUchyNT1MN71gVp9PBxVgS
         2fx/Y+0hO1uWdY57WsEzvQdB2vdsnHvl3T5IuHrHxi9N5NlnXN61gXYLihdXm01yJ6Sh
         Sc/uCYJprja1ACFUr7cND0gViO0bMfB9/stmy5RjWs93FZJ6F2LAI3HbetDkv3OSObew
         eyOD5njEtuHQTX01uLLUkIFkcIpw7kv8F88M+maGKFpSpzTV84rvKMMsBN260w8jH71T
         Ha0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZOwexnLzgRaOcJkwphfgSAD84/oNl6Z19amZw/BOZCg=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=VpYnYhhZaiPROGy+K/cq1dZqC54YKmoHCcVApOBmao/HRSnyU67v9WMNwGpdHWw2pK
         a6RnWzoW4IOD/OFpKnxoIco+JWeCzoUyS/M51UK3SgJgXuUKvvVTuHyTZUNgU3ICuhBi
         cD17PEjE00vUkzUmdk357tQe8l2nwOwiHLcap5ir93pAfr3NHSr9/FSyETjohhDhwcAc
         32Ifnh7Ayh0u5IOCD++46mX/rP7HvRrBDs/3ye1aUyAUedV4tIHEhU0XvOT+d0F4aQuE
         rleCoLt2S9RbUGhRI7D9591yHeAR8qYQQhUAO/zLNenrmK9JAFOuym1cznnNjDNUEilM
         RDtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773075073; x=1773679873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOwexnLzgRaOcJkwphfgSAD84/oNl6Z19amZw/BOZCg=;
        b=xFN+k6U5gbzRGKKvdUVy6wmv9A5zM4hrp3ydQtmMF6FpYD/wOwY+v/yZ7kHz9LyWfy
         OD8mUOziF/A4ULZWwGcSDZaQgM3K9FHtJWseklBjPqOWKZ2bOaJ05N6lZrIKitThgQ6Q
         EhflSYBqxnmVe227xfXll7GBB0SJtaiawOTaFveWkcSdQ7KquTgRqcWfcXB3v7kPjEOf
         HlqI4CCnAx6bFKaSMwf2SqwCr6YmeK/DyiHaFgLTSMZgPW1Hg9qrWnhnabhbilvlBsX8
         YLgwA4FUxxsZ+ftzln79jUBLo8f9xUNLNwa8yphSC6TIotGwvAQDW5VIOddUGtEU6+jj
         EUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075073; x=1773679873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOwexnLzgRaOcJkwphfgSAD84/oNl6Z19amZw/BOZCg=;
        b=SFedY29MHhwPxnH1EATnjN+3fAdveGShG3AwiGuEYyBgr6DRNlvPpbZvEuiGIguPC2
         F6Kb6+XigVFJ6iHMd7YCV+5HUQxXPssqGCNeE+GNtgjA4Z64BYhaPHabhta5U2SftxZu
         PLd9s4SuoafaqRcbu3Cm9+/OtJTOu95w5nOojDM/MK85qYyQPnQ4bTJuZZktC5OPkJV8
         utLaYvDeZXRY/Cg8i+NnOBXtYJxdP1JrMD/8eqaGMuPJ3IeA6PmaX+k8a75VTCu1vV/S
         eov2EgYA1Vjv6eIrnF53ZWs0qfIAiNiWLXnVXdccAolqba/pxG0E8F4B1y0ssJn4rJoH
         2Sgw==
X-Gm-Message-State: AOJu0YxnDxB8Xxlofu/lLouxLmC/MbOOStaTjTq4bju9hF6AiTjuoOlR
	irmGcRofT/IKjZkJsloqNn7T6iL0pKvcw20mtFPvZqrLGoc3wIMqCNl4Ns1XLb2C7lixHGaIHIu
	+iZ2E1L21vQ6SSydUSBR9+l0DSxVh7Dd69Az01IVx
X-Gm-Gg: ATEYQzxXQ5FY+CRidNvlbGNFyEFlSuwOzFDW0PiZ0EJC+Yc9OO+VKOWVa3JkyaXLMMo
	gLcERCZX2qA9v1yrm3UHc0s7Myhas+H4vj2vP8aonckaDlhqZWejb7n4UmTQ3jxRkW6EfxAW5X9
	9u0di9NnmdI4/xwRweBTUHRkqoJe69gyf3JZUkux4H9c/3c4EtCVNSuCR/yWvUl+Ug0vZGJjfT9
	wDVmP1A2Nynu94akkVwqL7cf4WWOrmYmuc6bt+s7jil2nJJkQxyvwKIr4nykqw17w5C9Jxd725S
	FYclmFchfV9Hmz7js8LSGdsWz+y11+oCtJOKjA==
X-Received: by 2002:a05:6402:32b:b0:660:f90b:a19b with SMTP id
 4fb4d7f45d1cf-661e7ca8126mr62094a12.8.1773075072266; Mon, 09 Mar 2026
 09:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Mar 2026 17:50:36 +0100
X-Gm-Features: AaiRm53QzzneIU-TxHuc9lEWgrdehRwyStTmzbthf8difyoN1mbFyLtsojOfYmk
Message-ID: <CAG48ez1CN4hrYVi3dGYY-4vJgSeib-pb19qCNs7Gjkb2mrjKuA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/23] fs,kthread: start all kthreads in nullfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2004923D367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79815-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> The places that need to perform lookup in init's filesystem state may
> use scoped_with_init_fs() which will temporarily override the caller's
> fs_struct with init's fs_struct.

One small concern I have about the overall approach is that the use of
scoped_with_init_fs() in non-kernel tasks reminds me a _little_ bit of
the set_fs(KERNEL_DS) mechanism that was removed a few years ago:
There is state in the task that controls whether some argument is
interpreted as a user-supplied, untrusted value or a kernel-supplied
value that is interpreted in some more privileged scope. I think there
were occasionally security issues where userspace-supplied pointers
were accidentally accessed under KERNEL_DS, allowing userspace to
cause accesses to arbitrary kernel addresses - in particular,
performance interrupts could occur in KERNEL_DS sections and attempt
to access userspace stack memory, see
<https://project-zero.issues.chromium.org/42452355>.

I think switching task_struct::fs is much less problematic - path
walks shouldn't happen in IRQ context or such, scoped_with_init_fs()
will likely only be used when accessing paths that unprivileged
userspace has no influence over, and VFS operations normally don't
operate on multiple logically unrelated file paths; but it means we'll
have to keep in mind that filesystem handlers for some operations like
lookup/open can run with weird task_struct::fs.

To be clear, I think what you're doing is fine; it's just something to
keep in mind.

