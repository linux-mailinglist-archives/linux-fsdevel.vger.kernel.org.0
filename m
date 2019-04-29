Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03CEB08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfD2ToT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 15:44:19 -0400
Received: from verein.lst.de ([213.95.11.211]:40835 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfD2ToT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:44:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 60A8068AFE; Mon, 29 Apr 2019 21:44:03 +0200 (CEST)
Date:   Mon, 29 Apr 2019 21:44:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/4] iomap: Add a page_prepare callback
Message-ID: <20190429194403.GC6138@lst.de>
References: <20190429163239.4874-1-agruenba@redhat.com> <20190429163239.4874-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429163239.4874-3-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
> +				   unsigned len, struct iomap *iomap)
> +{
> +	return 0;
> +}

Now that we check for each callback there is no need to add a dummy
one in this patch.

But given that that won't change the end result:

Reviewed-by: Christoph Hellwig <hch@lst.de>
