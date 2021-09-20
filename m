Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA9411534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhITNE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbhITNEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:04:53 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5FC061574;
        Mon, 20 Sep 2021 06:03:26 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B1BB1C01F; Mon, 20 Sep 2021 15:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1632143001; bh=o0lhty4X6j45MKMdeQ2Ew7ArWBTJlIvbH0JC70A4KkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y/g2DGsjZxzT5ePX+rfTYkXtVhY9eBknuuB7V/YYpZuafUobD7/cCSnOTeSVxjQ5s
         NbIAo65DvpsbqO/Kz3UCNywFXGpXocGVR1GwzOGd3Ry9iGTPEetYlsUhvbtp2Lr407
         9Z2yT/hqc/rFf/xzPdvJWBhIb1S7W7tOP91rVqfXV+YHtE7j3yBybpqUuNpxfbXdrL
         4Ms3ZtRNFuwMTT5tT8WSOoMKJkQeKPfwEo5lrEy50XxMa+l6Jq0dYAYIN5c5li6Ock
         TPrxurSntW8xMHFd3O3vVPL2WJSBTcOcYIoGggOmgq7hDOrQX7RCjyHphaiuVNnT8S
         Dv7fn183ugkKw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 6B61DC009;
        Mon, 20 Sep 2021 15:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1632143000; bh=o0lhty4X6j45MKMdeQ2Ew7ArWBTJlIvbH0JC70A4KkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WPJjhD69bZ4L3Sj16UatugRQAQE+k0FiSJgz/31Pik1fu+m8Hj0yLWfAx46s6qcZz
         FaTBFxWExHkkKjYURG4rYKnmHZcl0X5IBN3z/o+KOfLisYJmTVxqneBod5248tTDZr
         j2Qux4cijpqrT6TOHyUm7iEvAGXixCsLfTQTIRve5NDSX/vKESsxSlDrkKGsKXL8X5
         PEZi+wQWErdr85nSsUKjduLR2eanwkUxza1RqpdXXKpLRwfBVO4SCQzAE5v7LClwJq
         uIKcio8I0T96BJoQ3DBKnN3UnylWxVMtrTA2fokrK2DIP25iB0bzZNSrj2hfBs+fZB
         yeux5WMHa+GFQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8eba130b;
        Mon, 20 Sep 2021 13:03:11 +0000 (UTC)
Date:   Mon, 20 Sep 2021 22:02:55 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fscache, 9p, afs, cifs, nfs: Deal with some warnings
 from W=1
Message-ID: <YUiGf9bzSX62jUrP@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUiAmnMV7+fprNC1@casper.infradead.org>
 <163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Mon, Sep 20, 2021 at 01:14:15PM +0100:
> Deal with some warnings generated from make W=1:
> 
>  (1) Add/remove/fix kerneldoc parameters descriptions.
> 
>  (2) afs_sillyrename() isn't an API functions, so remove the kerneldoc
>      annotation.
> 
>  (3) The fscache object CREATE_OBJECT work state isn't used, so remove it.
> 
>  (4) Move __add_fid() from between v9fs_fid_add() and its comment.
> 
>  (5) 9p's caches_show() doesn't really make sense as an API function, show
>      remove the kerneldoc annotation.  It's also not prefixed with 'v9fs_'.

Happy with the 9p changes:
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

Having all of these in a single commit makes it difficult to deal but I
don't expect any conflict on my end, so happy to have it go in your
fscache tree.

Matthew Wilcox wrote on Mon, Sep 20, 2021 at 01:37:46PM +0100:
> This is an example of a weird pattern in filesystems.  Several of
> them have kernel-doc for the implementation of various ->ops methods.
> I don't necessarily believe we should delete the comments (although is
> there any useful information in the above?), but I don't see the point
> in the comment being kernel-doc.

As far as I'm concerned this is just an "it's always been like this"
thing for me/9p, I wouldn't mind if it were all converted to normal
comments -- but now it's describing arguments by name having it as
kerneldoc has helped catch comments which didn't get updated when
function changed quite a few times in patches similar to this one so it
would only make sense if we remove obvious argument descriptions as well
in my opinion, and that's a bit of manual work.

-- 
Dominique


