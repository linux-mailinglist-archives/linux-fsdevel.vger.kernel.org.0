Return-Path: <linux-fsdevel+bounces-49846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BFAC4110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD677AC161
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479620E03C;
	Mon, 26 May 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="guR0u6n7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94C1F37D4;
	Mon, 26 May 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268662; cv=none; b=BjJODYn0cgoZMQV3FODAoa3ZrcU8gr836nkYWID8PKniXWx8nWbTqBWYi2m9qvjQU0H5xQ6tzrYw7QtyJ4OIF7iola4+eEjl6ZbQQbR0v4CO5oSEzZqq15DWmpz30bFPNJEPDB+e8HYiPiYtyV6ttjxZf3m6S12HDLyXFgO8TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268662; c=relaxed/simple;
	bh=gYcdd8zQYK4yxRqvoa/IEnerv4qEycslK+MR5UzDiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtgW9AAkxNzpPcfrVLUJAGiqjgRYcIFx1hFEFDijGCu2hkW8O7M8KZVtJ7R+oGCqjFm2vFpfIxrz9iqdgMJP+7CKGpc4xRkdcuHPT3dI2wKbZFwSDKxN9Qv+TcbwfA+ufbgt/sQyMm8Jk7S5XFqcOuXhHiozo3B38tlqBP30Qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=guR0u6n7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UetEMwiMoH1A6Y8Vrz32m9ArHm8OKszsQTk5vGdJS2I=; b=guR0u6n7RSW5StMI5evhMBMWZx
	Emhji3jaZQ48QA35SS69TRyzV3IfkTTZhxah8xzT8qI4LAwd3wIXU5nfsDaN0XbmoCUwFERqgagAM
	DbxmmmMEtS/KQkcXwesfDPdgtCOKcfNIjZNE1Hg2fAs7BJ7FeOZs/+hQavlvrxKy2kAtlxVOq0Tr7
	kr2h0VlnA5zHY+B1xwVjbtfGn4U+Des1IKXUyhIFdWdbmPqF5qDkmOY7FVdeL2DbBnseFMIGB3A5l
	g6zjpHKukBWB4htGOXDyUsOrREQ8jaav43QtgS7f1OdPL0N8Sj2cMjq/08FNY1dBKdgxihCnKepuq
	8pLo7Awg==;
Received: from 179-125-91-139-dinamico.pombonet.net.br ([179.125.91.139] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uJYXR-00DKxj-1E; Mon, 26 May 2025 16:10:49 +0200
Date: Mon, 26 May 2025 11:10:42 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: do not convert when writing to memory map
Message-ID: <aDR2Yvy39Q-XgeAB@quatroqueijos.cascardo.eti.br>
References: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>
 <20250520145708.GA432950@mit.edu>
 <aC5LA4bExl8rMRv0@quatroqueijos.cascardo.eti.br>
 <ixlyfqaobk4whctod5wwhusqeeduqxamni6zkxl2wdlbtcyms2@intsywwjfv25>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ixlyfqaobk4whctod5wwhusqeeduqxamni6zkxl2wdlbtcyms2@intsywwjfv25>

On Mon, May 26, 2025 at 03:43:31PM +0200, Jan Kara wrote:
> On Wed 21-05-25 18:52:03, Thadeu Lima de Souza Cascardo wrote:
> > On Tue, May 20, 2025 at 10:57:08AM -0400, Theodore Ts'o wrote:
> > > On Mon, May 19, 2025 at 07:42:46AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > > inline data handling has a race between writing and writing to a memory
> > > > map.
> > > > 
> > > > When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
> > > > destroys the inline data, but if block allocation fails, restores the
> > > > inline data. In that process, we could have:
> > > > 
> > > > CPU1					CPU2
> > > > destroy_inline_data
> > > > 					write_begin (does not see inline data)
> > > > restory_inline_data
> > > > 					write_end (sees inline data)
> > > > 
> > > > The conversion inside ext4_page_mkwrite was introduced at commit
> > > > 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
> > > > fixes a documented bug in the commit message, which suggests some
> > > > alternatives fixes.
> > > 
> > > Your fix just reverts commit 7b4cc9787fe3, and removes the BUG_ON.
> > > While this is great for shutting up the syzbot report, but it causes
> > > file writes to an inline data file via a mmap to never get written
> > > back to the storage device.  So you are replacing BUG_ON that can get
> > > triggered on a race condition in case of a failed block allocation,
> > > with silent data corruption.   This is not an improvement.
> > > 
> > > Thanks for trying to address this, but I'm not going to accept your
> > > proposed fix.
> > > 
> > >      	    	 	       	       - Ted
> > 
> > Hi, Ted.
> > 
> > I am trying to understand better the circumstances where the data loss
> > might occur with the fix, but might not occur without the fix. Or, even if
> > they occur either way, such that I can work on a better/proper fix.
> > 
> > Right now, if ext4_convert_inline_data (called from ext4_page_mkwrite)
> > fails with ENOSPC, the memory access will lead to a SIGBUS. The same will
> > happen without the fix, if there are no blocks available.
> > 
> > Now, without ext4_convert_inline_data, blocks will be allocated by
> > ext4_page_mkwrite and written by ext4_do_writepages. Are you concerned
> > about a failure between the clearing of the inode data and the writing of
> > the block in ext4_do_writepages?
> > 
> > Or are you concerned about a potential race condition when allocating
> > blocks?
> > 
> > Which of these cannot happen today with the code as is? If I understand
> > correctly, the inline conversion code also calls ext4_destroy_inline_data
> > before allocating and writing to blocks.
> > 
> > Thanks a lot for the review and guidance.
> 
> So I'm not sure what Ted was exactly worried about because writeback code
> should normally allocate underlying blocks for writeout of the mmaped page
> AFAICT. But the problem I can see is that clearing
> EXT4_STATE_MAY_INLINE_DATA requires i_rwsem held as otherwise we may be
> racing with e.g. write(2) and switching EXT4_STATE_MAY_INLINE_DATA in the
> middle of the write will cause bad things (inconsistency between how
> write_begin() and write_end() callbacks behave).
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks, Jan.

I later noticed as well that writepages is not holding the inode lock
either, so there would be a potential for race condition there as well.

I have sent a v2 that I find would not have this problem. But we should
probably cleanup the handling of inline data in writepages as a followup.

Cascardo.

