Return-Path: <linux-fsdevel+bounces-76895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 80bqDGuli2ntXgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:38:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B211F707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0A8C3018C12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654A334C34;
	Tue, 10 Feb 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjrj/cvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD97278165
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759527; cv=pass; b=nd4JIqSFBFxr3pTakPnNE63Nq1sINoLVUTdsG7Y5iOpYC+VUf629g8FkHFh6ZhyDfbivSZNpn6pBuJdMzG/1onxap63WDkX66WxkI/fjvJi9dKB0VgYq/5EabB4SCW4DHT6RS//OStI6U8HcM469IKSI8MBV8X8k+2pLIkQWstw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759527; c=relaxed/simple;
	bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Knbz7rSqqvkq/mHeAR7SBo2RJjPp5Rbl3fUYKN4IRRYUNstggwbwwLgJm+4Xhq5a3welxdEPu1OaTJ2EvadspTXe5zFDn6v0lOSohu9A9f7GegRkdwQVAQ8L3YHYE16YaV5Zlp5cSSyI3/QdrPphT2omJOhJpALjNvwC/ie147w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjrj/cvf; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a871daa98fso31577095ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 13:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770759525; cv=none;
        d=google.com; s=arc-20240605;
        b=F47N9elDig9/TKVCUF/w05tO1s7pPeg5vonw/KnJIPKL6LC8ZbkN5Fva3b64UA2Uxh
         pfhdmBLfCooWZ+JRSOoY1lpbDNYIK8XB0z5RS6aDzbD3E4RqN+GrqT49Qq9pGllDj9FZ
         kjOM3nkO4nQKA0PIXniW5Dew1T51dO9CDQcX3nH1DsSPNRrF3VUoy5DyGtw1MShx+49Z
         0DdLgg33FOvNUbpAl8RXBzHzbLpPghCqVt+FJY4uOxefyTNpK0H4NvUsgaSvxF3brZoC
         QPBjHSlo8bagwE17z2OlJJ6Kdw53b3GhGKe8T70GgALm3wigyQjv1KmkPUT2XReISc6z
         JmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        fh=Uvza3aov2Gmmt0qGz3xNDhPfsQwH/WBzeVbYSW5KRLE=;
        b=Eprskqv8ZLylHP8g8nFvTeY9XJ60ujnTbr8q/yJe+/mTwxjcz6e2jh+fBtb8vPcUbV
         ozZIKhmQ6z49OQds87O4pU9YgKEg0TDli0T3Mp6Y3xE47o6Br7EQMmbKFvlNT+gJbT2t
         MhjeuETCWnF2NLbE4alEyn2odQP0zx/12WFiRkesjxKNi13ceCDgHmtW2XI0hjEVWuh1
         CP8292YmdI7PUwLyPOXH01Y+jZg80kY/tuaq51YxF4KuG8JnYUeP/oM0w+1py8Qqq1cJ
         /LFdl2a1/OhMU/tG+gj79+mkXvVQ2tqaS2tTBg+SdRBbusHB2Ik8rC2y3wMIwLr2bM6u
         kB6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759525; x=1771364325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        b=gjrj/cvf3qgqX6pPT82FXWiHCqjrEc/PrB4lYOZmSizoz/w56fO8KUWBgajZq6yTsi
         FP5EtrpVPauXhjYaSdSB0xtyG2dXqY7aAxh5Yv+IzSWBABo0yMCQZBeYSVpoCWL3aaLT
         jxUmzRaCGKsqBFjxj+Wkk7uGMZuTJq7hQ73fl7km4n+2/M6pJD8YXKXQiJ0yV/dVAd3L
         XAXnAhT3+/xwXvHMJ0Ct7jMLpjujzMDL7ewGg8cQ3uJ9a9OyFB8s/1gbmddt5BrMG6L6
         oOPhSzcjSTypvsQ28cKp1rlo/gnqmKHfZe8qO/Dh88YfR4dKmnk0cqmP+d0egU+3jm1G
         SPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759525; x=1771364325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR2ChMHSQYG9eiKqn995QhGy6+Jcq6dQubiTn+G1TVc=;
        b=OJ2myRut8igiNOxnamm88IiVm3uDlwF9upShrvd5lxOBVRbd328n3j6a1rylhkbKT+
         dIK6rDNDb/0ExRodAEznmSll6cdt5nLRGU71NXHB/VULhwhRsOUWExbGvNYomB02x3we
         EkTTDFWamTX2Drq1ddPJnlgxii+0JJ2ZoA7odx06WjME08KITpmZuSkCxDFmsVwyQceE
         dOTMcxItO8FA+2i72HBV2FkUb8pqfg1dpLv6sbYSk9X6gz6hOTOUJmee17Nd0KSZjxVs
         iwkS0Vqf495xguZpOpsPPItM7sptrLD0ZKgukZHdpzVSJ9g35QNVQ+apzzM8Vq15Vs8k
         MlOw==
X-Forwarded-Encrypted: i=1; AJvYcCWJlajy9E/lfudgT28LRBmqmG7WDqkzLfTDlFJ3fKTLjxbNgQQSrjg3YI2vC//eIUNrjcxEbdxIt0LKSUGo@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM1Hyzudv5eevq6TZn7Q/wAZuyqNGOMoQsnei74coAalGE+1g
	wMYEGtzdMFrOtSxRzibZchr9qmXRxH9TXD2NptVdmOGGvnt+9hYgTyoMGQTdLeU6YqfobDsv7eI
	m4EBBlN6GUXvYytKa+/tzSTX2pDbvQlhzMg==
X-Gm-Gg: AZuq6aJRvEiYdt8XkLdBSdFNcpCsXwdeJcKpEudD9yvSrcZep7NU1OUdaTkF+bDxFDD
	MbaB0y00natgnBlpYv9zZShsV+fKoZh1mbrgTY4BpbshcdJrKwMJUoV5ujXtCvqTUzmi4/NLoul
	YUhJb5/7Z983NQWibnpdpd7PVfmpB1Ko/mYo4ftDBDOW1lnqTF2/nixLbN0DaPXZWguMxqjcHiU
	qPOaCCTN/aXqquGcJ24VP1FudMFW7Fs/F1WeEo1dcK/8i8rXuVaI5OAAZdkpFf4QLKswzLPL52M
	Gu4KNoAWxDesdfp2xIizHok=
X-Received: by 2002:a17:903:1aef:b0:2aa:ecec:a447 with SMTP id
 d9443c01a7336-2ab27f5ccffmr6284285ad.36.1770759524804; Tue, 10 Feb 2026
 13:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210192738.3041609-1-andrii@kernel.org> <aYui6BgekgRplVka@linux.dev>
In-Reply-To: <aYui6BgekgRplVka@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 13:38:31 -0800
X-Gm-Features: AZwV_QhA0DEhtZ-EkZ_Xu_JjyHDVYb_bRHTKSR6CTiprFcTcAmgBUrZ-O5pJohI
Message-ID: <CAEf4BzZnwhGW1VPtQ9svSYUp-+c8=9rxyupF=Xf+WG3sV14oUg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput() in do_procmap_query()
To: Shakeel Butt <shakeel.butt@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	Ruikai Peng <ruikai@pwno.io>, Thomas Gleixner <tglx@kernel.org>, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76895-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,237b5b985b78c1da9600];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pwno.io:email,linux.dev:email,appspotmail.com:email]
X-Rspamd-Queue-Id: BE7B211F707
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 1:30=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Feb 10, 2026 at 11:27:38AM -0800, Andrii Nakryiko wrote:
> > When user provides incorrectly sized buffer for build ID for PROCMAP_QU=
ERY we
> > return with -ENAMETOOLONG error. After recent changes this condition ha=
ppens
> > later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so ori=
ginal
> > goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
> > further to clean up only vm_file and name_buf.
> >
> > Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA=
 lock")
>
> Why didn't the BPF AI review bot didn't trigger for b5cbacd7f86f?
>

I was wondering the same, tbh. I think it's because I marked the patch
for mm-stable tree with [PATCH mm-stable], and our BPF CI
infrastructure just ignored this patch (even though bpf mailing list
was cc'ed).

> > Reported-by: Ruikai Peng <ruikai@pwno.io>
> > Reported-by: Thomas Gleixner <tglx@kernel.org>
> > Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

