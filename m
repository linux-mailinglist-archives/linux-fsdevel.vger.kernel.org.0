Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09851AADBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415557AbgDOQUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415556AbgDOQT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:19:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4758C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LooeW7dQ/13AfG5q/+tT1KBPAM5Hd+vUD9bRvniFzGQ=; b=jDAP4zKeWhlyP0L1Sefauxpjxu
        VSlc1FdBYmhpDswpGZkDi1PFEWkjcz4ZwTM1Mz6aC2a9DnJUVKbxFPW2e1euQkjnr1o9e8t/WKvO3
        sv0mjCw7py89JWqCcc0/4O3sIytiCAg2QSKmo2owM6qs7K5NZ4IMYMhVfVA/+Ox8hwyZO6KiTc2yU
        zQDlc69S9wbLkxcF89yfXLKq1cJgDivVTjt1+IUP4KONWdDby6NsBccr7ulZOLEk3A0+M3raH8Zcy
        F2PDmyNa5Nd0mLwAdvQlg37PzD0MLrE7Ige/07TSRtxz05E/mCyHZ8Q3Ch1Y694cmPLVP+zpJ0bBZ
        Lv97yzRA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOklb-0005Bh-GO; Wed, 15 Apr 2020 16:19:59 +0000
Subject: Re: [PATCH] Implement utf8 unit tests as a kunit test suite.
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31317125-42d6-3306-aa06-955eebb07623@infradead.org>
Date:   Wed, 15 Apr 2020 09:19:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 4/15/20 1:28 AM, Ricardo Cañuelo wrote:
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..734c25920750 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -8,7 +8,19 @@ config UNICODE
>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>  	  support.
>  
> -config UNICODE_NORMALIZATION_SELFTEST
> -	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +config UNICODE_KUNIT_TESTS
> +	bool "Kunit tests for UTF-8 support"
> +	depends on UNICODE && KUNIT
>  	default n
> +	help
> +	  This builds the ext4 KUnit tests.

			ext4??

> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a production
> +	  build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.


thanks.
-- 
~Randy

