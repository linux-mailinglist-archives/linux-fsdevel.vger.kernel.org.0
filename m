Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDA3E85E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhHJWGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 18:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234814AbhHJWGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628633140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KlRVFcfsiPZEuz6J4GfZil/2Tt8hvbgnI3Yitqd2JX8=;
        b=Szp7AY3+hXusnbKiXuqqY2FdcoKMWBUdkKCKk7EtljROb9Xheubk0XiYgrR1vaYaLPRMYK
        w3vVP9fDRisEbRmpyoG10JaQf043MPhT/V7nWCdp2vriU91jz8GWaAx4xrUcHVSeEezN+z
        M6+zwGm5Yoqp4lT5qKP3BvUQejZPSrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-fMf0dIkKOKW7rilvcogtaw-1; Tue, 10 Aug 2021 18:05:36 -0400
X-MC-Unique: fMf0dIkKOKW7rilvcogtaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8258042EB;
        Tue, 10 Aug 2021 22:05:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 854FC5D9CA;
        Tue, 10 Aug 2021 22:05:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-89-willy@infradead.org>
References: <20210715033704.692967-89-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 088/138] mm/filemap: Add filemap_get_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1815134.1628633133.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 23:05:33 +0100
Message-ID: <1815135.1628633133@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> filemap_get_folio() is a replacement for find_get_page().
> Turn pagecache_get_page() into a wrapper around __filemap_get_folio().
> Remove find_lock_head() as this use case is now covered by
> filemap_get_folio().
> 
> Reduces overall kernel size by 209 bytes.  __filemap_get_folio() is
> 316 bytes shorter than pagecache_get_page() was, but the new
> pagecache_get_page() is 99 bytes

longer, one presumes.

> .
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

