Return-Path: <linux-fsdevel+bounces-76183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CcQJgHQgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:37:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15001D7CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7D80302CD23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E032D249B;
	Tue,  3 Feb 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiK25jnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036E29B777
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115004; cv=pass; b=sXlZsgQIFcp0EaV/jB4A8+zJi53vpc6PSFKxEcTuybSKQ364YVpzvBNJkaWGXFhG3QfK3IsPcdvP0pykJByEp/JUBftIbHbJWwFBOH6Yw+59bFVQD5t3BCAc+NjytQ0kU8Gc/D6m3HvV/YBiprbWRFwVBlua9vA5Bd4oMkjFktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115004; c=relaxed/simple;
	bh=ul7KfdRXTNvuFJMdZ7g3tC8uGE9mAlWxgeaG0R3HtcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALj13GMbdi4QtaRg+fJMy5yrFEg5DtVhksg1EfuNDTlxwxj21xV74izrpM4F1ZLgR1Nymkz/3GDzfh+vNPyieHx6gagGKuumi8+2nkc46Wg5imtUVvKtPYuJOMYqTvTw3bCVlrUpTY7FIAMaN8RjQRAiRuxwk9R6PDBH6QOBLg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiK25jnN; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b884ad1026cso900807866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 02:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770115001; cv=none;
        d=google.com; s=arc-20240605;
        b=ID7Km20PW+tf29JC/i3N7cRwH47DD0/wR8NzF/iT0ZQBfIEleRcpxCLZv6rd8Kgv7R
         MrN4PLYS1ewroTO2QhYbH+8O42N1KthJqfJC5Z7+eRm8+cWpK7CSVEkGX5rcpQZFVNlU
         n77UsOCueLIhAdjk/L6npuID7qvBYL8IHIXGtfI6faklRLIsyaI+eDQ+l4fCo87WBxGf
         uZxlWJAjqkq/afwNtAeCA1NPn3+0f1dsrCWccKsY958K1nj+9z5biV29BQpNXWCQH4Xp
         DtJpVJ/U23RwcN7+K8s9TmF5VCP3janarso8V4RZd8p8iMeuzeGLMK7CVbeRYyP5Ga5B
         uSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJ/HweRTJprPyy2tfWc/5Q2wUSI9RBrN3tEReiWghTE=;
        fh=tt3vU/0Xta2Khdv0uPwMN/APwobqENJGv7sKHLX/o1M=;
        b=NQ4FIeAp92iXtgCn9nAQ5yTr4n0iYWh4m0OS4veOSI75xZa21gM5tOC3AZPFUmr4z8
         oAON7h8F0aWJRw5JKnPwqj2KfJuqJI2t37US1cPDwyYzrot5Q6JO+N/XR/oDRHqAk24p
         gSV7K3L/0iRMncI8oDx0dRYC/Z9N4PABoXe+WBXer7QoTu7FEsmuJjuIZgehDpKtk/cv
         m6/yMC7Qyt0R2vvksQDdpelAuIJHGjrA2M8ay966atwUYzyawJZEdvFLkC39k5cjgOXf
         faHoN+s/u9BsdCrP8e/hGPjeDXkzffVBgncwk5+yWd/d66VvrrKjGlKaLQIYMHjVKEp9
         bLKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770115001; x=1770719801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ/HweRTJprPyy2tfWc/5Q2wUSI9RBrN3tEReiWghTE=;
        b=MiK25jnN3bi/nRrKmI1fA+Z03U6/qNw27D06A135INZIBW7X05mU5qeYYdttEAakGg
         O9rarsN4iPq6v8vWpxLIAYJ7HB8dpzSU7At0dVdhozPEhYRYtzOZPgeZJ/dgooDwTT2j
         HKx1bypoNmM2Myv00k1Rt4esQ2yqFFDvW91Kgepd+uM96cVFAz9qxWaI3Vgoudy0wsdw
         ISwSoE951IKl0UcKOmHf8c/7qaaIe5vMevpK8Uv1M8As21AzqzTANEMuWmQ6D/H1tl2o
         54RVq0k1wrPpPnjv17ryLjIILFMYYDap/+hxTeKx/5czzs1VREc8Rhpd4sYKuiEAMl4D
         F7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115001; x=1770719801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJ/HweRTJprPyy2tfWc/5Q2wUSI9RBrN3tEReiWghTE=;
        b=t6oylXp5zlhqedxQgL1DNl7moU6KPrxo65eWF0ankc7C82WRLIOKDbz39CGYOJLkyS
         RycV9yAGM3A1ao2rD1PCT53chlczaAfz3ymN3MbkkLAJVPZ3OOfUS3v9+U4crDREShdv
         kD1Cufh9ZU47pkt8+fvTxtya83cvGyjquO4pCCPuDCfhJ27VlGcD0ko+pG9yAY6czey0
         i94ixZUN7OFfAvAf6i4auvfysmCr/EqGbeoxArkoC+5DdVOpFa8ekDpXKrAkeqv6i26z
         KCqZNJfaeef8GYGQRj7tPrQaGgjIkr48nFIE3T+gBD91Uk1SZpu+zF3Tv4RKCC2ZaLqz
         WLuw==
X-Forwarded-Encrypted: i=1; AJvYcCUl02JV9I4w8Bk3mLNubdQQP6zx8cKjpqk8o7AX2dTGnszdJsv1Uhq0RSdvkmvNG54gtzZizMnFqNraua0X@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9SNOt0m0uwetUCwaR2NshbGidMnS00jWP6RZkhXjejSnsHM4
	Kth3Qmro7mPsjcjv/Scnz00qwV8grWQ1EkXNmw3tob0ybNzfjJ/cBgbYwN6py6m7tFvQVPmQUA0
	Mu/6bVWDKhSmlDp7b8RpvEYbvR6Z4gJg=
X-Gm-Gg: AZuq6aL09tu2VSr+N/swzmi7bVp6Yj5Pd7mrsnsMWxPKMqrMdyIWzIHPRFy6ThghrSv
	+LUz29MzILnQV8RpQ69nSwhmi+NqtXZp+3F/C1OKWu8CX+L01nPg+K7aZrLZV+Q/GaKLdCEO7GY
	soT/jE48a/9p+HorsXNtQw5jM5JHL82dWwtSo1dO2HfR7UmKHTtV2q1ZS7AoU3F9Zeg0tgPKujx
	1qUPpTCebB48ktyFMaXk0S4scE7bfrynfW+lfrA0+adUbi2BG46YxVtKldwN/4tfHUaB8WEYLlN
	b6HqOzK1FWKYgnOip7L0tVs4FAD4qg==
X-Received: by 2002:a17:907:948a:b0:b87:63a8:8849 with SMTP id
 a640c23a62f3a-b8dff6f6f95mr949753366b.46.1770115000982; Tue, 03 Feb 2026
 02:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
In-Reply-To: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Feb 2026 11:36:29 +0100
X-Gm-Features: AZwV_QiZMqOQhwDuh5GFcuPBQIpPBUEBNmCDwHAxvoye98W3uYQSS5l94tf_J0g
Message-ID: <CAOQ4uxh5aJTY4fSODDedYD750voZG73hdM0SMnZYd66Uc19rmQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-76183-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 15001D7CCF
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 2:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> I propose a session where various topics of interest could be
> discussed including but not limited to the below list
>
> New features being proposed at various stages of readiness:
>
>  - fuse4fs: exporting the iomap interface to userspace
>
>  - famfs: export distributed memory
>
>  - zero copy for fuse-io-uring
>
>  - large folios
>
>  - file handles on the userspace API
>
>  - compound requests
>
>  - BPF scripts
>
> How do these fit into the existing codebase?
>
> Cleaner separation of layers:
>
>  - transport layer: /dev/fuse, io-uring, viriofs
>
>  - filesystem layer: local fs, distributed fs
>
> Introduce new version of cleaned up API?
>
>  - remove async INIT
>
>  - no fixed ROOT_ID
>
>  - consolidate caching rules
>
>  - who's responsible for updating which metadata?
>
>  - remove legacy and problematic flags
>

- Let server explicitly declare NFS export support

We could couple that with LOOKUP_HANDLE, because I think there are very few
servers out there that truly provide stable NFS handles with current
FUSE protocol.

Thanks,
Amir.

