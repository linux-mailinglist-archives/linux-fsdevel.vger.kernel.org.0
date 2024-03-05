Return-Path: <linux-fsdevel+bounces-13567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5492871174
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AECB236ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E91373;
	Tue,  5 Mar 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HRvKBAcw";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HRvKBAcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEE7F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597501; cv=none; b=hDNEKKhbdnGy+cwJOwihvliRMFcyYbZygLNIL9mSH7s+vh4fBitOKctbB9iYuPANcd/UOfPtWUTcmePqD6pqrxdlEIiIIPxWTux+d5YE6ZoRMha8r/Yi7MDHCZqqnv2UPHPThwH6ra205/bm2kGKkIF2uepcipAaJEhoTByldq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597501; c=relaxed/simple;
	bh=OlF+yyYMhqZggaFe7ddFTz/KyKxyQjUor3Wr0AU9YRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJTyUuZCLi048OP8wJ60aMPEVcq+WmtsajoRhgyGjMMG7qNi7yO6NYSSgpt6unCB7B8VJ7Wtdiyhl8gkYGB415UcYFEvZRKUuKL5inryfFDyJjXW699kBbBOB50FUfL5Hs6eHOw09rCwA/QurbdlT4X0sXYUD9I9oWrWovYikH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HRvKBAcw; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HRvKBAcw; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 7EAB3C01D; Tue,  5 Mar 2024 01:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709597496; bh=1Rm1gUDcBjfsdBpilpf2D3iy6dxrLRTRCJClg1P8GOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRvKBAcw0EWoz4bEu4yu9jHSaAYgWeIGR6SannCALbZDe9xbueQpUJjdGWen1TF+U
	 jidGEDKgXaSFzPRqE2lEPyCvTakl/CXto2p+3x25y+IRxQNqu3VDi9CtwkopczCZMe
	 TmAZQNqsGWY3wjIXGJ0nDkUrl/011CFjcUzewTQrUe9kCSYvYgNXAd7oXw6vSQYIAR
	 Mqxt5DKG++LkCuBbChA2p/k8RVuavvLClt2iqa1uAsZBsE8RAeXOMGhh7txicaF/e9
	 ho4ujqpQQH+HLgJLkneA11eNsjruoHAIfpk6sDuSYBoHZX3KTqJPRjvRGQjwZaUKkv
	 I1Yfa+3LsmZHA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 87722C009;
	Tue,  5 Mar 2024 01:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709597496; bh=1Rm1gUDcBjfsdBpilpf2D3iy6dxrLRTRCJClg1P8GOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRvKBAcw0EWoz4bEu4yu9jHSaAYgWeIGR6SannCALbZDe9xbueQpUJjdGWen1TF+U
	 jidGEDKgXaSFzPRqE2lEPyCvTakl/CXto2p+3x25y+IRxQNqu3VDi9CtwkopczCZMe
	 TmAZQNqsGWY3wjIXGJ0nDkUrl/011CFjcUzewTQrUe9kCSYvYgNXAd7oXw6vSQYIAR
	 Mqxt5DKG++LkCuBbChA2p/k8RVuavvLClt2iqa1uAsZBsE8RAeXOMGhh7txicaF/e9
	 ho4ujqpQQH+HLgJLkneA11eNsjruoHAIfpk6sDuSYBoHZX3KTqJPRjvRGQjwZaUKkv
	 I1Yfa+3LsmZHA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ed2e7d9e;
	Tue, 5 Mar 2024 00:11:29 +0000 (UTC)
Date: Tue, 5 Mar 2024 09:11:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: 9p KASAN splat
Message-ID: <ZeZjInbYNkpLPPkz@codewreck.org>
References: <D56DE98B-F6F1-4B38-A736-20B7E8B247FE@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D56DE98B-F6F1-4B38-A736-20B7E8B247FE@oracle.com>

Hi Chuck,

Chuck Lever III wrote on Mon, Mar 04, 2024 at 05:29:24PM +0000:
> While testing linux-next (20240304) under kdevops, I see
> this KASAN splat, seems 100% reproducible:

Thanks for the report -- there's already a fix for it but we've been
sitting on it for a while, sorry:
https://lkml.kernel.org/r/20240202121531.2550018-1-lizhi.xu@windriver.com

I've pinged Eric yesterday to take the patch as the problem is in his
-next tree; hopefully he'll be able to have a look soon but until then
please apply the patch directly.
-- 
Dominique Martinet | Asmadeus

