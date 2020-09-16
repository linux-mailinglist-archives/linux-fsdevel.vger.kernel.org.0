Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B426CB6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPU1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgIPRYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIDNYXiU2iGbO/F9JK0prHUpFcyTmc8uGMG0d6uO9go=;
        b=DJHrLAJTK9asrU8CWApV8apdtDzQf4dG6rB6I6D7ulUnZMkXGDkqNkGDkjCasYqFbdXX+E
        RivWxB79wOOBECrSkoZdWHvO1JWZDkgnvbV7uMvoegsEMkJBlzkrXBIWLfTpb8oB70gWLD
        ZI94Sbvs3BHfSaFxE0570maJ4pMHIxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-vMiOjr13O8uH-OJWC3YD5w-1; Wed, 16 Sep 2020 13:24:17 -0400
X-MC-Unique: vMiOjr13O8uH-OJWC3YD5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E405A107464B;
        Wed, 16 Sep 2020 17:24:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9499E60BFA;
        Wed, 16 Sep 2020 17:24:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08GHOEOU016676;
        Wed, 16 Sep 2020 13:24:14 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08GHOCwu016672;
        Wed, 16 Sep 2020 13:24:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 16 Sep 2020 13:24:12 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] pmem: export the symbols __copy_user_flushcache and
 __copy_from_user_flushcache
In-Reply-To: <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 16 Sep 2020, Dan Williams wrote:

> On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > I'm submitting this patch that adds the required exports (so that we could
> > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > it for the next merge window.
> 
> Why? This should go with the first user, and it's not clear that it
> needs to be relative to the current dax_operations export scheme.

Before nvfs gets included in the kernel, I need to distribute it as a 
module. So, it would make my maintenance easier. But if you don't want to 
export it now, no problem, I can just copy __copy_user_flushcache from the 
kernel to the module.

> My first question about nvfs is how it compares to a daxfs with
> executables and other binaries configured to use page cache with the
> new per-file dax facility?

nvfs is faster than dax-based filesystems on metadata-heavy operations 
because it doesn't have the overhead of the buffer cache and bios. See 
this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS

Mikulas

