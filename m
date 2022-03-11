Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B04D5B55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 07:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiCKGJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 01:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbiCKGIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:08:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845011C24;
        Thu, 10 Mar 2022 22:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zZX32PSi2aSL+p5ZY5IzG4d4sdNCU/3SVS19/PoUrc=; b=zj31q3hD7GXCmzaT+IWFsScjCU
        T+rT5A+RBalworv2YZPS7FV/Ba+v6f8QdF8OHksrdNGIlC32VTHTDcLRusyG7t3PBMiTxO4Ig96KP
        OJVMuHzSpN6OsW0n2n4erVKunciY2V8oEIuU+BF61gf66mcg4rgjwmoBg1ht9Nw/h1OME4DZCZe4f
        Aj4FQn4nAwCLXq5bsDiI/ZynnFgYiU1pZVR2Vc9tue4j3AhZQyRnzDBsepz16NGeXSTLKnBS4pQOT
        oYYbG14sVtjJaaOSGvYjf67hPHJ61kV1wcEY0LVZadooezU2RCSaMyoFin3gKO5wJHitwwKD0W8bM
        yPMLCp/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSYR0-00FDuY-Cs; Fri, 11 Mar 2022 06:07:30 +0000
Date:   Thu, 10 Mar 2022 22:07:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YirnIuXUj5RrUadm@infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
 <20220307071229.GR3927073@dread.disaster.area>
 <Yiqcgi7G7ZrEbPHV@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiqcgi7G7ZrEbPHV@bombadil.infradead.org>
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

On Thu, Mar 10, 2022 at 04:49:06PM -0800, Luis Chamberlain wrote:
> Some filesystems who want to support zone storage natively have been
> extended to do things to help with these quirks. My concerns were the
> divergence on approaches to how filesystems use ZNS as well. Do you have
> any plans to consider such efforts for XFS or would you rather build on
> ZoneFS somehow?

XFS will always require a random writable area for metadata.  I have
an old early draft with a fully zone aware allocator essentially
replacing the realtime subvolume.  But it's been catching dust so far,
maybe I'll have a chance to resurrect it if I don't have too fight too
many stupid patchseries all at once.
