Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1AD665024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 00:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAJX7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 18:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjAJX7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:59:54 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D150F46;
        Tue, 10 Jan 2023 15:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zaQebgLDqCPgFYMaZnJVb7D3Vvt9ZqamhPlbIpdbnqY=; b=TH+tlcaPZSexC2qXnGIKYRM+8j
        G0HiRq/83FpJEoGuZ+V9ZlNyyjhkO7pruJVlpP0Vi+1lRiv5LyX0LdkE8Udw2l2Lk7mW640+KaCQq
        P2+SvmM86IitIsV+pODan7G9B4dhNYwE4rLbvwnVuiCkZoyRJcgIVqLYC0yOWlL7/9z6ztOq+Kppj
        ZfUUNBMZQGku21yh4fgYh0azrXN60Ss66TJ/k7xclbkoiFzlcgp9GCF+Zc9wgxh6ZksK3KVYxdFf4
        eWaJUP+c8KMSckecJ8OlL0rYTjxDEBcxwLOHhm82QMfkjJDqTpz1wAe+eJJvaW4k9LVtReSHKbswS
        nZR9n0lA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFOWj-0015az-2b;
        Tue, 10 Jan 2023 23:59:33 +0000
Date:   Tue, 10 Jan 2023 23:59:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: remove locks_inode
Message-ID: <Y7375Zo5pE7g4P4H@ZenIV>
References: <20230110104501.11722-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110104501.11722-1-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:44:59AM -0500, Jeff Layton wrote:
> locks_inode was turned into a wrapper around file_inode in de2a4a501e71
> (Partially revert "locks: fix file locking on overlayfs"). Finish
> replacing locks_inode invocations everywhere with file_inode.

Looks good to me.  Which tree do you want that to go through?
