Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D976B232C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCILhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCILhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:37:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAE2C659;
        Thu,  9 Mar 2023 03:37:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A238B21EC4;
        Thu,  9 Mar 2023 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678361852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3Kavnuvtu7F05R8cl+TpZ5HAF6KAZmeumBN1jWbLoQ=;
        b=XUx4sJxKU3XO7MWeqdF7dviVgqo402OFnqiEdZHQ7sTosaobll7UT3n4E9Lzk1Rg+oelG7
        zMa/ABkw3giE1EufXuvTqj9Ble7kkXJetNJNaE313nKPujfzlXx29on1ecd7rsZeGUWASA
        EQEHyR9g/fyW3xJPhFqHrXvN9SkkMSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678361852;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3Kavnuvtu7F05R8cl+TpZ5HAF6KAZmeumBN1jWbLoQ=;
        b=+rHmDJy4x9riy/fEyBB10A1ZsYGESX6aLipvrcz0e3P5bHAcQAgR5PWgnDRstQRCSMCqWO
        PReGCZDTZIQebcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94D511391B;
        Thu,  9 Mar 2023 11:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JD1QJPzECWQhVQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 11:37:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2CE8FA06FF; Thu,  9 Mar 2023 12:37:32 +0100 (CET)
Date:   Thu, 9 Mar 2023 12:37:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 02/11] ext4: Remove unused extern variables declaration
Message-ID: <20230309113732.3l6opu5qe5teqn74@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <a66618d6de35f373b50fbcb066e5c4dacdc91294.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66618d6de35f373b50fbcb066e5c4dacdc91294.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:29, Ojaswin Mujoo wrote:
> ext4_mb_stats & ext4_mb_max_to_scan are never used. We use
> sbi->s_mb_stats and sbi->s_mb_max_to_scan instead.
> Hence kill these extern declarations.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 2 --
>  fs/ext4/mballoc.h | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..b8b00457da8d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2903,8 +2903,6 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
>  /* mballoc.c */
>  extern const struct seq_operations ext4_mb_seq_groups_ops;
>  extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
> -extern long ext4_mb_stats;
> -extern long ext4_mb_max_to_scan;
>  extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
>  extern int ext4_mb_init(struct super_block *);
>  extern int ext4_mb_release(struct super_block *);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index dcda2a943cee..165a17893c81 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -49,7 +49,7 @@
>  #define MB_DEFAULT_MIN_TO_SCAN		10
>  
>  /*
> - * with 'ext4_mb_stats' allocator will collect stats that will be
> + * with 's_mb_stats' allocator will collect stats that will be
>   * shown at umount. The collecting costs though!
>   */
>  #define MB_DEFAULT_STATS		0
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
