Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FED143496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgATXyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 18:54:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgATXyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ql4n5W4vFN3I8Xy7sV62aN9Gf8jFQHyQ1BMzuwRtAkc=; b=ixBpRpXQibOQXwqc3Z8VjZz3z
        0hOBkaKpCzadJariHpFi+Uymd97opRdTONZAd4euJC1RNtlGryklwWTB2LKc2SC/H0LDRPA9J604G
        +wjuNV5/X51RcbXB+uTcUElNv2kUNcnnfxJT77s+GOGWDh/BC/i0tqyXPFPtyaxotDNbZK8FEdnjK
        eed5L0TDWNyjVyDJf1pZ1kDCvaEDAgoHJ2BH6NC+aKDphIOVkoYadXWY/sv1gN2OC3trWlX+G62oP
        +jpwP7+kh0I8fMKwINBO/xLw4Vr+zAWzl1FGAFlYWAL4befQLQER3VW2zljxRbYGAHirU2nfRbjB4
        rVJd3LBPg==;
Received: from [2603:3004:32:9a00::c7a3]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itgs0-0001dp-LQ; Mon, 20 Jan 2020 23:54:12 +0000
Subject: Re: [PATCH 0/3] bootconfig: tracing: Fix documentations of bootconfig
 and boot-time tracing
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
References: <157949056842.25888.12912764773767908046.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c74fe0a3-b36a-3eb1-198b-f0a9622f0bbe@infradead.org>
Date:   Mon, 20 Jan 2020 15:54:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157949056842.25888.12912764773767908046.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/19/20 7:22 PM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is the bootconfig and boot-time tracing documentation fix
> and updates. These can be applied on the latest tracing tree.
> 
> Thanks for Randy about reporting and suggesting these fixes!
> 
> Thank you,
> 
> ---

for all 3 patches:

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> Masami Hiramatsu (3):
>       bootconfig: Fix Kconfig help message for BOOT_CONFIG
>       Documentation: bootconfig: Fix typos in bootconfig documentation
>       Documentation: tracing: Fix typos in boot-time tracing documentation
> 
> 
>  Documentation/admin-guide/bootconfig.rst |   32 ++++++++++++++++--------------
>  Documentation/trace/boottime-trace.rst   |   18 ++++++++---------
>  init/Kconfig                             |    4 +++-
>  3 files changed, 29 insertions(+), 25 deletions(-)
> 
> --
> Masami Hiramatsu <mhiramat@kernel.org>
> 


-- 
~Randy
