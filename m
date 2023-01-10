Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F856644EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjAJPdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 10:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbjAJPcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:32:35 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA44CE7;
        Tue, 10 Jan 2023 07:32:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BA4868BEB; Tue, 10 Jan 2023 16:32:16 +0100 (CET)
Date:   Tue, 10 Jan 2023 16:32:16 +0100
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
Message-ID: <20230110153216.GA10159@lst.de>
References: <20230108165645.381077-1-hch@lst.de> <20230109195309.GU11562@twin.jikos.cz> <20230110081653.GA11947@lst.de> <20230110130042.GA11562@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110130042.GA11562@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:00:42PM +0100, David Sterba wrote:
> On Tue, Jan 10, 2023 at 09:16:53AM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 09, 2023 at 08:53:09PM +0100, David Sterba wrote:
> > > The btrfs patches were sent separately some time ago, now merged to
> > > misc-next with updated changelogs and with the suggested switch to folio
> > > API in the 2nd patch.
> > 
> > Yes, 7 weeks ago to be exact.  I wish we could just feed everything
> > together now that we've missed the previous merge window, as that
> > makes patch juggling for Andrew and Matthew a lot simpler.
> 
> The patches are not fixes so they should wait for the next merge window.

Agreed.  But it would be a lot simpler if we could queue them up in
-mm with the other patches now that we've missed the previous merge
window.
