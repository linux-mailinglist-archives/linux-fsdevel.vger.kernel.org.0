Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071275B2744
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIHT7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiIHT6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:58:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17781079DD;
        Thu,  8 Sep 2022 12:58:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o25so3386886wrf.9;
        Thu, 08 Sep 2022 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AriYWRy0S8/4zTc53zgSGwSVET6sY/8gNSzp/r0ruz0=;
        b=oAGXCNyFY2Kd6YPdZOHZ1cciYW/Cv4EaH+XDQyhz8zpcyQDQUoM0TP2on6MqHzdE9a
         bT/uIToVoOukFUcQuSS4f+CJW96OO3KkR3FYVfpVF58TVnJQ39Bfqg4c+FsVBRJpZx+4
         guOuBgrnCAaRVcOz0unNEwXobujSm/K+h5Z+jHZ38ptzWMd4/2pQntAVLNrb5w4hdiZL
         OP+4CsSZO/Ub60w4h+W1cp/uYdjZrPU/hXgEVCF4LkpAH+9jTCxoSqW0mX7b5N34hxm8
         Gg1fdZAo21TYsiRCqi576sSRa4OUIh1cZLHVMRI4J1Q0JgJ0tl6K2nC+1IURFNU2EIM1
         GH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AriYWRy0S8/4zTc53zgSGwSVET6sY/8gNSzp/r0ruz0=;
        b=8KXPymKP6MqrIVyYWSShochQPkgyrtdSr2w2cBZLCSV8nPqgRhbGq+hXKqj8d0L/e3
         h0Ym3PfW/YTvk2+AZ5o0fEscrgdeBDdrqFxMtZCNasfiwQqYmCi+4xyQJsoS/hEF9w+W
         ZMJxrntPeJXBLNfF44Ja1AMdmFBKvHGGZI+QWDINGRjH36KoX6R/THe4qHb4reEs91dS
         lp2Y//9lfavrabAyX8eInRklQQD7Uf4O9Ts4P6JuTVq4fpWEGCP68c49NJokyC0HGUTY
         TCRTvhJoZu5zNQnesyPQUZGf4BMwIN3veFwzaNMTqFoaAPrp9NLYdQ/rFYMAa/F1Ka47
         WRsA==
X-Gm-Message-State: ACgBeo0Xo0VbohsVxnQcbvj7pIvCCy7J4dul6gN8L4OIFzweoxVLTSGj
        FACBqmmZ/+xPu3XZWvuaAqthpPhfGuY=
X-Google-Smtp-Source: AA6agR4smh4lUp9P7OVFX7KCM7jJqv/4eep551Sgpk9qV/9IQ9UqZG3nnTZMhFV5H92pfVY/WGwouQ==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr6108658wri.455.1662667090512;
        Thu, 08 Sep 2022 12:58:10 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c2d5600b003a541d893desm3360682wmg.38.2022.09.08.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:58:10 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v6 0/5] landlock: truncate support
Date:   Thu,  8 Sep 2022 21:58:00 +0200
Message-Id: <20220908195805.128252-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Notably, the availability of the truncate right is associated with an
opened file when opening the file and is later checked to authorize
ftruncate(2) operations. This is similar to how the write mode gets
remembered after a open(..., O_WRONLY) to authorize later write()
operations. These opened file descriptors can also be passed between
processes and will continue to enforce their truncation properties
when these processes attempt an ftruncate().

These patches are based on version 6.0-rc4.

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

Past discussions:
V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
V5: https://lore.kernel.org/all/20220817203006.21769-1-gnoack3000@gmail.com/

Changelog:

V6:
* LSM hooks: create file_truncate hook in addition to path_truncate.
  Use it in the existing path_truncate call sites where appropriate.
* landlock: check LANDLOCK_ACCESS_FS_TRUNCATE right during open(), and
  associate that right with the opened struct file in a security blob.
  Introduce get_path_access_rights() helper function.
* selftests: test ftruncate in a separate test, to exercise that
  the rights are associated with the file descriptor.
* Documentation: Rework documentation to reflect new ftruncate() semantics.
* Applied small fixes by Mickaël Salaün which he added on top of V5, in
  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
  (I hope I found them all.)

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

Günther Noack (5):
  security: create file_truncate hook from path_truncate hook
  landlock: Support file truncation
  selftests/landlock: Selftests for file truncation support
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  62 +++-
 fs/namei.c                                   |   6 +-
 fs/open.c                                    |   4 +-
 include/linux/lsm_hook_defs.h                |   1 +
 include/linux/security.h                     |   6 +
 include/uapi/linux/landlock.h                |  18 +-
 samples/landlock/sandboxer.c                 |  23 +-
 security/apparmor/lsm.c                      |   6 +
 security/landlock/fs.c                       |  88 +++++-
 security/landlock/fs.h                       |  18 ++
 security/landlock/limits.h                   |   2 +-
 security/landlock/setup.c                    |   1 +
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |   5 +
 security/tomoyo/tomoyo.c                     |  13 +
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 287 ++++++++++++++++++-
 17 files changed, 508 insertions(+), 36 deletions(-)


base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
--
2.37.3
