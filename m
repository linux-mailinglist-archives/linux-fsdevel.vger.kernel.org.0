Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC81418F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgARSd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 13:33:57 -0500
Received: from [198.137.202.133] ([198.137.202.133]:44030 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgARSd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O0FvQU1+LL+nY/awXfWm1zOJdSt4kxBeR65IPQXUBzQ=; b=HKrlvjMUQYbnZqM268AjtmGso
        VEUfPKnFUvFb9/dyAxD4OjzdeuQnC0z9arbqs6pt4TMCnOXand+EwQC9JqCgpVgGkVTSt1qeMTsL7
        hZ9sa1FOilpIQqome3sGu1z/NCOGLTL1X7/hm6/2pgHLC7ZoDtVJDYW2JEMd7AHeZddj0AbJ+DrX9
        AqiAnVmL5JvZAOUxarOKTcnL29YWznUVjDlxqHAU1s/uQgGeECBoJ5I4ricMU3DFTsbuabhH0sNGq
        UOO8eln4QXe06l2ugRVaWK/cBK5Z15YNvcQJpRtWqZd8uX3Y/wkdCH5lrFSrBu+8JMkVc7RPdFu+j
        hdxReIfjw==;
Received: from [2603:3004:32:9a00::ce80]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1issu6-0003uP-6e; Sat, 18 Jan 2020 18:33:04 +0000
Subject: Re: [PATCH v6 01/22] bootconfig: Add Extra Boot Config support
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867221257.17873.1775090991929862549.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a61b3af0-e61c-f135-d7d4-3ff51b8117dc@infradead.org>
Date:   Sat, 18 Jan 2020 10:33:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157867221257.17873.1775090991929862549.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/10/20 8:03 AM, Masami Hiramatsu wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index a34064a031a5..63450d3bbf12 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1215,6 +1215,17 @@ source "usr/Kconfig"
>  
>  endif
>  
> +config BOOT_CONFIG
> +	bool "Boot config support"
> +	select LIBXBC
> +	default y
> +	help
> +	  Extra boot config allows system admin to pass a config file as
> +	  complemental extension of kernel cmdline when booting.
> +	  The boot config file is usually attached at the end of initramfs.

Is there some other location where it might be attached?
Please explain.

> +
> +	  If unsure, say Y.
> +
>  choice
>  	prompt "Compiler optimization level"
>  	default CC_OPTIMIZE_FOR_PERFORMANCE


-- 
~Randy
