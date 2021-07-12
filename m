Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3532E3C5F96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhGLPq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 11:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235630AbhGLPq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626104648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WuSPRD1wDv1XgXD6ASMOATCcREIw2C2s++qW8Y0/iD4=;
        b=i6IobVgkjlIYgp5syiUqEEw/VPWY+Fu0o0Uck5tQSHNyMnm6JP1K9qhAaiu2lQLnCKqPjc
        RAYUtKmiH+DmEzVjrBLkunNkt/UBk3c3i6rNCEI2ZZD8dtuUQePtkqxl77ZmtOJvThMJ2+
        I8JDLLK8zUucUUfRbNSdtdGBIvknqKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348--poMmpVWPna4Y7tWojGNoQ-1; Mon, 12 Jul 2021 11:44:06 -0400
X-MC-Unique: -poMmpVWPna4Y7tWojGNoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC6F61B2C9AF;
        Mon, 12 Jul 2021 15:43:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F175A1042A43;
        Mon, 12 Jul 2021 15:43:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Request for folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3398984.1626104609.1@warthog.procyon.org.uk>
Date:   Mon, 12 Jul 2021 16:43:29 +0100
Message-ID: <3398985.1626104609@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Is it possible to get Willy's folios patchset - or at least the core of it -
staged for the next merge window?  I'm working on improvements to the local
filesystem caching code and the network filesystem support library and that
involves a lot of dealing with pages - all of which will need to be converted
to the folios stuff.  This has the potential to conflict with the changes
Willy's patches make to filesystems.  Further, the folios patchset offers some
facilities that make my changes a bit easier - and some changes that make
things a bit more challenging (e.g. page size becoming variable).

Also, is it possible to get the folios patchset in a stable public git branch
that I can base my patches upon?

Thanks,
David

