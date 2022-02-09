Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F14AF419
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiBIO3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 09:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiBIO32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:29:28 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA70C06157B;
        Wed,  9 Feb 2022 06:29:30 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219ET5t3033107;
        Wed, 9 Feb 2022 08:29:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644416945;
        bh=INMBu7PPL0wGBid1gx4F4e097L/7OHc2MPdshLnO7UU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CvnIYOKF4pXBywPyb3NY8+8oqz4Mccnm9sEvHExMjItbQuDBLnlF9eusuvMDfWRFu
         B4z0pcIHac/n9WKeQljUoMt0r3eczMv56NY6FyIs8I2tiAfq7OdmKZl+ru6uzTCnkY
         iDwct/95X0/8RKEtvG/nP1cMbPvNLniOXwW7z/8E=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219ET5x0043742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 08:29:05 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 08:29:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 08:29:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219ET41V095968;
        Wed, 9 Feb 2022 08:29:04 -0600
Date:   Wed, 9 Feb 2022 08:29:04 -0600
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
Message-ID: <20220209142904.ye22csd2zh5vynik@stack>
References: <20220208233156.E2CA6C004E1@smtp.kernel.org>
 <b18fc937-9cc2-bb7b-fb58-3ba2555371c7@infradead.org>
 <20220209090300.43241711@xps13>
 <20220209135439.qcyge32xinvazn43@chewer>
 <20220209150703.253b16bd@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220209150703.253b16bd@xps13>
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

On 15:07-20220209, Miquel Raynal wrote:
Hi Miquel,

> > > Maybe we should have added K3 people in Cc but their MAINTAINERS entry
> > > is incomplete so get_maintainers.pl did not immediately found them.  
> > 
> > What are we missing there?
> 
> Actually nothing is missing, I overlooked the file name. I touched
> arch/arm64/Kconfig.platforms in my patch and of course
> get_maintainers.pl didn't look at the symbol owners. I should have
> checked that myself manually in the first place.

Sure. thanks for cross checking.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
