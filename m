Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918CD3A95EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhFPJVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231489AbhFPJVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623835174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qumv7jbVw+hxWVCUJgAAifjH3q12vZ4JPKnNlTv8Q/k=;
        b=EuaTEYPkKLYpFyvhCmkXEKF+dPDZwACys5ibTygW663oV3Bn6rm9IhqDJbAhT9fr6ItGQk
        /W3XeeMRaTVwtuutSphcADQE5BSBBYuw5Nm7ijGe4lOk223qoQ4N9y80q4Lhtez+Yq2mwb
        BbFJmeHV5fqF+dt3njdFNoJ/gYpAQbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-J2Uk_XPePa2fVOX2u6zVNw-1; Wed, 16 Jun 2021 05:19:31 -0400
X-MC-Unique: J2Uk_XPePa2fVOX2u6zVNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625741012581;
        Wed, 16 Jun 2021 09:19:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E61C61094;
        Wed, 16 Jun 2021 09:19:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-2-willy@infradead.org>
References: <20210614201435.1379188-2-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/33] mm: Convert get_page_unless_zero() to return bool
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <810911.1623835168.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 10:19:28 +0100
Message-ID: <810912.1623835168@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

