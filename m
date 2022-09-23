Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80675E811C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiIWRu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIWRu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:50:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41A53D1B;
        Fri, 23 Sep 2022 10:50:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b35so1277932edf.0;
        Fri, 23 Sep 2022 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Ni29tjS3Hw4tGE/3CqxcnWG6R4VNkp8dMW8hLmThRR0=;
        b=gkk5a+qFdycLQsd1+XQBb7mFKbYD60XO6meTGnCtuKD/ZnDfjf6JvZtqTiz+E2cX2V
         9QWvBjbKXx++2qgdLJjTfczv74zwVdyIpehZtx+O4IjwjgUnwC6jhWomuaR3HrPJWE6F
         i/PomlRrhYrT64sNVlnbcmBMTngzRwzAVjfEPw9sDWWu61AVubb9uxFj9Ni02J7GoFSX
         aQb1ooDLtSgcNFAtzsR/mDh9rBRray4etVlgubwAhJ2tuXiXJOlG0sBeWVkQSjCF43mD
         XHW+m5M1ta1T32ZfSXNd/3ERtdyQIlCktdm47IR1OjJxCGm42eHAia+YykZpguuzJlYh
         KJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ni29tjS3Hw4tGE/3CqxcnWG6R4VNkp8dMW8hLmThRR0=;
        b=aR8jIX2BLI2K4flf5i0VFBt6LR9ZfIKfLEssVl0rrLLgpm9pXd1bc4T9cxFfA53JIL
         Li1lGjDKYFi5q6vT61P747w0fmrIqnANjmfX30s3JbYLPF12Bl9BtvSQ4qLYK0ZMX263
         29hFX2bfgvBUA87nKzrU6q5bzFMDp2wAUpZr67GnMAOkwGcnOMX4jE9YBkE6Ja4lDSdT
         fjnmKaSnk5V/tU3pUTOxxxkNiie5DMhEmEMJl+0twWa4dm37ewLbQVzCkTZtFK2ABYoo
         yQeQA9fsz7B7NEYGiF+mggYuu21xZKHfqujDAo6tCz7INstwAwW0kS/tJuppqh7GkuyQ
         x1Xw==
X-Gm-Message-State: ACrzQf0P3e0aizClCrYV0MIpw4PKGIMsyr14NRu+JzTI5tg2IjA+Zghs
        LnRZmNobeyLrzhkIo8IdNksAZMg37HA=
X-Google-Smtp-Source: AMsMyM5jOHm0uRKQwITdvwb3qhVYSEJW6AG16LEd6nDLZ6hhG1wbAq/E2LCk9+krbCCgFFedtIQ6NA==
X-Received: by 2002:a05:6402:35c5:b0:450:4b7d:9c49 with SMTP id z5-20020a05640235c500b004504b7d9c49mr9663203edc.149.1663955423761;
        Fri, 23 Sep 2022 10:50:23 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7c847000000b0044e01e2533asm1623436edt.43.2022.09.23.10.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:50:23 -0700 (PDT)
Date:   Fri, 23 Sep 2022 19:50:21 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 3/5] selftests/landlock: Selftests for file truncation
 support
Message-ID: <Yy3x3b3+CrD/rb0J@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-4-gnoack3000@gmail.com>
 <3f3b7798-c3e1-e257-5094-0033e7605062@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f3b7798-c3e1-e257-5094-0033e7605062@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 07:05:44PM +0200, Mickaël Salaün wrote:
> I'd like to have tests similar to base_test.c:ruleset_fd_transfer to check
> ftruncate with different kind of file descriptors and not-sandboxed
> processes. That would require some code refactoring to reuse the FD passing
> code.

Done. I factored out the FD sending and receiving into helper function in common.h.

> On 08/09/2022 21:58, Günther Noack wrote:
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 87b28d14a1aa..ddc8c7e57e86 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > ...
> > +TEST_F_FORK(layout1, truncate)
> > +{
> > +	const char *const file_rwt = file1_s1d1;
> > +	const char *const file_rw = file2_s1d1;
> > +	const char *const file_rt = file1_s1d2;
> > +	const char *const file_t = file2_s1d2;
> > +	const char *const file_none = file1_s1d3;
> > +	const char *const dir_t = dir_s2d1;
> > +	const char *const file_in_dir_t = file1_s2d1;
> > +	const char *const dir_w = dir_s3d1;
> > +	const char *const file_in_dir_w = file1_s3d1;
> > +	int file_rwt_fd, file_rw_fd;
> 
> These variables are unused now.

Good catch, done.

> > +TEST_F_FORK(layout1, ftruncate)
> 
> Great!
> 
> > +{
> > +	/*
> > +	 * This test opens a new file descriptor at different stages of
> > +	 * Landlock restriction:
> > +	 *
> > +	 * without restriction:                    ftruncate works
> > +	 * something else but truncate restricted: ftruncate works
> > +	 * truncate restricted and permitted:      ftruncate works
> > +	 * truncate restricted and not permitted:  ftruncate fails
> > +	 *
> > +	 * Whether this works or not is expected to depend on the time when the
> > +	 * FD was opened, not to depend on the time when ftruncate() was
> > +	 * called.
> > +	 */
> > +	const char *const path = file1_s1d1;
> > +	int fd0, fd1, fd2, fd3;
> 
> You can rename them fd_layer0, fd_layer1…

Done.

> > +	fd0 = open(path, O_WRONLY);
> > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > +
> > +	landlock_single_path(_metadata, path,
> > +			     LANDLOCK_ACCESS_FS_READ_FILE |
> > +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
> 
> I'd prefer to follow the current way to write rule layers: write all struct
> rule at first and then call each enforcement steps. It is a bit more verbose
> but easier to understand errors. The list of test_ftruncate checks are
> straightforward to follow.

Done.


> > +	fd1 = open(path, O_WRONLY);
> > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > +
> > +	landlock_single_path(_metadata, path, LANDLOCK_ACCESS_FS_TRUNCATE,
> > +			     LANDLOCK_ACCESS_FS_TRUNCATE);
> > +
> > +	fd2 = open(path, O_WRONLY);
> > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > +	EXPECT_EQ(0, test_ftruncate(fd2));
> > +
> > +	landlock_single_path(_metadata, path,
> > +			     LANDLOCK_ACCESS_FS_TRUNCATE |
> > +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
> > +
> > +	fd3 = open(path, O_WRONLY);
> > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > +	EXPECT_EQ(0, test_ftruncate(fd2));
> > +	EXPECT_EQ(EACCES, test_ftruncate(fd3));
> > +
> > +	ASSERT_EQ(0, close(fd0));
> > +	ASSERT_EQ(0, close(fd1));
> > +	ASSERT_EQ(0, close(fd2));
> > +	ASSERT_EQ(0, close(fd3));
> > +}
> > +
> >   /* clang-format off */
> >   FIXTURE(layout1_bind) {};
> >   /* clang-format on */

-- 
