Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCFCDBD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJGGRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 02:17:11 -0400
Received: from verein.lst.de ([213.95.11.211]:34920 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfJGGRK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:17:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 487C668AFE; Mon,  7 Oct 2019 08:17:06 +0200 (CEST)
Date:   Mon, 7 Oct 2019 08:17:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191007061705.GA20377@lst.de>
References: <20191006154608.24738-1-hch@lst.de> <20191006154608.24738-2-hch@lst.de> <20191006224324.GR13108@magnolia> <20191007054838.GA15655@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007054838.GA15655@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:48:38AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 06, 2019 at 03:43:24PM -0700, Darrick J. Wong wrote:
> > > +iomap-y				+= trace.o \
> > 
> > I think this patch is missing fs/iomap/trace.c ?
> 
> It does.  The file is in my tree, but I never did a git-add for it..

A branch with the file is here:

   git://git.infradead.org/users/hch/xfs.git iomap-writepage.7

Gitweb:

    http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-writepage.7

I'll wait a bit until I resend to see if people find other issues.
