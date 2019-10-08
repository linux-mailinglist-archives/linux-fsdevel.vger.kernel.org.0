Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924A5D0308
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfJHVrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 17:47:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36171 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHVrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:47:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so190840pfr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deKxqqIeBJnms1ArtnCHEcClgbbTOafzse1Vw29vp3M=;
        b=FiOaf3BluQtz79g61N30s9XrSWDujtsm+6AAYd+wa70Q+3AsODwCTRCuR4GyRN/hrT
         SIad+dd5d2TROZ/tWHeb/O0bcimfWZJEHD0C58O17e+eWehUTHa50JxLCXaGg3+Pwdbf
         Rv3HMnwA2hLHY2pOpUmPw0Y5VkDqFL7ZadoKP80JrU+moRBfy3+2TZ/nn3cbt9mjZwuA
         qTxwsVmuRA7CM2wqEwxmW5X/rCeEwtekbfUduwXKxyXaKW96nPQfnT8on+T27qsC11L5
         bQdsep4WzKpTicx+rsKUnVpbKIFpHXsrKbxKKYnG/iWR3w+vYpF6IULBXXFsN1cFpX4+
         9z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deKxqqIeBJnms1ArtnCHEcClgbbTOafzse1Vw29vp3M=;
        b=nkSP9pHKpNe3aJdPyU3S9DKdhzGBwxuMWcR0J73O6pKyhfXOlVOO1JOBNXm9RDotaC
         pLmhkQfAJ4HWK+lCewZ7HWei0EWrZX2M9qWEsEGfZvF9B5hwgIsffRbVNhpppJRV2QZ4
         Iq9hcfmTd+mqj2nyETmhXDsgat2IFySWcdy4FuRDuuEwuHu99mt4jy5PFvYwfE6FXLAL
         ESy3t7QXNDE9SAcsLXJhABp0FewP8eWwWOS/4h2yt67LqJdKtNDyQR90gaQxrH48T5c0
         tdEKk2jFYx7kGekt/diljLMeJ744rhxGkNBWCRdJGfOK9XV1ZkcJ0mNlFmVlETTx565z
         WPVg==
X-Gm-Message-State: APjAAAUiTXS6kLw8EGL9XhO+B0HaOqOBh/Um+PAwnI32hAYhy/7bt+vf
        k7LsZ9eIu3E2uYth6MoMNXn+1g==
X-Google-Smtp-Source: APXvYqzrPn6t1Floi5tLW9Ts9jTNHSZ5+XjjhsO4ow7Qm01JTGlIdau0pgLA4Keuom9H5ytTcP0GsA==
X-Received: by 2002:a63:ba58:: with SMTP id l24mr591901pgu.434.1570571226070;
        Tue, 08 Oct 2019 14:47:06 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id v19sm87014pff.46.2019.10.08.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:47:04 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:47:00 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v2 linux-kselftest-test 3/3] kunit: update documentation
 to describe module-based build
Message-ID: <20191008214700.GC186342@google.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-4-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570546546-549-4-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:55:46PM +0100, Alan Maguire wrote:
> Documentation should describe how to build kunit and tests as
> modules.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> 
> ---
>  Documentation/dev-tools/kunit/faq.rst   |  3 ++-
>  Documentation/dev-tools/kunit/index.rst |  3 +++
>  Documentation/dev-tools/kunit/usage.rst | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
[...]
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index c6e6963..fa0f03f 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -539,6 +539,22 @@ Interspersed in the kernel logs you might see the following:
>  
>  Congratulations, you just ran a KUnit test on the x86 architecture!
>  
> +In a similar manner, kunit and kunit tests can also be built as modules,
> +so if you wanted to run tests in this way you might add the following config
> +options to your ``.config``:
> +
> +.. code-block:: none
> +
> +        CONFIG_KUNIT=m
> +        CONFIG_KUNIT_EXAMPLE_TEST=m

This doesn't appear to be properly tabbed.

> +Once the kernel is built and installed, a simple
> +
> +.. code-block:: bash
> +	modprobe example-test
> +
> +...will run the tests.
> +
>  Writing new tests for other architectures
>  -----------------------------------------
>  
> -- 
> 1.8.3.1
> 
