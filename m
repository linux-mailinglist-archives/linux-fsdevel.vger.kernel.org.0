Return-Path: <linux-fsdevel+bounces-60992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D90B540DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 05:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583597BA51D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E1231839;
	Fri, 12 Sep 2025 03:28:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239692264C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647735; cv=none; b=mFc8o6NkFfgYNvir9LIqRT3dyaRcunUgdou5JIl3LHK9uuizGGDy+r3Y1owEnDu539J9988NG0IjCEMo2GP7ODOijmTbQLpKahh2BFRC8h608p3gJ6ePSzTLQqUlI2qZmXUOm5BnGDnb+BY2TP4aTuqsciAuT2EAWojMF5RGp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647735; c=relaxed/simple;
	bh=c//LVwICk4V/tE3QslXuBYeRtb09Uzbz5fQEmQMYgqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T36SU1rcxamDpHs4ZPcUAah9GqCsr26uRtpWJ6eow8m2AMmH+pMUv8jA4DMqJ1G8VqeSQB9rf8neBhR7gVkXry+MoAmiJZWCf1w3BjUO3VW7tcWinfRIRu+4/mGDaK010+IMIYn4Ry9nazdBsDPm1Oh1JmQMeHVQ2mSNe5wkR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea3ca65bd38so1211713276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 20:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757647732; x=1758252532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itpjzVo5uNHzuebuDZK5ma68QytdvIQ2v0NI1Mc1wDI=;
        b=EK5npkav4x6Vd3doqkOYzpxYaeN/u+RsW2rGHJQSwAbCPJwE6FE7lln8GBjIQfu3X1
         o4MWd8RiXmnkitpJZtusJk+xeb+D3kNme1paj6SOABtdPozVUKT0N9bg6ye3TJOrqQhx
         kULeFey756N30y0P+zKSZ4/wN5mUGbVTbPEOmD6VEjM16JEYQXcEzruABIwaYRuyJ9Bw
         V3m4IKM0rrmUrCmbpai9B91mMievSiMWBiOdmndbByarZjEZmbZX3UwBlvqM2VGiwoJU
         8ncGctV+jNoC3SIdo2LXw37ohd38UmB3uAdVzZiqiEJav0q9IpNLpJqBHsZJknex9RrB
         wL/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZTJUVY/TwRgJnE9TWqfa1rVn2NE3Nt8U4MQDcOL3rNF/KgeH311xv+mqEIgnQNEy7byTqcyzo5AEPTuMX@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXeN+eTN4ueQJt1yBTX6eSaqDKYIz8xQCGmjb28EAVKndOpU0
	AbpPV2Iv4pcYiBSbhMAOA7EEJ05eOem7jhYZdG53H1tA2gtJYRDWVpB+AHKqysOv65A=
X-Gm-Gg: ASbGnctjxX8NQ6Y+1m9bWUJinPqztp6KyG8pwk34+1Rs/wmqz+u3WteJcRPO3M84TOm
	6K+wriP4WPeAHYpiKYVeg1tySBDu7nY0gVlZ8x59pphGWbqLtvDSXVB0JnhrVJnLSNchvMvcY7j
	nsHZfxwfjRYlGLCvWQEmcw+iwy1P4RtUdwi1+4SuEc/KIi3+IBqkJaSaRDCbTehQdnSlXq2Uijj
	lCdaH2v0/iDxfFYacWNfc09pEyVzn8AX4TREX4DSkGzls0TTHudHX7ixPwZ3ntC95M71qrFWU/Q
	7n7G9ne/eiCoByig/kL4hx3C9mpu0Q2H4rWW/xG+iwO3AZV+M3cVw2zGaslfe1KbIQSF1HguAt9
	9YoMfzBWLnFFi1DMt/J84Ua7qLjwwR5bYwLcGBtWMII0IDT35jd/ADasGEBVww/0cBaDkbTnekz
	7NSfjHyFsxMZB2q+g=
X-Google-Smtp-Source: AGHT+IGtm18tfEYvhBPtjpmzWjhhqSyUrVIRcFArK0LCIZ8SSRgrtfkhd+AZZIYZFaA3CTX07nzRkA==
X-Received: by 2002:a05:690e:220d:b0:600:f59f:780f with SMTP id 956f58d0204a3-62725679061mr1350881d50.27.1757647731871;
        Thu, 11 Sep 2025 20:28:51 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623452bsm8356217b3.5.2025.09.11.20.28.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 20:28:51 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6083cc69so13645007b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 20:28:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbQjvyzj4eywN6GxvCT3ySY5J9qeuFzhn50gmYDmrNY6sQ1L0Hw4crTxrzHKs/LrFw/Yhj0H9m7MchuJ5i@vger.kernel.org
X-Received: by 2002:a05:690c:dc8:b0:71f:a817:1de6 with SMTP id
 00721157ae682-730652da62dmr17458847b3.41.1757647731022; Thu, 11 Sep 2025
 20:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912010956.1044233-1-slava@dubeyko.com>
In-Reply-To: <20250912010956.1044233-1-slava@dubeyko.com>
From: black_desk <me@black-desk.cn>
Date: Fri, 12 Sep 2025 11:28:39 +0800
X-Gmail-Original-Message-ID: <CAC1kPDO9jCx73_PqRtFRMLyTp7KmX6PzpN+LFL4gw6Pckju-HA@mail.gmail.com>
X-Gm-Features: Ac12FXxT9Rru-cF_T-DHRXJGUJk2RMEG-iySZSa3YneCNixkgl1qFL9IqIzYF7E
Message-ID: <CAC1kPDO9jCx73_PqRtFRMLyTp7KmX6PzpN+LFL4gw6Pckju-HA@mail.gmail.com>
Subject: Re: [PATCH v2] hfs: introduce KUnit tests for HFS string operations
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	frank.li@vivo.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:10=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> This patch implements the initial Kunit based set of
> unit tests for HFS string operations. It checks
> functionality of hfs_strcmp(), hfs_hash_dentry(),
> and hfs_compare_dentry() methods.
>
> ./tools/testing/kunit/kunit.py run --kunitconfig ./fs/hfs/.kunitconfig
>
> [16:04:50] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig
> [16:04:51] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig
> Building with:
> $ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D22
> [16:04:59] Starting KUnit Kernel (1/1)...
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Running tests with:
> $ .kunit/linux kunit.enable=3D1 mem=3D1G console=3Dtty kunit_shutdown=3Dh=
alt
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D hfs_string=
 (3 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [16:04:59] [PASSED] hfs_strcmp_test
> [16:04:59] [PASSED] hfs_hash_dentry_test
> [16:04:59] [PASSED] hfs_compare_dentry_test
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PAS=
SED] hfs_string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [16:04:59] Testing complete. Ran 3 tests: passed: 3
> [16:04:59] Elapsed time: 9.087s total, 1.310s configuring, 7.611s buildin=
g, 0.125s running
>
> v2
> Fix linker error.
>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/hfs/.kunitconfig  |   7 +++
>  fs/hfs/Kconfig       |  15 +++++
>  fs/hfs/Makefile      |   2 +
>  fs/hfs/string.c      |   3 +
>  fs/hfs/string_test.c | 132 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 159 insertions(+)
>  create mode 100644 fs/hfs/.kunitconfig
>  create mode 100644 fs/hfs/string_test.c
>
> diff --git a/fs/hfs/.kunitconfig b/fs/hfs/.kunitconfig
> new file mode 100644
> index 000000000000..5caa9af1e3bb
> --- /dev/null
> +++ b/fs/hfs/.kunitconfig
> @@ -0,0 +1,7 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_HFS_FS=3Dy
> +CONFIG_HFS_KUNIT_TEST=3Dy
> +CONFIG_BLOCK=3Dy
> +CONFIG_BUFFER_HEAD=3Dy
> +CONFIG_NLS=3Dy
> +CONFIG_LEGACY_DIRECT_IO=3Dy
> diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
> index 5ea5cd8ecea9..7f3cbe43b4b7 100644
> --- a/fs/hfs/Kconfig
> +++ b/fs/hfs/Kconfig
> @@ -13,3 +13,18 @@ config HFS_FS
>
>           To compile this file system support as a module, choose M here:=
 the
>           module will be called hfs.
> +
> +config HFS_KUNIT_TEST
> +       tristate "KUnit tests for HFS filesystem" if !KUNIT_ALL_TESTS
> +       depends on HFS_FS && KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds KUnit tests for the HFS filesystem.
> +
> +         KUnit tests run during boot and output the results to the debug
> +         log in TAP format (https://testanything.org/). Only useful for
> +         kernel devs running KUnit test harness and are not for inclusio=
n
> +         into a production build.
> +
> +         For more information on KUnit and unit tests in general please
> +         refer to the KUnit documentation in Documentation/dev-tools/kun=
it/.
> diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
> index b65459bf3dc4..a7c9ce6b4609 100644
> --- a/fs/hfs/Makefile
> +++ b/fs/hfs/Makefile
> @@ -9,3 +9,5 @@ hfs-objs :=3D bitmap.o bfind.o bnode.o brec.o btree.o \
>             catalog.o dir.o extent.o inode.o attr.o mdb.o \
>              part_tbl.o string.o super.o sysdep.o trans.o
>
> +# KUnit tests
> +obj-$(CONFIG_HFS_KUNIT_TEST) +=3D string_test.o
> diff --git a/fs/hfs/string.c b/fs/hfs/string.c
> index 3912209153a8..b011c1cbdf94 100644
> --- a/fs/hfs/string.c
> +++ b/fs/hfs/string.c
> @@ -65,6 +65,7 @@ int hfs_hash_dentry(const struct dentry *dentry, struct=
 qstr *this)
>         this->hash =3D end_name_hash(hash);
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(hfs_hash_dentry);

It seems we should use EXPORT_SYMBOL_IF_KUNIT here?
See https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-funct=
ions

Thanks,
Chen Linxuan

>
>  /*
>   * Compare two strings in the HFS filename character ordering
> @@ -87,6 +88,7 @@ int hfs_strcmp(const unsigned char *s1, unsigned int le=
n1,
>         }
>         return len1 - len2;
>  }
> +EXPORT_SYMBOL_GPL(hfs_strcmp);
>
>  /*
>   * Test for equality of two strings in the HFS filename character orderi=
ng.
> @@ -112,3 +114,4 @@ int hfs_compare_dentry(const struct dentry *dentry,
>         }
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(hfs_compare_dentry);
> diff --git a/fs/hfs/string_test.c b/fs/hfs/string_test.c
> new file mode 100644
> index 000000000000..de1928dc4ef4
> --- /dev/null
> +++ b/fs/hfs/string_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for HFS string operations
> + *
> + * Copyright (C) 2025 Viacheslav Dubeyko <slava@dubeyko.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/dcache.h>
> +#include "hfs_fs.h"
> +
> +/* Test hfs_strcmp function */
> +static void hfs_strcmp_test(struct kunit *test)
> +{
> +       /* Test equal strings */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "hello", 5));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("test", 4, "test", 4));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("", 0, "", 0));
> +
> +       /* Test unequal strings */
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("hello", 5, "world", 5));
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("test", 4, "testing", 7));
> +
> +       /* Test different lengths */
> +       KUNIT_EXPECT_LT(test, hfs_strcmp("test", 4, "testing", 7), 0);
> +       KUNIT_EXPECT_GT(test, hfs_strcmp("testing", 7, "test", 4), 0);
> +
> +       /* Test case insensitive comparison (HFS should handle case) */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("Test", 4, "TEST", 4));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "HELLO", 5));
> +
> +       /* Test with special characters */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("file.txt", 8, "file.txt", 8)=
);
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("file.txt", 8, "file.dat", 8)=
);
> +
> +       /* Test boundary cases */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("a", 1, "a", 1));
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("a", 1, "b", 1));
> +}
> +
> +/* Test hfs_hash_dentry function */
> +static void hfs_hash_dentry_test(struct kunit *test)
> +{
> +       struct qstr test_name1, test_name2, test_name3;
> +       struct dentry dentry =3D {};
> +       char name1[] =3D "testfile";
> +       char name2[] =3D "TestFile";
> +       char name3[] =3D "different";
> +
> +       /* Initialize test strings */
> +       test_name1.name =3D name1;
> +       test_name1.len =3D strlen(name1);
> +       test_name1.hash =3D 0;
> +
> +       test_name2.name =3D name2;
> +       test_name2.len =3D strlen(name2);
> +       test_name2.hash =3D 0;
> +
> +       test_name3.name =3D name3;
> +       test_name3.len =3D strlen(name3);
> +       test_name3.hash =3D 0;
> +
> +       /* Test hashing */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name1));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name2));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name3));
> +
> +       /* Case insensitive names should hash the same */
> +       KUNIT_EXPECT_EQ(test, test_name1.hash, test_name2.hash);
> +
> +       /* Different names should have different hashes */
> +       KUNIT_EXPECT_NE(test, test_name1.hash, test_name3.hash);
> +}
> +
> +/* Test hfs_compare_dentry function */
> +static void hfs_compare_dentry_test(struct kunit *test)
> +{
> +       struct qstr test_name;
> +       struct dentry dentry =3D {};
> +       char name[] =3D "TestFile";
> +
> +       test_name.name =3D name;
> +       test_name.len =3D strlen(name);
> +
> +       /* Test exact match */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "TestFile", &test_nam=
e));
> +
> +       /* Test case insensitive match */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "testfile", &test_nam=
e));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "TESTFILE", &test_nam=
e));
> +
> +       /* Test different names */
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 8,
> +                                                   "DiffFile", &test_nam=
e));
> +
> +       /* Test different lengths */
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 7,
> +                                                   "TestFil", &test_name=
));
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 9,
> +                                                   "TestFiles", &test_na=
me));
> +
> +       /* Test empty string */
> +       test_name.name =3D "";
> +       test_name.len =3D 0;
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 0, "", &test=
_name));
> +
> +       /* Test HFS_NAMELEN boundary */
> +       test_name.name =3D "This_is_a_very_long_filename_that_exceeds_nor=
mal_limits";
> +       test_name.len =3D strlen(test_name.name);
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, HFS_NAMELEN,
> +                       "This_is_a_very_long_filename_th", &test_name));
> +}
> +
> +static struct kunit_case hfs_string_test_cases[] =3D {
> +       KUNIT_CASE(hfs_strcmp_test),
> +       KUNIT_CASE(hfs_hash_dentry_test),
> +       KUNIT_CASE(hfs_compare_dentry_test),
> +       {}
> +};
> +
> +static struct kunit_suite hfs_string_test_suite =3D {
> +       .name =3D "hfs_string",
> +       .test_cases =3D hfs_string_test_cases,
> +};
> +
> +kunit_test_suite(hfs_string_test_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for HFS string operations");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>
>
>

