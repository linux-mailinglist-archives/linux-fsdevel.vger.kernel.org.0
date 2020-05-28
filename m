Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159571E688C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405505AbgE1RUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 13:20:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33963C08C5C6;
        Thu, 28 May 2020 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s1IXw8Twd2kdKrDd1HQy17LRiidIo6BNwR5yWekBZs8=; b=gi6/TE78wMNosleSSXyJToQtTf
        VPE3tMvPQ1EZarGtzAiZQFW2khOCOa5YAYJGn8kyf4yEBtOW1N3V/zWuoe/2pi5W0c83ZKNHvDqSV
        /XdxPCk0KYP2b3/f2758unr+G76cNAHyuBdOS+tAQ+lEedtN5NvuFkVlcN2rQhbhVWFQ25L9xg4wU
        MoQzj1e+HJ7beYrcHGZHrZtzhMtQr8Vn7ABE0B9YY5lS/OcRY5FP3gAqIrmX63K0JKrBDW6svmdmy
        J+oQsjOpUF5aKgMNBr1i7GCOcqOr7/ZD4T1GHA3tMY00meCBwuo0FaqwhUAAtymqmMEpKSHcZTfjQ
        Bdy1gz8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeMCO-000547-02; Thu, 28 May 2020 17:20:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A856C9836F8; Thu, 28 May 2020 19:20:05 +0200 (CEST)
Date:   Thu, 28 May 2020 19:20:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@ZenIV.linux.org.uk, hch@lst.de, x86@kernel.org
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200528172005.GP2483@worktop.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Urgh, that's horrible code. That's got plain stac()/clac() calls on
instead of the regular uaccess APIs.

Anybody any clue about what the best way forward here is?

Also, I wonder how we get at memset() with AC set,..
