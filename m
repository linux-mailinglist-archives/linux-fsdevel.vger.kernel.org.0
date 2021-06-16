Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D443A97D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhFPKn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbhFPKnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623840074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWEt9p9DXdZhqDZchOI4jAwnNkq0AvDlrJB64/vFrV4=;
        b=h2eAMZTyht22BwcMZAyJoURHuEvFf9qR7AC0iiGIHRYV/KuzD58TWavclQs3IkucBJdLZw
        srJHs20JcbIM8Ol7v9vkzRquW7UJ1oprYWrdmHi1Z7fgzAaDke2GTNsB8+4r9v05/dB7LM
        MOzQVEehavcvD/CzUI4gb1A0DHrWodk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-DcH2aPvvORaGN_IKJguTjQ-1; Wed, 16 Jun 2021 06:41:12 -0400
X-MC-Unique: DcH2aPvvORaGN_IKJguTjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F66B9126F;
        Wed, 16 Jun 2021 10:41:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 941425D9DE;
        Wed, 16 Jun 2021 10:41:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <811608.1623835903@warthog.procyon.org.uk>
References: <811608.1623835903@warthog.procyon.org.uk> <20210614201435.1379188-3-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 02/33] mm: Introduce struct folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <816706.1623840068.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:41:08 +0100
Message-ID: <816707.1623840068@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Could we also get a synonym for page_offset()?  Perhaps called folio_fpos()
> rather than folio_offset()?  "Offset" is a bit generic.

Nevermind, that's handled in a later patch.

David

