Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B955160B900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiJXUAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiJXT7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:59:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D08173594;
        Mon, 24 Oct 2022 11:22:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E5C06732D; Mon, 24 Oct 2022 16:44:11 +0200 (CEST)
Date:   Mon, 24 Oct 2022 16:44:11 +0200
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
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221024144411.GA25172@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:
> David, what's your plan to progress with this series?

FYI, I object to merging any of my code into btrfs without a proper
copyright notice, and I also need to find some time to remove my
previous significant changes given that the btrfs maintainer
refuses to take the proper and legally required copyright notice.

So don't waste any of your time on this.
