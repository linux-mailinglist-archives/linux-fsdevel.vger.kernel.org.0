Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7EF433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD3K3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 06:29:43 -0400
Received: from verein.lst.de ([213.95.11.211]:45229 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfD3K3n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:29:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C4D9C67358; Tue, 30 Apr 2019 12:29:25 +0200 (CEST)
Date:   Tue, 30 Apr 2019 12:29:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/5] fs: Turn __generic_write_end into a void
 function
Message-ID: <20190430102925.GA19506@lst.de>
References: <20190429220934.10415-1-agruenba@redhat.com> <20190429220934.10415-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429220934.10415-3-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:31AM +0200, Andreas Gruenbacher wrote:
> The VFS-internal __generic_write_end helper always returns the value of
> its @copied argument.  This can be confusing, and it isn't very useful
> anyway, so turn __generic_write_end into a function returning void
> instead.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
