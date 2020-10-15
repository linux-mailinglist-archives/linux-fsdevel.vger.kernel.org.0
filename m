Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C728EF22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbgJOJIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJOJIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:08:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55856C061755;
        Thu, 15 Oct 2020 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YDzw0FIaN7/YFvR16XfiWofJuH
        nBmfIWvm4JMJjj7K9G5HeNS1Z/YDuhO0g0YvmnniYO+A5pRgJH0EQ00QRifWQ7/wFuOK66kQ+CHbl
        VmHNK4vhJ2UeayscpW4LECX05RTGJY5IkFz+pz9nwSFIXfkyRPCrxcfeeKjpEbU9zcegEqPcECjRP
        HqUXdlzRteT43Md67LRNqe+y+f4ibfLBMdmYo4nA2bw2pBrFMiIY+xhWHorLEVmlUHpngejo++Dr8
        NFbDLjJ1gIQ7zhvChfWzoMnUsQjy8srPiPNP/XClAfLq47c8PtZaWykDYnT5T0gMHL7PfYb7kzf6Y
        qzk2bIBA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzFd-0003sL-RM; Thu, 15 Oct 2020 09:08:45 +0000
Date:   Thu, 15 Oct 2020 10:08:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 15/16] iomap: Inline iomap_iop_set_range_uptodate into
 its one caller
Message-ID: <20201015090845.GD12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
