Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125043F69ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhHXTgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhHXTgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629833756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjeJb11sd7AXQmlw4rd/pE8mkEc+Ncx1wpvZlkae4fs=;
        b=cxrBr/SV2hey3liK/YRe1Nn/8iRFhSGpbkdaCBTeQeDrRYVIH4/UdnBUZY7KpBc23PQLi+
        L9Yhl1V/TGdPkpcBe39jBVkMk6aUcF/kfrBpMGKciah6WQl3UcxC/TTzyRpKdE5d7ucy28
        B9a544TipOTsUnGdNmheFUME5qfdFsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-6HO01C7nOj-y0iZJsa8Uug-1; Tue, 24 Aug 2021 15:35:54 -0400
X-MC-Unique: 6HO01C7nOj-y0iZJsa8Uug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 818A3800493;
        Tue, 24 Aug 2021 19:35:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F207E1ABDF;
        Tue, 24 Aug 2021 19:35:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YSVHI9iaamxTGmI7@casper.infradead.org>
References: <YSVHI9iaamxTGmI7@casper.infradead.org> <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org> <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com> <YSVCAJDYShQke6Sy@casper.infradead.org> <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1967143.1629833751.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 20:35:51 +0100
Message-ID: <1967144.1629833751@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Sure, but at the time Jeff Bonwick chose it, it had no meaning in
> computer science or operating system design.  Whatever name is chosen,
> we'll get used to it.  I don't even care what name it is.
> 
> I want "short" because it ends up used everywhere.  I don't want to
> be typing
> 	lock_hippopotamus(hippopotamus);
> 
> and I want greppable so it's not confused with something somebody else
> has already used as an identifier.

Can you live with pageset?

David

