Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D430F107367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfKVNik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:38:40 -0500
Received: from verein.lst.de ([213.95.11.211]:52055 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfKVNik (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:38:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0382B68C4E; Fri, 22 Nov 2019 14:38:38 +0100 (CET)
Date:   Fri, 22 Nov 2019 14:38:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        sandeen@sandeen.net
Subject: Re: [PATCH 5/5] fibmap: Reject negative block numbers
Message-ID: <20191122133837.GD25822@lst.de>
References: <20191122085320.124560-1-cmaiolino@redhat.com> <20191122085320.124560-6-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122085320.124560-6-cmaiolino@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:53:20AM +0100, Carlos Maiolino wrote:
> FIBMAP receives an integer from userspace which is then implicitly converted
> into sector_t to be passed to bmap(). No check is made to ensure userspace
> didn't send a negative block number, which can end up in an underflow, and
> returning to userspace a corrupted block address.
> 
> As a side-effect, the underflow caused by a negative block here, will
> trigger the WARN() in iomap_bmap_actor(), which is how this issue was
> first discovered.
> 
> This is essentially a V2 of a patch I sent a while ago, reworded and
> refactored to fit into this patchset.

That last sentence should probably be removed.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
