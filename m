Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4988B3E8549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhHJVax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233785AbhHJVax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ty+ydYn1pML2P/TxDV/t1IRGgO3smk0UHuoRcYPGPk=;
        b=SfWItrccXc+fzUuvg2zVmDVIPhluUYTgMDocziRBw+rPz8teLUul06rs5mb+ZgYRuwpin+
        Ff+30rJ6bY/K5h1YLOeRzOaK5AiNnjq/R5A+a7QtgI5nvRlIVgxxAXxPA3qxLWdiZZmGlU
        ZhqcRb6HwHbChu1TW1H13w6NqlIbwgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-CAwpK4s2MB2ow40EJgENLA-1; Tue, 10 Aug 2021 17:30:28 -0400
X-MC-Unique: CAwpK4s2MB2ow40EJgENLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319ED8799E0;
        Tue, 10 Aug 2021 21:30:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3754C60BF1;
        Tue, 10 Aug 2021 21:30:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-79-willy@infradead.org>
References: <20210715033704.692967-79-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 078/138] mm/filemap: Add folio_mkwrite_check_truncate()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813577.1628631024.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:30:24 +0100
Message-ID: <1813578.1628631024@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is the folio equivalent of page_mkwrite_check_truncate().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

