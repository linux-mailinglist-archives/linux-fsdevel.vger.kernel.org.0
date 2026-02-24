Return-Path: <linux-fsdevel+bounces-78236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJNnChB2nWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:57:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F4618504B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01E61304E75C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA0372B58;
	Tue, 24 Feb 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="o0kJGj2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA536D51B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926995; cv=none; b=PlLvvW+xUzVNneXXQQCZ9hlM9Hd1FCHDPpZhPPB3Ff18aWs01znwNiqv9cv3VJeDlRRg2nOFzsewF1gk9ksoBc/gaLXW6W0Ltm7pHyxxINVya/tPih24PfghNfwXh+RjMLBsj3kbAsLUjoQmHyJhPR/r4bXs2r222q+4+bYkUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926995; c=relaxed/simple;
	bh=5W3fC7k3QTk8rCbVAYdaEo9MIgPGJ+jOAMGnhrvA4a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihduXBT7/kh+TVR6WrGvCPy8V1rXKLdxGnDTSr1cxHY6jgV8dzVclsHDBix8raQrOShVU/a9MLX5aBjU9F9yce+Jd3rpnE1iv0VhbwwBjvIlnDVQgvQeBmekihyEdWmX2gnCYh9rGW8B7tQ6pVybGmu68V2XXGfe9Qlw5dLv5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=o0kJGj2U; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BE3AD240101
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 10:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771926985; bh=D0pOdSaCzjlaD0VH8H60ecB/YDhhbYujFtBI1AQDveE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=o0kJGj2U3F9G4D1rFIrY+55DUCAIKB/bkTNYNcTHHHXPkLAEbkvQ99WflajmqMBz4
	 oRBXbBzzzLVFVDZWHH8WGeXLXf6E7QHVoW/w78VSC8yO4W9wgNlKK+Pku2hYbBi8s2
	 CgvABNM1rYCcvS8rL7yE67kMYToy6kMe/eWjlWccPHCJPyjVPmCfc8HCSBy1bT87Ix
	 EUy4AuQp52V7on7GizXMAACtnEOMIWnFbIijaJm2FioSkU9JLxtwZRtMAUJEEbb5jH
	 Gc33vkcW7d6esXX4DicIewqzf0Kf6DxNgfJKQADfMiIKabgd6M9wkmARyNVuyEXIgZ
	 jreqGjXhEBP1w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fKtQv5X3fz6tw3;
	Tue, 24 Feb 2026 10:56:23 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
  "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
  "frank.li@vivo.com" <frank.li@vivo.com>,  "slava@dubeyko.com"
 <slava@dubeyko.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
  "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
 <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Subject: Re: [PATCH v5] hfsplus: fix uninit-value by validating catalog
 record size
In-Reply-To: <CADhLXY4Of=3ekg86ggi68_VEtYh6qDr-OtfP-D3=4mc9xm0i+Q@mail.gmail.com>
References: <20260221061626.15853-1-kartikey406@gmail.com>
	<9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
	<CADhLXY4Of=3ekg86ggi68_VEtYh6qDr-OtfP-D3=4mc9xm0i+Q@mail.gmail.com>
Date: Tue, 24 Feb 2026 09:56:25 +0000
Message-ID: <87pl5ua2iv.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78236-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43F4618504B
X-Rspamd-Action: no action

Deepanshu Kartikey <kartikey406@gmail.com> writes:

> On Tue, Feb 24, 2026 at 12:28=E2=80=AFAM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
>>
>
>> > +     case HFSPLUS_FILE_THREAD:
>> > +             /* Ensure we have at least the fixed fields before readi=
ng nodeName.length */
>> > +             if (fd->entrylength < offsetof(struct hfsplus_cat_thread=
, nodeName) +
>> > +                 offsetof(struct hfsplus_unistr, unicode)) {
>> > +                     pr_err("thread record too short (got %u)\n", fd-=
>entrylength);
>> > +                     return -EIO;
>> > +             }
>
> The check is in the HFSPLUS_FOLDER_THREAD/HFSPLUS_FILE_THREAD case in
> hfsplus_brec_read_cat() function (fs/hfsplus/bfind.c):
>
> This validates that we have at least the minimum bytes needed before
> calling hfsplus_cat_thread_size() which reads nodeName.length.

Hi,

So... yes, while this is essentially what I recommended, just checking
entrylength against HFSPLUS_MIN_THREAD_SZ will yield the same results,
because:

HFSPLUS_MIN_THREAD_SZ is already defined 10, the same value as the
offsetof chain. hfsplus_readdir() already uses it for the same
guard. It's shorter, consistent with other places and the intent is
immediately clear (easier to read).

Cheers,
C. Mitrodimas

