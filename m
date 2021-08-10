Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098C53E8476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhHJUkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhHJUkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628628002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EuPUdq45S8oTL3THA/Ef2LivSA8dQ3PVd0haAKDU0tU=;
        b=hj+K3oy1BepW/QOeBVbw2+yUXBVzHQwoAokLdKsCe9XsrkoyyvsSgp7vEvhAttkhJNK0c7
        4kBZoShORCXoivZDYkiD4a3Zw2iNn552n7uFp9FtXuTb90FC22eSCB11XYIs0olwRZ1gND
        3CndcUqLtHv9dvaLpHUUKsbkOS+4b88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415--cFXP4rTOFegIKKrE7j5_g-1; Tue, 10 Aug 2021 16:40:00 -0400
X-MC-Unique: -cFXP4rTOFegIKKrE7j5_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E6A801AEB;
        Tue, 10 Aug 2021 20:39:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3A95C1A1;
        Tue, 10 Aug 2021 20:39:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-52-willy@infradead.org>
References: <20210715033704.692967-52-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 051/138] mm: Add folio_pfn()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811154.1628627997.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:39:57 +0100
Message-ID: <1811155.1628627997@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is the folio equivalent of page_to_pfn().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

