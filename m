Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94503A97BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhFPKkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232561AbhFPKkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18UYC34LO482T5e/LOQVLpAiVeD6lKSvaD2c4N3RCHU=;
        b=gDtULYZMMm7xNPn7DG8LATn1WPYdbNQdIT7BOFxF+7E0Rz578LEL0EacLv+kaj5PSbv1X6
        deK7rfujzewk28tCn86yTXsGmTg3SNX9j50UF6pqFj/25tQ2fEZ5vnWqijMYwvlh3GQ9RU
        Xb8QRIMvOx71DMww+qUta4iQp8QoFC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-ERrAuzyUOG6kh7AfBGBWHQ-1; Wed, 16 Jun 2021 06:37:52 -0400
X-MC-Unique: ERrAuzyUOG6kh7AfBGBWHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080949126F;
        Wed, 16 Jun 2021 10:37:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A23F263B8C;
        Wed, 16 Jun 2021 10:37:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-34-willy@infradead.org>
References: <20210614201435.1379188-34-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 33/33] mm: Add folio_mapped()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <816367.1623839868.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:37:48 +0100
Message-ID: <816368.1623839868@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This function is the equivalent of page_mapped().  It is slightly
> shorter as we do not need to handle the PageTail() case.  Reimplement
> page_mapped() as a wrapper around folio_mapped().  folio_mapped()
> is 13 bytes smaller than page_mapped(), but the page_mapped() wrapper
> is 30 bytes, for a net increase of 17 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

