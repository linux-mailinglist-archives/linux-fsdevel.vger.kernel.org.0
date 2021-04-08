Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786E7358793
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDHOzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHOzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:55:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA528C061760;
        Thu,  8 Apr 2021 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ngPzXydGHBjskx5cUB/06uGvBv1ng+f09FOLsWljv8=; b=JmqiGWaoPyP0M/wyjvEambr2hQ
        Pqfhp0rW3/YWQSEW67k7BqrjIQoQAHIbjqS/Ov+4EVqS9oYAxYFObB143hXed3ldwgU9EPF4Xw5Xs
        mOMGA4NF7eOLQt/RM4MdXGRqBa7Iy7T8wJSU+ghg3wes7SBZ/XEtD8y6cInb1UTB/pwAY0K6mlReR
        N96yrQ0ZtYi4KD9lCpm1g76pst1pbgLT4KckVkbUWxGFC97tUtXN6puarzldUCUYnQRyRVYLYP5yh
        yKV5ashBhese4KOWcF6ZJNu7cCKhHd/6ZbA5ZK/v9CFVDq4ZVFs9SerOLlEUccOAaEejb6sfUGfh2
        9TrgBE/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUW3g-00GNjJ-Br; Thu, 08 Apr 2021 14:55:03 +0000
Date:   Thu, 8 Apr 2021 15:55:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v6 05/30] mm: Implement readahead_control pageset
 expansion
Message-ID: <20210408145500.GO2531743@casper.infradead.org>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789069829.6155.4295672417565512161.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161789069829.6155.4295672417565512161.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:04:58PM +0100, David Howells wrote:
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
