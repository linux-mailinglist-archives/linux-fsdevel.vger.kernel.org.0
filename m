Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE697423EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjF2KZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjF2KYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:24:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDC10F;
        Thu, 29 Jun 2023 03:24:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED1D01F8CC;
        Thu, 29 Jun 2023 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688034285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/XKB+r+ekcoHEi9Huf6354CPCt0Hc3+t2mEM3GX83U=;
        b=NCnTRTTho+vomSO0VR8t2cDDSm0F/lMr/XS/eUbFJ5Xdymj/tPjtu0BART4kCWwOdfwbsM
        rdRUusUducUe6/a74zOp77T2laW3POVKPcka0791Zw7IEC9J35CSUIEnBZkbr+pyY5W1wV
        ry/mBh/hooit+nYefASFZZH8ckAA1cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688034285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/XKB+r+ekcoHEi9Huf6354CPCt0Hc3+t2mEM3GX83U=;
        b=4JcEEsEM1k6KsKE6kYn+saQ97khh3gu0TUGU60TbLW07FA61YlTpbVgs9GebkrTPK6igK5
        ip+xyOk5qTCKxBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAB1013905;
        Thu, 29 Jun 2023 10:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FiFeNe1bnWTPGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 10:24:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66360A0722; Thu, 29 Jun 2023 12:24:45 +0200 (CEST)
Date:   Thu, 29 Jun 2023 12:24:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 3/7] quota: rename dquot_active() to
 inode_dquot_active()
Message-ID: <20230629102445.injcpqkfm6wnrw3y@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132155.1560425-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 21:21:51, Baokun Li wrote:
> Now we have a helper function dquot_dirty() to determine if dquot has
> DQ_MOD_B bit. dquot_active() can easily be misunderstood as a helper
> function to determine if dquot has DQ_ACTIVE_B bit. So we avoid this by
> adding the "inode_" prefix and later on we will add the helper function
> dquot_active() to determine if dquot has DQ_ACTIVE_B bit.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Maybe inode_quota_active() will be a better name what you are already
renaming it?

								Honza

> ---
>  fs/quota/dquot.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index a8b43b5b5623..b21f5e888482 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1435,7 +1435,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
>  	return QUOTA_NL_NOWARN;
>  }
>  
> -static int dquot_active(const struct inode *inode)
> +static int inode_dquot_active(const struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> @@ -1458,7 +1458,7 @@ static int __dquot_initialize(struct inode *inode, int type)
>  	qsize_t rsv;
>  	int ret = 0;
>  
> -	if (!dquot_active(inode))
> +	if (!inode_dquot_active(inode))
>  		return 0;
>  
>  	dquots = i_dquot(inode);
> @@ -1566,7 +1566,7 @@ bool dquot_initialize_needed(struct inode *inode)
>  	struct dquot **dquots;
>  	int i;
>  
> -	if (!dquot_active(inode))
> +	if (!inode_dquot_active(inode))
>  		return false;
>  
>  	dquots = i_dquot(inode);
> @@ -1677,7 +1677,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  	int reserve = flags & DQUOT_SPACE_RESERVE;
>  	struct dquot **dquots;
>  
> -	if (!dquot_active(inode)) {
> +	if (!inode_dquot_active(inode)) {
>  		if (reserve) {
>  			spin_lock(&inode->i_lock);
>  			*inode_reserved_space(inode) += number;
> @@ -1747,7 +1747,7 @@ int dquot_alloc_inode(struct inode *inode)
>  	struct dquot_warn warn[MAXQUOTAS];
>  	struct dquot * const *dquots;
>  
> -	if (!dquot_active(inode))
> +	if (!inode_dquot_active(inode))
>  		return 0;
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
>  		warn[cnt].w_type = QUOTA_NL_NOWARN;
> @@ -1790,7 +1790,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>  	struct dquot **dquots;
>  	int cnt, index;
>  
> -	if (!dquot_active(inode)) {
> +	if (!inode_dquot_active(inode)) {
>  		spin_lock(&inode->i_lock);
>  		*inode_reserved_space(inode) -= number;
>  		__inode_add_bytes(inode, number);
> @@ -1832,7 +1832,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
>  	struct dquot **dquots;
>  	int cnt, index;
>  
> -	if (!dquot_active(inode)) {
> +	if (!inode_dquot_active(inode)) {
>  		spin_lock(&inode->i_lock);
>  		*inode_reserved_space(inode) += number;
>  		__inode_sub_bytes(inode, number);
> @@ -1876,7 +1876,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
>  	struct dquot **dquots;
>  	int reserve = flags & DQUOT_SPACE_RESERVE, index;
>  
> -	if (!dquot_active(inode)) {
> +	if (!inode_dquot_active(inode)) {
>  		if (reserve) {
>  			spin_lock(&inode->i_lock);
>  			*inode_reserved_space(inode) -= number;
> @@ -1931,7 +1931,7 @@ void dquot_free_inode(struct inode *inode)
>  	struct dquot * const *dquots;
>  	int index;
>  
> -	if (!dquot_active(inode))
> +	if (!inode_dquot_active(inode))
>  		return;
>  
>  	dquots = i_dquot(inode);
> @@ -2103,7 +2103,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
>  	struct super_block *sb = inode->i_sb;
>  	int ret;
>  
> -	if (!dquot_active(inode))
> +	if (!inode_dquot_active(inode))
>  		return 0;
>  
>  	if (i_uid_needs_update(idmap, iattr, inode)) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
