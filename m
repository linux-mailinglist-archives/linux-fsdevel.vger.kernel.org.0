Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619F2426B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLI3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 04:29:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgHLI3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597220956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tM7fbBAWWXBkVIey9wZ7wkJQvmojNxlSppUNG5+gS7I=;
        b=VMsxZERnqmd8x13tXOnHF+vmYVWmCDiZtq/yoGXdkGQVjTdKDjjsnFCEs5rBEr94xcWn0X
        BhhvcDB0WSSm+82UoSxJsCE2pgQ6a9wDqyWoskwbZlMunWna9BS58AjdXUqNw10r/0dDoa
        If3Oz8ZF8RCJJHobawfTyzyG8FwJZHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-TlqZyLRKPRmUg1gFsceu9A-1; Wed, 12 Aug 2020 04:29:15 -0400
X-MC-Unique: TlqZyLRKPRmUg1gFsceu9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C7551853DB1;
        Wed, 12 Aug 2020 08:29:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E72998AD14;
        Wed, 12 Aug 2020 08:29:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
References: <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com> <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <52483.1597190733@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98801.1597220949.1@warthog.procyon.org.uk>
Date:   Wed, 12 Aug 2020 09:29:09 +0100
Message-ID: <98802.1597220949@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Worried about performance?  Io-uring will allow you to do all those
> five syscalls (or many more) with just one I/O submission.

io_uring isn't going to help here.  We're talking about synchronous reads.
AIUI, you're adding a couple more syscalls to the list and running stuff in a
side thread to save the effort of going in and out of the kernel five times.
But you still have to pay the set up/tear down costs on the fds and do the
pathwalks.  io_uring doesn't magically make that cost disappear.

io_uring also requires resources such as a kernel accessible ring buffer to
make it work.

You're proposing making everything else more messy just to avoid a dedicated
syscall.  Could you please set out your reasoning for that?

David

