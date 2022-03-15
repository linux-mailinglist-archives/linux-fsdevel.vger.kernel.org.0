Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB24DA2FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiCOTI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCOTI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 181F513D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647371235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=m7Z8URsvaQnoRcZWkuhYfe8q1W/Lfy2+2wu4jrp/4pU=;
        b=bkOb3s+nWWO1Tdiwm7w+R9J6MvDD05U75T3Z/NfD/GdSwrPV02rGKmcukzGvnmcV444iat
        WuQAf3Wk8LCyqIdx3asUBkfgy6cKv30EtnrXoa19ZWxK24Zrp+KK9LJCOp1x+Ri3nyGrLe
        PoerPeMxin/9RXAeINvyMtQekUorn/E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-gMqiAMxxOI6QUWhVgSeM0Q-1; Tue, 15 Mar 2022 15:07:14 -0400
X-MC-Unique: gMqiAMxxOI6QUWhVgSeM0Q-1
Received: by mail-qt1-f200.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so9097qtk.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 12:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=m7Z8URsvaQnoRcZWkuhYfe8q1W/Lfy2+2wu4jrp/4pU=;
        b=NWqUmGspcpXk0Qq4hIUZ/QxVKFIyr1lHbbdBBkqA0OvRAuvwNqvUkhvAxHUXNHgiI2
         2UiGd4CS31BQMmTIMl0Used7Zqd4mLkvEt8QzeyiFnwfOT743qLVI/tqRAJUhVSE1mTG
         0ve5pAhdU9cRcaOOaJLhcRMR/fQc3GxHx/Tra7N3VpgcU9a8Tl0GuPWmTXc9HlVodvrx
         NCXc/CLGWejtd5GuhqTJPe/tluAU9iVYeG34rWIES9R56GkQXqCYAtp2BJ3cJfh2WoFi
         MqG5y225gpnFUQ2OTjJ1Xfnnv/klxOGTDyWCX5ptZOEAhQ9kKFRcCuZ3ssUypc/HpcbS
         nYoQ==
X-Gm-Message-State: AOAM532AJ82DKpZyBrh1uB5Fu3xki1nivelzFiftymoO2DNKWhh0VbJd
        LsO3vZ9zGf1K6JVFMvIFjqtgQrU1g//Z3y5AxQVm+qatD5SNGmizbFUoMEfPdWCTe+XkkC24hWt
        zef552oGbxlKltJPTTKx4dNP3rg==
X-Received: by 2002:a05:6214:2424:b0:435:8d8b:57e9 with SMTP id gy4-20020a056214242400b004358d8b57e9mr23359175qvb.128.1647371232842;
        Tue, 15 Mar 2022 12:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2PpDWXkveQAfLwhu4E9UCIJnSQWm7EEMTxU41OTSy61A6rkewZ8pUQjc4DddWZYBDEicUlw==
X-Received: by 2002:a05:6214:2424:b0:435:8d8b:57e9 with SMTP id gy4-20020a056214242400b004358d8b57e9mr23359155qvb.128.1647371232574;
        Tue, 15 Mar 2022 12:07:12 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id j20-20020a37a014000000b0067b3a0c7d89sm9683802qke.38.2022.03.15.12.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:07:12 -0700 (PDT)
Date:   Tue, 15 Mar 2022 15:07:10 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjDj3lvlNJK/IPiU@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been chasing down an issue recently that results in the following
soft lockup warning in XFS writeback (iomap_ioend) completion:

 watchdog: BUG: soft lockup - CPU#42 stuck for 208s! [kworker/42:0:52508]
 ...
 CPU: 42 PID: 52508 Comm: kworker/42:0 Tainted: G S           L    5.17.0-rc8 #5
 Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 1.2.4 05/28/2021
 Workqueue: xfs-conv/dm-0 xfs_end_io [xfs]
 RIP: 0010:_raw_spin_unlock_irqrestore+0x1a/0x31
 Code: 74 01 c3 0f 1f 44 00 00 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 f7 c6 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> f1 6e 6a ff 65 8b 05 7a e3 1a 63 85 c0 74 01 c3 0f 1f 44 00 00
 RSP: 0018:ff4a81e4a8a37ce8 EFLAGS: 00000206
 RAX: 0000000000000001 RBX: ffffffff9de08b28 RCX: ff4a81e4a6cfbd00
 RDX: ff4a81e4a6cfbd00 RSI: 0000000000000246 RDI: 0000000000000001
 RBP: 0000000000000246 R08: ff4a81e4a6cfbd00 R09: 000000000002f8c0
 R10: 00006dfe673f3ac5 R11: 00000000fa83b2da R12: 0000000000000fa8
 R13: ffcb6e504b14e640 R14: 0000000000000000 R15: 0000000000001000
 FS:  0000000000000000(0000) GS:ff1a26083fd40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000888000 CR3: 0000000790f4a006 CR4: 0000000000771ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554 
 Call Trace:
  <TASK>
  folio_wake_bit+0x8a/0x110
  folio_end_writeback+0x37/0x80
  iomap_finish_ioend+0xc6/0x330
  iomap_finish_ioends+0x93/0xd0
  xfs_end_ioend+0x5e/0x150 [xfs]
  xfs_end_io+0xaf/0xe0 [xfs]
  process_one_work+0x1c5/0x390
  ? process_one_work+0x390/0x390
  worker_thread+0x30/0x350
  ? process_one_work+0x390/0x390
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

This is reproduced via repeated iterations of the LTP diotest3 test [1]
on a 96xCPU system. This usually first occurs in a transient manner,
dumping two or three warnings and then the system recovers and test
continues, but it eventually reproduces a full on livelock in this same
path. I think I've narrowed the root cause of the warning to commit
c2407cf7d22d0 ("mm: make wait_on_page_writeback() wait for multiple
pending writebacks") (last discussed here[2] afaics). The first thing to
note is that I think the dio aspect of the test program is not
important. The test in this case creates 100x tasks that each run a
"buffered write -> fsync -> dio read" loop on an isolated range of the
test file, where the buffered writes and fsyncs seem to be the primary
contributing factors.

What seems to happen is that the majority of the fsync calls end up
waiting on writeback of a particular page, the wakeup of the writeback
bit on that page wakes a task that immediately resets PG_writeback on
the page such that N other folio_wait_writeback() waiters see the bit
still set and immediately place themselves back onto the tail of the
wait queue.  Meanwhile the waker task spins in the WQ_FLAG_BOOKMARK loop
in folio_wake_bit() (backing off the lock for a cycle or so in each
iteration) only to find the same bunch of tasks in the queue. This
process repeats for a long enough amount of time to trigger the soft
lockup warning. I've confirmed this spinning behavior with a tracepoint
in the bookmark loop that indicates we're stuck for many hundreds of
thousands of iterations (at least) of this loop when the soft lockup
warning triggers.

As to the full livelock variant, I think we end up with a
write_cache_pages() task that is woken waiting for page P, immediately
resets PG_writeback on P and moves on to P+1. P+1 is also already under
writeback, so write_cache_pages() blocks here waiting on that. Page P
has still not been submitted for I/O because XFS/iomap batches I/O
submissions across multiple ->writepage() callbacks. The waker task
spinloop occurs on page P as described above, but since the waker task
is the XFS workqueue task associated with ioend completion on the inode
(because these are delalloc writes that require unwritten extent
conversion on completion), it will never get to waking page P+1 and
we're stuck for good. IOW:

1. Page P is stuck in PG_writeback on a queue awaiting I/O submission.
2. The P submitting task is blocked waiting on PG_writeback of page P+1.
3. The waker task responsible for waking P+1 is spinning waking tasks
for a previous PG_writeback state on page P. This wait queue will never
drain, however, because it consists of a large number of tasks (>
WAITQUEUE_WALK_BREAK_CNT) inserted via folio_wait_writeback() that will
never break the loop for P (because of step 1).

I've run a few quick experiments to try and corroborate this analysis.
The problem goes away completely if I either back out the loop change in
folio_wait_writeback() or bump WAITQUEUE_WALK_BREAK_CNT to something
like 128 (i.e. greater than the total possible number of waiter tasks in
this test). I've also played a few games with bookmark behavior mostly
out of curiosity, but usually end up introducing other problems like
missed wakeups, etc. I've not been able to reproduce this problem on
ext4, I suspect due to sufficiently different writeback/completion
batching behavior. I was thinking about whether skipping writeback of
PG_writeback pages after an explicit wait (removing the wait loop and
BUG_ON()) might avoid this problem and the one the loop is intended to
fix, but I'm not sure that would be safe. Thoughts or ideas?

Brian

[1] while [ true ]; do TMPDIR=<xfsdir> diotest3 -b 65536 -n 100 -i 100 -o 1024000; done
[2] https://lore.kernel.org/linux-mm/000000000000886dbd05b7ffa8db@google.com/

