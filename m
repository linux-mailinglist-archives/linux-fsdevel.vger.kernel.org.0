Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14AE10A1E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKZQVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 11:21:22 -0500
Received: from verein.lst.de ([213.95.11.211]:41504 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfKZQVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:21:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D013468C4E; Tue, 26 Nov 2019 17:21:19 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:21:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] iomap: remove unneeded variable in
 iomap_dio_rw()
Message-ID: <20191126162119.GA7562@lst.de>
References: <20191126122051.6041-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126122051.6041-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:20:51PM +0100, Johannes Thumshirn wrote:
> The 'start' variable indicates the start of a filemap and is set to the
> iocb's position, which we have already cached as 'pos', upon function
> entry.
> 
> 'pos' is used as a cursor indicating the current position and updated
> later in iomap_dio_rw(), but not before the last use of 'start'.
> 
> Remove 'start' as it's synonym for 'pos' before we're entering the loop
> calling iomapp_apply().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
