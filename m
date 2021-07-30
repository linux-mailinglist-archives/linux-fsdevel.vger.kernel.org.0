Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6C3DBDB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhG3R26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 13:28:58 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36808 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3R25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:28:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:45382)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m9WJT-00C0vz-8O; Fri, 30 Jul 2021 11:28:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50210 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m9WJR-00EIHz-PZ; Fri, 30 Jul 2021 11:28:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        peterx@redhat.com, david@redhat.com, christian.brauner@ubuntu.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
Date:   Fri, 30 Jul 2021 12:28:17 -0500
In-Reply-To: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com> (Tiberiu
        A. Georgescu's message of "Fri, 30 Jul 2021 16:08:25 +0000")
Message-ID: <87y29nbtji.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m9WJR-00EIHz-PZ;;;mid=<87y29nbtji.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+6IEKtMRYJExMJRTDSbxhxN5Cr2lmSlHE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XM_B_SpammyWords,
        XM_B_SpammyWords2,XM_Multi_Part_URI autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 834 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 9 (1.1%), b_tie_ro: 7 (0.9%), parse: 1.30 (0.2%),
        extract_message_metadata: 15 (1.8%), get_uri_detail_list: 3.9 (0.5%),
        tests_pri_-1000: 14 (1.7%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 138 (16.5%), check_bayes:
        134 (16.0%), b_tokenize: 15 (1.8%), b_tok_get_all: 13 (1.6%),
        b_comp_prob: 4.1 (0.5%), b_tok_touch_all: 97 (11.6%), b_finish: 1.10
        (0.1%), tests_pri_0: 634 (76.0%), check_dkim_signature: 1.13 (0.1%),
        check_dkim_adsp: 4.2 (0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 14 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com> writes:

> This patch follows up on a previous RFC:
> 20210714152426.216217-1-tiberiu.georgescu@nutanix.com
>
> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> entry is cleared. In many cases, there is no difference between swapped-out
> shared pages and newly allocated, non-dirty pages in the pagemap
> interface.

What is the point?

You say a shared swapped out page is the same as a clean shared page
and you are exactly correct.  What is the point in knowing a shared
page was swapped out?  What does is the gain?

I tried to understand the point by looking at your numbers below
and everything I could see looked worse post patch.  

Eric



> Example pagemap-test code (Tested on Kernel Version 5.14-rc3):
>     #define NPAGES (256)
>     /* map 1MiB shared memory */
>     size_t pagesize = getpagesize();
>     char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
>     		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
>     /* Dirty new pages. */
>     for (i = 0; i < PAGES; i++)
>     	p[i * pagesize] = i;
>
> Run the above program in a small cgroup, which causes swapping:
>     /* Initialise cgroup & run a program */
>     $ echo 512K > foo/memory.limit_in_bytes
>     $ echo 60 > foo/memory.swappiness
>     $ cgexec -g memory:foo ./pagemap-test
>
> Check the pagemap report. Example of the current expected output:
>     $ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
>     00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>     *
>     00000710  e1 6b 06 00 00 00 00 a1  9e eb 06 00 00 00 00 a1  |.k..............|
>     00000720  6b ee 06 00 00 00 00 a1  a5 a4 05 00 00 00 00 a1  |k...............|
>     00000730  5c bf 06 00 00 00 00 a1  90 b6 06 00 00 00 00 a1  |\...............|
>
> The first pagemap entries are reported as zeroes, indicating the pages have
> never been allocated while they have actually been swapped out.
>
> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> make use of the XArray associated with the virtual memory area struct
> passed as an argument. The XArray contains the location of virtual pages in
> the page cache, swap cache or on disk. If they are in either of the caches,
> then the original implementation still works. If not, then the missing
> information will be retrieved from the XArray.
>
> Performance
> ============
> I measured the performance of the patch on a single socket Xeon E5-2620
> machine, with 128GiB of RAM and 128GiB of swap storage. These were the
> steps taken:
>
>   1. Run example pagemap-test code on a cgroup
>     a. Set up cgroup with limit_in_bytes=4GiB and swappiness=60;
>     b. allocate 16GiB (about 4 million pages);
>     c. dirty 0,50 or 100% of pages;
>     d. do this for both private and shared memory.
>   2. Run `dd if=<PAGEMAP> ibs=8 skip=$(($VADDR / $PAGESIZE)) count=4194304`
>      for each possible configuration above
>     a.  3 times for warm up;
>     b. 10 times to measure performance.
>        Use `time` or another performance measuring tool.
>
> Results (averaged over 10 iterations):
>                +--------+------------+------------+
>                | dirty% |  pre patch | post patch |
>                +--------+------------+------------+
>  private|anon  |     0% |      8.15s |      8.40s |
>                |    50% |     11.83s |     12.19s |
>                |   100% |     12.37s |     12.20s |
>                +--------+------------+------------+
>   shared|anon  |     0% |      8.17s |      8.18s |
>                |    50% | (*) 10.43s |     37.43s |
>                |   100% | (*) 10.20s |     38.59s |
>                +--------+------------+------------+
>
> (*): reminder that pre-patch produces incorrect pagemap entries for swapped
>      out pages.
>
> From run to run the above results are stable (mostly <1% stderr).
>
> The amount of time it takes for a full read of the pagemap depends on the
> granularity used by dd to read the pagemap file. Even though the access is
> sequential, the script only reads 8 bytes at a time, running pagemap_read()
> COUNT times (one time for each page in a 16GiB area).
>
> To reduce overhead, we can use batching for large amounts of sequential
> access. We can make dd read multiple page entries at a time,
> allowing the kernel to make optimisations and yield more throughput.
>
> Performance in real time (seconds) of
> `dd if=<PAGEMAP> ibs=8*$BATCH skip=$(($VADDR / $PAGESIZE / $BATCH))
> count=$((4194304 / $BATCH))`:
> +---------------------------------+ +---------------------------------+
> |     Shared, Anon, 50% dirty     | |     Shared, Anon, 100% dirty    |
> +-------+------------+------------+ +-------+------------+------------+
> | Batch |  Pre-patch | Post-patch | | Batch |  Pre-patch | Post-patch |
> +-------+------------+------------+ +-------+------------+------------+
> |     1 | (*) 10.43s |     37.43s | |     1 | (*) 10.20s |     38.59s |
> |     2 | (*)  5.25s |     18.77s | |     2 | (*)  5.15s |     19.37s |
> |     4 | (*)  2.63s |      9.42s | |     4 | (*)  2.63s |      9.74s |
> |     8 | (*)  1.38s |      4.80s | |     8 | (*)  1.35s |      4.94s |
> |    16 | (*)  0.73s |      2.46s | |    16 | (*)  0.72s |      2.54s |
> |    32 | (*)  0.40s |      1.31s | |    32 | (*)  0.41s |      1.34s |
> |    64 | (*)  0.25s |      0.72s | |    64 | (*)  0.24s |      0.74s |
> |   128 | (*)  0.16s |      0.43s | |   128 | (*)  0.16s |      0.44s |
> |   256 | (*)  0.12s |      0.28s | |   256 | (*)  0.12s |      0.29s |
> |   512 | (*)  0.10s |      0.21s | |   512 | (*)  0.10s |      0.22s |
> |  1024 | (*)  0.10s |      0.20s | |  1024 | (*)  0.10s |      0.21s |
> +-------+------------+------------+ +-------+------------+------------+
>
> To conclude, in order to make the most of the underlying mechanisms of
> pagemap and xarray, one should be using batching to achieve better
> performance.
>
> Future Work
> ============
>
> Note: there are PTE flags which currently do not survive the swap out when
> the page is shmem: SOFT_DIRTY and UFFD_WP.
>
> A solution for saving the state of the UFFD_WP flag has been proposed by
> Peter Xu in the patch linked below. The concept and mechanism proposed
> could be extended to include the SOFT_DIRTY bit as well:
> 20210715201422.211004-1-peterx@redhat.com
> Our patches are mostly orthogonal.
>
> Kind regards,
> Tibi
>
> Tiberiu A Georgescu (1):
>   pagemap: report swap location for shared pages
>
>  fs/proc/task_mmu.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
