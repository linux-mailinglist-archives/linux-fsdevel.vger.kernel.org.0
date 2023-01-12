Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7588D666C66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 09:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjALIbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 03:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjALIbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:31:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0239DF21;
        Thu, 12 Jan 2023 00:31:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 525FD68BEB; Thu, 12 Jan 2023 09:30:57 +0100 (CET)
Date:   Thu, 12 Jan 2023 09:30:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/11] Remove AS_EIO and AS_ENOSPC
Message-ID: <20230112083057.GA14077@lst.de>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:18:12AM +0000, Matthew Wilcox (Oracle) wrote:
> Finish the work of converting every user to the "new" wb_err
> infrastructure.  This will clash with Christoph's patch series to remove
> folio_write_one(), so I'll redo this after that patch series goes in.

Based on the conflicts with the btrfs tree picking up the btrfs part
of this series I think the best way forward is:

 - I'll resubmit my series without the two btrfs patches and the final
   patch to move folio_write_one into jfs
 - that last patch will be delayed until 6.4 and rebased on top of
   your series

While this keeps folio_write_one/write_one_page around for one more
merge window it should entangle all the work nicely.  We'll just need
to watch out that no new users appear.
