Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4A397876
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFAQyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:54:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1197C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 09:52:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a6so16112852ioe.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uitFieTpnbycPvc54uApPb9GmZGNx7UfciTUinWfBWU=;
        b=NCGfvQO3715UT4U5DAXmIwcOUr5fxsWv+KsnBa+UtqeWrwOx3pY4mUrnzYIMyj77yZ
         d6BsY2yyds7LsEl/O8ODt7gN4NG6MkJNgY2lu3hlRnw2YgW79nNoK0CNlKauQDjQEA1d
         3+MZwfoTX254yPAxzP6Yl24nU8kSVbPUdrl9bf5w820gNbRCFdK+EeWgLeM9/KmH11y1
         hDdRHQqQTfxM6q4M+ASDBBexPXdcD93kYJ6KD8h7AcKVI/M8An0kts346HmBgPGNJ0hx
         fwUKIC+CblF/nhU7s84eqF+vHERFBQY6D2ByjgQzpwaKssO8FqbtalVeyAN5VqhZryYq
         SCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uitFieTpnbycPvc54uApPb9GmZGNx7UfciTUinWfBWU=;
        b=ZElyTSczMgMDXEaL/oxUNjaiukNzFKOm30KJoR/PzfSUmVhzuQXt//t9jAunc0lqkJ
         AoBMa3z/hVeJTfVQhFXudigToIip3PzKOrqDHu4ORYucgRoytfBloaJX6A3iiqfY4hyy
         eRU6/G7mjPgL3WLgoQHKv9FyXVvgqyH+Z/KVMX/2ubg+1p6GL4CeQYZh8ggbS9+taddn
         1DEM+FX4Gc6D5+jlg0k9X9KDximxCFUN3/V88LJ01ggiEPV1HSiNZB2en5xTI1F3Dg7L
         p9gU/E13NUVZW69JQRXVd3pecJkc/9hpIYINuWySSJnTCdnWKZVAS6/FIUfQnbOdXJiJ
         Br4w==
X-Gm-Message-State: AOAM530ZfvjDo49MV6kXeQIGluto9Ex56Ia8389/DSTRGl/GI+fgEg4A
        76yvadvyohUNhKhsOqjbdcP6Lw77OHdii6cuAOvCXQ==
X-Google-Smtp-Source: ABdhPJz/Wz0asvUSzF1X+RNA4CcuV4wFbfxEiz0Emjddt0M7CYet49Sz4rwILsrXHIPOtE3wKDdZeUBqOkWmSX3LEGo=
X-Received: by 2002:a02:335c:: with SMTP id k28mr2545971jak.4.1622566338733;
 Tue, 01 Jun 2021 09:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210531184742.1142042-1-krisman@collabora.com>
In-Reply-To: <20210531184742.1142042-1-krisman@collabora.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Jun 2021 09:52:06 -0700
Message-ID: <CAGS_qxoJ7c8ZOZdwJ8BsmNmNvZNQvRp_xSjh--DBsQJtcL=tZw@mail.gmail.com>
Subject: Re: [PATCH] unicode: Implement UTF-8 tests as a KUnit test
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 11:47 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> From: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
>
> Hi,
>
> This patch saw some review on the list around one year ago [1], and I
> proposed it on a PR that ended up vanishing on the list noise [2], while
> I moved on to other things.
>
> Given the long time since last review, I'm proposing it for review again
> instead of making it part of a new PR.  From the version I've been
> carrying, the only update of this iteration is the KUNIT_ALL_TESTS
> symbol dependency on Kconfig, and the CONFIG_ option rename to better
> fit other KUNIT tests.  The actual code continues to work fine on top of
> mainline.
>
> Please, let me know what you think.
>
> [1] https://www.spinics.net/lists/linux-fsdevel/msg166356.html
> [2] https://patchwork.kernel.org/project/linux-fsdevel/patch/87blkap6az.f=
sf@collabora.com/
>
> -- >8 --
>
> This translates the existing UTF-8 unit test module into a
> KUnit-compliant test suite. No functionality has been added or removed.

Just a note: this is actually a safer conversion to KUnit than some
others we've seen.
Other tests sometimes return non-zero from modue_init() if any test
case failed, but KUnit does not, nor did this test.
So that's nice.

>
> Some names changed to make the file name, the Kconfig option and test
> suite name less specific, since this source file might hold more UTF-8
> tests in the future.
>
> Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
> [Fix checkpatch's complaint. Fix module build.
>  Add KUNIT_ALL_TESTS to kconfig]
> Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

Looks good on the KUnit-side of things, thanks.
Just minor nits about the naming below.

> ---
>  fs/unicode/Kconfig                          |  21 ++-
>  fs/unicode/Makefile                         |   2 +-
>  fs/unicode/{utf8-selftest.c =3D> utf8-test.c} | 199 +++++++++-----------

Very minor nit: utf8_test.c would be preferred.

Since the original version, there's now a "style guide",
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-file=
-and-module-names

>  3 files changed, 109 insertions(+), 113 deletions(-)
>  rename fs/unicode/{utf8-selftest.c =3D> utf8-test.c} (60%)
>
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..e29aca813374 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -8,7 +8,20 @@ config UNICODE
>           Say Y here to enable UTF-8 NFD normalization and NFD+CF casefol=
ding
>           support.
>
> -config UNICODE_NORMALIZATION_SELFTEST
> -       tristate "Test UTF-8 normalization support"
> -       depends on UNICODE
> -       default n
> +config UNICODE_KUNIT_TESTS
> +       tristate "KUnit test UTF-8 normalization support" if !KUNIT_ALL_T=
ESTS
> +       depends on UNICODE && KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the KUnit test suite for Unicode normalization and
> +         casefolding support.
> +
> +         KUnit tests run during boot and output the results to the debug=
 log
> +         in TAP format (http://testanything.org/). Only useful for kerne=
l devs
> +         running KUnit test harness and are not for inclusion into a pro=
duction
> +         build.
> +
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index b88aecc86550..0e8e2192a715 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_UNICODE) +=3D unicode.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) +=3D utf8-selftest.o
> +obj-$(CONFIG_UNICODE_KUNIT_TESTS) +=3D utf8-test.o
>
>  unicode-y :=3D utf8-norm.o utf8-core.o
>
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-test.c
> similarity index 60%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/utf8-test.c
> index 6fe8af7edccb..3ef3a80f9407 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-test.c
> @@ -1,39 +1,23 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Kernel module for testing utf-8 support.
> + * KUnit tests for utf-8 support.
>   *
> - * Copyright 2017 Collabora Ltd.
> + * Copyright 2020 Collabora Ltd.
>   */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/printk.h>
> +#include <kunit/test.h>
>  #include <linux/unicode.h>
> -#include <linux/dcache.h>
> -
>  #include "utf8n.h"
>
> -unsigned int failed_tests;
> -unsigned int total_tests;
> -
>  /* Tests will be based on this version. */
>  #define latest_maj 12
>  #define latest_min 1
>  #define latest_rev 0
>
> -#define _test(cond, func, line, fmt, ...) do {                         \
> -               total_tests++;                                          \
> -               if (!cond) {                                            \
> -                       failed_tests++;                                 \
> -                       pr_err("test %s:%d Failed: %s%s",               \
> -                              func, line, #cond, (fmt?":":"."));       \
> -                       if (fmt)                                        \
> -                               pr_err(fmt, ##__VA_ARGS__);             \
> -               }                                                       \
> -       } while (0)
> -#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__=
VA_ARGS__)
> -#define test(cond) _test(cond, __func__, __LINE__, "")
> +#define str(s) #s
> +#define VERSION_STR(maj, min, rev) str(maj) "." str(min) "." str(rev)
> +
> +/* Test data */

(Not actionable, just a remark)

Just an FYI, there's now support for iterating over test data arrays:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameter=
ized-testing

I think this is fine as-is as both test cases that use it have some setup.
That setup could be moved into an init func and store its result in
test->priv, but it's more readable as-is, IMO.

However one benefit is it would allow adding a "description" to each
test case to show on failure.
E.g. here's what a failure would look like right now:

[09:28:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[09:28:09] =3D=3D=3D=3D=3D=3D=3D=3D [FAILED] utf8-unit-test =3D=3D=3D=3D=3D=
=3D=3D=3D
[09:28:09] [PASSED] utf8_test_supported_versions
[09:28:09] [FAILED] utf8_test_nfdi
[09:28:09]     # utf8_test_nfdi: EXPECTATION FAILED at
fs/unicode/utf8-test.c:202
[09:28:09]     Expected c =3D=3D nfdi_test_data[i].dec[j], but
[09:28:09]         c =3D=3D 137
[09:28:09]         nfdi_test_data[i].dec[j] =3D=3D 138
[09:28:09] Unexpected byte 0x89 should be 0x8a
[09:28:09]     not ok 2 - utf8_test_nfdi
[09:28:09]
[09:28:09] [PASSED] utf8_test_nfdicf
[09:28:09] [FAILED] utf8_test_comparisons
[09:28:09]     # utf8_test_comparisons: EXPECTATION FAILED at
fs/unicode/utf8-test.c:267
[09:28:09]     Expected utf8_strncmp(table, &s1, &s2) =3D=3D 0, but
[09:28:09]         utf8_strncmp(table, &s1, &s2) =3D=3D 1
[09:28:09]
[09:28:09] =C7=89 =C7=8A comparison mismatch
[09:28:09]     not ok 4 - utf8_test_comparisons
[09:28:09]

It's a bit hard to grok where the failure lies and perhaps converting
the comments into a string that can be shown on failure would help.
But this is a pre-existing condition (and making the change seems is
something I'd be personally too lazy to do).

>
>  static const struct {
>         /* UTF-8 strings in this vector _must_ be NULL-terminated. */
> @@ -160,88 +144,117 @@ static const struct {
>         }
>  };
>
> -static void check_utf8_nfdi(void)
> +
> +/* Test cases */
> +
> +static void utf8_test_supported_versions(struct kunit *test)
> +{
> +       /* Unicode 7.0.0 should be supported. */
> +       KUNIT_EXPECT_TRUE(test, utf8version_is_supported(7, 0, 0));
> +
> +       /* Unicode 9.0.0 should be supported. */
> +       KUNIT_EXPECT_TRUE(test, utf8version_is_supported(9, 0, 0));
> +
> +       /* Unicode 1x.0.0 (the latest version) should be supported. */
> +       KUNIT_EXPECT_TRUE(test,
> +               utf8version_is_supported(latest_maj, latest_min, latest_r=
ev));
> +
> +       /* Next versions don't exist. */
> +       KUNIT_EXPECT_FALSE(test,
> +               utf8version_is_supported(latest_maj + 1, 0, 0));
> +
> +       /* Test for invalid version values */
> +       KUNIT_EXPECT_FALSE(test, utf8version_is_supported(0, 0, 0));
> +       KUNIT_EXPECT_FALSE(test, utf8version_is_supported(-1, -1, -1));
> +}
> +
> +static void utf8_test_nfdi(struct kunit *test)
>  {
>         int i;
>         struct utf8cursor u8c;
>         const struct utf8data *data;
>
>         data =3D utf8nfdi(UNICODE_AGE(latest_maj, latest_min, latest_rev)=
);
> -       if (!data) {
> -               pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
> -                      __func__, latest_maj, latest_min, latest_rev);
> -               return;
> -       }
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, data,
> +               "Unable to load utf8-%d.%d.%d. Skipping.",
> +               latest_maj, latest_min, latest_rev);
>
>         for (i =3D 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
> -               int len =3D strlen(nfdi_test_data[i].str);
> -               int nlen =3D strlen(nfdi_test_data[i].dec);
> +               size_t len =3D strlen(nfdi_test_data[i].str);
> +               size_t nlen =3D strlen(nfdi_test_data[i].dec);
>                 int j =3D 0;
>                 unsigned char c;
>
> -               test((utf8len(data, nfdi_test_data[i].str) =3D=3D nlen));
> -               test((utf8nlen(data, nfdi_test_data[i].str, len) =3D=3D n=
len));
> +               KUNIT_EXPECT_EQ(test,
> +                       utf8len(data, nfdi_test_data[i].str),
> +                       (ssize_t)nlen);
> +               KUNIT_EXPECT_EQ(test,
> +                       utf8nlen(data, nfdi_test_data[i].str, len),
> +                       (ssize_t)nlen);
>
> -               if (utf8cursor(&u8c, data, nfdi_test_data[i].str) < 0)
> -                       pr_err("can't create cursor\n");
> +               KUNIT_ASSERT_EQ_MSG(test,
> +                       utf8cursor(&u8c, data, nfdi_test_data[i].str), 0,
> +                       "Can't create cursor");
>
>                 while ((c =3D utf8byte(&u8c)) > 0) {
> -                       test_f((c =3D=3D nfdi_test_data[i].dec[j]),
> -                              "Unexpected byte 0x%x should be 0x%x\n",
> -                              c, nfdi_test_data[i].dec[j]);
> +                       KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].de=
c[j],
> +                               "Unexpected byte 0x%x should be 0x%x",
> +                               c, nfdi_test_data[i].dec[j]);
>                         j++;
>                 }
>
> -               test((j =3D=3D nlen));
> +               KUNIT_EXPECT_EQ(test, j, (int)nlen);
>         }
>  }
>
> -static void check_utf8_nfdicf(void)
> +static void utf8_test_nfdicf(struct kunit *test)
>  {
>         int i;
>         struct utf8cursor u8c;
>         const struct utf8data *data;
>
>         data =3D utf8nfdicf(UNICODE_AGE(latest_maj, latest_min, latest_re=
v));
> -       if (!data) {
> -               pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
> -                      __func__, latest_maj, latest_min, latest_rev);
> -               return;
> -       }
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, data,
> +               "Unable to load utf8-%d.%d.%d. Skipping.",
> +               latest_maj, latest_min, latest_rev);
>
>         for (i =3D 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
> -               int len =3D strlen(nfdicf_test_data[i].str);
> -               int nlen =3D strlen(nfdicf_test_data[i].ncf);
> +               size_t len =3D strlen(nfdicf_test_data[i].str);
> +               size_t nlen =3D strlen(nfdicf_test_data[i].ncf);
>                 int j =3D 0;
>                 unsigned char c;
>
> -               test((utf8len(data, nfdicf_test_data[i].str) =3D=3D nlen)=
);
> -               test((utf8nlen(data, nfdicf_test_data[i].str, len) =3D=3D=
 nlen));
> +               KUNIT_EXPECT_EQ(test,
> +                       utf8len(data, nfdicf_test_data[i].str),
> +                       (ssize_t)nlen);
> +               KUNIT_EXPECT_EQ(test,
> +                       utf8nlen(data, nfdicf_test_data[i].str, len),
> +                       (ssize_t)nlen);
>
> -               if (utf8cursor(&u8c, data, nfdicf_test_data[i].str) < 0)
> -                       pr_err("can't create cursor\n");
> +               KUNIT_ASSERT_EQ_MSG(test,
> +                       utf8cursor(&u8c, data, nfdicf_test_data[i].str), =
0,
> +                       "Can't create cursor");
>
>                 while ((c =3D utf8byte(&u8c)) > 0) {
> -                       test_f((c =3D=3D nfdicf_test_data[i].ncf[j]),
> -                              "Unexpected byte 0x%x should be 0x%x\n",
> -                              c, nfdicf_test_data[i].ncf[j]);
> +                       KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].=
ncf[j],
> +                               "Unexpected byte 0x%x should be 0x%x\n",
> +                               c, nfdicf_test_data[i].ncf[j]);
>                         j++;
>                 }
>
> -               test((j =3D=3D nlen));
> +               KUNIT_EXPECT_EQ(test, j, (int)nlen);
>         }
>  }
>
> -static void check_utf8_comparisons(void)
> +static void utf8_test_comparisons(struct kunit *test)
>  {
>         int i;
> -       struct unicode_map *table =3D utf8_load("12.1.0");
> +       struct unicode_map *table;
>
> -       if (IS_ERR(table)) {
> -               pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
> -                      __func__, latest_maj, latest_min, latest_rev);
> -               return;
> -       }
> +       table =3D utf8_load(VERSION_STR(latest_maj, latest_min, latest_re=
v));
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, table,
> +               "Unable to load utf8-%d.%d.%d. Skipping.\n",
> +               latest_maj, latest_min, latest_rev);
>
>         for (i =3D 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>                 const struct qstr s1 =3D {.name =3D nfdi_test_data[i].str=
,
> @@ -249,8 +262,8 @@ static void check_utf8_comparisons(void)
>                 const struct qstr s2 =3D {.name =3D nfdi_test_data[i].dec=
,
>                                         .len =3D sizeof(nfdi_test_data[i]=
.dec)};
>
> -               test_f(!utf8_strncmp(table, &s1, &s2),
> -                      "%s %s comparison mismatch\n", s1.name, s2.name);
> +               KUNIT_EXPECT_EQ_MSG(test, utf8_strncmp(table, &s1, &s2), =
0,
> +                       "%s %s comparison mismatch", s1.name, s2.name);
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
> @@ -259,54 +272,24 @@ static void check_utf8_comparisons(void)
>                 const struct qstr s2 =3D {.name =3D nfdicf_test_data[i].n=
cf,
>                                         .len =3D sizeof(nfdicf_test_data[=
i].ncf)};
>
> -               test_f(!utf8_strncasecmp(table, &s1, &s2),
> -                      "%s %s comparison mismatch\n", s1.name, s2.name);
> +               KUNIT_EXPECT_EQ_MSG(test, utf8_strncasecmp(table, &s1, &s=
2), 0,
> +                       "%s %s comparison mismatch", s1.name, s2.name);
>         }
>
>         utf8_unload(table);
>  }
>
> -static void check_supported_versions(void)
> -{
> -       /* Unicode 7.0.0 should be supported. */
> -       test(utf8version_is_supported(7, 0, 0));
> -
> -       /* Unicode 9.0.0 should be supported. */
> -       test(utf8version_is_supported(9, 0, 0));
> -
> -       /* Unicode 1x.0.0 (the latest version) should be supported. */
> -       test(utf8version_is_supported(latest_maj, latest_min, latest_rev)=
);
> -
> -       /* Next versions don't exist. */
> -       test(!utf8version_is_supported(13, 0, 0));
> -       test(!utf8version_is_supported(0, 0, 0));
> -       test(!utf8version_is_supported(-1, -1, -1));
> -}
> -
> -static int __init init_test_ucd(void)
> -{
> -       failed_tests =3D 0;
> -       total_tests =3D 0;
> -
> -       check_supported_versions();
> -       check_utf8_nfdi();
> -       check_utf8_nfdicf();
> -       check_utf8_comparisons();
> -
> -       if (!failed_tests)
> -               pr_info("All %u tests passed\n", total_tests);
> -       else
> -               pr_err("%u out of %u tests failed\n", failed_tests,
> -                      total_tests);
> -       return 0;
> -}
> -
> -static void __exit exit_test_ucd(void)
> -{
> -}
> +static struct kunit_case utf8_test_cases[] =3D {
> +       KUNIT_CASE(utf8_test_supported_versions),
> +       KUNIT_CASE(utf8_test_nfdi),
> +       KUNIT_CASE(utf8_test_nfdicf),
> +       KUNIT_CASE(utf8_test_comparisons),
> +       {}
> +};
>
> -module_init(init_test_ucd);
> -module_exit(exit_test_ucd);
> +static struct kunit_suite utf8_test_suite =3D {
> +       .name =3D "utf8-unit-test",

The guidance on suite naming lives at:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#suites
Being pedantic, one might say we should call this "fs_utf8" or similar.

But the main points IMO are
* we should use _ instead of -
* we can drop "-unit-test" or "-tests" from suite names, as it's a bit
redundant.


> +       .test_cases =3D utf8_test_cases,
> +};
>
> -MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
> -MODULE_LICENSE("GPL");
> +kunit_test_suite(utf8_test_suite);
> --
> 2.31.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20210531184742.1142042-1-krisman%40collabora.com.
