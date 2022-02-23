Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196C4C0F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiBWJn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiBWJnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:43:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDB5B8BA;
        Wed, 23 Feb 2022 01:42:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D2A221136;
        Wed, 23 Feb 2022 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56pA+CGuLQdgLd1qYOFFRNIzWIldSybof2H4l1KI8t4=;
        b=0gNDoIaoLdEU2IMCVzAidRu5UH2wcGsj0GzEaCOft0i/o29VhqfuIn4GuXAmVBs8zEt1uF
        4tJRDE0ohUrnUbTmkP4pfkvXCQiX+4rHql1as9hY/4dCiGZvnS7AyYqhvBNKPycRNxnBR5
        FCqaRJf0pCFhsDE2Ex7k1XfUBdi/lJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56pA+CGuLQdgLd1qYOFFRNIzWIldSybof2H4l1KI8t4=;
        b=OcFi/ubLrrHGvOI5ACYacYG2EUj/BoRvkQeFxGQcNy5/87ltEnGBxHgT7DizcKpVqNw+tl
        M5rLo33EGBCJULCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3059CA3B81;
        Wed, 23 Feb 2022 09:42:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3D7DA0605; Wed, 23 Feb 2022 10:42:54 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:42:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/9] ext4: Add commit_tid info in jbd debug log
Message-ID: <20220223094254.fmowjdq4dbig5elz@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <60daf324eec64f2be0b9ce0e240294d36411037c.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60daf324eec64f2be0b9ce0e240294d36411037c.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:13, Ritesh Harjani wrote:
> This adds commit_tid argument in ext4_fc_update_stats()
> so that we can add this information too in jbd_debug logs.
> This is also required in a later patch to pass the commit_tid info in
> ext4_fc_commit_start/stop() trace events.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 7fb1eceef30c..ee32aac0cbbf 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1127,11 +1127,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  }
>  
>  static void ext4_fc_update_stats(struct super_block *sb, int status,
> -				 u64 commit_time, int nblks)
> +				 u64 commit_time, int nblks, tid_t commit_tid)
>  {
>  	struct ext4_fc_stats *stats = &EXT4_SB(sb)->s_fc_stats;
>  
> -	jbd_debug(1, "Fast commit ended with status = %d", status);
> +	jbd_debug(1, "Fast commit ended with status = %d for tid %u",
> +			status, commit_tid);
>  	if (status == EXT4_FC_STATUS_OK) {
>  		stats->fc_num_commits++;
>  		stats->fc_numblks += nblks;
> @@ -1181,14 +1182,16 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
>  			commit_tid > journal->j_commit_sequence)
>  			goto restart_fc;
> -		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0);
> +		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
> +				commit_tid);
>  		return 0;
>  	} else if (ret) {
>  		/*
>  		 * Commit couldn't start. Just update stats and perform a
>  		 * full commit.
>  		 */
> -		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0);
> +		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0,
> +				commit_tid);
>  		return jbd2_complete_transaction(journal, commit_tid);
>  	}
>  
> @@ -1220,12 +1223,12 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	 * don't react too strongly to vast changes in the commit time
>  	 */
>  	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
> -	ext4_fc_update_stats(sb, status, commit_time, nblks);
> +	ext4_fc_update_stats(sb, status, commit_time, nblks, commit_tid);
>  	return ret;
>  
>  fallback:
>  	ret = jbd2_fc_end_commit_fallback(journal);
> -	ext4_fc_update_stats(sb, status, 0, 0);
> +	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
