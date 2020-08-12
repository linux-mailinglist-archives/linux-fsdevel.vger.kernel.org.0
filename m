Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7806C242B55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHLOYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:24:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726630AbgHLOYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597242242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF1PzXjpzf3p7zUDwOJiId7wF1Lsnzi9qAduhzfHZOs=;
        b=ZfgarcweGQzfDfwIyh+mNyZ7H3yH5Kyy0MOkkAFrxHdUMbZEEh9OAXBMXYwv6b9+UghmwB
        srhrmiAPB7549HuFtT6hZbc5NNrrBMSl2wNICckpFElAM64nI5Y/DgQiTBR3driZraA3EW
        +hX31Md+j/ExfIGVivKG//cX+e4nXB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-gt8_i8atP8K4P7OsjX-rFQ-1; Wed, 12 Aug 2020 10:23:59 -0400
X-MC-Unique: gt8_i8atP8K4P7OsjX-rFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D6F101C8A5;
        Wed, 12 Aug 2020 14:23:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B129F5D6BD;
        Wed, 12 Aug 2020 14:23:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegvLaoQHZTm1-QKorzsL3ZDnTOcHpcAJn36yF=n-YymCow@mail.gmail.com>
References: <CAJfpegvLaoQHZTm1-QKorzsL3ZDnTOcHpcAJn36yF=n-YymCow@mail.gmail.com> <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <135551.1597240486@warthog.procyon.org.uk>
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
Content-ID: <137928.1597242232.1@warthog.procyon.org.uk>
Date:   Wed, 12 Aug 2020 15:23:52 +0100
Message-ID: <137929.1597242232@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> The point is that generic operations already exist and no need to add
> new, specialized ones to access metadata.

open and read already exist, yes, but the metadata isn't currently in
convenient inodes and dentries that you can just walk through.  So you're
going to end up with a specialised filesystem instead, I suspect.  Basically,
it's the same as your do-everything-through-/proc/self/fds/ approach.

And it's going to be heavier.  I don't know if you're planning on creating a
superblock each time you do an O_ALT open, but you will end up creating some
inodes, dentries and a file - even before you get to the reading bit.

David

