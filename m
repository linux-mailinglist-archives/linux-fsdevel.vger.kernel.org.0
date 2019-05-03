Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B11308D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfECOiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 10:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfECOiZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 10:38:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B53A2075E;
        Fri,  3 May 2019 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556894304;
        bh=h8oxhzJgMjKsgFLL1fTeERSR9DIUHSDvIGx4NtqrSk8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pk4OHvvgJJmv9SPnB6LKIN4E7kYPSd9V9fKtqN0iU5EoavNPnLPHQKTqci0zx2sOe
         OUW21wB7Vx2wMWr8UJHS7PkPhgYKYCStUAReyHvN/DZti58bKEgvn8G7m+LgdKLl+q
         2Iy1KJC7agYFgVsnqcKMjl9uBxuQgNZuMkNlyvD4=
Subject: Re: [PATCH v2 15/17] MAINTAINERS: add entry for KUnit the unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-16-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <68f88e1c-d40f-9dad-7296-ab2b2303c575@kernel.org>
Date:   Fri, 3 May 2019 08:38:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-16-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:01 PM, Brendan Higgins wrote:
> Add myself as maintainer of KUnit, the Linux kernel's unit testing
> framework.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c38f21aee787..c78ae95c56b80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8448,6 +8448,16 @@ S:	Maintained
>   F:	tools/testing/selftests/
>   F:	Documentation/dev-tools/kselftest*
>   
> +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> +M:	Brendan Higgins <brendanhiggins@google.com>
> +L:	kunit-dev@googlegroups.com
> +W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
> +S:	Maintained
> +F:	Documentation/kunit/
> +F:	include/kunit/
> +F:	kunit/
> +F:	tools/testing/kunit/
> +

Please add kselftest mailing list to this entry, based on our
conversation on taking these patches through kselftest tree.

thanks,
-- Shuah
