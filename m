Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEA17C0D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCFOtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 09:49:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbgCFOtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583506140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPKncNxD+H6FSBEIxsKO9EUaXIxD1slAskRHA95lWGQ=;
        b=Mu8MYU556M07CYCiNkvkhDb2LKFSadEjA5H7Dc5pgM81Xmkn71zw90js2CWDtgZlzgvQS2
        HMmFku12Kvxk57V/eiCUa/ldDLe51+1wOGG+z7VTDsYFGiclqN649fwrOGMmI8Grgv8ijb
        Zgf6Jj2bmI551yFTXojzurjCplhkHcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-QSXU0n8gM-6CEnr1OE_cyg-1; Fri, 06 Mar 2020 09:48:57 -0500
X-MC-Unique: QSXU0n8gM-6CEnr1OE_cyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383AD1034B20;
        Fri,  6 Mar 2020 14:48:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78B788D57C;
        Fri,  6 Mar 2020 14:48:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200306140032.tpwfytofaeuazalo@yavin>
References: <20200306140032.tpwfytofaeuazalo@yavin> <20200302152458.hznqqssixhlpykgr@yavin> <20200302143546.srzk3rnh4o6s76a7@wittgenstein> <20200302115239.pcxvej3szmricxzu@wittgenstein> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <848282.1583159228@warthog.procyon.org.uk> <888183.1583160603@warthog.procyon.org.uk> <20200302150528.okjdx2mkluicje4w@wittgenstein> <932113.1583167065@warthog.procyon.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4041048.1583506130.1@warthog.procyon.org.uk>
Date:   Fri, 06 Mar 2020 14:48:50 +0000
Message-ID: <4041049.1583506130@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> wrote:

> Right, but open_tree() doesn't need RESOLVE_ flags (nor can you add them
> without an open_tree2()). Instead you can pass an O_PATH file descriptor
> with AT_EMPTY_PATH which you could've safely resolved with openat2().

Note that openat2() is not a substitute for open_tree(). See the effect of
the OPEN_TREE_CLONE flag.

David

