Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE812CAC4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgLAT0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLAT0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:26:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F78C0613CF;
        Tue,  1 Dec 2020 11:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ctr5EXXYW4g8lMkVbVgbcb+rbE/UuR8LXlO9Lx8gDs4=; b=Jh7/ko0PEnqEzZBmawFj4/rhOp
        XSdYhRKXPwvJfh1JZxISV0rFsgnqsclg9Sl2BdeTZrGbBncTXSGj8YAdGNw9zw84WoJajSejWUghz
        1Vahso77Of3gfu1IEJr9zHumHC3SeFBjmsDFRRvsRFZIO4ZvKbwv1YaoPUmgDv3YKZoRKsmzMHbLm
        o8Lo7DtbOpJBuE2PN7gMLHjWWMUmQHL+VuNZ1itm7kfXtRb28UDLx+32MW5f6bCMfkRCMvGy3X/bL
        PPz6FakeDtzwQjWuEmI1GyGcFU4lXAIR8+1/BcIDDNPPuIdgw/m8+5YPY6c9Ts4COYsduKUfx3FPj
        BUfJmb5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkBHT-0006Cu-Qm; Tue, 01 Dec 2020 19:25:43 +0000
Date:   Tue, 1 Dec 2020 19:25:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Toke H??iland-J??rgensen <toke@redhat.com>
Subject: Re: [PATCH] fs: 9p: add generic splice_write file operation
Message-ID: <20201201192543.GA23073@infradead.org>
References: <20201201151658.GA13180@nautica>
 <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 04:44:56PM +0100, Dominique Martinet wrote:
> The default splice operations got removed recently, add it back to 9p
> with iter_file_splice_write like many other filesystems do.
> 
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Cc: Toke H??iland-J??rgensen <toke@redhat.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
