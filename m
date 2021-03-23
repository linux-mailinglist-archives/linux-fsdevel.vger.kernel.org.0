Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E58345CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCWLaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhCWLaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616499000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uA3R361pj1QpU9aKb+hlh9fO5r7oAvCIeL7X+xnjfCM=;
        b=WCuOC4e1oZq3zVxMlb2DKdXeckUtHrlSipMuz7Bc/FEpoQScQUr/i/V0R3Epd36Gtq1MmL
        BqihHWXDr1X+79wtCjocCD/vecA9MV7BT3PIcCR6gyXpyH6VSE/YwhovttCJDay4X7GbG7
        bh46S1e/RZLuzVQPUyGUOaEdahSbnQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-snVUSe3fMK-MgT2m7OMedQ-1; Tue, 23 Mar 2021 07:29:58 -0400
X-MC-Unique: snVUSe3fMK-MgT2m7OMedQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B4E190B2A1;
        Tue, 23 Mar 2021 11:29:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C717A6E706;
        Tue, 23 Mar 2021 11:29:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210320054104.1300774-4-willy@infradead.org>
References: <20210320054104.1300774-4-willy@infradead.org> <20210320054104.1300774-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 03/27] afs: Use wait_on_page_writeback_killable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2443201.1616498991.1@warthog.procyon.org.uk>
Date:   Tue, 23 Mar 2021 11:29:51 +0000
Message-ID: <2443202.1616498991@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Open-coding this function meant it missed out on the recent bugfix

Would that be:

	c2407cf7d22d0c0d94cf20342b3b8f06f1d904e7
	mm: make wait_on_page_writeback() wait for multiple pending writebacks

David

