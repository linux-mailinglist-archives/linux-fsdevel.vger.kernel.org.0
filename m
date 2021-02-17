Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8687131DC9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 16:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhBQPoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 10:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233761AbhBQPoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613576566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcLEsH31tuwsh/4DX1Q5nBlV7w+3XG/SIyqKK0hnVM0=;
        b=hkCVrxYUxXy06vRNVMxv1Fe9AOz4nJxocpvzEXRlhKSZTgq9xmFv4Yn96u44yaWdxPL2UE
        OhhtxCgpjhoS0s9lZfqQRY7WsyeUTGamajmRrCRSYdejb37vQNfR9AxvQ4JrsuX2V7nl9V
        deUnwuB8t8KSAsHTys7fGq72LeQr7kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-droMoF7zMQSpyOmj-QQ_fw-1; Wed, 17 Feb 2021 10:42:42 -0500
X-MC-Unique: droMoF7zMQSpyOmj-QQ_fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0E76A0BC8;
        Wed, 17 Feb 2021 15:42:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35BDC5C3E4;
        Wed, 17 Feb 2021 15:42:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSQYBjnMsDj5pMd6MOGTY5w_ZR=pw7VRYKfP5ZwmHBj2=Q@mail.gmail.com>
References: <CAOg9mSQYBjnMsDj5pMd6MOGTY5w_ZR=pw7VRYKfP5ZwmHBj2=Q@mail.gmail.com> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk> <20210216103215.GB27714@lst.de> <20210216132251.GI2858050@casper.infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586930.1613576553.1@warthog.procyon.org.uk>
Date:   Wed, 17 Feb 2021 15:42:33 +0000
Message-ID: <1586931.1613576553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> I plan to try and use readahead_expand in Orangefs...

Would it help if I shuffled the readahead_expand patch to the bottom of the
pack?

David

