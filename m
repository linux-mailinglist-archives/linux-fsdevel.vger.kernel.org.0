Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6982742D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIVNWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:22:13 -0400
Received: from verein.lst.de ([213.95.11.211]:44587 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIVNWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:22:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1792867373; Tue, 22 Sep 2020 15:22:11 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:22:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/15] btrfs: split btrfs_direct_IO to read and write
Message-ID: <20200922132210.GD20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144353.31319-6-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:43:43AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The read and write DIO don't have anything in common except for the
> call to iomap_dio_rw. Extract the write call into a new function to get
> rid of conditional statements for direct write.
> 
> Originally proposed by Christoph Hellwig <hch@lst.de>
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
