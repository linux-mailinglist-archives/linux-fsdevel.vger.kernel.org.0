Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5667D378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjAZRqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 12:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjAZRqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:46:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B16A31F;
        Thu, 26 Jan 2023 09:46:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0900768D05; Thu, 26 Jan 2023 18:46:12 +0100 (CET)
Date:   Thu, 26 Jan 2023 18:46:11 +0100
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
Message-ID: <20230126174611.GC15999@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-24-hch@lst.de> <Y9GkVONZJFXVe8AH@localhost.localdomain> <20230126052143.GA28195@lst.de> <Y9K7pZq2h9aXiKCJ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9K7pZq2h9aXiKCJ@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:43:01PM -0500, Josef Bacik wrote:
> I actually hadn't been running 125 because it wasn't in the auto group, Dave
> noticed it, I just tried it on this VM and hit it right away.  No worries,
> that's why we have the CI stuff, sometimes it just doesn't trigger for us but
> will trigger with the CI setup.  Thanks,

Oh, I guess the lack of auto group means I've never tested it.  But
it's a fairly bad bug, and I'm surprised nothing in auto hits an
error after a bio split.  I'll need to find out if I can find a simpler
reproducer as this warrants a regression test.
