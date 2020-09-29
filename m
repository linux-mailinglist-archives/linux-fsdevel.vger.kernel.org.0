Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B9E27CA47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgI2MRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 08:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732356AbgI2MRv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:17:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3971AC84;
        Tue, 29 Sep 2020 12:17:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45172DA701; Tue, 29 Sep 2020 14:16:30 +0200 (CEST)
Date:   Tue, 29 Sep 2020 14:16:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 01/14] fs: remove dio_end_io()
Message-ID: <20200929121629.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924163922.2547-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:39:08AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we removed the last user of dio_end_io(), remove the helper
> function dio_end_io().
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

I'll add this and patch 2 to misc-next as they're cleanups after the
dio-iomap switch, so they're in the same batch.
