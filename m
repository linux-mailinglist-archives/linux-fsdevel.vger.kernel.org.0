Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B08666C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjALIFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 03:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjALIE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:04:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3A4FD58;
        Thu, 12 Jan 2023 00:02:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2630A68BEB; Thu, 12 Jan 2023 09:02:33 +0100 (CET)
Date:   Thu, 12 Jan 2023 09:02:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove write_one_page / folio_write_one
Message-ID: <20230112080232.GA12920@lst.de>
References: <20230108165645.381077-1-hch@lst.de> <20230109195309.GU11562@twin.jikos.cz> <20230110081653.GA11947@lst.de> <20230110130042.GA11562@suse.cz> <20230110153216.GA10159@lst.de> <20230111192027.GJ11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111192027.GJ11562@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 08:20:27PM +0100, David Sterba wrote:
> Ok then, to make it easier for the folio changes I'll send the two btrfs
> patches next week. As the rest of the series does not depend on it,
> I don't see the need to let them all go via the mm tree.

The last patch depends on the btrfs changes as it removes write_one_page
entirely.
