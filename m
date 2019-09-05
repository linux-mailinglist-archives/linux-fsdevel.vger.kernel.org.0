Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6EEAA8EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfIEQZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:25:57 -0400
Received: from verein.lst.de ([213.95.11.211]:50122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfIEQZ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:25:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 531F368B20; Thu,  5 Sep 2019 18:25:53 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:25:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 08/15] btrfs: basic direct read operation
Message-ID: <20190905162553.GB22450@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-9-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-9-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret = 0;
> +	if (iocb->ki_flags & IOCB_DIRECT)

Missing empty line after the declaration.

> +ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)

The iomap in the name doesn't seem to add much.  In fact I'm not even
sure the function adds all that much, I would have just open coded it.
