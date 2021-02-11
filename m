Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CCD31967F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 00:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBKXWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 18:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhBKXWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613085657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6IjqWhQ0S9zeiEfAx5Yk7ukP5YPF6bWEm9sEktZ4FzI=;
        b=Sv2BmASltM7RiVDYVB/AXsRQT6UrKqdNFOnmqKvQeExStUhs2rI/np2x8P/iMw5Ex4m1Jq
        a9GmjNG3+yuSu+2tGr79x9rsoTQNAj77U0BMbCAsTJt9kPLEWO9dMmT2n64BmzYneFGwRF
        XYlQb7aYElaa33OizY62ELvt6J8Dzhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-vgOPstjGMz6AfI60Xa_BHQ-1; Thu, 11 Feb 2021 18:20:55 -0500
X-MC-Unique: vgOPstjGMz6AfI60Xa_BHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66AA4107ACC7;
        Thu, 11 Feb 2021 23:20:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2932F60657;
        Thu, 11 Feb 2021 23:20:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
References: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk> <1330751.1612974783@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27815.1613085646.1@warthog.procyon.org.uk>
Date:   Thu, 11 Feb 2021 23:20:46 +0000
Message-ID: <27816.1613085646@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Also, honestly, I really *REALLY* want your commit messages to talk
> about who has been cc'd, who has been part of development, and point
> to the PUBLIC MAILING LISTS WHERE THAT DISCUSSION WAS TAKING PLACE, so
> that I can actually see that "yes, other people were involved"

Most of the development discussion took place on IRC and waving snippets of
code about in pastebin rather than email - the latency of email is just too
high.  There's not a great deal I can do about that now as I haven't kept IRC
logs.  I can do that in future if you want.

> No, I don't require this in general, but exactly because of the
> history we have, I really really want to see that. I want to see a
>
>    Link: https://lore.kernel.org/r/....

I can add links to where I've posted the stuff for review.  Do you want this
on a per-patch basis or just in the cover for now?

Also, do you want things like these:

 https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
 https://lore.kernel.org/linux-fsdevel/4467.1579020509@warthog.procyon.org.uk/

which pertain to the overall fscache rewrite, but where the relevant changes
didn't end up included in this particular patchset?  Or this:

 https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.html

where someone was testing the overall patchset of which this is a subset?

> and the Cc's - or better yet, the Reviewed-by's etc - so that when I
> get a pull request, it really is very obvious to me when I look at it
> that others really have been involved.
> 
> So if I continue to see just
> 
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 
> at the end of the commit messages, I will not pull.
> 
> Yes, in this thread a couple of people have piped up and said that
> they were part of the discussion and that they are interested, but if
> I have to start asking around just to see that, then it's too little,
> too late.
> 
> No more of this "it looks like David Howells did things in private". I
> want links I can follow to see the discussion, and I really want to
> see that others really have been involved.
> 
> Ok?

Sure.

I can go and edit in link pointers into the existing patches if you want and
add Jeff's Review-and-tested-by into the appropriate ones.  You would be able
to compare against the existing tag, so it wouldn't entirely invalidate the
testing.

Also, do you want links inserting into all the patches of the two keyrings
pull requests I've sent you?

David

