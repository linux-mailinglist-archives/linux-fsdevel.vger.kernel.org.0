Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54477A6A60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfICNuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICNuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAvvvTd/kG24q/y3ajQFQZLkXwSn6IFFif86NAbeoXA=; b=tTKvxXx15sgkgyowmyu2biBee
        jd97cdn7jtEzlUV8Y2AJ9nKvpEci1B2v5YXfCWKmEOF1HzgR/Tp8B3bJ22mEoFHrhJNqIOA2uqYUe
        kCdaddNGAShMcg8n7+w97paoSFHWSzDlOhLBNg3G7A1t5B0/A9HOXHynLh0ew/QOdi32UT6BNIAQV
        n4yv5lJrxW2kDyJhXCQ8t/qYrq5YzdGiEtxe63iqZYf0DAPCU7N39qKuFkDeALYtXZKmB8c8b2ogE
        0SzGFHlclZbnfFP8QviIpGO4kVvlGnaEyyzmAt6mZKz64bexoz6sbREJcdFRfhUCQhcxvCOVPUr2e
        TIw42cing==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i59CS-0003Rw-6p; Tue, 03 Sep 2019 13:50:24 +0000
Date:   Tue, 3 Sep 2019 06:50:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903135024.GA8274@infradead.org>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903134832.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:48:32PM +0100, Al Viro wrote:
> Not sure what would be the best way to do it...  I don't mind breaking
> the out-of-tree modules, whatever their license is; what I would rather
> avoid is _quiet_ breaking of such.

Any out of tree module running against an upstream kernel will need
a recompile for a new version anyway.  So I would not worry about it
at all.
