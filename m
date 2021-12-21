Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8F47BBCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 09:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhLUI1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 03:27:48 -0500
Received: from verein.lst.de ([213.95.11.211]:45811 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232440AbhLUI1r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:27:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 405B168AFE; Tue, 21 Dec 2021 09:27:44 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:27:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: Fix error handling in iomap_zero_iter()
Message-ID: <20211221082744.GA5889@lst.de>
References: <20211221044450.517558-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221044450.517558-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 04:44:50AM +0000, Matthew Wilcox (Oracle) wrote:
> iomap_write_end() does not return a negative errno to indicate an
> error, but the number of bytes successfully copied.  It cannot return
> an error today, so include a debugging assertion like the one in
> iomap_unshare_iter().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
