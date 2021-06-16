Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204033A964C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhFPJir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhFPJiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623836200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pb8rlKDzNwfhkCK0Z8UCi46pV+uHNekULCY4/0U7rpw=;
        b=GIlrDHbtx+g7CxOye5B0bT+aDzdTA60rSaTQ7BOJFXV4AhjoNhQOAIB6NZ3n9emQYuDnA4
        PdVUs+GnGDh04hlZfQLDoW3lynqo5Zx9b8GtVDXt8BI4+avrxrJRuVJwVE+MpcJYCbZy2o
        3UIZGiUkSki4vy16GzrAeDnROVHiRtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-uxWh6hrgNLCWG_BsrcN2BA-1; Wed, 16 Jun 2021 05:36:39 -0400
X-MC-Unique: uxWh6hrgNLCWG_BsrcN2BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FBC1084F4C;
        Wed, 16 Jun 2021 09:36:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E92D8E73C;
        Wed, 16 Jun 2021 09:36:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-5-willy@infradead.org>
References: <20210614201435.1379188-5-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 04/33] mm/vmstat: Add functions to account folio statistics
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <811827.1623836195.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 16 Jun 2021 10:36:35 +0100
Message-ID: <811828.1623836195@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Allow page counters to be more readily modified by callers which have
> a folio.  Name these wrappers with 'stat' instead of 'state' as requeste=
d
> by Linus here:
> https://lore.kernel.org/linux-mm/CAHk-=3Dwj847SudR-kt+46fT3+xFFgiwpgThvm=
7DJWGdi4cVrbnQ@mail.gmail.com/
> No change to generated code.
> =

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

