Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34799A5609
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfIBM2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:28:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfIBM2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Be/ms/OJKGVxo7e8F3rHJQGcp7FrmkdDRfckdC6QUAo=; b=Q8ndzAoMeSDVU5DmiNdG+sA6d
        8DrrS0HQw2FVvZz160rayjyJFMKkVHbGAAj6ejbxtqPzo/sQMilXaRvWNRsFJnZ/bL0Dw+yybMaR/
        iXqIZVWeRJUvMKRC2rJ/iDgYszCSittOhuH+I5Z9z2zVltWVjRS3v/LIUKxqMl7OoP2HPip+b6Cc9
        njpYNNKPAVslVgdmiSSV4N0kZDCGZycMaVtCmFhd7K6A1IQVbmug89exefRhktZbM7XRa+FtRdgyx
        imm6YWk2GDwCBaubMGvtUKGBILIZR2F1RU0N+1KPPQV1lTG7RNfpaMt1P3w/qyNx5lmgFvVjJd/dD
        tD7oMLZfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lRk-0004CP-AT; Mon, 02 Sep 2019 12:28:36 +0000
Date:   Mon, 2 Sep 2019 05:28:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 19/21] erofs: kill all erofs specific fault injection
Message-ID: <20190902122836.GQ15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-20-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-20-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:28PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph suggested [1], "Please just use plain kmalloc
> everywhere and let the normal kernel error injection code
> take care of injeting any errors."

Thanks.
