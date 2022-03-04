Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16E4CDE05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiCDUQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiCDUQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:16:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D353240DFE;
        Fri,  4 Mar 2022 12:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=bLCxfOdz+dmxDq7wm6IX5GzzT29aRrqMZDoR0UjGFLs=; b=0Ldtqau6edE1j97tDw1pNp+bin
        QVTRvKSNTp0aNoqTsXAFKJvIpnPBsNZb1kU58PFzZFeaobBCuUHMus5CohDaUDu5ob+f01LkrApIx
        IWmJ9nLJXaYjrnfhlF83ws9WV8LoiIGMBLy9dpIlOMbHwX/RUElnkpcYjfvB+YeJhnGCRCjHxqda5
        0ADdpoCSZiHnZQ/ZYkRnli6Cm5PL7SiHUEMUCXwgbq8cJAw+rtRMd6nu25KzOXxY1uXOXxMZywd7Q
        LjASQFH8d8IjVUWb4o2au+fYgYUOGpYpO6OWkoucqHKGmqjdOwAfZBBgH/8aIVSLTaw3+bZ6/kdLp
        yfKyOnWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQEI3-00BuHS-RL; Fri, 04 Mar 2022 20:12:39 +0000
Date:   Fri, 4 Mar 2022 12:12:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiJyt79fELL6+/fF@bombadil.infradead.org>
References: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
 <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
 <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
 <20220303145551.GA7057@bgt-140510-bm01>
 <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
 <20220303171025.GA11082@bgt-140510-bm01>
 <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220303201831.GC11082@bgt-140510-bm01>
 <BYAPR04MB49686E8DFFF46555915F65BAF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49686E8DFFF46555915F65BAF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:33:06PM +0000, Matias Bjørling wrote:
> > -----Original Message-----
> > From: Adam Manzanares <a.manzanares@samsung.com>
> > However, an end-user application should not (in my opinion) have to deal
> > with this. It should use helper functions from a library that provides the
> > appropriate abstraction to the application, such that the applications don't
> > have to care about either specific zone capacity/size, or multiple resets. This is
> > similar to how file systems work with file system semantics. For example, a file
> > can span multiple extents on disk, but all an application sees is the file
> > semantics.
> > >
> > 
> > I don't want to go so far as to say what the end user application should and
> > should not do.
> 
> Consider it as a best practice example. Another typical example is
> that one should avoid extensive flushes to disk if the application
> doesn't need persistence for each I/O it issues. 

Although I was sad to see there was no raw access to a block zoned
storage device, the above makes me kind of happy that this is the case
today. Why? Because there is an implicit requirement on management of
data on zone storage devices outside of regular storage SSDs, and if
its not considered and *very well documented*, in agreement with us
all, we can end up with folks slightly surprised with these
requirements.

An application today can't directly manage these objects so that's not
even possible today. And in fact it's not even clear if / how we'll get
there.

So in the meantime the only way to access zones directly, if an application
wants anything close as possible to the block layer, the only way is
through the VFS through zonefs. I can hear people cringing even if you
are miles away. If we want an improvement upon this, whatever API we come
up with we *must* clearly embrace and document the requirements /
responsiblities above.

From what I read, the unmapped LBA problem can be observed as a
non-problem *iff* users are willing to deal with the above. We seem to
have disagreement on the expection from users.

Any way, there are two aspects to what Javier was mentioning and I think
it is *critial* to separate them:

 a) emulation should be possible given the nature of NAND
 b) The PO2 requirement exists, is / should it exist forever?

The discussion around these two throws drew in a third aspect:

c) Applications which want to deal with LBAs directly on
NVMe ZNS drives must be aware of the ZNS design and deal with
it diretly or indirectly in light of the unmapped LBAs which
are caused by the differences between zone sizes, zone capacity,
how objects can span multiple zones, zone resets, etc.

I think a) is easier to swallow and accept provided there is
no impact on existing users. b) and c) are things which I think
could be elaborated a bit more at LSFMM through community dialog.

  Luis
