Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14274FC590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiDKUNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiDKUN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:13:29 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFCF31500;
        Mon, 11 Apr 2022 13:11:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:42400)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ne0NQ-007yzj-1p; Mon, 11 Apr 2022 14:11:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:43272 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ne0NO-0052JF-PO; Mon, 11 Apr 2022 14:11:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        hagen@jauu.net, jack@suse.cz, keescook@chromium.org,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Date:   Mon, 11 Apr 2022 15:10:38 -0500
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com> (Khalid Aziz's
        message of "Mon, 11 Apr 2022 10:05:44 -0600")
Message-ID: <87tuazwfcx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ne0NO-0052JF-PO;;;mid=<87tuazwfcx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19V71Xyq0obzOnCiicXz+jKoh/Ns7RbFgY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Khalid Aziz <khalid.aziz@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 615 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.4%), parse: 1.69 (0.3%),
         extract_message_metadata: 8 (1.3%), get_uri_detail_list: 4.8 (0.8%),
        tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.79 (0.3%),
        tests_pri_-900: 1.52 (0.2%), tests_pri_-90: 123 (20.0%), check_bayes:
        121 (19.6%), b_tokenize: 16 (2.6%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 4.9 (0.8%), b_tok_touch_all: 85 (13.9%), b_finish: 1.19
        (0.2%), tests_pri_0: 433 (70.4%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 3.7 (0.6%), poll_dns_idle: 1.22 (0.2%), tests_pri_10:
        3.5 (0.6%), tests_pri_500: 13 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> Page tables in kernel consume some of the memory and as long as number
> of mappings being maintained is small enough, this space consumed by
> page tables is not objectionable. When very few memory pages are
> shared between processes, the number of page table entries (PTEs) to
> maintain is mostly constrained by the number of pages of memory on the
> system. As the number of shared pages and the number of times pages
> are shared goes up, amount of memory consumed by page tables starts to
> become significant.
>
> Some of the field deployments commonly see memory pages shared across
> 1000s of processes. On x86_64, each page requires a PTE that is only 8
> bytes long which is very small compared to the 4K page size. When 2000
> processes map the same page in their address space, each one of them
> requires 8 bytes for its PTE and together that adds up to 8K of memory
> just to hold the PTEs for one 4K page. On a database server with 300GB
> SGA, a system carsh was seen with out-of-memory condition when 1500+
> clients tried to share this SGA even though the system had 512GB of
> memory. On this server, in the worst case scenario of all 1500
> processes mapping every page from SGA would have required 878GB+ for
> just the PTEs. If these PTEs could be shared, amount of memory saved
> is very significant.
>
> This patch series implements a mechanism in kernel to allow userspace
> processes to opt into sharing PTEs. It adds two new system calls - (1)
> mshare(), which can be used by a process to create a region (we will
> call it mshare'd region) which can be used by other processes to map
> same pages using shared PTEs, (2) mshare_unlink() which is used to
> detach from the mshare'd region. Once an mshare'd region is created,
> other process(es), assuming they have the right permissions, can make
> the mashare() system call to map the shared pages into their address
> space using the shared PTEs.  When a process is done using this
> mshare'd region, it makes a mshare_unlink() system call to end its
> access. When the last process accessing mshare'd region calls
> mshare_unlink(), the mshare'd region is torn down and memory used by
> it is freed.
>

>
> API
> ===
>
> The mshare API consists of two system calls - mshare() and mshare_unlink()
>
> --
> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>
> mshare() creates and opens a new, or opens an existing mshare'd
> region that will be shared at PTE level. "name" refers to shared object
> name that exists under /sys/fs/mshare. "addr" is the starting address
> of this shared memory area and length is the size of this area.
> oflags can be one of:
>
> - O_RDONLY opens shared memory area for read only access by everyone
> - O_RDWR opens shared memory area for read and write access
> - O_CREAT creates the named shared memory area if it does not exist
> - O_EXCL If O_CREAT was also specified, and a shared memory area
>   exists with that name, return an error.
>
> mode represents the creation mode for the shared object under
> /sys/fs/mshare.
>
> mshare() returns an error code if it fails, otherwise it returns 0.
>

Please don't add system calls that take names.
 
Please just open objects on the filesystem and allow multi-instances of
the filesystem.  Otherwise someone is going to have to come along later
and implement namespace magic to deal with your new system calls.  You
already have a filesystem all that is needed to avoid having to
introduce namespace magic is to simply allow multiple instances of the
filesystem to be mounted.

On that note.  Since you have a filesystem, introduce a well known
name for a directory and in that directory place all of the information
and possibly control files for your filesystem.  No need to for proc
files and the like, and if at somepoint you have mount options that
allow the information to be changed you can have different mounts
with different values present.


This is must me.  But I find it weird that you don't use mmap
to place the shared area from the mshare fd into your address space.

I think I would do:
	// Establish the mshare region
	addr = mmap(NULL, PGDIR_SIZE, PROT_READ | PROT_WRITE,
			MAP_SHARED | MAP_MSHARE, msharefd, 0);

	// Remove the mshare region
        addr2 = mmap(addr, PGDIR_SIZE, PROT_NONE,
        		MAP_FIXED | MAP_MUNSHARE, msharefd, 0);

I could see a point of using separate system calls instead of
adding MAP_SHARE and MAP_UNSHARE flags.

What are the locking implications of taking a page fault in the shared
region?

Is it a noop or is it going to make some of the nasty locking we have in
the kernel for things like truncates worse?

Eric
