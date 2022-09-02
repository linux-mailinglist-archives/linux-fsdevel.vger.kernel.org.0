Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68555AA7F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiIBGQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiIBGQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:16:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853090823;
        Thu,  1 Sep 2022 23:16:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nc14so1838403ejc.4;
        Thu, 01 Sep 2022 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=xZmHQywJhWEpEzsh7jK8r6cT/tFKKPUpbNcfbxXGdpo=;
        b=CYvzjK/Xx4Mo2Ueyvd6hvSGr4fmxbCvBwjyE72YX/8JZo18M7B+78KKC48cSi0vMOu
         rrkp2Wij4ulbvmb6wAkdPxwceSHYqq9diAcDsK+/AT02Q4SEa3vBhjN4gOFpKmuci2qu
         e+WgBfAf/ocFsY3pOMJa3ImbFTeK7Nr2HOJsofPMkzOT0hrhPEzulUzASsZHXKV/LLi5
         xRq3CSXZrWT2/EpZLr0Y5/2uFGH0eTYgREBFnIUBy7XxZK+JjJJT5aK+uBxrrrGqjuEN
         7R6smPgq8r9aPiTpqp/UNV5a6YcpViAWek1jreqvMuDGhhtSrK2Ah15MaH4Tv2EIUhl/
         2G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xZmHQywJhWEpEzsh7jK8r6cT/tFKKPUpbNcfbxXGdpo=;
        b=vB25r1VtPSyEhj29FNENUsU0LgEf64/8UESQ81b7+m0sqwNiq5Y6bo084nAjfqYmdK
         M7HWDPBXbHJCMQNCa9US9ZV2bZvKYMcvEGI2FVgtHBlifMB9qFMxXOAD8iuRoLKI5lg/
         t8VYqwwOQwf4RhkJHdqEYvso6+oHe9Zd5KC+OR/xPjdJFYGOZkuGTXSPSGhBl//VQ6pr
         qjtTi+4Iap6PLKXk852+2NZIV/acKaDPyJDwS9CbdYlY7Vko0pQeySgvCgW8pxr6SYGi
         6svaYb38ySKM/4/7Ox41bm3AY231SNAc+0wgF70c0e/6spanzY7mdytGD+a4rIPxOG0q
         yVIA==
X-Gm-Message-State: ACgBeo2Lf5NwwvsaCSUrCGSDFsEuyz/jNpyEOpMz+wQNP0pZkGYWb5Wg
        tFd6p7XW7Wau3LTcVpuw+wo=
X-Google-Smtp-Source: AA6agR4uwBohdh0zxFDyS49atx3EAXfQj6wWqy89tYkMIJ3pNTCdb4x/IkZ60BILEOxMMZScDUtVSg==
X-Received: by 2002:a17:907:968f:b0:742:1244:b02 with SMTP id hd15-20020a170907968f00b0074212440b02mr11430279ejc.496.1662099401405;
        Thu, 01 Sep 2022 23:16:41 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402040300b004466f5375a5sm756678edv.53.2022.09.01.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:16:40 -0700 (PDT)
Date:   Fri, 2 Sep 2022 08:16:38 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v5 0/4] landlock: truncate support
Message-ID: <YxGfxo87drkAjWGf@nuc>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
 <YxGVgfcXwEa+5ZYn@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxGVgfcXwEa+5ZYn@nuc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:32:49AM +0200, Günther Noack wrote:
> On Thu, Sep 01, 2022 at 07:10:38PM +0200, Mickaël Salaün wrote:
> > Hmm, I think there is an issue with this series. Landlock only enforces
> > restrictions at open time or when dealing with user-supplied file paths
> > (relative or absolute).
>
> Argh, ok. That sounds like a desirable property, although it would
> mean reworking the patch set.
>
> > The use of the path_truncate hook in this series
> > doesn't distinguish between file descriptor from before the current sandbox
> > or from after being sandboxed. For instance, if a file descriptor is
> > received through a unix socket, it is assumed that this is legitimate and no
> > Landlock restriction apply on it, which is not the case with this series
> > anymore. It is the same for files opened before the process sandbox itself.
> >
> > To be able to follow the current semantic, I think we should control the
> > truncate access at open time (or when dealing with a user-supplied path) but
> > not on any file descriptor as it is currently done.
>
> OK - so let me try to make a constructive proposal. We have previously
> identified a few operations where a truncation happens, and I would
> propose that the following Landlock rights should be needed for these:
>
> * truncate() (operating on char *path): Require LL_ACCESS_FS_TRUNCATE
> * ftruncate() (operating on fd): No Landlock rights required
> * open() for reading with O_TRUNC: Require LL_ACCESS_FS_TRUNCATE
> * open() for writing with O_TRUNC: Require LL_ACCESS_FS_WRITE_FILE

Thinking about it again, another alternative would be to require
TRUNCATE as well when opening a file for writing - it would be
logical, because the resulting FD can be truncated. It would also
require people to provide the truncate right in order to open files
for writing, but this may be the logical thing to do.

Let me know what you think!

—Günther

>
> The rationale goes as follows:
>
> * ftruncate() is already adequately protected by the
>   LL_ACCESS_FS_WRITE_FILE right. ftruncate is only permitted on fds
>   that are open for writing.
> * truncate() is not Landlock-restrictable in Landlock ABI v1,
>   so needs to be covered by the new truncate right.
> * open() for reading with O_TRUNC is also not Landlock-restrictable in
>   Landlock ABI v1, so needs to be covered by the new truncate right.
> * open() for writing with O_TRUNC is also not Landlock-restrictable in
>   Landlock ABI v1. BUT: A caller who can open the file for writing
>   will also be able to ftruncate it - so it doesn't really make sense
>   to ask for a different Landlock right here.
>
> Does that approach make sense to you?
>
> I think in terms of changs required for it, it sounds like it would
> require a change to the path_truncate LSM hook to distinguish the
> cases above.
>
> Do you want a new patch on top of the existing one, or should I rather
> create a new version of the old truncate patch set?
>
> --Günther
>
> > On 17/08/2022 22:30, Günther Noack wrote:
> > > The goal of these patches is to work towards a more complete coverage
> > > of file system operations that are restrictable with Landlock.
> > >
> > > The known set of currently unsupported file system operations in
> > > Landlock is described at [1]. Out of the operations listed there,
> > > truncate is the only one that modifies file contents, so these patches
> > > should make it possible to prevent the direct modification of file
> > > contents with Landlock.
> > >
> > > The patch introduces the truncation restriction feature as an
> > > additional bit in the access_mask_t bitmap, in line with the existing
> > > supported operations.
> > >
> > > The truncation flag covers both the truncate(2) and ftruncate(2)
> > > families of syscalls, as well as open(2) with the O_TRUNC flag.
> > > This includes usages of creat() in the case where existing regular
> > > files are overwritten.
> > >
> > > Apart from Landlock, file truncation can also be restricted using
> > > seccomp-bpf, but it is more difficult to use (requires BPF, requires
> > > keeping up-to-date syscall lists) and it is not configurable by file
> > > hierarchy, as Landlock is. The simplicity and flexibility of the
> > > Landlock approach makes it worthwhile adding.
> > >
> > > While it's possible to use the "write file" and "truncate" rights
> > > independent of each other, it simplifies the mental model for
> > > userspace callers to always use them together.
> > >
> > > Specifically, the following behaviours might be surprising for users
> > > when using these independently:
> > >
> > >   * The commonly creat() syscall requires the truncate right when
> > >     overwriting existing files, as it is equivalent to open(2) with
> > >     O_TRUNC|O_CREAT|O_WRONLY.
> > >   * The "write file" right is not always required to truncate a file,
> > >     even through the open(2) syscall (when using O_RDONLY|O_TRUNC).
> > >
> > > Nevertheless, keeping the two flags separate is the correct approach
> > > to guarantee backwards compatibility for existing Landlock users.
> > >
> > > These patches are based on version 6.0-rc1.
> > >
> > > Best regards,
> > > Günther
> > >
> > > [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> > >
> > > Past discussions:
> > > V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> > > V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
> > > V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
> > > V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
> > >
> > > Changelog:
> > >
> > > V5:
> > > * Documentation
> > >    * Fix wording in userspace-api headers and in landlock.rst.
> > >    * Move the truncation limitation section one to the bottom.
> > >    * Move all .rst changes into the documentation commit.
> > > * selftests
> > >    * Remove _metadata argument from helpers where it became unnecessary.
> > >    * Open writable file descriptors at the top of both tests, before Landlock
> > >      is enabled, to exercise ftruncate() independently from open().
> > >    * Simplify test_ftruncate and decouple it from exercising open().
> > >    * test_creat(): Return errno on close() failure (it does not conflict).
> > >    * Fix /* comment style */
> > >    * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
> > >    * Add missing |O_TRUNC to a check in one test.
> > >    * Put the truncate_unhandled test before the other.
> > >
> > > V4:
> > >   * Documentation
> > >     * Clarify wording and syntax as discussed in review.
> > >     * Use a less confusing error message in the example.
> > >   * selftests:
> > >     * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
> > >       (This is an intentionally uncommon error code, so that the source
> > >       of the error is clear and the test can distinguish test setup
> > >       failures from failures in the actual system call under test.)
> > >   * samples/Documentation:
> > >     * Use additional clarifying comments in the kernel backwards
> > >       compatibility logic.
> > >
> > > V3:
> > >   * selftests:
> > >     * Explicitly test ftruncate with readonly file descriptors
> > >       (returns EINVAL).
> > >     * Extract test_ftruncate, test_truncate, test_creat helpers,
> > >       which simplified the previously mixed usage of EXPECT/ASSERT.
> > >     * Test creat() behaviour as part of the big truncation test.
> > >     * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
> > >       This simplifies the tests a bit. The kernel implementations are the
> > >       same as for truncate(2) and ftruncate(2), so there is little benefit
> > >       from testing them exhaustively. (We aren't testing all open(2)
> > >       variants either.)
> > >   * samples/landlock/sandboxer.c:
> > >     * Use switch() to implement best effort mode.
> > >   * Documentation:
> > >     * Give more background on surprising truncation behaviour.
> > >     * Use switch() in the example too, to stay in-line with the sample tool.
> > >     * Small fixes in header file to address previous comments.
> > > * misc:
> > >    * Fix some typos and const usages.
> > >
> > > V2:
> > >   * Documentation: Mention the truncation flag where needed.
> > >   * Documentation: Point out connection between truncation and file writing.
> > >   * samples: Add file truncation to the landlock/sandboxer.c sample tool.
> > >   * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
> > >   * selftests: Exercise truncation syscalls when the truncate right
> > >     is not handled by Landlock.
> > >
> > > Günther Noack (4):
> > >    landlock: Support file truncation
> > >    selftests/landlock: Selftests for file truncation support
> > >    samples/landlock: Extend sample tool to support
> > >      LANDLOCK_ACCESS_FS_TRUNCATE
> > >    landlock: Document Landlock's file truncation support
> > >
> > >   Documentation/userspace-api/landlock.rst     |  52 +++-
> > >   include/uapi/linux/landlock.h                |  17 +-
> > >   samples/landlock/sandboxer.c                 |  23 +-
> > >   security/landlock/fs.c                       |   9 +-
> > >   security/landlock/limits.h                   |   2 +-
> > >   security/landlock/syscalls.c                 |   2 +-
> > >   tools/testing/selftests/landlock/base_test.c |   2 +-
> > >   tools/testing/selftests/landlock/fs_test.c   | 257 ++++++++++++++++++-
> > >   8 files changed, 336 insertions(+), 28 deletions(-)
> > >
> > >
> > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > --
> > > 2.37.2
>
> --

--
