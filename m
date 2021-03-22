Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AF343CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVJ0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 05:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhCVJZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616405148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM5PYcagQbtDg3NrFzWha9n5u8jY/mxXCcbX0fzIUlk=;
        b=Jf/p0uMltl/O21PvjfHNUkl+Mj7d4iTnz4QfGJxPMSh0dnia6s/mXCN+zilemIKExdoQ4z
        z+1llgHa4oN0qNHjQ/sILE+naKjdMSzbq13B0lL7m888yaYg52BPNXDYTYXc6CjxDmLYPT
        6T4V9WcVaH/KJ3OvxzOsRLen24FTdlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-c39_QNLyMOaD17Z6n2Owsg-1; Mon, 22 Mar 2021 05:25:45 -0400
X-MC-Unique: c39_QNLyMOaD17Z6n2Owsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65115108BD06;
        Mon, 22 Mar 2021 09:25:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAD2B2CE8A;
        Mon, 22 Mar 2021 09:25:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210320054104.1300774-2-willy@infradead.org>
References: <20210320054104.1300774-2-willy@infradead.org> <20210320054104.1300774-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 01/27] fs/cachefiles: Remove wait_bit_key layout dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1878126.1616405135.1@warthog.procyon.org.uk>
Date:   Mon, 22 Mar 2021 09:25:35 +0000
Message-ID: <1878127.1616405135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Cachefiles was relying on wait_page_key and wait_bit_key being the
> same layout, which is fragile.  Now that wait_page_key is exposed in
> the pagemap.h header, we can remove that fragility
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-and-tested-by: David Howells <dhowells@redhat.com>

I wonder if this could be pushed directly to Linus now since we're relying on
two different structs being compatible.

