Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C090454CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfFYKtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:49:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFYKtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=sw5AQ1CngqSn+ZUl/GIUBor1j
        qH/z7Cl5HGojMC+ChAg666tiva8y6WcI1ri3Xch2LxvnfKl6O7g1IjDxR53KtzYr/DoUVDRYQhzIu
        Y0Nbhn2n4dZEAwmBKUUWfckLqQXhSsaEMofTOxkwPuOsLn5Opracjl2XU6Xl+DhzYyFytH5YPRa8d
        /LaZNO7OiR/AxDHOxeaj4I9/ZZVfgjqb/1b4eHX12p/qU1INSJ9aT4/478BmxcEvoXss+Qjb+l43Q
        fRFqTWr8P8tqazui7lUvB5pR+HTTrLvgROJN7IevKSLO9Xcg49mpgsJ7okGUL0+5erMP16HPuztmq
        1xlR78tzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfj0h-0005Js-9G; Tue, 25 Jun 2019 10:49:11 +0000
Date:   Tue, 25 Jun 2019 03:49:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] quota: honor quote type in Q_XGETQSTAT[V] calls
Message-ID: <20190625104911.GI30156@infradead.org>
References: <0b96d49c-3c0b-eb71-dd87-750a6a48f1ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b96d49c-3c0b-eb71-dd87-750a6a48f1ef@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
