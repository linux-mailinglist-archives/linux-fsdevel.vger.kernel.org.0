Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7100C35E2CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbhDMPZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhDMPZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:25:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A40C061574;
        Tue, 13 Apr 2021 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+bjDZWt7VIMptiDm8AUPH0gC71TkNTerLWI8vmVplDw=; b=ZtRHIn2jRKd/7WzhfcChKhit2G
        Pqtvb+9SDLPcrrrXT/UUacJkD74wMmQNpJ0AJWlp92PrvEmAAoE4IViXc3BPLGdAKvbbw4YmYN3RN
        0rgoZXA7/xi+y1zEIEqq32+pE7vjjwjJFN2Z0DWk+BJtc/wKHHX9DcxxseCRuKygG2/qdye6XFRHT
        Y5Q34affJetwAj2nMRHejIkSMLQh7TT4+kI6qsdJl9AQiSsYY9uSIsLASr/hcMEwFh38wjYdohQlG
        EwxmRLrOxyGzCA6kDmCC6E+ZlTE8xJWvTixlGocl3iOR4fN9bMN9aMPPHpGC73MTCrUuZbqc2xmUt
        SoiE4Jog==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWKsN-005uLz-Ka; Tue, 13 Apr 2021 15:23:13 +0000
Date:   Tue, 13 Apr 2021 16:22:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add set/end/wait functions for PG_private_2
Message-ID: <20210413152251.GQ2531743@casper.infradead.org>
References: <20210408145057.GN2531743@casper.infradead.org>
 <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
 <1268564.1618326701@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268564.1618326701@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:11:41PM +0100, David Howells wrote:
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Dave Wysochanski <dwysocha@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

