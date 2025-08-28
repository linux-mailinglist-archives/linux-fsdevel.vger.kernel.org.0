Return-Path: <linux-fsdevel+bounces-59477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC0DB39A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E90FA00515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1B30C61A;
	Thu, 28 Aug 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDJxVeHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471B30C61E;
	Thu, 28 Aug 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377327; cv=none; b=BADetERT3AeDGvtNVrsgViETJJ26MNXTrMzLDTkUxFIKwKoJaKe5dZ2OqDADuonODzN6haWLy7Qp1IGqIsf81Q5J0+HEQ559m1PtP+Zbjz/oBezY1ufqyogSv/hLvUdAqvh1Wz/gq3pakcPEhTbrBtTc8NBKc2jvDM+7ND6iFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377327; c=relaxed/simple;
	bh=eW2yAjPFiJAtzvQcyoVx75C1Sq4LDyiD/8jgLsKqJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMdaYWaL/4CFC3ZFBYif3+/gAS5Pzdnf7d5w7Pco5eDAiCUlwv0/eGzhVRVyyHEq7pP9UhObWRL0iMO6TWiaA+9GxCeEH+zE4qBy8pI4DQ1HtfavsGhOQa1nFlrTTjxUIHS+adDkDhkFW1PyBzrpGC3j+BBWNZZdTxP+82Z+PMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDJxVeHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629FDC4CEF5;
	Thu, 28 Aug 2025 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756377326;
	bh=eW2yAjPFiJAtzvQcyoVx75C1Sq4LDyiD/8jgLsKqJOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDJxVeHNKI0qoYj8uANT198DfRATKzRO9ozcedIzYgoMYh0RlpRI79TbphVPB0eJt
	 2MecyNDOBKJ8nHIR65BXb3Uykcajgot0Y5Q9vV4n+rLaTpHQ6VL9oZ3pLPIyE6OzK9
	 zG5eUyJy62HqpPhDoXnI8Y1hrrXj8Ge77vWkvnehWNwiNFu39SJKuXYai1DWStshNo
	 L+3gEVtMXHE+P9cxE2IhVgKfsgKlxAMgf1VWLsUVLf+nuial1eUxqmuc6jDT/aID8j
	 Ru+MndbZXxH4AT7FhYMcbNdhz4t06qAaGVLoWzC2zBo24bfFWpXUKuIL8glkauhugp
	 FpSgukPr/ep8Q==
Date: Thu, 28 Aug 2025 12:35:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 53/54] fs: remove I_LRU_ISOLATING flag
Message-ID: <20250828-inklusive-glossar-1ec2e3ed79d2@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>
 <aK-iSiXtuaDj_fyW@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK-iSiXtuaDj_fyW@dread.disaster.area>

On Thu, Aug 28, 2025 at 10:26:50AM +1000, Dave Chinner wrote:
> On Tue, Aug 26, 2025 at 11:39:53AM -0400, Josef Bacik wrote:
> > If the inode is on the LRU it has a full reference and thus no longer
> > needs to be pinned while it is being isolated.
> > 
> > Remove the I_LRU_ISOLATING flag and associated helper functions
> > (inode_pin_lru_isolating, inode_unpin_lru_isolating, and
> > inode_wait_for_lru_isolating) as they are no longer needed.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> ....
> > @@ -745,34 +742,32 @@ is_uncached_acl(struct posix_acl *acl)
> >   * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
> >   *			and thus is on the s_cached_inode_lru list.
> >   *
> > - * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> > - * upon. There's one free address left.
> > + * __I_{SYNC,NEW} are used to derive unique addresses to wait upon. There are
> > + * two free address left.
> >   */
> >  
> >  enum inode_state_bits {
> >  	__I_NEW			= 0U,
> > -	__I_SYNC		= 1U,
> > -	__I_LRU_ISOLATING	= 2U
> > +	__I_SYNC		= 1U
> >  };
> >  
> >  enum inode_state_flags_t {
> >  	I_NEW			= (1U << __I_NEW),
> >  	I_SYNC			= (1U << __I_SYNC),
> > -	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
> > -	I_DIRTY_SYNC		= (1U << 3),
> > -	I_DIRTY_DATASYNC	= (1U << 4),
> > -	I_DIRTY_PAGES		= (1U << 5),
> > -	I_CLEAR			= (1U << 6),
> > -	I_LINKABLE		= (1U << 7),
> > -	I_DIRTY_TIME		= (1U << 8),
> > -	I_WB_SWITCH		= (1U << 9),
> > -	I_OVL_INUSE		= (1U << 10),
> > -	I_CREATING		= (1U << 11),
> > -	I_DONTCACHE		= (1U << 12),
> > -	I_SYNC_QUEUED		= (1U << 13),
> > -	I_PINNING_NETFS_WB	= (1U << 14),
> > -	I_LRU			= (1U << 15),
> > -	I_CACHED_LRU		= (1U << 16)
> > +	I_DIRTY_SYNC		= (1U << 2),
> > +	I_DIRTY_DATASYNC	= (1U << 3),
> > +	I_DIRTY_PAGES		= (1U << 4),
> > +	I_CLEAR			= (1U << 5),
> > +	I_LINKABLE		= (1U << 6),
> > +	I_DIRTY_TIME		= (1U << 7),
> > +	I_WB_SWITCH		= (1U << 8),
> > +	I_OVL_INUSE		= (1U << 9),
> > +	I_CREATING		= (1U << 10),
> > +	I_DONTCACHE		= (1U << 11),
> > +	I_SYNC_QUEUED		= (1U << 12),
> > +	I_PINNING_NETFS_WB	= (1U << 13),
> > +	I_LRU			= (1U << 14),
> > +	I_CACHED_LRU		= (1U << 15)
> >  };
> 
> This is a bit of a mess - we should reserve the first 4 bits for the
> waitable inode_state_bits right from the start and not renumber the
> other flag bits into that range. i.e. start the first non-waitable
> bit at bit 4. That way every time we add/remove a waitable bit, we
> don't have to rewrite the entire set of flags. i.e: something like:
> 
> enum inode_state_flags_t {
> 	I_NEW			= (1U << __I_NEW),
> 	I_SYNC			= (1U << __I_SYNC),
> 	// waitable bit 2 unused
> 	// waitable bit 3 unused
> 	I_DIRTY_SYNC		= (1U << 4),
> ....
> 
> This will be much more blame friendly if we do it this way from the
> start of this patch set.

Thanks. I had this locally a bit differently but I just change it to a
comment.

