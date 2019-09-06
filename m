Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA42AB22B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfIFFzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 01:55:00 -0400
Received: from verein.lst.de ([213.95.11.211]:54436 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfIFFzA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:55:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E178968B20; Fri,  6 Sep 2019 07:54:55 +0200 (CEST)
Date:   Fri, 6 Sep 2019 07:54:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] btrfs: Add a simple buffered iomap write
Message-ID: <20190906055455.GA1830@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-5-rgoldwyn@suse.de> <20190905162344.GA22450@lst.de> <20190905204210.eb3gadoux3ih353q@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905204210.eb3gadoux3ih353q@fiona>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:42:10PM -0500, Goldwyn Rodrigues wrote:
> > Thіs looks really strange.  Can you explain me why you need the
> > manual dirtying and SetPageUptodate, and an additional page refcount
> > here?
> 
> It was a part btrfs code which is carried forward. Yes, we don't need
> the page dirtying and uptodate since iomap does it for us.

But even the get_page seems very odd to me.  It needs a detailed
comment at least.
