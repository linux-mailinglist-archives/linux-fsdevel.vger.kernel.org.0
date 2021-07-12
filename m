Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D33C5EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhGLPYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 11:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhGLPYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626103293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4AyPW2hg2NEBE9g0AG+jjWOdZjnn7OtGrKXLoX3xsM=;
        b=R3suBad6734OjoLuilfk6Tq7kgOBCEK9rQrcX10DOWlctF5RPXJMFPgPjmQECY46r6iDAj
        d/Rva3OesvNM/1pTBYCFjdyU9M62nBDtDnkRyoe77oMrA1oDXIDtGMnt9GGnUYwZ9BBeUQ
        gdyQDnLpGfIVHxuNGu/lw3x4HchmnjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-G2K1CvugPUGxclwLniksiQ-1; Mon, 12 Jul 2021 11:21:29 -0400
X-MC-Unique: G2K1CvugPUGxclwLniksiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A889B362F8;
        Mon, 12 Jul 2021 15:21:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B84760C17;
        Mon, 12 Jul 2021 15:21:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com>
References: <CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com> <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk> <162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk>
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        Tom Rix <trix@redhat.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] afs: check function return
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3360494.1626103286.1@warthog.procyon.org.uk>
Date:   Mon, 12 Jul 2021 16:21:26 +0100
Message-ID: <3360495.1626103286@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Marc Dionne <marc.c.dionne@gmail.com> wrote:

> > @@ -777,7 +777,7 @@ int afs_writepages(struct address_space *mapping,
> >                 mapping->writeback_index = next / PAGE_SIZE;
> 
> Isn't there the same issue with the use of next here.

Good point.

> >                         mapping->writeback_index = next;
> 
> Unrelated to this patch, but since next is a byte offset, should this
> also divide by PAGE_SIZE as above.

Also a good point.  I'll whip up a separate patch for that.

David

