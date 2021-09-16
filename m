Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4207340DBB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhIPNwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 09:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236213AbhIPNwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631800281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4lVrPdsoP5O/cM/OSAIFtewkyqRFucE9aREXO9piQ+4=;
        b=ggemZuBk+kMGJrsxLIgzNQ7aBWNaPzD2SoU63quAODI/JEC311SPu7G5BVTCY7NApJqLMe
        KeBLlhhVYATBgTxNpJyeUF1rpdo6g/ozW3PAzrG5fwWAHVPaW796aZV7B8YG9Ep7UjOlPa
        2BsBPp9F6E7tH0GeAXzB00NyKwb6qwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-wINEPB07OC23uIxFVwSC_g-1; Thu, 16 Sep 2021 09:51:18 -0400
X-MC-Unique: wINEPB07OC23uIxFVwSC_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A48100C660;
        Thu, 16 Sep 2021 13:51:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB6E5D9C6;
        Thu, 16 Sep 2021 13:51:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YUJcN/dqa8f4R9w0@mit.edu>
References: <YUJcN/dqa8f4R9w0@mit.edu> <YUIwgGzBqX6ZiGgk@mit.edu> <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com> <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com> <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers Summit topic?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1763246.1631800271.1@warthog.procyon.org.uk>
Date:   Thu, 16 Sep 2021 14:51:11 +0100
Message-ID: <1763247.1631800271@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:

> > My reading of the email threads is that they're iterating to an actual
> > conclusion (I admit, I'm surprised) ... or at least the disagreements
> > are getting less.  Since the merge window closed this is now a 5.16
> > thing, so there's no huge urgency to getting it resolved next week.
> 
> My read was that it was more that people were just getting exhausted,
> and not necessarily that folks were converging.

The problem, from where I sit, is that I'd started rebasing my stuff on top of
Willy's patches and making use of them in the expectation that they were
likely to go in - and I think other people might have been doing that too
based on some of the comments.

However, that's all been thrown up in the air.  Not only did they not get
merged in this window, it's not currently looking certain that they'd get
merged in the next window either.

So what do I do?  Do I defoliate my patches - which then risks merge conflicts
with the folio patches?  Or do I stick with the foliation and hope that
Willy's goes in next time?

Some guidance as to what's likely to happen to the folio patches would be
really appreciated!

David

