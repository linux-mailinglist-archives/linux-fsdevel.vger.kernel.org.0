Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193921C7E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEGAUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgEGAUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:20:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABAC061A0F;
        Wed,  6 May 2020 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=excBqZStLeV60mEOM9tnGxdnFE86OJlcFs5Xupo8OTQ=; b=TXTbJAKxd9Sq2b/ULZ8MgT583W
        gJkYwJQMqbAY0ye2ORGzXFfQPT3ijQaW4QHrr2yHuJOEymUQd1k4IcdqfCzrs57HTS5sKTBN4hIZd
        4ghvIXKeB2BF62ZW6tb/i3J+SgL+vTiLpUQX9bLl4co4A1Bf9O1iRuztqG0kjn5+QrPYxzZhcA1Af
        +wFykXmPZ2AACC8OHWvkXICWlk81WeHwcXl7XUcxiXRpkAtiDcf/anMdgMaWZJo+xIiNHH4l2iu+F
        vbr/entZpIM/le/2dNgBe8zGc4p1pNsd2nQtheRLMPDbcYEonBrI0lpcw4ZC8yu3ACmGgRCBwJhbK
        L71qn97g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWUGw-0003XB-31; Thu, 07 May 2020 00:20:18 +0000
Subject: Re: [PATCH] kernel: add panic_on_taint
To:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, cai@lca.pw
References: <20200506222815.274570-1-aquini@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60e5c03f-ab34-8095-e2f3-e0ee6a1fb9c1@infradead.org>
Date:   Wed, 6 May 2020 17:20:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506222815.274570-1-aquini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/20 3:28 PM, Rafael Aquini wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..75c02c1841b2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3404,6 +3404,9 @@
>  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  
> +	panic_on_taint	panic() when the kernel gets tainted, if the taint
> +			flag being set matches with the assigned bitmask.
> +

Where is the bitmask assigned?

I.e., maybe this text should be more like:

	panic_on_taint=<bitmask>
and then the bits are explained.  See e.g. panic= and panic_print=
in this same file.


>  	crash_kexec_post_notifiers
>  			Run kdump after running panic-notifiers and dumping
>  			kmsg. This only for the users who doubt kdump always


-- 
~Randy

