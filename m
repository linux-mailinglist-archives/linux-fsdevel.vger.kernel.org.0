Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522A6DD17F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDKFWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKFWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F29E7C;
        Mon, 10 Apr 2023 22:22:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id la3so6613081plb.11;
        Mon, 10 Apr 2023 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190531; x=1683782531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rmngkbu524+forBMckeuIV6oxujm7LgVJnw1wudpvY=;
        b=C1UQJgTBdnT01wX3/PJMrVIGuvITewpd17pvzSzGl2ACOgWq/Re1MqSSe9lo065iXi
         DkkzL+CgUE+SN2oaDUU6sxJScnB7YbIucBQnD0/NuBFZY+txYDoPPA3ZNGZX/I1vTPTw
         DHov2hswa3NiIqk2g8zSF5krOJJgP1xATGWWYTHzU+mkKLSiHpJSrgq4g1QWKhyo2WfC
         I5SjX2KmY761+BYk+PFWFb1WNq54mnELFbpB3YmFPjxRZR7E2cnnxbYIC03QYX2D+53G
         XnsnOoZoRs42APUuIf9PNPhl9J1o7XvC0bXkBjzsHhTFlMaJFjQYtzveV9VhhCq7ckp9
         PRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190531; x=1683782531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Rmngkbu524+forBMckeuIV6oxujm7LgVJnw1wudpvY=;
        b=X3gP+6TAxXHMFdL03+gsGexsetmDHgU4gHCLT3fomZKvKkamz4RtHuR2LessCavqDE
         ioZlLBFeOrWtnEabv4TUCjVzs079870azL2gVXr04pZ5ULccnILBnk0Z0Rreg8umJEDM
         vGbu1VMRIl5K4zulTYCDseBeeZ7+mzgweMKdZhDeukNa7j1BqhTfI5btNUu8Q7arxDgA
         6F3QSVMOhR6u5BvMrdsqajAK/X6lXyOC6iZH+Os1yAw3awjLtdURMRQtEL5CbHmXjprl
         ui9J4j7t4zdfo3x91l7MYhzuoYnh16HPBps6bOiXzx4VoUf8arZQqFJig0hacgD0Tk5l
         bBJA==
X-Gm-Message-State: AAQBX9epweDcqsOeYJbNth4tR09NfItnDLyiITBhbMMMGh88GYqpXPTE
        OhK6CZFmwmhtWGq2RDNWiO/NetSCmiQ=
X-Google-Smtp-Source: AKy350YfHzq+dXJwPIrRmxMWCEnQZqwUQxe9hKS5nqIRni3Xiu7BgROZMES62WI262xjIwzz4u81RQ==
X-Received: by 2002:a17:903:11c7:b0:19a:727e:d4f3 with SMTP id q7-20020a17090311c700b0019a727ed4f3mr23001940plh.5.1681190530770;
        Mon, 10 Apr 2023 22:22:10 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:10 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 0/8] ext2: DIO to use iomap
Date:   Tue, 11 Apr 2023 10:51:48 +0530
Message-Id: <cover.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please find the series which moves ext2 direct-io to use modern iomap interface.

Here are some more details -
1. Patch-1: Fixes a kernel bug_on problem with ext2 dax code (found during code
   review and testing).
2. Patch-2: Adds a __generic_file_fsync_nolock implementation as we had
   discussed.
3. Patch-3 & Patch-4: Moves ext4 nojournal and ext2 to use _nolock method.
4. Patch-5: This is the main patch which moves ext2 direct-io to use iomap.
   (more details can be found in the patch)
5. Patch-6: Kills IOMAP_DIO_NOSYNC flag as it is not in use by any filesystem.
6. Patch-7: adds IOCB_STRINGS macro for use in trace events for better trace
   output of iocb flags.
7. Patch-8: Add ext2 trace point for DIO.

Testing:
=========
This passes ext2 "auto" group testing for fstests. There were no new failures
with this patches.


Ritesh Harjani (IBM) (8):
  ext2/dax: Fix ext2_setsize when len is page aligned
  libfs: Add __generic_file_fsync_nolock implementation
  ext4: Use __generic_file_fsync_nolock implementation
  ext2: Use __generic_file_fsync_nolock implementation
  ext2: Move direct-io to use iomap
  iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
  fs.h: Add IOCB_STRINGS for use in trace points
  ext2: Add direct-io trace points

 fs/ext2/Makefile      |   2 +-
 fs/ext2/ext2.h        |   1 +
 fs/ext2/file.c        | 127 +++++++++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c       |  57 +++++++++++--------
 fs/ext2/trace.c       |   5 ++
 fs/ext2/trace.h       |  61 ++++++++++++++++++++
 fs/ext4/fsync.c       |  31 +++++------
 fs/iomap/direct-io.c  |   2 +-
 fs/libfs.c            |  43 ++++++++++++++
 include/linux/fs.h    |  15 +++++
 include/linux/iomap.h |   6 --
 11 files changed, 303 insertions(+), 47 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

--
2.39.2

