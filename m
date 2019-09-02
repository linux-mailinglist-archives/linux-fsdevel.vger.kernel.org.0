Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3263A5590
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfIBMHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:07:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfIBMHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Oks1cgmbtAsxCs1TYU+vI3codTgdNBAbLyudCDF34M=; b=e1NgQmXyfdoylBK1YZuNte/Tr
        oVXW7b8+0Oqvh+P9q3MHylNL+tmQwG+n+Mz68cp+mCtjlWqLtmYHpb5wDymlyERG7NVNweJcCG1Vv
        k0ZLWt3YMLpuV8VUUWJlS43ZrTVlNF4u4EKs12bMHUtdTtRfJHgDgb5CVTWBG4wsCDLeXjU1NBW/T
        GaLfKudvIJkAXUraumOM046AWnwfbkdYqm1pPCXxgXKabvCEXtTgtJvCMidGctRG/v+VpY+B2dzmP
        NVcXfxVn8ykRrGhm4zlVpi8B3inqPDjb9c0EBCVdnLszKLswxoFi0DRamtBasFOAzNIjPVcvEKP9+
        /lRggLsLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l7Y-0005WV-E0; Mon, 02 Sep 2019 12:07:44 +0000
Date:   Mon, 2 Sep 2019 05:07:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 05/21] erofs: update erofs_inode_is_data_compressed helper
Message-ID: <20190902120744.GE15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-6-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-6-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:14PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph said, "This looks like a really obsfucated
> way to write:
> 	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
> 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY; "
> 
> Although I had my own consideration, it's the right way for now.

Well, if you do check one field for two values it really helps to do
the same style of check for both.  All your choice how you do the check,
but don't mix multiple styles..

So this looks good.
