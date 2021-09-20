Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537AB412302
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351616AbhITST5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 14:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351444AbhITSRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632161780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=smgGeNTJKJdRB3jySjdLq/O6aIDEticWWn8WNZpB814=;
        b=YuzYaMpkaJ4+hcmiSIGX+WLg+FrxfFxmsxQm/ktdsnP/BzzcfcBcpTS4DM7jtd3dhsYvv+
        rAe1GcG5MJWgxqwQTaINACBqzJmBKfcmnOmA0KbogN1Gv4Z5hgvDmYC68lQWEBgVHcTS7l
        kuoC+MOzcpDhniydyD7dcl8h7q+dKVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-V_dpYbo3NfOmkZRcCVpp8Q-1; Mon, 20 Sep 2021 14:16:19 -0400
X-MC-Unique: V_dpYbo3NfOmkZRcCVpp8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467EE802936;
        Mon, 20 Sep 2021 18:16:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 687BB19724;
        Mon, 20 Sep 2021 18:16:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5murR7TbC9BtSgWyrJVC-YG5dUba2ekZTvX75gg4ukaAZw@mail.gmail.com>
References: <CAH2r5murR7TbC9BtSgWyrJVC-YG5dUba2ekZTvX75gg4ukaAZw@mail.gmail.com> <163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] fscache, 9p, afs, cifs, nfs: Deal with some warnings from W=1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2976711.1632161773.1@warthog.procyon.org.uk>
Date:   Mon, 20 Sep 2021 19:16:13 +0100
Message-ID: <2976712.1632161773@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> For the cifs ones in connect.c (and also ioctl.c), I had submitted a
> patch in rc1 for these (haven't heard back on that) but did not submit
> kerneldoc fixup for fs/cifs/misc.c.  They seem trivial and safe, do
> you want to split those out and I can put them in?

I can, though the reason I did the patch is that the warnings are always
popping up in what I'm doing.  I can drop the patch from mine when I'm done, I
guess.

David

