Return-Path: <linux-fsdevel+bounces-49599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E5ABFF2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F046A4A0C42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020E239E71;
	Wed, 21 May 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XxLm6lkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D072B9A9;
	Wed, 21 May 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864348; cv=none; b=hfUFyoEt7h+ZqMRTJ4PR6OiJEMZpxTQ6FSCQGcM4n63tzpGuEMujV9rnsiigmaMEO+9ha9FxkniJv38rGZUq35vL7X1MdTeTWC6+W8Yd5MSL88qqO4arANCk2oRhtzwf/m3caYU/HnmNiaaYof3I/OFxEO0WtOAWc3p+VUvu37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864348; c=relaxed/simple;
	bh=a3021qwGd8op6QYBd5F7OHz3L8PCT3uP7zLUWiXVI5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyBQOHl+PSe0eqjG2Lq1fNEmDVWK/6r8dtI9irdEM70GgwDCMXsEaNmZ6KmJAJwF2RwmkRhoHMpmmm6LiVVT+MoGrAMCoVq1Zwh6655geyuMqUcqXXzGIL+2BRFKGQrEu5ZAf9hniNCbviv6j72b2uVx4O0c+9JPVY4I5fQlee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XxLm6lkX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C3UN8ZJE9PxOxCNtZinTl54gTvEE+thRSkGHKOq3odE=; b=XxLm6lkX3HBiixB8EwVsdVQ5hy
	PCVmaSr4nGv9/9ONPS/gyNA05XUBlgLSajDRiGLXQ1H97nzPhVJUguP4CsZmFbNM891lnz6pK2OgM
	ZW4feJz5rB9gIIhxsAI1ZBNanoBtgFbk2HNr1rAAy5JUSYadaLymHSKKb8qPlZfZnFAo49/hBnEJU
	1SbAueK7mrR6NGo8C7jmkeK5eMt6vR67iqssztAeTYmwFtORhjqTCRq5liE9yT3nY3IGZFJ314hw3
	1QJTi2w0yZbTAf82NLYsmklQxL6ODLHH5eSbG/ohf5PXAZ+1odMC+u01oW8J5G+df9gCSdW1py+Eu
	94QkwiqA==;
Received: from 179-125-70-180-dinamico.pombonet.net.br ([179.125.70.180] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHrM9-00BPwH-Lr; Wed, 21 May 2025 23:52:10 +0200
Date: Wed, 21 May 2025 18:52:03 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>, Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: do not convert when writing to memory map
Message-ID: <aC5LA4bExl8rMRv0@quatroqueijos.cascardo.eti.br>
References: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>
 <20250520145708.GA432950@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520145708.GA432950@mit.edu>

On Tue, May 20, 2025 at 10:57:08AM -0400, Theodore Ts'o wrote:
> On Mon, May 19, 2025 at 07:42:46AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > inline data handling has a race between writing and writing to a memory
> > map.
> > 
> > When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
> > destroys the inline data, but if block allocation fails, restores the
> > inline data. In that process, we could have:
> > 
> > CPU1					CPU2
> > destroy_inline_data
> > 					write_begin (does not see inline data)
> > restory_inline_data
> > 					write_end (sees inline data)
> > 
> > The conversion inside ext4_page_mkwrite was introduced at commit
> > 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
> > fixes a documented bug in the commit message, which suggests some
> > alternatives fixes.
> 
> Your fix just reverts commit 7b4cc9787fe3, and removes the BUG_ON.
> While this is great for shutting up the syzbot report, but it causes
> file writes to an inline data file via a mmap to never get written
> back to the storage device.  So you are replacing BUG_ON that can get
> triggered on a race condition in case of a failed block allocation,
> with silent data corruption.   This is not an improvement.
> 
> Thanks for trying to address this, but I'm not going to accept your
> proposed fix.
> 
>      	    	 	       	       - Ted

Hi, Ted.

I am trying to understand better the circumstances where the data loss
might occur with the fix, but might not occur without the fix. Or, even if
they occur either way, such that I can work on a better/proper fix.

Right now, if ext4_convert_inline_data (called from ext4_page_mkwrite)
fails with ENOSPC, the memory access will lead to a SIGBUS. The same will
happen without the fix, if there are no blocks available.

Now, without ext4_convert_inline_data, blocks will be allocated by
ext4_page_mkwrite and written by ext4_do_writepages. Are you concerned
about a failure between the clearing of the inode data and the writing of
the block in ext4_do_writepages?

Or are you concerned about a potential race condition when allocating
blocks?

Which of these cannot happen today with the code as is? If I understand
correctly, the inline conversion code also calls ext4_destroy_inline_data
before allocating and writing to blocks.

Thanks a lot for the review and guidance.
Cascardo.

