Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA28D31B391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 01:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhBOAYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 19:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229881AbhBOAYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 19:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613348591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icyirenyNVPQ/6+Zc420o3Iw7zjp69we48horNqQpPg=;
        b=Gm8bdkiMNHIpOdEKvgxUW7pseqmRMOeClH5yiwLBCQ5lnqDHD7wifsxshV72xkKUAfe1Hj
        dBukpa/PSQEK6kkMY7Nn5OtVPi343sPWs4+zhj1eaJAinfDtYBlfE0KKrSKL3d8ahgUSue
        wFGmpZy8/1qKvrXcisjjZNy6C1RXjoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-xtPvx-7lP1aR-4qYcHimfw-1; Sun, 14 Feb 2021 19:23:07 -0500
X-MC-Unique: xtPvx-7lP1aR-4qYcHimfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FB8D1005501;
        Mon, 15 Feb 2021 00:23:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 013BD6F986;
        Mon, 15 Feb 2021 00:22:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
References: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk> <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com> <27816.1613085646@warthog.procyon.org.uk>
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
Content-ID: <860728.1613348577.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 15 Feb 2021 00:22:57 +0000
Message-ID: <860729.1613348577@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But no, it's not a replacement for actual code review after the fact.
> =

> If you think email has too long latency for review, and can't use
> public mailing lists and cc the people who are maintainers, then I
> simply don't want your patches.

I think we were talking at cross-purposes by the term "development" here. =
 I
was referring to the discussion of how the implementation should be done a=
nd
working closely with colleagues - both inside and outside Red Hat - to get
things working, not specifically the public review side of things.  It's j=
ust
that I don't have a complete record of the how-to-implement-it, the
how-to-get-various-bits-working-together and the why-is-it-not-working?
discussions.

Anyway, I have posted my fscache modernisation patches multiple times for
public review, I have tried to involve the wider community in aspects of t=
he
development on public mailing lists and I have been including the maintain=
ers
in to/cc.

I've posted the more full patchset for public review a number of times:

4th May 2020:
https://lore.kernel.org/linux-fsdevel/158861203563.340223.7585359869938129=
395.stgit@warthog.procyon.org.uk/

13th Jul (split into three subsets):
https://lore.kernel.org/linux-fsdevel/159465766378.1376105.116199762510392=
87525.stgit@warthog.procyon.org.uk/
https://lore.kernel.org/linux-fsdevel/159465784033.1376674.181064636939898=
11037.stgit@warthog.procyon.org.uk/
https://lore.kernel.org/linux-fsdevel/159465821598.1377938.204636227022500=
8168.stgit@warthog.procyon.org.uk/

20th Nov:
https://lore.kernel.org/linux-fsdevel/160588455242.3465195.321473385827301=
9178.stgit@warthog.procyon.org.uk/

I then cut it down and posted that publically a couple of times:

20th Jan:
https://lore.kernel.org/linux-fsdevel/161118128472.1232039.117467998330664=
25131.stgit@warthog.procyon.org.uk/

25th Jan:
https://lore.kernel.org/linux-fsdevel/161161025063.2537118.200924944468224=
1405.stgit@warthog.procyon.org.uk/

I let you know what was coming here:
https://lore.kernel.org/linux-fsdevel/447452.1596109876@warthog.procyon.or=
g.uk/
https://lore.kernel.org/linux-fsdevel/2522190.1612544534@warthog.procyon.o=
rg.uk/

to try and find out whether you were going to have any objections to the
design in advance, rather than at the last minute.

I've apprised people of what I was up to:
https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
https://lore.kernel.org/linux-fsdevel/2758811.1610621106@warthog.procyon.o=
rg.uk/
https://lore.kernel.org/linux-fsdevel/1441311.1598547738@warthog.procyon.o=
rg.uk/
https://lore.kernel.org/linux-fsdevel/160655.1611012999@warthog.procyon.or=
g.uk/

Asked for consultation on parts of what I wanted to do:
https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.=
uk/
https://lore.kernel.org/linux-fsdevel/4467.1579020509@warthog.procyon.org.=
uk/
https://lore.kernel.org/linux-fsdevel/3577430.1579705075@warthog.procyon.o=
rg.uk/

Asked someone who is actually using fscache in production to test the rewr=
ite:
https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.h=
tml

I've posted partial patches to try and help 9p and cifs along:
https://lore.kernel.org/linux-fsdevel/1514086.1605697347@warthog.procyon.o=
rg.uk/
https://lore.kernel.org/linux-cifs/1794123.1605713481@warthog.procyon.org.=
uk/
https://lore.kernel.org/linux-fsdevel/241017.1612263863@warthog.procyon.or=
g.uk/
https://lore.kernel.org/linux-cifs/270998.1612265397@warthog.procyon.org.u=
k/

(Jeff has been handling Ceph and Dave NFS).

Proposed conference topics related to this:
https://lore.kernel.org/linux-fsdevel/9608.1575900019@warthog.procyon.org.=
uk/
https://lore.kernel.org/linux-fsdevel/14196.1575902815@warthog.procyon.org=
.uk/
https://lore.kernel.org/linux-fsdevel/364531.1579265357@warthog.procyon.or=
g.uk/

though the lockdown put paid to that:-(

Willy has discussed it too:
https://lore.kernel.org/linux-fsdevel/20200826193116.GU17456@casper.infrad=
ead.org/

David

