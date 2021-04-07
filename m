Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB813577E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDGWnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 18:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhDGWnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617835416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYVt7IOY92f4o6AihpWFYJ05SCAGXsSZd9ZYg963CF8=;
        b=KWNPM52r3mLPmnten/CgcP+WUF/pI0Ekft8p8d4G9FwUGnKSV2jCWK2wclSa5j2FDMTs51
        vAiCgciVdI00dDJSs4MqoQZ+YfaUoaW2Kx/ab+Q01Yy8Any5UvutawntXg+PLzZnNIAHv+
        venMYqhf0o8H8TPemFFuZMDnHS8EU/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466--CHwVQfCMV-ArBwNt9JnQg-1; Wed, 07 Apr 2021 18:43:34 -0400
X-MC-Unique: -CHwVQfCMV-ArBwNt9JnQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 963208030A1;
        Wed,  7 Apr 2021 22:43:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4F4819D7D;
        Wed,  7 Apr 2021 22:43:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210407201857.3582797-1-willy@infradead.org>
References: <20210407201857.3582797-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] readahead improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <752550.1617835411.1@warthog.procyon.org.uk>
Date:   Wed, 07 Apr 2021 23:43:31 +0100
Message-ID: <752551.1617835411@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> As requested, fix up readahead_expand() so as to not confuse the ondemand
> algorithm.  Also make the documentation slightly better.  Dave, could you
> put in some debug and check this actually works?  I don't generally test
> with any filesystems that use readahead_expand(), but printing (index,
> nr_to_read, lookahead_size) in page_cache_ra_unbounded() would let a human
> (such as your good self) determine whether it's working approximately
> as designed.

I added the patches to my fscache-netfs-lib branch and ran the quick group of
xfstests with afs and got the same results.

David

