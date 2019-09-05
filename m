Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF2AA906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfIEQcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:32:12 -0400
Received: from verein.lst.de ([213.95.11.211]:50181 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfIEQcM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:32:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AD4868B20; Thu,  5 Sep 2019 18:32:09 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:32:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 13/15] btrfs: Remove btrfs_dio_data and
 __btrfs_direct_write
Message-ID: <20190905163208.GE22450@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-14-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-14-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:06:48AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_dio_data is unnecessary since we are now storing all
> informaiton in btrfs_iomap.
> 
> Advantage: We don't abuse current->journal_info anymore :)

I'd suggest just folding that into the patch removing their last
users.
