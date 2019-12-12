Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6589D11C1E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLLBJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:09:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37855 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLLBJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:09:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep17so291899pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hROdlOePoG4K4sMVeAa6ErIyhbPGlWiSJjCq4h8vx3c=;
        b=oxnJQLHlPTuEHM9ECGOa3fhIh/k0g9PL4Uhla0Z8oTOKqF70Nh9dCKmgZBlyDwt0/P
         t8SUmks9f13g2mZwYmaS76+IVjiD0vu1vQXVE22u6ii3RhX1/c3Esg3/k4dRZ3qPaZb7
         tOwB1Omun1Z379a0OFV9YSU6+WG+QnqCK0kiY8caRNf5g69QUwr32P2tPZU/2kUeIQBU
         YHHtCbLgo7GJJihItC3/f3OeZmXNHwZmDLwp+eehMHFbzRhpE1o4WfrMSYeyRxhkWrpX
         xSv4GZJHDoTnVyLqWhvlOcnopp0BaVizsezeUv/PZ8BYsdFF1/SMob55zFABNY+zP8kb
         Javw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hROdlOePoG4K4sMVeAa6ErIyhbPGlWiSJjCq4h8vx3c=;
        b=E00rv4AOIGldlNap/faMrXxseBGIyCXCm6YsNoEaeWKOnnTDZ4lFHxQz+aADOT31gA
         jS9Ao+NsaGIrYAI3Gl596lU/HrOOAm6R1Y7hqiA66g7BPzngr/FvnLl8JN3YfJA8yk2x
         o07i7SClpieVpFzzFP9A3soIEp4/6YGna3XUouniLS1pMcTkBnMejxlUUjJE5b17np3M
         ynbqrnbhPrhrqUS7J3tnPnAaD3N9AWR9WQ2YQ7eB1yzRuST9Pq1iWduff/vhwc78Rlm/
         BlvuGrg82wlozdc9z6QQkO43Hmpxr4lLY5gMItG/EXv3mP1mdUafcunYhcdNFWq29JWN
         6iTA==
X-Gm-Message-State: APjAAAXWknVytUgvS9PXTYuXwPh9ZQKLItXgQDahBAeHHZpwnsiM4Y1h
        4SUvgD44OFAks9fAro7Jxpgzeg==
X-Google-Smtp-Source: APXvYqxogwXVX/STSzE2IL4JscqdzT1Rhjo8iIC+1XWMhTwztYagsIC1hyNN5XU6/3yXy32M0Bpgbw==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr6529435pll.17.1576112957355;
        Wed, 11 Dec 2019 17:09:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e16sm4238762pff.181.2019.12.11.17.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:09:16 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
Message-ID: <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
Date:   Wed, 11 Dec 2019 18:09:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 4:41 PM, Jens Axboe wrote:
> On 12/11/19 1:18 PM, Linus Torvalds wrote:
>> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> $ cat /proc/meminfo | grep -i active
>>> Active:           134136 kB
>>> Inactive:       28683916 kB
>>> Active(anon):      97064 kB
>>> Inactive(anon):        4 kB
>>> Active(file):      37072 kB
>>> Inactive(file): 28683912 kB
>>
>> Yeah, that should not put pressure on some swap activity. We have 28
>> GB of basically free inactive file data, and the VM is doing something
>> very very bad if it then doesn't just quickly free it with no real
>> drama.
>>
>> In fact, I don't think it should even trigger kswapd at all, it should
>> all be direct reclaim. Of course, some of the mm people hate that with
>> a passion, but this does look like a prime example of why it should
>> just be done.
> 
> For giggles, I ran just a single thread on the file set. We're only
> doing about 100K IOPS at that point, yet when the page cache fills,
> kswapd still eats 10% cpu. That seems like a lot for something that
> slow.

Warning, the below is from the really crazy department...

Anyway, I took a closer look at the profiles for the uncached case.
We're spending a lot of time doing memsets (this is the xa_node init,
from the radix tree constructor), and call_rcu for the node free later
on. All wasted time, and something that meant we weren't as close to the
performance of O_DIRECT as we could be.

So Chris and I started talking about this, and pondered "what would
happen if we simply bypassed the page cache completely?". Case in point,
see below incremental patch. We still do the page cache lookup, and use
that page to copy from if it's there. If the page isn't there, allocate
one and do IO to it, but DON'T add it to the page cache. With that,
we're almost at O_DIRECT levels of performance for the 4k read case,
without 1-2%. I think 512b would look awesome, but we're reading full
pages, so that won't really help us much. Compared to the previous
uncached method, this is 30% faster on this device. That's substantial.

Obviously this has issues with truncate that would need to be resolved,
and it's definitely dirtier. But the performance is very enticing...


diff --git a/mm/filemap.c b/mm/filemap.c
index c37b0e221a8a..9834c394fffd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -933,8 +933,8 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
 
-static int __add_to_page_cache(struct page *page, struct address_space *mapping,
-			       pgoff_t offset, gfp_t gfp_mask, bool lru)
+int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
+				pgoff_t offset, gfp_t gfp_mask)
 {
 	void *shadow = NULL;
 	int ret;
@@ -956,18 +956,11 @@ static int __add_to_page_cache(struct page *page, struct address_space *mapping,
 		WARN_ON_ONCE(PageActive(page));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
 			workingset_refault(page, shadow);
-		if (lru)
-			lru_cache_add(page);
+		lru_cache_add(page);
 	}
 	return ret;
 
 }
-
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
-{
-	return __add_to_page_cache(page, mapping, offset, gfp_mask, true);
-}
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
 #ifdef CONFIG_NUMA
@@ -1998,6 +1991,13 @@ static void shrink_readahead_size_eio(struct file *filp,
 	ra->ra_pages /= 4;
 }
 
+static void buffered_put_page(struct page *page, bool clear_mapping)
+{
+	if (clear_mapping)
+		page->mapping = NULL;
+	put_page(page);
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2040,7 +2040,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	offset = *ppos & ~PAGE_MASK;
 
 	for (;;) {
-		bool drop_page = false;
+		bool clear_mapping = false;
 		struct page *page;
 		pgoff_t end_index;
 		loff_t isize;
@@ -2118,7 +2118,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
+			buffered_put_page(page, clear_mapping);
 			goto out;
 		}
 
@@ -2127,7 +2127,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_MASK) + 1;
 			if (nr <= offset) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				goto out;
 			}
 		}
@@ -2160,27 +2160,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		offset &= ~PAGE_MASK;
 		prev_offset = offset;
 
-		/*
-		 * If we're dropping this page due to drop-behind, then
-		 * lock it first. Ignore errors here, we can just leave it
-		 * in the page cache. Note that we didn't add this page to
-		 * the LRU when we added it to the page cache. So if we
-		 * fail removing it, or lock it, add to the LRU.
-		 */
-		if (drop_page) {
-			bool addlru = true;
-
-			if (!lock_page_killable(page)) {
-				if (page->mapping == mapping)
-					addlru = !remove_mapping(mapping, page);
-				else
-					addlru = false;
-				unlock_page(page);
-			}
-			if (addlru)
-				lru_cache_add(page);
-		}
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		written += ret;
 		if (!iov_iter_count(iter))
 			goto out;
@@ -2222,7 +2202,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				error = 0;
 				goto find_page;
 			}
@@ -2239,7 +2219,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					 * invalidate_mapping_pages got it
 					 */
 					unlock_page(page);
-					put_page(page);
+					buffered_put_page(page, clear_mapping);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -2254,7 +2234,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		goto out;
 
 no_cached_page:
@@ -2267,12 +2247,16 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
-		if (iocb->ki_flags & IOCB_UNCACHED)
-			drop_page = true;
+		if (iocb->ki_flags & IOCB_UNCACHED) {
+			__SetPageLocked(page);
+			page->mapping = mapping;
+			page->index = index;
+			clear_mapping = true;
+			goto readpage;
+		}
 
-		error = __add_to_page_cache(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL),
-				!drop_page);
+		error = add_to_page_cache(page, mapping, index,
+				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
 			put_page(page);
 			if (error == -EEXIST) {

-- 
Jens Axboe

