Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAB3E851C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhHJVUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233785AbhHJVUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbBsqE5E2tugwxtBa6xA2bpuYwiRlnVA8iQZujStbxk=;
        b=iwXJ0UbE1Ta+GaSMgTfAA37L4D3LIwzVRHTG2ch+C7EVvI+z5E1bMLOiVGXbcqsFRtnWhO
        lJoG7Hy7tnca1ISDBh9IGaGzPYD5D3Da9bCkHZKasFeJz6IMvMs4ouKZUmQIF5h33a1BdX
        dm8joqrVT/Lrm+UaSjHsb7XVicNcPn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-spmMtCWsNSmNKkE49r2ESg-1; Tue, 10 Aug 2021 17:19:57 -0400
X-MC-Unique: spmMtCWsNSmNKkE49r2ESg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB9D1853029;
        Tue, 10 Aug 2021 21:19:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF2535D740;
        Tue, 10 Aug 2021 21:19:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-71-willy@infradead.org>
References: <20210715033704.692967-71-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 070/138] mm/writeback: Convert tracing writeback_page_template to folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813046.1628630394.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:19:54 +0100
Message-ID: <1813047.1628630394@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Rename writeback_dirty_page() to writeback_dirty_folio() and
> wait_on_page_writeback() to folio_wait_writeback().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

