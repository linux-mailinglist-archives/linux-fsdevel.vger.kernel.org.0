Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B26589F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiHDQMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHDQMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:12:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C32AC5F;
        Thu,  4 Aug 2022 09:12:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so206522ejc.1;
        Thu, 04 Aug 2022 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PpPG5wYCRZsq069IvYn+22mm1mwA+6w1okB2tdTtwBw=;
        b=NKR2MIHsuPw766Og+Rlaad52ijTLne3TmUqPa5QhxC/l5pKQ0TwoJ4LMjIsqs65Xue
         QlVWJyb+TXvQo5mNzva/wKBJYM2OxkdafPhIx6rrDwsjaN/whrgs6ZArTJt7fnUIZkOb
         KTtELO0ahezasckbHpkoHiOR3LqYULnNfNi7GkKOMGzCXBx2rHZBNTp5dV/UkEStQhkA
         tfe2SScMDUJyC5NumgG9XYlpPQ4BBTsdHZpmwpE4g1llrpQbPseuqFoIR5+SWkUhAzCX
         yNkDOAFEPH+3grbs955ol69lRJvzC3bXD2fOLbDx/CtU02GWzXAKcm88JFtZ7ASotRLN
         vfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PpPG5wYCRZsq069IvYn+22mm1mwA+6w1okB2tdTtwBw=;
        b=vueXfWKVTS/Ajb1FwPyWKUPpWYk9IpV/dl1L47DbMuvz7ts6WNIqpzwV5lz1dr0oLh
         69qMo/8AZF41aZklbrqxVWrRo+V78dQldgemlLj814qkEMO3o8+f0Z61wDsZGydgFhTJ
         kIQx3fiUR/KHO6TJV+ZjYZiTWSSj9pY2UMxizUBKNpt6vdeMI5PrVs9yl42iHRnrwCtm
         O4PvgygYGJ2G0ZB7PQEwkKDXnyORCoQPACXhNBajaWnx0FzWmpmrmWMH20GoALKC/Q98
         zmRmLFTTLwG5QDFz/yEvp7AUmHmTrvTJ18GqWmzbUzzQ0dAkKjlMiTc2rFlruG4n/oVl
         1WEg==
X-Gm-Message-State: ACgBeo0Ot4AXvbUiaqYwqq1T2LDxk7DRPWMX9JDHhYi67d87gIp8/L9y
        PURI3pEzD7FEFltT65J1bH0=
X-Google-Smtp-Source: AA6agR4W+gW6Ys5Cn6Yv8+sZbgYemFVVg9/qSduyEIxKty4XUaFFUawfco3KdxlcGwZp17F98ooXnQ==
X-Received: by 2002:a17:907:72ce:b0:730:c053:9870 with SMTP id du14-20020a17090772ce00b00730c0539870mr2011876ejc.480.1659629537518;
        Thu, 04 Aug 2022 09:12:17 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073022b796a7sm494810eja.93.2022.08.04.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:12:16 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:12:15 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH 2/2] landlock: Selftests for truncate(2) support.
Message-ID: <Yuvv34OiMeWRTYdV@nuc>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-3-gnoack3000@gmail.com>
 <f93e7b0f-8782-248f-df9a-4670ede67dae@digikod.net>
 <YsxPgm30TUOxJbzS@nuc>
 <c8964ea0-df91-da78-89c6-85fb02a6a3bc@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8964ea0-df91-da78-89c6-85fb02a6a3bc@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:30:24PM +0200, Mickaël Salaün wrote:
> On 11/07/2022 18:27, Günther Noack wrote:
> > On Fri, Jul 08, 2022 at 01:17:46PM +0200, Mickaël Salaün wrote:
>
> [...]
>
> > >
> > > > +		{
> > > > +			.path = file1_s1d1,
> > > > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > > > +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> > > > +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> > > > +		},
> > > > +		{
> > > > +			.path = file2_s1d2,
> > > > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > > > +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > > +		},
> > > > +		{
> > > > +			.path = file1_s1d2,
> > > > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > > > +		},
> > >
> > > Move this entry before file2_s1d2 to keep the paths sorted and make this
> > > easier to read. You can change the access rights per path to also keep their
> > > ordering though.
> >
> > I've admittedly found it difficult to remember which of these files
> > and subdirectories exist and how they are named and mixed up the names
> > at least twice when developing these tests. To make it easier, I've now
> > renamed these by including this at the top of the test:
> >
> > char *file_rwt = file1_s1d1;
> > char *file_rw = file2_s1s1;
> > // etc
> >
> > With the test using names like file_rwt, I find that easier to work
> > with and found myself jumping less between the "rules" on top and the
> > place where the assertions are written out.
> >
> > This is admittedly a bit out of line with the other tests, but maybe
> > it's worth doing? Let me know what you think.
>
> It indeed makes things clearer.
>
>
> >
> > >
> > >
> > > > +		{
> > > > +			.path = dir_s2d3,
> > > > +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> > > > +		},
> > > > +		// Implicitly: No access rights for file2_s1d1.
> > >
> > > Comment to move after the use of file1_s1d1.
> >
> > I'm understanding this as "keep the files in order according to the
> > layout". I've reshuffled things a bit by renaming them, but this is
> > also in the right order now.
>
> Right.
>
> [...]
>
> > > > +	reg_fd = open(file1_s1d1, O_RDWR | O_CLOEXEC);
> > > > +	ASSERT_LE(0, reg_fd);
> > > > +	EXPECT_EQ(0, ftruncate(reg_fd, 10));
> > >
> > > You should not use EXPECT but ASSERT here. I use EXPECT when an error could
> > > block a test or when it could stop a cleanup (i.e. teardown).
> >
> > ASSERT is the variant that stops the test immediately, whereas EXPECT
> > notes down the test failure and continues execution.
> >
> > So in that spirit, I tried to use:
> >
> >   * ASSERT for successful open() calls where the FD is still needed later
> >   * ASSERT for close() (for symmetry with open())
> >   * EXPECT for expected-failing open() calls where the FD is not used later
> >   * EXPECT for everything else
>
> I understand your logic, but this gymnastic adds complexity to writing tests
> (which might be difficult to explain) for not much gain. Indeed, all these
> tests should pass, except if we add a SKIP (cf.
> https://lore.kernel.org/all/20220628222941.2642917-1-jeffxu@google.com/).
>
> In the case of an open FD, it will not be an issue to not close it if a test
> failed, which is not the same with FIXTURE_TEARDOWN where we want the
> workspace to be clean after tests, whether they succeeded or failed.
>
>
> >
> > I had another pass over the tests and have started to use EXPECT for a
> > few expected-failing open() calls.
> >
> > The selftest framework seems inspired by the Googletest framework
> > (https://google.github.io/googletest/primer.html#assertions) where
> > this is described as: "Usually EXPECT_* are preferred, as they allow
> > more than one failure to be reported in a test. However, you should
> > use ASSERT_* if it doesn’t make sense to continue when the assertion
> > in question fails."
>
> I think this is good in theory, but in practice, at least for the Landlock
> selftests, everything should pass. Any test failure is a blocker because it
> breaks the contract with users.
>
> I find it very difficult to write tests that would check as much as
> possible, even if some of these tests failed, without unexpected behaviors
> (e.g. blocking the whole tests, writing to unexpected locations…) because it
> changes the previous state from a known state to a set of potential states
> (e.g. when creating or removing files). Doing it generically increases
> complexity for tests which may already be difficult to understand. When
> investigating a test failure, we can still replace some ASSERT with EXPECT
> though.

After some other refactorings you suggested (which I'll post soon),
the bulk of the test code now just consists of long stretches of

  EXPECT_EQ(0, test_open(...));
  EXPECT_EQ(0, test_truncate(...));
  EXPECT_EQ(EACCES, test_ftruncate(...));

So these are actually reasonably independent and don't interact much,
which means that printing multiple independent failures is not too
hard. There are a bunch of ASSERT usages left, but they are hidden in
the test_foo() helpers.

I suspect you would be ok with it now, and I'll try to send the next
patch version still with EXPECT. If you still feel strongly about it,
please let me know.

(The classic JUnit/XUnit test frameworks only have an equivalent to
ASSERT and crash early during tests. On the other hand, in these
frameworks, there is also more emphasis on writing a larger number of
narrower test cases instead of the long chains of assertions and
expectations that we use here.)

>
>
> >
> > I imagined that the same advice would apply to the kernel selftests?
> > Please let me know if I'm overlooking subtle differences here.
>
> I made kselftest_harness.h generally available (outside of seccomp) but I
> guess each subsystem maintainer might handle that differently.
>
> See
> https://lore.kernel.org/all/1b043379-b6eb-d272-c9b9-25c6960e1ef1@digikod.net/
> for similar concerns.

--
