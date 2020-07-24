Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C155822CEF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGXT7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:59:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbgGXT7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595620792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Y8DAU+5pPrSS4jiBjfZlFxrk4Ru03nSwBoI5HcfmaE=;
        b=Lgnd9knYKekf4x+STyADHu+Q9sWaDZFBKioGxgRbZGYns/TBUeNj/8pwg2MMtmY1GJNOW1
        StzMW0oTzWxwJLwBh0+yuizM2rjVvj4LOyavNB6EgYq16qKC69mjtuIHa4vmil26H9ZqJd
        psY/wurNeQwSROwrUWO1NZ5aIBBXDvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-vs8mvubXOWuU2pZDAJAw5A-1; Fri, 24 Jul 2020 15:59:51 -0400
X-MC-Unique: vs8mvubXOWuU2pZDAJAw5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D88800688;
        Fri, 24 Jul 2020 19:59:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37E9F76210;
        Fri, 24 Jul 2020 19:59:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
References: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com> <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk> <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute change notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2189055.1595620785.1@warthog.procyon.org.uk>
Date:   Fri, 24 Jul 2020 20:59:45 +0100
Message-ID: <2189056.1595620785@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So now you can basically allocate as much kernel memory as you want as
> a regular user, as long as you have a mounted directory you can walk
> (ie everybody).
> 
> Is there any limiting of watches anywhere? I don't see it.

That's a good point.  Any suggestions on how to do it?  An additional RLIMIT?

Or should I do it like I did with keyrings and separately manage a quota for
each user?

David

