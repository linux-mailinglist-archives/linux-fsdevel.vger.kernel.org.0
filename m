Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913136740C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjASSVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 13:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjASSVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:21:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844059373F;
        Thu, 19 Jan 2023 10:21:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD4F468D0D; Thu, 19 Jan 2023 19:21:37 +0100 (CET)
Date:   Thu, 19 Jan 2023 19:21:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <20230119182137.GA9388@lst.de>
References: <20230112090532.1212225-1-hch@lst.de> <20230112090532.1212225-3-hch@lst.de> <20230117191222.GC11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117191222.GC11562@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:12:22PM +0100, David Sterba wrote:
> The changelog sounds like a good cover letter for a series, overall
> description but lacks more details.

So, I've done a massive split, but I need guidance on what you
want for a changelog.  There is one bit here which I've incorporated:

> - use of mempool must be mentioned in the changelog with explanation
>   that it's the safe usage pattern and why it cannot lead to lockups

but otherwise I'm at at loss.  Do you want descriptions of what the
low-level changes are counter to the normal normal Linux way of
explain why the changes are done an what the high level design
decisions are?  Or is there something else that is not obvious
from the patch and needs more elaboration?  I can't really think
of much that's missing, but maybe it's easy to overlook important
points when you've been staring at the code for half a year.

Here is the current commit text:

http://git.infradead.org/users/hch/misc.git/commitdiff/c88b5ef41a8e0b5daf645eea415ade683e2d8b72
