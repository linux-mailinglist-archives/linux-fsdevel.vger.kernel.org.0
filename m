Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6167DD71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 07:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjA0Gas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 01:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjA0Gar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:30:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42947291;
        Thu, 26 Jan 2023 22:30:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B25EF68D09; Fri, 27 Jan 2023 07:30:42 +0100 (CET)
Date:   Fri, 27 Jan 2023 07:30:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: build the legacy direct I/O code conditionally
Message-ID: <20230127063042.GA3174@lst.de>
References: <20230125065839.191256-1-hch@lst.de> <20230125065839.191256-3-hch@lst.de> <Y9LulMOE1BnUMP2l@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LulMOE1BnUMP2l@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:20:20PM +0000, Al Viro wrote:
> On Wed, Jan 25, 2023 at 07:58:39AM +0100, Christoph Hellwig wrote:
> > Add a new LEGACY_DIRECT_IO config symbol that is only selected by the
> > file systems that still use the legacy blockdev_direct_IO code, so that
> > kernels without support for those file systems don't need to build the
> > code.
> 
> Looks sane...  FWIW, I've got this in the misc pile; doesn't seem to
> conflict anything in your series, thankfully...

Yes, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

If someone had time to convert ocfs2 to iomap we could also kill
the entire __blockdev_direct_IO variant.
