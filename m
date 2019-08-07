Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B878552C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 23:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfHGVbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 17:31:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfHGVbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:31:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so42843671pgj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQJ8f3sbtpxQFwytiN3eHpksnWvvNOcO2e4/JMupkqc=;
        b=ltUuSGLnwli7uHEKMbcJ+YOm7vx0HT8aK0FqET7xYC6vzOpSEUHRN/AATglHk0+0p+
         zSnAx29U8WuLTI9ExqxwFzPZmo0mHUqAjMn2RgZOIpvSFf2FTljKhjOmlz/PX2bEMaRC
         lFE+Jq8IidL4IM+nVDmMMflaOTHFIJmzC3aOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQJ8f3sbtpxQFwytiN3eHpksnWvvNOcO2e4/JMupkqc=;
        b=egghQaMxev0g78xr5AC9oYZU9C3NkGs1rYlANJOX4LM12Q8jgiY23mS2Po5grnFZCc
         /Jm2CDg0c+38OKQtV1lbGTmp+ycOoLb//NAwFhtZr7yldc/w0QnqVpeWRQwy7yVM3036
         vFQOLwiyD0533Wn6BUHFchjtbAvWsZ8OCRzpy57QN2RHOjOwRx7AMt9xxrH1zp4h2hyL
         eCsslBM6U/subKhdBd+QLXjSY5VdHGiP6rXCZI3+CgVSQqhaU1eAW0IJ9lMZ20A4e5zc
         K2bLSWgzucslKhI50547pmAnSLS/S+xTJzaYUrgQnogekfaNQl/kS++n2GRAkE/LR/Zt
         /2WQ==
X-Gm-Message-State: APjAAAUEQ+sP7LI45e37RK59CMwgVu7RewNE1MVJwz+q+gJ7dH2WkWaA
        q2roh3N4FePiSywqRyFxJ16Nnw==
X-Google-Smtp-Source: APXvYqycwCSZRxiQZg5b6w8u5vo5c0fzV5zhn+ILS/tJqsI66etCit/pYaYlIq/y8q2Rld0VAf6CWw==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr11549407pfa.76.1565213468077;
        Wed, 07 Aug 2019 14:31:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a6sm92456750pfa.162.2019.08.07.14.31.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:31:07 -0700 (PDT)
Date:   Wed, 7 Aug 2019 17:31:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190807213105.GA14622@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
 <20190807204530.GB90900@google.com>
 <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:58:40PM -0700, Andrew Morton wrote:
> On Wed, 7 Aug 2019 16:45:30 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Aug 07, 2019 at 01:04:02PM -0700, Andrew Morton wrote:
> > > On Wed,  7 Aug 2019 13:15:54 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > > 
> > > > In Android, we are using this for the heap profiler (heapprofd) which
> > > > profiles and pin points code paths which allocates and leaves memory
> > > > idle for long periods of time. This method solves the security issue
> > > > with userspace learning the PFN, and while at it is also shown to yield
> > > > better results than the pagemap lookup, the theory being that the window
> > > > where the address space can change is reduced by eliminating the
> > > > intermediate pagemap look up stage. In virtual address indexing, the
> > > > process's mmap_sem is held for the duration of the access.
> > > 
> > > So is heapprofd a developer-only thing?  Is heapprofd included in
> > > end-user android loads?  If not then, again, wouldn't it be better to
> > > make the feature Kconfigurable so that Android developers can enable it
> > > during development then disable it for production kernels?
> > 
> > Almost all of this code is already configurable with
> > CONFIG_IDLE_PAGE_TRACKING. If you disable it, then all of this code gets
> > disabled.
> > 
> > Or are you referring to something else that needs to be made configurable?
> 
> Yes - the 300+ lines of code which this patchset adds!
> 
> The impacted people will be those who use the existing
> idle-page-tracking feature but who will not use the new feature.  I
> guess we can assume this set is small...

Yes, I think this set should be small. The code size increase of page_idle.o
is from ~1KB to ~2KB. Most of the extra space is consumed by
page_idle_proc_generic() function which this patch adds. I don't think adding
another CONFIG option to disable this while keeping existing
CONFIG_IDLE_PAGE_TRACKING enabled, is worthwhile but I am open to the
addition of such an option if anyone feels strongly about it. I believe that
once this patch is merged, most like this new interface being added is what
will be used more than the old interface (for some of the usecases) so it
makes sense to keep it alive with CONFIG_IDLE_PAGE_TRACKING.

thanks,

 - Joel

