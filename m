Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF31EA5583
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfIBMFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:05:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbfIBMFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dXWn+A1sRVmLUbQptxdzKnlErfLZaZwQz+KmzxIMlqo=; b=ZVO1F7QzZBrYhEdlDfaPu/614
        Up2AY3++ZwAyAntG+H9TvQbOTgcy3JcptjyZ2ryyl/hUt6AKn0NT5Xz5mYzZ70XpTW/iHhvcUTmHc
        t3bn/TGFNFvWvxKr6LbT9otMNtpkpcXwAC1+QPR1vEPC3QX1xvRwI3KcsXaTOkEUpN8FmWtpqNkWa
        DwaGeoWZawwEevWM7GVpEoZqelTtbZUtxGjYLsIyMAiCyqHjwq3bHr0ibA1Lei3B92HwYhOyewSGE
        h8cs9XIl0Yaqc1eMMS+Uv6bgSeK+YGSDsv4SdeB6bP9Poy7IbylUI4oMFxKR/Gl+MubAhQhtchtEx
        vZI/eB9QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l50-0005Ed-VM; Mon, 02 Sep 2019 12:05:06 +0000
Date:   Mon, 2 Sep 2019 05:05:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 01/21] erofs: remove all the byte offset comments
Message-ID: <20190902120506.GA15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-2-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-2-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:10PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph suggested [1], "Please remove all the byte offset comments.
> that is something that can easily be checked with gdb or pahole."

Looks good.  If you want to keep them after the field names as someone
pointed out feel free to - I don't think it actually is very useful
but we've also heard other opinions.
