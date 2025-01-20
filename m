Return-Path: <linux-fsdevel+bounces-39705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C1BA171AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51BC3A583F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267311EE7CE;
	Mon, 20 Jan 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1/nKefm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267D1E3DFC;
	Mon, 20 Jan 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393945; cv=none; b=PQ1O64GV/BfILH4By3yJTgOa7vm0XQ5txLIHoGiLeqGeLNG/HSFxPjj2r0iwQBUW160UUaqOlKpg4E0Z9DetKcshslMDuwe3ntauNbBNGDWWuZhX3YWLRYxPN46vYD9THrKscCXrmZ06ShdxF0R+bE9rZXbYTsflzZA5J9IKOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393945; c=relaxed/simple;
	bh=tm2jtvGigO2Ni9vWg0UsoQFDqCOp4nm4RD/2KqLUasA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISXIhZwz/Q5RJBbsyyVHFCHba70IswOjg1/bUCNlnOK+PjHn4rNy4Ff4xnk8zArsBueYUAlOPZDyijTMts9gpiLlxwDoUyN8fOQsxI239g/6R8ow1+hjv8PwNbHriA0cBZn9FOhjnnfUD9Nq12BNRKl59yv05XgGY+twbnzZ6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1/nKefm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3442C4CEDD;
	Mon, 20 Jan 2025 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737393943;
	bh=tm2jtvGigO2Ni9vWg0UsoQFDqCOp4nm4RD/2KqLUasA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1/nKefmis7byrisGvP3pL1mFyvczwCIt2KfRd3R8Xb9piYhmi807q/TxrFUY8afn
	 OVA6B1vzM+tbS9zbMFPjGzks8BntLSxM2b17eY47BNglVCVB4e0o846UvcqaxcjR1u
	 5+Hss3d2TgKMc2Vy0waJCJZbVKAw4GdbwgHJMhcyewaam2d2sQIQtppeQ+kPT61fOh
	 sSn+Jmsg18BJAFK31WO34KKpDZdNjhGkv3weIT+8iDUMTUjGycpRbowp3VPUhOXSjV
	 n1bY8F7A9/zbDiLvcsyN3wH356f6qYF8FKASn/TllUonPOMJorzm2Jr55I4mx73jJl
	 uAyQj5VTu/3Jw==
Date: Mon, 20 Jan 2025 09:25:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, fstests@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Message-ID: <20250120172542.GC1159@sol.localdomain>
References: <1201003.1737382806@warthog.procyon.org.uk>
 <1113699.1737376348@warthog.procyon.org.uk>
 <1207325.1737387826@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207325.1737387826@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 03:43:46PM +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > However, in this case (in which I'm running these against ceph), I don't think
> > that the find should return nothing, so it's not a bug in the test script per
> > se.
> 
> Turned out that I hadn't enabled XTS and so the tests for xts(aes) failed and
> produced no files.
> 
> David

AES-XTS support is mandatory for fscrypt, as is documented in fscrypt.rst.  The
filesystems that support fscrypt select FS_ENCRYPTION_ALGS, which has "imply
CRYPTO_XTS" and "imply CRYPTO_AES".  As explained in the comment just above it,
the reason that it's "imply" rather than "select" is so people can disable the
generic implementations of these algorithms if they know that an optimized
implementation will always be available.

It would be enlightening to understand what the issue was here.  Did you
explicitly disable these options, overriding the imply, without providing a
replacement?  Or was this another issue specific to unmerged kernel patches?

- Eric

