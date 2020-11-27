Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF612C6A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgK0ROU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 12:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731905AbgK0ROR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606497256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KIgiB7XwiEetdKIISGv2CypamLeOfEv8HOdOckyqc9M=;
        b=CKTtCeMrqMcOv173J4MhCpD3MvSN5xFSYVbEhvM6MeHSz4H1IRN8SLLvoueA116dy88xfP
        3pZlSiJfE8dwAWTe5LFUuQRbrkeDGN3LvLcCWZCX8CR4D5+ADydBk7FTeXWX1lmFWcGVoz
        67FAsXzINMwOiXumWc/NrZd8ooCx27I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-o9IBtE9xOm26M_tKsJPzVQ-1; Fri, 27 Nov 2020 12:14:13 -0500
X-MC-Unique: o9IBtE9xOm26M_tKsJPzVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171018042CC;
        Fri, 27 Nov 2020 17:14:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E916B6085D;
        Fri, 27 Nov 2020 17:14:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5b8ce555-7451-d977-22e7-e5d080ef2e1a@kernel.dk>
References: <5b8ce555-7451-d977-22e7-e5d080ef2e1a@kernel.dk> <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com> <20201123080506.GA30578@infradead.org> <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk> <516984.1606127474@warthog.procyon.org.uk> <1155891.1606222222@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2791167.1606497249.1@warthog.procyon.org.uk>
Date:   Fri, 27 Nov 2020 17:14:09 +0000
Message-ID: <2791168.1606497249@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> which looks to be around a 6% drop.

That's quite a lot.

> which looks to be around 2-3%, but we're also running at a much
> slower rate (830K vs ~2.3M).

That's still a lot.

Thanks for having a look!

David

