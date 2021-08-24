Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3A3F6B03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHXVdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 17:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhHXVc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629840734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1bBKQxF9AzQlxTWDTeQSqBxRnoYnXGYVxoI8bGH2M7Q=;
        b=MBqdOr89AEJD+meJLzM+kQzU+S6/q8tDYnZe4v5m9aBOrYnW8kU/TFgN9WV95iTgmIF6dF
        q2cDM9eL91QMZJfD6tp0Nf0Vt6y9WRK5hxcNKpHSTrIwmfspO+0wvZAfqjoxygPhfGJqGP
        puxxgd3QXAyjOTcuP3RWkM0q6ETCa2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-kETizTevP-u1-NfG0NVGLA-1; Tue, 24 Aug 2021 17:32:12 -0400
X-MC-Unique: kETizTevP-u1-NfG0NVGLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF71D1082922;
        Tue, 24 Aug 2021 21:32:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0788E5D9C6;
        Tue, 24 Aug 2021 21:32:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YSVQOgrPhwGcUSp4@mit.edu>
References: <YSVQOgrPhwGcUSp4@mit.edu> <YSVH6k5plj9lrTFe@mit.edu> <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org> <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org> <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com> <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com> <1967090.1629833687@warthog.procyon.org.uk>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1974379.1629840723.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 22:32:03 +0100
Message-ID: <1974380.1629840723@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:

> What do you think of "struct pageset"?  Not quite as short as folios,
> but it's clearer.

Fine by me (I suggested page_set), and as Vlastimil points out, the current
usage of the name could be renamed.

David

