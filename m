Return-Path: <linux-fsdevel+bounces-77861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP2NLOgLmml+YAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:47:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282316DBA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C0A303B7DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D0311597;
	Sat, 21 Feb 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ9sJa10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEA41C62;
	Sat, 21 Feb 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703231; cv=none; b=XxA4mzDTiVeboPen8jw8sl9RIU9wxSCSLU6b44BPWP2qfMMLcsX36PcNHpQd3lX8hZKAWiRg2wXLs/F/CHilHVl5CcxsSSO+ZrSX7VXMarR5WPyNjDTDLuRO7sHnz925UJDRd9F1ug7SjTpA7ccmxWkDC7LsEy5SpkPl2MAmYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703231; c=relaxed/simple;
	bh=+Lml4KArtsOCi5pvVS/O/dpytCcmSTUlIcJifnlJFd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5C0OH3dzPX2Phd72cKHSY+0TXhkrCtgirEUIxICoX1F3MG7M9UEWr6659CEf/LAktdLIsf/dJzQ84VvJV+s+CXmfNiv+jIzCBNs1GKiXOQTmcKmngH6uGhLR/6p8VG9SnT+yHjEL7LsAWvGyUTAbV5v8pHXiAb9NLVTgQrngrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ9sJa10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F4C4CEF7;
	Sat, 21 Feb 2026 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703230;
	bh=+Lml4KArtsOCi5pvVS/O/dpytCcmSTUlIcJifnlJFd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ9sJa10y84CZ5/eOp0f3PDnfgoLrpv8H4nZHgyDKOe5krFzC0L1WMqYXMQnAC2nB
	 tbiKSihxbaa1i831qZ4QbOC/pAbF14wcc+QnSESdEj5Av1fofrw4g+fxbsN64O//rQ
	 sQsHen82gDPeJ5lUbKfupjfHYoGmxAF38HSRnJPJeJueOQE7qxs26gSn/3fXANU3xO
	 uO3iSPrNADCHffxawoLnKmiL+hs+UHGAn5+UYbh4wgeohPgVFJn6UqtoBMiAs6+E6N
	 zcvfS8pd6vDZkh8mNNQ+HRUFHD5lQ18cmsyO31kczSbmmpzZqQX6JKzQB4puy7Q+Kb
	 iwE7nZosrTlFQ==
Date: Sat, 21 Feb 2026 11:47:08 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] fscrypt: return a byte offset from
 bh_get_inode_and_lblk_num
Message-ID: <20260221194708.GD2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-7-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77861-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1282316DBA4
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:14:44AM +0100, Christoph Hellwig wrote:
> @@ -331,7 +331,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  	inode = mapping->host;
>  
>  	*inode_ret = inode;
> -	*lblk_num_ret = (folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits;
> +	*pos_ret = folio_pos(folio) + bh_offset(bh);
>  	return true;
>  }

Rename bh_get_inode_and_lblk_num() to bh_get_inode_and_pos() to reflect
the new semantics.

(And s/logical block number/file position/ in the comment above it)

- Eric

