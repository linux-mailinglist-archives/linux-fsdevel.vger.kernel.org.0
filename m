Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8EA3A68AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhFNOG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 10:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233293AbhFNOG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623679495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K18SaxL7pqOT5ezBYnXMObDqxTM59sv8KTPuqWaSQpg=;
        b=Nec6Q2ACmOsB5V4YOv71By30T2oiHFz0Zifet2LJ+3gcubHgbtafRkDCIU7O/sgIKk0T7w
        ykxPV1nlThmrcQP6TRSvYa7j2117RatafZs6TH+Y6devIaXcfJbleK2Rk1CyAkYhE0mXAy
        gT5TmzRLdrSxn6wVCHbt8KDs0FWI1tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--Yh-n_SOMT6GoVj9P0XwgA-1; Mon, 14 Jun 2021 10:04:54 -0400
X-MC-Unique: -Yh-n_SOMT6GoVj9P0XwgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D1B8015F8;
        Mon, 14 Jun 2021 14:04:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 795DF5C1A3;
        Mon, 14 Jun 2021 14:04:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YMddm2P0vD+4edBu@casper.infradead.org>
References: <YMddm2P0vD+4edBu@casper.infradead.org> <YMdZbsvBNYBtZDC2@casper.infradead.org> <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk> <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk> <466590.1623677832@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        jlayton@kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <468964.1623679490.1@warthog.procyon.org.uk>
Date:   Mon, 14 Jun 2021 15:04:50 +0100
Message-ID: <468965.1623679490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Al Viro made such a change for Ceph - and we're writing, not reading.
> 
> I'd feel better if you said "xfstests doesn't show any new problems"
> than arguing to authority.

I'm kind of referring it to Al - I added him to the to: list.  And xfstests
doesn't show any new problems - but that doesn't mean that this path got
tested.

David

