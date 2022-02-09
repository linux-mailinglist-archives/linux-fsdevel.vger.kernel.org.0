Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835224AF3A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiBIOHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiBIOHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:07:12 -0500
X-Greylist: delayed 706 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 06:07:15 PST
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FBC061355;
        Wed,  9 Feb 2022 06:07:14 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219Dsdrd023902;
        Wed, 9 Feb 2022 07:54:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644414879;
        bh=uXWud1+qmR023V5cJfdeKbgOBMmLlhDqz1glFdO81RI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fnQb9WXfzGF4ifc7OYteA3tqAaA7MlJz9S20N3yTGpEihr8ol8C/th/8s+gtavoR/
         bGgT6E2WOjmEfnSOfhABzRUbpKHSHDz+yqL8tniHbS+VZ8rg6WRH01bf9AXIWl7AU0
         xb7GTyzTmw3R2qqiIaGgQ00ssV4ca7wb7VLyRsP4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219DsdEI044066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 07:54:39 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 07:54:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 07:54:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219DsdfJ013530;
        Wed, 9 Feb 2022 07:54:39 -0600
Date:   Wed, 9 Feb 2022 07:54:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <broonie@kernel.org>, <mhocko@suse.cz>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mm-commits@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: mmotm 2022-02-08-15-31 uploaded (drivers/mtd/nand/raw/Kconfig)
Message-ID: <20220209135439.qcyge32xinvazn43@chewer>
References: <20220208233156.E2CA6C004E1@smtp.kernel.org>
 <b18fc937-9cc2-bb7b-fb58-3ba2555371c7@infradead.org>
 <20220209090300.43241711@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220209090300.43241711@xps13>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09:03-20220209, Miquel Raynal wrote:
> Hi Randy,
> 
> rdunlap@infradead.org wrote on Tue, 8 Feb 2022 22:30:23 -0800:
> 
> > On 2/8/22 15:31, Andrew Morton wrote:
> > > The mm-of-the-moment snapshot 2022-02-08-15-31 has been uploaded to
> > > 
> > >    https://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > mmotm-readme.txt says
> > > 
> > > README for mm-of-the-moment:
> > > 
> > > https://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> > > 
> > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > https://ozlabs.org/~akpm/mmotm/series
> > > 
> > > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > > followed by the base kernel version against which this patch series is to
> > > be applied.  
> > 
> > on i386:
> > 
> > WARNING: unmet direct dependencies detected for OMAP_GPMC
> >   Depends on [n]: MEMORY [=y] && OF_ADDRESS [=n]
> >   Selected by [y]:
> >   - MTD_NAND_OMAP2 [=y] && MTD [=y] && MTD_RAW_NAND [=y] && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
> > 
> > 
> > Full randconfig file is attached.
> 
> + Uwe, + K3 people + Krzysztof

Thanks for looping me in.

> 
> Uwe already raised the issue, and this was proposed:
> 
> https://lore.kernel.org/linux-mtd/20220127105652.1063624-1-miquel.raynal@bootlin.com/T/

I will respond to the patch.

> 
> Maybe we should have added K3 people in Cc but their MAINTAINERS entry
> is incomplete so get_maintainers.pl did not immediately found them.

What are we missing there?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
