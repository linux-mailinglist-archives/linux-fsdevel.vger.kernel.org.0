Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DECE251768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgHYLWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgHYLWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:22:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD21DC061574;
        Tue, 25 Aug 2020 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y8tYGIcaslAkdQtxJehqh9yrMuWuEgxVcXkf8U1Ien0=; b=BmmrGemwTGvO1CAjmKE8PH/rPA
        PTXrUHTxPJF7GmOjtRCH7f8grW8lwB6rJjJfy7jMzn0UDbo36rSZ8cyb0fuCUjRYS3aJka9N83aeW
        gEEcWUCLOTMsIp77S3OTV/+MY3rKkD4op6kFS6JDJTGyujW+GcaWPcOkfGjOdw6tjDhJIeSqY315U
        2K8yMaGJfs6ZMYlBa1ENazOmRi53m/jpF/gWFy3zP5z5Ely2V5p/8csuCVbQjiuoBlfQKdqve47z3
        EOQ3CCMTAEWrekdEH2oDgFNSGAnNiUIOQDf5oU5wqS3ob9/zWck1S4yz2ch+kJe79vYaLeRZDwKhv
        QBazWawA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAX1b-0007kx-Bg; Tue, 25 Aug 2020 11:21:59 +0000
Date:   Tue, 25 Aug 2020 12:21:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
Message-ID: <20200825112159.GA29726@infradead.org>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
 <CAGqt0zzA5NRx+vrcwyekW=Z18BL5CGTuZEBvpRO3vK5rHCBs=A@mail.gmail.com>
 <20200825102040.GA15394@infradead.org>
 <CAGqt0zxoJZrYXS+wp7bwfsajfpaotu02oUy53VkQ5CTGcE_2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGqt0zxoJZrYXS+wp7bwfsajfpaotu02oUy53VkQ5CTGcE_2hA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:40:34AM +0100, Yuxuan Shui wrote:
> Hi,
> 
> On Tue, Aug 25, 2020 at 11:20 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Aug 25, 2020 at 10:26:14AM +0100, Yuxuan Shui wrote:
> > > Hi,
> > >
> > > Do we actually want to fix this bug or not? There are a number of
> > > people actually seeing this bug.
> >
> > bmap should not succeed for unwritten extents.
> 
> Why not? Unwritten extents are still allocated extents.

Because you can't read from or write to them.
