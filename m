Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7351240ECFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhIPV7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 17:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240317AbhIPV7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631829492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7+YMmIXw9LQayHd2lCNryDpntnlyqVSMgHcgd/qI8Y=;
        b=LNn9UwcqXSC0tABIv6z738cxKLe3V5RQzOpfboLuAPllFcYB5GVKIowntweZdsQKVyf9z7
        nGugZU+usIMw2JdZAmq03+CIH1Tg7pZQr10CXfjKlO6UOpvydhA5tXjgT8fIaYjm1Ubu9t
        RhQxmXnn99nJ7vNUt3X3QawYIePA1Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-xq4bETqxNqyM7wgCNTkOHw-1; Thu, 16 Sep 2021 17:58:11 -0400
X-MC-Unique: xq4bETqxNqyM7wgCNTkOHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18DD2801B3D;
        Thu, 16 Sep 2021 21:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E299C5FCA6;
        Thu, 16 Sep 2021 21:58:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YUN2vokEM8wgASk8@cmpxchg.org>
References: <YUN2vokEM8wgASk8@cmpxchg.org> <YSPwmNNuuQhXNToQ@casper.infradead.org> <YTu9HIu+wWWvZLxp@moria.home.lan> <YUIT2/xXwvZ4IErc@cmpxchg.org> <20210916025854.GE34899@magnolia>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     dhowells@redhat.com, "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Folio discussion recap
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1791362.1631829486.1@warthog.procyon.org.uk>
Date:   Thu, 16 Sep 2021 22:58:07 +0100
Message-ID: <1791363.1631829487@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> I know Kent was surprised by this. I know Dave Chinner suggested to
> call it "cache page" or "cage" early on, which also suggests an
> understanding of a *dedicated* cache page descriptor.

If we are aiming to get pages out of the view of the filesystem, then we
should probably not include "page" in the name.  "Data cache" would seem
obvious, but we already have that concept for the CPU.  How about something
like "struct content" and rename i_pages to i_content?

David

