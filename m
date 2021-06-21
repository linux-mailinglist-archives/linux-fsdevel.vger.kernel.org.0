Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6523AEAFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUOTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUOTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:19:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BAC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=10tKwqK5CAce6OafEuT+LmnP32ejxTa/riT/wDSP91M=; b=wJ1VKmlFCty3tG6NsgDir7BFMu
        R/DIk4gLNplbBzcxgafS7l78w0OQuSbCctE3B+SBHqDbDmuSx8isJqd6TNbnzJFl8ReDG7cy/vxYC
        7NfKxRvzPUQSrpsSdqhKqm/xAG//dVBEDeOTwkxwh7Fhoel8KjqZgdL35fanP2T7799H41ahU8eWj
        jhKjhw/FiCOKBjMaptKfbDf+qLfgJ7k7MC1LSVKwP+NV6Z4zcfe93EtPir2XpOQ6whLc6iI+klbrR
        U1qufGD8TsvWazd3gCEsbuF2QKPJF9ysOeXSF40UCGCcwXjlebF5pG9l80BvYdYNMtrbtWOYgn68P
        hc0JX+sA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKjK-00DAa8-Fs; Mon, 21 Jun 2021 14:17:00 +0000
Date:   Mon, 21 Jun 2021 15:16:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YNCfUoaTNyi4xiF+@casper.infradead.org>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
 <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621140956.GA1887@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:09:56PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 03:03:07PM +0100, Matthew Wilcox wrote:
> > i suggested that to viro last night, and he pointed out that ioctl(S_SYNC)
> 
> Where would that S_SYNC ioctl be implemented?

xfs_diflags_to_iflags(
        if (xflags & FS_XFLAG_SYNC)
                flags |= S_SYNC;

(mutatis mutandi per filesystem)
