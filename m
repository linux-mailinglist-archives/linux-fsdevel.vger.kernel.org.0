Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0DD1B7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfJIWOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 18:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJIWOt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:14:49 -0400
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C05620B7C;
        Wed,  9 Oct 2019 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570659288;
        bh=m4PELeG4FH7XyCDThiykdmZ+j/dNLTN4TQDfS1hIAl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3QfiYZ0ghzsbSW26PCMYsxgFwDTpTMMR8mHdaipDRHUMsRKyr5otUOcvtxCiJJxo
         DGMUQtyJYW3ECl5SAYi3XEMakKOO/XAqhbQeXMptffN3qjzfj4PpxvjO8VmdeH2i10
         zD9mnhGX5tZcipf19dmupQvx5uHlZ2tPvP5xyBsc=
Date:   Thu, 10 Oct 2019 07:14:45 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/12] nvme-core: export existing ctrl and ns
 interfaces
Message-ID: <20191009221445.GC3009@washi1.fujisawa.hgst.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-3-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:19PM -0600, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> We export existing nvme ctrl and ns management APIs so that target
> passthru code can manage the nvme ctrl.
> 
> This is a preparation patch for implementing NVMe Over Fabric target
> passthru feature.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>
