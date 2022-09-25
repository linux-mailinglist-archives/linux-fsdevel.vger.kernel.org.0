Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756E5E9556
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIYSKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiIYSK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:10:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387F1C92C;
        Sun, 25 Sep 2022 11:10:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nb11so9919097ejc.5;
        Sun, 25 Sep 2022 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=WL4FcDDRn7CBCsx9iuFDQKIHfIbZOER+6dU8Fb4faT0=;
        b=Riit7OVBKB4Av+C9OabXAo7a+1d3a99IErAGLHVW1ZlmpL7PAuSbnT/JFfNBg3xbkC
         z1ebmIcHnIoGRftEeH9N5t6Xo5eBclCP+21x/VrnZgCZgaJeYSVSWdP+kHFCvn/c7vNe
         AdX5ovMVdZprIyPwKtglCm4D2nSY20IqG6wyA4zXq+hCR3fPhBQm8ktn13Y0FTRDV3fx
         nT0zZ0rj2+k81AsSiDE+zDvYR1k7A3pbZhOICRJLci0unPOdlfnKdGxmzTQzxdo4YcA0
         sPC7Lm+OLSmQ5uhMGHmOX3nYzjmvSfej0PSbtI+rde7LNks8EvX1W7q9GDAeoNk8bzsW
         +xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WL4FcDDRn7CBCsx9iuFDQKIHfIbZOER+6dU8Fb4faT0=;
        b=SjwefrKDiVIYF9g53t31tyfB5/fLtBzrM29ftf8KGRvEiWY6Lb/lA0o/n2ROsh9O9I
         2ikNb4SvFOUnR1tyIjZSETvIc+uhO4omDtfpJUu8QTkkUuvOJ3xjuNJVWLzh21p3sivz
         nTb234lOTXdxUtEgiV4opTHPtb/ytERNOfb82a/08rI0kUvTrFyamZWBEstwhtmwkeEQ
         Ki5bSyH0fBRrhKxGKddu8fRiRkduVrWXk9I9labbI7MR+LQD2tphtPcp2DTAvruiW2nI
         Jw+Rq92VcHsbfDyNi106KIRh6NQS8iyPeX+5tZH8xre1S2lAolG4x+X5aGQY1ce817HN
         S6tg==
X-Gm-Message-State: ACrzQf3Mi3/GDCgKD08i7k9FEVWsSGeR34RBcDYntfEzIzSn1n05bZeQ
        RuXvy5Wcrektq0KyslRgRP4=
X-Google-Smtp-Source: AMsMyM7iXN8X6v2DK5A6rGAQNV4JdUJ7sL8ZcXEQHA2Clp+Kui7j1BHYpRAKaYrwEE3gE7ccot+8nQ==
X-Received: by 2002:a17:907:7206:b0:783:1d78:6249 with SMTP id dr6-20020a170907720600b007831d786249mr4920086ejc.9.1664129408261;
        Sun, 25 Sep 2022 11:10:08 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7db8a000000b004571fc9112dsm2179040edt.83.2022.09.25.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 11:10:07 -0700 (PDT)
Date:   Sun, 25 Sep 2022 20:10:06 +0200
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
Message-ID: <YzCZfiwIVOcjCxQo@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-4-gnoack3000@gmail.com>
 <3f3b7798-c3e1-e257-5094-0033e7605062@digikod.net>
 <Yy3x3b3+CrD/rb0J@nuc>
 <5233611f-1dba-3ecb-670f-fff61820e9d6@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5233611f-1dba-3ecb-670f-fff61820e9d6@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:54:55PM +0200, Mickaël Salaün wrote:
> 
> On 23/09/2022 19:50, Günther Noack wrote:
> > On Fri, Sep 16, 2022 at 07:05:44PM +0200, Mickaël Salaün wrote:
> > > I'd like to have tests similar to base_test.c:ruleset_fd_transfer to check
> > > ftruncate with different kind of file descriptors and not-sandboxed
> > > processes. That would require some code refactoring to reuse the FD passing
> > > code.
> > 
> > Done. I factored out the FD sending and receiving into helper function in common.h.
> 
> Please use a dedicated patch for this refactoring.

+1, will do.

> > > On 08/09/2022 21:58, Günther Noack wrote:
> > > > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > > > index 87b28d14a1aa..ddc8c7e57e86 100644
> > > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > > +++ b/tools/testing/selftests/landlock/fs_test.c
> > > > ...
> > > > +TEST_F_FORK(layout1, truncate)
> > > > +{
> > > > +	const char *const file_rwt = file1_s1d1;
> > > > +	const char *const file_rw = file2_s1d1;
> > > > +	const char *const file_rt = file1_s1d2;
> > > > +	const char *const file_t = file2_s1d2;
> > > > +	const char *const file_none = file1_s1d3;
> > > > +	const char *const dir_t = dir_s2d1;
> > > > +	const char *const file_in_dir_t = file1_s2d1;
> > > > +	const char *const dir_w = dir_s3d1;
> > > > +	const char *const file_in_dir_w = file1_s3d1;
> > > > +	int file_rwt_fd, file_rw_fd;
> > > 
> > > These variables are unused now.
> > 
> > Good catch, done.
> > 
> > > > +TEST_F_FORK(layout1, ftruncate)
> > > 
> > > Great!
> > > 
> > > > +{
> > > > +	/*
> > > > +	 * This test opens a new file descriptor at different stages of
> > > > +	 * Landlock restriction:
> > > > +	 *
> > > > +	 * without restriction:                    ftruncate works
> > > > +	 * something else but truncate restricted: ftruncate works
> > > > +	 * truncate restricted and permitted:      ftruncate works
> > > > +	 * truncate restricted and not permitted:  ftruncate fails
> > > > +	 *
> > > > +	 * Whether this works or not is expected to depend on the time when the
> > > > +	 * FD was opened, not to depend on the time when ftruncate() was
> > > > +	 * called.
> > > > +	 */
> > > > +	const char *const path = file1_s1d1;
> > > > +	int fd0, fd1, fd2, fd3;
> > > 
> > > You can rename them fd_layer0, fd_layer1…
> > 
> > Done.
> > 
> > > > +	fd0 = open(path, O_WRONLY);
> > > > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > > > +
> > > > +	landlock_single_path(_metadata, path,
> > > > +			     LANDLOCK_ACCESS_FS_READ_FILE |
> > > > +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > > +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
> > > 
> > > I'd prefer to follow the current way to write rule layers: write all struct
> > > rule at first and then call each enforcement steps. It is a bit more verbose
> > > but easier to understand errors. The list of test_ftruncate checks are
> > > straightforward to follow.
> > 
> > Done.
> > 
> > 
> > > > +	fd1 = open(path, O_WRONLY);
> > > > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > > > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > > > +
> > > > +	landlock_single_path(_metadata, path, LANDLOCK_ACCESS_FS_TRUNCATE,
> > > > +			     LANDLOCK_ACCESS_FS_TRUNCATE);
> > > > +
> > > > +	fd2 = open(path, O_WRONLY);
> > > > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > > > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > > > +	EXPECT_EQ(0, test_ftruncate(fd2));
> > > > +
> > > > +	landlock_single_path(_metadata, path,
> > > > +			     LANDLOCK_ACCESS_FS_TRUNCATE |
> > > > +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > > +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
> > > > +
> > > > +	fd3 = open(path, O_WRONLY);
> > > > +	EXPECT_EQ(0, test_ftruncate(fd0));
> > > > +	EXPECT_EQ(0, test_ftruncate(fd1));
> > > > +	EXPECT_EQ(0, test_ftruncate(fd2));
> > > > +	EXPECT_EQ(EACCES, test_ftruncate(fd3));
> > > > +
> > > > +	ASSERT_EQ(0, close(fd0));
> > > > +	ASSERT_EQ(0, close(fd1));
> > > > +	ASSERT_EQ(0, close(fd2));
> > > > +	ASSERT_EQ(0, close(fd3));
> > > > +}
> > > > +
> > > >    /* clang-format off */
> > > >    FIXTURE(layout1_bind) {};
> > > >    /* clang-format on */
> > 

-- 
