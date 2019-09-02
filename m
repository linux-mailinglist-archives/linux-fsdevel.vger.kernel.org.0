Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB76CA558D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfIBMHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:07:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfIBMHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sQDD21Z9frf8D/J1ALbMqvAMuCO6kNLcplZgjbOP9Ts=; b=T9I9NsTnMeqHA6FV7Ueo7zG9p
        cWOS+hlOGdcm5R3dZMKq9T+x0AIklGPo4cXYylow7gWVrxBwe1y/ZzBn64iT6dp5pI/Yo0Mlrvw3z
        U4xKLF8StZ0fNKtATrpJ2+R/sUnw+zKlkkqK8do2JcWJu/vXMJPZtOb+YHc6pJJvpA7ZUNlbbZPzl
        tO3VOo1fjFw6ML+0bbPue9uXl7J+y0dITKTzxLSMCpd4FtEL1u3XiATcknTHBFa09gc6KZAZod9fd
        hV0IyF9NJ0uuyVZ3o43pNZQILibVfugVzGDHvY5RE8JieZfq9oLlMGm2F6uOFrExRceyX2MR1L7FS
        Hc6k8JvEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l6o-0005UW-Pr; Mon, 02 Sep 2019 12:06:58 +0000
Date:   Mon, 2 Sep 2019 05:06:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 04/21] erofs: kill __packed for on-disk structures
Message-ID: <20190902120658.GD15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-5-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-5-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:13PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph suggested "Please don't add __packed" [1],
> remove all __packed except struct erofs_dirent here.
> 
> Note that all on-disk fields except struct erofs_dirent
> (12 bytes with a 8-byte nid) in EROFS are naturally aligned.

Thanks.  The users of various architectures where this generates a lot
better code will thank you.
