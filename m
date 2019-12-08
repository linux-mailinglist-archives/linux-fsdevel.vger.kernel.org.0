Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6976F11639A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfLHTeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 14:34:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHTef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=opNmX6AL5pe9BiEApgh4safJJRAYoGJDanS+73QXh4o=; b=HQmIHIGh6pFM4c8sq8vsdzEol
        FJJw4CAdpQu5FBEmzwuax5uP7Pqqh0+86C6fUfExA4wQjHa0tQGL/xx2Sa04/NaX/Ui9VI+GYjzKl
        3JFLiO+qaqc2ru18YySDKhzus/TBG6/PICSlaW9fMncAwYvw0OxmUfyhk7Mc2YQRVz7l9XPpG91ie
        NeTRF5CPu3c/omskP0kYKkKyYLGPZeeAETo6CsDCo77R2lpl1+t2bE1vJa164rlGEdafeg3wGRzPa
        thKQSfpuBY2Lu4KysTSnCp7sX4EHuGk/P//OqbDEozZzaXGFOaWFD6qH0A8MsdVeB+WJIAhhS0hjq
        CTkxk4vyQ==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie2K9-0005In-LR; Sun, 08 Dec 2019 19:34:33 +0000
Subject: Re: [RFC PATCH v4 01/22] bootconfig: Add Extra Boot Config support
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
 <157528160980.22451.2034344493364709160.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
Date:   Sun, 8 Dec 2019 11:34:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <157528160980.22451.2034344493364709160.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/2/19 2:13 AM, Masami Hiramatsu wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 67a602ee17f1..13bb3eac804c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1235,6 +1235,17 @@ source "usr/Kconfig"
>  
>  endif
>  
> +config BOOT_CONFIG
> +	bool "Boot config support"
> +	select LIBXBC
> +	default y

questionable "default y".
That needs lots of justification.

> +	help
> +	 Extra boot config allows system admin to pass a config file as
> +	 complemental extension of kernel cmdline when boot.

	                                          when booting.

> +	 The boot config file is usually attached at the end of initramfs.

The 3 help text lines above should be indented with one tab + 2 spaces,
like the "If" line below.

> +
> +	  If unsure, say Y.
> +
>  choice
>  	prompt "Compiler optimization level"
>  	default CC_OPTIMIZE_FOR_PERFORMANCE


-- 
~Randy

