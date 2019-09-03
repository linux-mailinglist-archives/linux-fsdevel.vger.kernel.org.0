Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358C4A6A45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfICNo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:44:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbfICNo7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33DAFAE9A;
        Tue,  3 Sep 2019 13:44:58 +0000 (UTC)
Date:   Tue, 3 Sep 2019 08:44:55 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com, riteshh@linux.ibm.com
Subject: Re: [PATCH v3 0/15] Btrfs iomap
Message-ID: <20190903134455.i323xy2wbmh4icsp@fiona>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190902164331.GE6263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902164331.GE6263@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:43 02/09, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:21PM -0500, Goldwyn Rodrigues wrote:
> > This is an effort to use iomap for btrfs. This would keep most
> > responsibility of page handling during writes in iomap code, hence
> > code reduction. For CoW support, changes are needed in iomap code
> > to make sure we perform a copy before the write.
> > This is in line with the discussion we had during adding dax support in
> > btrfs.
> 
> This looks pretty good modulo a few comments.
> 
> Can you please convert the XFS code to use your two iomaps for COW
> approach as well to validate it?
> 
> Also the iomap_file_dirty helper would really benefit from using the
> two iomaps, any chance you could look into improving it to use your
> new infrastructure?

Yes. However, I haven't looked at much of XFS code, but from the initial
looks of it, it is simple to read.

-- 
Goldwyn
