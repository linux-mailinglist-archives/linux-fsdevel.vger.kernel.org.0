Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5274D043C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiCGQhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiCGQhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:37:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5CC8A6E8;
        Mon,  7 Mar 2022 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yTXlmVhXdue+hw7f3NKXFRnCD1J0MzuR7RUoJXiWM7g=; b=olmpuDa+nZWk/tfWvBDceZMqN3
        AdZ3sJ/DL5xye0kqv7f6MzOhYgKKWywgGLOEh0HmsagJWoBsiQEezciTNfAsT11/6Nndh7wZr845G
        Y1sYyvPd3wnJ3fOjgXVnzpT6O3xW2p2igvzwtKCa/GBbsUol8l3k60vVj24pXMDDngHh/Ymj42RYx
        4GubAboDiV4kG4oqrvyazJWOiboaXGWrJN6i9bvf7Sd2K/s6VNlLACyemTBCgwnQ7F/lTWVP136j9
        PcxfpyrYfx9QUnUkksScXxYbEFVUUtobcVRA24yn2MdL6vkNNsCySLh7IY+L24IJdt+boO3FOQCGG
        DFL4Cnzg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRGLb-000rHT-WF; Mon, 07 Mar 2022 16:36:36 +0000
Date:   Mon, 7 Mar 2022 08:36:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiY0k8FXjsZhutOX@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <e2aeff43-a8e6-e160-1b35-1a2c1b32e443@opensource.wdc.com>
 <YiYoVmQE54mVFzHL@bombadil.infradead.org>
 <PH0PR04MB74165C10E988676726E5EDA59B089@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74165C10E988676726E5EDA59B089@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Mon, Mar 07, 2022 at 04:23:46PM +0000, Johannes Thumshirn wrote:
> On 07/03/2022 16:44, Luis Chamberlain wrote:
> > On Mon, Mar 07, 2022 at 08:56:30AM +0900, Damien Le Moal wrote:
> >> btrfs maps zones to block groups and the sectors between zone capacity
> >> and zone size are marked as unusable. The report above is not showing
> >> that. The coding is correct though. The block allocation will not be
> >> attempted beyond zone capacity.
> > 
> > That does not explain or justify why zone size was used instead of zone
> > capacity. Using the zones size gives an incorrect inflated sense of actual
> > capacity, and users / userspace applications can easily missuse that.
> > 
> > Should other filesystems follow this logic as well? If so why?
> >
> 
> The justification is, when btrfs zoned support was implemented there was no 
> zone capacity. This started with zns and thus btrfs' knowledge of 
> zone_capacity came with it's zns support. So instead of playing the blame
> game for whatever reason I don't want to know, you could have reported the
> bug or fixed it yourself.

I didn't realize it would be acknowledged as a bug, now that it is I'll
just go send a fix, thanks!

  Luis
