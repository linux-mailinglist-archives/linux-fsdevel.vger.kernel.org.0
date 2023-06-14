Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E380672F5E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbjFNHRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbjFNHRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:17:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2021BF7;
        Wed, 14 Jun 2023 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A9oFU+vnOlGnOM0ionZnLQAJ6RAa+8dpH74N0R9yvEA=; b=YgLOWv9y/h1kcMSUvXXE1RqI2U
        5u1+AMg0qRQ1SCamLEl+xlHT9EVOsT+1GVlKx0PBntOJ32RfmiDzWmn5dG8mxmdXa1H6HTSQgifOY
        ckfGCkQKSrLrTRWYYh9vj38QYMhMYl/Z/xjl6/m4W7GWND/iwXB+wuEbXMcJ04pRS3DuYA8mYt8k7
        9xgtbJig0pDfwc4YG+40XMluUEQdLmieOKo6sjzfO5G7cMwzZasyEeiDVuclhAAcketABJ4mbHyRs
        /C2BWOMYHz/ZrWsodxyU6eZKY+D9XXjJht8uCevjpwWuWTv+vzbWvEN38B+PjCkuGDVrmNmhYuuLV
        OoTlVkOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53908)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q9KkH-0001Bx-E8; Wed, 14 Jun 2023 08:16:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q9KkD-0000DH-Of; Wed, 14 Jun 2023 08:16:41 +0100
Date:   Wed, 14 Jun 2023 08:16:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Message-ID: <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
 <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:20:34AM +0800, Wei Chin Tsai wrote:
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 0e8ff85890ad..df91412a1069 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -343,6 +343,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>  {
>  	return is_gate_vma(vma) ? "[vectors]" : NULL;
>  }
> +EXPORT_SYMBOL_GPL(arch_vma_name);
...
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b5370fe5c198..a1abe77fcdc3 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4700,6 +4700,7 @@ __weak const char *arch_vma_name(struct vm_area_struct *vma)
>  {
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(arch_vma_name);

Have you confirmed:
1) whether this actually builds
2) whether this results in one or two arch_vma_name exports

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
