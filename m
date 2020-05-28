Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48231E66D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404769AbgE1Pya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:54:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404764AbgE1Py3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590681267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/lhFX5r9PT7zuGJP+y6HDeEE7b6YUf1DyVHHqpeTzk=;
        b=d3meHbSJuPUJyxfsg26xfFz4W/oXnkpI4dN9Do2huC/sgbKHkspa1YopK4lnkY4aDjjZAL
        70x7VFCS1B1GjyvE0++vJkH/IDU0s2Sopxf7MP/E16MFVUGDr/+oIMaaRQUhBYEKC9+ht6
        xbMafogpSJfY3xqdigvbrbunnO9l4Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-FAkJZ9wIOj-olFhGYfr0Yw-1; Thu, 28 May 2020 11:54:17 -0400
X-MC-Unique: FAkJZ9wIOj-olFhGYfr0Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CA9100CCC1;
        Thu, 28 May 2020 15:54:15 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AE4A394E;
        Thu, 28 May 2020 15:54:12 +0000 (UTC)
Date:   Thu, 28 May 2020 10:54:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200528155409.vv3zzxov7qn4ohna@treble>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 08:32:22AM -0700, Randy Dunlap wrote:
> On 5/13/20 8:31 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-05-13-20-30 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> 
> on x86_64:
> 
> arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
> arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled

Randy,

I wasn't able to recreate this one.  If you can still do so, can you
share the .o file?

-- 
Josh

