Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F021BA02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJPvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJPvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78281C08C5CE;
        Fri, 10 Jul 2020 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tLZrBdy0w31KZDLXNkpTiw91RFrAaSdIHK1Jn/JSlgQ=; b=h2cPnUAg2Oof0ho1HY+J3aavaW
        HTndCaBqX2gGrZiIlx74V6h9Y711Jk0gyor1Ev/EIHYMJ/TybzeMuqim0FXo5hFbJKY+2XqHOb5a2
        8+OyogCM4INWoACgZ5Kir6GxSVS6pzmxCm2c5BEhU+0zqZIzRR+n8ZK44I9+HIuyzMjpsYByAxmVL
        hYE2jase8rHtb3MAvBOUXJUXyYIQ23ZzasSEiLDLZ2hdzx7xZHqtqOXCaa1OO1VtcsAXlkBfdX41V
        pzF4x7lrZu44U+G/WvKUxt0ws2NrXvBMfSgbGbtYfz4FVNv3gPcvp1r8Pyxi1rSoMTFnLy5w5Wanu
        lzI/ARmA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtvIw-0002BS-5c; Fri, 10 Jul 2020 15:51:16 +0000
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8985bd54-0392-28c0-936c-fb1c2a0010e9@infradead.org>
Date:   Fri, 10 Jul 2020 08:51:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/20 12:56 AM, Rasmus Villemoes wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 0498af567f70..95e9486d4217 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1158,9 +1158,20 @@ config NET_NS
>  
>  endif # NAMESPACES
>  
> +config KCMP_SYSCALL
> +	bool "kcmp system call"
> +	help
> +	  Enable the kcmp system call, which allows one to determine
> +	  whether to tasks share various kernel resources, for example

	Either s/to/two/ or s/to//
?

> +	  whether they share address space, or if two file descriptors
> +	  refer to the same open file description.
> +
> +	  If unsure, say N.
> +
>  config CHECKPOINT_RESTORE
>  	bool "Checkpoint/restore support"
>  	select PROC_CHILDREN
> +	select KCMP_SYSCALL
>  	default n
>  	help
>  	  Enables additional kernel features in a sake of checkpoint/restore.


-- 
~Randy

