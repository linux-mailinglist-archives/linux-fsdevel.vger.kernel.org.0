Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D6738D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFURma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFURmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:42:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEDC2109;
        Wed, 21 Jun 2023 10:41:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6686ef86110so2502094b3a.2;
        Wed, 21 Jun 2023 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687369301; x=1689961301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTPhwv/l6Zw+9hEjHuSPvm+1sfohWrOHSKZvEZPPa6U=;
        b=sGcziMemkFUmSP94DSylM75CBluEuaN4gTu1N8Khw6++o32GEFK/5tY0/Jpuqe6mQk
         knKUbt6uIO4s08Ku6zHLbSoFogKyaFKNrQmJkBCcDK/S4/teZFu68RZ0APPoOpIZXWmZ
         VIYlvII1vAR5BO/vGyyIbYDHLblzQvKiTtmbAyB5iZ1BO0VED6ggAfhuuIkXJC00j6H5
         VOG4lqcF7DOFNLO68RLXSxWan5mW0xvYcaqfiAEwPN8dsvE+4MI6S1DUxDAU1af6wVn2
         YfvKBnyvVPEM+POrDXuo5tDyMUvKICbetB+M86LUi/Lj+X5L+v3xQgpsYOwN+lwQyrIh
         /LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369301; x=1689961301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTPhwv/l6Zw+9hEjHuSPvm+1sfohWrOHSKZvEZPPa6U=;
        b=UdaJviji9X6kc43myGUVrv0S9j11KvwiuK5JOGoMSV7Mcd69xZ3bhpMym31ymC1rWn
         oGI9Q8c1HqWk3LmgRlkOljXRVoZ3E6QWt4TOu6RhoBq6u3idWInZCsY/bnByfN69+OwY
         hhll4NJeS6q44Zewk/vtd2crpQtvKRJbs4PiZqCRjDfVRqtuvJdMVU/D9uJOquLPSupt
         8qV1/ZvbeUbRnIlNSX1UXMBhzuRU9qM283ExHCrzH+dZgZi39BHYB+dVmAI8rG98Veoo
         GoiNdR47Wyg2nSQgAkozBbH5mU75+GvvNmUyjTqRkGfEm9ILaXzD93w0Q77jOcrWSfdu
         KgmA==
X-Gm-Message-State: AC+VfDz5/hHHjfO9j/ORCQSY4AHVBfUEIr/CtUrhVh7m+MjhwLbUJBPx
        IpKmd1V4XGnXxeJYajRYA8I=
X-Google-Smtp-Source: ACHHUZ5Qt1Ok5g9bWn/7p+98L+FP3lJ8PTaAJJjAaHP9uLgl2jmtosizAULWhyYflY4xBzGWEBCiBQ==
X-Received: by 2002:a05:6a20:9189:b0:10f:f672:6e88 with SMTP id v9-20020a056a20918900b0010ff6726e88mr12846057pzd.4.1687369301310;
        Wed, 21 Jun 2023 10:41:41 -0700 (PDT)
Received: from jbongio9100214.lan ([2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id j23-20020a62e917000000b0066a4636c777sm1246824pfh.192.2023.06.21.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:41:40 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH 0/1] iomap regression for aio dio 4k writes
Date:   Wed, 21 Jun 2023 10:29:19 -0700
Message-ID: <20230621174114.1320834-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick and Allison,

There has been a standing performance regression involving AIO DIO
4k-aligned writes on ext4 backed by a fast local SSD since the switch
to iomap. I think it was originally reported and investigated in this
thread: https://lore.kernel.org/all/87lf7rkffv.fsf@collabora.com/

Short version:
Pre-iomap, for ext4 async direct writes, after the bio is written to disk
the completion function is called directly during the endio stage.

Post-iomap, for direct writes, after the bio is written to disk, the completion
function is deferred to a work queue. This adds latency that impacts
performance most noticeably in very fast SSDs.

Detailed version:
A possible explanation is below, followed by a few questions to figure
out the right way to fix it.

In 4.15, ext4 uses fs/direct-io.c. When an AIO DIO write has completed
in the nvme driver, the interrupt handler for the write request ends
in calling bio_endio() which ends up calling dio_bio_end_aio(). A
different end_io function is used for async and sync io. If there are
no pages mapped in memory for the write operation's inode, then the
completion function for ext4 is called directly. If there are pages
mapped, then they might be dirty and need to be updated and work
is deferred to a work queue.

Here is the relevant 4.15 code:

fs/direct-io.c: dio_bio_end_aio()
if (dio->result)
        defer_completion = dio->defer_completion ||
                           (dio_op == REQ_OP_WRITE &&
                           dio->inode->i_mapping->nrpages);
if (defer_completion) {
        INIT_WORK(&dio->complete_work, dio_aio_complete_work);
        queue_work(dio->inode->i_sb->s_dio_done_wq,
                   &dio->complete_work);
} else {
        dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
}

After ext4 switched to using iomap, the endio function became
iomap_dio_bio_end_io() in fs/iomap/direct-io.c. In iomap the same end io
function is used for both async and sync io. All write requests will
defer io completion to a work queue even if there are no mapped pages
for the inode.

Here is the relevant code in latest kernel (post-iomap) ...

fs/iomap/direct-io.c: iomap_dio_bio_end_io()
if (dio->wait_for_completion) {
          struct task_struct *waiter = dio->submit.waiter;
          WRITE_ONCE(dio->submit.waiter, NULL);
          blk_wake_io_task(waiter);
   } else if (dio->flags & IOMAP_DIO_WRITE) {
         struct inode *inode = file_inode(dio->iocb->ki_filp);

         WRITE_ONCE(dio->iocb->private, NULL);
         INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
         queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
   } else {
         WRITE_ONCE(dio->iocb->private, NULL);
         iomap_dio_complete_work(&dio->aio.work);
}

With the attached patch, I see significantly better performance in 5.10 than 4.15. 5.10 is the latest kernel where I have driver support for an SSD that is fast enough to reproduce the regression. I verified that upstream iomap works the same.

Test results using the reproduction script from the original report
and testing with 4k/8k/12k/16k blocksizes and write-only:
https://people.collabora.com/~krisman/dio/week21/bench.sh

fio benchmark command:
fio --ioengine libaio --size=2G --direct=1 --filename=${MNT}/file --iodepth=64 \
--time_based=1 --thread=1 --overwrite=1 --bs=${BS} --rw=$RW \
--name "`uname -r`-${TYPE}-${RW}-${BS}-${FS}" \
--runtime=100 --output-format=terse >> ${LOG}

For 4.15, with all write completions called in io handler:
4k:  bw=1056MiB/s
8k:  bw=2082MiB/s
12k: bw=2332MiB/s
16k: bw=2453MiB/s

For unmodified 5.10, with all write completions deferred:
4k:  bw=1004MiB/s
8k:  bw=2074MiB/s
12k: bw=2309MiB/s
16k: bw=2465MiB/s

For modified 5.10, with all write completions called in io handler:
4k:  bw=1193MiB/s
8k:  bw=2258MiB/s
12k: bw=2346MiB/s
16k: bw=2446MiB/s

Questions:

Why did iomap from the beginning not make the async/sync io and
mapped/unmapped distinction that fs/direct-io.c did?

Since no issues have been found for ext4 calling completion work
directly in the io handler pre-iomap, it is unlikely that this is
unsafe (sleeping within an io handler callback). However, this may not
be true for all filesystems. Does XFS potentially sleep in its
completion code?

Allison, Ted mentioned you saw a similar problem when doing performance testing for the latest version of Unbreakable Linux. Can you test/verify this patch addresses your performance regression as well?

Jeremy Bongio (1):
  For DIO writes with no mapped pages for inode, skip deferring
    completion.

 fs/iomap/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.41.0.185.g7c58973941-goog

