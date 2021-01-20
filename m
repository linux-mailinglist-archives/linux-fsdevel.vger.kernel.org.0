Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C02FD566
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbhATQTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbhATQTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:19:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A1C061757;
        Wed, 20 Jan 2021 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Khj4yZXBU5CVNv5IIshlEh8x3+XWS0+T3H0OXUMdHvA=; b=hRy6Vb6Xs0CYmt9lEK9nkESjac
        yxRJGc5c3W/c66vZ5VgpK2yDC3ncnMykDIsvMidl1375oR4e78OtWTwxgS6VcfGb1XXnPQrNZdD3w
        2P6m48/TMWyf/lKusMSmOuUjB2CdwsTaCqmqkFbsPi+B/ww9TSC5AweiqJ6MegsKgwJaysWiHGjg1
        JP40uyR61vyeLUH+KBjigoi5o7fRAZp5INyu5S1QRclO5ih5tCBslXpVx3KNdFYrdczchG2wZt2uQ
        m+zOckXDnqPJo8lHyXqqvsV7/trypQCqq285qrW2sko1AA9rve9UEfpr82ZF5kPtuTse+AtinsOo5
        /LsKSzMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2GBv-00Fu6m-J3; Wed, 20 Jan 2021 16:18:45 +0000
Date:   Wed, 20 Jan 2021 16:18:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: Do not pass iter into
 generic_file_buffered_read_get_pages()
Message-ID: <20210120161843.GA3790454@infradead.org>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210120160611.26853-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120160611.26853-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This whole code has a massive refactoring pending that barely didn't
make it in the last merge window.  willy, do you plan to resend it
ASAP?
