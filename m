Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064E33E8518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhHJVTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233821AbhHJVTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnxCt8QWZgAhjEG2eKWaY7Qim4IZ3G3PhV73vNy+RzQ=;
        b=EsTlEwQpdHMd9EV4URYpuaB3a5tq+4opD7/bzZwhZKxSmkDEuVFne3Mp8eB8oqkum3/Ac9
        RvVnwe1NtJbiM1WNQXvPrv5MFaWAUtHXYMBnW7kM2TVjPRFiaW5ZTQzxTwDf9ka7S6okRG
        bSTLpy9+QlQl5tOIRJYYVRrKAY9wLJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Iax4_KXDNKuQfYbevFwUug-1; Tue, 10 Aug 2021 17:19:10 -0400
X-MC-Unique: Iax4_KXDNKuQfYbevFwUug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E3B15A08D;
        Tue, 10 Aug 2021 21:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 401C7669F3;
        Tue, 10 Aug 2021 21:19:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-70-willy@infradead.org>
References: <20210715033704.692967-70-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 069/138] mm/writeback: Add __folio_mark_dirty()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813002.1628630345.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:19:05 +0100
Message-ID: <1813003.1628630345@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Turn __set_page_dirty() into a wrapper around __folio_mark_dirty().
> Convert account_page_dirtied() into folio_account_dirtied() and account
> the number of pages in the folio to support multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

