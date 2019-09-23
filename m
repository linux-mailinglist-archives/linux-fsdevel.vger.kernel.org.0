Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18FBB862
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfIWPse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:48:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfIWPse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M6naaO3eN2JtKgsodjGmbFEb7omduasR6eHtDOBj/YU=; b=WDxDdSVtxB4MQheuYDglZVo77
        ITnMkIz7R+0s/TcK9u0iB564ZvSW2OG/lJv1lRwdjnxBatB+wSX35svuC1yd5Ea1AxQ52gRn6cmF2
        /83K/HFVn4+skc/Wt6uGE+DwUbc77iTcslmEjK/CRAvgV+6YQUkzJbtlBrr5Q+8JJKlmrTyBq44/u
        TJiHeSIwQ3VM6J44S1d1yNryMKLsQ8iZf1OrD6FnYs6OHkND8aMMMkrLPNGm6nhYxiQsA6gnvmund
        vT7S7hcNSvEXvCDhPF31ee1v2WxWOnkGIihjEU+7pqNLhV5/Kty9KSYUOFACXDa3f7vCTTX3UOnh6
        bZwx9NxQw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCQZ9-00063q-MO; Mon, 23 Sep 2019 15:47:55 +0000
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
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
        torvalds@linux-foundation.org,
        Felix Guo <felixguoxiuping@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
Date:   Mon, 23 Sep 2019 08:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923090249.127984-16-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/19 2:02 AM, Brendan Higgins wrote:
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/dev-tools/index.rst           |   1 +
>  Documentation/dev-tools/kunit/api/index.rst |  16 +
>  Documentation/dev-tools/kunit/api/test.rst  |  11 +
>  Documentation/dev-tools/kunit/faq.rst       |  62 +++
>  Documentation/dev-tools/kunit/index.rst     |  79 +++
>  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
>  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
>  7 files changed, 925 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
>  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
>  create mode 100644 Documentation/dev-tools/kunit/faq.rst
>  create mode 100644 Documentation/dev-tools/kunit/index.rst
>  create mode 100644 Documentation/dev-tools/kunit/start.rst
>  create mode 100644 Documentation/dev-tools/kunit/usage.rst


> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> new file mode 100644
> index 000000000000..6dc229e46bb3
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -0,0 +1,180 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Getting Started
> +===============
> +
> +Installing dependencies
> +=======================
> +KUnit has the same dependencies as the Linux kernel. As long as you can build
> +the kernel, you can run KUnit.
> +
> +KUnit Wrapper
> +=============
> +Included with KUnit is a simple Python wrapper that helps format the output to
> +easily use and read KUnit output. It handles building and running the kernel, as
> +well as formatting the output.
> +
> +The wrapper can be run with:
> +
> +.. code-block:: bash
> +
> +   ./tools/testing/kunit/kunit.py run
> +
> +Creating a kunitconfig
> +======================
> +The Python script is a thin wrapper around Kbuild as such, it needs to be

                                       around Kbuild. As such,

> +configured with a ``kunitconfig`` file. This file essentially contains the
> +regular Kernel config, with the specific test targets as well.
> +
> +.. code-block:: bash
> +
> +	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> +	cd $PATH_TO_LINUX_REPO
> +	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> +
> +You may want to add kunitconfig to your local gitignore.
> +
> +Verifying KUnit Works
> +---------------------
> +
> +To make sure that everything is set up correctly, simply invoke the Python
> +wrapper from your kernel repo:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py
> +
> +.. note::
> +   You may want to run ``make mrproper`` first.

I normally use O=builddir when building kernels.
Does this support using O=builddir ?

> +
> +If everything worked correctly, you should see the following:
> +
> +.. code-block:: bash
> +
> +	Generating .config ...
> +	Building KUnit Kernel ...
> +	Starting KUnit Kernel ...
> +
> +followed by a list of tests that are run. All of them should be passing.
> +
> +.. note::
> +   Because it is building a lot of sources for the first time, the ``Building
> +   kunit kernel`` step may take a while.
> +
> +Writing your first test
> +=======================

[snip]

> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> new file mode 100644
> index 000000000000..c6e69634e274
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/usage.rst

TBD...


-- 
~Randy
