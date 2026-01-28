Return-Path: <linux-fsdevel+bounces-75809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHUDHReAemmc7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:31:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AAA91FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C89C303A858
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730ED327202;
	Wed, 28 Jan 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgK0UAt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55424CEEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635852; cv=pass; b=eOSX5YjXk9f70Dqbw5qNnQ1Cf+rEvVu0O34QCMeoHYBNCO2I18gdf7FWkzZix4o8BiXcdpZmESWcIIahk8LgM0TzRUleNJEgeENzcqMVXZZYl4ov6Oa23y41jSTwrfvt7Qd1vtRy9cgU5z70CJwh5rCwGIJt51h+jBcuIRVYo1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635852; c=relaxed/simple;
	bh=oTDUXuspekuoflCCCvdaf/51nYCK6D4Tq6W7Hr8EGRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+tWHG2U5BSgXUvaR+P/VSPGaS59/2JcWQ1PfL0IH6Nl+tqwbvnLaePX4o6uvmidHr6oHP1hXcYgfNlEzzIWikpbiBpbwm8DRe2LA3bff+M/7kumCTgKruY0bEZG7tA/2yXaKc5tRulaVIwTacwhXqSL4pF4MWw+7qv6wK01g24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgK0UAt3; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c551edc745eso112725a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769635849; cv=none;
        d=google.com; s=arc-20240605;
        b=bQqy1T9WvgVSrk/Eht6TbJiWmQ3JiSuCm77nNAuotI9/VKBV70RYT/SBtGvNkwUrvp
         sWQyTN5CDkh/GxrKlF2JcxN6MUSb2fJTfnudS1JBMwVkK2srV1hmcpniZjQnvpDYgIZ4
         oeW8KRlsIPP1+8TKKwVz0hb2nqSF/Ut+AR5BxZIZWmfGWHC1apeNxihsd8eY3gVXwxqE
         SiR5m7qxIUk6LVOU9xEdhOwc9eebuih+6ELbejFUL2hXreNOvy852WDGwywbpuvksE43
         HfoswQZMHomDzpX6ZMyn0kjGS3ojVtH8gS/solugIpeuG5TMF88o4gtbxWDQAkWIOPmc
         NsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        fh=NXpIocY1frErbPXelRfU5WE8uDXWMhE4iHXkrvrASEs=;
        b=AybMB68hqgwlja6Owei5XEjjnbdjodMH/hQQiBnRNoCZslbkWPlZqHpIW33Rm1ugTc
         TsgHgTNGTbwcuFqPnLHcuHNqGsxmeym20zLyNM9JB46EvJgCFKr6kyiRJjTMXRHqhVjw
         35p33C7AKTZcvw7dC0hKmJh1ak4oc36rfKwJC90FeiHMOwTZe8dy3y/j29vJg140TqDK
         KTJSwyJb9ZhTq9YvFGLyYxPcoWCv1wd1tawaO6J9h/yK5sPSFeeyNls55CBtlQmTruN9
         nYN+daG3UIyHxRXplgsYLdKNNsWdsTJLQxFX/5OhiISy143aYR7YQhlJj6gBxnMKi+3S
         bCNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769635849; x=1770240649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        b=LgK0UAt3VQ2Muyl2YwcsryRUqQMWR/IZRJu9gyovwXYvwmHlmsGk5Y2CJVGoUkf96Z
         eQnm+D4/C8qxXhLVonqUS4dgUyFTWTu9vLtc671P9DWI9fVn81SngP9maz86FnlkkeYM
         FcnvFlETh0Y+1BKID+blQeJJjCjk6Qho9cijEEMvQ5qjFPeDrN5qZguK39wr0xsiUYpM
         yDxG37u1trtRnaXVTjTaG0duqojPTtfwujlpZv0ku84czZU6a4Hr1qoBs/5D1mBl5YiJ
         Dj3Nt3XI5qrtpZ4fe6Vwf1tXFcM5fERd5cQGsMs01mjAzbGuu3w0vfvirPk1dbTH05Np
         w9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635849; x=1770240649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        b=gRjDxHzjvzC7c9+Rt3AKxM5hizi0eCc7xS8GFEVxhK48ItSJ99OBAGxQnV6Gd8g7bb
         3xs58Ov6TmQBm751BTA0f7YbZOI0lpTuJAnqRUEMjHmHeHq/tNtcb2pXzs+qWG9yTHB7
         hv4U6PW2ONXj5ou4VRKSngSn+jvBr0npW/WCsP5x8tVwPCIGAbIyh00sQFensY7F+51k
         poA+6lxxuNIR0axS3jRSQbGWfSJWkvAizDo1NDLzJgfnA6cGtrKYXU3YJCDHe42MZ8rw
         64ECcgdGQ5+abGIL1unc8OrBlenAtiLeC8c2GCnRox8dF+uDdsjjA7KocGenYAF8s+FN
         baQg==
X-Forwarded-Encrypted: i=1; AJvYcCVgNkVFyP6WKkt8M87wrq7uIcHLHuN7RxRHT2ejfOw6MATqt8b1xFjYdJ1+sqWtOD0EzViDAvYziwDuMy9u@vger.kernel.org
X-Gm-Message-State: AOJu0YyKObNUTG+o/NaFrru24WOn0RCVhZgTkY5hl4CLC/odhB4IPcFX
	9+zhaa+DkrVOTKa1BN2R6aKqs8GCYcGe9WVxrBfBNNi1ugUkkt2R16n1ZeRj9MU76oboAb/Vuj1
	vJW77Hw9dMmi50U8om9oAYTtXIchBpAg=
X-Gm-Gg: AZuq6aLba2bvB3RiNaQ7qKHbP5RrgD4ui0eiifEGnXiTAJbnkrNgAilV4jRc8gafcL2
	q/VPN1Cuz2ap1Lyxz7DDeTKP48xSuy+KLsKZJYu41Z8EcDdCnluHTe6DzVn31emd63RBaDTjBKe
	ZbPT7kzb+cvGipDnpj7Ni0eQTkXmf4NrkLulay7SmiS4wFKj0ywWt0Pc1vtNz30UkEedgMAl4Do
	ajxIoh6rRZzjBaSPV0Segodg2svE4gPe2qnOYci/eMdaSmXwdU8E0THyOdQYbJP6cNZ/tEJ1tNd
	8fEJCQNuppS2lYokNMhRQg==
X-Received: by 2002:a17:90b:2892:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-353fed74c1fmr5879594a91.24.1769635849063; Wed, 28 Jan 2026
 13:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
In-Reply-To: <20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 13:30:37 -0800
X-Gm-Features: AZwV_QjHSWyqWt5Dm8Ai8UuksKxp5jniDzRGkYBpB0ZnFwwuHpKNwCSnC3fMcVk
Message-ID: <CAEf4BzZJSuc0AH1Hio-DVpgR9S-KZsMNqU7tb--c4=mPZJ5dcA@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75809-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B39AAA91FA
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:50=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 28 Jan 2026 10:32:32 -0800 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> > ...
> >
> > To make this safe, we need to grab file refcount while VMA is still loc=
ked, but
> > other than that everything is pretty straightforward. Internal build_id=
_parse()
> > API assumes VMA is passed, but it only needs the underlying file refere=
nce, so
> > just add another variant build_id_parse_file() that expects file passed
> > directly.
> >
> > Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API f=
or /proc/<pid>/maps")
> > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks.  ed5d583a88a9 was 6 months ago so I assume this isn't super
> urgent, so it needn't be rushed into mainline via mm.git's hotfixes
> queue.
>
> To provide for additional review and test time I'll queue the fix for
> the upcoming merge window (Feb 18 upstream merge) with a cc:stable.

This seems to be exacerbated (as we haven't seen these syzbot reports
before that) by more recent:

777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")

which is in mm-stable. So I'm not sure, probably would be best to have
both of them together.

