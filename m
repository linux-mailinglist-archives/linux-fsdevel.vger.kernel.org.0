Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59217AA8F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfIEQ1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:27:24 -0400
Received: from verein.lst.de ([213.95.11.211]:50124 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfIEQ1Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:27:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 905E368B20; Thu,  5 Sep 2019 18:27:21 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:27:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 11/15] iomap: use a function pointer for dio submits
Message-ID: <20190905162721.GC22450@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-12-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-12-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (dio->dops && dio->dops->submit_io) {
> +		dio->dops->submit_io(bio, file_inode(dio->iocb->ki_filp),
> +				pos);

pos would still fit on the previously line as-is.

> +		dio->submit.cookie = BLK_QC_T_NONE;

But I think you should return the cookie from the submit function for
completeness, even if btrfs would currently always return BLK_QC_T_NONE.
