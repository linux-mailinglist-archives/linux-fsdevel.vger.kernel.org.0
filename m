Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B324D5DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 09:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiCKIrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 03:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCKIrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:47:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A01BA927;
        Fri, 11 Mar 2022 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BjiPEUQ71tUca48iumOg0cUwE/Qm4Dl7SatHwSELFAc=; b=may5sVdzPgFlyETPK7ghtZvL5M
        vgNtRztfRnK9qJofT147hObMIaiwlMnNzQS6+E3AVeQ8wktFUGXwjTxmUSD/nOxOgkKTY4D7uUlg6
        xeWvW3cVT05G3RaquuEhz35yEAcFJVpVAt8HpwoOHhOFEE6SXlK0STmk0sIADpqfHMKKoj6nCQG/T
        316KJGS4RYxR9p4hbSLWL2W+aC9lI3IMG/wS3KNg/D08NaT/Me2VtgXtigQBWktQWocclIzzVk9Wp
        lQd1Ls9dsXT0vyllvRqMl03m3dl4fJozm7AyeuUb27ZCQ1apO6f//LEvwk4q2LCAiSRec3JrkVRfm
        3pdjhvqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSauY-00Ffe1-PO; Fri, 11 Mar 2022 08:46:10 +0000
Date:   Fri, 11 Mar 2022 00:46:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YisMUruNKNlV8FhW@infradead.org>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
 <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:53:17AM +0100, Javier González wrote:
> How do you propose we meed the request from Damien to support _all_
> existing users if we remove the PO2 constraint from the block layer?

By actually making the users support it.  Not by adding crap to
block drivers to pretend that they are exposing something totally
different than what they actually are.
