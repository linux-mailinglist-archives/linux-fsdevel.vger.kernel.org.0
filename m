Return-Path: <linux-fsdevel+bounces-76130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP3TM7iRgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:12:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE0D50F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3239D3011116
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1E36AB53;
	Tue,  3 Feb 2026 06:07:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4927BF93;
	Tue,  3 Feb 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098874; cv=none; b=a6f7WeTm3vGxhmfN/0i4aL1g1hrrmD1zDycPP8Go+xkWvYbg+cWTkdOh2CT3wgn021NGL/JU2sey4iTEaDb1HQ2CuKGMT2QSKJLeW34bgVlYGUwN61XyrFaWpkfFhbXU1FpSl0y8qNeH8TxcdmRduAp5Rl/hlN6epfb4Cx9/Cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098874; c=relaxed/simple;
	bh=1Z231lQsAhz1SAHzJ6XW0H6rSsUy7VIpNvWhs4Cbuag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuWDXdx5DXlHH3T6xc+Aby+TT0cyopLkdvscMDmm8j5wjhFS+tzutinthMarlmE2zLXgZF93nYeP1Bb/be/3kpzDlvF0abvmqNSzUxGegGqx9SdVcjmJUXS3Qt6uJ6Z+V69ddpfGd9wStO6sqJ/EoW8f1DMhqWWbAiKzI1vdH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82DA668AFE; Tue,  3 Feb 2026 07:07:48 +0100 (CET)
Date: Tue, 3 Feb 2026 07:07:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v6 08/16] ntfs: update file operations
Message-ID: <20260203060748.GE16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-9-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-9-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76130-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 01DE0D50F9
X-Rspamd-Action: no action

Suggested commit message:

Rewrite the file operations to utilize the iomap infrastructure,
replacing the legacy buffer-head based implementation.

Implement ntfs_setattr() with size change handling, uid/gid/mode.

Add support for Direct I/O.

Add support for fallocate with the FALLOC_FL_KEEP_SIZE,
FALLOC_FL_PUNCH_HOLE, FALLOC_FL_COLLAPSE_RANGE, FALLOC_FL_INSERT_RANGE
and FALLOC_FL_ALLOCATE_RANGE modes.

Implement .llseek with SEEK_DATA / SEEK_HOLE support.

Implement ntfs_fiemap() using iomap_fiemap().

Add FS_IOC_SHUTDOWN, FS_IOC_[GS]ETFSLABEL, FITRIM ioctl support.

>  static int ntfs_file_open(struct inode *vi, struct file *filp)
>  {
> +	struct ntfs_inode *ni = NTFS_I(vi);
> +
> +	if (NVolShutdown(ni->vol))
> +		return -EIO;
> +
>  	if (sizeof(unsigned long) < 8) {
>  		if (i_size_read(vi) > MAX_LFS_FILESIZE)
>  			return -EOVERFLOW;
>  	}
> +	if (filp->f_flags & O_TRUNC && NInoNonResident(ni)) {
> +		int err;
>  
> +		mutex_lock(&ni->mrec_lock);
> +		down_read(&ni->runlist.lock);
> +		if (!ni->runlist.rl) {
> +			err = ntfs_attr_map_whole_runlist(ni);
> +			if (err) {
> +				up_read(&ni->runlist.lock);
> +				mutex_unlock(&ni->mrec_lock);
> +				return err;
> +			}
>  		}
> +		ni->lcn_seek_trunc = ni->runlist.rl->lcn;
> +		up_read(&ni->runlist.lock);
> +		mutex_unlock(&ni->mrec_lock);
>  	}

Do you ever hits this?  O_TRUNC should call into ->setattr to do
the truncation long before calling into ->open.

> +
> +	filp->f_mode |= FMODE_NOWAIT;

This should also set FMODE_CAN_ODIRECT instead of setting the noop
direct I/O method.

> +static int ntfs_file_release(struct inode *vi, struct file *filp)
>  {
> +	struct ntfs_inode *ni = NTFS_I(vi);
> +	struct ntfs_volume *vol = ni->vol;
> +	s64 aligned_data_size = round_up(ni->data_size, vol->cluster_size);
> +
> +	if (NInoCompressed(ni))
> +		return 0;
> +
> +	inode_lock(vi);
> +	mutex_lock(&ni->mrec_lock);
> +	down_write(&ni->runlist.lock);
> +	if (aligned_data_size < ni->allocated_size) {

Splitting the compresse handling into a helper would really help
the code maintainability here.  Also please add a comment why
this does work on final release, which is highly unusual.  And
even more unusual then doing it in ->flush which is called for
every close.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

