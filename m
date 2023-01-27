Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45267DDFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 07:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjA0Gvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 01:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjA0GvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:51:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19979620;
        Thu, 26 Jan 2023 22:48:27 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2F7D6602E82;
        Fri, 27 Jan 2023 06:47:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674802047;
        bh=69W6soRYdRXxx92H88q51hXdJ1au/2h810DecoqjF2s=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=QRQCFMh8FhNf41DVQZOcw07fhehrXuCkJ+jxGny7r17qr85Jzq05s5VQJ+wvxCrBC
         +cVbfQFlF9uXMeOmdEFxtFKMs7oP6bvOmyS20sBJxm3fILJTOMrCYPMbEddE2+hkFm
         R3k0aeIH/9AwchlkpeiPElGjUhywVleAovENUoOdtmSTvQA9SDPl9HyCnwbn2E+4jZ
         KexE7nJrz/8SovRhKqfRjfEGY59v/CUvVwsKpAXglPwwmLfw50nrYHuKaExM7J+NNI
         JWKtBdZpRXAB8/8aZPT+Wdlswe+fk6NpGGglYs0N0mPKz3GpR1/SYZ/5tfoTB8K8n1
         kNInR2JY5s7Qw==
Content-Type: multipart/mixed; boundary="------------YDczPGnNMYCbOh0mtE2Xi30f"
Message-ID: <1968dff9-f48a-3290-a15b-a8b739f31ed2@collabora.com>
Date:   Fri, 27 Jan 2023 11:47:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
To:     Peter Xu <peterx@redhat.com>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-2-usama.anjum@collabora.com> <Y9MHM+RVzvigcTTk@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y9MHM+RVzvigcTTk@x1n>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/23 4:05 AM, Peter Xu wrote:
> On Tue, Jan 24, 2023 at 01:43:20PM +0500, Muhammad Usama Anjum wrote:
>> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
>> faults on its own. It can be used to track that which pages have been
>> written-to from the time the pages were write-protected. It is very
>> efficient way to track the changes as uffd is by nature pte/pmd based.
>>
>> UFFD synchronous WP sends the page faults to the userspace where the
>> pages which have been written-to can be tracked. But it is not efficient.
>> This is why this asynchronous version is being added. After setting the
>> WP Async, the pages which have been written to can be found in the pagemap
>> file or information can be obtained from the PAGEMAP_IOCTL.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v7:
>> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
>> - Handle automatic page fault resolution in better way (thanks to Peter)
>> ---
>>  fs/userfaultfd.c                 | 11 +++++++++++
>>  include/linux/userfaultfd_k.h    |  6 ++++++
>>  include/uapi/linux/userfaultfd.h |  8 +++++++-
>>  mm/memory.c                      | 29 +++++++++++++++++++++++++++--
>>  4 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 15a5bf765d43..b82af02092ce 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1867,6 +1867,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>>  	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
>>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
>>  
>> +	/* Write protection cannot be disabled in case of aync WP */
> 
> s/aync/async/
> 
> A slight reworded version:
> 
>         /* Unprotection is not supported if in async WP mode */
> 
Will fix in next version.

>> +	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
>> +		return -EINVAL;
>> +
>>  	if (mode_wp && mode_dontwake)
>>  		return -EINVAL;
>>  
>> @@ -1950,6 +1954,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>>  	return ret;
>>  }
>>  
>> +int userfaultfd_wp_async(struct vm_area_struct *vma)
>> +{
>> +	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
>> +
>> +	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
>> +}
>> +
>>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>>  {
>>  	/*
>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>> index 9df0b9a762cc..5db51fccae1d 100644
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
>>  				  unsigned long end, struct list_head *uf);
>>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>>  				       struct list_head *uf);
>> +extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>>  
>>  #else /* CONFIG_USERFAULTFD */
>>  
>> @@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>>  	return false;
>>  }
>>  
>> +int userfaultfd_wp_async(struct vm_area_struct *vma)
>> +{
>> +	return false;
>> +}
>> +
>>  #endif /* CONFIG_USERFAULTFD */
>>  
>>  static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
>> index 005e5e306266..f4252ef40071 100644
>> --- a/include/uapi/linux/userfaultfd.h
>> +++ b/include/uapi/linux/userfaultfd.h
>> @@ -38,7 +38,8 @@
>>  			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>>  			   UFFD_FEATURE_MINOR_SHMEM |		\
>>  			   UFFD_FEATURE_EXACT_ADDRESS |		\
>> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
>> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
>> +			   UFFD_FEATURE_WP_ASYNC)
>>  #define UFFD_API_IOCTLS				\
>>  	((__u64)1 << _UFFDIO_REGISTER |		\
>>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
>> @@ -203,6 +204,10 @@ struct uffdio_api {
>>  	 *
>>  	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>>  	 * write-protection mode is supported on both shmem and hugetlbfs.
>> +	 *
>> +	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
>> +	 * asynchronous mode is supported in which the write fault is automatically
>> +	 * resolved and write-protection is un-set.
>>  	 */
>>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
>> @@ -217,6 +222,7 @@ struct uffdio_api {
>>  #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>>  #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
>> +#define UFFD_FEATURE_WP_ASYNC			(1<<13)
>>  	__u64 features;
>>  
>>  	__u64 ioctls;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 4000e9f017e0..8c03b133d483 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>  
>>  	if (likely(!unshare)) {
>>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>> +			if (userfaultfd_wp_async(vma)) {
>> +				/*
>> +				 * Nothing needed (cache flush, TLB invalidations,
>> +				 * etc.) because we're only removing the uffd-wp bit,
>> +				 * which is completely invisible to the user. This
>> +				 * falls through to possible CoW.
> 
> Here it says it falls through to CoW, but..
> 
>> +				 */
>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
>> +					   pte_clear_uffd_wp(*vmf->pte));
>> +				return 0;
> 
> ... it's not doing so.  The original lines should do:
> 
> https://lore.kernel.org/all/Y8qq0dKIJBshua+X@x1n/
> 
> Side note: you cannot modify pgtable after releasing the pgtable lock.
> It's racy.
If I don't unlock and return after removing the UFFD_WP flag in case of
async wp, the target just gets stuck. Maybe the pte lock is not unlocked in
some path.

If I unlock and don't return, the crash happens.

So I'd put unlock and return from here. Please comment on the below patch
and what do you think should be done. I've missed something.

> 
>> +			}
>>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  			return handle_userfault(vmf, VM_UFFD_WP);
>>  		}
>> @@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>  
>>  	if (vma_is_anonymous(vmf->vma)) {
>>  		if (likely(!unshare) &&
>> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>> -			return handle_userfault(vmf, VM_UFFD_WP);
>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
>> +			if (userfaultfd_wp_async(vmf->vma)) {
>> +				/*
>> +				 * Nothing needed (cache flush, TLB invalidations,
>> +				 * etc.) because we're only removing the uffd-wp bit,
>> +				 * which is completely invisible to the user. This
>> +				 * falls through to possible CoW.
>> +				 */
>> +				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
>> +					   pmd_clear_uffd_wp(*vmf->pmd));
> 
> This is for THP, not hugetlb.
> 
> Clearing uffd-wp bit here for the whole pmd is wrong to me, because we
> track writes in small page sizes only.  We should just split.
By detecting if the fault is async wp, just splitting the PMD doesn't work.
The below given snippit is working right now. But definately, the fault of
the whole PMD is being resolved which if we can bypass by correctly
splitting would be highly desirable. Can you please take a look on UFFD
side and suggest the changes? It would be much appreciated. I'm attaching
WIP v9 patches for you to apply on next(next-20230105) and pagemap_ioctl
selftest can be ran to test things after making changes.

> 
> The relevant code for hugetlb resides in hugetlb_fault().
> 
>> +				return 0;
>> +			} else {
>> +				return handle_userfault(vmf, VM_UFFD_WP);
>> +			}
>> +		}
>>  		return do_huge_pmd_wp_page(vmf);
>>  	}
>>  
>> -- 
>> 2.30.2
>>
> 



--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)

        if (likely(!unshare)) {
                if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+                       if (userfaultfd_wp_async(vma)) {
+                               set_pte_at(vma->vm_mm, vmf->address,
+                                          vmf->pte,
+                                          pte_clear_uffd_wp(*vmf->pte));
+                               pte_unmap_unlock(vmf->pte, vmf->ptl);
+                               return 0;
+                       }
                        pte_unmap_unlock(vmf->pte, vmf->ptl);
                        return handle_userfault(vmf, VM_UFFD_WP);
                }
@@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault
*vmf)

        if (vma_is_anonymous(vmf->vma)) {
                if (likely(!unshare) &&
-                   userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
-                       return handle_userfault(vmf, VM_UFFD_WP);
+                   userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
+                       if (userfaultfd_wp_async(vmf->vma)) {
+                               set_pmd_at(vmf->vma->vm_mm, vmf->address,
+                                          vmf->pmd,
+                                          pmd_clear_uffd_wp(*vmf->pmd));
+                               return 0;
+                       } else {
+                               return handle_userfault(vmf, VM_UFFD_WP);
+                       }
+               }
                return do_huge_pmd_wp_page(vmf);
        }


-- 
BR,
Muhammad Usama Anjum
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/x-patch; charset=UTF-8; name="0000-cover-letter.patch"
Content-Disposition: attachment; filename="0000-cover-letter.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NzRlM2NkMmU2N2Y1ZTk0Zjk5OTRhNzVhYWMzYTNlMTNjY2Q2ZGViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogRnJpLCAyNyBKYW4gMjAyMyAxMTo0Mjo1MyArMDUw
MApTdWJqZWN0OiBbUEFUQ0ggV0lQIHY5IDAvNF0gSW1wbGVtZW50IElPQ1RMIHRvIGdldCBh
bmQvb3IgdGhlIGNsZWFyIGluZm8gYWJvdXQKIFBURXMKCipDaGFuZ2VzIGluIHY5OioKLSBG
aXggYnVpbGQgd2FybmluZ3MgYW5kIGVycm9ycyB3aGljaCB3ZXJlIGhhcHBlbmluZyBvbiBz
b21lIGNvbmZpZ3MKLSBTaW1wbGlmeSBwYWdlbWFwIGlvY3RsJ3MgY29kZQoKKkNoYW5nZXMg
aW4gdjg6KgotIFVwZGF0ZSB1ZmZkIGFzeW5jIHdwIGltcGxlbWVudGF0aW9uCi0gSW1wcm92
ZSBQQUdFTUFQX0lPQ1RMIGltcGxlbWVudGF0aW9uCgoqQ2hhbmdlcyBpbiB2NzoqCi0gQWRk
IHVmZmQgd3AgYXN5bmMKLSBVcGRhdGUgdGhlIElPQ1RMIHRvIHVzZSB1ZmZkIHVuZGVyIHRo
ZSBob29kIGluc3RlYWQgb2Ygc29mdC1kaXJ0eQogIGZsYWdzCgpIZWxsbywKCk5vdGU6ClNv
ZnQtZGlydHkgcGFnZXMgYW5kIHBhZ2VzIHdoaWNoIGhhdmUgYmVlbiB3cml0dGVuLXRvIGFy
ZSBzeW5vbnltcy4gQXMKa2VybmVsIGFscmVhZHkgaGFzIHNvZnQtZGlydHkgZmVhdHVyZSBp
bnNpZGUgd2hpY2ggd2UgaGF2ZSBnaXZlbiB1cCB0bwp1c2UsIHdlIGFyZSB1c2luZyB3cml0
dGVuLXRvIHRlcm1pbm9sb2d5IHdoaWxlIHVzaW5nIFVGRkQgYXN5bmMgV1AgdW5kZXIKdGhl
IGhvb2QuCgpUaGlzIElPQ1RMLCBQQUdFTUFQX1NDQU4gb24gcGFnZW1hcCBmaWxlIGNhbiBi
ZSB1c2VkIHRvIGdldCBhbmQvb3IgY2xlYXIKdGhlIGluZm8gYWJvdXQgcGFnZSB0YWJsZSBl
bnRyaWVzLiBUaGUgZm9sbG93aW5nIG9wZXJhdGlvbnMgYXJlCnN1cHBvcnRlZCBpbiB0aGlz
IGlvY3RsOgotIEdldCB0aGUgaW5mb3JtYXRpb24gaWYgdGhlIHBhZ2VzIGhhdmUgYmVlbiB3
cml0dGVuLXRvIChQQUdFX0lTX1dUKSwKICBmaWxlIG1hcHBlZCAoUEFHRV9JU19GSUxFKSwg
cHJlc2VudCAoUEFHRV9JU19QUkVTRU5UKSBvciBzd2FwcGVkCiAgKFBBR0VfSVNfU1dBUFBF
RCkuCi0gV3JpdGUtcHJvdGVjdCB0aGUgcGFnZXMgKFBBR0VNQVBfV1BfRU5HQUdFKSB0byBz
dGFydCBmaW5kaW5nIHdoaWNoCiAgcGFnZXMgaGF2ZSBiZWVuIHdyaXR0ZW4tdG8uCi0gRmlu
ZCBwYWdlcyB3aGljaCBoYXZlIGJlZW4gd3JpdHRlbi10byBhbmQgd3JpdGUgcHJvdGVjdCB0
aGUgcGFnZXMKICAoYXRvbWljIFBBR0VfSVNfV1QgKyBQQUdFTUFQX1dQX0VOR0FHRSkKCkl0
IGlzIHBvc3NpYmxlIHRvIGZpbmQgYW5kIGNsZWFyIHNvZnQtZGlydHkgcGFnZXMgZW50aXJl
bHkgaW4gdXNlcnNwYWNlLgpCdXQgaXQgaXNuJ3QgZWZmaWNpZW50OgotIFRoZSBtcHJvdGVj
dCBhbmQgU0lHU0VHViBoYW5kbGVyIGZvciBib29ra2VlcGluZwotIFRoZSB1c2VyZmF1bHRm
ZCB3cCB3aXRoIHRoZSBoYW5kbGVyIGZvciBib29ra2VlcGluZwoKU29tZSBiZW5jaG1hcmtz
IGNhbiBiZSBzZWVuIGhlcmVbMV0uIFRoaXMgc2VyaWVzIGFkZHMgZmVhdHVyZXMgdGhhdCB3
ZXJlbid0CnByZXNlbnQgZWFybGllcjoKLSBUaGVyZSBpcyBubyBhdG9taWMgZ2V0IHNvZnQt
ZGlydHkgUFRFIGJpdCBzdGF0dXMgYW5kIGNsZWFyIHByZXNlbnQgaW4KICB0aGUga2VybmVs
LgotIFRoZSBwYWdlcyB3aGljaCBoYXZlIGJlZW4gd3JpdHRlbi10byBjYW4gbm90IGJlIGZv
dW5kIGluIGFjY3VyYXRlIHdheS4KICAoS2VybmVsJ3Mgc29mdC1kaXJ0eSBQVEUgYml0ICsg
c29mX2RpcnR5IFZNQSBiaXQgc2hvd3MgbW9yZSBzb2Z0LWRpcnR5CiAgcGFnZXMgdGhhbiB0
aGVyZSBhY3R1YWxseSBhcmUuKQoKSGlzdG9yaWNhbGx5LCBzb2Z0LWRpcnR5IFBURSBiaXQg
dHJhY2tpbmcgaGFzIGJlZW4gdXNlZCBpbiB0aGUgQ1JJVQpwcm9qZWN0LiBUaGUgcHJvY2Zz
IGludGVyZmFjZSBpcyBlbm91Z2ggZm9yIGZpbmRpbmcgdGhlIHNvZnQtZGlydHkgYml0CnN0
YXR1cyBhbmQgY2xlYXJpbmcgdGhlIHNvZnQtZGlydHkgYml0IG9mIGFsbCB0aGUgcGFnZXMg
b2YgYSBwcm9jZXNzLgpXZSBoYXZlIHRoZSB1c2UgY2FzZSB3aGVyZSB3ZSBuZWVkIHRvIHRy
YWNrIHRoZSBzb2Z0LWRpcnR5IFBURSBiaXQgZm9yCm9ubHkgc3BlY2lmaWMgcGFnZXMgb24g
ZGVtYW5kLiBXZSBuZWVkIHRoaXMgdHJhY2tpbmcgYW5kIGNsZWFyIG1lY2hhbmlzbQpvZiBh
IHJlZ2lvbiBvZiBtZW1vcnkgd2hpbGUgdGhlIHByb2Nlc3MgaXMgcnVubmluZyB0byBlbXVs
YXRlIHRoZQpnZXRXcml0ZVdhdGNoKCkgc3lzY2FsbCBvZiBXaW5kb3dzLgoKKihNb3ZlZCB0
byB1c2luZyBVRkZEIGluc3RlYWQgb2Ygc29mdC1kaXJ0eSB0byBmaW5kIHBhZ2VzIHdoaWNo
IGhhdmUgYmVlbgp3cml0dGVuLXRvIGZyb20gdjcgcGF0Y2ggc2VyaWVzKSo6ClN0b3AgdXNp
bmcgdGhlIHNvZnQtZGlydHkgZmxhZ3MgZm9yIGZpbmRpbmcgd2hpY2ggcGFnZXMgaGF2ZSBi
ZWVuCndyaXR0ZW4gdG8uIEl0IGlzIHRvbyBkZWxpY2F0ZSBhbmQgd3JvbmcgYXMgaXQgc2hv
d3MgbW9yZSBzb2Z0LWRpcnR5CnBhZ2VzIHRoYW4gdGhlIGFjdHVhbCBzb2Z0LWRpcnR5IHBh
Z2VzLiBUaGVyZSBpcyBubyBpbnRlcmVzdCBpbgpjb3JyZWN0aW5nIGl0IFsyXVszXSBhcyB0
aGlzIGlzIGhvdyB0aGUgZmVhdHVyZSB3YXMgd3JpdHRlbiB5ZWFycyBhZ28uCkl0IHNob3Vs
ZG4ndCBiZSB1cGRhdGVkIHRvIGNoYW5nZWQgYmVoYXZpb3VyLiBQZXRlciBYdSBoYXMgc3Vn
Z2VzdGVkCnVzaW5nIHRoZSBhc3luYyB2ZXJzaW9uIG9mIHRoZSBVRkZEIFdQIFs0XSBhcyBp
dCBpcyBiYXNlZCBpbmhlcmVudGx5Cm9uIHRoZSBQVEVzLgoKU28gaW4gdGhpcyBwYXRjaCBz
ZXJpZXMsIEkndmUgYWRkZWQgYSBuZXcgbW9kZSB0byB0aGUgVUZGRCB3aGljaCBpcwphc3lu
Y2hyb25vdXMgdmVyc2lvbiBvZiB0aGUgd3JpdGUgcHJvdGVjdC4gV2hlbiB0aGlzIHZhcmlh
bnQgb2YgdGhlClVGRkQgV1AgaXMgdXNlZCwgdGhlIHBhZ2UgZmF1bHRzIGFyZSByZXNvbHZl
ZCBhdXRvbWF0aWNhbGx5IGJ5IHRoZQprZXJuZWwuIFRoZSBwYWdlcyB3aGljaCBoYXZlIGJl
ZW4gd3JpdHRlbi10byBjYW4gYmUgZm91bmQgYnkgcmVhZGluZwpwYWdlbWFwIGZpbGUgKCFQ
TV9VRkZEX1dQKS4gVGhpcyBmZWF0dXJlIGNhbiBiZSB1c2VkIHN1Y2Nlc3NmdWxseSB0bwpm
aW5kIHdoaWNoIHBhZ2VzIGhhdmUgYmVlbiB3cml0dGVuIHRvIGZyb20gdGhlIHRpbWUgdGhl
IHBhZ2VzIHdlcmUKd3JpdGUgcHJvdGVjdGVkLiBUaGlzIHdvcmtzIGp1c3QgbGlrZSB0aGUg
c29mdC1kaXJ0eSBmbGFnIHdpdGhvdXQKc2hvd2luZyBhbnkgZXh0cmEgcGFnZXMgd2hpY2gg
YXJlbid0IHNvZnQtZGlydHkgaW4gcmVhbGl0eS4KClRoZSBpbmZvcm1hdGlvbiByZWxhdGVk
IHRvIHBhZ2VzIGlmIHRoZSBwYWdlIGlzIGZpbGUgbWFwcGVkLCBwcmVzZW50IGFuZApzd2Fw
cGVkIGlzIHJlcXVpcmVkIGZvciB0aGUgQ1JJVSBwcm9qZWN0IFs1XVs2XS4gVGhlIGFkZGl0
aW9uIG9mIHRoZQpyZXF1aXJlZCBtYXNrLCBhbnkgbWFzaywgZXhjbHVkZWQgbWFzayBhbmQg
cmV0dXJuIG1hc2tzIGFyZSBhbHNvIHJlcXVpcmVkCmZvciB0aGUgQ1JJVSBwcm9qZWN0IFs1
XS4KClRoZSBJT0NUTCByZXR1cm5zIHRoZSBhZGRyZXNzZXMgb2YgdGhlIHBhZ2VzIHdoaWNo
IG1hdGNoIHRoZSBzcGVjaWZpYyBtYXNrcy4KVGhlIHBhZ2UgYWRkcmVzc2VzIGFyZSByZXR1
cm5lZCBpbiBzdHJ1Y3QgcGFnZV9yZWdpb24gaW4gYSBjb21wYWN0IGZvcm0uClRoZSBtYXhf
cGFnZXMgaXMgbmVlZGVkIHRvIHN1cHBvcnQgYSB1c2UgY2FzZSB3aGVyZSB1c2VyIG9ubHkg
d2FudHMgdG8gZ2V0CmEgc3BlY2lmaWMgbnVtYmVyIG9mIHBhZ2VzLiBTbyB0aGVyZSBpcyBu
byBuZWVkIHRvIGZpbmQgYWxsIHRoZSBwYWdlcyBvZgppbnRlcmVzdCBpbiB0aGUgcmFuZ2Ug
d2hlbiBtYXhfcGFnZXMgaXMgc3BlY2lmaWVkLiBUaGUgSU9DVEwgcmV0dXJucyB3aGVuCnRo
ZSBtYXhpbXVtIG51bWJlciBvZiB0aGUgcGFnZXMgYXJlIGZvdW5kLiBUaGUgbWF4X3BhZ2Vz
IGlzIG9wdGlvbmFsLiBJZgptYXhfcGFnZXMgaXMgc3BlY2lmaWVkLCBpdCBtdXN0IGJlIGVx
dWFsIG9yIGdyZWF0ZXIgdGhhbiB0aGUgdmVjX3NpemUuClRoaXMgcmVzdHJpY3Rpb24gaXMg
bmVlZGVkIHRvIGhhbmRsZSB3b3JzZSBjYXNlIHdoZW4gb25lIHBhZ2VfcmVnaW9uIG9ubHkK
Y29udGFpbnMgaW5mbyBvZiBvbmUgcGFnZSBhbmQgaXQgY2Fubm90IGJlIGNvbXBhY3RlZC4g
VGhpcyBpcyBuZWVkZWQgdG8KZW11bGF0ZSB0aGUgV2luZG93cyBnZXRXcml0ZVdhdGNoKCkg
c3lzY2FsbC4KClRoZSBwYXRjaCBzZXJpZXMgaW5jbHVkZSB0aGUgZGV0YWlsZWQgc2VsZnRl
c3Qgd2hpY2ggY2FuIGJlIHVzZWQgYXMgYW4gZXhhbXBsZQpmb3IgdGhlIHVmZmQgYXN5bmMg
d3AgdGVzdCBhbmQgUEFHRU1BUF9JT0NUTC4gSXQgc2hvd3MgdGhlIGludGVyZmFjZSB1c2Fn
ZXMgYXMKd2VsbC4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzU0ZDRjMzIy
LWNkNmUtZWVmZC1iMTYxLTJhZjJiNTZhYWUyNEBjb2xsYWJvcmEuY29tLwpbMl0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIxMjIwMTYyNjA2LjE1OTUzNTUtMS11c2FtYS5h
bmp1bUBjb2xsYWJvcmEuY29tClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MjExMjIxMTUwMDcuMjc4NzAxNy0xLXVzYW1hLmFuanVtQGNvbGxhYm9yYS5jb20KWzRdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZNkhjMmQrN2VUS3M3QWlIQHgxbgpbNV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1l5aURnNzlmbGhXb01EWkJAZ21haWwuY29tLwpb
Nl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIxMDE0MTM0ODAyLjEzNjE0MzYt
MS1tZGFueWxvQGdvb2dsZS5jb20vCgpSZWdhcmRzLApNdWhhbW1hZCBVc2FtYSBBbmp1bQoK
TXVoYW1tYWQgVXNhbWEgQW5qdW0gKDQpOgogIHVzZXJmYXVsdGZkOiBBZGQgVUZGRCBXUCBB
c3luYyBzdXBwb3J0CiAgdXNlcmZhdWx0ZmQ6IHNwbGl0IG13cml0ZXByb3RlY3RfcmFuZ2Uo
KQogIGZzL3Byb2MvdGFza19tbXU6IEltcGxlbWVudCBJT0NUTCB0byBnZXQgYW5kL29yIHRo
ZSBjbGVhciBpbmZvIGFib3V0CiAgICBQVEVzCiAgc2VsZnRlc3RzOiB2bTogYWRkIHBhZ2Vt
YXAgaW9jdGwgdGVzdHMKCiBmcy9wcm9jL3Rhc2tfbW11LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAyODMgKysrKysrKwogZnMvdXNlcmZhdWx0ZmQuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIxICsKIGluY2x1ZGUvbGludXgvdXNlcmZhdWx0ZmRfay5oICAgICAg
ICAgICAgICB8ICAxNyArCiBpbmNsdWRlL3VhcGkvbGludXgvZnMuaCAgICAgICAgICAgICAg
ICAgICAgfCAgNTAgKysKIGluY2x1ZGUvdWFwaS9saW51eC91c2VyZmF1bHRmZC5oICAgICAg
ICAgICB8ICAgOCArLQogbW0vbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDI5ICstCiBtbS91c2VyZmF1bHRmZC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNDAgKy0KIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9mcy5oICAgICAgICAgICAg
ICB8ICA1MCArKwogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vLmdpdGlnbm9yZSAgICAg
IHwgICAxICsKIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtL01ha2VmaWxlICAgICAgICB8
ICAgNSArLQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vcGFnZW1hcF9pb2N0bC5jIHwg
ODgwICsrKysrKysrKysrKysrKysrKysrKwogMTEgZmlsZXMgY2hhbmdlZCwgMTM2NCBpbnNl
cnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy92bS9wYWdlbWFwX2lvY3RsLmMKCi0tIAoyLjMwLjIKCg==
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-userfaultfd-Add-UFFD-WP-Async-support.patch"
Content-Disposition: attachment;
 filename="0001-userfaultfd-Add-UFFD-WP-Async-support.patch"
Content-Transfer-Encoding: base64

RnJvbSA1ZmI0NTkwMGJlNjEwNDkzNmQ4OGMzYTJlM2JkMTRlYTkzN2RkOTIwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogVHVlLCAzIEphbiAyMDIzIDEyOjQ3OjMxICswNTAw
ClN1YmplY3Q6IFtQQVRDSCBXSVAgdjkgMS80XSB1c2VyZmF1bHRmZDogQWRkIFVGRkQgV1Ag
QXN5bmMgc3VwcG9ydAoKQWRkIG5ldyBXUCBBc3luYyBtb2RlIChVRkZEX0ZFQVRVUkVfV1Bf
QVNZTkMpIHdoaWNoIHJlc29sdmVzIHRoZSBwYWdlCmZhdWx0cyBvbiBpdHMgb3duLiBJdCBj
YW4gYmUgdXNlZCB0byB0cmFjayB0aGF0IHdoaWNoIHBhZ2VzIGhhdmUgYmVlbgp3cml0dGVu
LXRvIGZyb20gdGhlIHRpbWUgdGhlIHBhZ2VzIHdlcmUgd3JpdGUtcHJvdGVjdGVkLiBJdCBp
cyB2ZXJ5CmVmZmljaWVudCB3YXkgdG8gdHJhY2sgdGhlIGNoYW5nZXMgYXMgdWZmZCBpcyBi
eSBuYXR1cmUgcHRlL3BtZCBiYXNlZC4KClVGRkQgc3luY2hyb25vdXMgV1Agc2VuZHMgdGhl
IHBhZ2UgZmF1bHRzIHRvIHRoZSB1c2Vyc3BhY2Ugd2hlcmUgdGhlCnBhZ2VzIHdoaWNoIGhh
dmUgYmVlbiB3cml0dGVuLXRvIGNhbiBiZSB0cmFja2VkLiBCdXQgaXQgaXMgbm90IGVmZmlj
aWVudC4KVGhpcyBpcyB3aHkgdGhpcyBhc3luY2hyb25vdXMgdmVyc2lvbiBpcyBiZWluZyBh
ZGRlZC4gQWZ0ZXIgc2V0dGluZyB0aGUKV1AgQXN5bmMsIHRoZSBwYWdlcyB3aGljaCBoYXZl
IGJlZW4gd3JpdHRlbiB0byBjYW4gYmUgZm91bmQgaW4gdGhlIHBhZ2VtYXAKZmlsZSBvciBp
bmZvcm1hdGlvbiBjYW4gYmUgb2J0YWluZWQgZnJvbSB0aGUgUEFHRU1BUF9JT0NUTC4KClN1
Z2dlc3RlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5qdW1AY29sbGFib3JhLmNvbT4KLS0t
CkNoYW5nZXMgaW4gdjc6Ci0gUmVtb3ZlIFVGRkRJT19XUklURVBST1RFQ1RfTU9ERV9BU1lO
Q19XUCBhbmQgYWRkIFVGRkRfRkVBVFVSRV9XUF9BU1lOQwotIEhhbmRsZSBhdXRvbWF0aWMg
cGFnZSBmYXVsdCByZXNvbHV0aW9uIGluIGJldHRlciB3YXkgKHRoYW5rcyB0byBQZXRlcikK
LS0tCiBmcy91c2VyZmF1bHRmZC5jICAgICAgICAgICAgICAgICB8IDExICsrKysrKysrKysr
CiBpbmNsdWRlL2xpbnV4L3VzZXJmYXVsdGZkX2suaCAgICB8ICA2ICsrKysrKwogaW5jbHVk
ZS91YXBpL2xpbnV4L3VzZXJmYXVsdGZkLmggfCAgOCArKysrKysrLQogbW0vbWVtb3J5LmMg
ICAgICAgICAgICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQogNCBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL3VzZXJmYXVsdGZkLmMgYi9mcy91c2VyZmF1bHRmZC5jCmluZGV4
IDE1YTViZjc2NWQ0My4uYzE3ODM1YTBlODQyIDEwMDY0NAotLS0gYS9mcy91c2VyZmF1bHRm
ZC5jCisrKyBiL2ZzL3VzZXJmYXVsdGZkLmMKQEAgLTE4NjcsNiArMTg2NywxMCBAQCBzdGF0
aWMgaW50IHVzZXJmYXVsdGZkX3dyaXRlcHJvdGVjdChzdHJ1Y3QgdXNlcmZhdWx0ZmRfY3R4
ICpjdHgsCiAJbW9kZV93cCA9IHVmZmRpb193cC5tb2RlICYgVUZGRElPX1dSSVRFUFJPVEVD
VF9NT0RFX1dQOwogCW1vZGVfZG9udHdha2UgPSB1ZmZkaW9fd3AubW9kZSAmIFVGRkRJT19X
UklURVBST1RFQ1RfTU9ERV9ET05UV0FLRTsKIAorCS8qIFRoZSB1bnByb3RlY3Rpb24gaXMg
bm90IHN1cHBvcnRlZCBpZiBpbiBhc3luYyBXUCBtb2RlICovCisJaWYgKCFtb2RlX3dwICYm
IChjdHgtPmZlYXR1cmVzICYgVUZGRF9GRUFUVVJFX1dQX0FTWU5DKSkKKwkJcmV0dXJuIC1F
SU5WQUw7CisKIAlpZiAobW9kZV93cCAmJiBtb2RlX2RvbnR3YWtlKQogCQlyZXR1cm4gLUVJ
TlZBTDsKIApAQCAtMTk1MCw2ICsxOTU0LDEzIEBAIHN0YXRpYyBpbnQgdXNlcmZhdWx0ZmRf
Y29udGludWUoc3RydWN0IHVzZXJmYXVsdGZkX2N0eCAqY3R4LCB1bnNpZ25lZCBsb25nIGFy
ZykKIAlyZXR1cm4gcmV0OwogfQogCitpbnQgdXNlcmZhdWx0ZmRfd3BfYXN5bmMoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEpCit7CisJc3RydWN0IHVzZXJmYXVsdGZkX2N0eCAqY3R4
ID0gdm1hLT52bV91c2VyZmF1bHRmZF9jdHguY3R4OworCisJcmV0dXJuIChjdHggJiYgKGN0
eC0+ZmVhdHVyZXMgJiBVRkZEX0ZFQVRVUkVfV1BfQVNZTkMpKTsKK30KKwogc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgdWZmZF9jdHhfZmVhdHVyZXMoX191NjQgdXNlcl9mZWF0dXJl
cykKIHsKIAkvKgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2VyZmF1bHRmZF9rLmgg
Yi9pbmNsdWRlL2xpbnV4L3VzZXJmYXVsdGZkX2suaAppbmRleCA5ZGYwYjlhNzYyY2MuLjk0
ZGNiNGRjMWI0YSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC91c2VyZmF1bHRmZF9rLmgK
KysrIGIvaW5jbHVkZS9saW51eC91c2VyZmF1bHRmZF9rLmgKQEAgLTE3OSw2ICsxNzksNyBA
QCBleHRlcm4gaW50IHVzZXJmYXVsdGZkX3VubWFwX3ByZXAoc3RydWN0IG1tX3N0cnVjdCAq
bW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCiAJCQkJICB1bnNpZ25lZCBsb25nIGVuZCwgc3Ry
dWN0IGxpc3RfaGVhZCAqdWYpOwogZXh0ZXJuIHZvaWQgdXNlcmZhdWx0ZmRfdW5tYXBfY29t
cGxldGUoc3RydWN0IG1tX3N0cnVjdCAqbW0sCiAJCQkJICAgICAgIHN0cnVjdCBsaXN0X2hl
YWQgKnVmKTsKK2V4dGVybiBpbnQgdXNlcmZhdWx0ZmRfd3BfYXN5bmMoc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEpOwogCiAjZWxzZSAvKiBDT05GSUdfVVNFUkZBVUxURkQgKi8KIApA
QCAtMjc0LDYgKzI3NSwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdWZmZF9kaXNhYmxlX2Zh
dWx0X2Fyb3VuZChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIAlyZXR1cm4gZmFsc2U7
CiB9CiAKK3N0YXRpYyBpbmxpbmUgaW50IHVzZXJmYXVsdGZkX3dwX2FzeW5jKHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hKQoreworCXJldHVybiBmYWxzZTsKK30KKwogI2VuZGlmIC8q
IENPTkZJR19VU0VSRkFVTFRGRCAqLwogCiBzdGF0aWMgaW5saW5lIGJvb2wgcHRlX21hcmtl
cl9lbnRyeV91ZmZkX3dwKHN3cF9lbnRyeV90IGVudHJ5KQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3VzZXJmYXVsdGZkLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdXNlcmZh
dWx0ZmQuaAppbmRleCAwMDVlNWUzMDYyNjYuLmY0MjUyZWY0MDA3MSAxMDA2NDQKLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3VzZXJmYXVsdGZkLmgKKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3VzZXJmYXVsdGZkLmgKQEAgLTM4LDcgKzM4LDggQEAKIAkJCSAgIFVGRkRfRkVBVFVS
RV9NSU5PUl9IVUdFVExCRlMgfAlcCiAJCQkgICBVRkZEX0ZFQVRVUkVfTUlOT1JfU0hNRU0g
fAkJXAogCQkJICAgVUZGRF9GRUFUVVJFX0VYQUNUX0FERFJFU1MgfAkJXAotCQkJICAgVUZG
RF9GRUFUVVJFX1dQX0hVR0VUTEJGU19TSE1FTSkKKwkJCSAgIFVGRkRfRkVBVFVSRV9XUF9I
VUdFVExCRlNfU0hNRU0gfAlcCisJCQkgICBVRkZEX0ZFQVRVUkVfV1BfQVNZTkMpCiAjZGVm
aW5lIFVGRkRfQVBJX0lPQ1RMUwkJCQlcCiAJKChfX3U2NCkxIDw8IF9VRkZESU9fUkVHSVNU
RVIgfAkJXAogCSAoX191NjQpMSA8PCBfVUZGRElPX1VOUkVHSVNURVIgfAlcCkBAIC0yMDMs
NiArMjA0LDEwIEBAIHN0cnVjdCB1ZmZkaW9fYXBpIHsKIAkgKgogCSAqIFVGRkRfRkVBVFVS
RV9XUF9IVUdFVExCRlNfU0hNRU0gaW5kaWNhdGVzIHRoYXQgdXNlcmZhdWx0ZmQKIAkgKiB3
cml0ZS1wcm90ZWN0aW9uIG1vZGUgaXMgc3VwcG9ydGVkIG9uIGJvdGggc2htZW0gYW5kIGh1
Z2V0bGJmcy4KKwkgKgorCSAqIFVGRkRfRkVBVFVSRV9XUF9BU1lOQyBpbmRpY2F0ZXMgdGhh
dCB1c2VyZmF1bHRmZCB3cml0ZS1wcm90ZWN0aW9uCisJICogYXN5bmNocm9ub3VzIG1vZGUg
aXMgc3VwcG9ydGVkIGluIHdoaWNoIHRoZSB3cml0ZSBmYXVsdCBpcyBhdXRvbWF0aWNhbGx5
CisJICogcmVzb2x2ZWQgYW5kIHdyaXRlLXByb3RlY3Rpb24gaXMgdW4tc2V0LgogCSAqLwog
I2RlZmluZSBVRkZEX0ZFQVRVUkVfUEFHRUZBVUxUX0ZMQUdfV1AJCSgxPDwwKQogI2RlZmlu
ZSBVRkZEX0ZFQVRVUkVfRVZFTlRfRk9SSwkJCSgxPDwxKQpAQCAtMjE3LDYgKzIyMiw3IEBA
IHN0cnVjdCB1ZmZkaW9fYXBpIHsKICNkZWZpbmUgVUZGRF9GRUFUVVJFX01JTk9SX1NITUVN
CQkoMTw8MTApCiAjZGVmaW5lIFVGRkRfRkVBVFVSRV9FWEFDVF9BRERSRVNTCQkoMTw8MTEp
CiAjZGVmaW5lIFVGRkRfRkVBVFVSRV9XUF9IVUdFVExCRlNfU0hNRU0JCSgxPDwxMikKKyNk
ZWZpbmUgVUZGRF9GRUFUVVJFX1dQX0FTWU5DCQkJKDE8PDEzKQogCV9fdTY0IGZlYXR1cmVz
OwogCiAJX191NjQgaW9jdGxzOwpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1v
cnkuYwppbmRleCA0MDAwZTlmMDE3ZTAuLmRhNTNmYjUzZGRiNyAxMDA2NDQKLS0tIGEvbW0v
bWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTMzNTEsNiArMzM1MSwxOCBAQCBzdGF0
aWMgdm1fZmF1bHRfdCBkb193cF9wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogCiAJaWYg
KGxpa2VseSghdW5zaGFyZSkpIHsKIAkJaWYgKHVzZXJmYXVsdGZkX3B0ZV93cCh2bWEsICp2
bWYtPnB0ZSkpIHsKKwkJCWlmICh1c2VyZmF1bHRmZF93cF9hc3luYyh2bWEpKSB7CisJCQkJ
LyoKKwkJCQkgKiBOb3RoaW5nIG5lZWRlZCAoY2FjaGUgZmx1c2gsIFRMQiBpbnZhbGlkYXRp
b25zLAorCQkJCSAqIGV0Yy4pIGJlY2F1c2Ugd2UncmUgb25seSByZW1vdmluZyB0aGUgdWZm
ZC13cCBiaXQsCisJCQkJICogd2hpY2ggaXMgY29tcGxldGVseSBpbnZpc2libGUgdG8gdGhl
IHVzZXIuIFRoaXMKKwkJCQkgKiBmYWxscyB0aHJvdWdoIHRvIHBvc3NpYmxlIENvVy4KKwkJ
CQkgKi8KKwkJCQlzZXRfcHRlX2F0KHZtYS0+dm1fbW0sIHZtZi0+YWRkcmVzcywgdm1mLT5w
dGUsCisJCQkJCSAgIHB0ZV9jbGVhcl91ZmZkX3dwKCp2bWYtPnB0ZSkpOworCQkJCXB0ZV91
bm1hcF91bmxvY2sodm1mLT5wdGUsIHZtZi0+cHRsKTsKKwkJCQlyZXR1cm4gMDsKKwkJCX0K
IAkJCXB0ZV91bm1hcF91bmxvY2sodm1mLT5wdGUsIHZtZi0+cHRsKTsKIAkJCXJldHVybiBo
YW5kbGVfdXNlcmZhdWx0KHZtZiwgVk1fVUZGRF9XUCk7CiAJCX0KQEAgLTQ4MTIsOCArNDgy
NCwyMSBAQCBzdGF0aWMgaW5saW5lIHZtX2ZhdWx0X3Qgd3BfaHVnZV9wbWQoc3RydWN0IHZt
X2ZhdWx0ICp2bWYpCiAKIAlpZiAodm1hX2lzX2Fub255bW91cyh2bWYtPnZtYSkpIHsKIAkJ
aWYgKGxpa2VseSghdW5zaGFyZSkgJiYKLQkJICAgIHVzZXJmYXVsdGZkX2h1Z2VfcG1kX3dw
KHZtZi0+dm1hLCB2bWYtPm9yaWdfcG1kKSkKLQkJCXJldHVybiBoYW5kbGVfdXNlcmZhdWx0
KHZtZiwgVk1fVUZGRF9XUCk7CisJCSAgICB1c2VyZmF1bHRmZF9odWdlX3BtZF93cCh2bWYt
PnZtYSwgdm1mLT5vcmlnX3BtZCkpIHsKKwkJCWlmICh1c2VyZmF1bHRmZF93cF9hc3luYyh2
bWYtPnZtYSkpIHsKKwkJCQkvKgorCQkJCSAqIE5vdGhpbmcgbmVlZGVkIChjYWNoZSBmbHVz
aCwgVExCIGludmFsaWRhdGlvbnMsCisJCQkJICogZXRjLikgYmVjYXVzZSB3ZSdyZSBvbmx5
IHJlbW92aW5nIHRoZSB1ZmZkLXdwIGJpdCwKKwkJCQkgKiB3aGljaCBpcyBjb21wbGV0ZWx5
IGludmlzaWJsZSB0byB0aGUgdXNlci4gVGhpcworCQkJCSAqIGZhbGxzIHRocm91Z2ggdG8g
cG9zc2libGUgQ29XLgorCQkJCSAqLworCQkJCXNldF9wbWRfYXQodm1mLT52bWEtPnZtX21t
LCB2bWYtPmFkZHJlc3MsIHZtZi0+cG1kLAorCQkJCQkgICBwbWRfY2xlYXJfdWZmZF93cCgq
dm1mLT5wbWQpKTsKKwkJCQlyZXR1cm4gMDsKKwkJCX0gZWxzZSB7CisJCQkJcmV0dXJuIGhh
bmRsZV91c2VyZmF1bHQodm1mLCBWTV9VRkZEX1dQKTsKKwkJCX0KKwkJfQogCQlyZXR1cm4g
ZG9faHVnZV9wbWRfd3BfcGFnZSh2bWYpOwogCX0KIAotLSAKMi4zMC4yCgo=
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-userfaultfd-split-mwriteprotect_range.patch"
Content-Disposition: attachment;
 filename="0002-userfaultfd-split-mwriteprotect_range.patch"
Content-Transfer-Encoding: base64

RnJvbSBlZTAzNjQ1NzQ0ZTMxMjlmYjkzMDIyYmZlYjAwM2I4OTI1MjkyM2FjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogVHVlLCAzIEphbiAyMDIzIDEyOjQ4OjU5ICswNTAw
ClN1YmplY3Q6IFtQQVRDSCBXSVAgdjkgMi80XSB1c2VyZmF1bHRmZDogc3BsaXQgbXdyaXRl
cHJvdGVjdF9yYW5nZSgpCgpTcGxpdCBtd3JpdGVwcm90ZWN0X3JhbmdlKCkgdG8gY3JlYXRl
IGEgdW5sb2NrZWQgdmVyc2lvbi4gVGhpcwp3aWxsIGJlIHVzZWQgaW4gdGhlIG5leHQgcGF0
Y2ggdG8gd3JpdGUgcHJvdGVjdCBhIG1lbW9yeSBhcmVhLgpBZGQgYSBoZWxwZXIgZnVuY3Rp
b24sIHdwX3JhbmdlX2FzeW5jKCkgYXMgd2VsbC4KClNpZ25lZC1vZmYtYnk6IE11aGFtbWFk
IFVzYW1hIEFuanVtIDx1c2FtYS5hbmp1bUBjb2xsYWJvcmEuY29tPgotLS0KQ2hhbmdlcyBp
biB2NzoKLSBSZW1vdmUgYXN5bmMgYmVpbmcgc2V0IGluIHRoZSBQQUdFTUFQX0lPQ1RMCi0t
LQogZnMvdXNlcmZhdWx0ZmQuYyAgICAgICAgICAgICAgfCAxMCArKysrKysrKysKIGluY2x1
ZGUvbGludXgvdXNlcmZhdWx0ZmRfay5oIHwgMTEgKysrKysrKysrKwogbW0vdXNlcmZhdWx0
ZmQuYyAgICAgICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy91c2VyZmF1bHRmZC5jIGIvZnMvdXNlcmZhdWx0ZmQuYwpp
bmRleCBjMTc4MzVhMGU4NDIuLjg3OTFhMmQzNzFjMSAxMDA2NDQKLS0tIGEvZnMvdXNlcmZh
dWx0ZmQuYworKysgYi9mcy91c2VyZmF1bHRmZC5jCkBAIC0xOTYxLDYgKzE5NjEsMTYgQEAg
aW50IHVzZXJmYXVsdGZkX3dwX2FzeW5jKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQog
CXJldHVybiAoY3R4ICYmIChjdHgtPmZlYXR1cmVzICYgVUZGRF9GRUFUVVJFX1dQX0FTWU5D
KSk7CiB9CiAKK2ludCB3cF9yYW5nZV9hc3luYyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBsZW4pCit7CisJc3RydWN0
IHVzZXJmYXVsdGZkX2N0eCAqY3R4ID0gdm1hLT52bV91c2VyZmF1bHRmZF9jdHguY3R4Owor
CisJaWYgKCFjdHgpCisJCXJldHVybiAtMTsKKworCXJldHVybiBfX213cml0ZXByb3RlY3Rf
cmFuZ2UoY3R4LT5tbSwgc3RhcnQsIGxlbiwgdHJ1ZSwgJmN0eC0+bW1hcF9jaGFuZ2luZyk7
Cit9CisKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHVmZmRfY3R4X2ZlYXR1cmVzKF9f
dTY0IHVzZXJfZmVhdHVyZXMpCiB7CiAJLyoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dXNlcmZhdWx0ZmRfay5oIGIvaW5jbHVkZS9saW51eC91c2VyZmF1bHRmZF9rLmgKaW5kZXgg
OTRkY2I0ZGMxYjRhLi43NjQwN2QyMWQwM2IgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
dXNlcmZhdWx0ZmRfay5oCisrKyBiL2luY2x1ZGUvbGludXgvdXNlcmZhdWx0ZmRfay5oCkBA
IC03Myw2ICs3Myw5IEBAIGV4dGVybiBzc2l6ZV90IG1jb3B5X2NvbnRpbnVlKHN0cnVjdCBt
bV9zdHJ1Y3QgKmRzdF9tbSwgdW5zaWduZWQgbG9uZyBkc3Rfc3RhcnQsCiBleHRlcm4gaW50
IG13cml0ZXByb3RlY3RfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLAogCQkJICAg
ICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgbGVuLAogCQkJICAgICAg
IGJvb2wgZW5hYmxlX3dwLCBhdG9taWNfdCAqbW1hcF9jaGFuZ2luZyk7CitleHRlcm4gaW50
IF9fbXdyaXRlcHJvdGVjdF9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sCisJCQkJ
IHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgbGVuLAorCQkJCSBib29sIGVu
YWJsZV93cCwgYXRvbWljX3QgKm1tYXBfY2hhbmdpbmcpOwogZXh0ZXJuIHZvaWQgdWZmZF93
cF9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqdm1hLAogCQkJICB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGxlbiwg
Ym9vbCBlbmFibGVfd3ApOwogCkBAIC0xODAsNiArMTgzLDggQEAgZXh0ZXJuIGludCB1c2Vy
ZmF1bHRmZF91bm1hcF9wcmVwKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25n
IHN0YXJ0LAogZXh0ZXJuIHZvaWQgdXNlcmZhdWx0ZmRfdW5tYXBfY29tcGxldGUoc3RydWN0
IG1tX3N0cnVjdCAqbW0sCiAJCQkJICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKnVmKTsKIGV4
dGVybiBpbnQgdXNlcmZhdWx0ZmRfd3BfYXN5bmMoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEpOworZXh0ZXJuIGludCB3cF9yYW5nZV9hc3luYyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwKKwkJCSAgdW5zaWduZWQgbG9uZyBsZW4pOwog
CiAjZWxzZSAvKiBDT05GSUdfVVNFUkZBVUxURkQgKi8KIApAQCAtMjgwLDYgKzI4NSwxMiBA
QCBzdGF0aWMgaW5saW5lIGludCB1c2VyZmF1bHRmZF93cF9hc3luYyhzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSkKIAlyZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBpbmxpbmUgaW50
IHdwX3JhbmdlX2FzeW5jKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBs
b25nIHN0YXJ0LAorCQkJCSB1bnNpZ25lZCBsb25nIGxlbikKK3sKKwlyZXR1cm4gLTE7Cit9
CisKICNlbmRpZiAvKiBDT05GSUdfVVNFUkZBVUxURkQgKi8KIAogc3RhdGljIGlubGluZSBi
b29sIHB0ZV9tYXJrZXJfZW50cnlfdWZmZF93cChzd3BfZW50cnlfdCBlbnRyeSkKZGlmZiAt
LWdpdCBhL21tL3VzZXJmYXVsdGZkLmMgYi9tbS91c2VyZmF1bHRmZC5jCmluZGV4IDY1YWQx
NzJhZGQyNy4uOWQ4YTQzZmFmNzY0IDEwMDY0NAotLS0gYS9tbS91c2VyZmF1bHRmZC5jCisr
KyBiL21tL3VzZXJmYXVsdGZkLmMKQEAgLTczNCwyNSArNzM0LDEzIEBAIHZvaWQgdWZmZF93
cF9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqZHN0X3ZtYSwKIAl0bGJfZmluaXNoX21tdSgmdGxiKTsKIH0KIAotaW50IG13cml0ZXBy
b3RlY3RfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCB1bnNpZ25lZCBsb25nIHN0
YXJ0LAotCQkJdW5zaWduZWQgbG9uZyBsZW4sIGJvb2wgZW5hYmxlX3dwLAotCQkJYXRvbWlj
X3QgKm1tYXBfY2hhbmdpbmcpCitpbnQgX19td3JpdGVwcm90ZWN0X3JhbmdlKHN0cnVjdCBt
bV9zdHJ1Y3QgKmRzdF9tbSwgdW5zaWduZWQgbG9uZyBzdGFydCwKKwkJCSAgdW5zaWduZWQg
bG9uZyBsZW4sIGJvb2wgZW5hYmxlX3dwLAorCQkJICBhdG9taWNfdCAqbW1hcF9jaGFuZ2lu
ZykKIHsKIAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmRzdF92bWE7CiAJdW5zaWduZWQgbG9u
ZyBwYWdlX21hc2s7CiAJaW50IGVycjsKLQotCS8qCi0JICogU2FuaXRpemUgdGhlIGNvbW1h
bmQgcGFyYW1ldGVyczoKLQkgKi8KLQlCVUdfT04oc3RhcnQgJiB+UEFHRV9NQVNLKTsKLQlC
VUdfT04obGVuICYgflBBR0VfTUFTSyk7Ci0KLQkvKiBEb2VzIHRoZSBhZGRyZXNzIHJhbmdl
IHdyYXAsIG9yIGlzIHRoZSBzcGFuIHplcm8tc2l6ZWQ/ICovCi0JQlVHX09OKHN0YXJ0ICsg
bGVuIDw9IHN0YXJ0KTsKLQotCW1tYXBfcmVhZF9sb2NrKGRzdF9tbSk7Ci0KIAkvKgogCSAq
IElmIG1lbW9yeSBtYXBwaW5ncyBhcmUgY2hhbmdpbmcgYmVjYXVzZSBvZiBub24tY29vcGVy
YXRpdmUKIAkgKiBvcGVyYXRpb24gKGUuZy4gbXJlbWFwKSBydW5uaW5nIGluIHBhcmFsbGVs
LCBiYWlsIG91dCBhbmQKQEAgLTc4Myw2ICs3NzEsMjggQEAgaW50IG13cml0ZXByb3RlY3Rf
cmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCB1bnNpZ25lZCBsb25nIHN0YXJ0LAog
CiAJZXJyID0gMDsKIG91dF91bmxvY2s6CisJcmV0dXJuIGVycjsKK30KKworaW50IG13cml0
ZXByb3RlY3RfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCB1bnNpZ25lZCBsb25n
IHN0YXJ0LAorCQkJdW5zaWduZWQgbG9uZyBsZW4sIGJvb2wgZW5hYmxlX3dwLAorCQkJYXRv
bWljX3QgKm1tYXBfY2hhbmdpbmcpCit7CisJaW50IGVycjsKKworCS8qCisJICogU2FuaXRp
emUgdGhlIGNvbW1hbmQgcGFyYW1ldGVyczoKKwkgKi8KKwlCVUdfT04oc3RhcnQgJiB+UEFH
RV9NQVNLKTsKKwlCVUdfT04obGVuICYgflBBR0VfTUFTSyk7CisKKwkvKiBEb2VzIHRoZSBh
ZGRyZXNzIHJhbmdlIHdyYXAsIG9yIGlzIHRoZSBzcGFuIHplcm8tc2l6ZWQ/ICovCisJQlVH
X09OKHN0YXJ0ICsgbGVuIDw9IHN0YXJ0KTsKKworCW1tYXBfcmVhZF9sb2NrKGRzdF9tbSk7
CisKKwllcnIgPSBfX213cml0ZXByb3RlY3RfcmFuZ2UoZHN0X21tLCBzdGFydCwgbGVuLCBl
bmFibGVfd3AsIG1tYXBfY2hhbmdpbmcpOworCiAJbW1hcF9yZWFkX3VubG9jayhkc3RfbW0p
OwogCXJldHVybiBlcnI7CiB9Ci0tIAoyLjMwLjIKCg==
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-fs-proc-task_mmu-Implement-IOCTL-to-get-and-or-the-c.patch"
Content-Disposition: attachment;
 filename*0="0003-fs-proc-task_mmu-Implement-IOCTL-to-get-and-or-the-c.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZjQ0NTNhZjMxYTA1MDRjYzA5NjQ3YmJmZmZjMTFlYWY4MGIwN2I4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogVHVlLCAzIEphbiAyMDIzIDEyOjUwOjIxICswNTAw
ClN1YmplY3Q6IFtQQVRDSCBXSVAgdjkgMy80XSBmcy9wcm9jL3Rhc2tfbW11OiBJbXBsZW1l
bnQgSU9DVEwgdG8gZ2V0IGFuZC9vcgogdGhlIGNsZWFyIGluZm8gYWJvdXQgUFRFcwoKVGhp
cyBJT0NUTCwgUEFHRU1BUF9TQ0FOIG9uIHBhZ2VtYXAgZmlsZSBjYW4gYmUgdXNlZCB0byBn
ZXQgYW5kL29yIGNsZWFyCnRoZSBpbmZvIGFib3V0IHBhZ2UgdGFibGUgZW50cmllcy4gVGhl
IGZvbGxvd2luZyBvcGVyYXRpb25zIGFyZSBzdXBwb3J0ZWQKaW4gdGhpcyBpb2N0bDoKLSBH
ZXQgdGhlIGluZm9ybWF0aW9uIGlmIHRoZSBwYWdlcyBoYXZlIGJlZW4gd3JpdHRlbi10byAo
UEFHRV9JU19XVCksCiAgZmlsZSBtYXBwZWQgKFBBR0VfSVNfRklMRSksIHByZXNlbnQgKFBB
R0VfSVNfUFJFU0VOVCkgb3Igc3dhcHBlZAogIChQQUdFX0lTX1NXQVBQRUQpLgotIFdyaXRl
LXByb3RlY3QgdGhlIHBhZ2VzIChQQUdFTUFQX1dQX0VOR0FHRSkgdG8gc3RhcnQgZmluZGlu
ZyB3aGljaAogIHBhZ2VzIGhhdmUgYmVlbiB3cml0dGVuLXRvLgotIEZpbmQgcGFnZXMgd2hp
Y2ggaGF2ZSBiZWVuIHdyaXR0ZW4tdG8gYW5kIHdyaXRlIHByb3RlY3QgdGhlIHBhZ2VzCiAg
KGF0b21pYyBQQUdFX0lTX1dUICsgUEFHRU1BUF9XUF9FTkdBR0UpCgpUaGUgdWZmZCBzaG91
bGQgaGF2ZSBiZWVuIHJlZ2lzdGVyZWQgb24gdGhlIG1lbW9yeSByYW5nZSBiZWZvcmUgcGVy
Zm9ybWluZwphbnkgV1AvV1QgKFdyaXRlIFByb3RlY3QvV3JpdHRlcm4tVG8pIHJlbGF0ZWQg
b3BlcmF0aW9ucyB3aXRoIHRoZSBJT0NUTC4KCnN0cnVjdCBwYWdlbWFwX3NjYW5fYXJncyBp
cyB1c2VkIGFzIHRoZSBhcmd1bWVudCBvZiB0aGUgSU9DVEwuIEluIHRoaXMKc3RydWN0Ogot
IFRoZSByYW5nZSBpcyBzcGVjaWZpZWQgdGhyb3VnaCBzdGFydCBhbmQgbGVuLgotIFRoZSBv
dXRwdXQgYnVmZmVyIG9mIHN0cnVjdCBwYWdlX3JlZ2lvbiBhcnJheSBhbmQgc2l6ZSBpcyBz
cGVjaWZpZWQgYXMKICB2ZWMgYW5kIHZlY19sZW4uCi0gVGhlIG9wdGlvbmFsIG1heGltdW0g
cmVxdWVzdGVkIHBhZ2VzIGFyZSBzcGVjaWZpZWQgaW4gdGhlIG1heF9wYWdlcy4KLSBUaGUg
ZmxhZ3MgY2FuIGJlIHNwZWNpZmllZCBpbiB0aGUgZmxhZ3MgZmllbGQuIFRoZSBQQUdFTUFQ
X1dQX0VOR0FHRQogIGlzIHRoZSBvbmx5IGFkZGVkIGZsYWcgYXQgdGhpcyB0aW1lLgotIFRo
ZSBtYXNrcyBhcmUgc3BlY2lmaWVkIGluIHJlcXVpcmVkX21hc2ssIGFueW9mX21hc2ssIGV4
Y2x1ZGVkXyBtYXNrCiAgYW5kIHJldHVybl9tYXNrLgoKVGhpcyBJT0NUTCBjYW4gYmUgZXh0
ZW5kZWQgdG8gZ2V0IGluZm9ybWF0aW9uIGFib3V0IG1vcmUgUFRFIGJpdHMuIFRoaXMKSU9D
VEwgZG9lc24ndCBzdXBwb3J0IGh1Z2V0bGJzIGF0IHRoZSBtb21lbnQuIE5vIGluZm9ybWF0
aW9uIGFib3V0Cmh1Z2V0bGIgY2FuIGJlIG9idGFpbmVkLiBUaGlzIHBhdGNoIGhhcyBldm9s
dmVkIGZyb20gYSBiYXNpYyBwYXRjaCBmcm9tCkdhYnJpZWwgS3Jpc21hbiBCZXJ0YXppLgoK
U2lnbmVkLW9mZi1ieTogTXVoYW1tYWQgVXNhbWEgQW5qdW0gPHVzYW1hLmFuanVtQGNvbGxh
Ym9yYS5jb20+Ci0tLQpDaGFuZ2UgaW4gdjg6Ci0gQ29ycmVjdCBpc19wdGVfdWZmZF93cCgp
Ci0gSW1wcm92ZSByZWFkYWJpbGl0eSBhbmQgZXJyb3IgY2hlY2tzCi0gUmVtb3ZlIHNvbWUg
dW4tbmVlZGVkIGNvZGUKCkNoYW5nZXMgaW4gdjc6Ci0gUmViYXNlIG9uIHRvcCBvZiBsYXRl
c3QgbmV4dAotIEZpeCBzb21lIGNvcm5lciBjYXNlcwotIEJhc2Ugc29mdC1kaXJ0eSBvbiB0
aGUgdWZmZCB3cCBhc3luYwotIFVwZGF0ZSB0aGUgdGVybWlub2xvZ2llcwotIE9wdGltaXpl
IHRoZSBtZW1vcnkgdXNhZ2UgaW5zaWRlIHRoZSBpb2N0bAoKQ2hhbmdlcyBpbiB2NjoKLSBS
ZW5hbWUgdmFyaWFibGVzIGFuZCB1cGRhdGUgY29tbWVudHMKLSBNYWtlIElPQ1RMIGluZGVw
ZW5kZW50IG9mIHNvZnRfZGlydHkgY29uZmlnCi0gQ2hhbmdlIG1hc2tzIGFuZCBiaXRtYXAg
dHlwZSB0byBfdTY0Ci0gSW1wcm92ZSBjb2RlIHF1YWxpdHkKCkNoYW5nZXMgaW4gdjU6Ci0g
UmVtb3ZlIHRsYiBmbHVzaGluZyBldmVuIGZvciBjbGVhciBvcGVyYXRpb24KCkNoYW5nZXMg
aW4gdjQ6Ci0gVXBkYXRlIHRoZSBpbnRlcmZhY2UgYW5kIGltcGxlbWVudGF0aW9uCgpDaGFu
Z2VzIGluIHYzOgotIFRpZ2h0ZW4gdGhlIHVzZXIta2VybmVsIGludGVyZmFjZSBieSB1c2lu
ZyBleHBsaWNpdCB0eXBlcyBhbmQgYWRkIG1vcmUKICBlcnJvciBjaGVja2luZwoKQ2hhbmdl
cyBpbiB2MjoKLSBDb252ZXJ0IHRoZSBpbnRlcmZhY2UgZnJvbSBzeXNjYWxsIHRvIGlvY3Rs
Ci0gUmVtb3ZlIHBpZGZkIHN1cHBvcnQgYXMgaXQgZG9lc24ndCBtYWtlIHNlbnNlIGluIGlv
Y3RsCi0tLQogZnMvcHJvYy90YXNrX21tdS5jICAgICAgICAgICAgfCAyODMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmggICAg
ICAgfCAgNTAgKysrKysrCiB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvZnMuaCB8ICA1MCAr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMzgzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9wcm9jL3Rhc2tfbW11LmMKaW5kZXggZTM1YTAz
OThkYjYzLi42NGE2NTk3YWVjMDYgMTAwNjQ0Ci0tLSBhL2ZzL3Byb2MvdGFza19tbXUuYwor
KysgYi9mcy9wcm9jL3Rhc2tfbW11LmMKQEAgLTE5LDYgKzE5LDcgQEAKICNpbmNsdWRlIDxs
aW51eC9zaG1lbV9mcy5oPgogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KICNpbmNsdWRl
IDxsaW51eC9wa2V5cy5oPgorI2luY2x1ZGUgPGxpbnV4L21pbm1heC5oPgogCiAjaW5jbHVk
ZSA8YXNtL2VsZi5oPgogI2luY2x1ZGUgPGFzbS90bGIuaD4KQEAgLTExMzUsNiArMTEzNiwy
MiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xlYXJfc29mdF9kaXJ0eShzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSwKIH0KICNlbmRpZgogCitzdGF0aWMgaW5saW5lIGJvb2wgaXNfcHRl
X3VmZmRfd3AocHRlX3QgcHRlKQoreworCWlmICgocHRlX3ByZXNlbnQocHRlKSAmJiBwdGVf
dWZmZF93cChwdGUpKSB8fAorCSAgICAoaXNfc3dhcF9wdGUocHRlKSAmJiBwdGVfc3dwX3Vm
ZmRfd3BfYW55KHB0ZSkpKQorCQlyZXR1cm4gdHJ1ZTsKKwlyZXR1cm4gZmFsc2U7Cit9CisK
K3N0YXRpYyBpbmxpbmUgYm9vbCBpc19wbWRfdWZmZF93cChwbWRfdCBwbWQpCit7CisJaWYg
KChwbWRfcHJlc2VudChwbWQpICYmIHBtZF91ZmZkX3dwKHBtZCkpIHx8CisJICAgIChpc19z
d2FwX3BtZChwbWQpICYmIHBtZF9zd3BfdWZmZF93cChwbWQpKSkKKwkJcmV0dXJuIHRydWU7
CisJcmV0dXJuIGZhbHNlOworfQorCiAjaWYgZGVmaW5lZChDT05GSUdfTUVNX1NPRlRfRElS
VFkpICYmIGRlZmluZWQoQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFKQogc3RhdGljIGlu
bGluZSB2b2lkIGNsZWFyX3NvZnRfZGlydHlfcG1kKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLAogCQl1bnNpZ25lZCBsb25nIGFkZHIsIHBtZF90ICpwbWRwKQpAQCAtMTc2MywxMSAr
MTc4MCwyNzcgQEAgc3RhdGljIGludCBwYWdlbWFwX3JlbGVhc2Uoc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJcmV0dXJuIDA7CiB9CiAKKyNkZWZpbmUgUEFH
RU1BUF9PUF9NQVNLCQkoUEFHRV9JU19XVCB8IFBBR0VfSVNfRklMRSB8CVwKKwkJCQkgUEFH
RV9JU19QUkVTRU5UIHwgUEFHRV9JU19TV0FQUEVEKQorI2RlZmluZSBQQUdFTUFQX05PTldU
X09QX01BU0sJKFBBR0VfSVNfRklMRSB8CVBBR0VfSVNfUFJFU0VOVCB8IFBBR0VfSVNfU1dB
UFBFRCkKKyNkZWZpbmUgSVNfV1BfRU5HQUdFX09QKGEpCShhLT5mbGFncyAmIFBBR0VNQVBf
V1BfRU5HQUdFKQorI2RlZmluZSBJU19HRVRfT1AoYSkJCShhLT52ZWMpCisjZGVmaW5lIFBB
R0VNQVBfU0NBTl9CSVRNQVAod3QsIGZpbGUsIHByZXNlbnQsIHN3YXApCVwKKwkod3QgfCBm
aWxlIDw8IDEgfCBwcmVzZW50IDw8IDIgfCBzd2FwIDw8IDMpCisjZGVmaW5lIElTX1dUX1JF
UVVJUkVEKGEpCQkJCVwKKwkoKGEtPnJlcXVpcmVkX21hc2sgJiBQQUdFX0lTX1dUKSB8fAlc
CisJIChhLT5hbnlvZl9tYXNrICYgUEFHRV9JU19XVCkpCisjZGVmaW5lIEhBU19OT19TUEFD
RShwKQkJKHAtPm1heF9wYWdlcyAmJiAocC0+Zm91bmRfcGFnZXMgPT0gcC0+bWF4X3BhZ2Vz
KSkKKworc3RydWN0IHBhZ2VtYXBfc2Nhbl9wcml2YXRlIHsKKwlzdHJ1Y3QgcGFnZV9yZWdp
b24gKnZlYzsKKwlzdHJ1Y3QgcGFnZV9yZWdpb24gcHJldjsKKwl1bnNpZ25lZCBsb25nIHZl
Y19sZW4sIHZlY19pbmRleDsKKwl1bnNpZ25lZCBpbnQgbWF4X3BhZ2VzLCBmb3VuZF9wYWdl
cywgZmxhZ3M7CisJdW5zaWduZWQgbG9uZyByZXF1aXJlZF9tYXNrLCBhbnlvZl9tYXNrLCBl
eGNsdWRlZF9tYXNrLCByZXR1cm5fbWFzazsKK307CisKK3N0YXRpYyBpbnQgcGFnZW1hcF9z
Y2FuX3Rlc3Rfd2Fsayh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCwg
c3RydWN0IG1tX3dhbGsgKndhbGspCit7CisJc3RydWN0IHBhZ2VtYXBfc2Nhbl9wcml2YXRl
ICpwID0gd2Fsay0+cHJpdmF0ZTsKKwlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHdh
bGstPnZtYTsKKworCWlmIChJU19XVF9SRVFVSVJFRChwKSAmJiAhdXNlcmZhdWx0ZmRfd3Ao
dm1hKSAmJiAhdXNlcmZhdWx0ZmRfd3BfYXN5bmModm1hKSkKKwkJcmV0dXJuIC1FUEVSTTsK
KwlpZiAodm1hLT52bV9mbGFncyAmIFZNX1BGTk1BUCkKKwkJcmV0dXJuIDE7CisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IGFkZF90b19vdXQoYm9vbCB3dCwgYm9vbCBm
aWxlLCBib29sIHByZXMsIGJvb2wgc3dhcCwKKwkJCSAgICAgc3RydWN0IHBhZ2VtYXBfc2Nh
bl9wcml2YXRlICpwLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGludCBsZW4pCit7
CisJdW5zaWduZWQgbG9uZyBiaXRtYXAsIGN1ciA9IFBBR0VNQVBfU0NBTl9CSVRNQVAod3Qs
IGZpbGUsIHByZXMsIHN3YXApOworCWJvb2wgY3B5ID0gdHJ1ZTsKKwlzdHJ1Y3QgcGFnZV9y
ZWdpb24gKnByZXYgPSAmcC0+cHJldjsKKworCWlmIChIQVNfTk9fU1BBQ0UocCkpCisJCXJl
dHVybiAtRU5PU1BDOworCisJaWYgKHAtPm1heF9wYWdlcyAmJiBwLT5mb3VuZF9wYWdlcyAr
IGxlbiA+PSBwLT5tYXhfcGFnZXMpCisJCWxlbiA9IHAtPm1heF9wYWdlcyAtIHAtPmZvdW5k
X3BhZ2VzOworCWlmICghbGVuKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWlmIChwLT5yZXF1
aXJlZF9tYXNrKQorCQljcHkgPSAoKHAtPnJlcXVpcmVkX21hc2sgJiBjdXIpID09IHAtPnJl
cXVpcmVkX21hc2spOworCWlmIChjcHkgJiYgcC0+YW55b2ZfbWFzaykKKwkJY3B5ID0gKHAt
PmFueW9mX21hc2sgJiBjdXIpOworCWlmIChjcHkgJiYgcC0+ZXhjbHVkZWRfbWFzaykKKwkJ
Y3B5ID0gIShwLT5leGNsdWRlZF9tYXNrICYgY3VyKTsKKwliaXRtYXAgPSBjdXIgJiBwLT5y
ZXR1cm5fbWFzazsKKwlpZiAoY3B5ICYmIGJpdG1hcCkgeworCQlpZiAoKHByZXYtPmxlbikg
JiYgKHByZXYtPmJpdG1hcCA9PSBiaXRtYXApICYmCisJCSAgICAocHJldi0+c3RhcnQgKyBw
cmV2LT5sZW4gKiBQQUdFX1NJWkUgPT0gYWRkcikpIHsKKwkJCXByZXYtPmxlbiArPSBsZW47
CisJCQlwLT5mb3VuZF9wYWdlcyArPSBsZW47CisJCX0gZWxzZSBpZiAocC0+dmVjX2luZGV4
IDwgcC0+dmVjX2xlbikgeworCQkJaWYgKHByZXYtPmxlbikgeworCQkJCW1lbWNweSgmcC0+
dmVjW3AtPnZlY19pbmRleF0sIHByZXYsIHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pKTsK
KwkJCQlwLT52ZWNfaW5kZXgrKzsKKwkJCX0KKwkJCXByZXYtPnN0YXJ0ID0gYWRkcjsKKwkJ
CXByZXYtPmxlbiA9IGxlbjsKKwkJCXByZXYtPmJpdG1hcCA9IGJpdG1hcDsKKwkJCXAtPmZv
dW5kX3BhZ2VzICs9IGxlbjsKKwkJfSBlbHNlIHsKKwkJCXJldHVybiAtRU5PU1BDOworCQl9
CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMgaW5saW5lIGludCBleHBvcnRfcHJldl90
b19vdXQoc3RydWN0IHBhZ2VtYXBfc2Nhbl9wcml2YXRlICpwLCBzdHJ1Y3QgcGFnZV9yZWdp
b24gX191c2VyICp2ZWMsCisJCQkJICAgICB1bnNpZ25lZCBsb25nICp2ZWNfaW5kZXgpCit7
CisJc3RydWN0IHBhZ2VfcmVnaW9uICpwcmV2ID0gJnAtPnByZXY7CisKKwlpZiAocHJldi0+
bGVuKSB7CisJCWlmIChjb3B5X3RvX3VzZXIoJnZlY1sqdmVjX2luZGV4XSwgcHJldiwgc2l6
ZW9mKHN0cnVjdCBwYWdlX3JlZ2lvbikpKQorCQkJcmV0dXJuIC1FRkFVTFQ7CisJCXAtPnZl
Y19pbmRleCsrOworCQkoKnZlY19pbmRleCkrKzsKKwkJcHJldi0+bGVuID0gMDsKKwl9CisJ
cmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IHBhZ2VtYXBfc2Nhbl9wbWRfZW50
cnkocG1kX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBzdGFydCwKKwkJCQkJIHVuc2lnbmVkIGxv
bmcgZW5kLCBzdHJ1Y3QgbW1fd2FsayAqd2FsaykKK3sKKwlzdHJ1Y3QgcGFnZW1hcF9zY2Fu
X3ByaXZhdGUgKnAgPSB3YWxrLT5wcml2YXRlOworCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hID0gd2Fsay0+dm1hOworCXVuc2lnbmVkIGxvbmcgYWRkciA9IGVuZDsKKwlzcGlubG9j
a190ICpwdGw7CisJaW50IHJldCA9IDAsIHJldDI7CisJcHRlX3QgKnB0ZTsKKworI2lmZGVm
IENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRQorCXB0bCA9IHBtZF90cmFuc19odWdlX2xv
Y2socG1kLCB2bWEpOworCWlmIChwdGwpIHsKKwkJYm9vbCBwbWRfd3Q7CisKKwkJcG1kX3d0
ID0gIWlzX3BtZF91ZmZkX3dwKCpwbWQpOworCQkvKgorCQkgKiBCcmVhayBodWdlIHBhZ2Ug
aW50byBzbWFsbCBwYWdlcyBpZiBvcGVyYXRpb24gbmVlZHMgdG8gYmUgcGVyZm9ybWVkIGlz
CisJCSAqIG9uIGEgcG9ydGlvbiBvZiB0aGUgaHVnZSBwYWdlLgorCQkgKi8KKwkJaWYgKHBt
ZF93dCAmJiBJU19XUF9FTkdBR0VfT1AocCkgJiYgKGVuZCAtIHN0YXJ0IDwgSFBBR0VfU0la
RSkpIHsKKwkJCXNwaW5fdW5sb2NrKHB0bCk7CisJCQlzcGxpdF9odWdlX3BtZCh2bWEsIHBt
ZCwgc3RhcnQpOworCQkJZ290byBwcm9jZXNzX3NtYWxsZXJfcGFnZXM7CisJCX0KKwkJaWYg
KElTX0dFVF9PUChwKSkKKwkJCXJldCA9IGFkZF90b19vdXQocG1kX3d0LCB2bWEtPnZtX2Zp
bGUsIHBtZF9wcmVzZW50KCpwbWQpLAorCQkJCQkgaXNfc3dhcF9wbWQoKnBtZCksIHAsIHN0
YXJ0LCAoZW5kIC0gc3RhcnQpL1BBR0VfU0laRSk7CisJCXNwaW5fdW5sb2NrKHB0bCk7CisJ
CWlmICghcmV0KSB7CisJCQlpZiAocG1kX3d0ICYmIElTX1dQX0VOR0FHRV9PUChwKSkKKwkJ
CQlyZXQgPSB3cF9yYW5nZV9hc3luYyh2bWEsIHN0YXJ0LCBIUEFHRV9TSVpFKTsKKwkJfQor
CQlyZXR1cm4gcmV0OworCX0KK3Byb2Nlc3Nfc21hbGxlcl9wYWdlczoKKwlpZiAocG1kX3Ry
YW5zX3Vuc3RhYmxlKHBtZCkpCisJCXJldHVybiAwOworI2VuZGlmIC8qIENPTkZJR19UUkFO
U1BBUkVOVF9IVUdFUEFHRSAqLworCisJcHRlID0gcHRlX29mZnNldF9tYXBfbG9jayh2bWEt
PnZtX21tLCBwbWQsIHN0YXJ0LCAmcHRsKTsKKwlpZiAoSVNfR0VUX09QKHApKSB7CisJCWZv
ciAoYWRkciA9IHN0YXJ0OyBhZGRyIDwgZW5kICYmICFyZXQ7IHB0ZSsrLCBhZGRyICs9IFBB
R0VfU0laRSkKKwkJCXJldCA9IGFkZF90b19vdXQoIWlzX3B0ZV91ZmZkX3dwKCpwdGUpLCB2
bWEtPnZtX2ZpbGUsIHB0ZV9wcmVzZW50KCpwdGUpLAorCQkJCQkgaXNfc3dhcF9wdGUoKnB0
ZSksIHAsIGFkZHIsIDEpOworCX0KKwlwdGVfdW5tYXBfdW5sb2NrKHB0ZSAtIDEsIHB0bCk7
CisJaWYgKCghcmV0IHx8IHJldCA9PSAtRU5PU1BDKSAmJiBJU19XUF9FTkdBR0VfT1AocCkp
CisJCXJldDIgPSB3cF9yYW5nZV9hc3luYyh2bWEsIHN0YXJ0LCBhZGRyIC0gc3RhcnQpOwor
CWlmIChyZXQyKQorCQlyZXQgPSByZXQyOworCisJY29uZF9yZXNjaGVkKCk7CisJcmV0dXJu
IHJldDsKK30KKworc3RhdGljIGludCBwYWdlbWFwX3NjYW5fcHRlX2hvbGUodW5zaWduZWQg
bG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwgaW50IGRlcHRoLAorCQkJCSBzdHJ1Y3Qg
bW1fd2FsayAqd2FsaykKK3sKKwlzdHJ1Y3QgcGFnZW1hcF9zY2FuX3ByaXZhdGUgKnAgPSB3
YWxrLT5wcml2YXRlOworCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gd2Fsay0+dm1h
OworCWludCByZXQgPSAwOworCisJaWYgKHZtYSkKKwkJcmV0ID0gYWRkX3RvX291dChmYWxz
ZSwgdm1hLT52bV9maWxlLCBmYWxzZSwgZmFsc2UsIHAsIGFkZHIsCisJCQkJIChlbmQgLSBh
ZGRyKS9QQUdFX1NJWkUpOworCXJldHVybiByZXQ7Cit9CisKKy8qIE5vIGh1Z2V0bGIgc3Vw
cG9ydCBpcyBwcmVzZW50LiAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBtbV93YWxrX29wcyBw
YWdlbWFwX3NjYW5fb3BzID0geworCS50ZXN0X3dhbGsgPSBwYWdlbWFwX3NjYW5fdGVzdF93
YWxrLAorCS5wbWRfZW50cnkgPSBwYWdlbWFwX3NjYW5fcG1kX2VudHJ5LAorCS5wdGVfaG9s
ZSA9IHBhZ2VtYXBfc2Nhbl9wdGVfaG9sZSwKK307CisKK3N0YXRpYyBsb25nIGRvX3BhZ2Vt
YXBfY21kKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZyAq
YXJnKQoreworCXVuc2lnbmVkIGxvbmcgZW1wdHlfc2xvdHMsIHZlY19pbmRleCA9IDA7CisJ
dW5zaWduZWQgbG9uZyBfX3VzZXIgc3RhcnQsIGVuZDsKKwl1bnNpZ25lZCBsb25nIF9fc3Rh
cnQsIF9fZW5kOworCXN0cnVjdCBwYWdlX3JlZ2lvbiBfX3VzZXIgKnZlYzsKKwlzdHJ1Y3Qg
cGFnZW1hcF9zY2FuX3ByaXZhdGUgcDsKKwlpbnQgcmV0OworCisJc3RhcnQgPSAodW5zaWdu
ZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKGFyZy0+c3RhcnQpOworCXZlYyA9IChzdHJ1Y3QgcGFn
ZV9yZWdpb24gKikodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKGFyZy0+dmVjKTsKKwlp
ZiAoKCFJU19BTElHTkVEKHN0YXJ0LCBQQUdFX1NJWkUpKSB8fCAoIWFjY2Vzc19vaygodm9p
ZCBfX3VzZXIgKilzdGFydCwgYXJnLT5sZW4pKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJaWYg
KElTX0dFVF9PUChhcmcpICYmICgoYXJnLT52ZWNfbGVuID09IDApIHx8CisJICAgICghYWNj
ZXNzX29rKCh2b2lkIF9fdXNlciAqKXZlYywgYXJnLT52ZWNfbGVuICogc2l6ZW9mKHN0cnVj
dCBwYWdlX3JlZ2lvbikpKSkpCisJCXJldHVybiAtRU5PTUVNOworCWlmICgoYXJnLT5mbGFn
cyAmIH5QQUdFTUFQX1dQX0VOR0FHRSkgfHwgKGFyZy0+cmVxdWlyZWRfbWFzayAmIH5QQUdF
TUFQX09QX01BU0spIHx8CisJICAgIChhcmctPmFueW9mX21hc2sgJiB+UEFHRU1BUF9PUF9N
QVNLKSB8fCAoYXJnLT5leGNsdWRlZF9tYXNrICYgflBBR0VNQVBfT1BfTUFTSykgfHwKKwkg
ICAgKGFyZy0+cmV0dXJuX21hc2sgJiB+UEFHRU1BUF9PUF9NQVNLKSkKKwkJcmV0dXJuIC1F
SU5WQUw7CisJaWYgKElTX0dFVF9PUChhcmcpICYmICgoIWFyZy0+cmVxdWlyZWRfbWFzayAm
JiAhYXJnLT5hbnlvZl9tYXNrICYmICFhcmctPmV4Y2x1ZGVkX21hc2spIHx8CisJCQkJIWFy
Zy0+cmV0dXJuX21hc2spKQorCQlyZXR1cm4gLUVJTlZBTDsKKwkvKiBUaGUgbm9uLVdUIGZs
YWdzIGNhbm5vdCBiZSBvYnRhaW5lZCBpZiBQQUdFTUFQX1dQX0VOR0FHRSBpcyBhbHNvIHNw
ZWNpZmllZC4gKi8KKwlpZiAoSVNfV1BfRU5HQUdFX09QKGFyZykgJiYgKChhcmctPnJlcXVp
cmVkX21hc2sgJiBQQUdFTUFQX05PTldUX09QX01BU0spIHx8CisJICAgIChhcmctPmFueW9m
X21hc2sgJiBQQUdFTUFQX05PTldUX09QX01BU0spKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisK
KwllbmQgPSBzdGFydCArIGFyZy0+bGVuOworCXAubWF4X3BhZ2VzID0gYXJnLT5tYXhfcGFn
ZXM7CisJcC5mb3VuZF9wYWdlcyA9IDA7CisJcC5mbGFncyA9IGFyZy0+ZmxhZ3M7CisJcC5y
ZXF1aXJlZF9tYXNrID0gYXJnLT5yZXF1aXJlZF9tYXNrOworCXAuYW55b2ZfbWFzayA9IGFy
Zy0+YW55b2ZfbWFzazsKKwlwLmV4Y2x1ZGVkX21hc2sgPSBhcmctPmV4Y2x1ZGVkX21hc2s7
CisJcC5yZXR1cm5fbWFzayA9IGFyZy0+cmV0dXJuX21hc2s7CisJcC5wcmV2LmxlbiA9IDA7
CisJcC52ZWNfbGVuID0gKFBBR0VNQVBfV0FMS19TSVpFID4+IFBBR0VfU0hJRlQpOworCisJ
aWYgKElTX0dFVF9PUChhcmcpKSB7CisJCXAudmVjID0ga21hbGxvY19hcnJheShwLnZlY19s
ZW4sIHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pLCBHRlBfS0VSTkVMKTsKKwkJaWYgKCFw
LnZlYykKKwkJCXJldHVybiAtRU5PTUVNOworCX0gZWxzZSB7CisJCXAudmVjID0gTlVMTDsK
Kwl9CisJX19zdGFydCA9IF9fZW5kID0gc3RhcnQ7CisJd2hpbGUgKCFyZXQgJiYgX19lbmQg
PCBlbmQpIHsKKwkJcC52ZWNfaW5kZXggPSAwOworCQllbXB0eV9zbG90cyA9IGFyZy0+dmVj
X2xlbiAtIHZlY19pbmRleDsKKwkJaWYgKHAudmVjX2xlbiA+IGVtcHR5X3Nsb3RzKQorCQkJ
cC52ZWNfbGVuID0gZW1wdHlfc2xvdHM7CisKKwkJX19lbmQgPSAoX19zdGFydCArIFBBR0VN
QVBfV0FMS19TSVpFKSAmIFBBR0VNQVBfV0FMS19NQVNLOworCQlpZiAoX19lbmQgPiBlbmQp
CisJCQlfX2VuZCA9IGVuZDsKKworCQltbWFwX3JlYWRfbG9jayhtbSk7CisJCXJldCA9IHdh
bGtfcGFnZV9yYW5nZShtbSwgX19zdGFydCwgX19lbmQsICZwYWdlbWFwX3NjYW5fb3BzLCAm
cCk7CisJCW1tYXBfcmVhZF91bmxvY2sobW0pOworCQlpZiAoISghcmV0IHx8IHJldCA9PSAt
RU5PU1BDKSkKKwkJCWdvdG8gZnJlZV9kYXRhOworCisJCV9fc3RhcnQgPSBfX2VuZDsKKwkJ
aWYgKElTX0dFVF9PUChhcmcpICYmIHAudmVjX2luZGV4KSB7CisJCQlpZiAoY29weV90b191
c2VyKCZ2ZWNbdmVjX2luZGV4XSwgcC52ZWMsCisJCQkJCSBwLnZlY19pbmRleCAqIHNpemVv
ZihzdHJ1Y3QgcGFnZV9yZWdpb24pKSkgeworCQkJCXJldCA9IC1FRkFVTFQ7CisJCQkJZ290
byBmcmVlX2RhdGE7CisJCQl9CisJCQl2ZWNfaW5kZXggKz0gcC52ZWNfaW5kZXg7CisJCX0K
Kwl9CisJaWYgKCFyZXQgfHwgcmV0ID09IC1FTk9TUEMpCisJCXJldCA9IGV4cG9ydF9wcmV2
X3RvX291dCgmcCwgdmVjLCAmdmVjX2luZGV4KTsKKwlpZiAoIXJldCkKKwkJcmV0ID0gdmVj
X2luZGV4OworZnJlZV9kYXRhOgorCWlmIChJU19HRVRfT1AoYXJnKSkKKwkJa2ZyZWUocC52
ZWMpOworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGxvbmcgcGFnZW1hcF9zY2FuX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25n
IGFyZykKK3sKKwlzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZyBfX3VzZXIgKnVhcmcgPSAoc3Ry
dWN0IHBhZ2VtYXBfc2Nhbl9hcmcgX191c2VyICopYXJnOworCXN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tID0gZmlsZS0+cHJpdmF0ZV9kYXRhOworCXN0cnVjdCBwYWdlbWFwX3NjYW5fYXJnIGFy
Z3VtZW50OworCisJaWYgKGNtZCA9PSBQQUdFTUFQX1NDQU4pIHsKKwkJaWYgKGNvcHlfZnJv
bV91c2VyKCZhcmd1bWVudCwgdWFyZywgc2l6ZW9mKHN0cnVjdCBwYWdlbWFwX3NjYW5fYXJn
KSkpCisJCQlyZXR1cm4gLUVGQVVMVDsKKwkJcmV0dXJuIGRvX3BhZ2VtYXBfY21kKG1tLCAm
YXJndW1lbnQpOworCX0KKwlyZXR1cm4gLUVJTlZBTDsKK30KKwogY29uc3Qgc3RydWN0IGZp
bGVfb3BlcmF0aW9ucyBwcm9jX3BhZ2VtYXBfb3BlcmF0aW9ucyA9IHsKIAkubGxzZWVrCQk9
IG1lbV9sc2VlaywgLyogYm9ycm93IHRoaXMgKi8KIAkucmVhZAkJPSBwYWdlbWFwX3JlYWQs
CiAJLm9wZW4JCT0gcGFnZW1hcF9vcGVuLAogCS5yZWxlYXNlCT0gcGFnZW1hcF9yZWxlYXNl
LAorCS51bmxvY2tlZF9pb2N0bCA9IHBhZ2VtYXBfc2Nhbl9pb2N0bCwKKwkuY29tcGF0X2lv
Y3RsCT0gcGFnZW1hcF9zY2FuX2lvY3RsLAogfTsKICNlbmRpZiAvKiBDT05GSUdfUFJPQ19Q
QUdFX01PTklUT1IgKi8KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmgg
Yi9pbmNsdWRlL3VhcGkvbGludXgvZnMuaAppbmRleCBiN2I1Njg3MTAyOWMuLjZkMDNhOTAz
YTc0NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmgKKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2ZzLmgKQEAgLTMwNSw0ICszMDUsNTQgQEAgdHlwZWRlZiBpbnQgX19i
aXR3aXNlIF9fa2VybmVsX3J3Zl90OwogI2RlZmluZSBSV0ZfU1VQUE9SVEVECShSV0ZfSElQ
UkkgfCBSV0ZfRFNZTkMgfCBSV0ZfU1lOQyB8IFJXRl9OT1dBSVQgfFwKIAkJCSBSV0ZfQVBQ
RU5EKQogCisvKiBQYWdlbWFwIGlvY3RsICovCisjZGVmaW5lIFBBR0VNQVBfU0NBTglfSU9X
UignZicsIDE2LCBzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZykKKworLyogQml0cyBhcmUgc2V0
IGluIHRoZSBiaXRtYXAgb2YgdGhlIHBhZ2VfcmVnaW9uIGFuZCBtYXNrcyBpbiBwYWdlbWFw
X3NjYW5fYXJncyAqLworI2RlZmluZSBQQUdFX0lTX1dUCQkoMSA8PCAwKQorI2RlZmluZSBQ
QUdFX0lTX0ZJTEUJCSgxIDw8IDEpCisjZGVmaW5lIFBBR0VfSVNfUFJFU0VOVAkJKDEgPDwg
MikKKyNkZWZpbmUgUEFHRV9JU19TV0FQUEVECQkoMSA8PCAzKQorCisvKgorICogc3RydWN0
IHBhZ2VfcmVnaW9uIC0gUGFnZSByZWdpb24gd2l0aCBiaXRtYXAgZmxhZ3MKKyAqIEBzdGFy
dDoJU3RhcnQgb2YgdGhlIHJlZ2lvbgorICogQGxlbjoJTGVuZ3RoIG9mIHRoZSByZWdpb24K
KyAqIGJpdG1hcDoJQml0cyBzZXRzIGZvciB0aGUgcmVnaW9uCisgKi8KK3N0cnVjdCBwYWdl
X3JlZ2lvbiB7CisJX191NjQgc3RhcnQ7CisJX191NjQgbGVuOworCV9fdTY0IGJpdG1hcDsK
K307CisKKy8qCisgKiBzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZyAtIFBhZ2VtYXAgaW9jdGwg
YXJndW1lbnQKKyAqIEBzdGFydDoJCVN0YXJ0aW5nIGFkZHJlc3Mgb2YgdGhlIHJlZ2lvbgor
ICogQGxlbjoJCUxlbmd0aCBvZiB0aGUgcmVnaW9uIChBbGwgdGhlIHBhZ2VzIGluIHRoaXMg
bGVuZ3RoIGFyZSBpbmNsdWRlZCkKKyAqIEB2ZWM6CQlBZGRyZXNzIG9mIHBhZ2VfcmVnaW9u
IHN0cnVjdCBhcnJheSBmb3Igb3V0cHV0CisgKiBAdmVjX2xlbjoJCUxlbmd0aCBvZiB0aGUg
cGFnZV9yZWdpb24gc3RydWN0IGFycmF5CisgKiBAbWF4X3BhZ2VzOgkJT3B0aW9uYWwgbWF4
IHJldHVybiBwYWdlcworICogQGZsYWdzOgkJRmxhZ3MgZm9yIHRoZSBJT0NUTAorICogQHJl
cXVpcmVkX21hc2s6CVJlcXVpcmVkIG1hc2sgLSBBbGwgb2YgdGhlc2UgYml0cyBoYXZlIHRv
IGJlIHNldCBpbiB0aGUgUFRFCisgKiBAYW55b2ZfbWFzazoJCUFueSBtYXNrIC0gQW55IG9m
IHRoZXNlIGJpdHMgYXJlIHNldCBpbiB0aGUgUFRFCisgKiBAZXhjbHVkZWRfbWFzazoJRXhj
bHVkZSBtYXNrIC0gTm9uZSBvZiB0aGVzZSBiaXRzIGFyZSBzZXQgaW4gdGhlIFBURQorICog
QHJldHVybl9tYXNrOglCaXRzIHRoYXQgYXJlIHRvIGJlIHJlcG9ydGVkIGluIHBhZ2VfcmVn
aW9uCisgKi8KK3N0cnVjdCBwYWdlbWFwX3NjYW5fYXJnIHsKKwlfX3U2NCBzdGFydDsKKwlf
X3U2NCBsZW47CisJX191NjQgdmVjOworCV9fdTY0IHZlY19sZW47CisJX191MzIgbWF4X3Bh
Z2VzOworCV9fdTMyIGZsYWdzOworCV9fdTY0IHJlcXVpcmVkX21hc2s7CisJX191NjQgYW55
b2ZfbWFzazsKKwlfX3U2NCBleGNsdWRlZF9tYXNrOworCV9fdTY0IHJldHVybl9tYXNrOwor
fTsKKworLyogU3BlY2lhbCBmbGFncyAqLworI2RlZmluZSBQQUdFTUFQX1dQX0VOR0FHRQko
MSA8PCAwKQorCiAjZW5kaWYgLyogX1VBUElfTElOVVhfRlNfSCAqLwpkaWZmIC0tZ2l0IGEv
dG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmggYi90b29scy9pbmNsdWRlL3VhcGkvbGlu
dXgvZnMuaAppbmRleCBiN2I1Njg3MTAyOWMuLjZkMDNhOTAzYTc0NSAxMDA2NDQKLS0tIGEv
dG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmgKKysrIGIvdG9vbHMvaW5jbHVkZS91YXBp
L2xpbnV4L2ZzLmgKQEAgLTMwNSw0ICszMDUsNTQgQEAgdHlwZWRlZiBpbnQgX19iaXR3aXNl
IF9fa2VybmVsX3J3Zl90OwogI2RlZmluZSBSV0ZfU1VQUE9SVEVECShSV0ZfSElQUkkgfCBS
V0ZfRFNZTkMgfCBSV0ZfU1lOQyB8IFJXRl9OT1dBSVQgfFwKIAkJCSBSV0ZfQVBQRU5EKQog
CisvKiBQYWdlbWFwIGlvY3RsICovCisjZGVmaW5lIFBBR0VNQVBfU0NBTglfSU9XUignZics
IDE2LCBzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZykKKworLyogQml0cyBhcmUgc2V0IGluIHRo
ZSBiaXRtYXAgb2YgdGhlIHBhZ2VfcmVnaW9uIGFuZCBtYXNrcyBpbiBwYWdlbWFwX3NjYW5f
YXJncyAqLworI2RlZmluZSBQQUdFX0lTX1dUCQkoMSA8PCAwKQorI2RlZmluZSBQQUdFX0lT
X0ZJTEUJCSgxIDw8IDEpCisjZGVmaW5lIFBBR0VfSVNfUFJFU0VOVAkJKDEgPDwgMikKKyNk
ZWZpbmUgUEFHRV9JU19TV0FQUEVECQkoMSA8PCAzKQorCisvKgorICogc3RydWN0IHBhZ2Vf
cmVnaW9uIC0gUGFnZSByZWdpb24gd2l0aCBiaXRtYXAgZmxhZ3MKKyAqIEBzdGFydDoJU3Rh
cnQgb2YgdGhlIHJlZ2lvbgorICogQGxlbjoJTGVuZ3RoIG9mIHRoZSByZWdpb24KKyAqIGJp
dG1hcDoJQml0cyBzZXRzIGZvciB0aGUgcmVnaW9uCisgKi8KK3N0cnVjdCBwYWdlX3JlZ2lv
biB7CisJX191NjQgc3RhcnQ7CisJX191NjQgbGVuOworCV9fdTY0IGJpdG1hcDsKK307CisK
Ky8qCisgKiBzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZyAtIFBhZ2VtYXAgaW9jdGwgYXJndW1l
bnQKKyAqIEBzdGFydDoJCVN0YXJ0aW5nIGFkZHJlc3Mgb2YgdGhlIHJlZ2lvbgorICogQGxl
bjoJCUxlbmd0aCBvZiB0aGUgcmVnaW9uIChBbGwgdGhlIHBhZ2VzIGluIHRoaXMgbGVuZ3Ro
IGFyZSBpbmNsdWRlZCkKKyAqIEB2ZWM6CQlBZGRyZXNzIG9mIHBhZ2VfcmVnaW9uIHN0cnVj
dCBhcnJheSBmb3Igb3V0cHV0CisgKiBAdmVjX2xlbjoJCUxlbmd0aCBvZiB0aGUgcGFnZV9y
ZWdpb24gc3RydWN0IGFycmF5CisgKiBAbWF4X3BhZ2VzOgkJT3B0aW9uYWwgbWF4IHJldHVy
biBwYWdlcworICogQGZsYWdzOgkJRmxhZ3MgZm9yIHRoZSBJT0NUTAorICogQHJlcXVpcmVk
X21hc2s6CVJlcXVpcmVkIG1hc2sgLSBBbGwgb2YgdGhlc2UgYml0cyBoYXZlIHRvIGJlIHNl
dCBpbiB0aGUgUFRFCisgKiBAYW55b2ZfbWFzazoJCUFueSBtYXNrIC0gQW55IG9mIHRoZXNl
IGJpdHMgYXJlIHNldCBpbiB0aGUgUFRFCisgKiBAZXhjbHVkZWRfbWFzazoJRXhjbHVkZSBt
YXNrIC0gTm9uZSBvZiB0aGVzZSBiaXRzIGFyZSBzZXQgaW4gdGhlIFBURQorICogQHJldHVy
bl9tYXNrOglCaXRzIHRoYXQgYXJlIHRvIGJlIHJlcG9ydGVkIGluIHBhZ2VfcmVnaW9uCisg
Ki8KK3N0cnVjdCBwYWdlbWFwX3NjYW5fYXJnIHsKKwlfX3U2NCBzdGFydDsKKwlfX3U2NCBs
ZW47CisJX191NjQgdmVjOworCV9fdTY0IHZlY19sZW47CisJX191MzIgbWF4X3BhZ2VzOwor
CV9fdTMyIGZsYWdzOworCV9fdTY0IHJlcXVpcmVkX21hc2s7CisJX191NjQgYW55b2ZfbWFz
azsKKwlfX3U2NCBleGNsdWRlZF9tYXNrOworCV9fdTY0IHJldHVybl9tYXNrOworfTsKKwor
LyogU3BlY2lhbCBmbGFncyAqLworI2RlZmluZSBQQUdFTUFQX1dQX0VOR0FHRQkoMSA8PCAw
KQorCiAjZW5kaWYgLyogX1VBUElfTElOVVhfRlNfSCAqLwotLSAKMi4zMC4yCgo=
--------------YDczPGnNMYCbOh0mtE2Xi30f
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-selftests-vm-add-pagemap-ioctl-tests.patch"
Content-Disposition: attachment;
 filename="0004-selftests-vm-add-pagemap-ioctl-tests.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NzRlM2NkMmU2N2Y1ZTk0Zjk5OTRhNzVhYWMzYTNlMTNjY2Q2ZGViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogVHVlLCAyNCBKYW4gMjAyMyAxMzozNjoyMyArMDUw
MApTdWJqZWN0OiBbUEFUQ0ggV0lQIHY5IDQvNF0gc2VsZnRlc3RzOiB2bTogYWRkIHBhZ2Vt
YXAgaW9jdGwgdGVzdHMKCkFkZCBwYWdlbWFwIGlvY3RsIHRlc3RzLiBBZGQgc2V2ZXJhbCBk
aWZmZXJlbnQgdHlwZXMgb2YgdGVzdHMgdG8ganVkZ2UKdGhlIGNvcnJlY3Rpb24gb2YgdGhl
IGludGVyZmFjZS4KClNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIFVzYW1hIEFuanVtIDx1c2Ft
YS5hbmp1bUBjb2xsYWJvcmEuY29tPgotLS0KQ2hhZ2VzIGluIHY3OgotIEFkZCBhbmQgdXBk
YXRlIGFsbCB0ZXN0IGNhc2VzCgpDaGFuZ2VzIGluIHY2OgotIFJlbmFtZSB2YXJpYWJsZXMK
CkNoYW5nZXMgaW4gdjQ6Ci0gVXBkYXRlZCBhbGwgdGhlIHRlc3RzIHRvIGNvbmZvcm0gdG8g
bmV3IElPQ1RMCgpDaGFuZ2VzIGluIHYzOgotIEFkZCBhbm90aGVyIHRlc3QgdG8gZG8gc2Fu
aXR5IG9mIGZsYWdzCgpDaGFuZ2VzIGluIHYyOgotIFVwZGF0ZSB0aGUgdGVzdHMgdG8gdXNl
IHRoZSBpb2N0bCBpbnRlcmZhY2UgaW5zdGVhZCBvZiBzeXNjYWxsCgpUQVAgdmVyc2lvbiAx
MwoxLi41NApvayAxIHNhbml0eV90ZXN0c19zZCB3cm9uZyBmbGFnIHNwZWNpZmllZApvayAy
IHNhbml0eV90ZXN0c19zZCB3cm9uZyBtYXNrIHNwZWNpZmllZApvayAzIHNhbml0eV90ZXN0
c19zZCB3cm9uZyByZXR1cm4gbWFzayBzcGVjaWZpZWQKb2sgNCBzYW5pdHlfdGVzdHNfc2Qg
bWl4dHVyZSBvZiBjb3JyZWN0IGFuZCB3cm9uZyBmbGFnCm9rIDUgc2FuaXR5X3Rlc3RzX3Nk
IENsZWFyIGFyZWEgd2l0aCBsYXJnZXIgdmVjIHNpemUKb2sgNiBzYW5pdHlfdGVzdHNfc2Qg
UmVwZWF0ZWQgcGF0dGVybiBvZiBkaXJ0eSBhbmQgbm9uLWRpcnR5IHBhZ2VzCm9rIDcgc2Fu
aXR5X3Rlc3RzX3NkIFJlcGVhdGVkIHBhdHRlcm4gb2YgZGlydHkgYW5kIG5vbi1kaXJ0eSBw
YWdlcyBpbiBwYXJ0cwpvayA4IHNhbml0eV90ZXN0c19zZCBUd28gcmVnaW9ucwpvayA5IFBh
Z2UgdGVzdGluZzogYWxsIG5ldyBwYWdlcyBtdXN0IGJlIHNvZnQgZGlydHkKb2sgMTAgUGFn
ZSB0ZXN0aW5nOiBhbGwgcGFnZXMgbXVzdCBub3QgYmUgc29mdCBkaXJ0eQpvayAxMSBQYWdl
IHRlc3Rpbmc6IGFsbCBwYWdlcyBkaXJ0eSBvdGhlciB0aGFuIGZpcnN0IGFuZCB0aGUgbGFz
dCBvbmUKb2sgMTIgUGFnZSB0ZXN0aW5nOiBvbmx5IG1pZGRsZSBwYWdlIGRpcnR5Cm9rIDEz
IFBhZ2UgdGVzdGluZzogb25seSB0d28gbWlkZGxlIHBhZ2VzIGRpcnR5Cm9rIDE0IFBhZ2Ug
dGVzdGluZzogb25seSBnZXQgMiBkaXJ0eSBwYWdlcyBhbmQgY2xlYXIgdGhlbSBhcyB3ZWxs
Cm9rIDE1IFBhZ2UgdGVzdGluZzogUmFuZ2UgY2xlYXIgb25seQpvayAxNiBMYXJnZSBQYWdl
IHRlc3Rpbmc6IGFsbCBuZXcgcGFnZXMgbXVzdCBiZSBzb2Z0IGRpcnR5Cm9rIDE3IExhcmdl
IFBhZ2UgdGVzdGluZzogYWxsIHBhZ2VzIG11c3Qgbm90IGJlIHNvZnQgZGlydHkKb2sgMTgg
TGFyZ2UgUGFnZSB0ZXN0aW5nOiBhbGwgcGFnZXMgZGlydHkgb3RoZXIgdGhhbiBmaXJzdCBh
bmQgdGhlIGxhc3Qgb25lCm9rIDE5IExhcmdlIFBhZ2UgdGVzdGluZzogb25seSBtaWRkbGUg
cGFnZSBkaXJ0eQpvayAyMCBMYXJnZSBQYWdlIHRlc3Rpbmc6IG9ubHkgdHdvIG1pZGRsZSBw
YWdlcyBkaXJ0eQpvayAyMSBMYXJnZSBQYWdlIHRlc3Rpbmc6IG9ubHkgZ2V0IDIgZGlydHkg
cGFnZXMgYW5kIGNsZWFyIHRoZW0gYXMgd2VsbApvayAyMiBMYXJnZSBQYWdlIHRlc3Rpbmc6
IFJhbmdlIGNsZWFyIG9ubHkKb2sgMjMgSHVnZSBwYWdlIHRlc3Rpbmc6IGFsbCBuZXcgcGFn
ZXMgbXVzdCBiZSBzb2Z0IGRpcnR5Cm9rIDI0IEh1Z2UgcGFnZSB0ZXN0aW5nOiBhbGwgcGFn
ZXMgbXVzdCBub3QgYmUgc29mdCBkaXJ0eQpvayAyNSBIdWdlIHBhZ2UgdGVzdGluZzogYWxs
IHBhZ2VzIGRpcnR5IG90aGVyIHRoYW4gZmlyc3QgYW5kIHRoZSBsYXN0IG9uZQpvayAyNiBI
dWdlIHBhZ2UgdGVzdGluZzogb25seSBtaWRkbGUgcGFnZSBkaXJ0eQpvayAyNyBIdWdlIHBh
Z2UgdGVzdGluZzogb25seSB0d28gbWlkZGxlIHBhZ2VzIGRpcnR5Cm9rIDI4IEh1Z2UgcGFn
ZSB0ZXN0aW5nOiBvbmx5IGdldCAyIGRpcnR5IHBhZ2VzIGFuZCBjbGVhciB0aGVtIGFzIHdl
bGwKb2sgMjkgSHVnZSBwYWdlIHRlc3Rpbmc6IFJhbmdlIGNsZWFyIG9ubHkKb2sgMzAgaHBh
Z2VfdW5pdF90ZXN0cyBhbGwgbmV3IGh1Z2UgcGFnZSBtdXN0IGJlIGRpcnR5Cm9rIDMxIGhw
YWdlX3VuaXRfdGVzdHMgYWxsIHRoZSBodWdlIHBhZ2UgbXVzdCBub3QgYmUgZGlydHkKb2sg
MzIgaHBhZ2VfdW5pdF90ZXN0cyBhbGwgdGhlIGh1Z2UgcGFnZSBtdXN0IGJlIGRpcnR5IGFu
ZCBjbGVhcgpvayAzMyBocGFnZV91bml0X3Rlc3RzIG9ubHkgbWlkZGxlIHBhZ2UgZGlydHkK
b2sgMzQgaHBhZ2VfdW5pdF90ZXN0cyBjbGVhciBmaXJzdCBoYWxmIG9mIGh1Z2UgcGFnZQpv
ayAzNSBocGFnZV91bml0X3Rlc3RzIGNsZWFyIGZpcnN0IGhhbGYgb2YgaHVnZSBwYWdlIHdp
dGggbGltaXRlZCBidWZmZXIKb2sgMzYgaHBhZ2VfdW5pdF90ZXN0cyBjbGVhciBzZWNvbmQg
aGFsZiBodWdlIHBhZ2UKb2sgMzcgVGVzdCB0ZXN0X3NpbXBsZQpvayAzOCBtcHJvdGVjdF90
ZXN0cyBCb3RoIHBhZ2VzIGRpcnR5Cm9rIDM5IG1wcm90ZWN0X3Rlc3RzIEJvdGggcGFnZXMg
YXJlIG5vdCBzb2Z0IGRpcnR5Cm9rIDQwIG1wcm90ZWN0X3Rlc3RzIEJvdGggcGFnZXMgZGly
dHkgYWZ0ZXIgcmVtYXAgYW5kIG1wcm90ZWN0Cm9rIDQxIG1wcm90ZWN0X3Rlc3RzIENsZWFy
IGFuZCBtYWtlIHRoZSBwYWdlcyBkaXJ0eQpvayA0MiBzYW5pdHlfdGVzdHMgY2xlYXIgb3Ag
Y2FuIG9ubHkgYmUgc3BlY2lmaWVkIHdpdGggUEFHRV9JU19XVApvayA0MyBzYW5pdHlfdGVz
dHMgcmVxdWlyZWRfbWFzayBzcGVjaWZpZWQKb2sgNDQgc2FuaXR5X3Rlc3RzIGFueW9mX21h
c2sgc3BlY2lmaWVkCm9rIDQ1IHNhbml0eV90ZXN0cyBleGNsdWRlZF9tYXNrIHNwZWNpZmll
ZApvayA0NiBzYW5pdHlfdGVzdHMgcmVxdWlyZWRfbWFzayBhbmQgYW55b2ZfbWFzayBzcGVj
aWZpZWQKb2sgNDcgc2FuaXR5X3Rlc3RzIEdldCBzZCBhbmQgcHJlc2VudCBwYWdlcyB3aXRo
IGFueW9mX21hc2sKb2sgNDggc2FuaXR5X3Rlc3RzIEdldCBhbGwgdGhlIHBhZ2VzIHdpdGgg
cmVxdWlyZWRfbWFzawpvayA0OSBzYW5pdHlfdGVzdHMgR2V0IHNkIGFuZCBwcmVzZW50IHBh
Z2VzIHdpdGggcmVxdWlyZWRfbWFzayBhbmQgYW55b2ZfbWFzawpvayA1MCBzYW5pdHlfdGVz
dHMgRG9uJ3QgZ2V0IHNkIHBhZ2VzCm9rIDUxIHNhbml0eV90ZXN0cyBEb24ndCBnZXQgcHJl
c2VudCBwYWdlcwpvayA1MiBzYW5pdHlfdGVzdHMgRmluZCBkaXJ0eSBwcmVzZW50IHBhZ2Vz
IHdpdGggcmV0dXJuIG1hc2sKb2sgNTMgc2FuaXR5X3Rlc3RzIE1lbW9yeSBtYXBwZWQgZmls
ZQpvayA1NCB1bm1hcHBlZF9yZWdpb25fdGVzdHMgR2V0IHN0YXR1cyBvZiBwYWdlcwogIyBU
b3RhbHM6IHBhc3M6NTQgZmFpbDowIHhmYWlsOjAgeHBhc3M6MCBza2lwOjAgZXJyb3I6MAot
LS0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtLy5naXRpZ25vcmUgICAgICB8ICAgMSAr
CiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS9NYWtlZmlsZSAgICAgICAgfCAgIDUgKy0K
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtL3BhZ2VtYXBfaW9jdGwuYyB8IDg4MCArKysr
KysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgODg0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdm0vcGFnZW1hcF9pb2N0bC5jCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvdm0vLmdpdGlnbm9yZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtLy5n
aXRpZ25vcmUKaW5kZXggMWY4YzM2YTlmYTEwLi45ZTdlMGFlMjY1ODIgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtLy5naXRpZ25vcmUKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdm0vLmdpdGlnbm9yZQpAQCAtMTcsNiArMTcsNyBAQCBtcmVtYXBf
ZG9udHVubWFwCiBtcmVtYXBfdGVzdAogb24tZmF1bHQtbGltaXQKIHRyYW5zaHVnZS1zdHJl
c3MKK3BhZ2VtYXBfaW9jdGwKIHByb3RlY3Rpb25fa2V5cwogcHJvdGVjdGlvbl9rZXlzXzMy
CiBwcm90ZWN0aW9uX2tleXNfNjQKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3ZtL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdm0vTWFrZWZpbGUK
aW5kZXggODljMTRlNDFiZDQzLi41NGMwNzQ0NDBhMWIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3ZtL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3ZtL01ha2VmaWxlCkBAIC0yNCw5ICsyNCw4IEBAIE1BQ0hJTkUgPz0gJChzaGVsbCBl
Y2hvICQodW5hbWVfTSkgfCBzZWQgLWUgJ3MvYWFyY2g2NC4qL2FybTY0LycgLWUgJ3MvcHBj
NjQuKi9wCiAjIHRoaW5ncyBkZXNwaXRlIHVzaW5nIGluY29ycmVjdCB2YWx1ZXMgc3VjaCBh
cyBhbiAqb2NjYXNpb25hbGx5KiBpbmNvbXBsZXRlCiAjIExETElCUy4KIE1BS0VGTEFHUyAr
PSAtLW5vLWJ1aWx0aW4tcnVsZXMKLQogQ0ZMQUdTID0gLVdhbGwgLUkgJCh0b3Bfc3JjZGly
KSAtSSAkKHRvcF9zcmNkaXIpL3Vzci9pbmNsdWRlICQoRVhUUkFfQ0ZMQUdTKSAkKEtIRFJf
SU5DTFVERVMpCi1MRExJQlMgPSAtbHJ0IC1scHRocmVhZAorTERMSUJTID0gLWxydCAtbHB0
aHJlYWQgLWxtCiBURVNUX0dFTl9GSUxFUyA9IGNvdwogVEVTVF9HRU5fRklMRVMgKz0gY29t
cGFjdGlvbl90ZXN0CiBURVNUX0dFTl9GSUxFUyArPSBndXBfdGVzdApAQCAtNTIsNiArNTEs
NyBAQCBURVNUX0dFTl9GSUxFUyArPSBvbi1mYXVsdC1saW1pdAogVEVTVF9HRU5fRklMRVMg
Kz0gdGh1Z2UtZ2VuCiBURVNUX0dFTl9GSUxFUyArPSB0cmFuc2h1Z2Utc3RyZXNzCiBURVNU
X0dFTl9GSUxFUyArPSB1c2VyZmF1bHRmZAorVEVTVF9HRU5fUFJPR1MgKz0gcGFnZW1hcF9p
b2N0bAogVEVTVF9HRU5fUFJPR1MgKz0gc29mdC1kaXJ0eQogVEVTVF9HRU5fUFJPR1MgKz0g
c3BsaXRfaHVnZV9wYWdlX3Rlc3QKIFRFU1RfR0VOX0ZJTEVTICs9IGtzbV90ZXN0cwpAQCAt
MTAzLDYgKzEwMyw3IEBAICQoT1VUUFVUKS9jb3c6IHZtX3V0aWwuYwogJChPVVRQVVQpL2to
dWdlcGFnZWQ6IHZtX3V0aWwuYwogJChPVVRQVVQpL2tzbV9mdW5jdGlvbmFsX3Rlc3RzOiB2
bV91dGlsLmMKICQoT1VUUFVUKS9tYWR2X3BvcHVsYXRlOiB2bV91dGlsLmMKKyQoT1VUUFVU
KS9wYWdlbWFwX2lvY3RsOiB2bV91dGlsLmMKICQoT1VUUFVUKS9zb2Z0LWRpcnR5OiB2bV91
dGlsLmMKICQoT1VUUFVUKS9zcGxpdF9odWdlX3BhZ2VfdGVzdDogdm1fdXRpbC5jCiAkKE9V
VFBVVCkvdXNlcmZhdWx0ZmQ6IHZtX3V0aWwuYwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdm0vcGFnZW1hcF9pb2N0bC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdm0vcGFnZW1hcF9pb2N0bC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwMC4uODc3NjQ2ZjllZThhCi0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdm0vcGFnZW1hcF9pb2N0bC5jCkBAIC0wLDAgKzEsODgwIEBACisvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAorI2luY2x1ZGUgPHN0ZGlvLmg+Cisj
aW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzeXMv
bW1hbi5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8bWFsbG9jLmg+CisjaW5j
bHVkZSAidm1fdXRpbC5oIgorI2luY2x1ZGUgIi4uL2tzZWxmdGVzdC5oIgorI2luY2x1ZGUg
PGxpbnV4L3R5cGVzLmg+CisjaW5jbHVkZSA8bGludXgvdXNlcmZhdWx0ZmQuaD4KKyNpbmNs
dWRlIDxsaW51eC9mcy5oPgorI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgorI2luY2x1ZGUgPHN5
cy9zdGF0Lmg+CisjaW5jbHVkZSA8bWF0aC5oPgorI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4K
KworI2RlZmluZSBQQUdFTUFQX09QX01BU0sJCShQQUdFX0lTX1dUIHwgUEFHRV9JU19GSUxF
IHwJXAorCQkJCSBQQUdFX0lTX1BSRVNFTlQgfCBQQUdFX0lTX1NXQVBQRUQpCisjZGVmaW5l
IFBBR0VNQVBfTk9OX1dUX01BU0sJKFBBR0VfSVNfRklMRSB8CVBBR0VfSVNfUFJFU0VOVCB8
CVwKKwkJCQkgUEFHRV9JU19TV0FQUEVEKQorCisjZGVmaW5lIFRFU1RfSVRFUkFUSU9OUyAx
MAorI2RlZmluZSBQQUdFTUFQICIvcHJvYy9zZWxmL3BhZ2VtYXAiCitpbnQgcGFnZW1hcF9m
ZDsKK2ludCB1ZmZkOworaW50IHBhZ2Vfc2l6ZTsKK2ludCBocGFnZV9zaXplOworCitzdGF0
aWMgbG9uZyBwYWdlbWFwX2lvY3RsKHZvaWQgKnN0YXJ0LCBpbnQgbGVuLCB2b2lkICp2ZWMs
IGludCB2ZWNfbGVuLCBpbnQgZmxhZywKKwkJCSAgaW50IG1heF9wYWdlcywgbG9uZyByZXF1
aXJlZF9tYXNrLCBsb25nIGFueW9mX21hc2ssIGxvbmcgZXhjbHVkZWRfbWFzaywKKwkJCSAg
bG9uZyByZXR1cm5fbWFzaykKK3sKKwlzdHJ1Y3QgcGFnZW1hcF9zY2FuX2FyZyBhcmc7CisJ
aW50IHJldDsKKworCWFyZy5zdGFydCA9ICh1aW50cHRyX3Qpc3RhcnQ7CisJYXJnLmxlbiA9
IGxlbjsKKwlhcmcudmVjID0gKHVpbnRwdHJfdCl2ZWM7CisJYXJnLnZlY19sZW4gPSB2ZWNf
bGVuOworCWFyZy5mbGFncyA9IGZsYWc7CisJYXJnLm1heF9wYWdlcyA9IG1heF9wYWdlczsK
KwlhcmcucmVxdWlyZWRfbWFzayA9IHJlcXVpcmVkX21hc2s7CisJYXJnLmFueW9mX21hc2sg
PSBhbnlvZl9tYXNrOworCWFyZy5leGNsdWRlZF9tYXNrID0gZXhjbHVkZWRfbWFzazsKKwlh
cmcucmV0dXJuX21hc2sgPSByZXR1cm5fbWFzazsKKworCXJldCA9IGlvY3RsKHBhZ2VtYXBf
ZmQsIFBBR0VNQVBfU0NBTiwgJmFyZyk7CisKKwlyZXR1cm4gcmV0OworfQorCitpbnQgaW5p
dF91ZmZkKHZvaWQpCit7CisJc3RydWN0IHVmZmRpb19hcGkgdWZmZGlvX2FwaTsKKworCXVm
ZmQgPSBzeXNjYWxsKF9fTlJfdXNlcmZhdWx0ZmQsIE9fQ0xPRVhFQyB8IE9fTk9OQkxPQ0sp
OworCWlmICh1ZmZkID09IC0xKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coInVmZmQgc3lzY2Fs
bCBmYWlsZWRcbiIpOworCisJdWZmZGlvX2FwaS5hcGkgPSBVRkZEX0FQSTsKKwl1ZmZkaW9f
YXBpLmZlYXR1cmVzID0gVUZGRF9GRUFUVVJFX1dQX0FTWU5DOworCWlmIChpb2N0bCh1ZmZk
LCBVRkZESU9fQVBJLCAmdWZmZGlvX2FwaSkpCisJCWtzZnRfZXhpdF9mYWlsX21zZygiVUZG
RElPX0FQSVxuIik7CisKKwlpZiAodWZmZGlvX2FwaS5hcGkgIT0gVUZGRF9BUEkpCisJCWtz
ZnRfZXhpdF9mYWlsX21zZygiVUZGRElPX0FQSSBlcnJvciAlbGx1XG4iLCB1ZmZkaW9fYXBp
LmFwaSk7CisKKwlyZXR1cm4gMDsKK30KKworaW50IHdwX2luaXQodm9pZCAqbHBCYXNlQWRk
cmVzcywgaW50IGR3UmVnaW9uU2l6ZSkKK3sKKwlzdHJ1Y3QgdWZmZGlvX3JlZ2lzdGVyIHVm
ZmRpb19yZWdpc3RlcjsKKwlzdHJ1Y3QgdWZmZGlvX3dyaXRlcHJvdGVjdCB3cDsKKworCS8q
IFRPRE86IGNhbiBpdCBiZSBhdm9pZGVkPyBXcml0ZSBwcm90ZWN0IGRvZXNuJ3QgZW5nYWdl
IG9uIHRoZSBwYWdlcyBpZiB0aGV5IGFyZW4ndAorCSAqIHByZXNlbnQgYWxyZWFkeS4gVGhl
IHBhZ2VzIGNhbiBiZSBtYWRlIHByZXNlbnQgYnkgd3JpdGluZyB0byB0aGVtLgorCSAqLwor
CW1lbXNldChscEJhc2VBZGRyZXNzLCAtMSwgZHdSZWdpb25TaXplKTsKKworCXVmZmRpb19y
ZWdpc3Rlci5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKWxwQmFzZUFkZHJlc3M7CisJ
dWZmZGlvX3JlZ2lzdGVyLnJhbmdlLmxlbiA9IGR3UmVnaW9uU2l6ZTsKKwl1ZmZkaW9fcmVn
aXN0ZXIubW9kZSA9IFVGRkRJT19SRUdJU1RFUl9NT0RFX1dQOworCWlmIChpb2N0bCh1ZmZk
LCBVRkZESU9fUkVHSVNURVIsICZ1ZmZkaW9fcmVnaXN0ZXIpID09IC0xKQorCQlrc2Z0X2V4
aXRfZmFpbF9tc2coImlvY3RsKFVGRkRJT19SRUdJU1RFUilcbiIpOworCisJaWYgKCEodWZm
ZGlvX3JlZ2lzdGVyLmlvY3RscyAmIFVGRkRJT19XUklURVBST1RFQ1QpKQorCQlrc2Z0X2V4
aXRfZmFpbF9tc2coImlvY3RsIHNldCBpcyBpbmNvcnJlY3RcbiIpOworCisJaWYgKHJhbmQo
KSAlIDIpIHsKKwkJd3AucmFuZ2Uuc3RhcnQgPSAodW5zaWduZWQgbG9uZylscEJhc2VBZGRy
ZXNzOworCQl3cC5yYW5nZS5sZW4gPSBkd1JlZ2lvblNpemU7CisJCXdwLm1vZGUgPSBVRkZE
SU9fV1JJVEVQUk9URUNUX01PREVfV1A7CisKKwkJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19X
UklURVBST1RFQ1QsICZ3cCkgPT0gLTEpCisJCQlrc2Z0X2V4aXRfZmFpbF9tc2coImlvY3Rs
KFVGRkRJT19XUklURVBST1RFQ1QpXG4iKTsKKwl9IGVsc2UgeworCQlpZiAocGFnZW1hcF9p
b2N0bChscEJhc2VBZGRyZXNzLCBkd1JlZ2lvblNpemUsIE5VTEwsIDAsIFBBR0VNQVBfV1Bf
RU5HQUdFLCAwLAorCQkJCSAgMCwgMCwgMCwgMCkgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxf
bXNnKCJlcnJvciAlZCAlZCAlc1xuIiwgMSwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisJ
fQorCXJldHVybiAwOworfQorCitpbnQgd3BfZnJlZSh2b2lkICpscEJhc2VBZGRyZXNzLCBp
bnQgZHdSZWdpb25TaXplKQoreworCXN0cnVjdCB1ZmZkaW9fcmVnaXN0ZXIgdWZmZGlvX3Jl
Z2lzdGVyOworCisJdWZmZGlvX3JlZ2lzdGVyLnJhbmdlLnN0YXJ0ID0gKHVuc2lnbmVkIGxv
bmcpbHBCYXNlQWRkcmVzczsKKwl1ZmZkaW9fcmVnaXN0ZXIucmFuZ2UubGVuID0gZHdSZWdp
b25TaXplOworCXVmZmRpb19yZWdpc3Rlci5tb2RlID0gVUZGRElPX1JFR0lTVEVSX01PREVf
V1A7CisJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19VTlJFR0lTVEVSLCAmdWZmZGlvX3JlZ2lz
dGVyLnJhbmdlKSkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJpb2N0bCB1bnJlZ2lzdGVyIGZh
aWx1cmVcbiIpOworCXJldHVybiAwOworfQorCitpbnQgY2xlYXJfc29mdGRpcnR5X3dwKHZv
aWQgKmxwQmFzZUFkZHJlc3MsIGludCBkd1JlZ2lvblNpemUpCit7CisJc3RydWN0IHVmZmRp
b193cml0ZXByb3RlY3Qgd3A7CisKKwlpZiAocmFuZCgpICUgMikgeworCQl3cC5yYW5nZS5z
dGFydCA9ICh1bnNpZ25lZCBsb25nKWxwQmFzZUFkZHJlc3M7CisJCXdwLnJhbmdlLmxlbiA9
IGR3UmVnaW9uU2l6ZTsKKwkJd3AubW9kZSA9IFVGRkRJT19XUklURVBST1RFQ1RfTU9ERV9X
UDsKKworCQlpZiAoaW9jdGwodWZmZCwgVUZGRElPX1dSSVRFUFJPVEVDVCwgJndwKSA9PSAt
MSkKKwkJCWtzZnRfZXhpdF9mYWlsX21zZygiaW9jdGwoVUZGRElPX1dSSVRFUFJPVEVDVClc
biIpOworCX0gZWxzZSB7CisJCWlmIChwYWdlbWFwX2lvY3RsKGxwQmFzZUFkZHJlc3MsIGR3
UmVnaW9uU2l6ZSwgTlVMTCwgMCwgUEFHRU1BUF9XUF9FTkdBR0UsIDAsCisJCQkJICAwLCAw
LCAwLCAwKSA8IDApCisJCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4i
LCAxLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKwl9CisJcmV0dXJuIDA7Cit9CisKK2lu
dCBzYW5pdHlfdGVzdHNfc2Qodm9pZCkKK3sKKwljaGFyICptZW0sICptWzJdOworCWludCBt
ZW1fc2l6ZSwgdmVjX3NpemUsIHJldCwgcmV0MiwgcmV0MywgaSwgbnVtX3BhZ2VzID0gMTA7
CisJc3RydWN0IHBhZ2VfcmVnaW9uICp2ZWM7CisKKwl2ZWNfc2l6ZSA9IDEwMDsKKwltZW1f
c2l6ZSA9IG51bV9wYWdlcyAqIHBhZ2Vfc2l6ZTsKKworCXZlYyA9IG1hbGxvYyhzaXplb2Yo
c3RydWN0IHBhZ2VfcmVnaW9uKSAqIHZlY19zaXplKTsKKwlpZiAoIXZlYykKKwkJa3NmdF9l
eGl0X2ZhaWxfbXNnKCJlcnJvciBub21lbVxuIik7CisJbWVtID0gbW1hcChOVUxMLCBtZW1f
c2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTiwg
LTEsIDApOworCWlmIChtZW0gPT0gTUFQX0ZBSUxFRCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNn
KCJlcnJvciBub21lbVxuIik7CisKKwl3cF9pbml0KG1lbSwgbWVtX3NpemUpOworCisJLyog
MS4gd3Jvbmcgb3BlcmF0aW9uICovCisJa3NmdF90ZXN0X3Jlc3VsdChwYWdlbWFwX2lvY3Rs
KG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsIC0xLAorCQkJCSAgICAgICAwLCBQQUdF
X0lTX1dULCAwLCAwLCBQQUdFX0lTX1dUKSA8IDAsCisJCQkgIiVzIHdyb25nIGZsYWcgc3Bl
Y2lmaWVkXG4iLCBfX2Z1bmNfXyk7CisJa3NmdF90ZXN0X3Jlc3VsdChwYWdlbWFwX2lvY3Rs
KG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsIDgsCisJCQkJICAgICAgIDAsIDB4MTEx
MSwgMCwgMCwgUEFHRV9JU19XVCkgPCAwLAorCQkJICIlcyB3cm9uZyBtYXNrIHNwZWNpZmll
ZFxuIiwgX19mdW5jX18pOworCWtzZnRfdGVzdF9yZXN1bHQocGFnZW1hcF9pb2N0bChtZW0s
IG1lbV9zaXplLCB2ZWMsIHZlY19zaXplLCAwLAorCQkJCSAgICAgICAwLCBQQUdFX0lTX1dU
LCAwLCAwLCAweDEwMDApIDwgMCwKKwkJCSAiJXMgd3JvbmcgcmV0dXJuIG1hc2sgc3BlY2lm
aWVkXG4iLCBfX2Z1bmNfXyk7CisJa3NmdF90ZXN0X3Jlc3VsdChwYWdlbWFwX2lvY3RsKG1l
bSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsCisJCQkJICAgICAgIFBBR0VNQVBfV1BfRU5H
QUdFIHwgMHgzMiwKKwkJCQkgICAgICAgMCwgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19X
VCkgPCAwLAorCQkJICIlcyBtaXh0dXJlIG9mIGNvcnJlY3QgYW5kIHdyb25nIGZsYWdcbiIs
IF9fZnVuY19fKTsKKworCS8qIDIuIENsZWFyIGFyZWEgd2l0aCBsYXJnZXIgdmVjIHNpemUg
Ki8KKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUs
IFBBR0VNQVBfV1BfRU5HQUdFLCAwLAorCQkJICAgIFBBR0VfSVNfV1QsIDAsIDAsIFBBR0Vf
SVNfV1QpOworCWtzZnRfdGVzdF9yZXN1bHQocmV0ID49IDAsICIlcyBDbGVhciBhcmVhIHdp
dGggbGFyZ2VyIHZlYyBzaXplXG4iLCBfX2Z1bmNfXyk7CisKKwkvKiAzLiBSZXBlYXRlZCBw
YXR0ZXJuIG9mIGRpcnR5IGFuZCBub24tZGlydHkgcGFnZXMgKi8KKwlmb3IgKGkgPSAwOyBp
IDwgbWVtX3NpemU7IGkgKz0gMiAqIHBhZ2Vfc2l6ZSkKKwkJbWVtW2ldKys7CisKKwlyZXQg
PSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsIDAsIDAsIFBB
R0VfSVNfV1QsIDAsIDAsCisJCQkgICAgUEFHRV9JU19XVCk7CisJaWYgKHJldCA8IDApCisJ
CWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwgZXJybm8sIHN0
cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9PSBtZW1fc2l6ZS8o
cGFnZV9zaXplICogMiksCisJCQkgIiVzIFJlcGVhdGVkIHBhdHRlcm4gb2YgZGlydHkgYW5k
IG5vbi1kaXJ0eSBwYWdlc1xuIiwgX19mdW5jX18pOworCisJLyogNC4gUmVwZWF0ZWQgcGF0
dGVybiBvZiBkaXJ0eSBhbmQgbm9uLWRpcnR5IHBhZ2VzIGluIHBhcnRzICovCisJcmV0ID0g
cGFnZW1hcF9pb2N0bChtZW0sIG1lbV9zaXplLCB2ZWMsIG51bV9wYWdlcy81LCBQQUdFTUFQ
X1dQX0VOR0FHRSwKKwkJCSAgICBudW1fcGFnZXMvMiAtIDIsIFBBR0VfSVNfV1QsIDAsIDAs
IFBBR0VfSVNfV1QpOworCWlmIChyZXQgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVy
cm9yICVkICVkICVzXG4iLCByZXQsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJcmV0
MiA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwgdmVjLCAyLCAwLCAwLCBQQUdFX0lT
X1dULCAwLCAwLAorCQkJICAgICBQQUdFX0lTX1dUKTsKKwlpZiAocmV0MiA8IDApCisJCWtz
ZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldDIsIGVycm5vLCBzdHJl
cnJvcihlcnJubykpOworCisJcmV0MyA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwg
dmVjLCBudW1fcGFnZXMvMiwgMCwgMCwgUEFHRV9JU19XVCwgMCwgMCwKKwkJCSAgICAgUEFH
RV9JU19XVCk7CisJaWYgKHJldDMgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9y
ICVkICVkICVzXG4iLCByZXQzLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCWtzZnRf
dGVzdF9yZXN1bHQoKHJldCArIHJldDMpID09IG51bV9wYWdlcy8yICYmIHJldDIgPT0gMiwK
KwkJCSAiJXMgUmVwZWF0ZWQgcGF0dGVybiBvZiBkaXJ0eSBhbmQgbm9uLWRpcnR5IHBhZ2Vz
IGluIHBhcnRzXG4iLCBfX2Z1bmNfXyk7CisKKwl3cF9mcmVlKG1lbSwgbWVtX3NpemUpOwor
CW11bm1hcChtZW0sIG1lbV9zaXplKTsKKworCS8qIDUuIFR3byByZWdpb25zICovCisJbVsw
XSA9IG1tYXAoTlVMTCwgbWVtX3NpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9Q
UklWQVRFIHwgTUFQX0FOT04sIC0xLCAwKTsKKwlpZiAobVswXSA9PSBNQVBfRkFJTEVEKQor
CQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yIG5vbWVtXG4iKTsKKwltWzFdID0gbW1hcChO
VUxMLCBtZW1fc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUgfCBN
QVBfQU5PTiwgLTEsIDApOworCWlmIChtWzFdID09IE1BUF9GQUlMRUQpCisJCWtzZnRfZXhp
dF9mYWlsX21zZygiZXJyb3Igbm9tZW1cbiIpOworCisJd3BfaW5pdChtWzBdLCBtZW1fc2l6
ZSk7CisJd3BfaW5pdChtWzFdLCBtZW1fc2l6ZSk7CisKKwltZW1zZXQobVswXSwgJ2EnLCBt
ZW1fc2l6ZSk7CisJbWVtc2V0KG1bMV0sICdiJywgbWVtX3NpemUpOworCisJcmV0ID0gcGFn
ZW1hcF9pb2N0bChtWzBdLCBtZW1fc2l6ZSwgTlVMTCwgMCwgUEFHRU1BUF9XUF9FTkdBR0Us
IDAsCisJCQkgICAgMCwgMCwgMCwgMCk7CisJaWYgKHJldCA8IDApCisJCWtzZnRfZXhpdF9m
YWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5v
KSk7CisKKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1bMV0sIG1lbV9zaXplLCB2ZWMsIDEsIDAs
IDAsIFBBR0VfSVNfV1QsIDAsIDAsCisJCQkgICAgUEFHRV9JU19XVCk7CisJaWYgKHJldCA8
IDApCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwgZXJy
bm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9PSAxICYm
IHZlY1swXS5sZW4gPT0gbWVtX3NpemUvcGFnZV9zaXplLAorCQkJICIlcyBUd28gcmVnaW9u
c1xuIiwgX19mdW5jX18pOworCisJd3BfZnJlZShtWzBdLCBtZW1fc2l6ZSk7CisJd3BfZnJl
ZShtWzFdLCBtZW1fc2l6ZSk7CisJbXVubWFwKG1bMF0sIG1lbV9zaXplKTsKKwltdW5tYXAo
bVsxXSwgbWVtX3NpemUpOworCisJZnJlZSh2ZWMpOworCXJldHVybiAwOworfQorCitpbnQg
YmFzZV90ZXN0cyhjaGFyICpwcmVmaXgsIGNoYXIgKm1lbSwgaW50IG1lbV9zaXplLCBpbnQg
c2tpcCkKK3sKKwlpbnQgdmVjX3NpemUsIHJldCwgZGlydHksIGRpcnR5MjsKKwlzdHJ1Y3Qg
cGFnZV9yZWdpb24gKnZlYywgKnZlYzI7CisKKwlpZiAoc2tpcCkgeworCQlrc2Z0X3Rlc3Rf
cmVzdWx0X3NraXAoIiVzIGFsbCBuZXcgcGFnZXMgbXVzdCBiZSBzb2Z0IGRpcnR5XG4iLCBw
cmVmaXgpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIiVzIGFsbCBwYWdlcyBtdXN0IG5v
dCBiZSBzb2Z0IGRpcnR5XG4iLCBwcmVmaXgpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAo
IiVzIGFsbCBwYWdlcyBkaXJ0eSBvdGhlciB0aGFuIGZpcnN0IGFuZCB0aGUgbGFzdCBvbmVc
biIsCisJCQkJICAgICAgcHJlZml4KTsKKwkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCIlcyBv
bmx5IG1pZGRsZSBwYWdlIGRpcnR5XG4iLCBwcmVmaXgpOworCQlrc2Z0X3Rlc3RfcmVzdWx0
X3NraXAoIiVzIG9ubHkgdHdvIG1pZGRsZSBwYWdlcyBkaXJ0eVxuIiwgcHJlZml4KTsKKwkJ
a3NmdF90ZXN0X3Jlc3VsdF9za2lwKCIlcyBvbmx5IGdldCAyIGRpcnR5IHBhZ2VzIGFuZCBj
bGVhciB0aGVtIGFzIHdlbGxcbiIsIHByZWZpeCk7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tp
cCgiJXMgUmFuZ2UgY2xlYXIgb25seVxuIiwgcHJlZml4KTsKKwkJcmV0dXJuIDA7CisJfQor
CisJdmVjX3NpemUgPSBtZW1fc2l6ZS9wYWdlX3NpemU7CisJdmVjID0gbWFsbG9jKHNpemVv
ZihzdHJ1Y3QgcGFnZV9yZWdpb24pICogdmVjX3NpemUpOworCXZlYzIgPSBtYWxsb2Moc2l6
ZW9mKHN0cnVjdCBwYWdlX3JlZ2lvbikgKiB2ZWNfc2l6ZSk7CisKKwkvKiAxLiBhbGwgbmV3
IHBhZ2VzIG11c3QgYmUgbm90IGJlIHNvZnQgZGlydHkgKi8KKwlkaXJ0eSA9IHBhZ2VtYXBf
aW9jdGwobWVtLCBtZW1fc2l6ZSwgdmVjLCAxLCBQQUdFTUFQX1dQX0VOR0FHRSwgdmVjX3Np
emUgLSAyLAorCQkJICAgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7CisJaWYg
KGRpcnR5IDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwg
ZGlydHksIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJZGlydHkyID0gcGFnZW1hcF9p
b2N0bChtZW0sIG1lbV9zaXplLCB2ZWMyLCAxLCBQQUdFTUFQX1dQX0VOR0FHRSwgMCwKKwkJ
CSAgICAgICBQQUdFX0lTX1dULCAwLCAwLCBQQUdFX0lTX1dUKTsKKwlpZiAoZGlydHkyIDwg
MCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwgZGlydHkyLCBl
cnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCWtzZnRfdGVzdF9yZXN1bHQoZGlydHkgPT0g
MCAmJiBkaXJ0eTIgPT0gMCwKKwkJCSAiJXMgYWxsIG5ldyBwYWdlcyBtdXN0IGJlIHNvZnQg
ZGlydHlcbiIsIHByZWZpeCk7CisKKwkvKiAyLiBhbGwgcGFnZXMgbXVzdCBub3QgYmUgc29m
dCBkaXJ0eSAqLworCWRpcnR5ID0gcGFnZW1hcF9pb2N0bChtZW0sIG1lbV9zaXplLCB2ZWMs
IDEsIDAsIDAsIFBBR0VfSVNfV1QsIDAsIDAsCisJCQkgICAgICBQQUdFX0lTX1dUKTsKKwlp
ZiAoZGlydHkgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4i
LCBkaXJ0eSwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0
KGRpcnR5ID09IDAsICIlcyBhbGwgcGFnZXMgbXVzdCBub3QgYmUgc29mdCBkaXJ0eVxuIiwg
cHJlZml4KTsKKworCS8qIDMuIGFsbCBwYWdlcyBkaXJ0eSBvdGhlciB0aGFuIGZpcnN0IGFu
ZCB0aGUgbGFzdCBvbmUgKi8KKwltZW1zZXQobWVtICsgcGFnZV9zaXplLCAwLCBtZW1fc2l6
ZSAtICgyICogcGFnZV9zaXplKSk7CisKKwlkaXJ0eSA9IHBhZ2VtYXBfaW9jdGwobWVtLCBt
ZW1fc2l6ZSwgdmVjLCAxLCAwLCAwLCBQQUdFX0lTX1dULCAwLCAwLAorCQkJICAgICAgUEFH
RV9JU19XVCk7CisJaWYgKGRpcnR5IDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJv
ciAlZCAlZCAlc1xuIiwgZGlydHksIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJa3Nm
dF90ZXN0X3Jlc3VsdChkaXJ0eSA9PSAxICYmIHZlY1swXS5sZW4gPj0gdmVjX3NpemUgLSAy
ICYmIHZlY1swXS5sZW4gPD0gdmVjX3NpemUsCisJCQkgIiVzIGFsbCBwYWdlcyBkaXJ0eSBv
dGhlciB0aGFuIGZpcnN0IGFuZCB0aGUgbGFzdCBvbmVcbiIsIHByZWZpeCk7CisKKwkvKiA0
LiBvbmx5IG1pZGRsZSBwYWdlIGRpcnR5ICovCisJY2xlYXJfc29mdGRpcnR5X3dwKG1lbSwg
bWVtX3NpemUpOworCW1lbVt2ZWNfc2l6ZS8yICogcGFnZV9zaXplXSsrOworCisJZGlydHkg
PSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsIDAsIDAsIFBB
R0VfSVNfV1QsIDAsIDAsCisJCQkgICAgICBQQUdFX0lTX1dUKTsKKwlpZiAoZGlydHkgPCAw
KQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4iLCBkaXJ0eSwgZXJy
bm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KGRpcnR5ID09IDEg
JiYgdmVjWzBdLmxlbiA+PSAxLAorCQkJICIlcyBvbmx5IG1pZGRsZSBwYWdlIGRpcnR5XG4i
LCBwcmVmaXgpOworCisJLyogNS4gb25seSB0d28gbWlkZGxlIHBhZ2VzIGRpcnR5IGFuZCB3
YWxrIG92ZXIgb25seSBtaWRkbGUgcGFnZXMgKi8KKwljbGVhcl9zb2Z0ZGlydHlfd3AobWVt
LCBtZW1fc2l6ZSk7CisJbWVtW3ZlY19zaXplLzIgKiBwYWdlX3NpemVdKys7CisJbWVtWyh2
ZWNfc2l6ZS8yICsgMSkgKiBwYWdlX3NpemVdKys7CisKKwlkaXJ0eSA9IHBhZ2VtYXBfaW9j
dGwoJm1lbVt2ZWNfc2l6ZS8yICogcGFnZV9zaXplXSwgMiAqIHBhZ2Vfc2l6ZSwgdmVjLCAx
LCAwLCAwLAorCQkJICAgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7CisJaWYg
KGRpcnR5IDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwg
ZGlydHksIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJa3NmdF90ZXN0X3Jlc3VsdChk
aXJ0eSA9PSAxICYmIHZlY1swXS5zdGFydCA9PSAodWludHB0cl90KSgmbWVtW3ZlY19zaXpl
LzIgKiBwYWdlX3NpemVdKSAmJgorCQkJIHZlY1swXS5sZW4gPT0gMiwKKwkJCSAiJXMgb25s
eSB0d28gbWlkZGxlIHBhZ2VzIGRpcnR5XG4iLCBwcmVmaXgpOworCisJLyogNi4gb25seSBn
ZXQgMiBkaXJ0eSBwYWdlcyBhbmQgY2xlYXIgdGhlbSBhcyB3ZWxsICovCisJbWVtc2V0KG1l
bSwgLTEsIG1lbV9zaXplKTsKKworCS8qIGdldCBhbmQgY2xlYXIgc2Vjb25kIGFuZCB0aGly
ZCBwYWdlcyAqLworCXJldCA9IHBhZ2VtYXBfaW9jdGwobWVtICsgcGFnZV9zaXplLCAyICog
cGFnZV9zaXplLCB2ZWMsIDEsIFBBR0VNQVBfV1BfRU5HQUdFLAorCQkJICAgIDIsIFBBR0Vf
SVNfV1QsIDAsIDAsIFBBR0VfSVNfV1QpOworCWlmIChyZXQgPCAwKQorCQlrc2Z0X2V4aXRf
ZmFpbF9tc2coImVycm9yICVkICVkICVzXG4iLCByZXQsIGVycm5vLCBzdHJlcnJvcihlcnJu
bykpOworCisJZGlydHkgPSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYzIsIHZl
Y19zaXplLCAwLCAwLAorCQkJICAgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7
CisJaWYgKGRpcnR5IDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAl
c1xuIiwgZGlydHksIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJa3NmdF90ZXN0X3Jl
c3VsdChyZXQgPT0gMSAmJiB2ZWNbMF0ubGVuID09IDIgJiYKKwkJCSB2ZWNbMF0uc3RhcnQg
PT0gKHVpbnRwdHJfdCkobWVtICsgcGFnZV9zaXplKSAmJgorCQkJIGRpcnR5ID09IDIgJiYg
dmVjMlswXS5sZW4gPT0gMSAmJiB2ZWMyWzBdLnN0YXJ0ID09ICh1aW50cHRyX3QpbWVtICYm
CisJCQkgdmVjMlsxXS5sZW4gPT0gdmVjX3NpemUgLSAzICYmCisJCQkgdmVjMlsxXS5zdGFy
dCA9PSAodWludHB0cl90KShtZW0gKyAzICogcGFnZV9zaXplKSwKKwkJCSAiJXMgb25seSBn
ZXQgMiBkaXJ0eSBwYWdlcyBhbmQgY2xlYXIgdGhlbSBhcyB3ZWxsXG4iLCBwcmVmaXgpOwor
CisJLyogNy4gUmFuZ2UgY2xlYXIgb25seSAqLworCW1lbXNldChtZW0sIC0xLCBtZW1fc2l6
ZSk7CisKKwlkaXJ0eSA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwgTlVMTCwgMCwg
UEFHRU1BUF9XUF9FTkdBR0UsIDAsCisJCQkgICAgICAwLCAwLCAwLCAwKTsKKwlpZiAoZGly
dHkgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4iLCBkaXJ0
eSwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlkaXJ0eTIgPSBwYWdlbWFwX2lvY3Rs
KG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3NpemUsIDAsIDAsCisJCQkgICAgICAgUEFHRV9J
U19XVCwgMCwgMCwgUEFHRV9JU19XVCk7CisJaWYgKGRpcnR5MiA8IDApCisJCWtzZnRfZXhp
dF9mYWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIGRpcnR5MiwgZXJybm8sIHN0cmVycm9y
KGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KGRpcnR5ID09IDAgJiYgZGlydHkyID09
IDAsICIlcyBSYW5nZSBjbGVhciBvbmx5XG4iLAorCQkJIHByZWZpeCk7CisKKwlmcmVlKHZl
Yyk7CisJZnJlZSh2ZWMyKTsKKwlyZXR1cm4gMDsKK30KKwordm9pZCAqZ2V0aHVnZXBhZ2Uo
aW50IG1hcF9zaXplKQoreworCWludCByZXQ7CisJY2hhciAqbWFwOworCisJbWFwID0gbWVt
YWxpZ24oaHBhZ2Vfc2l6ZSwgbWFwX3NpemUpOworCWlmICghbWFwKQorCQlrc2Z0X2V4aXRf
ZmFpbF9tc2coIm1lbWFsaWduIGZhaWxlZCAlZCAlc1xuIiwgZXJybm8sIHN0cmVycm9yKGVy
cm5vKSk7CisKKwlyZXQgPSBtYWR2aXNlKG1hcCwgbWFwX3NpemUsIE1BRFZfSFVHRVBBR0Up
OworCWlmIChyZXQpCisJCWtzZnRfZXhpdF9mYWlsX21zZygibWFkdmlzZSBmYWlsZWQgJWQg
JWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwl3cF9pbml0KG1h
cCwgbWFwX3NpemUpOworCisJaWYgKGNoZWNrX2h1Z2VfYW5vbihtYXAsIG1hcF9zaXplL2hw
YWdlX3NpemUsIGhwYWdlX3NpemUpKQorCQlyZXR1cm4gbWFwOworCisJZnJlZShtYXApOwor
CXJldHVybiBOVUxMOworCit9CisKK2ludCBocGFnZV91bml0X3Rlc3RzKHZvaWQpCit7CisJ
Y2hhciAqbWFwOworCWludCByZXQ7CisJc2l6ZV90IG51bV9wYWdlcyA9IDEwOworCWludCBt
YXBfc2l6ZSA9IGhwYWdlX3NpemUgKiBudW1fcGFnZXM7CisJaW50IHZlY19zaXplID0gbWFw
X3NpemUvcGFnZV9zaXplOworCXN0cnVjdCBwYWdlX3JlZ2lvbiAqdmVjLCAqdmVjMjsKKwor
CXZlYyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IHBhZ2VfcmVnaW9uKSAqIHZlY19zaXplKTsK
Kwl2ZWMyID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pICogdmVjX3NpemUp
OworCWlmICghdmVjIHx8ICF2ZWMyKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coIm1hbGxvYyBm
YWlsZWRcbiIpOworCisJbWFwID0gZ2V0aHVnZXBhZ2UobWFwX3NpemUpOworCWlmIChtYXAp
IHsKKwkJLyogMS4gYWxsIG5ldyBodWdlIHBhZ2UgbXVzdCBub3QgYmUgZGlydHkgKi8KKwkJ
cmV0ID0gcGFnZW1hcF9pb2N0bChtYXAsIG1hcF9zaXplLCB2ZWMsIHZlY19zaXplLCBQQUdF
TUFQX1dQX0VOR0FHRSwgMCwKKwkJCQkgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19X
VCk7CisJCWlmIChyZXQgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAl
ZCAlc1xuIiwgcmV0LCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCQlrc2Z0X3Rlc3Rf
cmVzdWx0KHJldCA9PSAwLCAiJXMgYWxsIG5ldyBodWdlIHBhZ2UgbXVzdCBiZSBkaXJ0eVxu
IiwgX19mdW5jX18pOworCisJCS8qIDIuIGFsbCB0aGUgaHVnZSBwYWdlIG11c3Qgbm90IGJl
IGRpcnR5ICovCisJCXJldCA9IHBhZ2VtYXBfaW9jdGwobWFwLCBtYXBfc2l6ZSwgdmVjLCB2
ZWNfc2l6ZSwgMCwgMCwKKwkJCQkgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7
CisJCWlmIChyZXQgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAl
c1xuIiwgcmV0LCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCQlrc2Z0X3Rlc3RfcmVz
dWx0KHJldCA9PSAwLCAiJXMgYWxsIHRoZSBodWdlIHBhZ2UgbXVzdCBub3QgYmUgZGlydHlc
biIsIF9fZnVuY19fKTsKKworCQkvKiAzLiBhbGwgdGhlIGh1Z2UgcGFnZSBtdXN0IGJlIGRp
cnR5IGFuZCBjbGVhciBkaXJ0eSBhcyB3ZWxsICovCisJCW1lbXNldChtYXAsIC0xLCBtYXBf
c2l6ZSk7CisJCXJldCA9IHBhZ2VtYXBfaW9jdGwobWFwLCBtYXBfc2l6ZSwgdmVjLCB2ZWNf
c2l6ZSwgUEFHRU1BUF9XUF9FTkdBR0UsIDAsCisJCQkJICAgIFBBR0VfSVNfV1QsIDAsIDAs
IFBBR0VfSVNfV1QpOworCQlpZiAocmV0IDwgMCkKKwkJCWtzZnRfZXhpdF9mYWlsX21zZygi
ZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwkJ
a3NmdF90ZXN0X3Jlc3VsdChyZXQgPT0gMSAmJiB2ZWNbMF0uc3RhcnQgPT0gKHVpbnRwdHJf
dCltYXAgJiYKKwkJCQkgdmVjWzBdLmxlbiA9PSB2ZWNfc2l6ZSAmJiB2ZWNbMF0uYml0bWFw
ID09IFBBR0VfSVNfV1QsCisJCQkJICIlcyBhbGwgdGhlIGh1Z2UgcGFnZSBtdXN0IGJlIGRp
cnR5IGFuZCBjbGVhclxuIiwgX19mdW5jX18pOworCisJCS8qIDQuIG9ubHkgbWlkZGxlIHBh
Z2UgZGlydHkgKi8KKwkJd3BfZnJlZShtYXAsIG1hcF9zaXplKTsKKwkJZnJlZShtYXApOwor
CQltYXAgPSBnZXRodWdlcGFnZShtYXBfc2l6ZSk7CisJCXdwX2luaXQobWFwLCBtYXBfc2l6
ZSk7CisJCWNsZWFyX3NvZnRkaXJ0eV93cChtYXAsIG1hcF9zaXplKTsKKwkJbWFwW3ZlY19z
aXplLzIgKiBwYWdlX3NpemVdKys7CisKKwkJcmV0ID0gcGFnZW1hcF9pb2N0bChtYXAsIG1h
cF9zaXplLCB2ZWMsIHZlY19zaXplLCAwLCAwLAorCQkJCSAgICBQQUdFX0lTX1dULCAwLCAw
LCBQQUdFX0lTX1dUKTsKKwkJaWYgKHJldCA8IDApCisJCQlrc2Z0X2V4aXRfZmFpbF9tc2co
ImVycm9yICVkICVkICVzXG4iLCByZXQsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJ
CWtzZnRfdGVzdF9yZXN1bHQocmV0ID09IDEgJiYgdmVjWzBdLmxlbiA+IDAsCisJCQkJICIl
cyBvbmx5IG1pZGRsZSBwYWdlIGRpcnR5XG4iLCBfX2Z1bmNfXyk7CisKKwkJd3BfZnJlZSht
YXAsIG1hcF9zaXplKTsKKwkJZnJlZShtYXApOworCX0gZWxzZSB7CisJCWtzZnRfdGVzdF9y
ZXN1bHRfc2tpcCgiYWxsIG5ldyBodWdlIHBhZ2UgbXVzdCBiZSBkaXJ0eVxuIik7CisJCWtz
ZnRfdGVzdF9yZXN1bHRfc2tpcCgiYWxsIHRoZSBodWdlIHBhZ2UgbXVzdCBub3QgYmUgZGly
dHlcbiIpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoImFsbCB0aGUgaHVnZSBwYWdlIG11
c3QgYmUgZGlydHkgYW5kIGNsZWFyXG4iKTsKKwkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJv
bmx5IG1pZGRsZSBwYWdlIGRpcnR5XG4iKTsKKwl9CisKKwkvKiA1LiBjbGVhciBmaXJzdCBo
YWxmIG9mIGh1Z2UgcGFnZSAqLworCW1hcCA9IGdldGh1Z2VwYWdlKG1hcF9zaXplKTsKKwlp
ZiAobWFwKSB7CisKKwkJbWVtc2V0KG1hcCwgMCwgbWFwX3NpemUpOworCisJCXJldCA9IHBh
Z2VtYXBfaW9jdGwobWFwLCBtYXBfc2l6ZS8yLCBOVUxMLCAwLCBQQUdFTUFQX1dQX0VOR0FH
RSwgMCwKKwkJCQkgICAgMCwgMCwgMCwgMCk7CisJCWlmIChyZXQgPCAwKQorCQkJa3NmdF9l
eGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwgcmV0LCBlcnJubywgc3RyZXJyb3Io
ZXJybm8pKTsKKworCQlyZXQgPSBwYWdlbWFwX2lvY3RsKG1hcCwgbWFwX3NpemUsIHZlYywg
dmVjX3NpemUsIDAsIDAsCisJCQkJICAgIFBBR0VfSVNfV1QsIDAsIDAsIFBBR0VfSVNfV1Qp
OworCQlpZiAocmV0IDwgMCkKKwkJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQgJWQg
JXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwkJa3NmdF90ZXN0X3Jl
c3VsdChyZXQgPT0gMSAmJiB2ZWNbMF0ubGVuID09IHZlY19zaXplLzIgJiYKKwkJCQkgdmVj
WzBdLnN0YXJ0ID09ICh1aW50cHRyX3QpKG1hcCArIG1hcF9zaXplLzIpLAorCQkJCSAiJXMg
Y2xlYXIgZmlyc3QgaGFsZiBvZiBodWdlIHBhZ2VcbiIsIF9fZnVuY19fKTsKKwkJd3BfZnJl
ZShtYXAsIG1hcF9zaXplKTsKKwkJZnJlZShtYXApOworCX0gZWxzZSB7CisJCWtzZnRfdGVz
dF9yZXN1bHRfc2tpcCgiY2xlYXIgZmlyc3QgaGFsZiBvZiBodWdlIHBhZ2VcbiIpOworCX0K
KworCS8qIDYuIGNsZWFyIGZpcnN0IGhhbGYgb2YgaHVnZSBwYWdlIHdpdGggbGltaXRlZCBi
dWZmZXIgKi8KKwltYXAgPSBnZXRodWdlcGFnZShtYXBfc2l6ZSk7CisJaWYgKG1hcCkgewor
CQltZW1zZXQobWFwLCAwLCBtYXBfc2l6ZSk7CisKKwkJcmV0ID0gcGFnZW1hcF9pb2N0bCht
YXAsIG1hcF9zaXplLCB2ZWMsIHZlY19zaXplLCBQQUdFTUFQX1dQX0VOR0FHRSwKKwkJCQkg
ICAgdmVjX3NpemUvMiwgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7CisJCWlmIChy
ZXQgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwgcmV0
LCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCQlyZXQgPSBwYWdlbWFwX2lvY3RsKG1h
cCwgbWFwX3NpemUsIHZlYywgdmVjX3NpemUsIDAsIDAsCisJCQkJICAgIFBBR0VfSVNfV1Qs
IDAsIDAsIFBBR0VfSVNfV1QpOworCQlpZiAocmV0IDwgMCkKKwkJCWtzZnRfZXhpdF9mYWls
X21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7
CisKKwkJa3NmdF90ZXN0X3Jlc3VsdChyZXQgPT0gMSAmJiB2ZWNbMF0ubGVuID09IHZlY19z
aXplLzIgJiYKKwkJCQkgdmVjWzBdLnN0YXJ0ID09ICh1aW50cHRyX3QpKG1hcCArIG1hcF9z
aXplLzIpLAorCQkJCSAiJXMgY2xlYXIgZmlyc3QgaGFsZiBvZiBodWdlIHBhZ2Ugd2l0aCBs
aW1pdGVkIGJ1ZmZlclxuIiwKKwkJCQkgX19mdW5jX18pOworCQl3cF9mcmVlKG1hcCwgbWFw
X3NpemUpOworCQlmcmVlKG1hcCk7CisJfSBlbHNlIHsKKwkJa3NmdF90ZXN0X3Jlc3VsdF9z
a2lwKCJjbGVhciBmaXJzdCBoYWxmIG9mIGh1Z2UgcGFnZSB3aXRoIGxpbWl0ZWQgYnVmZmVy
XG4iKTsKKwl9CisKKwkvKiA3LiBjbGVhciBzZWNvbmQgaGFsZiBvZiBodWdlIHBhZ2UgKi8K
KwltYXAgPSBnZXRodWdlcGFnZShtYXBfc2l6ZSk7CisJaWYgKG1hcCkgeworCQltZW1zZXQo
bWFwLCAtMSwgbWFwX3NpemUpOworCQlyZXQgPSBwYWdlbWFwX2lvY3RsKG1hcCArIG1hcF9z
aXplLzIsIG1hcF9zaXplLzIsIE5VTEwsIDAsIFBBR0VNQVBfV1BfRU5HQUdFLAorCQkJCSAg
ICAwLCAwLCAwLCAwLCAwKTsKKwkJaWYgKHJldCA8IDApCisJCQlrc2Z0X2V4aXRfZmFpbF9t
c2coImVycm9yICVkICVkICVzXG4iLCByZXQsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwor
CisJCXJldCA9IHBhZ2VtYXBfaW9jdGwobWFwLCBtYXBfc2l6ZSwgdmVjLCB2ZWNfc2l6ZSwg
MCwgMCwKKwkJCQkgICAgUEFHRV9JU19XVCwgMCwgMCwgUEFHRV9JU19XVCk7CisJCWlmIChy
ZXQgPCAwKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciAlZCAlZCAlc1xuIiwgcmV0
LCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKworCQlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9
PSAxICYmIHZlY1swXS5sZW4gPT0gdmVjX3NpemUvMiwKKwkJCQkgIiVzIGNsZWFyIHNlY29u
ZCBoYWxmIGh1Z2UgcGFnZVxuIiwgX19mdW5jX18pOworCQl3cF9mcmVlKG1hcCwgbWFwX3Np
emUpOworCQlmcmVlKG1hcCk7CisJfSBlbHNlIHsKKwkJa3NmdF90ZXN0X3Jlc3VsdF9za2lw
KCJjbGVhciBzZWNvbmQgaGFsZiBodWdlIHBhZ2VcbiIpOworCX0KKworCWZyZWUodmVjKTsK
KwlmcmVlKHZlYzIpOworCXJldHVybiAwOworfQorCitpbnQgdW5tYXBwZWRfcmVnaW9uX3Rl
c3RzKHZvaWQpCit7CisJdm9pZCAqc3RhcnQgPSAodm9pZCAqKTB4MTAwMDAwMDA7CisJaW50
IGRpcnR5LCBsZW4gPSAweDAwMDQwMDAwOworCWludCB2ZWNfc2l6ZSA9IGxlbiAvIHBhZ2Vf
c2l6ZTsKKwlzdHJ1Y3QgcGFnZV9yZWdpb24gKnZlYyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0
IHBhZ2VfcmVnaW9uKSAqIHZlY19zaXplKTsKKworCS8qIDEuIEdldCBkaXJ0eSBwYWdlcyAq
LworCWRpcnR5ID0gcGFnZW1hcF9pb2N0bChzdGFydCwgbGVuLCB2ZWMsIHZlY19zaXplLCAw
LCAwLCBQQUdFTUFQX05PTl9XVF9NQVNLLCAwLCAwLAorCQkJICAgICAgUEFHRU1BUF9OT05f
V1RfTUFTSyk7CisJaWYgKGRpcnR5IDwgMCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJv
ciAlZCAlZCAlc1xuIiwgZGlydHksIGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJa3Nm
dF90ZXN0X3Jlc3VsdChkaXJ0eSA+PSAwLCAiJXMgR2V0IHN0YXR1cyBvZiBwYWdlc1xuIiwg
X19mdW5jX18pOworCisJZnJlZSh2ZWMpOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9p
ZCB0ZXN0X3NpbXBsZSh2b2lkKQoreworCWludCBpOworCWNoYXIgKm1hcDsKKwlzdHJ1Y3Qg
cGFnZV9yZWdpb24gdmVjOworCisJbWFwID0gYWxpZ25lZF9hbGxvYyhwYWdlX3NpemUsIHBh
Z2Vfc2l6ZSk7CisJaWYgKCFtYXApCisJCWtzZnRfZXhpdF9mYWlsX21zZygiYWxpZ25lZF9h
bGxvYyBmYWlsZWRcbiIpOworCXdwX2luaXQobWFwLCBwYWdlX3NpemUpOworCisJY2xlYXJf
c29mdGRpcnR5X3dwKG1hcCwgcGFnZV9zaXplKTsKKworCWZvciAoaSA9IDAgOyBpIDwgVEVT
VF9JVEVSQVRJT05TOyBpKyspIHsKKwkJaWYgKHBhZ2VtYXBfaW9jdGwobWFwLCBwYWdlX3Np
emUsICZ2ZWMsIDEsIDAsIDAsCisJCQkJICBQQUdFX0lTX1dULCAwLCAwLCBQQUdFX0lTX1dU
KSA9PSAxKSB7CisJCQlrc2Z0X3ByaW50X21zZygiZGlydHkgYml0IHdhcyAxLCBidXQgc2hv
dWxkIGJlIDAgKGk9JWQpXG4iLCBpKTsKKwkJCWJyZWFrOworCQl9CisKKwkJY2xlYXJfc29m
dGRpcnR5X3dwKG1hcCwgcGFnZV9zaXplKTsKKwkJLyogV3JpdGUgc29tZXRoaW5nIHRvIHRo
ZSBwYWdlIHRvIGdldCB0aGUgZGlydHkgYml0IGVuYWJsZWQgb24gdGhlIHBhZ2UgKi8KKwkJ
bWFwWzBdKys7CisKKwkJaWYgKHBhZ2VtYXBfaW9jdGwobWFwLCBwYWdlX3NpemUsICZ2ZWMs
IDEsIDAsIDAsCisJCQkJICBQQUdFX0lTX1dULCAwLCAwLCBQQUdFX0lTX1dUKSA9PSAwKSB7
CisJCQlrc2Z0X3ByaW50X21zZygiZGlydHkgYml0IHdhcyAwLCBidXQgc2hvdWxkIGJlIDEg
KGk9JWQpXG4iLCBpKTsKKwkJCWJyZWFrOworCQl9CisKKwkJY2xlYXJfc29mdGRpcnR5X3dw
KG1hcCwgcGFnZV9zaXplKTsKKwl9CisJd3BfZnJlZShtYXAsIHBhZ2Vfc2l6ZSk7CisJZnJl
ZShtYXApOworCisJa3NmdF90ZXN0X3Jlc3VsdChpID09IFRFU1RfSVRFUkFUSU9OUywgIlRl
c3QgJXNcbiIsIF9fZnVuY19fKTsKK30KKworaW50IHNhbml0eV90ZXN0cyh2b2lkKQorewor
CWNoYXIgKm1lbSwgKmZtZW07CisJaW50IG1lbV9zaXplLCB2ZWNfc2l6ZSwgcmV0OworCXN0
cnVjdCBwYWdlX3JlZ2lvbiAqdmVjOworCisJLyogMS4gd3Jvbmcgb3BlcmF0aW9uICovCisJ
bWVtX3NpemUgPSAxMCAqIHBhZ2Vfc2l6ZTsKKwl2ZWNfc2l6ZSA9IG1lbV9zaXplIC8gcGFn
ZV9zaXplOworCisJdmVjID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pICog
dmVjX3NpemUpOworCW1lbSA9IG1tYXAoTlVMTCwgbWVtX3NpemUsIFBST1RfUkVBRCB8IFBS
T1RfV1JJVEUsIE1BUF9QUklWQVRFIHwgTUFQX0FOT04sIC0xLCAwKTsKKwlpZiAobWVtID09
IE1BUF9GQUlMRUQgfHwgdmVjID09IE1BUF9GQUlMRUQpCisJCWtzZnRfZXhpdF9mYWlsX21z
ZygiZXJyb3Igbm9tZW1cbiIpOworCisJd3BfaW5pdChtZW0sIG1lbV9zaXplKTsKKworCWtz
ZnRfdGVzdF9yZXN1bHQocGFnZW1hcF9pb2N0bChtZW0sIG1lbV9zaXplLCB2ZWMsIHZlY19z
aXplLCBQQUdFTUFQX1dQX0VOR0FHRSwgMCwKKwkJCQkgICAgICAgUEFHRU1BUF9PUF9NQVNL
LCAwLCAwLCBQQUdFTUFQX09QX01BU0spIDwgMCwKKwkJCSAiJXMgY2xlYXIgb3AgY2FuIG9u
bHkgYmUgc3BlY2lmaWVkIHdpdGggUEFHRV9JU19XVFxuIiwgX19mdW5jX18pOworCWtzZnRf
dGVzdF9yZXN1bHQocGFnZW1hcF9pb2N0bChtZW0sIG1lbV9zaXplLCB2ZWMsIHZlY19zaXpl
LCAwLCAwLAorCQkJCSAgICAgICBQQUdFTUFQX09QX01BU0ssIDAsIDAsIFBBR0VNQVBfT1Bf
TUFTSykgPj0gMCwKKwkJCSAiJXMgcmVxdWlyZWRfbWFzayBzcGVjaWZpZWRcbiIsIF9fZnVu
Y19fKTsKKwlrc2Z0X3Rlc3RfcmVzdWx0KHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwg
dmVjLCB2ZWNfc2l6ZSwgMCwgMCwKKwkJCQkgICAgICAgMCwgUEFHRU1BUF9PUF9NQVNLLCAw
LCBQQUdFTUFQX09QX01BU0spID49IDAsCisJCQkgIiVzIGFueW9mX21hc2sgc3BlY2lmaWVk
XG4iLCBfX2Z1bmNfXyk7CisJa3NmdF90ZXN0X3Jlc3VsdChwYWdlbWFwX2lvY3RsKG1lbSwg
bWVtX3NpemUsIHZlYywgdmVjX3NpemUsIDAsIDAsCisJCQkJICAgICAgIDAsIDAsIFBBR0VN
QVBfT1BfTUFTSywgUEFHRU1BUF9PUF9NQVNLKSA+PSAwLAorCQkJICIlcyBleGNsdWRlZF9t
YXNrIHNwZWNpZmllZFxuIiwgX19mdW5jX18pOworCWtzZnRfdGVzdF9yZXN1bHQocGFnZW1h
cF9pb2N0bChtZW0sIG1lbV9zaXplLCB2ZWMsIHZlY19zaXplLCAwLCAwLAorCQkJCSAgICAg
ICBQQUdFTUFQX09QX01BU0ssIFBBR0VNQVBfT1BfTUFTSywgMCwgUEFHRU1BUF9PUF9NQVNL
KSA+PSAwLAorCQkJICIlcyByZXF1aXJlZF9tYXNrIGFuZCBhbnlvZl9tYXNrIHNwZWNpZmll
ZFxuIiwgX19mdW5jX18pOworCXdwX2ZyZWUobWVtLCBtZW1fc2l6ZSk7CisJbXVubWFwKG1l
bSwgbWVtX3NpemUpOworCisJLyogMi4gR2V0IHNkIGFuZCBwcmVzZW50IHBhZ2VzIHdpdGgg
YW55b2ZfbWFzayAqLworCW1lbSA9IG1tYXAoTlVMTCwgbWVtX3NpemUsIFBST1RfUkVBRCB8
IFBST1RfV1JJVEUsIE1BUF9QUklWQVRFIHwgTUFQX0FOT04sIC0xLCAwKTsKKwlpZiAobWVt
ID09IE1BUF9GQUlMRUQpCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3Igbm9tZW1cbiIp
OworCXdwX2luaXQobWVtLCBtZW1fc2l6ZSk7CisKKwltZW1zZXQobWVtLCAwLCBtZW1fc2l6
ZSk7CisKKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywgdmVjX3Np
emUsIDAsIDAsCisJCQkgICAgMCwgUEFHRU1BUF9PUF9NQVNLLCAwLCBQQUdFTUFQX09QX01B
U0spOworCWtzZnRfdGVzdF9yZXN1bHQocmV0ID49IDAgJiYgdmVjWzBdLnN0YXJ0ID09ICh1
aW50cHRyX3QpbWVtICYmIHZlY1swXS5sZW4gPT0gdmVjX3NpemUgJiYKKwkJCSB2ZWNbMF0u
Yml0bWFwID09IChQQUdFX0lTX1dUIHwgUEFHRV9JU19QUkVTRU5UKSwKKwkJCSAiJXMgR2V0
IHNkIGFuZCBwcmVzZW50IHBhZ2VzIHdpdGggYW55b2ZfbWFza1xuIiwgX19mdW5jX18pOwor
CisJLyogMy4gR2V0IHNkIGFuZCBwcmVzZW50IHBhZ2VzIHdpdGggcmVxdWlyZWRfbWFzayAq
LworCXJldCA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwgdmVjLCB2ZWNfc2l6ZSwg
MCwgMCwKKwkJCSAgICBQQUdFTUFQX09QX01BU0ssIDAsIDAsIFBBR0VNQVBfT1BfTUFTSyk7
CisJa3NmdF90ZXN0X3Jlc3VsdChyZXQgPj0gMCAmJiB2ZWNbMF0uc3RhcnQgPT0gKHVpbnRw
dHJfdCltZW0gJiYgdmVjWzBdLmxlbiA9PSB2ZWNfc2l6ZSAmJgorCQkJIHZlY1swXS5iaXRt
YXAgPT0gKFBBR0VfSVNfV1QgfCBQQUdFX0lTX1BSRVNFTlQpLAorCQkJICIlcyBHZXQgYWxs
IHRoZSBwYWdlcyB3aXRoIHJlcXVpcmVkX21hc2tcbiIsIF9fZnVuY19fKTsKKworCS8qIDQu
IEdldCBzZCBhbmQgcHJlc2VudCBwYWdlcyB3aXRoIHJlcXVpcmVkX21hc2sgYW5kIGFueW9m
X21hc2sgKi8KKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywgdmVj
X3NpemUsIDAsIDAsCisJCQkgICAgUEFHRV9JU19XVCwgUEFHRV9JU19QUkVTRU5ULCAwLCBQ
QUdFTUFQX09QX01BU0spOworCWtzZnRfdGVzdF9yZXN1bHQocmV0ID49IDAgJiYgdmVjWzBd
LnN0YXJ0ID09ICh1aW50cHRyX3QpbWVtICYmIHZlY1swXS5sZW4gPT0gdmVjX3NpemUgJiYK
KwkJCSB2ZWNbMF0uYml0bWFwID09IChQQUdFX0lTX1dUIHwgUEFHRV9JU19QUkVTRU5UKSwK
KwkJCSAiJXMgR2V0IHNkIGFuZCBwcmVzZW50IHBhZ2VzIHdpdGggcmVxdWlyZWRfbWFzayBh
bmQgYW55b2ZfbWFza1xuIiwKKwkJCSBfX2Z1bmNfXyk7CisKKwkvKiA1LiBEb24ndCBnZXQg
c2QgcGFnZXMgKi8KKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1lbSwgbWVtX3NpemUsIHZlYywg
dmVjX3NpemUsIDAsIDAsCisJCQkgICAgMCwgMCwgUEFHRV9JU19XVCwgUEFHRU1BUF9PUF9N
QVNLKTsKKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9PSAwLCAiJXMgRG9uJ3QgZ2V0IHNkIHBh
Z2VzXG4iLCBfX2Z1bmNfXyk7CisKKwkvKiA2LiBEb24ndCBnZXQgcHJlc2VudCBwYWdlcyAq
LworCXJldCA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwgdmVjLCB2ZWNfc2l6ZSwg
MCwgMCwKKwkJCSAgICAwLCAwLCBQQUdFX0lTX1BSRVNFTlQsIFBBR0VNQVBfT1BfTUFTSyk7
CisJa3NmdF90ZXN0X3Jlc3VsdChyZXQgPT0gMCwgIiVzIERvbid0IGdldCBwcmVzZW50IHBh
Z2VzXG4iLCBfX2Z1bmNfXyk7CisKKwl3cF9mcmVlKG1lbSwgbWVtX3NpemUpOworCW11bm1h
cChtZW0sIG1lbV9zaXplKTsKKworCS8qIDguIEZpbmQgZGlydHkgcHJlc2VudCBwYWdlcyB3
aXRoIHJldHVybiBtYXNrICovCisJbWVtID0gbW1hcChOVUxMLCBtZW1fc2l6ZSwgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTiwgLTEsIDApOworCWlm
IChtZW0gPT0gTUFQX0ZBSUxFRCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciBub21l
bVxuIik7CisJd3BfaW5pdChtZW0sIG1lbV9zaXplKTsKKworCW1lbXNldChtZW0sIDAsIG1l
bV9zaXplKTsKKworCXJldCA9IHBhZ2VtYXBfaW9jdGwobWVtLCBtZW1fc2l6ZSwgdmVjLCB2
ZWNfc2l6ZSwgMCwgMCwKKwkJCSAgICAwLCBQQUdFTUFQX09QX01BU0ssIDAsIFBBR0VfSVNf
V1QpOworCWtzZnRfdGVzdF9yZXN1bHQocmV0ID49IDAgJiYgdmVjWzBdLnN0YXJ0ID09ICh1
aW50cHRyX3QpbWVtICYmIHZlY1swXS5sZW4gPT0gdmVjX3NpemUgJiYKKwkJCSB2ZWNbMF0u
Yml0bWFwID09IFBBR0VfSVNfV1QsCisJCQkgIiVzIEZpbmQgZGlydHkgcHJlc2VudCBwYWdl
cyB3aXRoIHJldHVybiBtYXNrXG4iLCBfX2Z1bmNfXyk7CisJd3BfZnJlZShtZW0sIG1lbV9z
aXplKTsKKwltdW5tYXAobWVtLCBtZW1fc2l6ZSk7CisKKwkvKiA5LiBNZW1vcnkgbWFwcGVk
IGZpbGUgKi8KKwlpbnQgZmQ7CisJc3RydWN0IHN0YXQgc2J1ZjsKKworCWZkID0gb3Blbihf
X0ZJTEVfXywgT19SRE9OTFkpOworCWlmIChmZCA8IDApIHsKKwkJa3NmdF90ZXN0X3Jlc3Vs
dF9za2lwKCIlcyBNZW1vcnkgbWFwcGVkIGZpbGVcbiIpOworCQlnb3RvIGZyZWVfdmVjX2Fu
ZF9yZXR1cm47CisJfQorCisJcmV0ID0gc3RhdChfX0ZJTEVfXywgJnNidWYpOworCWlmIChy
ZXQgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4iLCByZXQs
IGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJZm1lbSA9IG1tYXAoTlVMTCwgc2J1Zi5z
dF9zaXplLCBQUk9UX1JFQUQsIE1BUF9TSEFSRUQsIGZkLCAwKTsKKwlpZiAoZm1lbSA9PSBN
QVBfRkFJTEVEKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yIG5vbWVtXG4iKTsKKwor
CXJldCA9IHBhZ2VtYXBfaW9jdGwoZm1lbSwgc2J1Zi5zdF9zaXplLCB2ZWMsIHZlY19zaXpl
LCAwLCAwLAorCQkJICAgIDAsIFBBR0VNQVBfTk9OX1dUX01BU0ssIDAsIFBBR0VNQVBfTk9O
X1dUX01BU0spOworCisJa3NmdF90ZXN0X3Jlc3VsdChyZXQgPj0gMCAmJiB2ZWNbMF0uc3Rh
cnQgPT0gKHVpbnRwdHJfdClmbWVtICYmCisJCQkgdmVjWzBdLmxlbiA9PSBjZWlsZigoZmxv
YXQpc2J1Zi5zdF9zaXplL3BhZ2Vfc2l6ZSkgJiYKKwkJCSB2ZWNbMF0uYml0bWFwID09IFBB
R0VfSVNfRklMRSwKKwkJCSAiJXMgTWVtb3J5IG1hcHBlZCBmaWxlXG4iLCBfX2Z1bmNfXyk7
CisKKwltdW5tYXAoZm1lbSwgc2J1Zi5zdF9zaXplKTsKKwljbG9zZShmZCk7CisKK2ZyZWVf
dmVjX2FuZF9yZXR1cm46CisJZnJlZSh2ZWMpOworCXJldHVybiAwOworfQorCitpbnQgbXBy
b3RlY3RfdGVzdHModm9pZCkKK3sKKwlpbnQgcmV0OworCWNoYXIgKm1lbSwgKm1lbTI7CisJ
c3RydWN0IHBhZ2VfcmVnaW9uIHZlYzsKKwlpbnQgcGFnZW1hcF9mZCA9IG9wZW4oIi9wcm9j
L3NlbGYvcGFnZW1hcCIsIE9fUkRPTkxZKTsKKworCWlmIChwYWdlbWFwX2ZkIDwgMCkgewor
CQlmcHJpbnRmKHN0ZGVyciwgIm9wZW4oKSBmYWlsZWRcbiIpOworCQlleGl0KDEpOworCX0K
KworCS8qIDEuIE1hcCB0d28gcGFnZXMgKi8KKwltZW0gPSBtbWFwKDAsIDIgKiBwYWdlX3Np
emUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURSB8IE1BUF9BTk9OLCAtMSwg
MCk7CisJaWYgKG1lbSA9PSBNQVBfRkFJTEVEKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVy
cm9yIG5vbWVtXG4iKTsKKwl3cF9pbml0KG1lbSwgMiAqIHBhZ2Vfc2l6ZSk7CisKKwkvKiBQ
b3B1bGF0ZSBib3RoIHBhZ2VzLiAqLworCW1lbXNldChtZW0sIDEsIDIgKiBwYWdlX3NpemUp
OworCisJcmV0ID0gcGFnZW1hcF9pb2N0bChtZW0sIDIgKiBwYWdlX3NpemUsICZ2ZWMsIDEs
IDAsIDAsIFBBR0VfSVNfV1QsCisJCQkgICAgMCwgMCwgUEFHRV9JU19XVCk7CisJaWYgKHJl
dCA8IDApCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQgJWQgJXNcbiIsIHJldCwg
ZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9PSAx
ICYmIHZlYy5sZW4gPT0gMiwgIiVzIEJvdGggcGFnZXMgZGlydHlcbiIsIF9fZnVuY19fKTsK
KworCS8qIDIuIFN0YXJ0IHNvZnRkaXJ0eSB0cmFja2luZy4gQ2xlYXIgVk1fU09GVERJUlRZ
IGFuZCBjbGVhciB0aGUgc29mdGRpcnR5IFBURSBiaXQuICovCisJcmV0ID0gcGFnZW1hcF9p
b2N0bChtZW0sIDIgKiBwYWdlX3NpemUsIE5VTEwsIDAsIFBBR0VNQVBfV1BfRU5HQUdFLCAw
LAorCQkJICAgIDAsIDAsIDAsIDApOworCWlmIChyZXQgPCAwKQorCQlrc2Z0X2V4aXRfZmFp
bF9tc2coImVycm9yICVkICVkICVzXG4iLCByZXQsIGVycm5vLCBzdHJlcnJvcihlcnJubykp
OworCisJa3NmdF90ZXN0X3Jlc3VsdChwYWdlbWFwX2lvY3RsKG1lbSwgMiAqIHBhZ2Vfc2l6
ZSwgJnZlYywgMSwgMCwgMCwgUEFHRV9JU19XVCwKKwkJCSAwLCAwLCBQQUdFX0lTX1dUKSA9
PSAwLAorCQkJICIlcyBCb3RoIHBhZ2VzIGFyZSBub3Qgc29mdCBkaXJ0eVxuIiwgX19mdW5j
X18pOworCisJLyogMy4gUmVtYXAgdGhlIHNlY29uZCBwYWdlICovCisJbWVtMiA9IG1tYXAo
bWVtICsgcGFnZV9zaXplLCBwYWdlX3NpemUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAorCQkg
ICAgTUFQX1BSSVZBVEV8TUFQX0FOT058TUFQX0ZJWEVELCAtMSwgMCk7CisJaWYgKG1lbTIg
PT0gTUFQX0ZBSUxFRCkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJlcnJvciBub21lbVxuIik7
CisJd3BfaW5pdChtZW0yLCBwYWdlX3NpemUpOworCisJLyogUHJvdGVjdCArIHVucHJvdGVj
dC4gKi8KKwltcHJvdGVjdChtZW0sIDIgKiBwYWdlX3NpemUsIFBST1RfUkVBRCk7CisJbXBy
b3RlY3QobWVtLCAyICogcGFnZV9zaXplLCBQUk9UX1JFQUR8UFJPVF9XUklURSk7CisKKwkv
KiBNb2RpZnkgYm90aCBwYWdlcy4gKi8KKwltZW1zZXQobWVtLCAyLCAyICogcGFnZV9zaXpl
KTsKKworCXJldCA9IHBhZ2VtYXBfaW9jdGwobWVtLCAyICogcGFnZV9zaXplLCAmdmVjLCAx
LCAwLCAwLCBQQUdFX0lTX1dULAorCQkJICAgIDAsIDAsIFBBR0VfSVNfV1QpOworCWlmIChy
ZXQgPCAwKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yICVkICVkICVzXG4iLCByZXQs
IGVycm5vLCBzdHJlcnJvcihlcnJubykpOworCisJa3NmdF90ZXN0X3Jlc3VsdChyZXQgPT0g
MSAmJiB2ZWMubGVuID09IDIsCisJCQkgIiVzIEJvdGggcGFnZXMgZGlydHkgYWZ0ZXIgcmVt
YXAgYW5kIG1wcm90ZWN0XG4iLCBfX2Z1bmNfXyk7CisKKwkvKiA0LiBDbGVhciBhbmQgbWFr
ZSB0aGUgcGFnZXMgZGlydHkgKi8KKwlyZXQgPSBwYWdlbWFwX2lvY3RsKG1lbSwgMiAqIHBh
Z2Vfc2l6ZSwgTlVMTCwgMCwgUEFHRU1BUF9XUF9FTkdBR0UsIDAsCisJCQkgICAgMCwgMCwg
MCwgMCk7CisJaWYgKHJldCA8IDApCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3IgJWQg
JWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwltZW1zZXQobWVt
LCAnQScsIDIgKiBwYWdlX3NpemUpOworCisJcmV0ID0gcGFnZW1hcF9pb2N0bChtZW0sIDIg
KiBwYWdlX3NpemUsICZ2ZWMsIDEsIDAsIDAsIFBBR0VfSVNfV1QsCisJCQkgICAgMCwgMCwg
UEFHRV9JU19XVCk7CisJaWYgKHJldCA8IDApCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJy
b3IgJWQgJWQgJXNcbiIsIHJldCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CisKKwlrc2Z0
X3Rlc3RfcmVzdWx0KHJldCA9PSAxICYmIHZlYy5sZW4gPT0gMiwKKwkJCSAiJXMgQ2xlYXIg
YW5kIG1ha2UgdGhlIHBhZ2VzIGRpcnR5XG4iLCBfX2Z1bmNfXyk7CisKKwl3cF9mcmVlKG1l
bSwgMiAqIHBhZ2Vfc2l6ZSk7CisJbXVubWFwKG1lbSwgMiAqIHBhZ2Vfc2l6ZSk7CisJcmV0
dXJuIDA7Cit9CisKK2ludCBtYWluKHZvaWQpCit7CisJY2hhciAqbWVtLCAqbWFwOworCWlu
dCBtZW1fc2l6ZTsKKworCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisJa3NmdF9zZXRfcGxhbig1
NCk7CisKKwlwYWdlX3NpemUgPSBnZXRwYWdlc2l6ZSgpOworCWhwYWdlX3NpemUgPSByZWFk
X3BtZF9wYWdlc2l6ZSgpOworCisJcGFnZW1hcF9mZCA9IG9wZW4oUEFHRU1BUCwgT19SRFdS
KTsKKwlpZiAocGFnZW1hcF9mZCA8IDApCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKGlu
aXRfdWZmZCgpKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coInVmZmQgaW5pdCBmYWlsZWRcbiIp
OworCisJLyoKKwkgKiBTb2Z0LWRpcnR5IFBURSBiaXQgdGVzdHMKKwkgKi8KKworCS8qIDEu
IFNhbml0eSB0ZXN0aW5nICovCisJc2FuaXR5X3Rlc3RzX3NkKCk7CisKKwkvKiAyLiBOb3Jt
YWwgcGFnZSB0ZXN0aW5nICovCisJbWVtX3NpemUgPSAxMCAqIHBhZ2Vfc2l6ZTsKKwltZW0g
PSBtbWFwKE5VTEwsIG1lbV9zaXplLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBfUFJJ
VkFURSB8IE1BUF9BTk9OLCAtMSwgMCk7CisJaWYgKG1lbSA9PSBNQVBfRkFJTEVEKQorCQlr
c2Z0X2V4aXRfZmFpbF9tc2coImVycm9yIG5vbWVtXG4iKTsKKwl3cF9pbml0KG1lbSwgbWVt
X3NpemUpOworCisJYmFzZV90ZXN0cygiUGFnZSB0ZXN0aW5nOiIsIG1lbSwgbWVtX3NpemUs
IDApOworCisJd3BfZnJlZShtZW0sIG1lbV9zaXplKTsKKwltdW5tYXAobWVtLCBtZW1fc2l6
ZSk7CisKKwkvKiAzLiBMYXJnZSBwYWdlIHRlc3RpbmcgKi8KKwltZW1fc2l6ZSA9IDUxMiAq
IDEwICogcGFnZV9zaXplOworCW1lbSA9IG1tYXAoTlVMTCwgbWVtX3NpemUsIFBST1RfUkVB
RCB8IFBST1RfV1JJVEUsIE1BUF9QUklWQVRFIHwgTUFQX0FOT04sIC0xLCAwKTsKKwlpZiAo
bWVtID09IE1BUF9GQUlMRUQpCisJCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3Igbm9tZW1c
biIpOworCXdwX2luaXQobWVtLCBtZW1fc2l6ZSk7CisKKwliYXNlX3Rlc3RzKCJMYXJnZSBQ
YWdlIHRlc3Rpbmc6IiwgbWVtLCBtZW1fc2l6ZSwgMCk7CisKKwl3cF9mcmVlKG1lbSwgbWVt
X3NpemUpOworCW11bm1hcChtZW0sIG1lbV9zaXplKTsKKworCS8qIDQuIEh1Z2UgcGFnZSB0
ZXN0aW5nICovCisJbWFwID0gZ2V0aHVnZXBhZ2UoaHBhZ2Vfc2l6ZSk7CisJaWYgKG1hcCkg
eworCQliYXNlX3Rlc3RzKCJIdWdlIHBhZ2UgdGVzdGluZzoiLCBtYXAsIGhwYWdlX3NpemUs
IDApOworCQl3cF9mcmVlKG1hcCwgaHBhZ2Vfc2l6ZSk7CisJCWZyZWUobWFwKTsKKwl9IGVs
c2UgeworCQliYXNlX3Rlc3RzKCJIdWdlIHBhZ2UgdGVzdGluZzoiLCBOVUxMLCAwLCAxKTsK
Kwl9CisKKwkvKiA2LiBIdWdlIHBhZ2UgdGVzdHMgKi8KKwlocGFnZV91bml0X3Rlc3RzKCk7
CisKKwkvKiA3LiBJdGVyYXRpdmUgdGVzdCAqLworCXRlc3Rfc2ltcGxlKCk7CisKKwkvKiA4
LiBNcHJvdGVjdCB0ZXN0ICovCisJbXByb3RlY3RfdGVzdHMoKTsKKworCS8qCisJICogT3Ro
ZXIgUFRFIGJpdCB0ZXN0cworCSAqLworCisJLyogMS4gU2FuaXR5IHRlc3RpbmcgKi8KKwlz
YW5pdHlfdGVzdHMoKTsKKworCS8qIDIuIFVubWFwcGVkIGFkZHJlc3MgdGVzdCAqLworCXVu
bWFwcGVkX3JlZ2lvbl90ZXN0cygpOworCisJY2xvc2UocGFnZW1hcF9mZCk7CisJcmV0dXJu
IGtzZnRfZXhpdF9wYXNzKCk7Cit9Ci0tIAoyLjMwLjIKCg==

--------------YDczPGnNMYCbOh0mtE2Xi30f--
