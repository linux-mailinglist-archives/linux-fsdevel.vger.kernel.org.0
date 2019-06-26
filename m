Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32349569D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfFZMz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 08:55:56 -0400
Received: from verein.lst.de ([213.95.11.211]:42928 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfFZMz4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:55:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8A33A68B05; Wed, 26 Jun 2019 14:55:25 +0200 (CEST)
Date:   Wed, 26 Jun 2019 14:55:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: fold __generic_write_end back into
 generic_write_end
Message-ID: <20190626125525.GC4744@lst.de>
References: <20190626120333.13310-1-agruenba@redhat.com> <20190626120333.13310-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626120333.13310-2-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 02:03:33PM +0200, Andreas Gruenbacher wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This effectively reverts a6d639da63ae ("fs: factor out a
> __generic_write_end helper") as we now open code what is left of that
> helper in iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

And this one needs an additional signoff from you as it went through
your hands..
