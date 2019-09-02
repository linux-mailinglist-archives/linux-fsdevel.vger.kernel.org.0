Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA16A56B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfIBMym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:54:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfIBMym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cfou+aUkoFJmVggCmG5eZbSGsSmpOejeEZjjhO0gxJ4=; b=nfwL6FD/J5EAsuQwSDBysBDcS
        l4z7uQMeWEypiiaMxnhvBiPDbiKdqtKF8yZaWdcy/67tm+ZPiBujr4hww6UUL2LKJGKZuCEx8Mfiw
        KR/KFNkASy3e7RmEVI9D91/iZLmvxSrzqaeRhrIqQroiOFxTYd1yTOyPhfAzRdVpS/7LrPAgab/dv
        Xy+1eLJYjahB6DI6QNqSKKeh+EdsIkKAlxXZOwq85lzYWfTn0SQPjKsZOnoIsaoKUcWPVvnkqMGvA
        xXZDRWaYbqIPpRL1pLS8KqxGbZydOOwozGUN8EHI3LhJvnJymhNZHJXpcwW3sowqW2OJQG5msHlRH
        kibL2g0KA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lqw-0004g0-Qu; Mon, 02 Sep 2019 12:54:38 +0000
Date:   Mon, 2 Sep 2019 05:54:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 16/21] erofs: kill magic underscores
Message-ID: <20190902125438.GA17750@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-17-hsiangkao@aol.com>
 <20190902122627.GN15931@infradead.org>
 <20190902123937.GA17916@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902123937.GA17916@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 08:39:37PM +0800, Gao Xiang wrote:
> > 
> > > +	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
> > 
> > I still need to wade through the old thread - but didn't you say this
> > wasn't really a new vs old version but a compat vs full inode?  Maybe
> > the names aren't that suitable either?
> 
> Could you kindly give some suggestions for better naming about it?
> there are all supported by EROFS... (Actually we only mainly use v1...)

Maybe EROFS_INODE_LAYOUT_COMPACT and EROFS_INODE_LAYOUT_EXTENDED?
