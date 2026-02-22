Return-Path: <linux-fsdevel+bounces-77877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL7IM/6Vm2kK2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:49:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40C170D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2652D301AE7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617435FF73;
	Sun, 22 Feb 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CrjLnC6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FA35FF66
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771804155; cv=none; b=JHvIpLyoOlolCIQujfjqFuTr7X8bKtDwC4ctDmIU29kAfdTKvS5JeFQAgGrlfSYQoHSa7UT2KcF+IxWEtNcBFnczbSGaZSeBeXo864pM83j41dLzql2kOhXTgtwMRr6fPo3PE6GfzVa5XmfTrAIVmEfhedYHWilSxL1Rsk2zUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771804155; c=relaxed/simple;
	bh=ZNl0hwlwMovxdQ2MQwq2WRIA1rd3ydK8yMeshKvjva4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er8JcepW1Y8XeHJocC7yJNSF2kMa92zzkUBetO2wmeLRs1wpYsvcnweIehOWG+K0+ZwwkzNJdngi7nyTJJPJkm6sr93XZgGGebVzHiCzOhRypotKKQ8ttJku9Dmv7xVerU4QBAPPVHc03azVSYTmPeGDi47FQli7qUUMFt1pCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CrjLnC6J; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 22 Feb 2026 15:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771804141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wf1OfANA38l1Nqjx+a+UYfaqGfLco3xZ9QiXSc8+bzA=;
	b=CrjLnC6JILfkdrFtkitx8WNrZzh/SpyN8brXdb+YUkYTugS6Wi3PSNDnM6X4kTDJfo4UdK
	tTApzlJhUwSDhEz3EQOaU6KmYKK6DHcpd67RWoubBbUO1seAP++WmaKcIV6/4LSmsP4S6C
	FH9flvlL2j1ZmkT58kG4f0z7JIuGNwY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Carlos Maiolino <cem@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com, Muchun Song <muchun.song@linux.dev>, 
	Cgroups <cgroups@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Hao Li <hao.li@linux.dev>
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock()
 (RCU free path)
Message-ID: <aZuVgStlrvZ87duZ@linux.dev>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
 <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
 <ccdcd672-b5e1-45bc-86f3-791af553f0d8@linux.ibm.com>
 <aZrstwhqX6bSpjtz@hyeyoo>
 <aZuR6_Mm9uqt_6Fp@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZuR6_Mm9uqt_6Fp@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77877-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: BA40C170D93
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 03:36:46PM -0800, Shakeel Butt wrote:
> On Sun, Feb 22, 2026 at 08:47:03PM +0900, Harry Yoo wrote:
> [...]
> > 
> > It seems it crashed while dereferencing objcg->ref->data->count.
> > I think that implies that obj_cgroup_release()->percpu_ref_exit()
> > is already called due to the refcount reaching zero and set
> > ref->data = NULL.
> > 
> > Wait, was the stock->objcg ever a valid objcg?
> > I think it should be valid when refilling the obj stock, otherwise
> > it should have crashed in refill_obj_stock() -> obj_cgroup_get() path
> > in the first place, rather than crashing when draining.
> > 
> > And that sounds like we're somehow calling obj_cgroup_put() more times
> > than obj_cgroup_get().
> > 
> > Anyway, this is my theory that it may be due to mis-refcounting of objcgs.
> > 
> 
> I have not looked deeper into recent slub changes (sheafs or obj_exts savings)
> but one thing looks weird to me:
> 
> allocate_slab() // for cache with SLAB_OBJ_EXT_IN_OBJ
> 	-> alloc_slab_obj_exts_early()
> 		-> slab_set_stride(slab, s->size)
> 	-> account_slab()
> 		-> alloc_slab_obj_exts()
> 			-> slab_set_stride(slab, sizeof(struct slabobj_ext));
> 
> Unconditional overwrite of stride. Not sure if it is issue or even related to
> this crash but looks odd.

I asked AI to debug this crash report along with a nudge towards to look for
stride corruption, it gave me the following output:


# Stride Corruption Bug Analysis

## Bug Report Context

- **Crash Location**: `drain_obj_stock+0x620/0xa48` in `obj_cgroup_put(old)` at mm/memcontrol.c:3059
- **Root Cause**: `percpu_ref.data` is NULL, meaning `obj_cgroup_release()` already ran
- **Platform**: IBM Power11 (pSeries LPAR, Radix MMU, LE, 64K pages, kernel 6.19.0-next-20260216)
- **Trigger**: xfstests generic/428

## Identified Bug: Unconditional Stride Overwrite

### Location: mm/slub.c lines 2196-2223 (alloc_slab_obj_exts)

```c
retry:
    old_exts = READ_ONCE(slab->obj_exts);
    handle_failed_objexts_alloc(old_exts, vec, objects);
    slab_set_stride(slab, sizeof(struct slabobj_ext));  // BUG: UNCONDITIONALLY SET

    if (new_slab) {
        slab->obj_exts = new_exts;
    } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
        // obj_exts already exists, BUT stride was already modified above!
        mark_objexts_empty(vec);
        kfree(vec);
        return 0;
    } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
        goto retry;
    }
```

### The Problem

The stride is set to `sizeof(struct slabobj_ext)` **BEFORE** checking if `obj_exts` already
exists. If a slab was created with `SLAB_OBJ_EXT_IN_OBJ` mode (where stride = `s->size`),
and later `alloc_slab_obj_exts` is called for any reason, the stride gets corrupted.

### Stride Modes

There are two stride modes (see alloc_slab_obj_exts_early):

1. **Normal mode**: stride = `sizeof(struct slabobj_ext)` (~16 bytes)
   - obj_exts is a separate array or in slab leftover space

2. **SLAB_OBJ_EXT_IN_OBJ mode**: stride = `s->size` (object size, e.g., 64-256+ bytes)
   - obj_ext is embedded within each object at a fixed offset

### Consequences of Wrong Stride

When `slab_obj_ext` is later called:
```c
obj_ext = (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
```

With corrupted stride (16 instead of 256):
- **Expected**: `obj_exts + 256 * 5 = obj_exts + 1280` (correct obj_ext for object 5)
- **Actual**: `obj_exts + 16 * 5 = obj_exts + 80` (WRONG obj_ext - belongs to object 0!)

This causes:
1. Reading wrong object's objcg pointer
2. Releasing wrong objcg reference (`obj_cgroup_put`)
3. Reference underflow on victim objcg
4. Early `obj_cgroup_release()` → `percpu_ref_exit()` → `data = NULL`
5. Stock still caches the objcg pointer
6. Later `drain_obj_stock()` tries to put it → **CRASH**

## Missing Safety Check

`slab_obj_ext()` in mm/slab.h has **no bounds checking**:

```c
static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
                                               unsigned long obj_exts,
                                               unsigned int index)
{
    struct slabobj_ext *obj_ext;

    VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
    // MISSING: VM_WARN_ON_ONCE(index >= slab->objects);

    obj_ext = (struct slabobj_ext *)(obj_exts +
                                     slab_get_stride(slab) * index);
    return kasan_reset_tag(obj_ext);
}
```

## CRITICAL: Memory Ordering Bug on PowerPC (Likely Root Cause)

### The Problem

In `alloc_slab_obj_exts` (mm/slub.c lines 2199-2220), there is **NO memory barrier**
between the stride store and the obj_exts visibility via cmpxchg:

```c
slab_set_stride(slab, sizeof(struct slabobj_ext));  // Store to stride (line 2199)
                                                     // NO MEMORY BARRIER HERE!
if (new_slab) {
    slab->obj_exts = new_exts;                       // Store to obj_exts (line 2207)
} else if (...) {
} else if (cmpxchg(&slab->obj_exts, ...) != ...) {   // Atomic on obj_exts (line 2220)
    goto retry;
}
```

### Why This Crashes on PowerPC

PowerPC has a **weakly-ordered memory model**. Stores can be reordered and may not be
immediately visible to other processors. The cmpxchg provides a barrier AFTER it
executes, but the stride store BEFORE cmpxchg may not be visible when obj_exts becomes
visible.

**Race Scenario:**
1. CPU A: `slab_set_stride(slab, 16)` (store to stride, in CPU A's store buffer)
2. CPU A: `cmpxchg(&slab->obj_exts, 0, new_exts)` succeeds, obj_exts is now visible
3. CPU B: Sees `obj_exts` is set (from step 2)
4. CPU B: Reads `slab->stride` → **sees OLD value (0 or garbage)** due to reordering!
5. CPU B: `slab_obj_ext` calculates `obj_exts + 0 * index = obj_exts` for ALL indices!
6. **All objects appear to share the same obj_ext at offset 0**

### Consequences

- Object 0's objcg is correct
- Object 1..N all read object 0's objcg (WRONG!)
- When freeing multiple objects, we `obj_cgroup_put` the SAME objcg multiple times
- Reference count underflows → early `obj_cgroup_release()`
- `percpu_ref_exit()` sets `data = NULL`
- Later stock drain tries to put the objcg → **CRASH in `drain_obj_stock`**

### Why This Matches the Bug Report

- **Platform**: IBM Power11 (PowerPC) - weakly ordered memory
- **Trigger**: xfstests generic/428 - creates high filesystem activity with many allocations
- **Crash location**: `drain_obj_stock` → `obj_cgroup_put` with NULL data
- **Pattern**: Stock has cached objcg that was prematurely released

### Proposed Fix

Add a write memory barrier to ensure stride is visible before obj_exts:

```c
slab_set_stride(slab, sizeof(struct slabobj_ext));
smp_wmb();  // Ensure stride is visible before obj_exts

if (new_slab) {
    slab->obj_exts = new_exts;
} else if (...) {
} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
    goto retry;
}
```

And correspondingly, the reader side should use a read barrier:
```c
static inline unsigned short slab_get_stride(struct slab *slab)
{
    // Need acquire semantics when reading stride after seeing obj_exts
    return smp_load_acquire(&slab->stride);
}
```

Or use `smp_store_release` / `smp_load_acquire` pairs for proper ordering.

### Also Applies to alloc_slab_obj_exts_early

The same issue exists in `alloc_slab_obj_exts_early` (lines 2290-2291 and 2308-2309):

```c
slab->obj_exts = obj_exts;                           // Store obj_exts
slab_set_stride(slab, sizeof(struct slabobj_ext));   // Store stride AFTER!
```

Here the order is **reversed** - obj_exts is set BEFORE stride! This is even worse
for memory ordering, as other CPUs could see obj_exts before stride is set.

## Original Theory: Unconditional Stride Overwrite

(Kept for reference - less likely to be the root cause on this specific crash)

The stride is set to `sizeof(struct slabobj_ext)` **BEFORE** checking if `obj_exts`
already exists. However, analysis shows this is protected by the TOCTOU check in
callers (`!slab_obj_exts(slab)`).

## Trigger Scenarios

1. **Memory ordering on PowerPC** (MOST LIKELY): Stride not visible when obj_exts
   becomes visible due to missing memory barriers.

2. **Race between alloc_slab_obj_exts calls**: Two CPUs trying to allocate obj_exts
   for the same slab simultaneously.

3. **Interaction with RCU free path**: Objects in RCU sheaf being processed when
   stride is stale/zero.

## Confirmed Code Analysis (CONFIG_64BIT)

On 64-bit systems (including IBM Power11), the stride is stored dynamically:

**mm/slab.h:562-569**:
```c
#ifdef CONFIG_64BIT
static inline void slab_set_stride(struct slab *slab, unsigned short stride)
{
    slab->stride = stride;  // Plain store - NO memory ordering!
}
static inline unsigned short slab_get_stride(struct slab *slab)
{
    return slab->stride;    // Plain load - NO memory ordering!
}
```

**mm/slab.h:533-548** (`slab_obj_exts`):
```c
static inline unsigned long slab_obj_exts(struct slab *slab)
{
    unsigned long obj_exts = READ_ONCE(slab->obj_exts);  // Only compiler barrier!
    // ... validation ...
    return obj_exts & ~OBJEXTS_FLAGS_MASK;
}
```

`READ_ONCE` only provides compiler ordering, NOT CPU memory ordering. There's no
acquire barrier to ensure the stride read happens after seeing obj_exts.

## Complete Fix Using Release/Acquire Semantics

### Fix 1: Reader side - slab_obj_exts (mm/slab.h)

Change `READ_ONCE` to `smp_load_acquire`:

```c
static inline unsigned long slab_obj_exts(struct slab *slab)
{
    unsigned long obj_exts = smp_load_acquire(&slab->obj_exts);  // Acquire barrier
    // ... validation ...
    return obj_exts & ~OBJEXTS_FLAGS_MASK;
}
```

### Fix 2: Writer side - alloc_slab_obj_exts (mm/slub.c:2196-2223)

Use `smp_store_release` for obj_exts after setting stride:

```c
retry:
    old_exts = READ_ONCE(slab->obj_exts);
    handle_failed_objexts_alloc(old_exts, vec, objects);

    if (new_slab) {
        slab_set_stride(slab, sizeof(struct slabobj_ext));
        smp_store_release(&slab->obj_exts, new_exts);  // Release barrier
    } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
        mark_objexts_empty(vec);
        kfree(vec);
        return 0;
    } else {
        slab_set_stride(slab, sizeof(struct slabobj_ext));
        // cmpxchg already provides release semantics, but stride must be
        // visible before cmpxchg. Need explicit barrier:
        smp_wmb();
        if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts)
            goto retry;
    }
```

### Fix 3: Writer side - alloc_slab_obj_exts_early (mm/slub.c:2290-2291, 2308-2309)

The order is REVERSED here - obj_exts is set BEFORE stride! Fix by using
`smp_store_release`:

```c
// For normal obj_exts (lines 2290-2291):
slab_set_stride(slab, sizeof(struct slabobj_ext));  // Set stride FIRST
smp_store_release(&slab->obj_exts, obj_exts);       // Then release obj_exts

// For SLAB_OBJ_EXT_IN_OBJ (lines 2308-2309):
slab_set_stride(slab, s->size);                     // Set stride FIRST
smp_store_release(&slab->obj_exts, obj_exts);       // Then release obj_exts
```

## Why This Fixes the Crash

With proper release/acquire ordering:

1. **Writer** (CPU A): Sets stride, then `smp_store_release(&obj_exts, ...)` ensures
   stride is visible to all CPUs before obj_exts becomes visible

2. **Reader** (CPU B): `smp_load_acquire(&obj_exts)` ensures that if obj_exts is
   seen as set, the subsequent stride read will see the correct value

This prevents the race where CPU B sees obj_exts but reads stale/zero stride,
which caused all objects to appear to share obj_ext at offset 0, leading to
multiple `obj_cgroup_put` calls on the same objcg → reference underflow → crash.

## Additional Safety: Bounds Check in slab_obj_ext

Add bounds check to catch any remaining issues:
```c
VM_WARN_ON_ONCE(index >= slab->objects);
```

