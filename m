Return-Path: <linux-fsdevel+bounces-1177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061547D6E66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8947FB21195
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6F28E0C;
	Wed, 25 Oct 2023 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CRuGepNJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pa6Fidq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0015486
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:35 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B092138
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:06:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2A4321DDC;
	Wed, 25 Oct 2023 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698242771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0u5Mz7tLN8uPSS9lBs4LR/A1pXmk8vvjMRH07w8FzQ=;
	b=CRuGepNJVN0HHC/zi8IqLfaOy4Ew5BzM8MYk4CmW+1RIZeiqJloFVGFvo2nv1y/gblAMzH
	eGeP1yPcghgNwmCBV+smZp+gVwMqBe6t+iI7quS8CMdw5NIGMXuyn0piD7wFLBcBXT/tXB
	bh7CDMzt5NIpWi5Vjp9/WysWIgucBI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698242771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0u5Mz7tLN8uPSS9lBs4LR/A1pXmk8vvjMRH07w8FzQ=;
	b=Pa6Fidq+GQUhCvYDhO/mRBi8I6FLSF/iRgl6UXckhVhUzoha7bVCfiSbe2k+JgZ2dTPfF+
	urVaxmrTX9/Y7XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3C7513524;
	Wed, 25 Oct 2023 14:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8p3aK9MgOWUYEwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:06:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 359C2A05BC; Wed, 25 Oct 2023 16:06:11 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:06:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] blkdev: comment fs_holder_ops
Message-ID: <20231025140611.i33e6drkj5xzje6s@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-10-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-10-599c19f4faac@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]

On Tue 24-10-23 15:01:16, Christian Brauner wrote:
> Add a comment to @fs_holder_ops that @holder must point to a superblock.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza


> ---
>  include/linux/blkdev.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1bc776335ff8..abf71cce785c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1480,6 +1480,11 @@ struct blk_holder_ops {
>  	int (*thaw)(struct block_device *bdev);
>  };
>  
> +/*
> + * For filesystems using @fs_holder_ops, the @holder argument passed to
> + * helpers used to open and claim block devices via
> + * bd_prepare_to_claim() must point to a superblock.
> + */
>  extern const struct blk_holder_ops fs_holder_ops;
>  
>  /*
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

