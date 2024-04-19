Return-Path: <linux-fsdevel+bounces-17315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44F8AB5E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1881C20B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA27013C9C4;
	Fri, 19 Apr 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="G3ILpE9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11210A03
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557282; cv=none; b=gcib+8mqSnjCuILAFYnDmiywg2uVYX7uQqz/hpayPD+EyRuR0aKLzssLTeCwjmybJsMDV7t7Jcs+IFoE7RVNJQRvkyo/3q9O/7tyAVd7YbpfBZHkcLuy1APpvM6UtK0EJXInfgm/DwbqauC4JYQ0YSGBD0EZJPvOaEuRL8Qpbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557282; c=relaxed/simple;
	bh=Yol23ZQg+bpIqT9H+ZpdTB5UDVWLwncEFyoUAWA/QC4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjthweqEqpP5x6DV1EYwo7xsAyyu1y0ZIQMT1kRJJL7OiOohIqExDXRnqC1P45nTWhDCqJ+Ua5U6GCUxpA/CgPJj6F2mEXviNhKcvcsyL+mHZD4quCBcdbwCMoWF+IXDPRrLMi8WoKm6XLi/q5Yi3fxxbJS/mdiPL59bnVgouxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=G3ILpE9v; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713557276; x=1713816476;
	bh=Yol23ZQg+bpIqT9H+ZpdTB5UDVWLwncEFyoUAWA/QC4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G3ILpE9vA4YdOLOyCY9Yh+E3SjYk9d+eA1GJcWOTjZEPh91ydarh3iQfdQGzZV7rk
	 LMqYfV0y4zN6Li9YDuKcdkO3V+1RdRSJCgcsbH/7cxGzV4BfTuZzvh1hM0Y7aPvytq
	 w8ig5FxbYZofRzanzOG7w5ZReY+1ZBUaKWxQq66bnKR7VTFmTQRcsIycoomg7rWVMz
	 rcPf4TqBFJJNO/hw8Ho9nMJOrGwNhYEjDPBRFu8/Xt+k8U5fXEyemVm1GByedXPAaq
	 w6pNPR9QMz8/r2QW6zGCqLeNn+ZsE5aL2HOmLQCRBxJDwq6cjhMzLJCNpZfYu/DptL
	 bVebuzACQ8viQ==
Date: Fri, 19 Apr 2024 20:07:50 +0000
To: The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
From: Antonio SJ Musumeci <trapexit@spawn.link>
Subject: Re: EBADF returned from close() by FUSE
Message-ID: <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
In-Reply-To: <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de> <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link> <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de> <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link> <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: 89101a70c988a22b9328dfa64acf7eb42216ff18
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/24 13:18, The 8472 wrote:
>> Errnos are not *really* standard. They vary by
>> kernel release, different OSes, different libcs, different filesystems,
>> etc. As I pointed out recently to someone the use of EPERM to mean a
>> filesystem doesn't support "link" is not defined everywhere. Including
>> POSIX IIRC. And given FUSE is a cross platform protocol it shouldn't,
>> within reason, be interpreting any errors sent from the server (IMO).
> FUSE can send any errnos it wants over its client-server protocol.
> But the kernel could still translate them to error codes that don't
> have a documented meaning for a specific syscall.

No one is talking about or cares about the protocol error handling. That=20
is private to the protocol. What matters is what FUSE kernel side does.

And I'd disagree with you because as I tried to point out that=20
"documented meaning" is not set in stone. Things change over time.=20
Different systems, different filesystems, etc. treat situations=20
differently. Some platforms don't even have certain errno or conflate=20
others. Aren't there even differences in errno across some Linux archs?=20
This is just a fact of life. FUSE trying to make sense of that mess is=20
just going to lead to more of a mess. IMO EIO is no better than EBADF. A=20
lot of software don't handle handle EXDEV correctly let alone random=20
other errnos. For years Apple's SMB server would return EIO for just=20
about anything happening on the backend. If a FUSE server is sending=20
back EBADF in flush then it is likely a bug or bad decision. Ask them to=20
fix it.

And really... what is this translation table going to look like? `errno=20
--list | wc -l` returns 134. You going to have huge switch statements on=20
every single one of the couple dozen FUSE functions? Some of those=C2=A0=20
maybe with special checks against arguments for the function too since=20
many errno's are used to indicate multiple, sometimes entirely=20
different, errors? It'd be a mess. And as a cross platform technology=20
you'd need to define it as part of the protocol effectively. And it'd be=20
backwards incompatible therefore optional.




