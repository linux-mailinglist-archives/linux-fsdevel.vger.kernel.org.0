Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98791EB01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfD2Tmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 15:42:45 -0400
Received: from verein.lst.de ([213.95.11.211]:40820 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfD2Tmp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:42:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E5FB68AFE; Mon, 29 Apr 2019 21:42:28 +0200 (CEST)
Date:   Mon, 29 Apr 2019 21:42:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/4] iomap: Clean up __generic_write_end calling
Message-ID: <20190429194227.GA6138@lst.de>
References: <20190429163239.4874-1-agruenba@redhat.com> <CAHc6FU5jgGGsHS9xRDMmssOH3rzDWoRYvrnDM5mHK1ASKc60yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5jgGGsHS9xRDMmssOH3rzDWoRYvrnDM5mHK1ASKc60yA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:46:29PM +0200, Andreas Gruenbacher wrote:
> On Mon, 29 Apr 2019 at 18:32, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Move the call to __generic_write_end into iomap_write_end instead of
> > duplicating it in each of the three branches.  This requires open coding
> > the generic_write_end for the buffer_head case.
> 
> Wouldn't it make sense to turn __generic_write_end into a void
> function? Right now, it just oddly return its copied argument.

Yes, we could remove the return value.  That should be a separate patch
after this one, though.
