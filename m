Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC9A559F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfIBMLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:11:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIBMLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AkQJ3pn0tSPbVGUAjLiWsgB7lW6tQdzMzHZjPVRyQWM=; b=GUQDkbBtLE5yEsS47R96fMGlv
        0rnt/sISAm8SROv0oANzk/8LzPuhPon1GozFvDNWiKBrYIXKEs37mWO/Tw9boq7G5/4RCjBRHKKgf
        LStwsJRfbpDi3Pu6W1fPjVvC3GsT4W+I9myErHj2EZrXWBraokelP2m8iXQh7dLul8Ffkv28mgNbA
        ekU45QFIH7oJw9MyM8zwH7EMjV3KRoFZuh4zYt918oMT06B1xX74Fz+GUWi4Ep9AzddlXzDNYcfhf
        Ano3e4JurYbdTyjq56D7flq/1fgHb7eHIjNR8CiTbCrBLi3EA2LKmiiv6w3v6AqGjkP/i1wI9hDiV
        SOCAXP1nA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lBT-0006wD-QA; Mon, 02 Sep 2019 12:11:47 +0000
Date:   Mon, 2 Sep 2019 05:11:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 10/21] erofs: kill is_inode_layout_compression()
Message-ID: <20190902121147.GI15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-11-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-11-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

this looks much better.
