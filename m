Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B53A5588
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfIBMFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:05:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbfIBMFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rQBNmZ3r7tPYZ93qcdgzs9aT3ulfgxUExQ/2KE/PgFY=; b=TTaKIim1bhF1mLqocBrdBlH85
        8sJEL9o/uIe3NswXx32FNw7orE6U35jhrCh6sKd2DBNdat+AXAON5TRrFb+KuxHVqrpOG/xPmLgZs
        tYTVBj16cMNmFbCXUpVfkgAXmoJVqikEKnhkVgXzufH7+RRgECy7TvQ7BtSQiCllCIbBDpFgWO6Ga
        UpLklxlrYvFyjCFfvqjYUDl0MNEGMbf2VASynnkfV2PLD3mrLYFZY1Pi4UsguCMW69cUtuJ0CbY5L
        mrrAOEjySYvNc6lJitTAD3pije93p6JhN8g570szEXj+Ehs+eLTSKX+G6uWyoq6iRWyp51Y3XfJWa
        NprfvUrGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l5g-0005RV-BO; Mon, 02 Sep 2019 12:05:48 +0000
Date:   Mon, 2 Sep 2019 05:05:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 02/21] erofs: on-disk format should have explicitly
 assigned numbers
Message-ID: <20190902120548.GB15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-3-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-3-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:11PM +0800, Gao Xiang wrote:
>  enum {
> -	EROFS_INODE_FLAT_PLAIN,
> -	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
> -	EROFS_INODE_FLAT_INLINE,
> -	EROFS_INODE_FLAT_COMPRESSION,
> +	EROFS_INODE_FLAT_PLAIN			= 0,
> +	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
> +	EROFS_INODE_FLAT_INLINE			= 2,
> +	EROFS_INODE_FLAT_COMPRESSION		= 3,
>  	EROFS_INODE_LAYOUT_MAX
>  };
>  
> @@ -184,7 +184,7 @@ struct erofs_xattr_entry {
>  
>  /* available compression algorithm types */
>  enum {
> -	Z_EROFS_COMPRESSION_LZ4,
> +	Z_EROFS_COMPRESSION_LZ4	= 0,
>  	Z_EROFS_COMPRESSION_MAX
>  };

This all looks ok - it somtimes also helps to have a comment near
the numbers to indicate where they are stored, must that isn't a must.
