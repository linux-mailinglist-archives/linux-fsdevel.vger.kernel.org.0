Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB13E840E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhHJUDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232782AbhHJUDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628625766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tP9KR03y9jO0pY7rOoxFwa8EoNvcGlojedWxVEx2WzA=;
        b=UMnXyorzAKgB6/HFIUbNt8E7bayoPyvUKkpPxNHET6a1rlhZCxvHbxieR3QUG3PHhWAfRb
        mWB1LfX/UxXXGQd7GlyKgsyyq5ofT1vP1vJJYn0poI5rFTN7baH7wY1VMwwYngQMcNKnPL
        DUyWhwqaQF8nwSa/qtQ241ngEUZ6C/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-n5QRzA43N3qI08TA4HOSOw-1; Tue, 10 Aug 2021 16:02:43 -0400
X-MC-Unique: n5QRzA43N3qI08TA4HOSOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 761781009600;
        Tue, 10 Aug 2021 20:02:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C86AD60BF1;
        Tue, 10 Aug 2021 20:02:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-35-willy@infradead.org>
References: <20210715033704.692967-35-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v14 034/138] mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809400.1628625757.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:02:37 +0100
Message-ID: <1809401.1628625757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The last use of 'page' was removed by commit 468c398233da ("mm:
> memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
> the parameter from the function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: David Howells <dhowells@redhat.com>

