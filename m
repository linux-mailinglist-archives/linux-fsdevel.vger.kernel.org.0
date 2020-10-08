Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A546287D02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgJHUXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 16:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgJHUXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:23:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D4C0613D2;
        Thu,  8 Oct 2020 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yVBIxFzxIhh6buoG9IQTw5hekcir6VBGHslr30vxoAM=; b=3GS5JQaD0dS//eru5ltEC8tYt5
        Y7jG9HzKqSbI/GeUJJ6YAw71Y39EolCxtvvc4mFjnfl5WxX17yTbBgbMBN815ZP9HCOIbPKzcI+VO
        voV/C+MKKmFQK1xdRcOlv1uImv/emHf3gI9NzcKhHJcoKpu+iErxST9lKtLje7sFZ508b0nEQihSl
        IeFjpJUItj04rZga70+NbqQtZJi+Pz1ewjrlp6AIJge7wc/dScSTyYv3J77VdrUZYEaoku2fJXAHa
        SuTjNuGQ0NRD5hct2gDTGZ108lLQELOvKcteaq843bLdfkig1vbXtuAfBuOmqN1Gbk1aBjUO+tJlT
        f2c3fsKQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQcRs-0000ke-H7; Thu, 08 Oct 2020 20:23:36 +0000
Subject: Re: [PATCH 08/35] dmem: show some statistic in debugfs
To:     yulei.kernel@gmail.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <c53436d969cd70fd67b3eb8e02b75e138c364e91.1602093760.git.yuleixzhang@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2babfe21-beb8-762b-8ede-15f3467ca841@infradead.org>
Date:   Thu, 8 Oct 2020 13:23:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c53436d969cd70fd67b3eb8e02b75e138c364e91.1602093760.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 12:53 AM, yulei.kernel@gmail.com wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e1995da11cea..8a67c8933a42 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -235,6 +235,15 @@ config DMEM
>  	  Allow reservation of memory which could be dedicated usage of dmem.
>  	  It's the basics of dmemfs.
>  
> +config DMEM_DEBUG_FS
> +	bool "Enable debug information for direct memory"
> +	depends on DMEM && DEBUG_FS
> +	def_bool n

Drop the def_bool line. 'n' is the default anyway and the symbol is
already of type bool from 2 lines above.

> +	help
> +	  This option enables showing various statistics of direct memory
> +	  in debugfs filesystem.
> +
> +#


-- 
~Randy

