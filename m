Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4F7305B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFNRLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFNRLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:11:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70A193;
        Wed, 14 Jun 2023 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PzHse57bv4opp79PeT1dv2mWGxXGJza2n381yUGCxXU=; b=lDm3enHkz3oN3jZVWOiZa5CfAN
        9SO2XxwIPaLlNlFCvB+JNkLMGoT2HxgeTEWt3Awr4f6mHVUHaOeEqWxK5kgL/U6BSeCpBSzz0ikBE
        lBRD3cGK42Dq0gHovPb0ygCMl1CLuOwHdGRo2xTe2/GWFehc/vokQ6J/pDXQeTi0Z9HV6dnGR/zzY
        OzBDX0AL5e4OP1kyXhw/WQhXiyYyb4srATq8xCFwkA+cIbROkfJQw06JTQ8/ojL7rlFeNaqouYPF4
        dDlTKThXSBI4C1Z3fRDY1RcmFEBde+RSwF+GPscP4J3HkcGnGRabWk5YtKJib/yOmhRedVFvIw5x1
        ROxzaOgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9U1U-006ZZ9-9h; Wed, 14 Jun 2023 17:11:08 +0000
Date:   Wed, 14 Jun 2023 18:11:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wei-chin Tsai =?utf-8?B?KOiUoee2reaZiSk=?= 
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
Message-ID: <ZIn0rMjYESJHuzyg@casper.infradead.org>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
 <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
 <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
 <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
 <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
 <ZInpF3aKMLFVQ3Vf@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInpF3aKMLFVQ3Vf@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:21:43PM +0100, Russell King (Oracle) wrote:
> What I'm trying to get at is that we have arch_vma_name in
> arch/arm/kernel/process.c and also a weak function in kernel/signal.c.
> 
> Both of these end up adding an entry into the __ksymtab_strings
> section and a ___ksymtab section for this symbol. So we end up with
> two entries in each.
> 
> Now, if the one from kernel/signal.c points at its own weak function,
> and that is found first, then that's the function that is going to be
> bound, not the function that's overriding it.
> 
> If, instead, the export in kernel/signal.c ends up pointing at the
> overriden function, then the export in arch/arm/kernel/process.c is
> entirely redundant.
> 
> So, you need to get to the bottom of this... and until you do I'm
> afraid I'll have to NAK this patch.

I think the patch should be NAKed indefinitely.  I had a quick look at
the user, and it seems like something is being done in the kernel that
should be done in userspace.
