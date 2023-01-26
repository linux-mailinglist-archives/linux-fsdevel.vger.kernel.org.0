Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511B067C437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 06:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjAZFVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 00:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAZFVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 00:21:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D14609F;
        Wed, 25 Jan 2023 21:21:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A569268D09; Thu, 26 Jan 2023 06:21:43 +0100 (CET)
Date:   Thu, 26 Jan 2023 06:21:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/34] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <20230126052143.GA28195@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-24-hch@lst.de> <Y9GkVONZJFXVe8AH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9GkVONZJFXVe8AH@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 04:51:16PM -0500, Josef Bacik wrote:
> This is causing a panic in btrfs/125 because you set bbio to
> btrfs_bio(split_bio), which has a NULL end_io.  You need something like the
> following so that we're ending the correct bbio.  Thanks,

Just curious, what are the other configuration details as I've never been
able to hit it?

The fix itself looks good.
