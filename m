Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024DF57084D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiGKQ1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGKQ1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:27:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF897AC08;
        Mon, 11 Jul 2022 09:27:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so6923937edb.9;
        Mon, 11 Jul 2022 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jT4WgOrzr/K5nITEzr9CubaQA9Q32Mwo7fDrHfdz6uE=;
        b=fJMeBQ//91zD5LG89X1qnpt/6IZLJXpmOFbfxQa1Y5lfZe9VZy1fmEozXpidvh5HCW
         hgDhexscFta0GKUjVWJLvoQNcUEQOYCKspzT7IoiW3CDPguEd5xTTosvtDPzltE29tgb
         f3CCJiFqe09WooWfkt/POlyAdbPMx+6HoiIXno4e84R+kQ6M5gUfUghuQPmRPzC5hMpt
         tk3WUM4xUuYTo//KYMuHMdm6Z9hx1kr/aL//oPzNOTdbI8uVWsxrvCbis1sSUcVcmh/F
         /6mij6UFTrAmc6WPWe7mZzFqgCBd3s514lufAmtyDdj1c/+m36wiJi5CjJjp9pipTNl1
         u7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jT4WgOrzr/K5nITEzr9CubaQA9Q32Mwo7fDrHfdz6uE=;
        b=UNdSNWU0cLXLnceGGQ5aJNPXfGk1Pv8ggmVkrsw3kBx6H7O7dWRonOYvhzTOdfQGM1
         Ip1MwEIWQb6zh8vlPIPAl2O4K81OVBCBNr6vUIrgs3RaYeKEax4R/v0SLyb/P4L4Ia6b
         z2h9Eccd3Nrbn7CKgcXb0XFUVqpATCIKocycz/BLk/cVzrAqLLY7vb+yVLqdbnsMXL6y
         glC52OaqDHW7Jk4madU1ITlzE7DIFzqtrCH1AqCqA44YLVeZXi1S1AkcTMYHteFTEFFi
         nzWi6fq3n2tzOwIjW+G8ige46qkckLWdo2QDRAq08z6phZPLpsNn0UGOWG1rgNw9xOjP
         CW2w==
X-Gm-Message-State: AJIora/myRBI2mCL++1a6s4GfyHUSUafwvbJRMsbP1AM9gdhfECYYTts
        JVYVc6lDDo7rGT5UuiA6/TI5+th2Zlc=
X-Google-Smtp-Source: AGRyM1sfY8U15IPtj/TZKpbpRk4dWvFuCMwf/n6x/SauNq8WjcqBeUXy9vyMeAjHAnA+P4QDiSZVfA==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr25115004eda.151.1657556868425;
        Mon, 11 Jul 2022 09:27:48 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id ca15-20020a170906a3cf00b0072b2cc08c48sm2798427ejb.63.2022.07.11.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 09:27:47 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:27:46 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH 2/2] landlock: Selftests for truncate(2) support.
Message-ID: <YsxPgm30TUOxJbzS@nuc>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-3-gnoack3000@gmail.com>
 <f93e7b0f-8782-248f-df9a-4670ede67dae@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f93e7b0f-8782-248f-df9a-4670ede67dae@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 01:17:46PM +0200, Mickaël Salaün wrote:
> Please use "selftests/landlock:" as subject prefix and without a final dot.
>
>
> On 07/07/2022 22:06, Günther Noack wrote:
> > These tests exercise the following scenarios:
> >
> > * File with Read, Write, Truncate rights.
>
> Should we use a capital for access right names or does it come from Go? ;)

Done. Will be included in the next version.

>
>
> > * File with Read, Write rights.
> > * File with Truncate rights.
> > * File with no rights.
> > * Directory with Truncate rights.
> >
> > For each of the scenarios, both truncate() and the open() +
> > ftruncate() syscalls get exercised and their results checked.
> >
> > In particular, the test demonstrates that opening a file for writing
> > is not enough to call truncate().
>
> Looks good! According to my previous comment, O_TRUNC should be tested if it
> is checked by the kernel.

Done. Will be included in the next version.

>
>
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 80 ++++++++++++++++++++++
> >   1 file changed, 80 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index cb77eaa01c91..c3e48fd12b2b 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -2237,6 +2237,86 @@ TEST_F_FORK(layout1, reparent_rename)
> >   	ASSERT_EQ(EXDEV, errno);
> >   }
> > +TEST_F_FORK(layout1, truncate)
>
> Please move this test after the proc_pipe one.

Done. Will be included in the next version.

>
>
> > +{
> > +	const struct rule rules[] = {
>
> You can add a first layer of rules to check truncate and ftruncate with a
> ruleset not handling LANDLOCK_ACCESS_FS_TRUNCATE.

Done. I'll add a separate test for that which will exercise the
various truncation APIs in a scenario where the ruleset does not
handle LANDLOCK_ACCESS_FS_TRUNCATE, so that it's not restricted.

Will be included in the next version.

>
>
> > +		{
> > +			.path = file1_s1d1,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> > +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		{
> > +			.path = file2_s1d2,
> > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +		},
> > +		{
> > +			.path = file1_s1d2,
> > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
>
> Move this entry before file2_s1d2 to keep the paths sorted and make this
> easier to read. You can change the access rights per path to also keep their
> ordering though.

I've admittedly found it difficult to remember which of these files
and subdirectories exist and how they are named and mixed up the names
at least twice when developing these tests. To make it easier, I've now
renamed these by including this at the top of the test:

char *file_rwt = file1_s1d1;
char *file_rw = file2_s1s1;
// etc

With the test using names like file_rwt, I find that easier to work
with and found myself jumping less between the "rules" on top and the
place where the assertions are written out.

This is admittedly a bit out of line with the other tests, but maybe
it's worth doing? Let me know what you think.

>
>
> > +		{
> > +			.path = dir_s2d3,
> > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > +		},
> > +		// Implicitly: No access rights for file2_s1d1.
>
> Comment to move after the use of file1_s1d1.

I'm understanding this as "keep the files in order according to the
layout". I've reshuffled things a bit by renaming them, but this is
also in the right order now.

>
> > +		{},
> > +	};
> > +	const int ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, rules);
>
> Don't use ACCESS_ALL because it will change over time and we want tests to
> be deterministic. You can use rules[0].access instead.
>
>
> > +	int reg_fd;
> > +
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* Read, write and truncate permissions => truncate and ftruncate work. */
>
> It would be nice to have consistent comments such as: "Checks read, write
> and truncate access rights: truncate and ftruncate work."

Done. Will be included in next version.

>
>
> > +	reg_fd = open(file1_s1d1, O_RDWR | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
>
> You should not use EXPECT but ASSERT here. I use EXPECT when an error could
> block a test or when it could stop a cleanup (i.e. teardown).

ASSERT is the variant that stops the test immediately, whereas EXPECT
notes down the test failure and continues execution.

So in that spirit, I tried to use:

 * ASSERT for successful open() calls where the FD is still needed later
 * ASSERT for close() (for symmetry with open())
 * EXPECT for expected-failing open() calls where the FD is not used later
 * EXPECT for everything else

I had another pass over the tests and have started to use EXPECT for a
few expected-failing open() calls.

The selftest framework seems inspired by the Googletest framework
(https://google.github.io/googletest/primer.html#assertions) where
this is described as: "Usually EXPECT_* are preferred, as they allow
more than one failure to be reported in a test. However, you should
use ASSERT_* if it doesn’t make sense to continue when the assertion
in question fails."

I imagined that the same advice would apply to the kernel selftests?
Please let me know if I'm overlooking subtle differences here.

>
>
> > +	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	EXPECT_EQ(0, truncate(file1_s1d1, 10));
> > +	EXPECT_EQ(0, truncate64(file1_s1d1, 20));
> > +
> > +	/* Just read and write permissions => no truncate variant works. */
> > +	reg_fd = open(file2_s1d2, O_RDWR | O_CLOEXEC);
> > +	ASSERT_LE(0, reg_fd);
> > +	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
> > +	EXPECT_EQ(EACCES, errno);
> > +	ASSERT_EQ(0, close(reg_fd));
> > +
> > +	EXPECT_EQ(-1, truncate(file2_s1d2, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, truncate64(file2_s1d2, 20));
> > +	EXPECT_EQ(EACCES, errno);
> > +
> > +	/* Just truncate permissions => truncate(64) works, but can't open file. */
> > +	ASSERT_EQ(-1, open(file1_s1d2, O_RDWR | O_CLOEXEC));
> > +	ASSERT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(0, truncate(file1_s1d2, 10));
> > +	EXPECT_EQ(0, truncate64(file1_s1d2, 20));
> > +
> > +	/* Just truncate permission on directory => truncate(64) works, but can't open file. */
> > +	ASSERT_EQ(-1, open(file1_s2d3, O_RDWR | O_CLOEXEC));
> > +	ASSERT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(0, truncate(file1_s2d3, 10));
> > +	EXPECT_EQ(0, truncate64(file1_s2d3, 20));
> > +
> > +	/* No permissions => Neither truncate nor ftruncate work. */
> > +	ASSERT_EQ(-1, open(file2_s1d1, O_RDWR | O_CLOEXEC));
> > +	ASSERT_EQ(EACCES, errno);
> > +
> > +	EXPECT_EQ(-1, truncate(file2_s1d1, 10));
> > +	EXPECT_EQ(EACCES, errno);
> > +	EXPECT_EQ(-1, truncate64(file2_s1d1, 20));
> > +	EXPECT_EQ(EACCES, errno);
>
> These tests are good!

Thanks :)

>
> > +}
> > +
> >   static void
> >   reparent_exdev_layers_enforce1(struct __test_metadata *const _metadata)
> >   {

--
