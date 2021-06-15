Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C203A7DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFOMFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 08:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230179AbhFOMFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623758630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2Ni9+cw0tnXNVdw4RqCqoRUHbdvK7otr3HFN81fzT0=;
        b=fNEnJxxGGuD36u75+gBOisvITNEZgA4yZIAssno003CoJsR8fokmabp6BnJ+6MQmMmnHBR
        F7jZmoBPIvgQw9e2xqcsC7PF4GpDN/rpHhKYw84Hli+iahW0vbLnCeBPEWoJ6DKfZr2LFC
        ZvY3LSaETJPBN6wjd5sP75QNCf9DdqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Y4fgjC7NPY-rsSMgNj19ZA-1; Tue, 15 Jun 2021 08:03:49 -0400
X-MC-Unique: Y4fgjC7NPY-rsSMgNj19ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 907CF800D55;
        Tue, 15 Jun 2021 12:03:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC25C60861;
        Tue, 15 Jun 2021 12:03:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        marc.dionne@auristor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <654874.1623758571.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Tue, 15 Jun 2021 13:03:45 +0100
Message-ID: <654943.1623758625@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Note that this isn't really a fix, so can wait to the next merge window if you
prefer.

David

