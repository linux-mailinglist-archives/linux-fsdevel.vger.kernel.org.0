Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC44A5615
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfIBMcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:32:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfIBMcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w3Hc7m8r+TGDwNj+XBBaPkbdW/cqwomlTxHhtLv0JUw=; b=FZlCeV2oxgaxKh7ymjNQKch0h
        Eb87QzZIOiOfSgetqoO8drDmLSbUFXr4uzDxTOeqCTYb06NtpgaouVxHf0SyVgB9OxlHPJVrk8CYk
        TunmTaorkYBk01dhhnmvtA9MlYSffzjxWDDHpBAi/2Jki0K2atPCXH0rGq4c0m9ISFyMCJEEh3Wmf
        VwAKzv8GaWalA4MlW8PPwKam12gSDBVRF1/iU0nu3pRxIuzJ6RBYZd11hR2cdrq0AIzOiUTR647vy
        HBtM20X4W1+mOn7qQGubCgTnvAy80ImYSkak1H1TMHN+4qF98uZAA7rxxlCp8frvh/9O9/HZHYvYg
        J0OMoHHeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lUz-0005g6-5a; Mon, 02 Sep 2019 12:31:57 +0000
Date:   Mon, 2 Sep 2019 05:31:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 21/21] erofs: save one level of indentation
Message-ID: <20190902123157.GS15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-22-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-22-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:30PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph said [1], ".. and save one
> level of indentation."

Thanks.  Just a little cleanup, but cumulated things like this really
help readability.
