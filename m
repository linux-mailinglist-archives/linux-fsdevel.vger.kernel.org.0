Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B24F77E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiDGHnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiDGHnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:43:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146771A810;
        Thu,  7 Apr 2022 00:41:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC75368AFE; Thu,  7 Apr 2022 09:41:28 +0200 (CEST)
Date:   Thu, 7 Apr 2022 09:41:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: cleanup btrfs bio handling, part 1
Message-ID: <20220407074128.GA15763@lst.de>
References: <20220404044528.71167-1-hch@lst.de> <20220405145626.GY15609@twin.jikos.cz> <20220405150956.GA16714@lst.de> <20220406180023.GC15609@twin.jikos.cz> <20220407055343.GA13812@lst.de> <PH0PR04MB7416AEB0B8ED6AA096472DAF9BE69@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416AEB0B8ED6AA096472DAF9BE69@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:48:42AM +0000, Johannes Thumshirn wrote:
> > No problem.  What branch should I use as baseline?  for-next seems to
> > be merged from not otherwise visible branches so I'm not sure that is
> > a good baseline.
> > 
> 
> Most (if not all) btrfs development happens based on misc-next which is
> at https://github.com/kdave/btrfs-devel.git misc-next

Eww.  Having to track to it trees is a bit of a nightmare..
