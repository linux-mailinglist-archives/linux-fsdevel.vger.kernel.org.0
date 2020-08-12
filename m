Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4315D2428A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHLL2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 07:28:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42076 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727773AbgHLL2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597231717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjV6K3m7aYpDUqAWmC+w9QBoR6kWl/pmzBrtpDLCLfY=;
        b=XjnyI23bd/wx5qQzWg1Yl3tHGH5/c9Toj6qSYmUJCSBSf0FmfjNUkCt4XGwMlpwEgr8PtQ
        iHvnwbQDGy47AJD0PdQiEBLF1kAgIzqJ6F1ygD0EwOWy0BL7BTVpA6+HhUGH0bVdHZY3Yl
        JKiIiqDhW3sbDtU+2a/cGRY04+/dnX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-5J3rQyDiMHeKboA2VdWEqw-1; Wed, 12 Aug 2020 07:28:33 -0400
X-MC-Unique: 5J3rQyDiMHeKboA2VdWEqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56817802B54;
        Wed, 12 Aug 2020 11:28:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA50710013D7;
        Wed, 12 Aug 2020 11:28:27 +0000 (UTC)
Date:   Wed, 12 Aug 2020 13:28:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API
Message-ID: <20200812112825.b52tqeuro2lquxlw@ws.net.home>
References: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk>
 <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
 <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
 <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:04:14PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 12, 2020 at 11:43 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
> >
> > Hi,
> >
> > On 12/08/2020 09:37, Miklos Szeredi wrote:
> > [snip]
> > >
> > > b) The awarded performance boost is not warranted for the use cases it
> > > is designed for.
> 
> >
> > This is a key point. One of the main drivers for this work is the
> > efficiency improvement for large numbers of mounts. Ian and Karel have
> > already provided performance measurements showing a significant benefit
> > compared with what we have today. If you want to propose this
> > alternative interface then you need to show that it can sustain similar
> > levels of performance, otherwise it doesn't solve the problem. So
> > performance numbers here would be helpful.
> 
> Definitely.   Will measure performance with the interface which Linus proposed.

The proposal is based on paths and open(), how do you plan to deal
with mount IDs? David's fsinfo() allows to ask for mount info by mount
ID and it works well with mount notification where you get the ID. The
collaboration with notification interface is critical for our use-cases.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

