Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D73E8443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhHJUYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232824AbhHJUYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=apwsP+AC9v1VLvfj7h0q3HUR5973rn4Zs3StHw6qQA0=;
        b=bWC+fowRZJIANn47xWu97uv6w1TY+136UCScBhKzjFBlLEAXSscJ1c0KlfjBhpKukZ4FeO
        Vi/4BDwm6D4f0X3yoqWRAEGsnzpsAiAvUiMYpV7S2Ct2oIJhfee0C4+VvcbKwnyXo+SO1m
        dEDRCuc736/xtmi/5mk3EFAT3AJFGK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-Y9Pj2A6fPtK2pmP7RbjONQ-1; Tue, 10 Aug 2021 16:23:55 -0400
X-MC-Unique: Y9Pj2A6fPtK2pmP7RbjONQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A00C801B3D;
        Tue, 10 Aug 2021 20:23:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 847F0669ED;
        Tue, 10 Aug 2021 20:23:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-43-willy@infradead.org>
References: <20210715033704.692967-43-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 042/138] mm/memcg: Convert mem_cgroup_uncharge() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810385.1628627031.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:23:51 +0100
Message-ID: <1810386.1628627031@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert all the callers to call page_folio().  Most of them were already
> using a head page, but a few of them I can't prove were, so this may
> actually fix a bug.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

