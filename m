Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18EA5593
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfIBMJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:09:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfIBMJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hD33JRNWxCAWndZsQ4HRV60ur6T34Y1HHfRkqEYtilA=; b=o/SCA8sBOjyBgF0JmgfvuXgOe
        B11G7SW+TPY9eSMt+xcEjrQt1dwUwqB34Zi8BXCLCaRv29i6xXXsyRz+S7v7QSGucW1gXmTIm4qfj
        S9M50p9iM2lHX1Dl8bpzrGQioT8EBRG9id/ObP+k+erEqlpepf4SxAscTbVq/9q+2GHuUAFoazJ1b
        5NdIzjgzfsCS59YTorYY3CtTRRZjTfLfh5W1JMCGyinJAcx1o8nHQvjRBPstvSxVLIUVcSEvIEQjN
        TCHQZUUe+/Xja+jZc+6OUpxf/1pF+3iG25BXuBju6uXv7INQ2p9RmGoPxhbA3Lh20OTsETG8iOSzx
        JhtV6cFVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l9D-0005fR-JZ; Mon, 02 Sep 2019 12:09:27 +0000
Date:   Mon, 2 Sep 2019 05:09:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 06/21] erofs: kill erofs_{init,exit}_inode_cache
Message-ID: <20190902120927.GF15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-7-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-7-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:15PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph said [1] "having this function seems
> entirely pointless", let's kill those.

Looks much better.
