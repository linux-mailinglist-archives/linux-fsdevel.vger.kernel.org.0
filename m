Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74E6723CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 17:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjARQnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 11:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjARQnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:43:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA738B52;
        Wed, 18 Jan 2023 08:42:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E41468D13; Wed, 18 Jan 2023 17:42:48 +0100 (CET)
Date:   Wed, 18 Jan 2023 17:42:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 8/9] btrfs: handle a NULL folio in
 extent_range_redirty_for_io
Message-ID: <20230118164247.GC7584@lst.de>
References: <20230118094329.9553-1-hch@lst.de> <20230118094329.9553-9-hch@lst.de> <Y8gZmTFB6vCivxsY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gZmTFB6vCivxsY@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:08:57PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 18, 2023 at 10:43:28AM +0100, Christoph Hellwig wrote:
> > filemap_get_folio can return NULL, skip those cases.
> 
> Hmm, I'm not sure that's true.  We have one place that calls
> extent_range_redirty_for_io(), and it previously calls
> extent_range_clear_dirty_for_io() which has an explicit
> 
>                 BUG_ON(!page); /* Pages should be in the extent_io_tree */
> 
> so I'm going to say this one can't happen either.  I haven't delved far
> enough into btrfs to figure out why it can't happen.

I'll drop this patch for now.

