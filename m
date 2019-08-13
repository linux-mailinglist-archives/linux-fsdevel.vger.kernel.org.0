Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A561F8ADE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 06:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHMEjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 00:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfHMEjB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:39:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 661F82054F;
        Tue, 13 Aug 2019 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565671139;
        bh=3xMxQdsEpxtjj+1yTxgV9WOlUO2WQ552exvs56/rr1o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LR11it/I3O8CGTrv+Ng5zvucPa8uUkEfa3LmKFjw6O5u9qhsOj4v0EPjTnoOYONrH
         u/tnKqLjb2VOMamzmBD+bQ92PSyu/l9yjopx4tVHE3QOH9DwxrVN/Ixn8t2s8dlBob
         UQtw5MZJLoTm4I6qlCWqOvb7Iah3ocYPA4XTG7DY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-15-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-15-brendanhiggins@google.com>
Subject: Re: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building KUnit tests
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 21:38:58 -0700
Message-Id: <20190813043859.661F82054F@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:17)
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defc=
onfig
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/arch/um/configs/kunit_defconfig
> @@ -0,0 +1,8 @@
> +CONFIG_OF=3Dy
> +CONFIG_OF_UNITTEST=3Dy
> +CONFIG_OF_OVERLAY=3Dy
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_MUX=3Dy
> +CONFIG_KUNIT=3Dy
> +CONFIG_KUNIT_TEST=3Dy
> +CONFIG_KUNIT_EXAMPLE_TEST=3Dy
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -0,0 +1,8 @@
> +CONFIG_OF=3Dy
> +CONFIG_OF_UNITTEST=3Dy
> +CONFIG_OF_OVERLAY=3Dy
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_MUX=3Dy

Are these above config options necessary? I don't think they're part of
the patch series anymore so it looks odd to enable the OF unittests and
i2c configs.

> +CONFIG_KUNIT=3Dy
> +CONFIG_KUNIT_TEST=3Dy
> +CONFIG_KUNIT_EXAMPLE_TEST=3Dy
