Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCC444249
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKCNYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCNYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:24:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97BC061714;
        Wed,  3 Nov 2021 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z83BEBMepikQKZaP7EwgKglGj7+Xl9d+0OspVk4dFzg=; b=L4/mKn8kutBEl0TkUQJ6klzqsR
        qLPAy5ZFYF3BO83gwwJmwULBp+Q9KJL7eUjjz9niSU/Kx2FoHaQQyz3wAv9aoOwRIC5MlhtOI53Wg
        Bml8n9+v0exM+gHGB6surId2PyAY+bjT7Urkd+4DSWGAxCHtN0qmFc8kZKmH5mBIyJm8LnUX8uv5M
        qkGgWMP8CxZtf3mAjlCqC4+XT2CADd17BtoHE5OP6og3XM0iKsRCRRwybK/G/RxoTOwY5M6R/i3oi
        /e6KirRaXVvvsJxSX6zm3lEi6xYqN2IGYM5POKKxd5LfgDMSq0S8uEFElxfvBIALagP4KkypLu889
        CmGxnfIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miG7U-005DZJ-PP; Wed, 03 Nov 2021 13:16:32 +0000
Date:   Wed, 3 Nov 2021 13:16:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] folio: Add a function to get the host inode for a
 folio
Message-ID: <YYKLkBwQdtn4ja+i@casper.infradead.org>
References: <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk>
 <163584184628.4023316.9386282630968981869.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163584184628.4023316.9386282630968981869.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 08:30:46AM +0000, David Howells wrote:
> Add a convenience function, folio_inode() that will get the host inode from
> a folio's mapping.

I'm not opposed, but it only saves two characters, so I'm not entirely
sure it justifies its existance.  On the other hand, folio_inode() is
clear about what it does.

> + * For folios which are in the page cache, return the inode that is hosting
> + * this folio belongs to.

This looks like an editing mistake.  Either you meant
'return the inode that hosts this folio' or
'return the inode this folio belongs to'
(and i prefer the second).

With that grammo fixed,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
