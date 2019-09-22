Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C614BA325
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2019 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbfIVQ3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 12:29:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387604AbfIVQ3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rGqXLDwoxSJ+wMClTeqCK7DBN64mFNHAm3f7xeAfO/Y=; b=Jqrmyr//FV9HMLM96+iNkQrG9
        U4Uoy/pOrdbQVcKQBj9xPvAkV/nzrJpOJ1bdtxIXDSdsG2VLMEJv6TViNNLTSyi4UdBQYPKzaxcrJ
        2T4t8mrKe78jij/lNHM3wjTob7KcsjUa815F7f3Aihj/SleVztJIvrssWkutND3UYT6Rv/iySkIdf
        NfuXnPzxcoef19ZF0a6xFA3k17U3TqdtEDvk5uN2TMgl2RW2OQ0GTb2A3YN0AuqPW+csabIMBu0CZ
        MEZI3cTzBe5bCL5Kj08Onh8n/iaXULqCTmLm39f238LK0to8z19ySnG8XjQR5JizEmVVeaKJZ1gFo
        +Z/Ym2Tyg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iC4iv-00076b-DS; Sun, 22 Sep 2019 16:28:33 +0000
Subject: Re: [PATCH v17 07/19] kunit: test: add initial tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        torvalds@linux-foundation.org
References: <20190921001855.200947-1-brendanhiggins@google.com>
 <20190921001855.200947-8-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
Date:   Sun, 22 Sep 2019 09:28:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921001855.200947-8-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/19 5:18 PM, Brendan Higgins wrote:
> Add a test for string stream along with a simpler example.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  lib/kunit/Kconfig              | 25 ++++++++++
>  lib/kunit/Makefile             |  4 ++
>  lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
>  lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 lib/kunit/example-test.c
>  create mode 100644 lib/kunit/string-stream-test.c
> 
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 666b9cb67a74..3868c226cf31 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -11,3 +11,28 @@ menuconfig KUNIT
>  	  special hardware when using UML. Can also be used on most other
>  	  architectures. For more information, please see
>  	  Documentation/dev-tools/kunit/.
> +
> +if KUNIT

The 'if' above provides the dependency clause, so the 2 'depends on KUNIT'
below are not needed.  They are redundant.

> +
> +config KUNIT_TEST
> +	bool "KUnit test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables the unit tests for the KUnit test framework. These tests test
> +	  the KUnit test framework itself; the tests are both written using
> +	  KUnit and test KUnit. This option should only be enabled for testing
> +	  purposes by developers interested in testing that KUnit works as
> +	  expected.
> +
> +config KUNIT_EXAMPLE_TEST
> +	bool "Example test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables an example unit test that illustrates some of the basic
> +	  features of KUnit. This test only exists to help new users understand
> +	  what KUnit is and how it is used. Please refer to the example test
> +	  itself, lib/kunit/example-test.c, for more information. This option
> +	  is intended for curious hackers who would like to understand how to
> +	  use KUnit for kernel development.
> +
> +endif # KUNIT



-- 
~Randy
