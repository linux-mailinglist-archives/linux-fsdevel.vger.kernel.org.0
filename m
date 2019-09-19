Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7FB7B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfISODb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 10:03:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38252 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbfISODb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:03:31 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so7965272iol.5;
        Thu, 19 Sep 2019 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/2Z+xK26B0Qa9nBtssF8FRk9MDYmDZ7v204MIYrXPQ=;
        b=DLsWOHJytMjXzqdooDAScGRrLwolZBO1OrSvUyszMDhy2r9hjOgN48Q86vlfMu1nSJ
         vUPEsxhOFj3/m8893jlHMEw4TQFJzkJET1FO9NTZ8cnCgGhDj+JBUf4RzoeLPXHWdbrz
         DXAgqZ9ijGaS4N0tckhsEbH9W3jtcRQq5rnCJ1NooVNIYpL70KoObUOfYRPHdQYhjsGQ
         9ZASgQf6TGzeJITRB23Z2CuU9GtnVJCT1rm9N0YP4SOKKSGGrutz85sueZsV7SUB1ZaY
         //s1dQOZs07d2l55y9pa+biNMptcHOQDBvNZyD33Zum8+ESKRq609Ux8EaTE5ZVJq9Rt
         7CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/2Z+xK26B0Qa9nBtssF8FRk9MDYmDZ7v204MIYrXPQ=;
        b=D3P62ocWCT77CcNThJLSnPNI9dP68AKCVE+hzBTa6QeDJSWuJFCpJYgAsK5ZRM0T4a
         nrpV3rIWjZR3vvFolynFumrFerfCLru2QZab2QTJ3eGggmeHlMHPtUSG/Axtg0HWQ3nY
         UHh3hLaR5giTBgdzCN8ouG+7MUCmFNNPrw+Zk0zzSmWzPdKbUdOER6Lh4tGxy6wEOOwF
         efNph1CFJlRE5uJzUVQphE1QhYPmTlQhpX4MHBR9RGhCDDPvqqPkxL2zdhwO8togZD9w
         ecPXUksMBar2G6pXBBmBQqI4/hrmWH5fxaQhg1AetOKettxkgOfGAMqMA5BtczJ7llY4
         q4aQ==
X-Gm-Message-State: APjAAAV8uMX2InoZ/nJBJAGgDhY3M4bGqni4ARH/Ki5gtczDdAgZE6MS
        A2XNqruqy77N+jwXfvOx+6cGoQf89tcET9H1IJ4=
X-Google-Smtp-Source: APXvYqxp6gW43kwN3LJPPeCY0tft6kg9EeyqSAnHqBoR8n6r3SlG9KzQt20lImzP6tnJo3niaXDYX5XuA+ZcXpZc25o=
X-Received: by 2002:a5d:9f4e:: with SMTP id u14mr12333009iot.106.1568901810170;
 Thu, 19 Sep 2019 07:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <28368.1568875207@warthog.procyon.org.uk> <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
 <16147.1568632167@warthog.procyon.org.uk> <16257.1568886562@warthog.procyon.org.uk>
 <20190919131537.GA15392@bombadil.infradead.org>
In-Reply-To: <20190919131537.GA15392@bombadil.infradead.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 19 Sep 2019 16:03:20 +0200
Message-ID: <CAOi1vP-rQLhu=JF1H2Tmz21tM+FhTPYuKYjx05iSijv_QckVpQ@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 3:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 19, 2019 at 10:49:22AM +0100, David Howells wrote:
> > David Howells <dhowells@redhat.com> wrote:
> >
> > > > However, I was close to unpulling it again. It has a merge commit with
> > > > this merge message:
> > > >
> > > >     Merge remote-tracking branch 'net/master' into afs-next
> > > >
> > > > and that simply is not acceptable.
> > >
> > > Apologies - I meant to rebase that away.  There was a bug fix to rxrpc in
> > > net/master that didn't get pulled into your tree until Saturday.
> >
> > Actually, waiting for all outstanding fixes to get merged and then rebasing
> > might not be the right thing here.  The problem is that there are fixes in
> > both trees: afs fixes go directly into yours whereas rxrpc fixes go via
> > networking and I would prefer to base my patches on both of them for testing
> > purposes.  What's the preferred method for dealing with that?  Base on a merge
> > of the lastest of those fixes in each tree?
>
> Why is it organised this way?  I mean, yes, technically, rxrpc is a
> generic layer-6 protocol that any blah blah blah, but in practice no
> other user has come up in the last 37 years, so why bother pretending
> one is going to?  Just git mv net/rxrpc fs/afs/ and merge everything
> through your tree.
>
> I feel similarly about net/9p, net/sunrpc and net/ceph.  Every filesystem
> comes with its own presentation layer; nobody reuses an existing one.
> Just stop pretending they're separate components.

net/ceph is also being used by drivers/block/rbd.c.  net/ceph was split
out of fs/ceph when rbd was introduced.  We continued to manage them in
a single ceph-client.git tree though.

Thanks,

                Ilya
