Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8295949F3F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 08:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbiA1HFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 02:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiA1HFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:05:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5BC061714;
        Thu, 27 Jan 2022 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jf2E0pUG3GOZxihUHfPlYjorrQluw3AZrzDbcNera34=; b=bSrIeDjXe0kg3MTDdcQumiTEIp
        IksleX6eyErXVnT1iLyg1ZCBmqioCp3PbXMjc4sPeR6DRewgGFgE2ZVEcAtuYigTyTrHP7MGldcHY
        DK1hD72+iajXZTdIOh8pl9YauMSILSaOKfTXVGdHUpl7eLvRA/R3fTs3EtACH/zV3wM6ElH3axvdr
        jntQAzojiTkRqldKzjaW7gL0vWEVXNzSaAHifzk/8BLge541m44TJeD/r/QHhvwsv5sfOnh1a5gKd
        IdvOl27Th9lgeKoP5kDcX7tZhRBeVpUIcOgw9ncKRTrfCBQFbTM9b8lK+y5YiDzJoaaeXfF95lTBg
        iW3L+a/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDLJg-000iLD-EQ; Fri, 28 Jan 2022 07:05:04 +0000
Date:   Thu, 27 Jan 2022 23:05:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cachefiles: Split and rename S_KERNEL_FILE and
 extend effects
Message-ID: <YfOVoIQqaXkzDju5@infradead.org>
References: <1079106.1642772886@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079106.1642772886@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:48:06PM +0000, David Howells wrote:
> Split S_KERNEL_FILE into two separate flags to do two separate jobs and give
> them new names[1][2]:

I strong disagreewith this.  The flag is a horrible hack that does not
have any business to exist to start with.  Splitting it an potentially
proliferating the use is not a good.

The proper fix would be to fix the cachefiles design to not rely on it
at all.
