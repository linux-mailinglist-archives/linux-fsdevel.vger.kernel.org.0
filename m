Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9265583442
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfHFOsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 10:48:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbfHFOsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:48:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so41637354pfl.3;
        Tue, 06 Aug 2019 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPKj1q9pzAw01F3LuwbWC2NJPbuIQVTFZWSZ1tXqf8g=;
        b=QJ2Cxb8mgxyBmBWFhf+Q6WKHeahBHKbgCHhSNQaP7XebbA7RxANJ+gPXMpYWZCcMSu
         X359Nf5xHy+rw4UZX4hMjsVID68kwhu4AqXw7NM/rCH4HqG+ZDOo5A5SAswJAMLlEJK8
         z7yFfZyf/V+gepSBrVsmRbdzILbhwZtR1o1W4fb6SKsWY3NHkX3qpRxDA2HxO6BGES9y
         7Qu4NWlphGVXGI6g6CukvGsD2JQ+Nz4GEb7FiYPGqmYJMTe0BmSKOTXNkgyOg7WD/Aw6
         4M1QqWSg1xq7Cal5OUE8Rp+Rt9jVJd04zrvUG6ifgzm+idylAD6YNxfXOLHqgvOdlUn2
         Iq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPKj1q9pzAw01F3LuwbWC2NJPbuIQVTFZWSZ1tXqf8g=;
        b=K2WMk6WWHTsTERuVMC7kv09GFMyYcLFY5BFUux7z2uUr+3hePWprl6pTKaMS43E8pJ
         ogsDWQDYiqD3zZXRaX7ZFfgCo0oEJyDscfGCY0Kepo8DXPLwNs36mXtEuueakAiBVBoM
         cNlvF0eyNoWzaytsGpuFeVvbGZkg3eduqTM1lzkzXu81y6LwvU0HI12nfCUhCXVWvcsB
         3p+zcRgzFQ7goSarzAljD0hqd7rfIbutlyiBstrTBgT+o4q1Cv8bhABYH22nGwPQIHpx
         9AZXNMPqPxu+qdUi8tlxIu95JXT5uzcBifJLYpmlCyUIfp7r1BTkJfvWOEk472v2kbjV
         QIfg==
X-Gm-Message-State: APjAAAXxuWRtNTSa56bSFuCeVozeLzLyADpieyh5ZLYehgyIaaHPEPLt
        ubfk6YfNfeBEayMyBCDhXfc=
X-Google-Smtp-Source: APXvYqykjh8W3ip+qMmEJ9I/374nqTdJG5EsvPbtew94zlKNiZ7NYnx4nG7TA1fgWOgH43oAutyB7w==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr3320797pgm.265.1565102881165;
        Tue, 06 Aug 2019 07:48:01 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id r12sm72175100pgb.73.2019.08.06.07.47.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 07:47:59 -0700 (PDT)
Date:   Tue, 6 Aug 2019 23:47:47 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806144747.GA72938@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806111446.GA117316@google.com>
 <20190806115703.GY11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806115703.GY11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:57:03PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 07:14:46, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> > > On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > > > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > > > This bit will be used by idle page tracking code to correctly identify
> > > > > > if a page that was swapped out was idle before it got swapped out.
> > > > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > > > since the page frame gets unmapped.
> > > > > 
> > > > > And why do we need that? Why cannot we simply assume all swapped out
> > > > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > > > right? Or what does idle actualy mean here?
> > > > 
> > > > Yes, but other than swapping, in Android a page can be forced to be swapped
> > > > out as well using the new hints that Minchan is adding?
> > > 
> > > Yes and that is effectivelly making them idle, no?
> > 
> > That depends on how you think of it.
> 
> I would much prefer to have it documented so that I do not have to guess ;)
> 
> > If you are thinking of a monitoring
> > process like a heap profiler, then from the heap profiler's (that only cares
> > about the process it is monitoring) perspective it will look extremely odd if
> > pages that are recently accessed by the process appear to be idle which would
> > falsely look like those processes are leaking memory. The reality being,
> > Android forced those pages into swap because of other reasons. I would like
> > for the swapping mechanism, whether forced swapping or memory reclaim, not to
> > interfere with the idle detection.
> 
> Hmm, but how are you going to handle situation when the page is unmapped
> and refaulted again (e.g. a normal reclaim of a pagecache)? You are
> losing that information same was as in the swapout case, no? Or am I
> missing something?

If page is unmapped, it's not a idle memory any longer because it's
free memory. We could detect the pte is not present.

If page is refaulted, it's not a idle memory any longer because it's
accessed again. We could detect it because the newly allocated page
doesn't have a PG_idle page flag.

Both case, idle page tracking couldn't report them as IDLE so it's okay.
