Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480927424A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF2LFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjF2LFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:05:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF21E4C;
        Thu, 29 Jun 2023 04:05:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B950A1F8AA;
        Thu, 29 Jun 2023 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688036747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxZG+eGbesMc+qW7i7D8iQT3Knlr73r/mfe4sTHLErc=;
        b=g7u6RHC1eRr6vSIwplw/P90srh4AWrJx3RtZWc461xSV49K/qI7vEQY5nZHcnYRmKL5qCk
        uS1eyb9Uqjr+y0/3yeZAMWIFospnDclbEGC4/nWUGkbN79DQlKObMCyCJt9D0iDR03hFtG
        OOj6dH9xnx9XQJTB1wjvRhIg+8b34wI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688036747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxZG+eGbesMc+qW7i7D8iQT3Knlr73r/mfe4sTHLErc=;
        b=GrKPRyKdBdL7Gg1aiB3i/PdvQROhF7OHTAj2e/ohm7wnxK7kG+dLgRchP1bg0FiYeTYoob
        PwWp5O7f59uXHyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB07B139FF;
        Thu, 29 Jun 2023 11:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fGK2KYtlnWSpLwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 11:05:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3E4C9A0722; Thu, 29 Jun 2023 13:05:47 +0200 (CEST)
Date:   Thu, 29 Jun 2023 13:05:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 7/7] quota: remove unused function put_dquot_list()
Message-ID: <20230629110547.oppa5crrgzt6xrkf@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-8-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132155.1560425-8-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 21:21:55, Baokun Li wrote:
> Now that no one is calling put_dquot_list(), remove it.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I guess you can merge this with patch 6. When there was only a single user,
there's no good reason to separate the removal of the unused function...

								Honza

> ---
>  fs/quota/dquot.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index df028fb2ce72..ba0125473be3 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1102,26 +1102,6 @@ static void remove_inode_dquot_ref(struct inode *inode, int type)
>  	dqput(dquot);
>  }
>  
> -/*
> - * Free list of dquots
> - * Dquots are removed from inodes and no new references can be got so we are
> - * the only ones holding reference
> - */
> -static void put_dquot_list(struct list_head *tofree_head)
> -{
> -	struct list_head *act_head;
> -	struct dquot *dquot;
> -
> -	act_head = tofree_head->next;
> -	while (act_head != tofree_head) {
> -		dquot = list_entry(act_head, struct dquot, dq_free);
> -		act_head = act_head->next;
> -		/* Remove dquot from the list so we won't have problems... */
> -		list_del_init(&dquot->dq_free);
> -		dqput(dquot);
> -	}
> -}
> -
>  static void remove_dquot_ref(struct super_block *sb, int type)
>  {
>  	struct inode *inode;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
