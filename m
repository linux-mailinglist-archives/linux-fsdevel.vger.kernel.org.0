Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DA72980E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFILUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFILUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:20:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0EC1;
        Fri,  9 Jun 2023 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rLNelPrOQBAVxjBWyHqNPZTxjLdup6TmGjF/YpHSjt4=; b=Mx2PLkxnIexzgZQpmsFyLx/Q2b
        zmdpai16jB6MLCuwR2UtaDWbt1RvqLjDRE7oYoJ4pni9wuY/dJfTDBU2voPfuXHGWLAJYT27ScEZ9
        Nkyr87DqBB1TTyDuslGsYHEcLyf7hz1oT3xSPaiwm8PRpGpi/hNhhIgfPBZQmnVpOYB/SBXDQAOWa
        O5pEfBTp86K2tgB63Xzbgq0VUZcbsU4xr/8e1HYKt8N5Zu+Ma32Bnfn6GyoqWelb+jZIZO/uADA6E
        Ip7AjpYlCXlFZXfVW4lBaxgGiLYf60EpisPdwaFjNLdMoSbUDdbjizF/ViyhxBbRdUBE4xQr63Bji
        gMMwmo1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52444)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q7aAK-0001sZ-QH; Fri, 09 Jun 2023 12:20:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q7aAH-0001o2-CM; Fri, 09 Jun 2023 12:20:21 +0100
Date:   Fri, 9 Jun 2023 12:20:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "jim.tsai" <Wei-chin.Tsai@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/1] memory: export symbols for process memory related
 functions
Message-ID: <ZIMK9QV5+ce69Shr@shell.armlinux.org.uk>
References: <20230609110902.13799-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609110902.13799-1-Wei-chin.Tsai@mediatek.com>
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

On Fri, Jun 09, 2023 at 07:09:00PM +0800, jim.tsai wrote:
> Export symbols for arch_vma_name and smap_gather_stats
> functions so that we can detect the memory leak issues.
> Besides, we can know which memory type is leaked, too.

This commit description doesn't give enough information. How does
exporting arch_vma_name() help with detecting memory leak issues?

You haven't included any users of these new exports, so the initial
reaction is going to be negative - please include the users of these
new symbols in your patch set.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
