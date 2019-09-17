Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE6B47A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404337AbfIQGsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 02:48:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404329AbfIQGsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BeT2ja43daJNhcItoLBOrJ1UxylrPoP4JZsmFl5TXyo=; b=PH6EzH2A/K/viqVCbFNUsMoy8
        itxuz1Q4mSozOKn+LNc6x1zFPI7SI8aQBN2debOKDvUBC601HH68nP4BF2IEJTCD7ZToyk/81SRml
        FUp4olRM5V9p9ETE+FtbKfK4/8MyBqwAYr2bR++u/QIbUu1gKMnIiQhEgaVMQ0ORkwwCSi36jb7eO
        plhK0IduNnR9B4Rv35kKcLx3vBD1LRqNdtg09/yP2Zj0JPlQx5scvl7oadc0lyJYNx5+HTTgij4lL
        sLENDLonN54TTjd0noMtzOxmZE27e9+7klG9Em5uRPvdvNCQOrHGi/n+L948SjerbM81cD11oBhpG
        TE9WpVh1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA7HX-0000U8-P8; Tue, 17 Sep 2019 06:48:11 +0000
Date:   Mon, 16 Sep 2019 23:48:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daegyu Han <hdg9400@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Sharing ext4 on target storage to multiple initiators using
 NVMeoF
Message-ID: <20190917064811.GA25933@infradead.org>
References: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You might want to look into the pnfs block layout instead to do this
safely.  It is supported with XFS out of the box, but adding ext4
support shouldn't be all that hard.
