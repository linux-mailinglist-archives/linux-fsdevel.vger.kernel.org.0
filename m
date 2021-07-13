Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5103C69DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 07:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhGMFra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 01:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGMFra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:47:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC7C0613DD;
        Mon, 12 Jul 2021 22:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSOLV2yWdnXkqdxSe2pQiY3HJLae2PQc3A8NcVMaXyY=; b=eZSL/FG0R/mDuFBcwkcuVTD9uS
        KBFriZ9twqFxIks5L9Qwy6K9vJVLFsJTlxIZfVS8xQOcw0HgcjObmW6xwKV7NuzZ3OrOUWZMow+0o
        +6dguhppZ2oRT6GsukPupoL4M1SUGKqNNAV/qIsvdcjsNDuOfmpylP/+dolSKaa+bsugWw78u6x2x
        g9WClhQJE4wwbAsnYbvDuEcOjKLXvBmenvm2tDcJ2Oyz0jf5o4IKFMyds9hrXMPTscy+2NSMr58bA
        xkNWT9+yu/dIZngZY0qmL/RjyuyrY38EHPOM1s+iUwGDQpS2iCaBD0IWOuwBbiQ2KXcCRQLyMCErf
        nhpvvNuA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3BDC-000mGH-L7; Tue, 13 Jul 2021 05:44:09 +0000
Date:   Tue, 13 Jul 2021 06:44:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Add MAINTAINERS record
Message-ID: <YO0oJvuIXlcmSd7F@infradead.org>
References: <162609279295.3129635.5721010331369998019.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162609279295.3129635.5721010331369998019.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 01:26:32PM +0100, David Howells wrote:
> Add a MAINTAINERS record for the new netfs helper library.

Btw, any reason why this code is called netfs?  It is a library
that seems to mostly be glue code for fscache as far as I can tell and
has nothing to do with networking at all.
