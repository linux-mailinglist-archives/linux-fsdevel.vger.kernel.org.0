Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992753A9632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhFPJdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbhFPJdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623835908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXCjlY2RliOquOvoDO8BDnu0gEbkyWt4VmaWrl8nPLE=;
        b=NW+Qw/+m3b3Esbxe6L7eQKsuswPgdgkDIoz3+N1b4N7cyTjF4X5cuX7iJNmyKZ+1iJ72ng
        TylCiR82LKa9TrtzUkZI9xjyAUf+cNajQvyWmXDIjTMZvG6hiyLSNVuI41Hdu6m1tAM+y0
        ja4F8u3xZX2kUI/g/dTiVGBChDNq708=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-AsjWusxGPbiDGdRv14ygrQ-1; Wed, 16 Jun 2021 05:31:47 -0400
X-MC-Unique: AsjWusxGPbiDGdRv14ygrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55C11858F13;
        Wed, 16 Jun 2021 09:31:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 034495D6D1;
        Wed, 16 Jun 2021 09:31:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-3-willy@infradead.org>
References: <20210614201435.1379188-3-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
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
Content-ID: <811607.1623835903.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 10:31:43 +0100
Message-ID: <811608.1623835903@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> + * Return: The base-2 logarithm of the size of this folio.

You could probably just say "Return: log2 of the size of this folio".

Could we also get a synonym for page_offset()?  Perhaps called folio_fpos()
rather than folio_offset()?  "Offset" is a bit generic.

Reviewed-by: David Howells <dhowells@redhat.com>

