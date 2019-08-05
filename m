Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A87813B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfHEHz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 03:55:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40266 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:55:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so36087898pla.7;
        Mon, 05 Aug 2019 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GBNssX1bMqNwZuTT2aXjIxOqWduoE+LBh8Ztzf4N6oQ=;
        b=tm6N87dhYHIAEbxEoy1HHkioi5rH39Ke3r/VrlQqfkwdGu1vwyKT4LOes5F3vdfzRZ
         QXx6rq30FRBNIUF3tG4TcybP/rP/ADn3UWG54enC6hq5D4PWuLkfjvgKa5Wo+xt5GeIS
         UUWEyThwWTZ8b96DfSdDD+im57ytDv+o9v9QpWWXMG1dQ3fGMa3XfHtp54FktA2xO/0q
         NLiBXKd7Jrs2mJxD1aRn5yDijrYQ1iH2gAFLgbSDXb1o/n0TYYt9yedrcGYp2a+Xc+YQ
         hBBbcpZGFswP55MSgnjuHvZKFbQ4h0/5H5b+SD6Igezo9aOdxOqXFka++m0zGSLmjasD
         0cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GBNssX1bMqNwZuTT2aXjIxOqWduoE+LBh8Ztzf4N6oQ=;
        b=uQSX9MwqjnQ528EIc34IP/AMawzmkfdB8I+sEQv7rDeajjnx7pD2xiZ0iYfofNHvdk
         b/ppnIp71fr2nnWR0dLXH8BuFRl+BdXoNZjdj0gRVGrsRzWHMlXbLLRD/Pd3nzwMapkL
         eQb7bnwmd1IQhODPqMgbrYv11ZlgTN8ygGI24byC6QJCE1S8knzUT6RJKzvn3m2fBDux
         avgiGZNpOlwkMlN5gLKtR2LnqCxYo/fs/Wts3iAB4NvtZUfQtFINlNfufN9QMEBr/P55
         igTZW10yFAw2w+vwxDq87HmNPmwM5c23eKI+zpdTPbE4OXP9L8N+78L3+nLB9YMJDbtz
         d4jw==
X-Gm-Message-State: APjAAAWkBrHO7DzYSU3gofgIN1ov6Sph6QAKwSxHqcDTbVwqZ/tPjrK9
        LQs53hDCm/Bl37lvGQ9zk9I=
X-Google-Smtp-Source: APXvYqwrIdb5V4XLj2mWxoROgMr9ehjgpGMOkAhx5G5NUWMC3q3ieyB2ylBmkKu83M7kCJtegUPuPA==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr146390064plb.145.1564991755961;
        Mon, 05 Aug 2019 00:55:55 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e5sm13241222pgt.91.2019.08.05.00.55.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 00:55:54 -0700 (PDT)
Date:   Mon, 5 Aug 2019 16:55:47 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, joaodias@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        tkjos@google.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v3 1/2] mm/page_idle: Add per-pid idle page tracking
 using virtual indexing
Message-ID: <20190805075547.GA196934@google.com>
References: <20190726152319.134152-1-joel@joelfernandes.org>
 <20190731085335.GD155569@google.com>
 <20190731171937.GA75376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731171937.GA75376@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joel,

On Wed, Jul 31, 2019 at 01:19:37PM -0400, Joel Fernandes wrote:
> > > -static struct page *page_idle_get_page(unsigned long pfn)
> > > +static struct page *page_idle_get_page(struct page *page_in)
> > 
> > Looks weird function name after you changed the argument.
> > Maybe "bool check_valid_page(struct page *page)"?
> 
> 
> I don't think so, this function does a get_page_unless_zero() on the page as well.
> 
> > >  {
> > >  	struct page *page;
> > >  	pg_data_t *pgdat;
> > >  
> > > -	if (!pfn_valid(pfn))
> > > -		return NULL;
> > > -
> > > -	page = pfn_to_page(pfn);
> > > +	page = page_in;
> > >  	if (!page || !PageLRU(page) ||
> > >  	    !get_page_unless_zero(page))
> > >  		return NULL;
> > > @@ -51,6 +49,18 @@ static struct page *page_idle_get_page(unsigned long pfn)
> > >  	return page;
> > >  }
> > >  
> > > +/*
> > > + * This function tries to get a user memory page by pfn as described above.
> > > + */
> > > +static struct page *page_idle_get_page_pfn(unsigned long pfn)
> > 
> > So we could use page_idle_get_page name here.
> 
> 
> Based on above comment, I prefer to keep same name. Do you agree?

Yes, I agree. Just please add a comment about refcount in the description
on page_idle_get_page.

> 
> 
> > > +	return page_idle_get_page(pfn_to_page(pfn));
> > > +}
> > > +
> > >  static bool page_idle_clear_pte_refs_one(struct page *page,
> > >  					struct vm_area_struct *vma,
> > >  					unsigned long addr, void *arg)
> > > @@ -118,6 +128,47 @@ static void page_idle_clear_pte_refs(struct page *page)
> > >  		unlock_page(page);
> > >  }
> > >  
> > > +/* Helper to get the start and end frame given a pos and count */
> > > +static int page_idle_get_frames(loff_t pos, size_t count, struct mm_struct *mm,
> > > +				unsigned long *start, unsigned long *end)
> > > +{
> > > +	unsigned long max_frame;
> > > +
> > > +	/* If an mm is not given, assume we want physical frames */
> > > +	max_frame = mm ? (mm->task_size >> PAGE_SHIFT) : max_pfn;
> > > +
> > > +	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	*start = pos * BITS_PER_BYTE;
> > > +	if (*start >= max_frame)
> > > +		return -ENXIO;
> > > +
> > > +	*end = *start + count * BITS_PER_BYTE;
> > > +	if (*end > max_frame)
> > > +		*end = max_frame;
> > > +	return 0;
> > > +}
> > > +
> > > +static bool page_really_idle(struct page *page)
> > 
> > Just minor:
> > Instead of creating new API, could we combine page_is_idle with
> > introducing furthere argument pte_check?
> 
> 
> I cannot see in the code where pte_check will be false when this is called? I
> could rename the function to page_idle_check_ptes() if that's Ok with you.

What I don't like is _*really*_ part of the funcion name.

I see several page_is_idle calls in huge_memory.c, migration.c, swap.c.
They could just check only page flag so they could use "false" with pte_check.

< snip >
 
> > > +ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
> > > +			       size_t count, loff_t *pos,
> > > +			       struct task_struct *tsk, int write)
> > > +{
> > > +	int ret;
> > > +	char *buffer;
> > > +	u64 *out;
> > > +	unsigned long start_addr, end_addr, start_frame, end_frame;
> > > +	struct mm_struct *mm = file->private_data;
> > > +	struct mm_walk walk = { .pmd_entry = pte_page_idle_proc_range, };
> > > +	struct page_node *cur;
> > > +	struct page_idle_proc_priv priv;
> > > +	bool walk_error = false;
> > > +	LIST_HEAD(idle_page_list);
> > > +
> > > +	if (!mm || !mmget_not_zero(mm))
> > > +		return -EINVAL;
> > > +
> > > +	if (count > PAGE_SIZE)
> > > +		count = PAGE_SIZE;
> > > +
> > > +	buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > > +	if (!buffer) {
> > > +		ret = -ENOMEM;
> > > +		goto out_mmput;
> > > +	}
> > > +	out = (u64 *)buffer;
> > > +
> > > +	if (write && copy_from_user(buffer, ubuff, count)) {
> > > +		ret = -EFAULT;
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret = page_idle_get_frames(*pos, count, mm, &start_frame, &end_frame);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	start_addr = (start_frame << PAGE_SHIFT);
> > > +	end_addr = (end_frame << PAGE_SHIFT);
> > > +	priv.buffer = buffer;
> > > +	priv.start_addr = start_addr;
> > > +	priv.write = write;
> > > +
> > > +	priv.idle_page_list = &idle_page_list;
> > > +	priv.cur_page_node = 0;
> > > +	priv.page_nodes = kzalloc(sizeof(struct page_node) *
> > > +				  (end_frame - start_frame), GFP_KERNEL);
> > > +	if (!priv.page_nodes) {
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +
> > > +	walk.private = &priv;
> > > +	walk.mm = mm;
> > > +
> > > +	down_read(&mm->mmap_sem);
> > > +
> > > +	/*
> > > +	 * idle_page_list is needed because walk_page_vma() holds ptlock which
> > > +	 * deadlocks with page_idle_clear_pte_refs(). So we have to collect all
> > > +	 * pages first, and then call page_idle_clear_pte_refs().
> > > +	 */
> > 
> > Thanks for the comment, I was curious why you want to have
> > idle_page_list and the reason is here.
> > 
> > How about making this /proc/<pid>/page_idle per-process granuariy,
> > unlike system level /sys/xxx/page_idle? What I meant is not to check
> > rmap to see any reference from random process but just check only
> > access from the target process. It would be more proper as /proc/
> > <pid>/ interface and good for per-process tracking as well as
> > fast.
> 
> 
> I prefer not to do this for the following reasons:
> (1) It makes a feature lost, now accesses to shared pages will not be
> accounted properly. 

Do you really want to check global attribute by per-process interface?
That would be doable with existing idle page tracking feature and that's
the one of reasons page idle tracking was born(e.g. even, page cache
for non-mapped) unlike clear_refs.
Once we create a new interface by per-process, just checking the process
-granuariy access check sounds more reasonable to me.

With that, we could catch only idle pages of the target process even though
the page was touched by several other processes.
If the user want to know global level access point, they could use
exisint interface(If there is a concern(e.g., security) to use existing
idle page tracking, let's discuss it as other topic how we could make
existing feature more useful).

IOW, my point is that we already have global access check(1. from ptes
among several processes, 2. from page flag for non-mapped pages) feature
from from existing idle page tracking interface and now we are about to create
new interface for per-process wise so I wanted to create a particular
feature which cannot be covered by existing iterface.

> 
> (2) It makes it inconsistent with other idle page tracking mechanism. I

That's the my comment to create different idle page tracking we couldn't
do with existing interface.

> prefer if post per-process. At the heart of it, the tracking is always at the

What does it mean "post per-process"?

> physical page level -- I feel that is how it should be. Other drawback, is
> also we have to document this subtlety.

Sorry, Could you elaborate it a bit?
