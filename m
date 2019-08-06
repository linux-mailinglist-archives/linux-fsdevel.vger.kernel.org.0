Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDD82B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfHFFe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:34:28 -0400
Received: from verein.lst.de ([213.95.11.211]:53243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFFe2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:34:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8D5268B05; Tue,  6 Aug 2019 07:34:25 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:34:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Subject: Re: [PATCH 1/5] xfs: use a struct iomap in xfs_writepage_ctx
Message-ID: <20190806053425.GG13409@lst.de>
References: <156444951713.2682520.8109813555788585092.stgit@magnolia> <156444952349.2682520.6180005494290997205.stgit@magnolia> <20190805123826.6bv7jhcnw5ecnol7@orion.maiolino.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805123826.6bv7jhcnw5ecnol7@orion.maiolino.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:38:26PM +0200, Carlos Maiolino wrote:
> > -	 * Attempt to allocate whatever delalloc extent currently backs
> > -	 * offset_fsb and put the result into wpc->imap.  Allocate in a loop
> > -	 * because it may take several attempts to allocate real blocks for a
> > -	 * contiguous delalloc extent if free space is sufficiently fragmented.
> > +	 * Attempt to allocate whatever delalloc extent currently backs offset
> > +	 * and put the result into wpc->imap.  Allocate in a loop because it may
> 				     ^^^^
> 			And put the result into wpc->iomap?

Yes.  Darrick, can you fix this up when applying?
