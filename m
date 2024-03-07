Return-Path: <linux-fsdevel+bounces-13836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253448746A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 04:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A76B223B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722417551;
	Thu,  7 Mar 2024 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ychUmlpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86869E555;
	Thu,  7 Mar 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781574; cv=none; b=Q/sVWaV6iZkLqPHHgDBiVAfKm1fV7y7DRQ5CIhoKMqhcm52GG0jbUWfHeEhzeuj67UtGZkOCao6j3rAX5Zj3spvZpn1MbT0BwGIOP9//ggOlK7H+TmyC3wnalJlI2Cd9IM9hZYJ6HNbIUNziA1fMGdoL1y4QlieqypY3rQ6HMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781574; c=relaxed/simple;
	bh=hJ6fv3HI3NxvYP0IKsPxT4ASej2UnYY1+6Lcvw7UNHM=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=uw1MW/MKWD6s7tQw6yxQ3JMVMpc1HyPHLeG5H69y2O48AGYgqtJX7ZnOYMauM7fEr+tkgK0SNNBw2v4/J+26ZcAwtclUhppeyTq9iODj3cHz3bom1Ulbo2rD0FvHlzWDY1SWcyOiWyFv6BnWrIaSGQ7LMBHVsDElTTq2wOvspiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ychUmlpI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:References:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K3TldHFnOYBYmyA+ZpDycxvkU6EpB6K91tOzErQkNoI=; b=ychUmlpIQkbhQ0W88gqlbMN+nk
	N7kxwIp4Izr4S3lPCeFsCe0pWGa05MFzhPp2qPSYgcWyeCT567m7b6xEwRBOrMHS3lZSsqVyoUU4T
	7y7F6/lnCPMAbpLWNT/KgSkRXbsb+WWVTPkheyVwlC0r9TITjgwaWMg0KgLhrms6g9S/ejbG7FBNm
	SnHBJTcxh0jjHwmTLQ8nR9IGWHgPGEJJpwnf9Ij4MI5DdZHa+8y8x739teJjHUtKT2eoh77rLEGz6
	MdP/Ix8fny+Mesi6BjfLkCNZ6bfubnyJsEeeVzha+mbjpED+NoQEjvZnt3DmNMWzWM6Xr/QhSH1JE
	yw3U0gQw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri4Hf-00000002oO9-0yJC;
	Thu, 07 Mar 2024 03:19:03 +0000
Content-Type: multipart/mixed; boundary="------------oaFa8uBlfstuVB17zCaypWJR"
Message-ID: <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
Date: Wed, 6 Mar 2024 19:18:57 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 aliceryhl@google.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-38-surenb@google.com>
Content-Language: en-US
In-Reply-To: <20240306182440.2003814-38-surenb@google.com>

This is a multi-part message in MIME format.
--------------oaFa8uBlfstuVB17zCaypWJR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
This includes some editing suggestions and some doc build fixes.


On 3/6/24 10:24, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Provide documentation for memory allocation profiling.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  Documentation/mm/allocation-profiling.rst | 91 +++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/mm/allocation-profiling.rst
> 
> diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
> new file mode 100644
> index 000000000000..8a862c7d3aab
> --- /dev/null
> +++ b/Documentation/mm/allocation-profiling.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +MEMORY ALLOCATION PROFILING
> +===========================
> +
> +Low overhead (suitable for production) accounting of all memory allocations,
> +tracked by file and line number.
> +
> +Usage:
> +kconfig options:
> + - CONFIG_MEM_ALLOC_PROFILING
> + - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> + - CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +   adds warnings for allocations that weren't accounted because of a
> +   missing annotation
> +
> +Boot parameter:
> +  sysctl.vm.mem_profiling=0|1|never
> +
> +  When set to "never", memory allocation profiling overheads is minimized and it

                                                      overhead is

> +  cannot be enabled at runtime (sysctl becomes read-only).
> +  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y, default value is "1".
> +  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n, default value is "never".
> +
> +sysctl:
> +  /proc/sys/vm/mem_profiling
> +
> +Runtime info:
> +  /proc/allocinfo
> +
> +Example output:
> +  root@moria-kvm:~# sort -g /proc/allocinfo|tail|numfmt --to=iec
> +        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
> +        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
> +        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
> +        4.1M        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
> +        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
> +        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
> +         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> +         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> +         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
> +         55M     4887 mm/slub.c:2259 func:alloc_slab_page
> +        122M    31168 mm/page_ext.c:270 func:alloc_page_ext
> +===================
> +Theory of operation
> +===================
> +
> +Memory allocation profiling builds off of code tagging, which is a library for
> +declaring static structs (that typcially describe a file and line number in

                                  typically

> +some way, hence code tagging) and then finding and operating on them at runtime

                                                                        at runtime,

> +- i.e. iterating over them to print them in debugfs/procfs.

  i.e., iterating

> +
> +To add accounting for an allocation call, we replace it with a macro
> +invocation, alloc_hooks(), that
> + - declares a code tag
> + - stashes a pointer to it in task_struct
> + - calls the real allocation function
> + - and finally, restores the task_struct alloc tag pointer to its previous value.
> +
> +This allows for alloc_hooks() calls to be nested, with the most recent one
> +taking effect. This is important for allocations internal to the mm/ code that
> +do not properly belong to the outer allocation context and should be counted
> +separately: for example, slab object extension vectors, or when the slab
> +allocates pages from the page allocator.
> +
> +Thus, proper usage requires determining which function in an allocation call
> +stack should be tagged. There are many helper functions that essentially wrap
> +e.g. kmalloc() and do a little more work, then are called in multiple places;
> +we'll generally want the accounting to happen in the callers of these helpers,
> +not in the helpers themselves.
> +
> +To fix up a given helper, for example foo(), do the following:
> + - switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
> + - rename it to foo_noprof()
> + - define a macro version of foo() like so:
> +   #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
> +
> +It's also possible to stash a pointer to an alloc tag in your own data structures.
> +
> +Do this when you're implementing a generic data structure that does allocations
> +"on behalf of" some other code - for example, the rhashtable code. This way,
> +instead of seeing a large line in /proc/allocinfo for rhashtable.c, we can
> +break it out by rhashtable type.
> +
> +To do so:
> + - Hook your data structure's init function, like any other allocation function

maybe end the line above with a '.' like the following line.

> + - Within your init function, use the convenience macro alloc_tag_record() to
> +   record alloc tag in your data structure.
> + - Then, use the following form for your allocations:
> +   alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))


Finally, there are a number of documentation build warnings in this patch.
I'm no ReST expert, but the attached patch fixes them for me.

-- 
#Randy
--------------oaFa8uBlfstuVB17zCaypWJR
Content-Type: text/x-patch; charset=UTF-8;
 name="docum-mm-alloc-profiling-fix403.patch"
Content-Disposition: attachment;
 filename="docum-mm-alloc-profiling-fix403.patch"
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Ci0t
LQogRG9jdW1lbnRhdGlvbi9tbS9hbGxvY2F0aW9uLXByb2ZpbGluZy5yc3QgfCAgIDI4ICsr
KysrKysrKystLS0tLS0tLS0tCiBEb2N1bWVudGF0aW9uL21tL2luZGV4LnJzdCAgICAgICAg
ICAgICAgICB8ICAgIDEgCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLSBhL0RvY3VtZW50YXRpb24vbW0vYWxsb2NhdGlvbi1w
cm9maWxpbmcucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9hbGxvY2F0aW9uLXByb2ZpbGluZy5y
c3QKLS0tIGEvRG9jdW1lbnRhdGlvbi9tbS9hbGxvY2F0aW9uLXByb2ZpbGluZy5yc3QKKysr
IGIvRG9jdW1lbnRhdGlvbi9tbS9hbGxvY2F0aW9uLXByb2ZpbGluZy5yc3QKQEAgLTksMTEg
KzksMTEgQEAgdHJhY2tlZCBieSBmaWxlIGFuZCBsaW5lIG51bWJlci4KIAogVXNhZ2U6CiBr
Y29uZmlnIG9wdGlvbnM6Ci0gLSBDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElORwotIC0gQ09O
RklHX01FTV9BTExPQ19QUk9GSUxJTkdfRU5BQkxFRF9CWV9ERUZBVUxUCi0gLSBDT05GSUdf
TUVNX0FMTE9DX1BST0ZJTElOR19ERUJVRwotICAgYWRkcyB3YXJuaW5ncyBmb3IgYWxsb2Nh
dGlvbnMgdGhhdCB3ZXJlbid0IGFjY291bnRlZCBiZWNhdXNlIG9mIGEKLSAgIG1pc3Npbmcg
YW5ub3RhdGlvbgorLSBDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElORworLSBDT05GSUdfTUVN
X0FMTE9DX1BST0ZJTElOR19FTkFCTEVEX0JZX0RFRkFVTFQKKy0gQ09ORklHX01FTV9BTExP
Q19QUk9GSUxJTkdfREVCVUcKK2FkZHMgd2FybmluZ3MgZm9yIGFsbG9jYXRpb25zIHRoYXQg
d2VyZW4ndCBhY2NvdW50ZWQgYmVjYXVzZSBvZiBhCittaXNzaW5nIGFubm90YXRpb24KIAog
Qm9vdCBwYXJhbWV0ZXI6CiAgIHN5c2N0bC52bS5tZW1fcHJvZmlsaW5nPTB8MXxuZXZlcgpA
QCAtMjksNyArMjksOCBAQCBzeXNjdGw6CiBSdW50aW1lIGluZm86CiAgIC9wcm9jL2FsbG9j
aW5mbwogCi1FeGFtcGxlIG91dHB1dDoKK0V4YW1wbGUgb3V0cHV0OjoKKwogICByb290QG1v
cmlhLWt2bTp+IyBzb3J0IC1nIC9wcm9jL2FsbG9jaW5mb3x0YWlsfG51bWZtdCAtLXRvPWll
YwogICAgICAgICAyLjhNICAgIDIyNjQ4IGZzL2tlcm5mcy9kaXIuYzo2MTUgZnVuYzpfX2tl
cm5mc19uZXdfbm9kZQogICAgICAgICAzLjhNICAgICAgOTUzIG1tL21lbW9yeS5jOjQyMTQg
ZnVuYzphbGxvY19hbm9uX2ZvbGlvCkBAIC00MiwyMSArNDMsMjIgQEAgRXhhbXBsZSBvdXRw
dXQ6CiAgICAgICAgICAxNU0gICAgIDM2NTYgbW0vcmVhZGFoZWFkLmM6MjQ3IGZ1bmM6cGFn
ZV9jYWNoZV9yYV91bmJvdW5kZWQKICAgICAgICAgIDU1TSAgICAgNDg4NyBtbS9zbHViLmM6
MjI1OSBmdW5jOmFsbG9jX3NsYWJfcGFnZQogICAgICAgICAxMjJNICAgIDMxMTY4IG1tL3Bh
Z2VfZXh0LmM6MjcwIGZ1bmM6YWxsb2NfcGFnZV9leHQKKwogPT09PT09PT09PT09PT09PT09
PQogVGhlb3J5IG9mIG9wZXJhdGlvbgogPT09PT09PT09PT09PT09PT09PQogCiBNZW1vcnkg
YWxsb2NhdGlvbiBwcm9maWxpbmcgYnVpbGRzIG9mZiBvZiBjb2RlIHRhZ2dpbmcsIHdoaWNo
IGlzIGEgbGlicmFyeSBmb3IKIGRlY2xhcmluZyBzdGF0aWMgc3RydWN0cyAodGhhdCB0eXBj
aWFsbHkgZGVzY3JpYmUgYSBmaWxlIGFuZCBsaW5lIG51bWJlciBpbgotc29tZSB3YXksIGhl
bmNlIGNvZGUgdGFnZ2luZykgYW5kIHRoZW4gZmluZGluZyBhbmQgb3BlcmF0aW5nIG9uIHRo
ZW0gYXQgcnVudGltZQotLSBpLmUuIGl0ZXJhdGluZyBvdmVyIHRoZW0gdG8gcHJpbnQgdGhl
bSBpbiBkZWJ1Z2ZzL3Byb2Nmcy4KK3NvbWUgd2F5LCBoZW5jZSBjb2RlIHRhZ2dpbmcpIGFu
ZCB0aGVuIGZpbmRpbmcgYW5kIG9wZXJhdGluZyBvbiB0aGVtIGF0IHJ1bnRpbWUsCitpLmUu
LCBpdGVyYXRpbmcgb3ZlciB0aGVtIHRvIHByaW50IHRoZW0gaW4gZGVidWdmcy9wcm9jZnMu
CiAKIFRvIGFkZCBhY2NvdW50aW5nIGZvciBhbiBhbGxvY2F0aW9uIGNhbGwsIHdlIHJlcGxh
Y2UgaXQgd2l0aCBhIG1hY3JvCi1pbnZvY2F0aW9uLCBhbGxvY19ob29rcygpLCB0aGF0Ci0g
LSBkZWNsYXJlcyBhIGNvZGUgdGFnCi0gLSBzdGFzaGVzIGEgcG9pbnRlciB0byBpdCBpbiB0
YXNrX3N0cnVjdAotIC0gY2FsbHMgdGhlIHJlYWwgYWxsb2NhdGlvbiBmdW5jdGlvbgotIC0g
YW5kIGZpbmFsbHksIHJlc3RvcmVzIHRoZSB0YXNrX3N0cnVjdCBhbGxvYyB0YWcgcG9pbnRl
ciB0byBpdHMgcHJldmlvdXMgdmFsdWUuCitpbnZvY2F0aW9uLCBhbGxvY19ob29rcygpLCB0
aGF0OgorLSBkZWNsYXJlcyBhIGNvZGUgdGFnCistIHN0YXNoZXMgYSBwb2ludGVyIHRvIGl0
IGluIHRhc2tfc3RydWN0CistIGNhbGxzIHRoZSByZWFsIGFsbG9jYXRpb24gZnVuY3Rpb24K
Ky0gYW5kIGZpbmFsbHksIHJlc3RvcmVzIHRoZSB0YXNrX3N0cnVjdCBhbGxvYyB0YWcgcG9p
bnRlciB0byBpdHMgcHJldmlvdXMgdmFsdWUuCiAKIFRoaXMgYWxsb3dzIGZvciBhbGxvY19o
b29rcygpIGNhbGxzIHRvIGJlIG5lc3RlZCwgd2l0aCB0aGUgbW9zdCByZWNlbnQgb25lCiB0
YWtpbmcgZWZmZWN0LiBUaGlzIGlzIGltcG9ydGFudCBmb3IgYWxsb2NhdGlvbnMgaW50ZXJu
YWwgdG8gdGhlIG1tLyBjb2RlIHRoYXQKZGlmZiAtLSBhL0RvY3VtZW50YXRpb24vbW0vaW5k
ZXgucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9pbmRleC5yc3QKLS0tIGEvRG9jdW1lbnRhdGlv
bi9tbS9pbmRleC5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9pbmRleC5yc3QKQEAgLTI2
LDYgKzI2LDcgQEAgc2VlIHRoZSA6ZG9jOmBhZG1pbiBndWlkZSA8Li4vYWRtaW4tZ3VpZAog
ICAgcGFnZV9jYWNoZQogICAgc2htZnMKICAgIG9vbQorICAgYWxsb2NhdGlvbi1wcm9maWxp
bmcKIAogTGVnYWN5IERvY3VtZW50YXRpb24KID09PT09PT09PT09PT09PT09PT09Cg==

--------------oaFa8uBlfstuVB17zCaypWJR--

