Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2717A4C0F76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiBWJpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBWJpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:45:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B07A7E5B8;
        Wed, 23 Feb 2022 01:45:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE14F21110;
        Wed, 23 Feb 2022 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5ZDIoKcWqcN8oFYfdaU3K8qoqA6qbGzdsqNM5twVMk=;
        b=a7WIkYcd4gqNOUcX7s7m4WuBe4VaDdLAYOufiQp1xLwTZAq5F3BXQ4xZIWsX805fFgVx+7
        UZpX9W9K4CmQVsVREzRLkzB/Xd2eE0a2UYYCrUgx/EjEdi7uPDb6UyhM1GqMDsG/vAIXR+
        czRw4H05TwfB+90cAfZeunBeYu56Hro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5ZDIoKcWqcN8oFYfdaU3K8qoqA6qbGzdsqNM5twVMk=;
        b=y6gQKV6DNMbX+5nwTtF0m89CECoA0L3QlsqIDytPcXVsByNpqZ60vOoPhRB0nJe8qaujiC
        P4c6aV70aBQmxzCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA8F8A3B81;
        Wed, 23 Feb 2022 09:45:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74C05A0605; Wed, 23 Feb 2022 10:45:09 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:45:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 7/9] ext4: Fix remaining two trace events to use same
 printk convention
Message-ID: <20220223094509.asn3e4dcgs5fokeo@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <9cc1f9ac12ff3dca6b0c18d0bda2245a1264595e.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc1f9ac12ff3dca6b0c18d0bda2245a1264595e.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:15, Ritesh Harjani wrote:
> All ext4 & jbd2 trace events starts with "dev Major:Minor".
> While we are still improving/adding the ftrace events for FC,
> let's fix last two remaining trace events to follow the same
> convention.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/ext4.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 6e66cb7ce624..233dbffa5ceb 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2653,7 +2653,7 @@ TRACE_EVENT(ext4_fc_replay_scan,
>  		__entry->off = off;
>  	),
>  
> -	TP_printk("FC scan pass on dev %d,%d: error %d, off %d",
> +	TP_printk("dev %d,%d error %d, off %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->error, __entry->off)
>  );
> @@ -2679,7 +2679,7 @@ TRACE_EVENT(ext4_fc_replay,
>  		__entry->priv2 = priv2;
>  	),
>  
> -	TP_printk("FC Replay %d,%d: tag %d, ino %d, data1 %d, data2 %d",
> +	TP_printk("dev %d,%d: tag %d, ino %d, data1 %d, data2 %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->tag, __entry->ino, __entry->priv1, __entry->priv2)
>  );
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
