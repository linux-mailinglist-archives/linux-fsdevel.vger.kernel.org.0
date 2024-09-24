Return-Path: <linux-fsdevel+bounces-30002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB6A984CE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0FD1F24B64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823413BAE7;
	Tue, 24 Sep 2024 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="FhApgnE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30C17557;
	Tue, 24 Sep 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213445; cv=none; b=X2PHKx5r5hehK6OQOI9K1GnBlDXrRTdRD9F+affqh4AeqrngFuh6HQpNOH4xRO8eD1lQZMcvaZSO8RcFFjWGSniM5IbRU5uQHhYRgOf/hVgOG/Lf0Ti+kDm+5H0vqWfXO2FCp9MCSvOPZjNqISOM7RJtloff+4UK8cnSukwP25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213445; c=relaxed/simple;
	bh=id+MVpkcfj1r+xqw+ETnouJLXTiPaODoJXjl0uQ+0/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuKUoZy9wTBL9iCCSQ5FvAieruVrvN2ZGbZXOSPy418wfleYSL1swmVvhsoVzbBh/zGFzatmKAzNvr42D/AQs1R1r+MBh0XQEhHxeMGL0LBcBg+dxtuSYJIS3Y6tVfHDAcGD3uxrE33mGg+lvW3G59VH4Bkz7lGA7zg59TDNWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=FhApgnE9; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XCtM1168DzDq6L;
	Tue, 24 Sep 2024 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1727213437; bh=id+MVpkcfj1r+xqw+ETnouJLXTiPaODoJXjl0uQ+0/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FhApgnE91alCKcxHI2iicsog30YgbeS0TI6a7lGZ4k1qtrxo7SObMMiYmv4aDLa4R
	 V+AOynTEGUghDj/T3vRG7trgcM6pFDm3qeYeGmr/Y4Fvtr9dIG2Ab52dLaAEzp97nD
	 mNMnLwbBNpL7l7hLiLAIhjmws+siRCfA9p9evOT8=
X-Riseup-User-ID: 9DBC7A7667E14972B26C081E0E774D047F6AF1CB8E3C7EC5C30098804712CA6C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XCtLy0dbYzJqvx;
	Tue, 24 Sep 2024 21:30:33 +0000 (UTC)
Message-ID: <eb26f009-37e9-4988-ae86-c349af3f9a6b@riseup.net>
Date: Tue, 24 Sep 2024 23:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Cc: linux-kselftest@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
 kunit-dev@googlegroups.com, porlando@lkcamp.dev, dpereira@lkcamp.dev,
 ~lkcamp/patches@lists.sr.ht
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
 <20240923173454.264852-2-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20240923173454.264852-2-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey!

On 9/23/24 19:34, Gabriela Bittencourt wrote:
> Instead of creating 'test' functions, use kunit functions to test
> utf-8 support in unicode subsystem.

I think it would be nice to explain in the commit message what are the 
benefits of this change, why refactoring into KUnit is a good idea?

> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---
>   fs/unicode/.kunitconfig    |   3 +
>   fs/unicode/Kconfig         |   5 +-
>   fs/unicode/Makefile        |   2 +-
>   fs/unicode/utf8-selftest.c | 152 +++++++++++++++++--------------------
>   4 files changed, 76 insertions(+), 86 deletions(-)
>   create mode 100644 fs/unicode/.kunitconfig
>
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
> new file mode 100644
> index 000000000000..62dd5c171f9c
> --- /dev/null
> +++ b/fs/unicode/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_UNICODE=y
> +CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=y
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index da786a687fdc..4ad2c36550f1 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -10,6 +10,7 @@ config UNICODE
>   	  be a separate loadable module that gets requested only when a file
>   	  system actually use it.
>   
> -config UNICODE_NORMALIZATION_SELFTEST
> +config UNICODE_NORMALIZATION_KUNIT_TEST
>   	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +	depends on UNICODE && KUNIT
> +	default KUNIT_ALL_TESTS
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index e309afe2b2bb..37bbcbc628a1 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>   obj-y			+= unicode.o
>   endif
>   obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
>   
>   unicode-y := utf8-norm.o utf8-core.o
>   
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
> index 600e15efe9ed..54ded8db6b1c 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-selftest.c
> @@ -1,38 +1,18 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Kernel module for testing utf-8 support.
> + * KUnit tests for utf-8 support
>    *
>    * Copyright 2017 Collabora Ltd.
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/printk.h>
>   #include <linux/unicode.h>
> -#include <linux/dcache.h>
> +#include <kunit/test.h>
>   
>   #include "utf8n.h"
>   
> -static unsigned int failed_tests;
> -static unsigned int total_tests;
> -
>   /* Tests will be based on this version. */
>   #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
>   
> -#define _test(cond, func, line, fmt, ...) do {				\
> -		total_tests++;						\
> -		if (!cond) {						\
> -			failed_tests++;					\
> -			pr_err("test %s:%d Failed: %s%s",		\
> -			       func, line, #cond, (fmt?":":"."));	\
> -			if (fmt)					\
> -				pr_err(fmt, ##__VA_ARGS__);		\
> -		}							\
> -	} while (0)
> -#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
> -#define test(cond) _test(cond, __func__, __LINE__, "")
> -
>   static const struct {
>   	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
>   	unsigned char str[10];
> @@ -158,22 +138,22 @@ static const struct {
>   	}
>   };
>   
> -static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n,
> -		const char *s)
> +static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n, const char *s)
>   {
>   	return utf8nlen(um, n, s, (size_t)-1);
>   }
>   
>   static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
> -		enum utf8_normalization n, const char *s)
> +		      enum utf8_normalization n, const char *s)
>   {
>   	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
>   }
>   
> -static void check_utf8_nfdi(struct unicode_map *um)
> +static void check_utf8_nfdi(struct kunit *test)
>   {
>   	int i;
>   	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>   
>   	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>   		int len = strlen(nfdi_test_data[i].str);
> @@ -181,28 +161,29 @@ static void check_utf8_nfdi(struct unicode_map *um)
>   		int j = 0;
>   		unsigned char c;
>   
> -		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
> -		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
> -			nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
> +				nlen);
>   
> -		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +		KUNIT_EXPECT_GE_MSG(test, utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str),
> +				    0, "Can't create cursor\n");
>   
>   		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdi_test_data[i].dec[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdi_test_data[i].dec[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdi_test_data[i].dec[j]);
>   			j++;
>   		}
>   
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>   	}
>   }
>   
> -static void check_utf8_nfdicf(struct unicode_map *um)
> +static void check_utf8_nfdicf(struct kunit *test)
>   {
>   	int i;
>   	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>   
>   	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
>   		int len = strlen(nfdicf_test_data[i].str);
> @@ -210,29 +191,30 @@ static void check_utf8_nfdicf(struct unicode_map *um)
>   		int j = 0;
>   		unsigned char c;
>   
> -		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
> -				nlen));
> -		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
> -				nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +				nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
> +				nlen);
>   
> -		if (utf8cursor(&u8c, um, UTF8_NFDICF,
> -				nfdicf_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +		KUNIT_EXPECT_GE_MSG(test,
> +				    utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +				    0, "Can't create cursor\n");
>   
>   		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdicf_test_data[i].ncf[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdicf_test_data[i].ncf[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdicf_test_data[i].ncf[j]);
>   			j++;
>   		}
>   
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>   	}
>   }
>   
> -static void check_utf8_comparisons(struct unicode_map *table)
> +static void check_utf8_comparisons(struct kunit *test)
>   {
>   	int i;
> +	struct unicode_map *um = test->priv;
>   
>   	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>   		const struct qstr s1 = {.name = nfdi_test_data[i].str,
> @@ -240,8 +222,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
>   		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
>   					.len = sizeof(nfdi_test_data[i].dec)};
>   
> -		test_f(!utf8_strncmp(table, &s1, &s2),
> -		       "%s %s comparison mismatch\n", s1.name, s2.name);
> +		// strncmp returns 0 when strings are equal
> +		KUNIT_EXPECT_EQ_MSG(test, utf8_strncmp(um, &s1, &s2), 0,
> +				    "%s %s comparison mismatch\n", s1.name, s2.name);
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
> @@ -250,62 +233,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
>   		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
>   					.len = sizeof(nfdicf_test_data[i].ncf)};
>   
> -		test_f(!utf8_strncasecmp(table, &s1, &s2),
> -		       "%s %s comparison mismatch\n", s1.name, s2.name);
> +		// strncasecmp returns 0 when strings are equal
> +		KUNIT_EXPECT_EQ_MSG(test, utf8_strncasecmp(um, &s1, &s2), 0,
> +				    "%s %s comparison mismatch\n", s1.name, s2.name);
>   	}
>   }
>   
> -static void check_supported_versions(struct unicode_map *um)
> +static void check_supported_versions(struct kunit *test)
>   {
> +	struct unicode_map *um = test->priv;
>   	/* Unicode 7.0.0 should be supported. */
> -	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
>   
>   	/* Unicode 9.0.0 should be supported. */
> -	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
>   
>   	/* Unicode 1x.0.0 (the latest version) should be supported. */
> -	test(utf8version_is_supported(um, UTF8_LATEST));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
>   
>   	/* Next versions don't exist. */
> -	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> -	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> -	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
>   }
>   
> -static int __init init_test_ucd(void)
> +static struct kunit_case unicode_normalization_test_cases[] = {
> +	KUNIT_CASE(check_supported_versions),
> +	KUNIT_CASE(check_utf8_comparisons),
> +	KUNIT_CASE(check_utf8_nfdicf),
> +	KUNIT_CASE(check_utf8_nfdi),
> +	{}
> +};
> +
> +static int init_test_ucd(struct kunit *test)
>   {
> -	struct unicode_map *um;
> +	struct unicode_map *um = utf8_load(UTF8_LATEST);
>   
> -	failed_tests = 0;
> -	total_tests = 0;
> +	test->priv = um;
>   
> -	um = utf8_load(UTF8_LATEST);
> -	if (IS_ERR(um)) {
> -		pr_err("%s: Unable to load utf8 table.\n", __func__);
> -		return PTR_ERR(um);
> -	}
> +	KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
> +			    "%s: Unable to load utf8 table.\n", __func__);
>   
> -	check_supported_versions(um);
> -	check_utf8_nfdi(um);
> -	check_utf8_nfdicf(um);
> -	check_utf8_comparisons(um);
> -
> -	if (!failed_tests)
> -		pr_info("All %u tests passed\n", total_tests);
> -	else
> -		pr_err("%u out of %u tests failed\n", failed_tests,
> -		       total_tests);
> -	utf8_unload(um);
>   	return 0;
>   }
>   
> -static void __exit exit_test_ucd(void)
> +static void exit_test_ucd(struct kunit *test)
>   {
> +	utf8_unload(test->priv);
>   }
>   
> -module_init(init_test_ucd);
> -module_exit(exit_test_ucd);
> +static struct kunit_suite unicode_normalization_test_suite = {
> +	.name = "unicode_normalization",
> +	.test_cases = unicode_normalization_test_cases,
> +	.init = init_test_ucd,
> +	.exit = exit_test_ucd,
> +};
> +
> +kunit_test_suite(unicode_normalization_test_suite);
> +
>   
>   MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
> -MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
> +MODULE_DESCRIPTION("KUnit tests for utf-8 support");
>   MODULE_LICENSE("GPL");

