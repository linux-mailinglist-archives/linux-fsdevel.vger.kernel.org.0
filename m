Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5775EA55AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfIBMO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:14:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbfIBMO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JymFyC0tdTbm9X3JoqRE7PQcwtsQqKxEPc2TG5GY2Ds=; b=QH8c02QA6rBkmXFGSFyB7Aka8
        mWp/LOzOZ40CnGqUGc8P7DkmKgZffziJuTU46D9lyX8ee1tKtNM9DUu7IZdvNLEUH0yTR033Fts+l
        DHANKdXrV3de5zRX3c2sZa0pxru3Ia/n4ZzsMbMTr9IluREz0XXOdirsBdrOiXxfcfmvelSPQGbLq
        VpUH8umBDit1pcPQfSVD5b4EB+JBIbCLNQk+tLooWfeSffU3XcgGZDq53fy32Bl9x4FVcwbswVveb
        rynOa7qJQxFA3bQVvSZ5l+28cSqLjcbHrKY0OPRD7JgHpOLdju9LvvMKFbbf6gUz1iSfGKoy4PuS6
        B1L2UgHgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lE0-00075f-Cq; Mon, 02 Sep 2019 12:14:24 +0000
Date:   Mon, 2 Sep 2019 05:14:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 12/21] erofs: kill verbose debug info in erofs_fill_super
Message-ID: <20190902121424.GK15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-13-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-13-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:21PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph said [1], "That is some very verbose
> debug info.  We usually don't add that and let
> people trace the function instead. "

Note that this applies to most of the infoln users as far as
I can tell.  And if you want to keep some of those I think you
should converted them to use pr_info directly, and also print
sb->s_id as a prefix before the actual message so that the user
knows which file system is affected.
