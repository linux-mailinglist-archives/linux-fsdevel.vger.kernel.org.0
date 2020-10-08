Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92B2287D14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgJHU1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgJHU1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:27:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B5C0613D2;
        Thu,  8 Oct 2020 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7jif2k9zcZ8cHV0IvpYw8TET4vLh557VQNExhD1A4Wo=; b=CTzcYsDLt2qZcuaRE50e5/Tk0x
        RORejz9K7yDXQyTYhwvrg2JWgAcrr9LYrXw6bsr6DS4rkl0ey7kkju4NqD5Q0Mjvk4GAElSkaMq7f
        RkpyWSqvrV8IWfmiFG80+lSVgrT4+QcRoXKwfaGxRAVRY3/kQEHr0O9sxUNOpfIUEz8l32dqleWeN
        hwKhOPdKI0D21AuXgGOsCDP7GsBGteclbShiuMLFKxMSpfIGquwuZKwG8hMVrJxmVAZzuzBM4T0Uk
        La63iEZMMhHGqBJ59SqoXFtB+cFa5O931XHzGVAACARHUCliVLXRBXH2DY8Bvq2u7FgWYFVuMQaQl
        3FCQ0bjQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQcVY-00014w-Tq; Thu, 08 Oct 2020 20:27:25 +0000
Subject: Re: [PATCH 02/35] mm: support direct memory reservation
To:     yulei.kernel@gmail.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <2fbc347a5f52591fc9da8d708fef0be238eb06a5.1602093760.git.yuleixzhang@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84108593-f56a-8897-2026-a27d07a4824e@infradead.org>
Date:   Thu, 8 Oct 2020 13:27:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2fbc347a5f52591fc9da8d708fef0be238eb06a5.1602093760.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 12:53 AM, yulei.kernel@gmail.com wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c974888f86f..e1995da11cea 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -226,6 +226,15 @@ config BALLOON_COMPACTION
>  	  scenario aforementioned and helps improving memory defragmentation.
>  
>  #
> +# support for direct memory basics
> +config DMEM
> +	bool "Direct Memory Reservation"
> +	def_bool n

Drop the def_bool line.

> +	depends on SPARSEMEM
> +	help
> +	  Allow reservation of memory which could be dedicated usage of dmem.

	                                             dedicated to the use of dmem.
or
	                              which could be for the dedicated use of dmem.

> +	  It's the basics of dmemfs.

	           basis


-- 
~Randy

