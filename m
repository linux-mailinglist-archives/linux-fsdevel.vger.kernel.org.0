Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FEB5290E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfFYKIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:08:45 -0400
Received: from verein.lst.de ([213.95.11.211]:33408 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKIl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:08:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 45AF768C65; Tue, 25 Jun 2019 12:08:10 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:08:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190625100810.GH1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-12-hch@lst.de> <20190624154601.GK5387@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624154601.GK5387@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 08:46:01AM -0700, Darrick J. Wong wrote:
> This looks like a straight code copy from fs/xfs/ into fs/iomap.c.
> That's fine with me, but seeing as this file is now ~2700 lines long,
> perhaps we should break this up among major functional lines?
> 
> Looking at fs/iomap.c, I see...
> 
>  * Basic iomap iterator functions (~40 lines)
>  * Page cache management (readpage*, write, mkwrite) (~860 lines)
>  * Zeroing (~80 lines)
>  * FIEMAP and seek hole / seek data (~300 lines)
>  * directio (~500 lines)
>  * swapfiles (~170 lines)
>  * and now, page cache writeback (~520 lines)
> 
> If I have spare time this week (ha ha) I'll see if I can break all this
> up (as a separate patch series), so for this:

Meh.  Not sure I'm a fan of too fine grained splits like the one
above.  And ~3k lines is still pretty manageable.  But yes, once it
grows むore it might be worth splitting a bit.
