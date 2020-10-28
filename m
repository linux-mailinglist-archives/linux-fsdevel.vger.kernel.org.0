Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB029DCD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgJ1W2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733256AbgJ1W1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0h+flQgRyOo5zRJQkxKmDTKn+RKN2hYzp8ToCDWH/6Y=;
        b=X+xQ59/VtGJREj+ErStGrVXvAHLp6ykzIJyGjQmY2E84Sf5cFQRgno884HsVRReq1qBhoU
        u4UDmPdciVVx/RmnkRRY3GDsm2AqDAjVaj02jBZ+3ygEqiiADO+LrCpFjSBcwTyzJwnSoy
        LUeuJeb74jAt7sMvjKA3bH+Sdc6ZBOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-W-rgf9SBPE6VNEzhAMjuQA-1; Wed, 28 Oct 2020 11:24:39 -0400
X-MC-Unique: W-rgf9SBPE6VNEzhAMjuQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93EF4108E1A6;
        Wed, 28 Oct 2020 15:24:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC16D5D9EF;
        Wed, 28 Oct 2020 15:24:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201028142041.GZ20115@casper.infradead.org>
References: <20201028142041.GZ20115@casper.infradead.org> <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk> <160389422491.300137.18176057671220409936.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] afs: Fix to take ref on page when PG_private is set
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <442539.1603898676.1@warthog.procyon.org.uk>
Date:   Wed, 28 Oct 2020 15:24:36 +0000
Message-ID: <442540.1603898676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> There's an efficiency question here that I can't answer ... how often do
> you call afs_write_begin() on a page which already has PagePrivate set?

That's a question only userspace can answer - but think shell scripts that do
lots of small appends.

David

