Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7257119E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 06:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGLE5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 00:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGLE5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:57:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050387D7B4;
        Mon, 11 Jul 2022 21:57:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38CBF68AA6; Tue, 12 Jul 2022 06:57:19 +0200 (CEST)
Date:   Tue, 12 Jul 2022 06:57:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/4] gfs2: remove ->writepage
Message-ID: <20220712045719.GA4705@lst.de>
References: <20220711041459.1062583-1-hch@lst.de> <20220711041459.1062583-3-hch@lst.de> <CAHpGcMLFwN4toB2KD0EvPAgx3zchpGNfzUWfsJ-8dxmnOieCsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLFwN4toB2KD0EvPAgx3zchpGNfzUWfsJ-8dxmnOieCsQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:22:48AM +0200, Andreas Grünbacher wrote:
> It should be possible to remove the .writepage operation in
> gfs2_jdata_aops as well, but I must be overlooking something because
> that actually breaks things.

We'll need to wire up ->migratepage for it first to not lose any memory
migration functinality.  But yes, the plan is to eventually kill off
->writepage.  If I can get you to look into gfs2_jdata_aops,
gfs2_meta_aops and gfs2_rgrp_aops, that would be awesome.
