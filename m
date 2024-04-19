Return-Path: <linux-fsdevel+bounces-17273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B78AA738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A22A1F2167D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 03:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EFAB66C;
	Fri, 19 Apr 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="zfvMzZ2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD2EC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497432; cv=none; b=UtDRjnpkl/rF05kwRnwzCJD4OK4zbdMeQdFWRoErIEcHTT99cvdqpfFzqjydh14apX7a7dQkcqEor3G4NStLPkMKNuB3IuQo7wklqhfuVnadPg2Jqt+g5I2OOgp0ym/Aykjj2FRtxYf4Jyovsu6cHPQaC3+rlMkRbZ9oddcWLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497432; c=relaxed/simple;
	bh=mnvukGsXXcqSK9FQIb1/hwawkxVofpm0mLfqVVBnsJ4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEf6s92Jv7yHhzXm0pLXvkWGgXQDPJFPPi9VMns0jr8NmMrLN02ZTQYMy9V0ieFNkyxSxsB69fHYirtIAj9obLuqJG2MwqGrueuTMSARvbfd++yuMGKgabc11Mi1qaFrgB95ncT7G1QUTyqXZyzAkqwdI+/svD2aSwOoQ0pbTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=zfvMzZ2v; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713497426; x=1713756626;
	bh=mnvukGsXXcqSK9FQIb1/hwawkxVofpm0mLfqVVBnsJ4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=zfvMzZ2vr9eFwBBBoG7oLOxuas360+BHB9A8LaGmhqVzb1Pni0L1uE4SXTJ8Z+S50
	 VxSwEvTj6xpPrDoLoz5aI5T1c4NCP1H8RVckCoaFs0QnqyuqJ7y0yEQGYfBHJEWV0K
	 smsjzHK6uibVFy59l6WzSa4jR3/jFOuEFSlOSprsb29VVHsf3WZy3FfiQiEFn/4AYN
	 scHyyp4EzoSjevQ/A1kh8zzwwfsZIO8Umn63vkuXxP+cfMbAnViEMOPO7TdIgnByDX
	 4FkFXDTIjb9YGdLn2KuylkDdKptZ3CQRDnTUekNRxAXBYOp5TevdDkdUKdkZigQFgz
	 KxPBOk9Cuedtw==
Date: Fri, 19 Apr 2024 03:30:21 +0000
To: The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
From: Antonio SJ Musumeci <trapexit@spawn.link>
Subject: Re: EBADF returned from close() by FUSE
Message-ID: <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link>
In-Reply-To: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: 580955c485f6629bcc11b6b1d5177881a1bbcb73
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/18/24 17:10, The 8472 wrote:
> Hello, first time mailing the kernel mailing lists here, I hope got the r=
ight one.
>
> I'm investigating a bug report against the Rust standard library about er=
ror handling
> when closing file descriptors[0].
> Testing shows that a FUSE flush request can be answered with a EBADF erro=
r
> and this is surfaced to the close() call.
>
> I am asking if it is intended behavior that filesystems can pass arbitrar=
y error codes.
>
> Specifically a EBADF returned from close() and other syscalls that only u=
se that code
> to indicate that it's not an open FD number is concerning since attemptin=
g to use
> an incorrect FD number would normally indicate a double-drop or some othe=
r part
> of the program trampling over file descriptors it is not supposed to touc=
h.
>
> But if FUSE or other filesystems can pass arbitrary error codes into sysc=
all results
> then it becomes impossible to distinguish fatally broken invariants (file=
 descriptor ownership
> within a program) from merely questionable fileystem behavior.
> Since file descriptors are densely allocated (no equivalent to ASLR or gu=
ard pages)
> there are very little guard rails against accidental ownership violations=
.
>
>
> - The 8472
>
> [0] https://github.com/rust-lang/rust/issues/124105

I can't see how the kernel could meaningfully know of or limit errors=20
coming from the FUSE server without compromising the nature of the=20
technology. So in that sense... yes, it is intentional.



