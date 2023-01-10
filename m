Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A8663AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 09:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjAJIYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 03:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjAJIYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:24:38 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79543A1C;
        Tue, 10 Jan 2023 00:24:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A99F68AFE; Tue, 10 Jan 2023 09:24:29 +0100 (CET)
Date:   Tue, 10 Jan 2023 09:24:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/7] sysv: don't flush page immediately for DIRSYNC
 directories
Message-ID: <20230110082428.GC11947@lst.de>
References: <20230108165645.381077-1-hch@lst.de> <20230108165645.381077-5-hch@lst.de> <Y7szWmUKSwcxsaMu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7szWmUKSwcxsaMu@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 09:19:22PM +0000, Matthew Wilcox wrote:
> On Sun, Jan 08, 2023 at 05:56:42PM +0100, Christoph Hellwig wrote:
> > We do not need to writeout modified directory blocks immediately when
> > modifying them while the page is locked. It is enough to do the flush
> > somewhat later which has the added benefit that inode times can be
> > flushed as well. It also allows us to stop depending on
> > write_one_page() function.
> 
> Similar concerns to the minix patch here ... missing assignments to
> 'err'.

Fixed.
