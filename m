Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71C70F53A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEXL0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEXL0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 07:26:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4AC5;
        Wed, 24 May 2023 04:26:46 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.155.11.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C76C66065B2;
        Wed, 24 May 2023 12:26:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684927604;
        bh=bsOSefExqp2/c6+fD3EPeGailLukclpEDfuw/qyv9Mc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=C37LmDvHf/ixRR83ev7ZgblwOtRzbPCN/V/meV/PPyCuEtHP66YPMzxizmbaain4r
         qNIaUNLzDBtWO9EUrgyjA51Ee9PPjE+pjxEuokcZIY5BEVSNF+Uhs+xr79LHie6o0P
         lYjCWigw/tZ9zhDwmd4dzu1h/QN6PBtKL/oc/P1shW5YK1zEii7kWTLoUZvUW4qAhJ
         0aGegVZwEngYL5YL2MNf8dE0ttH8aczhpFBQX7cV8/esStwgAWuO6gmyI7OVO9eRao
         SkAVUP+VbwkU/VM5HrEQE4cB14CLsFWD3C4L4URjME6uN2tWJme9oxLA/H5YfIW3Gc
         ebrP08TPRxFeQ==
Content-Type: multipart/mixed; boundary="------------Xz97V200tO7rQELjn6uPUVb0"
Message-ID: <a2615158-a0a6-9c2f-b04a-964dfa932aec@collabora.com>
Date:   Wed, 24 May 2023 16:26:33 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-mm@kvack.org, Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com> <ZEkxh6dbnAOuYuJj@x1n>
 <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
 <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com> <ZG0XUZSBI2I3/3bY@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZG0XUZSBI2I3/3bY@x1n>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Xz97V200tO7rQELjn6uPUVb0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/23 12:43 AM, Peter Xu wrote:
> Hi, Muhammad,
> 
> On Mon, May 22, 2023 at 04:26:07PM +0500, Muhammad Usama Anjum wrote:
>> On 5/22/23 3:24 PM, Muhammad Usama Anjum wrote:
>>> On 4/26/23 7:13 PM, Peter Xu wrote:
>>>> Hi, Muhammad,
>>>>
>>>> On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
>>>>> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
>>>>>> +/* Supported flags */
>>>>>> +#define PM_SCAN_OP_GET	(1 << 0)
>>>>>> +#define PM_SCAN_OP_WP	(1 << 1)
>>>>> We have only these flag options available in PAGEMAP_SCAN IOCTL.
>>>>> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
>>>>> be specified as need. But PM_SCAN_OP_WP cannot be specified without
>>>>> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
>>>>> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
>>>>>
>>>>> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
>>>>> vs
>>>>> 2) UFFDIO_WRITEPROTECT
>>>>>
>>>>> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
>>>>> getting really good performance which is comparable just like we are
>>>>> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
>>>>> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
>>>>> performance and behavior wise.
>>>>>
>>>>> I've got the results from someone else that UFFDIO_WRITEPROTECT block
>>>>> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
>>>>> as I don't have tests comparing them one-to-one.
>>>>>
>>>>> What are your thoughts about it? Have you thought about making
>>>>> UFFDIO_WRITEPROTECT perform better?
>>>>>
>>>>> I'm sorry to mention the word "performance" here. Actually we want better
>>>>> performance to emulate Windows syscall. That is why we are adding this
>>>>> functionality. So either we need to see what can be improved in
>>>>> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
>>>>> pagemap_ioctl?
>>>>
>>>> I'm fine if you want to add it back if it works for you.  Though before
>>>> that, could you remind me why there can be a difference on performance?
>>> I've looked at the code again and I think I've found something. Lets look
>>> at exact performance numbers:
>>>
>>> I've run 2 different tests. In first test UFFDIO_WRITEPROTECT is being used
>>> for engaging WP. In second test PM_SCAN_OP_WP is being used. I've measured
>>> the average write time to the same memory which is being WP-ed and total
>>> time of execution of these APIs:
> 
> What is the steps of the test?  Is it as simple as "writeprotect",
> "unprotect", then write all pages in a single thread?
> 
> Is UFFDIO_WRITEPROTECT sent in one range covering all pages?
> 
> Maybe you can attach the test program here too.

I'd not attached the test earlier as I thought that you wouldn't be
interested in running the test. I've attached it now. The test has multiple
threads where one thread tries to get status of flags and reset them, while
other threads write to that memory. In main(), we call the pagemap_scan
ioctl to get status of flags and reset the memory area as well. While in N
threads, the memory is written.

I usually run the test by following where memory area is of 100000 * pages:
./win2_linux 8 100000 1 1 0

I'm running tests on real hardware. The results are pretty consistent. I'm
also testing only on x86_64. PM_SCAN_OP_WP wins every time as compared to
UFFDIO_WRITEPROTECT.

The PM_SCAN_OP_WP op doesn't work exclusively on v15. So please find the
updated WIP code here:
https://gitlab.collabora.com/usama.anjum/linux-mainline/-/commits/memwatchv16/

> 
>>>
>>> **avg write time:**
>>> | No of pages            | 2000 | 8192 | 100000 | 500000 |
>>> |------------------------|------|------|--------|--------|
>>> | UFFDIO_WRITEPROTECT    | 2200 | 2300 | 4100   | 4200   |
>>> | PM_SCAN_OP_WP          | 2000 | 2300 | 2500   | 2800   |
>>>
>>> **Execution time measured in rdtsc:**
>>> | No of pages            | 2000 | 8192  | 100000 | 500000 |
>>> |------------------------|------|-------|--------|--------|
>>> | UFFDIO_WRITEPROTECT    | 3200 | 14000 | 59000  | 58000  |
>>> | PM_SCAN_OP_WP          | 1900 | 7000  | 38000  | 40000  |
>>>
>>> Avg write time for UFFDIO_WRITEPROTECT is 1.3 times slow. The execution
>>> time is 1.5 times slower in the case of UFFDIO_WRITEPROTECT. So
>>> UFFDIO_WRITEPROTECT is making writes slower to the pages and execution time
>>> is also slower.
>>>
>>> This proves that PM_SCAN_OP_WP is better than UFFDIO_WRITEPROTECT. Although
>>> PM_SCAN_OP_WP and UFFDIO_WRITEPROTECT have been implemented differently. We
>>> should have seen no difference in performance. But we have quite a lot of
>>> difference in performance here. PM_SCAN_OP_WP takes read mm lock, uses
>>> walk_page_range() to walk over pages which finds VMAs from address ranges
>>> to walk over them and pagemap_scan_pmd_entry() is handling most of the work
>>> including tlb flushing. UFFDIO_WRITEPROTECT is also taking the mm lock and
>>> iterating from all the different page directories until a pte is found and
>>> then flags are updated there and tlb is flushed for every pte.
>>>
>>> My next deduction would be that we are getting worse performance as we are
>>> flushing tlb for one page at a time in case of UFFDIO_WRITEPROTECT. While
>>> we flush tlb for 512 pages (moslty) at a time in case of PM_SCAN_OP_WP.
>>> I've just verified this by adding some logs to the change_pte_range() and
>>> pagemap_scan_pmd_entry(). Logs are attached. I've allocated memory of 1000
>>> pages and write-protected it with UFFDIO_WRITEPROTECT and PM_SCAN_OP_WP.
>>> The logs show that UFFDIO_WRITEPROTECT has flushed tlb 1000 times of size 1
>>> page each time. While PM_SCAN_OP_WP has flushed only 3 times of bigger
>>> sizes. I've learned over my last experience that tlb flush is very
>>> expensive. Probably this is what we need to improve if we don't want to add
>>> PM_SCAN_OP_WP?
>>>
>>> The UFFDIO_WRITEPROTECT uses change_pte_range() which is very generic
>>> function and I'm not sure if can try to not do tlb flushes if uffd_wp is
>>> true. We can try to do flush somewhere else and hopefully we should do only
>>> one flush if possible. It will not be so straight forward to move away from
>>> generic fundtion. Thoughts?
>> I've just tested this theory of not doing per pte flushes and only did one
>> flush on entire range in uffd_wp_range(). But it didn't improve the
>> situation either. I was wrong that tlb flushes may be the cause.
> 
> I had a feeling that you were trapping tlb_flush_pte_range(), which is
> actually not really sending any TLB flushes but updating mmu_gather object
> for the addr range for future invalidations.
> 
> That's probably why it didn't show an effect when you comment it out.
Yeah, probably.

> 
> I am not sure whether the wr-protect path difference can be caused by the
> arch hooks, namely arch_enter_lazy_mmu_mode() / arch_leave_lazy_mmu_mode().
> 
> On x86 I saw that it's actually hooked onto some PV calls.  I had a feeling
> that this is for optimization only, but maybe it's still a good idea you
> also take that into your new code:
> 
> static inline void arch_enter_lazy_mmu_mode(void)
> {
> 	PVOP_VCALL0(mmu.lazy_mode.enter);
> }
I've just looked into it. It isn't making any difference. But I think I
should include it in the code. It must be helpful for hypervisors etc.

> 
> The other thing is I think you're flushing tlb outside pgtable lock in your
> new code.  IIUC that's racy, see:
> 
> commit 6ce64428d62026a10cb5d80138ff2f90cc21d367
> Author: Nadav Amit <namit@vmware.com>
> Date:   Fri Mar 12 21:08:17 2021 -0800
> 
>     mm/userfaultfd: fix memory corruption due to writeprotect
> 
> So you may want to put it at least into pgtable lock critical section, or
> IIUC you can also do inc_tlb_flush_pending() then dec_tlb_flush_pending()
> just like __tlb_gather_mmu(), to make sure do_wp_page() will properly flush
> the page when unluckily hit some of the page.
Good point. I'll release page table lock after tlb flushing. I've just
added it to next WIP v16.

> 
> That's also the spot (the flush_tlb_page() in 6ce64428d) that made me think
> on whether it caused the slowness on writting to those pages.  But it
> really depends on your test program, e.g. if it's a single threaded I don't
> think it'll trigger because when writting mm_tlb_flush_pending() should
> start to return 0 already, so the tlb should logically not be needed.  If
> you want maybe you can double check that.
> 
> So in short, I had a feeling that the new PM_SCAN_OP_WP just misses
> something here and there so it's faster - it means even if it's faster it
> may also be prone to race conditions etc so we'd better figure it out..
The test program is multi-threaded. The performance number cannot be
reproduced with single-threaded application.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
--------------Xz97V200tO7rQELjn6uPUVb0
Content-Type: text/x-csrc; charset=UTF-8; name="win2_linux.c"
Content-Disposition: attachment; filename="win2_linux.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0ZGJv
b2wuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8
dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojZGVmaW5lIF9HTlVfU09VUkNFCiNk
ZWZpbmUgX09QRU5fVEhSRUFEUwojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUg
PHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8bGludXgvdXNlcmZhdWx0ZmQuaD4KI2luY2x1ZGUg
PHN5cy9pb2N0bC5oPgoKI2RlZmluZSBMT0coZm9ybWF0LCAuLi4pIHtwcmludGYoIiVseDol
czogIiBmb3JtYXQsIGdldHBpZCgpLCBfX2Z1bmNfXyBfX1ZBX09QVF9fKCwpX19WQV9BUkdT
X18pO30KCiNkZWZpbmUgTUFYX1RIUkVBRF9DT1VOVCA2NAoKI2RlZmluZSBQQUdFX1NJWkUg
MHgxMDAwCgojZGVmaW5lIFRFU1RfVElNRSAoMy4wICogMTAwMC4wKSAqIDEwCgpzdGF0aWMg
Ym9vbCBmaW5pc2g7CnN0YXRpYyBpbnQgbnRocmVhZHM7CgpzdGF0aWMgdm9sYXRpbGUgbG9u
ZyBsb25nIHJhd193cml0ZXNfY291bnQsIHdyaXRlc190aW1lOwpzdGF0aWMgY2hhciAqbWVt
OwoKc3RhdGljIGJvb2wgcmFuZG9tX2FjY2VzcywgcmVhZF9yZXNldDsKCiNpZiBkZWZpbmVk
KF9faTM4Nl9fKQoKc3RhdGljIF9faW5saW5lX18gdW5zaWduZWQgbG9uZyBsb25nIHJkdHNj
KHZvaWQpCnsKICAgIHVuc2lnbmVkIGxvbmcgbG9uZyBpbnQgeDsKICAgIF9fYXNtX18gdm9s
YXRpbGUgKCIuYnl0ZSAweDBmLCAweDMxIiA6ICI9QSIgKHgpKTsKICAgIHJldHVybiB4Owp9
CgojZWxpZiBkZWZpbmVkKF9feDg2XzY0X18pCgpzdGF0aWMgX19pbmxpbmVfXyB1bnNpZ25l
ZCBsb25nIGxvbmcgcmR0c2Modm9pZCkKewogICAgdW5zaWduZWQgaGksIGxvOwogICAgX19h
c21fXyBfX3ZvbGF0aWxlX18gKCJyZHRzYyIgOiAiPWEiKGxvKSwgIj1kIihoaSkpOwogICAg
cmV0dXJuICggKHVuc2lnbmVkIGxvbmcgbG9uZylsbyl8KCAoKHVuc2lnbmVkIGxvbmcgbG9u
ZyloaSk8PDMyICk7Cn0KCiNlbmRpZgoKc3RydWN0IHRocmVhZF9pbmZvCnsKICAgIHZvbGF0
aWxlIHZvaWQgKm1lbTsKICAgIHNpemVfdCBucGFnZXM7Cn07Cgp2b2lkICp0aHJlYWRfcHJv
Yyh2b2lkICpkYXRhKQp7CiAgICBzdHJ1Y3QgdGhyZWFkX2luZm8gKmluZm8gPSBkYXRhOwog
ICAgdm9sYXRpbGUgdW5zaWduZWQgY2hhciAqbSA9IGluZm8tPm1lbTsKICAgIHNpemVfdCBw
YWdlOwogICAgdW5zaWduZWQgbG9uZyBsb25nIHQxLCB0MjsKCiAgICBwYWdlID0gMDsKICAg
IHdoaWxlICghZmluaXNoKQogICAgewogICAgICAgIHQxID0gcmR0c2MoKTsKCiAgICAgICAg
aWYgKHJhbmRvbV9hY2Nlc3MpCiAgICAgICAgICAgIHBhZ2UgPSByYW5kKCkgJSBpbmZvLT5u
cGFnZXM7CiAgICAgICAgZWxzZQogICAgICAgICAgICBwYWdlID0gKHBhZ2UgKyAxKSAlIGlu
Zm8tPm5wYWdlczsKCiAgICAgICAgKysqKHZvbGF0aWxlIHVuc2lnbmVkIGludCAqKShtICsg
cGFnZSAqIFBBR0VfU0laRSk7CiAgICAgICAgX19hdG9taWNfYWRkX2ZldGNoICgmcmF3X3dy
aXRlc19jb3VudCwgMSwgX19BVE9NSUNfUkVMQVhFRCk7CiAgICAgICAgdDIgPSByZHRzYygp
OwogICAgICAgIF9fYXRvbWljX2FkZF9mZXRjaCAoJndyaXRlc190aW1lLCB0MiAtIHQxLCBf
X0FUT01JQ19SRUxBWEVEKTsKICAgIH0KCiAgICByZXR1cm4gMDsKfQoKZG91YmxlIGN1cnJf
dGltZV9tcyh2b2lkKQp7CiAgICBzdHJ1Y3QgdGltZXNwZWMgY3VycmVudF90aW1lOwoKICAg
IGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmY3VycmVudF90aW1lKTsKICAgIHJl
dHVybiBjdXJyZW50X3RpbWUudHZfc2VjICogMTAwMCArCiAgICAgICAgICAgY3VycmVudF90
aW1lLnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgZG91YmxlIHJkdHNjX2M7CgoKLy9z
dGF0aWMgZG91YmxlIGlubGluZSBtY3NfZnJvbV9yZHRzY19hdmcodm9pZCAqdHNjLCB1bnNp
Z25lZCBsb25nIGxvbmcgY291bnQpCi8vewovLyAgICByZXR1cm4gKHVuc2lnbmVkIGludCl0
c2MgKiByZHRzY19jIC8gY291bnQ7Ci8vfQoKLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8v
Ly8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8v
Ly8vLy8vLy8vLy8vLy8vCiNkZWZpbmUgVUZGRF9GRUFUVVJFX1dQX1VOUE9QVUxBVEVECQko
MTw8MTMpCiNkZWZpbmUgVUZGRF9GRUFUVVJFX1dQX0FTWU5DCQkJKDE8PDE0KQoKI2lmbmRl
ZiBQQUdFTUFQX1NDQU4KLyogQml0cyBhcmUgc2V0IGluIHRoZSBiaXRtYXAgb2YgdGhlIHBh
Z2VfcmVnaW9uIGFuZCBtYXNrcyBpbiBwYWdlbWFwX3NjYW5fYXJncyAqLwojZGVmaW5lIFBB
R0VfSVNfV1JJVFRFTgkJKDEgPDwgMCkKI2RlZmluZSBQQUdFX0lTX0ZJTEUJCSgxIDw8IDEp
CiNkZWZpbmUgUEFHRV9JU19QUkVTRU5UCQkoMSA8PCAyKQojZGVmaW5lIFBBR0VfSVNfU1dB
UFBFRAkJKDEgPDwgMykKCi8qCiAqIHN0cnVjdCBwYWdlX3JlZ2lvbiAtIFBhZ2UgcmVnaW9u
IHdpdGggYml0bWFwIGZsYWdzCiAqIEBzdGFydDoJU3RhcnQgb2YgdGhlIHJlZ2lvbgogKiBA
bGVuOglMZW5ndGggb2YgdGhlIHJlZ2lvbgogKiBiaXRtYXA6CUJpdHMgc2V0cyBmb3IgdGhl
IHJlZ2lvbgogKi8Kc3RydWN0IHBhZ2VfcmVnaW9uIHsKCXVuc2lnbmVkIGxvbmcgbG9uZyBz
dGFydDsKCXVuc2lnbmVkIGxvbmcgbG9uZyBsZW47Cgl1bnNpZ25lZCBsb25nIGxvbmcgYml0
bWFwOwp9OwoKLyoKICogc3RydWN0IHBtX3NjYW5fYXJnIC0gUGFnZW1hcCBpb2N0bCBhcmd1
bWVudAogKiBAc2l6ZToJCVNpemUgb2YgdGhlIHN0cnVjdHVyZQogKiBAZmxhZ3M6CQlGbGFn
cyBmb3IgdGhlIElPQ1RMCiAqIEBzdGFydDoJCVN0YXJ0aW5nIGFkZHJlc3Mgb2YgdGhlIHJl
Z2lvbgogKiBAbGVuOgkJTGVuZ3RoIG9mIHRoZSByZWdpb24gKEFsbCB0aGUgcGFnZXMgaW4g
dGhpcyBsZW5ndGggYXJlIGluY2x1ZGVkKQogKiBAdmVjOgkJQWRkcmVzcyBvZiBwYWdlX3Jl
Z2lvbiBzdHJ1Y3QgYXJyYXkgZm9yIG91dHB1dAogKiBAdmVjX2xlbjoJCUxlbmd0aCBvZiB0
aGUgcGFnZV9yZWdpb24gc3RydWN0IGFycmF5CiAqIEBtYXhfcGFnZXM6CQlPcHRpb25hbCBt
YXggcmV0dXJuIHBhZ2VzCiAqIEByZXF1aXJlZF9tYXNrOglSZXF1aXJlZCBtYXNrIC0gQWxs
IG9mIHRoZXNlIGJpdHMgaGF2ZSB0byBiZSBzZXQgaW4gdGhlIFBURQogKiBAYW55b2ZfbWFz
azoJCUFueSBtYXNrIC0gQW55IG9mIHRoZXNlIGJpdHMgYXJlIHNldCBpbiB0aGUgUFRFCiAq
IEBleGNsdWRlZF9tYXNrOglFeGNsdWRlIG1hc2sgLSBOb25lIG9mIHRoZXNlIGJpdHMgYXJl
IHNldCBpbiB0aGUgUFRFCiAqIEByZXR1cm5fbWFzazoJQml0cyB0aGF0IGFyZSB0byBiZSBy
ZXBvcnRlZCBpbiBwYWdlX3JlZ2lvbgogKi8Kc3RydWN0IHBtX3NjYW5fYXJnIHsKCXVuc2ln
bmVkIGxvbmcgbG9uZyBzaXplOwoJdW5zaWduZWQgbG9uZyBsb25nIGZsYWdzOwoJdW5zaWdu
ZWQgbG9uZyBsb25nIHN0YXJ0OwoJdW5zaWduZWQgbG9uZyBsb25nIGxlbjsKCXVuc2lnbmVk
IGxvbmcgbG9uZyB2ZWM7Cgl1bnNpZ25lZCBsb25nIGxvbmcgdmVjX2xlbjsKCXVuc2lnbmVk
IGxvbmcgbG9uZyBtYXhfcGFnZXM7Cgl1bnNpZ25lZCBsb25nIGxvbmcgcmVxdWlyZWRfbWFz
azsKCXVuc2lnbmVkIGxvbmcgbG9uZyBhbnlvZl9tYXNrOwoJdW5zaWduZWQgbG9uZyBsb25n
IGV4Y2x1ZGVkX21hc2s7Cgl1bnNpZ25lZCBsb25nIGxvbmcgcmV0dXJuX21hc2s7Cn07Cgoj
ZGVmaW5lIFBNX1NDQU5fT1BfR0VUCSgxIDw8IDApCiNkZWZpbmUgUE1fU0NBTl9PUF9XUAko
MSA8PCAxKQoKLyogUGFnZW1hcCBpb2N0bCAqLwojZGVmaW5lIFBBR0VNQVBfU0NBTglfSU9X
UignZicsIDE2LCBzdHJ1Y3QgcG1fc2Nhbl9hcmcpCgojZW5kaWYKCiNkZWZpbmUgX19OUl91
c2VyZmF1bHRmZCAzMjMKCiNkZWZpbmUgUEFHRU1BUCAiL3Byb2Mvc2VsZi9wYWdlbWFwIgpp
bnQgcGFnZW1hcF9mZDsKaW50IHVmZmQ7CgpzdGF0aWMgbG9uZyBwYWdlbWFwX2lvY3RsKHZv
aWQgKnN0YXJ0LCBpbnQgbGVuLCB2b2lkICp2ZWMsIGludCB2ZWNfbGVuLCBpbnQgZmxhZywK
CQkJICBpbnQgbWF4X3BhZ2VzLCBsb25nIHJlcXVpcmVkX21hc2ssIGxvbmcgYW55b2ZfbWFz
aywgbG9uZyBleGNsdWRlZF9tYXNrLAoJCQkgIGxvbmcgcmV0dXJuX21hc2spCnsKCXN0cnVj
dCBwbV9zY2FuX2FyZyBhcmc7CgoJYXJnLnN0YXJ0ID0gKHVpbnRwdHJfdClzdGFydDsKCWFy
Zy5sZW4gPSBsZW47CglhcmcudmVjID0gKHVpbnRwdHJfdCl2ZWM7CglhcmcudmVjX2xlbiA9
IHZlY19sZW47CglhcmcuZmxhZ3MgPSBmbGFnOwoJYXJnLnNpemUgPSBzaXplb2Yoc3RydWN0
IHBtX3NjYW5fYXJnKTsKCWFyZy5tYXhfcGFnZXMgPSBtYXhfcGFnZXM7CglhcmcucmVxdWly
ZWRfbWFzayA9IHJlcXVpcmVkX21hc2s7CglhcmcuYW55b2ZfbWFzayA9IGFueW9mX21hc2s7
CglhcmcuZXhjbHVkZWRfbWFzayA9IGV4Y2x1ZGVkX21hc2s7CglhcmcucmV0dXJuX21hc2sg
PSByZXR1cm5fbWFzazsKCglyZXR1cm4gaW9jdGwocGFnZW1hcF9mZCwgUEFHRU1BUF9TQ0FO
LCAmYXJnKTsKfQoKaW50IGluaXRfdWZmZCh2b2lkKQp7CglzdHJ1Y3QgdWZmZGlvX2FwaSB1
ZmZkaW9fYXBpOwoKCXVmZmQgPSBzeXNjYWxsKF9fTlJfdXNlcmZhdWx0ZmQsIE9fQ0xPRVhF
QyB8IE9fTk9OQkxPQ0spOwoJaWYgKHVmZmQgPT0gLTEpCgkJZXhpdCgxKTsKCgl1ZmZkaW9f
YXBpLmFwaSA9IFVGRkRfQVBJOwoJdWZmZGlvX2FwaS5mZWF0dXJlcyA9IFVGRkRfRkVBVFVS
RV9XUF9VTlBPUFVMQVRFRCB8IFVGRkRfRkVBVFVSRV9XUF9BU1lOQyB8CgkJCSAgICAgIFVG
RkRfRkVBVFVSRV9XUF9IVUdFVExCRlNfU0hNRU07CglpZiAoaW9jdGwodWZmZCwgVUZGRElP
X0FQSSwgJnVmZmRpb19hcGkpKQoJCWV4aXQoMSk7CgoJaWYgKCEodWZmZGlvX2FwaS5hcGkg
JiBVRkZESU9fUkVHSVNURVJfTU9ERV9XUCkgfHwKCSAgICAhKHVmZmRpb19hcGkuZmVhdHVy
ZXMgJiBVRkZEX0ZFQVRVUkVfV1BfVU5QT1BVTEFURUQpIHx8CgkgICAgISh1ZmZkaW9fYXBp
LmZlYXR1cmVzICYgVUZGRF9GRUFUVVJFX1dQX0FTWU5DKSB8fAoJICAgICEodWZmZGlvX2Fw
aS5mZWF0dXJlcyAmIFVGRkRfRkVBVFVSRV9XUF9IVUdFVExCRlNfU0hNRU0pKQoJCWV4aXQo
MSk7CgoJcmV0dXJuIDA7Cn0KCmludCB3cF9pbml0KHZvaWQgKmxwQmFzZUFkZHJlc3MsIGlu
dCBkd1JlZ2lvblNpemUpCnsKCXN0cnVjdCB1ZmZkaW9fcmVnaXN0ZXIgdWZmZGlvX3JlZ2lz
dGVyOwoJc3RydWN0IHVmZmRpb193cml0ZXByb3RlY3Qgd3A7CgoJdWZmZGlvX3JlZ2lzdGVy
LnJhbmdlLnN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpbHBCYXNlQWRkcmVzczsKCXVmZmRpb19y
ZWdpc3Rlci5yYW5nZS5sZW4gPSBkd1JlZ2lvblNpemU7Cgl1ZmZkaW9fcmVnaXN0ZXIubW9k
ZSA9IFVGRkRJT19SRUdJU1RFUl9NT0RFX1dQOwoJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19S
RUdJU1RFUiwgJnVmZmRpb19yZWdpc3RlcikpCgkJZXhpdCgxKTsKCglpZiAoISh1ZmZkaW9f
cmVnaXN0ZXIuaW9jdGxzICYgVUZGRElPX1dSSVRFUFJPVEVDVCkpCgkJZXhpdCgxKTsKCgl3
cC5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKWxwQmFzZUFkZHJlc3M7Cgl3cC5yYW5n
ZS5sZW4gPSBkd1JlZ2lvblNpemU7Cgl3cC5tb2RlID0gVUZGRElPX1dSSVRFUFJPVEVDVF9N
T0RFX1dQOwoKCWlmIChpb2N0bCh1ZmZkLCBVRkZESU9fV1JJVEVQUk9URUNULCAmd3ApKQoJ
CWV4aXQoMSk7CgoJcmV0dXJuIDA7Cn0KCmludCB3cF9mcmVlKHZvaWQgKmxwQmFzZUFkZHJl
c3MsIGludCBkd1JlZ2lvblNpemUpCnsKCXN0cnVjdCB1ZmZkaW9fcmVnaXN0ZXIgdWZmZGlv
X3JlZ2lzdGVyOwoKCXVmZmRpb19yZWdpc3Rlci5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBs
b25nKWxwQmFzZUFkZHJlc3M7Cgl1ZmZkaW9fcmVnaXN0ZXIucmFuZ2UubGVuID0gZHdSZWdp
b25TaXplOwoJdWZmZGlvX3JlZ2lzdGVyLm1vZGUgPSBVRkZESU9fUkVHSVNURVJfTU9ERV9X
UDsKCWlmIChpb2N0bCh1ZmZkLCBVRkZESU9fVU5SRUdJU1RFUiwgJnVmZmRpb19yZWdpc3Rl
ci5yYW5nZSkpCgkJZXhpdCgxKTsKCXJldHVybiAwOwp9CgppbnQgd3BfYWRkcl9yYW5nZSh2
b2lkICpscEJhc2VBZGRyZXNzLCBpbnQgZHdSZWdpb25TaXplKQp7CglzdHJ1Y3QgdWZmZGlv
X3dyaXRlcHJvdGVjdCB3cDsKCgl3cC5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKWxw
QmFzZUFkZHJlc3M7Cgl3cC5yYW5nZS5sZW4gPSBkd1JlZ2lvblNpemU7Cgl3cC5tb2RlID0g
VUZGRElPX1dSSVRFUFJPVEVDVF9NT0RFX1dQOwoKCWlmIChpb2N0bCh1ZmZkLCBVRkZESU9f
V1JJVEVQUk9URUNULCAmd3ApKQoJCWV4aXQoMSk7CgoJcmV0dXJuIDA7Cn0KCi8vaW50IHdw
X2FkZHJfcmFuZ2VfKHZvaWQgKmxwQmFzZUFkZHJlc3MsIGludCBkd1JlZ2lvblNpemUpCi8v
ewovLwlzdHJ1Y3QgcGFnZV9yZWdpb24gKnZlYzsKLy8JaW50IHJldDsKLy8KLy8JdmVjID0g
bWFsbG9jKHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pICogZHdSZWdpb25TaXplKTsKLy8K
Ly8JcmV0ID0gcGFnZW1hcF9pb2N0bChscEJhc2VBZGRyZXNzLCBkd1JlZ2lvblNpemUsIHZl
YywgZHdSZWdpb25TaXplLCBQTV9TQ0FOX09QX0dFVCB8IFBNX1NDQU5fT1BfV1AsCi8vCQkJ
ICAgIDAsIFBBR0VfSVNfV1JJVFRFTiwgMCwgMCwgUEFHRV9JU19XUklUVEVOKTsKLy8KLy8J
aWYgKHJldCA8IDApCi8vCQlleGl0KDEpOwovLwovLwlmcmVlKHZlYyk7Ci8vCXJldHVybiAw
OwovL30KCmludCB3cF9hZGRyX3JhbmdlX18odm9pZCAqbHBCYXNlQWRkcmVzcywgaW50IGR3
UmVnaW9uU2l6ZSkKewoJaW50IHJldDsKCglyZXQgPSBwYWdlbWFwX2lvY3RsKGxwQmFzZUFk
ZHJlc3MsIGR3UmVnaW9uU2l6ZSwgTlVMTCwgMCwgUE1fU0NBTl9PUF9XUCwKCQkJICAgIDAs
IFBBR0VfSVNfV1JJVFRFTiwgMCwgMCwgUEFHRV9JU19XUklUVEVOKTsKCglpZiAocmV0IDwg
MCkKCQlleGl0KDEpOwoKCXJldHVybiAwOwp9CgojZGVmaW5lIFdSSVRFX1dBVENIX0ZMQUdf
UkVTRVQJMQpzdHJ1Y3QgcGFnZV9yZWdpb24gKmJ1ZjsKCmludCBHZXRXcml0ZVdhdGNoKGlu
dCBmbGFnLCBjaGFyICpzdGFydCwgbG9uZyBsZW4sIGxvbmcgKip2ZWMsIHVuc2lnbmVkIGlu
dCAqd3dfY291bnQsCgkJICB1bnNpZ25lZCBpbnQgKmdyYW51bGFyaXR5KQp7CglzdHJ1Y3Qg
cG1fc2Nhbl9hcmcgYXJnOwoJaW50IGksIGosIGluZCA9IDAsIHJldDsKCglhcmcuc3RhcnQg
PSAodWludHB0cl90KXN0YXJ0OwoJYXJnLmxlbiA9IGxlbjsKCWFyZy52ZWMgPSAodWludHB0
cl90KWJ1ZjsgLy8odWludHB0cl90KXZlYzsKCWFyZy52ZWNfbGVuID0gKnd3X2NvdW50OwoJ
YXJnLmZsYWdzID0gUE1fU0NBTl9PUF9HRVQ7CglpZiAoZmxhZyA9PSBXUklURV9XQVRDSF9G
TEFHX1JFU0VUKQoJCWFyZy5mbGFncyB8PSBQTV9TQ0FOX09QX1dQOwoJYXJnLnNpemUgPSBz
aXplb2Yoc3RydWN0IHBtX3NjYW5fYXJnKTsKCWFyZy5tYXhfcGFnZXMgPSAqd3dfY291bnQ7
CglhcmcucmVxdWlyZWRfbWFzayA9IFBBR0VfSVNfV1JJVFRFTjsKCWFyZy5hbnlvZl9tYXNr
ID0gMDsKCWFyZy5leGNsdWRlZF9tYXNrID0gMDsKCWFyZy5yZXR1cm5fbWFzayA9IFBBR0Vf
SVNfV1JJVFRFTjsKCglpZiAoZ3JhbnVsYXJpdHkpCgkJKmdyYW51bGFyaXR5ID0gNDA5NjsK
CglyZXQgPSBpb2N0bChwYWdlbWFwX2ZkLCBQQUdFTUFQX1NDQU4sICZhcmcpOwoJaWYgKHJl
dCA8IDApCgkJZ290byBmcmVlX2FuZF9yZXR1cm47CgoJKnd3X2NvdW50ID0gMDsKCWZvciAo
aSA9IDA7IGkgPCByZXQ7IGkrKykgewoJCSp3d19jb3VudCArPSBidWZbaV0ubGVuOwoKCQlm
b3IgKGogPSAwOyBqIDwgYnVmW2ldLmxlbjsgaisrKQoJCQl2ZWNbaW5kKytdID0gKGxvbmcg
aW50ICopKGJ1ZltpXS5zdGFydCArIGogKiA0MDk2KTsKCX0KCglyZXQgPSAwOwoKZnJlZV9h
bmRfcmV0dXJuOgoJcmV0dXJuIHJldDsKfQoKLy8jZGVmaW5lIFVTRV9QQUdFTUFQX0dFVF9X
UAovLyNkZWZpbmUgVVNFX1BBR0VNQVBfV1AKCnVuc2lnbmVkIGxvbmcgbG9uZyByZXNldF90
b3RhbDsKaW50IFJlc2V0V3JpdGVXYXRjaCh2b2lkICpscEJhc2VBZGRyZXNzLCBpbnQgZHdS
ZWdpb25TaXplKQp7Cgl1bnNpZ25lZCBsb25nIGxvbmcgdCA9IHJkdHNjKCk7CglpbnQgcmV0
OwoKI2lmZGVmIFVTRV9QQUdFTUFQX0dFVF9XUAoJcmV0ID0gd3BfYWRkcl9yYW5nZV8obHBC
YXNlQWRkcmVzcywgZHdSZWdpb25TaXplKTsKI2VsaWYgZGVmaW5lZCBVU0VfUEFHRU1BUF9X
UAoJcmV0ID0gd3BfYWRkcl9yYW5nZV9fKGxwQmFzZUFkZHJlc3MsIGR3UmVnaW9uU2l6ZSk7
CiNlbHNlCglyZXQgPSB3cF9hZGRyX3JhbmdlKGxwQmFzZUFkZHJlc3MsIGR3UmVnaW9uU2l6
ZSk7CiNlbmRpZgoJcmVzZXRfdG90YWwgKz0gcmR0c2MoKSAtIHQ7CgoJcmV0dXJuIHJldDsK
fQoKCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXVuc2lnbmVkIGludCB3
d19jb3VudCwgd3dfdG90YWwsIGN5Y2xlX2NvdW50LCBmYXVsdF9jb3VudDsKCXN0cnVjdCB0
aHJlYWRfaW5mbyBpbmZvW01BWF9USFJFQURfQ09VTlRdOwoJdW5zaWduZWQgbG9uZyBsb25n
IHQxLCB0MiwgcmR0c2Nfc3RhcnQsIHJkdHNjX2VuZDsKCWRvdWJsZSBzdGFydCwgY3Vyciwg
Y3ljbGVfc3RhcnQ7CglzdGF0aWMgbG9uZyAqKnd3X2FkZHI7Cglsb25nIGxvbmcgd3JpdGVz
X2NvdW50OwoJdW5zaWduZWQgbG9uZyBsb25nIHd3cmVhZF90aW1lOwoJZG91YmxlIHJ3X2Rl
bGF5X21zOwoJdW5zaWduZWQgaW50IGdyYW51bGFyaXR5OwoJdW5zaWduZWQgaW50IG9sZF9w
cm90OwoJdW5zaWduZWQgaW50IGNvdW50OwoJdW5zaWduZWQgaW50IGk7CglpbnQgZ2V0X2Nv
dW50OwoJc2l6ZV90IG5wYWdlczsKCglwYWdlbWFwX2ZkID0gb3BlbihQQUdFTUFQLCBPX1JE
V1IpOwoJaWYgKHBhZ2VtYXBfZmQgPCAwKSB7CgkJcGVycm9yKCJwYWdlbWFwZmQiKTsKCQly
ZXR1cm4gLUVJTlZBTDsKCX0KCglpZiAoaW5pdF91ZmZkKCkpCgkJcmV0dXJuIC0xOwoKCWlm
IChhcmdjIDwgNikgewoJCXB1dHMoIlVzYWdlOiB3aW4uZXhlIDxudGhyZWFkcz4gPG5wYWdl
cz4gPHdhdGNoX2RlbGF5X21zPiA8cmFuZG9tX2FjY2Vzcz4gPHJlYWRfcmVzZXQ+XG4iKTsK
CQlyZXR1cm4gLTE7Cgl9CgoJbnRocmVhZHMgPSBhdG9pKGFyZ3ZbMV0pOwoJaWYgKG50aHJl
YWRzID4gTUFYX1RIUkVBRF9DT1VOVCkgewoJCUxPRygiTWF4aW11bSBvZiAldSB0aHJlYWRz
IHN1cHBvcnRlZC5cbiIsIE1BWF9USFJFQURfQ09VTlQpOwoJCXJldHVybiAtMTsKCX0KCW5w
YWdlcyA9IGF0b2koYXJndlsyXSk7CglpZiAobnBhZ2VzIDwgbnRocmVhZHMgfHwgbnBhZ2Vz
ICUgbnRocmVhZHMpIHsKCQlMT0coIm5wYWdlcyBzaG91bGQgYmUgPiBudGhyZWFkcyBhbmQg
ZXZlbmx5IGRpdmlzaWJsZSBieSBudGhyZWFkcy5cbiIpOwoJCXJldHVybiAtMTsKCX0KCXJ3
X2RlbGF5X21zID0gYXRvZihhcmd2WzNdKTsKCXJhbmRvbV9hY2Nlc3MgPSBhdG9pKGFyZ3Zb
NF0pOwoJcmVhZF9yZXNldCA9IGF0b2koYXJndls1XSk7CgoJd3dfYWRkciA9IG1hbGxvYyhz
aXplb2YoKnd3X2FkZHIpICogbnBhZ2VzKTsKCgltZW0gPSBtbWFwKE5VTEwsIG5wYWdlcyAq
IFBBR0VfU0laRSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUgfCBNQVBf
QU5PTiwgLTEsIDApOwoJaWYgKCFtZW0pIHsKCQlMT0coIkZhaWxlZCB0byBhbGxvY2F0ZSB2
aXJ0dWFsIG1lbW9yeS5cbiIpOwoJCXJldHVybiAtMTsKCX0KCXdwX2luaXQobWVtLCBucGFn
ZXMgKiBQQUdFX1NJWkUpOwoJd3BfYWRkcl9yYW5nZShtZW0sIG5wYWdlcyAqIFBBR0VfU0la
RSk7CgoJbWVtWzBdID0gMHgyODsKCgltZW1bMHgxMDAwXSA9IDB4Mjk7CgoJYnVmID0gbWFs
bG9jKDEwMDAwMCAqIHNpemVvZihzdHJ1Y3QgcGFnZV9yZWdpb24pKTsKCgl3d19jb3VudCA9
IDEwMDsKCWlmIChHZXRXcml0ZVdhdGNoKDAsIG1lbSwgMHgxMDAwICogbnBhZ2VzLCB3d19h
ZGRyLCAmd3dfY291bnQsICZncmFudWxhcml0eSkpIHsKCQlMT0coIkdldFdyaXRlV2F0Y2go
KSBmYWlsZWQsIEdldExhc3RFcnJvcigpICVsdS5cbiIsIGVycm5vKTsKCQlyZXR1cm4gLTE7
Cgl9Ci8vCUxPRygiY291bnQgJWxsdSwgJXAsICVwLlxuIiwgd3dfY291bnQsIG1lbSwgd3df
YWRkclswXSk7CgltZW0gPSBtbWFwKE5VTEwsIG5wYWdlcyAqIDB4MTAwMCwgUFJPVF9SRUFE
IHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTiwgLTEsIDApOwoJaWYgKCFt
ZW0pIHsKCQlwZXJyb3IoIkVycm9yIGNvbW1pdCIpOwoJCXJldHVybiAtMTsKCX0KCXdwX2lu
aXQobWVtLCBucGFnZXMgKiAweDEwMDApOwoJd3BfYWRkcl9yYW5nZShtZW0sIG5wYWdlcyAq
IDB4MTAwMCk7CgoJd3dfY291bnQgPSAxMDA7CglpZiAoR2V0V3JpdGVXYXRjaCgwLCBtZW0s
IDB4MTAwMCAqIG5wYWdlcywgd3dfYWRkciwgJnd3X2NvdW50LCAmZ3JhbnVsYXJpdHkpKSB7
CgkJTE9HKCJHZXRXcml0ZVdhdGNoKCkgZmFpbGVkLCBHZXRMYXN0RXJyb3IoKSAlbHUuXG4i
LCBlcnJubyk7CgkJcmV0dXJuIC0xOwoJfQovLwlMT0coImNvdW50ICVsbHUsICVwLCAlcC5c
biIsIHd3X2NvdW50LCBtZW0sIHd3X2FkZHJbMF0pOwoKCW1lbXNldChtZW0sIDAsIG5wYWdl
cyAqIFBBR0VfU0laRSk7CglSZXNldFdyaXRlV2F0Y2gobWVtLCBucGFnZXMgKiBQQUdFX1NJ
WkUpOwoKCXd3X2NvdW50ID0gMTAwOwoJaWYgKEdldFdyaXRlV2F0Y2goMCwgbWVtLCAweDEw
MDAgKiBucGFnZXMsIHd3X2FkZHIsICZ3d19jb3VudCwgJmdyYW51bGFyaXR5KSkgewoJCUxP
RygiR2V0V3JpdGVXYXRjaCgpIGZhaWxlZCwgR2V0TGFzdEVycm9yKCkgJWx1LlxuIiwgZXJy
bm8pOwoJCXJldHVybiAtMTsKCX0KLy8JTE9HKCJyZWFkIGJ5dGVzICVsdSwgY291bnQgYWZ0
ZXIgcmVhZCAlbGx1LCAlcCwgJXAuXG4iLCBjb3VudCwgd3dfY291bnQsIG1lbSwgd3dfYWRk
clswXSk7CgoJbWVtc2V0KG1lbSwgMCwgbnBhZ2VzICogUEFHRV9TSVpFKTsKCVJlc2V0V3Jp
dGVXYXRjaChtZW0sIG5wYWdlcyAqIFBBR0VfU0laRSk7CgoJcHRocmVhZF90IHRoOwoJZm9y
IChpID0gMDsgaSA8IG50aHJlYWRzOyArK2kpIHsKCQlpbmZvW2ldLm1lbSA9IG1lbSArIDB4
MTAwMCAqIGkgKiBucGFnZXMgLyBudGhyZWFkczsKCQlpbmZvW2ldLm5wYWdlcyA9IG5wYWdl
cyAvIG50aHJlYWRzOwoKCQlwdGhyZWFkX2NyZWF0ZSgmdGgsIE5VTEwsIHRocmVhZF9wcm9j
LCAmaW5mb1tpXSk7Cgl9CgoJZ2V0X2NvdW50ID0gbnBhZ2VzOwoKCXd3cmVhZF90aW1lID0g
MDsKCWN1cnIgPSBzdGFydCA9IGN1cnJfdGltZV9tcygpOwoJd3dfdG90YWwgPSAwOwoJY3lj
bGVfY291bnQgPSAwOwoJcmR0c2Nfc3RhcnQgPSByZHRzYygpOwoJd2hpbGUgKGN1cnIgLSBz
dGFydCA8IFRFU1RfVElNRSkgewoJCWNoYXIgKmFkZHIsICplbmQ7CgoJCWN5Y2xlX3N0YXJ0
ID0gY3VycjsKCgkJdDEgPSByZHRzYygpOwoKCQlhZGRyID0gbWVtOwoJCWVuZCA9IG1lbSAr
IG5wYWdlcyAqIFBBR0VfU0laRTsKLy8JCUxPRygiY3ljbGUgJUk2NHUuXG4iLCBjeWNsZV9j
b3VudCk7CgkJd2hpbGUgKGFkZHIgPCBlbmQpIHsKCQkJd3dfY291bnQgPSBnZXRfY291bnQ7
CgkJCWlmIChHZXRXcml0ZVdhdGNoKHJlYWRfcmVzZXQgPyBXUklURV9XQVRDSF9GTEFHX1JF
U0VUIDogMCwgYWRkciwgZW5kIC0gYWRkciwKCQkJCQkgIHd3X2FkZHIsICZ3d19jb3VudCwg
JmdyYW51bGFyaXR5KSkgewoJCQkJTE9HKCJHZXRXcml0ZVdhdGNoKCkgZmFpbGVkLCBHZXRM
YXN0RXJyb3IoKSAlbHUuXG4iLCBlcnJubyk7CgkJCQlyZXR1cm4gLTE7CgkJCX0KCQkJd3df
dG90YWwgKz0gd3dfY291bnQ7CgkJCWlmICh3d19jb3VudCA8IGdldF9jb3VudCkKCQkJCWJy
ZWFrOwoJCQlhZGRyID0gKGNoYXIgKil3d19hZGRyW3d3X2NvdW50IC0gMV0gKyAweDEwMDA7
CgkJCUxPRygiYWRkciAlcCwgZW5kICVwLCB3d19jb3VudCAlSTY0dS5cbiIsIGFkZHIsIGVu
ZCwgd3dfY291bnQpOwoJCX0KCQlpZiAoIXJlYWRfcmVzZXQpCgkJCVJlc2V0V3JpdGVXYXRj
aChtZW0sIGVuZCAtIG1lbSk7CgoJCXQyID0gcmR0c2MoKTsKCQl3d3JlYWRfdGltZSArPSB0
MiAtIHQxOwoJCWN1cnIgPSBjdXJyX3RpbWVfbXMoKTsKCQl3aGlsZSAoY3VyciAtIHN0YXJ0
IDwgVEVTVF9USU1FICYmIGN1cnIgLSBjeWNsZV9zdGFydCA8IHJ3X2RlbGF5X21zKSB7CgkJ
CXNjaGVkX3lpZWxkKCk7CgkJCWN1cnIgPSBjdXJyX3RpbWVfbXMoKTsKCQl9CgkJKytjeWNs
ZV9jb3VudDsKCX0KLy8JcmR0c2NfZW5kID0gcmR0c2MoKTsKCXdyaXRlc19jb3VudCA9IHJh
d193cml0ZXNfY291bnQ7CglmaW5pc2ggPSB0cnVlOwovLwlyZHRzY19jID0gMTAwMC4wICog
KGN1cnIgLSBzdGFydCkgLyAocmR0c2NfZW5kIC0gcmR0c2Nfc3RhcnQpOwovLwlMT0coInJk
dHNjX2MgJWxmLlxuIiwgcmR0c2NfYyk7CgoJc2xlZXAoMSk7CgoJTE9HKCJFbGFwc2VkICUu
MWxmLCBjeWNsZV9jb3VudCAlbGx1LCB3cml0ZXNfY291bnQgJWxsZCwgd3JpdGVzIHdhdGNo
ZWQgJWxsdS5cbiIsCgkgICAgY3VyciAtIHN0YXJ0LCBjeWNsZV9jb3VudCwgd3JpdGVzX2Nv
dW50LCB3d190b3RhbCk7CglMT0coIndyaXRlcyBwZXIgdGhyZWFkICogbXNlYyAlLjNsZiwg
YXZnLiB3cml0ZSB0aW1lICUuMWxmLCBHZXRXcml0ZVdhdGNoKCkgYXZnICUuMWxmLlxuIiwK
CSAgICB3cml0ZXNfY291bnQgLyAoVEVTVF9USU1FICogbnRocmVhZHMpLCAoZmxvYXQpd3Jp
dGVzX3RpbWUvd3JpdGVzX2NvdW50LAoJICAgIHd3cmVhZF90aW1lIC8gY3ljbGVfY291bnQp
OwoKCXByaW50ZigiUmVzZXRXcml0ZVdhdGNoKCkgdGltZSByZHRzYyAtLT4gJWxsdSBNXG4i
LCByZXNldF90b3RhbC8xMDAwMDAwKTsKCiAgICBmcmVlKGJ1Zik7CiAgICByZXR1cm4gMDsK
fQo=

--------------Xz97V200tO7rQELjn6uPUVb0--
