Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644442C03E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 12:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgKWLOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 06:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbgKWLOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606130070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5lml5vZHauiXQibHImb0/7U2VYF7jHEppen3GS3U/U=;
        b=UArDClm3bbQIwvqvbQQFE5Cv4a+nbpQJ4QO3HCVh6dA6PeqBVhe3jpcKbObAsmusFnW/Jq
        2vtxcD6cjCJgEWWVD7OId7sIeOuiosI1xLPNVRrhE75xgU3vgXDEvviMpSSm/ZmOHMy+bN
        Jr6dNE5zgdRQ8ROx4dhu4oPyfUx/Ky0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-9Ijj66mtOfeY6n0Ul4XQVQ-1; Mon, 23 Nov 2020 06:14:26 -0500
X-MC-Unique: 9Ijj66mtOfeY6n0Ul4XQVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA8B106F6EC;
        Mon, 23 Nov 2020 11:14:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4BE660C04;
        Mon, 23 Nov 2020 11:14:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <516984.1606127474@warthog.procyon.org.uk>
References: <516984.1606127474@warthog.procyon.org.uk> <20201123080506.GA30578@infradead.org> <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <519189.1606130062.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Nov 2020 11:14:22 +0000
Message-ID: <519190.1606130062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I tried three different sets of patches: none, just the first (which add=
s the
> jump table without getting rid of the conditional branches), and all of =
them.

And, I forgot to mention, I ran each test four times and then interleaved =
the
result lines for that set.

David

