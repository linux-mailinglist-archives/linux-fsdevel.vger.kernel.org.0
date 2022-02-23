Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B04C0F4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiBWJhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiBWJhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:37:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F116496AB;
        Wed, 23 Feb 2022 01:37:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 472992114D;
        Wed, 23 Feb 2022 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkNKhnI3Z4RqRaZWsTmnjavlstvLrtTeTG7qCNbsiZc=;
        b=DZ4x99N+/+0AEa+8XMcKiLhDGfCtlrlBGG6mbmQTWkwkZRtF7wFbn1VmgG6gUO0VSCC/ih
        JL0LnlYOKsWQSUV7J51D40KNrHwpSMvsH+g7qKdjlD+93lZeEocuUtL8Dr52ByD/lccSMf
        ksAPETt0tMNm9J80JoeGpl0cSqEzSNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkNKhnI3Z4RqRaZWsTmnjavlstvLrtTeTG7qCNbsiZc=;
        b=qxX4/ycl1lYcZ5yOgm+InbnPdUtq6N86t/rBuaYd6sEIEBm7ZRTPRgke+/4HqsYSCuelPn
        okR0EOVnNeN+ZIBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 36E04A3B83;
        Wed, 23 Feb 2022 09:37:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0A3DA0605; Wed, 23 Feb 2022 10:37:13 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:37:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/9] ext4: Remove unused enum EXT4_FC_COMMIT_FAILED
Message-ID: <20220223093713.fw7c54xmllxrmmld@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <a1e9902e84595a2088bcf4882691a8330640246b.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e9902e84595a2088bcf4882691a8330640246b.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:09, Ritesh Harjani wrote:
> Below commit removed all references of EXT4_FC_COMMIT_FAILED.
> commit 0915e464cb274 ("ext4: simplify updating of fast commit stats")
> 
> Just remove it since it is not used anymore.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/fast_commit.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 02afa52e8e41..80414dcba6e1 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -93,7 +93,6 @@ enum {
>  	EXT4_FC_REASON_RENAME_DIR,
>  	EXT4_FC_REASON_FALLOC_RANGE,
>  	EXT4_FC_REASON_INODE_JOURNAL_DATA,
> -	EXT4_FC_COMMIT_FAILED,
>  	EXT4_FC_REASON_MAX
>  };
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
