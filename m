Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8851016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfFXPP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 11:15:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37002 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfFXPPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:15:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so22328797eds.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tb/fwXJIPZBkB2w8y3N+xp6qDheDapQLagvbQVmWBxs=;
        b=hKivaIYvCcbw0ygV6Kz/ud/MoCDO10N8kdFBEYqhIMh4ZVCmzkU5sNxig8oy6ZYXyO
         DaxcwQ0dkrrDxCs+vYrQatvN8v7AZbUi+4VwFuHZnNzOD1wtZ8Y54yY17uaAJEGQ6PcN
         yRxIyk/1RryQNYcrfRh4XEPNBhwjPu1A6L+5MulFzYjeDc/0xxkYjzHAmbGMJ5NKWyA9
         UkUGsfw18XOL+7K9WbelemLiJ3LthA+M0veyhFrPVt6CR8IQFI15s1KBKIOSa3dsDjT8
         uBxf4Mz5ND81hGRaKlV6YbyHwMOiqyw7I9U54xVYEi2z/yawXzgiyOpuhmO7EF3adB03
         IU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tb/fwXJIPZBkB2w8y3N+xp6qDheDapQLagvbQVmWBxs=;
        b=FBU7aIikORQl4bZPjpkKIHl+B/Qlbq7Z1IRp+UUquAC0lCSB1s3nYOAfmb0E4DhihZ
         v96WDS/6XstI408iIwDmhLmlCvIQDIv6o7Hdr8u8A0rL/gldrLW5r7+6rlSrElasjl8T
         gAUGQqHpV8zTZoHSmr3gKzbizGRQsy2Rmahs6TDu6krR+J1c3NAjvP50VfGC65AqenVU
         argVxRvo0Rg7HjJIlvxzjhELKX69EZ7nazU5o/cgQ1Ru2Fy0xirLGX6k+klecbaHDIqt
         JcW5Ib6L+qQjKTUPRoYTHrvpkHBzehqtd2XDtePgB2rUOFb349B9tdaq42DHtEUSNKN+
         vkAw==
X-Gm-Message-State: APjAAAXIo05e+gTh6sMxgEg+lWG8goV/j91pgHQPbrbjn8HUgJ+w4SSw
        /KokNQdqjxhjIO6LRfg40V8GGQ==
X-Google-Smtp-Source: APXvYqz2rk4utKNukeyBdZl2ORALqkVcwVPb1q4qGRLCaAP8B6P/6LhMQuSx+7vkAKVkB7JktYIaZQ==
X-Received: by 2002:a17:906:85d4:: with SMTP id i20mr20687001ejy.256.1561389324273;
        Mon, 24 Jun 2019 08:15:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f2sm873444ejb.41.2019.06.24.08.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:15:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A98AF1043B3; Mon, 24 Jun 2019 18:15:28 +0300 (+03)
Date:   Mon, 24 Jun 2019 18:15:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Message-ID: <20190624151528.fnz3hvlnyvea3ytn@box>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
 <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
 <20190624142747.chy5s3nendxktm3l@box>
 <C3161C66-5044-44E6-92F4-BBAD42EDF4E2@fb.com>
 <20190624145453.u4ej3e4ktyyqjite@box>
 <5BE23F34-B611-496B-9277-A09C9CC784B1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BE23F34-B611-496B-9277-A09C9CC784B1@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:04:21PM +0000, Song Liu wrote:
> 
> 
> > On Jun 24, 2019, at 7:54 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Mon, Jun 24, 2019 at 02:42:13PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Jun 24, 2019, at 7:27 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>> 
> >>> On Mon, Jun 24, 2019 at 02:01:05PM +0000, Song Liu wrote:
> >>>>>> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *mm,
> >>>>>> 				result = SCAN_FAIL;
> >>>>>> 				goto xa_unlocked;
> >>>>>> 			}
> >>>>>> +		} else if (!page || xa_is_value(page)) {
> >>>>>> +			xas_unlock_irq(&xas);
> >>>>>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
> >>>>>> +						  index, PAGE_SIZE);
> >>>>>> +			lru_add_drain();
> >>>>> 
> >>>>> Why?
> >>>> 
> >>>> isolate_lru_page() is likely to fail if we don't drain the pagevecs. 
> >>> 
> >>> Please add a comment.
> >> 
> >> Will do. 
> >> 
> >>> 
> >>>>>> +			page = find_lock_page(mapping, index);
> >>>>>> +			if (unlikely(page == NULL)) {
> >>>>>> +				result = SCAN_FAIL;
> >>>>>> +				goto xa_unlocked;
> >>>>>> +			}
> >>>>>> +		} else if (!PageUptodate(page)) {
> >>>>> 
> >>>>> Maybe we should try wait_on_page_locked() here before give up?
> >>>> 
> >>>> Are you referring to the "if (!PageUptodate(page))" case? 
> >>> 
> >>> Yes.
> >> 
> >> I think this case happens when another thread is reading the page in. 
> >> I could not think of a way to trigger this condition for testing. 
> >> 
> >> On the other hand, with current logic, we will retry the page on the 
> >> next scan, so I guess this is OK. 
> > 
> > What I meant that calling wait_on_page_locked() on !PageUptodate() page
> > will likely make it up-to-date and we don't need to SCAN_FAIL the attempt.
> > 
> 
> Yeah, I got the point. My only concern is that I don't know how to 
> reliably trigger this case for testing. I can try to trigger it. But I 
> don't know whether it will happen easily. 

Atrifically slowing down IO should do the trick.

-- 
 Kirill A. Shutemov
