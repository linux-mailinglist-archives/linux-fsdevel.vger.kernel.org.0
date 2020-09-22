Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BE2742DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVNWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:22:36 -0400
Received: from verein.lst.de ([213.95.11.211]:44589 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIVNWg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:22:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52A3B67373; Tue, 22 Sep 2020 15:22:34 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:22:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 06/15] btrfs: Move pos increment and pagecache
 extension to btrfs_buffered_write()
Message-ID: <20200922132234.GE20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-7-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144353.31319-7-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:43:44AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> While we do this, correct the call to pagecache_isize_extended():
>  - pagecache_isisze_extended needs to be called to the starting of the
>    write as opposed to i_size
>  - We don't need to check range before the call, this is done in the
>    function
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
