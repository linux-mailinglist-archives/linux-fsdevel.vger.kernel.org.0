Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEFE4C0F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiBWJl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiBWJl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:41:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B55B8BA;
        Wed, 23 Feb 2022 01:40:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 784D51F3A8;
        Wed, 23 Feb 2022 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/cCKw5BJZWLcNjwvBk6BwS8hu5S4/oabc2zMRr1ruQ=;
        b=s9eFaBF0QEya+5LYiLmwzdRjbs4czu/mj+8T0S0b6t+xmaLz3uUChNXud8FTcIjAro0P/3
        8326zMqkl3ovDTL+yKeaCJ2iJd+f5YHS1ICbA3W9P3mytxUOra0qjw4F95vH8T4uOuOvH8
        xdBdRKriluu41R8UMNrGuekpnRWNOXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/cCKw5BJZWLcNjwvBk6BwS8hu5S4/oabc2zMRr1ruQ=;
        b=t3dhcuoU01aIFH4P8jRBPp73eOCXZEkzR6VIoW1EIM2YKfNX2LqYPKzsNc+F8HHLhWWKdH
        vfzDQOc2CpeBeZBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6834FA3B84;
        Wed, 23 Feb 2022 09:40:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A260A0605; Wed, 23 Feb 2022 10:40:57 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:40:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/9] ext4: Add couple of more fast_commit tracepoints
Message-ID: <20220223094057.53zcovnazrqwbngw@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:11, Ritesh Harjani wrote:
> This adds two more tracepoints for ext4_fc_track_template() &
> ext4_fc_cleanup() which are helpful in debugging some fast_commit issues.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

So why is this more useful than trace_ext4_fc_track_range() and other
tracepoints? I don't think it provides any more information? What am I
missing?

								Honza

> ---
>  fs/ext4/fast_commit.c       |  3 ++
>  include/trace/events/ext4.h | 67 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5ac594e03402..bf70879bb4fe 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -386,6 +386,8 @@ static int ext4_fc_track_template(
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>  		return -EINVAL;
>  
> +	trace_ext4_fc_track_template(handle, inode, __fc_track_fn, enqueue);
> +
>  	tid = handle->h_transaction->t_tid;
>  	mutex_lock(&ei->i_fc_lock);
>  	if (tid == ei->i_sync_tid) {
> @@ -1241,6 +1243,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	if (full && sbi->s_fc_bh)
>  		sbi->s_fc_bh = NULL;
>  
> +	trace_ext4_fc_cleanup(journal, full, tid);
>  	jbd2_fc_release_bufs(journal);
>  
>  	spin_lock(&sbi->s_fc_lock);
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 17fb9c506e8a..cd09dccea502 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2855,6 +2855,73 @@ TRACE_EVENT(ext4_fc_track_range,
>  		      __entry->end)
>  	);
>  
> +TRACE_EVENT(ext4_fc_track_template,
> +	TP_PROTO(handle_t *handle, struct inode *inode,
> +		 void *__fc_track_fn, int enqueue),
> +
> +	TP_ARGS(handle, inode, __fc_track_fn, enqueue),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(tid_t, t_tid)
> +		__field(ino_t, i_ino)
> +		__field(tid_t, i_sync_tid)
> +		__field(void *, __fc_track_fn)
> +		__field(int, enqueue)
> +		__field(bool, jbd2_ongoing)
> +		__field(bool, fc_ongoing)
> +	),
> +
> +	TP_fast_assign(
> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->t_tid = handle->h_transaction->t_tid;
> +		__entry->i_ino = inode->i_ino;
> +		__entry->i_sync_tid = ei->i_sync_tid;
> +		__entry->__fc_track_fn = __fc_track_fn;
> +		__entry->enqueue = enqueue;
> +		__entry->jbd2_ongoing =
> +		    sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING;
> +		__entry->fc_ongoing =
> +		    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING;
> +	),
> +
> +	TP_printk("dev %d,%d, t_tid %u, ino %lu, i_sync_tid %u, "
> +		  "track_fn %pS, enqueue %d, jbd2_ongoing %d, fc_ongoing %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
> +		  (void *)__entry->__fc_track_fn, __entry->enqueue,
> +		  __entry->jbd2_ongoing, __entry->fc_ongoing)
> +	);
> +
> +TRACE_EVENT(ext4_fc_cleanup,
> +	TP_PROTO(journal_t *journal, int full, tid_t tid),
> +
> +	TP_ARGS(journal, full, tid),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(int, j_fc_off)
> +		__field(int, full)
> +		__field(tid_t, tid)
> +	),
> +
> +	TP_fast_assign(
> +		struct super_block *sb = journal->j_private;
> +
> +		__entry->dev = sb->s_dev;
> +		__entry->j_fc_off = journal->j_fc_off;
> +		__entry->full = full;
> +		__entry->tid = tid;
> +	),
> +
> +	TP_printk("dev %d,%d, j_fc_off %d, full %d, tid %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->j_fc_off, __entry->full, __entry->tid)
> +	);
> +
>  TRACE_EVENT(ext4_update_sb,
>  	TP_PROTO(struct super_block *sb, ext4_fsblk_t fsblk,
>  		 unsigned int flags),
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
