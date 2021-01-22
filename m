Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B8300B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbhAVSQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 13:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbhAVRV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:21:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39627C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/ZCNnT3pwMxzeZYvTCjmF9FEmUXDQjZsExOmtjFM20=; b=V2lAc3ELSVEfWhGjIQ6EJkilCO
        B8CW93q6Sk1bGyEiMBP/zB1GVOl5ScjV13w0iTR++72wzupPPFVT2udq+eMD7qTi3dns+yEkbjVsW
        wtSnz2QWHF0ry1jxyuTGWnpfP/p1rUlzPfYR++Z3ZfJG/o2eu6He+a/GZ5T4iSdRcGDOFBxxn8xVv
        mMi4ThhVHYM6RrRMfvu3O9jukfTIwR8GX/AwtBPaZhzz82/DBukx52tE5JkQSbfv8cDJDtBkxXCjp
        w5gsE7NILnomftWPaEaKt4VCevhVJ1vP53tvQ6WasehY5WZeMpAnFfYM3zfFVN4owzvm5zBq5FdeP
        BRJnYz2A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3070-0010W0-G6; Fri, 22 Jan 2021 17:20:44 +0000
Date:   Fri, 22 Jan 2021 17:20:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 7/8] ubifs: export get_znode
Message-ID: <20210122172042.GC237653@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-8-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122151536.7982-8-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 04:15:35PM +0100, Sascha Hauer wrote:
> get_znode will be needed by upcoming UBIFS quota support. Rename it to
> ubifs_get_znode and export it.

I wonder why'd you want to export ubifs functionality, but it only
gains global instead of static scope, so this looks ok to me.
