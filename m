Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84C788CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjHYPvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbjHYPvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:51:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435852135
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 08:51:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fb8933e18so14615477b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692978672; x=1693583472;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzPqSgYN1ipk63Sp/vabDCOnAXcV4ryfpRQU/BRuK1g=;
        b=goc9Lw4cPrLtJDFHcQ5rTDQnrzSd/BBg6No83MW0vwqjfd0+dmjXvED2IaSEOxOYEA
         4+FFxOV+zeakWXctti2m3apQNtkz2EBnl7vuUxjYOe9Rv8SdBhjBXzFXQE3s+T1KXWRO
         9LygS2XLTkYFCSsvzETdYs/r8Onujb+OqpIF8FY5TPbOEPl7Mc46OAgiIc8nObbEvZlK
         24vzDDRw6yHi0qttn8W9D5P+MBMSoua7+Xd6tBpEBx+UBOcuXUYg7dQj26h2Zh1vk6nZ
         ab2ZYS7XsiTX2Wv9GRoFhLWA3+YktPVN2ggqgzOn2HmUnxKEdTrnalUPW3UbSN144u09
         ZGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978672; x=1693583472;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IzPqSgYN1ipk63Sp/vabDCOnAXcV4ryfpRQU/BRuK1g=;
        b=Y0qquScQyob69ObyhA0QfucpxuiFtUnh9S3R5GZSH+5cr89kthkj4gy8WtXi2TBQyg
         0sio4FFijQ7n0PxssIIuB0jKPfCFdF1XLeKENCHnkGd1B/y1ysNYm00BfvtUceFz9Wcx
         AUbTCfyp3qRwTI/PvBFxbbqf91ZydFkMVpep/VkZfbwW5HrKcByhy6/evzJXjrKWSb/O
         JFWlvfraB/vgfpE8SYyt3mwOb12Wwz2jhxUVvGRC+R+joPqXVQExhGWuHjnJKFRFWpP3
         5qZVlaW/Kxl82SUMzDE1fO0sFZy2Ax1dkc2JQaBtWSHVcffloNsMdM1k555eexVtQhQm
         lKfg==
X-Gm-Message-State: AOJu0YxhDGF+++7iPHcHTUKgRVmOP/dKhHqAfjEte207clJO4tcrzTOE
        zNIl/N56p7hOhkzqllTAS4fLKFIm3JQ=
X-Google-Smtp-Source: AGHT+IENvzcpzaxNbRrU1ap0D58TZRJcqjQ5Bz7o1fY5c2+S1+Ss0zh2Gj5UUTDQLlKL10LRiAp58Rp0Is4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:33b0:9e28:e79a:8e70])
 (user=gnoack job=sendgmr) by 2002:a81:af0e:0:b0:58c:6ddd:d27c with SMTP id
 n14-20020a81af0e000000b0058c6dddd27cmr464037ywh.6.1692978672572; Fri, 25 Aug
 2023 08:51:12 -0700 (PDT)
Date:   Fri, 25 Aug 2023 17:51:09 +0200
In-Reply-To: <20230818.HopaLahS0qua@digikod.net>
Message-Id: <ZOjN7dub5QGJOzSX@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230814172816.3907299-3-gnoack@google.com>
 <20230818.HopaLahS0qua@digikod.net>
Subject: Re: [PATCH v3 2/5] selftests/landlock: Test ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri, Aug 18, 2023 at 07:06:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Aug 14, 2023 at 07:28:13PM +0200, G=C3=BCnther Noack wrote:
> > @@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
> >  	};
> >  	int fd, ruleset_fd;
> > =20
> > -	/* Enable Landlock. */
> > +	/* Enables Landlock. */
> >  	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
> >  	ASSERT_LE(0, ruleset_fd);
> >  	enforce_ruleset(_metadata, ruleset_fd);
> > @@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
> >  	ASSERT_EQ(0, close(fd));
> >  }
>=20
> We should also check with O_PATH to make sure the correct error is
> returned (and not EACCES).

Is this remark referring to the code before it or after it?

My interpretation is that you are asking to test that test_fioqsize_ioctl()=
 will
return errnos correctly?  Do I understand that correctly?  (I think that wo=
uld
be a little bit overdone, IMHO - it's just a test utility of ~10 lines afte=
r
all, which is below the threshold where it can be verified by staring at it=
 for
a bit. :))

> > +/* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
> > +static int test_fioqsize_ioctl(int fd)
> > +{
> > +	loff_t size;
> > +
> > +	if (ioctl(fd, FIOQSIZE, &size) < 0)
> > +		return errno;
> > +	return 0;
> > +}



> > +	dir_s1d1_fd =3D open(dir_s1d1, O_RDONLY);
>=20
> You can use O_CLOEXEC everywhere.

Done.


> > +	ASSERT_LE(0, dir_s1d1_fd);
> > +	file1_s1d1_fd =3D open(file1_s1d1, O_RDONLY);
> > +	ASSERT_LE(0, file1_s1d1_fd);
> > +	dir_s2d1_fd =3D open(dir_s2d1, O_RDONLY);
> > +	ASSERT_LE(0, dir_s2d1_fd);
> > +
> > +	/*
> > +	 * Checks that FIOQSIZE works on files where LANDLOCK_ACCESS_FS_IOCTL=
 is
> > +	 * permitted.
> > +	 */
> > +	EXPECT_EQ(EACCES, test_fioqsize_ioctl(dir_s1d1_fd));
> > +	EXPECT_EQ(0, test_fioqsize_ioctl(file1_s1d1_fd));
> > +	EXPECT_EQ(0, test_fioqsize_ioctl(dir_s2d1_fd));
> > +
> > +	/* Closes all file descriptors. */
> > +	ASSERT_EQ(0, close(dir_s1d1_fd));
> > +	ASSERT_EQ(0, close(file1_s1d1_fd));
> > +	ASSERT_EQ(0, close(dir_s2d1_fd));
> > +}
> > +
> > +TEST_F_FORK(layout1, ioctl_always_allowed)
> > +{
> > +	struct landlock_ruleset_attr attr =3D {
>=20
> const struct landlock_ruleset_attr attr =3D {

Done.

I am personally unsure whether "const" is worth it for local variables, but=
 I am
happy to abide by whatever the dominant style is.  (The kernel style guide
doesn't seem to mention it though.)

BTW, it's somewhat inconsistent within this file already -- we should maybe
clean this up.


> > +		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL,
> > +	};
> > +	int ruleset_fd, fd;
> > +	int flag =3D 0;
> > +	int n;
>=20
> const int flag =3D 0;
> int ruleset_fd, test_fd, n;

Done.

Thanks for the review!
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
