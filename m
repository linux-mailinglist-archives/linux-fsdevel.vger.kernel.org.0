Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99052D27C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiESMa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiESMaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 08:30:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF9BA57A
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:30:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so4947529pgc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H/GxLQaB7GezXLedyohaAuk7CJEHblBrWxweQUPeBzs=;
        b=eryMaoyVK6JbYQ3PjtfoZF0MUDDkQtXC03BMyUCFiKHn8IZ50uHRroCWYqVjhWC8/F
         hLrREtxLxevnRTZ9hRF2IRqngVvN6F8fIeW2N99YdY/pV+wq3WWeNRj/PGWcUzsVlwAA
         6ZS9nQRLp+JVPBIC1yMBKZnd2wseOgVbw0wHluYWNRI8NAuyholwUKGTdTRip7gfciXE
         3DwAfbyP5XAffOh1N//V87st+ZiE/b5NAgSWLR4Zz6zPeCKvXzZI4+e2tGh8/cgkKZgN
         fvEXesW9mTc5R7wEW9MrX/BDFe88syyt9jCqOj8/+ZWD4b3dPDQ1ciPVNTGmreGv8jSR
         4Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H/GxLQaB7GezXLedyohaAuk7CJEHblBrWxweQUPeBzs=;
        b=EzbYKClDppgHZc6g/9uA2yIIjEznjrkaYoV58rM269V428WrT/U/Bci17akFSGHk6p
         u7f0rSgNWAi8DH2zjwafG5fSRvUFuODsALlavzyNCVy/TBMyUJwQshalgYCgTTuMyH6+
         uF71jxVuWll2ZG+UxQOGQ581msdcrydl4E+/cUm01WsxouolrTwRkd+2aon8vHNgG9Tc
         bfJkhJ3mBUue60wmo92wa6e7S9TX0RlS/Qh6pjj3wHlH84NhVaNMqwsaSBjawWU7B5Ti
         sUCi3kcwG8sWJeBmB63yY5D7jx3TVfXvDJ0GGuxb5aVdcAOjlhVoEQwYwip2pgfywrp9
         J3hA==
X-Gm-Message-State: AOAM530avmMpoTN6SKK91aLZxyCh/ES5Pz83/3LR7MY5Jrgmy0TQS2hn
        OplCMOEcyLGMserpAVHuTjqN9g==
X-Google-Smtp-Source: ABdhPJyCV/oiXgQUoPh9YNnAPT36o419JcrwiEHZCmgZH36p2pkSYQssuM4uBRpgEDY2J38xyMpPfg==
X-Received: by 2002:aa7:8149:0:b0:518:f2e:220d with SMTP id d9-20020aa78149000000b005180f2e220dmr4456864pfn.65.1652963422725;
        Thu, 19 May 2022 05:30:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902d5d700b00161a8886635sm3559966plh.286.2022.05.19.05.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:30:21 -0700 (PDT)
Message-ID: <d97c1e72-5359-79e1-3af3-56d7911702f3@kernel.dk>
Date:   Thu, 19 May 2022 06:30:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_1/1=5d_fs-writeback=3a_writeback=5fsb?=
 =?UTF-8?Q?=5finodes=ef=bc=9aRecalculate_=27wrote=27_according_skipped_pages?=
Content-Language: en-US
To:     Zhihao Cheng <chengzhihao1@huawei.com>, hch@lst.de,
        torvalds@linux-foundation.org, mingo@redhat.com,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
References: <20220510133805.1988292-1-chengzhihao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510133805.1988292-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/22 7:38 AM, Zhihao Cheng wrote:
> Commit 505a666ee3fc ("writeback: plug writeback in wb_writeback() and
> writeback_inodes_wb()") has us holding a plug during wb_writeback, which
> may cause a potential ABBA dead lock:
> 
>     wb_writeback		fat_file_fsync
> blk_start_plug(&plug)
> for (;;) {
>   iter i-1: some reqs have been added into plug->mq_list  // LOCK A
>   iter i:
>     progress = __writeback_inodes_wb(wb, work)
>     . writeback_sb_inodes // fat's bdev
>     .   __writeback_single_inode
>     .   . generic_writepages
>     .   .   __block_write_full_page
>     .   .   . . 	    __generic_file_fsync
>     .   .   . . 	      sync_inode_metadata
>     .   .   . . 	        writeback_single_inode
>     .   .   . . 		  __writeback_single_inode
>     .   .   . . 		    fat_write_inode
>     .   .   . . 		      __fat_write_inode
>     .   .   . . 		        sync_dirty_buffer	// fat's bdev
>     .   .   . . 			  lock_buffer(bh)	// LOCK B
>     .   .   . . 			    submit_bh
>     .   .   . . 			      blk_mq_get_tag	// LOCK A
>     .   .   . trylock_buffer(bh)  // LOCK B
>     .   .   .   redirty_page_for_writepage
>     .   .   .     wbc->pages_skipped++
>     .   .   --wbc->nr_to_write
>     .   wrote += write_chunk - wbc.nr_to_write  // wrote > 0
>     .   requeue_inode
>     .     redirty_tail_locked
>     if (progress)    // progress > 0
>       continue;
>   iter i+1:
>       queue_io
>       // similar process with iter i, infinite for-loop !
> }
> blk_finish_plug(&plug)   // flush plug won't be called
> 
> Above process triggers a hungtask like:
> [  399.044861] INFO: task bb:2607 blocked for more than 30 seconds.
> [  399.046824]       Not tainted 5.18.0-rc1-00005-gefae4d9eb6a2-dirty
> [  399.051539] task:bb              state:D stack:    0 pid: 2607 ppid:
> 2426 flags:0x00004000
> [  399.051556] Call Trace:
> [  399.051570]  __schedule+0x480/0x1050
> [  399.051592]  schedule+0x92/0x1a0
> [  399.051602]  io_schedule+0x22/0x50
> [  399.051613]  blk_mq_get_tag+0x1d3/0x3c0
> [  399.051640]  __blk_mq_alloc_requests+0x21d/0x3f0
> [  399.051657]  blk_mq_submit_bio+0x68d/0xca0
> [  399.051674]  __submit_bio+0x1b5/0x2d0
> [  399.051708]  submit_bio_noacct+0x34e/0x720
> [  399.051718]  submit_bio+0x3b/0x150
> [  399.051725]  submit_bh_wbc+0x161/0x230
> [  399.051734]  __sync_dirty_buffer+0xd1/0x420
> [  399.051744]  sync_dirty_buffer+0x17/0x20
> [  399.051750]  __fat_write_inode+0x289/0x310
> [  399.051766]  fat_write_inode+0x2a/0xa0
> [  399.051783]  __writeback_single_inode+0x53c/0x6f0
> [  399.051795]  writeback_single_inode+0x145/0x200
> [  399.051803]  sync_inode_metadata+0x45/0x70
> [  399.051856]  __generic_file_fsync+0xa3/0x150
> [  399.051880]  fat_file_fsync+0x1d/0x80
> [  399.051895]  vfs_fsync_range+0x40/0xb0
> [  399.051929]  __x64_sys_fsync+0x18/0x30
> 
> In my test, 'need_resched()' (which is imported by 590dca3a71 "fs-writeback:
> unplug before cond_resched in writeback_sb_inodes") in function
> 'writeback_sb_inodes()' seldom comes true, unless cond_resched() is deleted
> from write_cache_pages().
> 
> Fix it by correcting wrote number according number of skipped pages
> in writeback_sb_inodes().
> 
> Goto Link to find a reproducer.

I can take this one for 5.19, thanks.

-- 
Jens Axboe

