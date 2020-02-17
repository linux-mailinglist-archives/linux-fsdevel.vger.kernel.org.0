Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A792516134E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgBQN1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:27:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgBQN1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tfAOwYcGbGkV/cjxNr8rykRLpMwyGl5pU2nNL+7tbzs=; b=sg9X51UqV5bnAwmYKk2fMUtoRJ
        j2XJhN9A1ZLfjK85y3oYxsxO+LRnJPnk/YnCrZ/ymWxP8a3WpmI5dvQY3fOa2Qiw+G/yVl4lo6tXn
        24vkmsAGHEXAdpBNeUMmEirOXzpGrSBdWFxBREyXJtKri2ORJm4g48vFwrXxSpemHKD+/MpBIEUxV
        2wCtAunQeC75orQqk54ZjVGIFxqHmfgx438L5/2iLEZjkz6LuzTWWi30KdKM1ny5NU59M0QkHY4BD
        C0euscwnZhpz3Tp3IT/s/uAXJFzjb6o1VPXjQNjVb73B3zC/XeBfS/yhTOv3KukikfmzvLzLjK69e
        Ld8G7Mcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gR3-0005AS-AB; Mon, 17 Feb 2020 13:27:41 +0000
Date:   Mon, 17 Feb 2020 05:27:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 7/7] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <20200217132741.GF14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-8-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-8-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:26:52PM -0500, Vivek Goyal wrote:
> Add a helper dax_ioamp_zero() to zero a range. This patch basically
> merges __dax_zero_page_range() and iomap_dax_zero().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c               | 12 ++++++------
>  fs/iomap/buffered-io.c |  9 +--------
>  include/linux/dax.h    | 17 +++--------------
>  3 files changed, 10 insertions(+), 28 deletions(-)

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
