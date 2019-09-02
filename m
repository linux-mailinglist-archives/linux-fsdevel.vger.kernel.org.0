Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6558CA55A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfIBMMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:12:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfIBMMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J0pxvEooYSHFFvDUmWTNFz+UlFOUvqkrq1JQQgTfRZk=; b=VEC6pF121qFiWicGITTyJ67R/
        JHlTes3Yc76ZTVPm/SNG2x+oHLatym8c/VKWKkIgKfaii20PQy1iLenT1cDH27sgK6+Z2hfgGcJTb
        pZOry7+kGLDbJDKp0mcAIGCto6JO0dcM6jcv1juCErY2XIR8NVF0TwPXIMctgIWcI/gUr5CDcHmhX
        SwFDpCKjabQeTtC/CiDCjt0opyPMa8pTfB1vvlXdROgNPJbvCovs/DJqrtBav2SJ7lWvDoVDlCJY1
        8Pf8LavpFBNIG7iPx3AE97X4coexKtDkmGLoyHJ0xrJVVweajn3sjO4nml6/bWJaP2BHMZ0FxGemR
        F3AvZcCUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lCE-00070e-Cb; Mon, 02 Sep 2019 12:12:34 +0000
Date:   Mon, 2 Sep 2019 05:12:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 11/21] erofs: use dsb instead of layout for ondisk
 super_block
Message-ID: <20190902121234.GJ15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-12-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-12-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	dsb = (struct erofs_super_block *)((u8 *)bh->b_data +
> +					   EROFS_SUPER_OFFSET);

Not new in this patch, but that u8 cast shouldn't be needed.
