Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86269581237
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiGZLjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiGZLjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:39:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699421B7B4;
        Tue, 26 Jul 2022 04:39:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CA201FBB6;
        Tue, 26 Jul 2022 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658835559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RdE6D5LluIMS7uHdldNeXeQC/M3YuNxvgWNeNiYXq8=;
        b=Ed4f/3JSh0o0I5iOeWr3KEosQNINvAuSuNwyhO1gYx+xktXbHPTI0/e3Hkqxyi6DO1XciD
        Ky8d39voi79b7UYY0xbCENqKCF9u51FkwJ4en8zWFcZh23/Vz43n5ox1TU654L0R7xaf8J
        H++zzPJ/2ar7cBK/CLkHS/eudnoG/1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658835559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RdE6D5LluIMS7uHdldNeXeQC/M3YuNxvgWNeNiYXq8=;
        b=324awbVk5O0Q9whboOmO7Z2OMXRXYpWGIJs+xDcsBha/voXYzD+bUXQ9fm6s9Fc9sh7EBa
        159Z69789CQUMqDg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F11D62C15D;
        Tue, 26 Jul 2022 11:39:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8559EA0664; Tue, 26 Jul 2022 13:39:18 +0200 (CEST)
Date:   Tue, 26 Jul 2022 13:39:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Fix comment typo
Message-ID: <20220726113918.qj7x53uw4e7u7hld@quack3>
References: <20220722194639.18545-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722194639.18545-1-gaoxin@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 23-07-22 03:46:39, Xin Gao wrote:
> The double `if' is duplicated in line 104, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 6eee19d15e8c..a9773167d695 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -100,7 +100,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * Given an inode, first check if we care what happens to our children.  Inotify
>   * and dnotify both tell their parents about events.  If we care about any event
>   * on a child we run all of our children and set a dentry flag saying that the
> - * parent cares.  Thus when an event happens on a child it can quickly tell if
> + * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
>   */
>  void __fsnotify_update_child_dentry_flags(struct inode *inode)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
