Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90934443AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhKCOhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 10:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhKCOhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635950085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBt63SHG96A9DgD47p6bvc+4BuRpJkNrq/VWF2GMPR0=;
        b=GRGnS+Lb1CYzKJSTnc2DEymA7wv8bg6uezpBnpCmIkclIG3H+G3GLncYCfizg4BXDymMMR
        XMjP7R5zbAV6bVjeFKOy2qCsua/CK4pSRtJEo7i5X++pcGBWbCF0u+OIA9vtlK1UEMA8Wl
        EIU342PRrN1vjrky2+VfABvwzAyKIVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-NU2BJUTbNw2ManfRoqAm1g-1; Wed, 03 Nov 2021 10:34:40 -0400
X-MC-Unique: NU2BJUTbNw2ManfRoqAm1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D93800053;
        Wed,  3 Nov 2021 14:34:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5F115F4EA;
        Wed,  3 Nov 2021 14:34:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YYKLkBwQdtn4ja+i@casper.infradead.org>
References: <YYKLkBwQdtn4ja+i@casper.infradead.org> <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk> <163584184628.4023316.9386282630968981869.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] folio: Add a function to get the host inode for a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1037301.1635950073.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 03 Nov 2021 14:34:33 +0000
Message-ID: <1037302.1635950073@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > + * For folios which are in the page cache, return the inode that is h=
osting
> > + * this folio belongs to.
> =

> This looks like an editing mistake.  Either you meant
> 'return the inode that hosts this folio' or
> 'return the inode this folio belongs to'
> (and i prefer the second).

Yeah - I'll go with that.

David

