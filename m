Return-Path: <linux-fsdevel+bounces-78888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEToD6mFpWkeDAYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 13:42:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEB1D8DCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7CF30B4D45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC336D9E1;
	Mon,  2 Mar 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtoUIMmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5D36CDEC
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454758; cv=pass; b=n5ryEplfC1X9X77vYIdMAdi35Lh64GBSSKOVOuwjl8snXyIj5D5yyTVYQtXV+slJFgKr38C9dhuxvgNm4Li63IY1XxTCI2cmnLElVmlSebGO21FfMjctWmPtYuz6FVOHKtsMjDC8sclyas9n5zJohuaXDKFwBWnhWIukI5wK/G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454758; c=relaxed/simple;
	bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWd+XDCSd2MP+WTvR0hWVcFQtNmsmWpG6Hf43wxoRBgx2cbPBbibltxEd5XYMZJPHlJe2rqHCb22ty6PxZotq6OjNUH8lQjfcGdQfWPUqqcAldaMWkZQvob6AYDcxLgc7s3zXxGIHnv13wRMyectLRDd5QJ2Z/oFXwMuz+glx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtoUIMmv; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be084d8166so71407eec.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 04:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454757; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/NPNsP7RyKdpc0qGW7NLMOIRuKhXHvnpCF8Nl27qh3JsGMf+eUsrkm7disRSrFg1o
         TcdqKV/a9zjt670x/TJ+VHtBUNH5kbIPxpX8FBwTSwH8CTGExP8ljFG+Xm51WWEnks6q
         mQDo8fFZe0NtJWaynyDS7F+y7gkCjtrY3LCaJ4JaIVq6SpP2FQEyVMrZ+Y2IfgCjw3Vc
         RWjJQzVqc5CkXhPrwYl99fLTFeCcj4E0qi4RejDBa7PH/8SX3M1zumFgPY+ZcHjx5QwK
         hNYuv/wwmV8ckrMo+JZcHTavYVoi8LYvLjuEoE/bBW/JThpfU4eTui6L3OvrgnM/O13f
         Iqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        fh=ivli4IWEF4Ku4tJaxoQ6nfN1zDUjV+birCiziBCNj/w=;
        b=UOQM3p9mY/gTH9E7Fp3XZFKD2bVN7xBlhKIMp2eJjwobp+uscDxV94J9DCCyB8esLe
         4KW859oFj9y5iaTNjG40wWUvdxgd3nAt1Tb93lNzlGwgYLkt1w6UtJQLXDTjEl3j6FCD
         spF3IEndr3/eHMQvzNzSgg1MWmXwlG2bOMsLf3L0D3uUTDfvUKUMUwKhwl14xGEW7rvt
         /7+y0EXVITPFGZxGF67pR9N5R4LcD/ZC/Nk1ChezPNBG8JPDF4nVnnqjoSpLc5klo56i
         3S6wMpygOsWfBE8COfniJpdoZLy+f3X0bXDg8UihJs/qo891d2bzWSokV+Wqe5TXG3jx
         c4Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454757; x=1773059557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=KtoUIMmvcT9a1/mJwfhsK4ojPgzcyjaxTFsEcYoZHNxa9cIO7JLI8+2vzY7sr6IXWs
         INDCyzwkjX7MYDdtmfTXbb5lNbJJyUd8EAH+GUZn1TLJlwfVj3XfqpdzLvewFUhWegbJ
         houyxh19vsOHE3ucUTuT46UASQcLmznDmqjYrOFDtNM4GdWzVpPFJaAnG+iJTZcL5I6+
         43i7B8ennRgMwdU1GhdIbMex7AT/IqbwGF5F6KAHYkjL+3inuUfXyYPZ2WU77m7wvmrV
         tX0DqNdR/hSNUqoZYQjeE3p3Usu63AK42R4NCObpWHhSI0UjKEhpWhjgROxcziVYmWdo
         5M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454757; x=1773059557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=UEk77e3srMh3NFCZyHh6Stl7txNK3zDdgUAOE9sv5O25ZKWr5HrZmq2ZPK5shYijIu
         naCWAFEuC2EO88U0pjtqKJZB80VdzuUiKv+p7Cs/pbMtvPDHtzsZiTWQqTh/Lq1467gO
         1Wl708aVfyGGLOM6J9r3okmlPzQ/lmB1OgwvvM7HhJzND3Uf9LqNw7Ax+Jdcw25Y7/Pr
         ReoYYTMjQO6v8cK+7Ael+MylBINrGQQBGqoikZfzNQKr3npyI2Y8eOgrXNAVqTzAKa04
         41hWvMBV0hszsfjS8tm2OKtvtc1lHkQfrd+Q70x4ZQ1UIHMzq3f/BnvuoLLexJxmbnU2
         DjPw==
X-Forwarded-Encrypted: i=1; AJvYcCWbJ11UPDNdKLKkYVy7uz2B6ZevUhy26WhgXiZah6SetTEjovXGjp0eqyMeRgIe3/pJZXGhZFnx+fviUpCD@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDEo6IvqMgjkJCRHdGZZEodcsf27Mazm0FtWUHMF32h37dZNz
	c1vCdOFIWX5i6LSia1UM1HgYHJdsZDbC+p/NNgXY35Brq1YTRkwr4m41Ka53xUJYYBoH21GTF/g
	zhj8LonsKQJtdtu9X4a1ivxx22oB2s6c=
X-Gm-Gg: ATEYQzxkeomaeYLk4li+0rD6RS2iMF2FPEWfBIjJMFN2yurqRL8BW5zhCQwH8i9c5BO
	+DtmsPnh4ACPPD4TrQEq2Zcs4H1x5flBJ7Y/ve6QRULlwsrU8MYfSuDCxXzWVII71k9h8gtU07+
	9aks8ckl1APzMMEuyNQZNLcMSdKcpBxsXsDPXBQj/E4hLAauDb12HtCCdt7LoyfT4uHMLeRX4Gh
	2cUEka58yf/7kl01g2HhXNfWYWXkNRlTj4EkZzrUxgOPr5dGtsQ5zwd/gWlioMfC7vbU3J4Y1Iw
	fth9+9Sfa6XxAo/qi7pNwn0V7LRfyG6q3qcSJIt4TICdExlDoLvpYwQssye+hyz4R9UWai07pg1
	Q5YKpLnEdnt5x1VTOaiL78TlwnifQ
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr221836eec.4.1772454756603; Mon, 02 Mar 2026
 04:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org> <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
 <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net> <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
 <p7rsBPaYxHKSMFCYVUFY5hdI1H6jxHK0s7lxLQkqH4rylM6yS03Yt52SCjiTO5qBVUmc41ZHZ7XZ0_3w_U-O0g==@protonmail.internalid>
 <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net> <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 13:32:24 +0100
X-Gm-Features: AaiRm52T7cw5MIQan-WghpnUecgDLtb8HLJUgWIjNNPX7ugGbu9wZy-93BfirNw
Message-ID: <CANiq72k_c06P4_JVDCNmwu8SwCUP3UjofLCAsovBVzQi=fb6CA@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78888-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: ADBEB1D8DCA
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> I was thinking something similar, in clippy or checkpatch.pl. If we
> should always have this attribute for small functions, we need to have a
> check.

No, as Gary said, we do not always want to have it.

So something trivial in `checkpatch.pl` or something like the existing
Clippy lint would have quite bad false positives (and even false
negatives, in the case of `checkpatch.pl`, depending on what logic you
are thinking about).

We would need cross-TU heuristics for this, because at the end of the
day what you are trying to say is "this function will end up being
trivial even if it may look like it doesn't before inlining
everything".

Cheers,
Miguel

