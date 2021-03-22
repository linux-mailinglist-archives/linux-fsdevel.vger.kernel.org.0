Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C3343CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCVJ1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 05:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhCVJ1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616405255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HYs/PB5ZvBoFnReuIbosdcSKvzup9kFmar9FwoHO/k=;
        b=NePOokCAm/5u8EQTD9NwO9+naJ5SIdTjJj6Pue9sVmy6+3ZhFIHW+jguaboTH5oJylMq0G
        HABASn+npDZy+aTDxr4cl0XlIWeMmquRbrYK7jyO/nsnseGslq4V1vKhWW/eVz8kKdV4Or
        k1G6MEA6ZHF/MjUOa54oJb+rxMvL090=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-PE7Ae_k1N0iWzuyUF0vbaw-1; Mon, 22 Mar 2021 05:27:32 -0400
X-MC-Unique: PE7Ae_k1N0iWzuyUF0vbaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72AEE84E20A;
        Mon, 22 Mar 2021 09:27:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1518F6A03C;
        Mon, 22 Mar 2021 09:27:26 +0000 (UTC)
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
Content-ID: <1878263.1616405246.1@warthog.procyon.org.uk>
Date:   Mon, 22 Mar 2021 09:27:26 +0000
Message-ID: <1878264.1616405246@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Open-coding this function meant it missed out on the recent bugfix
> for waiters being woken by a delayed wake event from a previous
> instantiation of the page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-and-tested-by: David Howells <dhowells@redhat.com>

Should this be pushed upstream now as well if it's missing out on a bugfix?

