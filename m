Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92F3F6995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhHXTMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234096AbhHXTME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629832279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QytVIZ66gR0G8NeLCm8O1HuYOuxgKf1znU1X9au5n0k=;
        b=Lw4v+XCvjdxqHqUFjhHN4BG+28D0IKIFfr2fSowAe5vlM3lz86HucEk2eCXvwdXDDEL4lP
        UupOvW6xx8f8RxJ6N8L/f1xrx4na9TkvV4w/Ss9Zy7iqgIAzlbBleMrdhVMmYBrQMr2hp7
        JfhcYPr2Ix1qWSWJdXC7KoYmBvxW+wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-JFz9LW5AMk65QMBUzvoOGw-1; Tue, 24 Aug 2021 15:11:18 -0400
X-MC-Unique: JFz9LW5AMk65QMBUzvoOGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99FD987505F;
        Tue, 24 Aug 2021 19:11:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A573360C05;
        Tue, 24 Aug 2021 19:11:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
References: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com> <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org> <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1966105.1629832273.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 20:11:13 +0100
Message-ID: <1966106.1629832273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Something like just "struct pages" would be less clunky, would still
> get the message across, but gets a bit too visually similar.

"page_group"?  I would suggest "pgroup", but that's already taken.  Maybe
"page_set" with "pset" as a shorthand pointer name.  Or "struct pset/pgset"?

I would prefer a short single word name as there's a good chance it's going to
be prefixing a bunch of API functions.

If you don't mind straying a bit from something with then name "page" in it,
then "chapter", "sheet" or "book"?

David

