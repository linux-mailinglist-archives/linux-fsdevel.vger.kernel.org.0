Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1468D7E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfJOR7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:59:43 -0400
Received: from verein.lst.de ([213.95.11.211]:56368 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfJOR7n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:59:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5493068B05; Tue, 15 Oct 2019 19:59:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 19:59:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] xfs: refactor the ioend merging code
Message-ID: <20191015175940.GA11481@lst.de>
References: <20191015154345.13052-1-hch@lst.de> <20191015154345.13052-5-hch@lst.de> <20191015175619.GN13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015175619.GN13108@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:56:19AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 15, 2019 at 05:43:37PM +0200, Christoph Hellwig wrote:
> > Introduce two nicely abstracted helper, which can be moved to the
> > iomap code later.  Also use list_pop_entry and list_first_entry_or_null
> > to simplify the code a bit.
> 
> No we don't use these....     ^^^^^^^^^^^^^^

list_first_entry_or_null is used, only list_pop_entry isn't, so that
needs to be removed.
