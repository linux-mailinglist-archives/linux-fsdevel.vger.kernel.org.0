Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1A5AD54E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiIEOm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiIEOmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:42:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AD5F12E;
        Mon,  5 Sep 2022 07:40:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA17268BFE; Mon,  5 Sep 2022 16:39:51 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:39:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Message-ID: <20220905143951.GA6367@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-17-hch@lst.de> <PH0PR04MB74166908EB6DF6C586B5AC539B7F9@PH0PR04MB7416.namprd04.prod.outlook.com> <20220905142543.GA5262@lst.de> <PH0PR04MB7416B4597F2F3426A85295A49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416B4597F2F3426A85295A49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:31:53PM +0000, Johannes Thumshirn wrote:
> hmm I got that one triggered with fsx:
> 
> + /home/johannes/src/fstests/ltp/fsx -d /mnt/test/test

Odd.  Is this a raid stripe tree setup where one copy is using zone
append and another isn't?  Because without that I can't see how
this would happen.  If not cane you send me the reproducer including
the mkfs line?

