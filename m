Return-Path: <linux-fsdevel+bounces-56813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49102B1BFFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA9118A1BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8B1F7586;
	Wed,  6 Aug 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p7nvMnp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEE1F0E2E;
	Wed,  6 Aug 2025 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458883; cv=none; b=CR/FMfpfvGGSLuFtLidZCH4CqjH2ZrYpLuS2RRca3G/xtKPsnwPOLqchZjQqqs1TQIZXgUuYsYUHpJKMzesxhiy7DDPo2Qv5KHgbzRftwZqd7OdbNyZE88W4QUcKQv5DQ6vxs4pHv8wvligfThryi70/jH9zOizaNOWIDSyPfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458883; c=relaxed/simple;
	bh=CbrAc24voAonq0FxpUx0tqtAhEUeTM8bhqXy0ZlxRVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djUcBHaiU8TWdjrRyrtyrWi44CSPbQF2LGQCvvv50Q8d6UQ+R/pnZleMPICD07JZUewauPGM7xMn6yKo3LGFjiWxjWSO69a7lJyazZTi+mnu1FY7IxCvb1ExdKv7KWt+hS2K9KosFedTvfs9Ptq5otLIYPiwpkh9vP35+JonBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p7nvMnp7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3yF6x2WBzThIcjPuCPFKf/OWhZAB96WeFUkccy9IgHg=; b=p7nvMnp7TvqD920RDWePn0O7Ki
	dw4cgVlWnYLPxDHzaNyanuIMdltSPUU29BYruUN+kykZUhLSyqxTAcLJc+LsrfY80fxtUZt2JDbCC
	BM3mJKNuEUM97xc0ZcLPzYGM6F7yLCIV1ob9JTZUWy5k8dczHLekbg654xEf0KA+RqwdR3Jw/WPzJ
	RI9CqZYzm6/rNA66jYMdFweP++9Ed1uqEGDeyDLrMvQ17loRmUQ5bKV9phou3y00CtOzA/Zlv/s7Y
	q/udf6zL5SxAX9Mb5FxkEJ3oP0EkxD8//O7hTi6fgpj4lwpTw9g9vIEi+4YP4SosY5nT3BhSYoe0Z
	Wb0E64Uw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujWto-00000008jxW-3kKy;
	Wed, 06 Aug 2025 05:41:17 +0000
Date: Wed, 6 Aug 2025 06:41:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: output mount_too_revealing() errors to fscontext
Message-ID: <20250806054116.GE222315@ZenIV>
References: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
 <20250806-errorfc-mount-too-revealing-v1-2-536540f51560@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-errorfc-mount-too-revealing-v1-2-536540f51560@cyphar.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 06, 2025 at 02:48:30PM +1000, Aleksa Sarai wrote:

>  	error = security_sb_kern_mount(sb);
> -	if (!error && mount_too_revealing(sb, &mnt_flags))
> +	if (!error && mount_too_revealing(sb, &mnt_flags)) {
>  		error = -EPERM;
> +		errorfcp(fc, "VFS", "Mount too revealing");
> +	}

Hmm...  For aesthetics sake, I'd probably do logging first; otherwise
fine by me.

