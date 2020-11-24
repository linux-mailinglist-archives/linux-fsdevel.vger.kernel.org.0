Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0C2C268E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbgKXMud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 07:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732709AbgKXMuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606222231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85J5ydxTbt/EblYQnFmb9dU7jIz8RU2wol+TDenY5jI=;
        b=jFaJ647b4z+TdWbjGmvUVooDB+7j7LUi8OmaE0RWgd6nZqSWf5PruZILeiZYf7pR5uFd5k
        KvzIX4PEmGjkICrUd78SER4/BRHzUO7EjMSARMnVHEkdprqw/jKzJlFlZgNMXozlC+k6Io
        JxOQ9im8Ox6v7NwqNMR0AKtb8sRjngc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-y8Fb6_MOMjGqGxjHxIppEg-1; Tue, 24 Nov 2020 07:50:27 -0500
X-MC-Unique: y8Fb6_MOMjGqGxjHxIppEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5D0180DE0D;
        Tue, 24 Nov 2020 12:50:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8DB60C64;
        Tue, 24 Nov 2020 12:50:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com>
References: <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com> <20201123080506.GA30578@infradead.org> <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk> <516984.1606127474@warthog.procyon.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1155890.1606222222.1@warthog.procyon.org.uk>
Date:   Tue, 24 Nov 2020 12:50:22 +0000
Message-ID: <1155891.1606222222@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pavel Begunkov <asml.silence@gmail.com> wrote:

> fio is relatively heavy, I'd suggest to try fio/t/io_uring with nullblk

no patches:

IOPS=885152, IOS/call=25/25, inflight=64 (64)
IOPS=890400, IOS/call=25/25, inflight=32 (32)
IOPS=890656, IOS/call=25/25, inflight=64 (64)
IOPS=896096, IOS/call=25/25, inflight=96 (96)
IOPS=876256, IOS/call=25/25, inflight=128 (128)
IOPS=905056, IOS/call=25/25, inflight=128 (128)
IOPS=882912, IOS/call=25/25, inflight=96 (96)
IOPS=887392, IOS/call=25/25, inflight=64 (32)
IOPS=897152, IOS/call=25/25, inflight=128 (128)
IOPS=871392, IOS/call=25/25, inflight=32 (32)
IOPS=865088, IOS/call=25/25, inflight=96 (96)
IOPS=880032, IOS/call=25/25, inflight=32 (32)
IOPS=905376, IOS/call=25/25, inflight=96 (96)
IOPS=898016, IOS/call=25/25, inflight=128 (128)
IOPS=885792, IOS/call=25/25, inflight=64 (64)
IOPS=897632, IOS/call=25/25, inflight=96 (96)

first patch only:

IOPS=876640, IOS/call=25/25, inflight=64 (64)
IOPS=878208, IOS/call=25/25, inflight=64 (64)
IOPS=884000, IOS/call=25/25, inflight=64 (64)
IOPS=900864, IOS/call=25/25, inflight=64 (64)
IOPS=878496, IOS/call=25/25, inflight=64 (64)
IOPS=870944, IOS/call=25/25, inflight=32 (32)
IOPS=900672, IOS/call=25/25, inflight=32 (32)
IOPS=882368, IOS/call=25/25, inflight=128 (128)
IOPS=877120, IOS/call=25/25, inflight=128 (128)
IOPS=861856, IOS/call=25/25, inflight=64 (64)
IOPS=892896, IOS/call=25/25, inflight=96 (96)
IOPS=875808, IOS/call=25/25, inflight=128 (128)
IOPS=887808, IOS/call=25/25, inflight=32 (80)
IOPS=889984, IOS/call=25/25, inflight=128 (128)

all patches:

IOPS=872192, IOS/call=25/25, inflight=96 (96)
IOPS=887360, IOS/call=25/25, inflight=32 (32)
IOPS=894432, IOS/call=25/25, inflight=128 (128)
IOPS=884640, IOS/call=25/25, inflight=32 (32)
IOPS=886784, IOS/call=25/25, inflight=32 (32)
IOPS=884160, IOS/call=25/25, inflight=96 (96)
IOPS=886944, IOS/call=25/25, inflight=96 (96)
IOPS=903360, IOS/call=25/25, inflight=128 (128)
IOPS=887744, IOS/call=25/25, inflight=64 (64)
IOPS=891072, IOS/call=25/25, inflight=32 (32)
IOPS=900512, IOS/call=25/25, inflight=128 (128)
IOPS=888544, IOS/call=25/25, inflight=128 (128)
IOPS=877312, IOS/call=25/25, inflight=128 (128)
IOPS=895008, IOS/call=25/25, inflight=128 (128)
IOPS=889376, IOS/call=25/25, inflight=128 (128)

David

