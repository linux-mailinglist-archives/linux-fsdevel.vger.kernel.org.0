Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D73B0CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVSPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230146AbhFVSPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624385588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miPd5CYvzE+oNS2YKPohgJHcAhxiPdT10XDw8a3tjh8=;
        b=Og/BgatMQ9BKn5JX5dFbZlln51EgaRnLu/eusRWeeyz2m6pTQ53DsBA54KBFz/8f9/HOiO
        diygGdxMvflZgnPZ1mWJc5nr2kdtHVfPBqrgPgwgYdZlr6RcSU4ePleU36lFFBU86PX9Vz
        MFjb4d47abJOi9/K0+kE1WyipI49ilQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-Zn3GIKvjNVeF1SIxtLQnQA-1; Tue, 22 Jun 2021 14:13:06 -0400
X-MC-Unique: Zn3GIKvjNVeF1SIxtLQnQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35BBC1084F4C;
        Tue, 22 Jun 2021 18:13:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0688D6091B;
        Tue, 22 Jun 2021 18:13:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YNImEkqizzuStW72@casper.infradead.org>
References: <YNImEkqizzuStW72@casper.infradead.org> <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com> <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk> <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org> <3231150.1624384533@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user buffer pages"?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3232237.1624385582.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 22 Jun 2021 19:13:02 +0100
Message-ID: <3232238.1624385582@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > It may also cause the read in to happen in the background whilst write=
_begin
> > is being done.
> =

> Huh?  Last I checked, the fault_in_readable actually read a byte from
> the page.  It has to wait for the read to complete before that can
> happen.

Ah, good point.

David

