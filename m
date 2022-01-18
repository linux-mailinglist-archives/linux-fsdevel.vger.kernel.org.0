Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9615E492B21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiARQYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 11:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiARQYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:24:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1153C061574;
        Tue, 18 Jan 2022 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jhVRXbKHsK5/+VUWx8p4vGxs4G6MvUWC+Xam2qsrUoE=; b=B8L/4HBkD4afSUo3u1LAzrrP2t
        q8E5GkLH53P9rQfA62suEcPUjnSLlnYuFQ98fuuil6qNWtXVBg7kqKwOia0sJByKWJ9pVTPpX19VZ
        /6fqUXVdLAxhTI9t06zRdMQhjNaxrUn4ABt5KgoooVH7rlx07IBIob7BEKJ5z59dZSP7C7Ti2ly/U
        gkAMZW5YhxoZwnd1aWUsp46fJbCq76LM543tiLUnj43CYV3Lf0PIrjloqr6d0T3BsNXcu4WpLdW5t
        igzmwLo/Ex2fL/Ssmy4mSMCfB9qQGG4XLW9fypo+nYutWP3oSxrlA4ICjuZTpp8gXHCx2NB8a1KHB
        3r/VkXjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9rGs-002EPo-4r; Tue, 18 Jan 2022 16:23:46 +0000
Date:   Tue, 18 Jan 2022 08:23:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for
 the S_KERNEL_FILE flag
Message-ID: <YebpktrcUZOlBHkZ@infradead.org>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
 <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:54:54PM +0000, David Howells wrote:
> Add an IS_KERNEL_FILE() macro to test the S_KERNEL_FILE inode flag as is
> common practice for the other inode flags[1].

Please fix the flag to have a sensible name first, as the naming of the
flag and this new helper is utterly wrong as we already discussed.
