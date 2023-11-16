Return-Path: <linux-fsdevel+bounces-2947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C67EDD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23BD1C209A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E02171C7;
	Thu, 16 Nov 2023 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhZRB2Gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7C1AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700126358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d0zllxIvEXWI41Y5eiP5HtOd5DP7XlwuzLUNFB7vaqM=;
	b=EhZRB2GgZGCY8tZoCFGd+LSFPiTYn5/uuOT3GVr1g8baoqEcfh/vQbg0Kt3TpNW3ExlffT
	2pzWIEQ99BR0oArg+lgDMaNEdRc/sdl3mskgq3J0uvjqTGZt+ZOSkg3oXKWO4VkOhz3CV7
	18LMkhCmwACjNfWkG9FPBtnlReA1WaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-X6ZQIDngOG2XeRBHFvcPJQ-1; Thu, 16 Nov 2023 04:19:16 -0500
X-MC-Unique: X6ZQIDngOG2XeRBHFvcPJQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso3554075e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126355; x=1700731155;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0zllxIvEXWI41Y5eiP5HtOd5DP7XlwuzLUNFB7vaqM=;
        b=XRhDtMltPlPKSSMo0VV+Fke7qs8g9bXnUuaM5hY0biCDRqYzfSTh1xprhGhMh0Miev
         B311gINW1DECETOhwFP1/wR8jAe8xxBP3svGPRMFdxhZRQZCUo3G6/k4LlJkkA1bqoza
         JnVgCkzpcylQXOH6fg2mgS4+bVaZPOD+gjrMDQSGUhQr0NnJTeh4DCM6J0pk8XLDtTu3
         S8JscEnQg1Tj8rhMg5jWnMxmojCjr6E0QXxfRX/3mTBhcRytyZDjafxRTnISJW37etP7
         xeKyMPk+IA+DcvSRsvsQKPUgYo7U8XNKBMUTqizEJef+b1D6hKeOGF2M9OLzetadFPaJ
         uLoA==
X-Gm-Message-State: AOJu0YxTHdWM6/9nRVV2FhNxESrhRUReM8fjWJzKHSIcuW081hYNkR/C
	HtzZMtjvql7EvHSAIowqB8xoBLFEFYRbUAdzf4e+/BSpxr61RbA7hDKzNDEHAaKWfwR3MJME9gI
	DO0xrwWWgxM0rTDRSy39BF2350w==
X-Received: by 2002:a05:600c:1ca5:b0:408:5919:5f97 with SMTP id k37-20020a05600c1ca500b0040859195f97mr12107687wms.25.1700126355012;
        Thu, 16 Nov 2023 01:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnRMdoDEaNut4IYZM6wXVGU9C68398acx31v4mDjswqx1vAYX1OJnHQseIuj6H+xz4eY0tjA==
X-Received: by 2002:a05:600c:1ca5:b0:408:5919:5f97 with SMTP id k37-20020a05600c1ca500b0040859195f97mr12107665wms.25.1700126354543;
        Thu, 16 Nov 2023 01:19:14 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id az23-20020a05600c601700b004054dcbf92asm2805042wmb.20.2023.11.16.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 01:19:14 -0800 (PST)
Message-ID: <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
Date: Thu, 16 Nov 2023 10:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
To: Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 usama.anjum@collabora.com, wangkefeng.wang@huawei.com,
 Peter Xu <peterx@redhat.com>
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.23 23:00, Andrew Morton wrote:
> On Wed, 15 Nov 2023 05:32:19 -0800 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ff3057680000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7ca4b2719dc742b8d0a4
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a25ff680000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d62338e80000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz
>>
>> The issue was bisected to:
>>
>> commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
>> Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Date:   Mon Aug 21 14:15:15 2023 +0000
>>
>>      fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag
> 
> Thanks.  The bisection is surprising, but the mentioned patch does
> mess with pagemap.
> 
> How about we add this?
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/memory.c:zap_pte_range() print bad swap entry
> Date: Wed Nov 15 01:54:18 PM PST 2023
> 
> We have a report of this WARN() triggering.  Let's print the offending
> swp_entry_t to help diagnosis.
> 
> Link: https://lkml.kernel.org/r/000000000000b0e576060a30ee3b@google.com
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   mm/memory.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/mm/memory.c~a
> +++ a/mm/memory.c
> @@ -1521,6 +1521,7 @@ static unsigned long zap_pte_range(struc
>   				continue;
>   		} else {
>   			/* We should have covered all the swap entry types */
> +			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>   			WARN_ON_ONCE(1);
>   		}
>   		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> _
> 

I'm curious if

1) make_uffd_wp_pte() won't end up overwriting existing pte markers, for
    example, if PTE_MARKER_POISONED is set. [unrelated to this bug]

2) We get the error on arm64, which does *not* support uffd-wp. Do we
    maybe end up calling make_uffd_wp_pte() and place a pte marker, even
    though we don't have CONFIG_PTE_MARKER_UFFD_WP?


static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
{
#ifdef CONFIG_PTE_MARKER_UFFD_WP
	return is_pte_marker_entry(entry) &&
	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
#else
	return false;
#endif
}

Will always return false without CONFIG_PTE_MARKER_UFFD_WP.

But make_uffd_wp_pte() might just happily place an entry. Hm.


The following might fix the problem:

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51e0ec658457..ae1cf19918d3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1830,8 +1830,10 @@ static void make_uffd_wp_pte(struct 
vm_area_struct *vma,
                 ptent = pte_swp_mkuffd_wp(ptent);
                 set_pte_at(vma->vm_mm, addr, pte, ptent);
         } else {
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
                 set_pte_at(vma->vm_mm, addr, pte,
                            make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
         }
  }


But I am *pretty* sure that that whole machinery should be fenced off. 
It does make 0 sense to mess with uffd-wp if there is no uffd-wp support.

-- 
Cheers,

David / dhildenb


