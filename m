Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F351A5977FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiHQUae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiHQUaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:30:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660EA98F0;
        Wed, 17 Aug 2022 13:30:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so18985152edd.3;
        Wed, 17 Aug 2022 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NWZQgWpMUk3JjlrLhlAgM4oy2WL6sXDOG4C6y2iheNU=;
        b=qRCTgsCC+kerWa/f082jGl/7mkEogEgsHQlxQiMNQSdnFeTDJdNMgUoUhjuOUYpQit
         w0SyRDnlx+eM+QE6r4T70jztO6m4YhCG6Ezi278SvWrmswZIzrAwAWs2tS0yOaFusXZW
         LH2lXbVZ8vb1LcERlLZ0MYcjDpS4gjBLCBuX5WFTKX+Pm1c+xkSWyzVu6viylYxWCZLf
         L6B9V/aDc5NsC5/UUj0uU8BPix7WqdWiNEdtamlEUikIt8SEmxU9aqQj2GkNPV2QeoVG
         bQI/2KUrdVjvqxgDSlw+CMQyCNYQpThNgkn0LtUagkTqua/VvEBteDtUgAq7D+g4yhG7
         ugsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NWZQgWpMUk3JjlrLhlAgM4oy2WL6sXDOG4C6y2iheNU=;
        b=ojPyKp93na9kVGKP86amI/7kF/3aL0ZwNaCc5LWKTwbTkhqAfyYZ+swnGTDG7rBL9q
         2R5nFBl0+tNAMeaOX7BvQiZ/xHSzEe1i3yLHg54NI+JS3RMK84awB/jBYc2/jQK5DEwi
         cwHM9nMXst04aGxgKsAf8on7kV28ZQJQ+5Zc20tU8M8XDfzdEWfURE+KlgeWVLgU5dFQ
         wV+mt+qhG20YxuhRSOw7xdBN0I8yVs1MIe3mZErV+6WAjiQh/qgwKYUVWgJrAZlamAoq
         dqUzoJ8PBWmC9AQvzeDOiV5X4gd7UvYv7ockCsprv+bst/oPZZvPtF7bGbh5IRM9gBDf
         jatQ==
X-Gm-Message-State: ACgBeo0152pxHchbbYU/Mk1fIs+k8otXpFBlhQzUf6/3rLdin21473tk
        nHpKJc2TxGr1IfjiD0ny2etpuCu56/A=
X-Google-Smtp-Source: AA6agR6BHP4ovKDM6lvjZIxhs6PWbHa6iNhVq6K45a48bdrTq7qfacfIt1J/t8Gz3s+S8O+zRyty7Q==
X-Received: by 2002:a05:6402:3552:b0:43d:a57d:22e9 with SMTP id f18-20020a056402355200b0043da57d22e9mr24471668edd.119.1660768214668;
        Wed, 17 Aug 2022 13:30:14 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090653c700b0073b0c2d420dsm512042ejo.217.2022.08.17.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:30:14 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v5 0/4] landlock: truncate support
Date:   Wed, 17 Aug 2022 22:30:02 +0200
Message-Id: <20220817203006.21769-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of these patches is to work towards a more complete coverage
of file system operations that are restrictable with Landlock.

The known set of currently unsupported file system operations in
Landlock is described at [1]. Out of the operations listed there,
truncate is the only one that modifies file contents, so these patches
should make it possible to prevent the direct modification of file
contents with Landlock.

The patch introduces the truncation restriction feature as an
additional bit in the access_mask_t bitmap, in line with the existing
supported operations.

The truncation flag covers both the truncate(2) and ftruncate(2)
families of syscalls, as well as open(2) with the O_TRUNC flag.
This includes usages of creat() in the case where existing regular
files are overwritten.

Apart from Landlock, file truncation can also be restricted using
seccomp-bpf, but it is more difficult to use (requires BPF, requires
keeping up-to-date syscall lists) and it is not configurable by file
hierarchy, as Landlock is. The simplicity and flexibility of the
Landlock approach makes it worthwhile adding.

While it's possible to use the "write file" and "truncate" rights
independent of each other, it simplifies the mental model for
userspace callers to always use them together.

Specifically, the following behaviours might be surprising for users
when using these independently:

 * The commonly creat() syscall requires the truncate right when
   overwriting existing files, as it is equivalent to open(2) with
   O_TRUNC|O_CREAT|O_WRONLY.
 * The "write file" right is not always required to truncate a file,
   even through the open(2) syscall (when using O_RDONLY|O_TRUNC).

Nevertheless, keeping the two flags separate is the correct approach
to guarantee backwards compatibility for existing Landlock users.

These patches are based on version 6.0-rc1.

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

Past discussions:
V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/

Changelog:

V5:
* Documentation
  * Fix wording in userspace-api headers and in landlock.rst.
  * Move the truncation limitation section one to the bottom.
  * Move all .rst changes into the documentation commit.
* selftests
  * Remove _metadata argument from helpers where it became unnecessary.
  * Open writable file descriptors at the top of both tests, before Landlock
    is enabled, to exercise ftruncate() independently from open().
  * Simplify test_ftruncate and decouple it from exercising open().
  * test_creat(): Return errno on close() failure (it does not conflict).
  * Fix /* comment style */
  * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
  * Add missing |O_TRUNC to a check in one test.
  * Put the truncate_unhandled test before the other.

V4:
 * Documentation
   * Clarify wording and syntax as discussed in review.
   * Use a less confusing error message in the example.
 * selftests:
   * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
     (This is an intentionally uncommon error code, so that the source
     of the error is clear and the test can distinguish test setup
     failures from failures in the actual system call under test.)
 * samples/Documentation:
   * Use additional clarifying comments in the kernel backwards
     compatibility logic.

V3:
 * selftests:
   * Explicitly test ftruncate with readonly file descriptors
     (returns EINVAL).
   * Extract test_ftruncate, test_truncate, test_creat helpers,
     which simplified the previously mixed usage of EXPECT/ASSERT.
   * Test creat() behaviour as part of the big truncation test.
   * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
     This simplifies the tests a bit. The kernel implementations are the
     same as for truncate(2) and ftruncate(2), so there is little benefit
     from testing them exhaustively. (We aren't testing all open(2)
     variants either.)
 * samples/landlock/sandboxer.c:
   * Use switch() to implement best effort mode.
 * Documentation:
   * Give more background on surprising truncation behaviour.
   * Use switch() in the example too, to stay in-line with the sample tool.
   * Small fixes in header file to address previous comments.
* misc:
  * Fix some typos and const usages.

V2:
 * Documentation: Mention the truncation flag where needed.
 * Documentation: Point out connection between truncation and file writing.
 * samples: Add file truncation to the landlock/sandboxer.c sample tool.
 * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
 * selftests: Exercise truncation syscalls when the truncate right
   is not handled by Landlock.

Günther Noack (4):
  landlock: Support file truncation
  selftests/landlock: Selftests for file truncation support
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  52 +++-
 include/uapi/linux/landlock.h                |  17 +-
 samples/landlock/sandboxer.c                 |  23 +-
 security/landlock/fs.c                       |   9 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 257 ++++++++++++++++++-
 8 files changed, 336 insertions(+), 28 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
--
2.37.2
