Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA724CB42B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 02:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiCCBD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 20:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiCCBD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:03:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975DB0B;
        Wed,  2 Mar 2022 17:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8yQc0CnC4AEyg+HOw28voqiJfaqMTkESL4AFvkxZ298=; b=UtiNF3lhz0lwJA3exKvT3iDSjo
        DTjVVyCsodBogsMbHJqx2Z9txg73jjsBcKM0ORVl/8SiijU4ZQA+ElbjjMGBMLIsdiYkYSijxtnsT
        SSscvhoRV2sFieC6AAWhBo2LHKXtMGRgK8XvrFJESqdZD4ODit2S9ixg9bT5ftrqa2nhka+ggta/b
        +jfKzB3Eegs/M/BV0QieLpPZtG/E3Yg7LPqccRmxzDUXiV4bmvbgZce4310H3gL8bcSREFL1MIckQ
        2rONdzwD+h1JAbFy8jntefPkZ8oZNBxqdit9+tGIAPZQE6MFlmoKKpLHHAW6Jr101kCcbPEcBdjo7
        NAIwO5eA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPZs6-004tpy-GU; Thu, 03 Mar 2022 01:03:10 +0000
Date:   Wed, 2 Mar 2022 17:03:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Cc:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <YiATzqllzGbAl0e5@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
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

On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
> Thinking proactively about LSFMM, regarding just Zone storage..
> 
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of

                          ^pain points

> having folks in the room we can likely settle on things faster which
> otherwise would take years.
> 
> I'll throw at least one topic out:
> 
>   * Raw access for zone append for microbenchmarks:
>   	- are we really happy with the status quo?
> 	- if not what outlets do we have?
> 
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.
> 
>   Luis
