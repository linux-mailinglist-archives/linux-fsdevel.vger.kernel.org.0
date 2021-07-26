Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7D3D5518
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhGZHc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:26 -0400
Received: from verein.lst.de ([213.95.11.211]:44209 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhGZHcZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8C8067373; Mon, 26 Jul 2021 10:12:17 +0200 (CEST)
Date:   Mon, 26 Jul 2021 10:12:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 03/27] iomap: mark the iomap argument to iomap_sector
 const
Message-ID: <20210726081217.GA14853@lst.de>
References: <20210719103520.495450-1-hch@lst.de> <20210719103520.495450-4-hch@lst.de> <20210719160820.GE22402@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719160820.GE22402@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 09:08:20AM -0700, Darrick J. Wong wrote:
> IMHO, constifiying functions is a good way to signal to /programmers/
> that they're not intended to touch the arguments, so

Yes, that is the point here.  Basically the iomap and iter should
be pretty much const, and we almost get there except for the odd
size changed flag for gfs2.
