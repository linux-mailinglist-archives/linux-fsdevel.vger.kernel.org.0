Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6187304D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjFNQV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjFNQVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:21:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E600119;
        Wed, 14 Jun 2023 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QWph71KWV3aPlqaV648UJHe6lbKZBpXdiDZJikc9zP8=; b=y45S5FcBhDXz+6NaXk1EUEetiF
        Vc+jk0MdpAtlg8qedoWjj6F9Zx4e7xguW8BAmEOEp2GikxxxOl8ZPV+zZLnrJHFphEVu89yYUHoBx
        jstoLPfDBdQt0YvbHkJXz+4agTaR9PuMcHXVI8Y2hNpO7BS0uy8Y5tjm/p1WiXvAzk8peUiqaC96g
        xBNo9bbF9J22MdPpTtUQMn81sfT+5ZQf2AlSOLPl0F3Zz5wrboKUSmlEqBtkYxQnJbPVMTCaBSyiA
        C4rKMZGYgpFMuo6t/mXfVKG/Hag5OHRTOMQcKuZ7x7FsbtDy91b7kpYYA/0z4gl395hb8tiN0gCEy
        UljwbNjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51956)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q9TFi-0001xs-6h; Wed, 14 Jun 2023 17:21:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q9TFf-0000Yu-9i; Wed, 14 Jun 2023 17:21:43 +0100
Date:   Wed, 14 Jun 2023 17:21:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Wei-chin Tsai =?utf-8?B?KOiUoee2reaZiSk=?= 
        <Wei-chin.Tsai@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Lee =?utf-8?B?KOadjuWlh+mMmik=?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Ivan Tseng =?utf-8?B?KOabvuW/l+i7kik=?= 
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Message-ID: <ZInpF3aKMLFVQ3Vf@shell.armlinux.org.uk>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
 <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
 <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
 <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
 <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
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

On Wed, Jun 14, 2023 at 02:11:25PM +0200, AngeloGioacchino Del Regno wrote:
> Il 14/06/23 11:59, Wei-chin Tsai (蔡維晉) ha scritto:
> > On Wed, 2023-06-14 at 08:16 +0100, Russell King (Oracle) wrote:
> > >   	
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >   On Wed, Jun 14, 2023 at 11:20:34AM +0800, Wei Chin Tsai wrote:
> > > > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > > > index 0e8ff85890ad..df91412a1069 100644
> > > > --- a/arch/arm/kernel/process.c
> > > > +++ b/arch/arm/kernel/process.c
> > > > @@ -343,6 +343,7 @@ const char *arch_vma_name(struct vm_area_struct
> > > *vma)
> > > >   {
> > > >   return is_gate_vma(vma) ? "[vectors]" : NULL;
> > > >   }
> > > > +EXPORT_SYMBOL_GPL(arch_vma_name);
> > > ...
> > > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > > index b5370fe5c198..a1abe77fcdc3 100644
> > > > --- a/kernel/signal.c
> > > > +++ b/kernel/signal.c
> > > > @@ -4700,6 +4700,7 @@ __weak const char *arch_vma_name(struct
> > > vm_area_struct *vma)
> > > >   {
> > > >   return NULL;
> > > >   }
> > > > +EXPORT_SYMBOL_GPL(arch_vma_name);
> > > 
> > > Have you confirmed:
> > > 1) whether this actually builds
> > > 2) whether this results in one or two arch_vma_name exports
> > > 
> > > ?
> > > 
> > > -- 
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> > Hi Russell,
> > 
> > We did confirm that it can be built successfully in kernel 6.1 and run
> > well in our system.
> > 
> 
> It runs well in your system and can be built successfully because you're building
> for ARM64, not for ARM...
> 
> > Actually, we only use this export symbol "arch_vma_name"
> > from kernel/signal.c in arm64. We also export symbol for arch_vma_name
> > in arch/arm/kernel/process.c because that, one day in the future,  we
> > are afraid that we also need this function in arm platform.

What I'm trying to get at is that we have arch_vma_name in
arch/arm/kernel/process.c and also a weak function in kernel/signal.c.

Both of these end up adding an entry into the __ksymtab_strings
section and a ___ksymtab section for this symbol. So we end up with
two entries in each.

Now, if the one from kernel/signal.c points at its own weak function,
and that is found first, then that's the function that is going to be
bound, not the function that's overriding it.

If, instead, the export in kernel/signal.c ends up pointing at the
overriden function, then the export in arch/arm/kernel/process.c is
entirely redundant.

So, you need to get to the bottom of this... and until you do I'm
afraid I'll have to NAK this patch.

For the record, I suspect it's the latter scenario (we end up with
two entries pointing at the same function) but that's nothing more
than a hunch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
