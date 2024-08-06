Return-Path: <linux-fsdevel+bounces-25056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670C9486B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0C1C22033
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C763B9;
	Tue,  6 Aug 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tTVR7OKO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5781392
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905415; cv=none; b=tGrmlBABC97520Qi48vYDS/8TL7RubRGeqaWqXQGd9tTW8D+yES+QWj6TidybQdw3SCo8Tzq0LUts4Diin943o4AjXfyO8MFS1RCbAH63JWzDU5JEcdoixSB9Si+J/5w+KfkLhoXFg7ffaSzTVVyJxVRnJK+jz6shHAkD1+g3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905415; c=relaxed/simple;
	bh=MXnhH8tRoxcz8AxRTy534nhSsd4sRm1EJwFEOKSpUH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG9vDD4C7UneGiEMAz3oiI6507JLUJtbBwfYNS/BQEYhwGWURpi/G61EAcChMOv9C7KzCvuYRrLGX+AOi3qkLnz/LJ6/zujYo/NER8J2XnqHHb+n0/9Sz2jGy35MzOQwA1LUrszdSGq04FXsxdHoOg71b2qcfxvau66kL+IrefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tTVR7OKO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 20:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722905411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIfU4BnHJ3hoVLSMX5altQK7zQMbwMLuzoLqpgAa4Os=;
	b=tTVR7OKOVx7nOY2s4nG2MZYNRAlg6OpEeMraQnerU5VMjk78lSTeFi6OXpiVVz6CNHaPt1
	TUIP36UPG4OlqBpTQFFVlW5x6mLI3GH+zshxNBYajovcShDiaCCRErZn4yndWCFIO6zEDu
	tdl7ppdbQTx5m00aX9c0GcC/qgSVLI0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Viacheslav Dubeyko <slava@dubeyko.com>, 
	Jonathan Carter <jcc@debian.org>
Cc: linux-bcache@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, slava@dubeiko.com
Subject: Re: bcachefs mount issue
Message-ID: <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
References: <0D2287C8-F086-43B1-85FA-B672BFF908F5@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D2287C8-F086-43B1-85FA-B672BFF908F5@dubeyko.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 05, 2024 at 09:35:09PM GMT, Viacheslav Dubeyko wrote:
> Hi Kent,
> 
> As far as I  can see, I have found a mount issue. I believe that it’s a mkfs tool issue.
> 
> ENVIRONMENT:
> Linux ssdfs-test-0070 6.10.0 #15 SMP PREEMPT_DYNAMIC Mon Aug  5 19:00:55 MSK 2024 x86_64 x86_64 x86_64 GNU/Linux
> 
> I am not sure how to share the mkfs.bcachefs tool version because this tool doesn’t show the version.

You're using an ancient version - I presume from Debian?

Debian hasn't been getting tools updates, you can't get anything modern
because of, I believe, a libsodium transition (?), and modern 1.9.x
versions aren't getting pushed out either.

I'll have to refer you to them - Jonathan, what's going on?

> REPRODUCTION PATH:
> 
> (1) Format partition by mkfs tool of any file system (for example, NILFS2)
> (2) Mount the prepared volume
> (3) Execute any file system operations on the volume
> (4) Unmount the volume
> (5) Format partition by mkfs.bcachefs tool
> (6) Try to mount the prepared  bcachefs volume
> (7) The bcachefs logic fails too mount the formatted volume
> 
> sudo mkfs.nilfs2 -f -b 4096 /dev/sda1 
> mkfs.nilfs2 (nilfs-utils 2.2.8)
> Start writing file system initial data to the device
>        Blocksize:4096  Device:/dev/sda1  Device Size:999292928
> File system initialization succeeded !!
> 
> sudo mount /dev/sda1 /mnt/test/
> 
> mount
> <skipped>
> /dev/sda1 on /mnt/test type nilfs2 (rw,relatime)
> 
> Aug  5 19:14:40 ssdfs-test-0070 kernel: [  520.066975] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> Aug  5 19:14:40 ssdfs-test-0070 nilfs_cleanerd[3854]: start
> Aug  5 19:14:40 ssdfs-test-0070 nilfs_cleanerd[3854]: pause (clean check)
> 
> sudo umount /mnt/test
> 
> Aug  5 19:15:18 ssdfs-test-0070 nilfs_cleanerd[3854]: shutdown
> 
> sudo mkfs.bcachefs -f --block_size=4096 /dev/sda1 
> External UUID: 483fb669-63aa-4f41-b0ba-61eb2446c2fe
> Internal UUID: 43527890-f6c8-43f1-bdd9-1c4936f71a8d
> Device index: 0
> Label: 
> Version: 14
> Oldest version on disk: 14
> Created: Mon Aug  5 19:20:32 2024
> Squence number: 0
> Block_size: 4.0K
> Btree node size: 128.0K
> Error action: ro
> Clean: 0
> Features: new_siphash,new_extent_overwrite,btree_ptr_v2,extents_above_btree_updates,btree_updates_journalled,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
> Compat features: 
> Metadata replicas: 1
> Data replicas: 1
> Metadata checksum type: crc32c (1)
> Data checksum type: crc32c (1)
> Compression type: none (0)
> Foreground write target: none
> Background write target: none
> Promote target: none
> Metadata target:                none
> String hash type: siphash (2)
> 32 bit inodes: 1
> GC reserve percentage: 8%
> Root reserve percentage: 0%
> Devices: 1 live, 1 total
> Sections: members
> Superblock size: 816
> 
> Members (size 64):
>   Device 0:
>     UUID: 2c54ddfc-f50c-4d15-aa80-7d23474de3e6
>     Size: 953.0M
>     Bucket size: 128.0K
>     First bucket: 0
>     Buckets: 7624
>     Last mount: (never)
>     State: rw
>     Group: (none)
>     Data allowed: journal,btree,user
>     Has data: (none)
>     Replacement policy: lru
>     Discard: 0
> initializing new filesystem
> going read-write
> mounted with opts: (null)
> 
> sudo mount /dev/sda1 /mnt/test/
> 
> mount
> <skipped>
> /dev/sda1 on /mnt/test type nilfs2 (rw,relatime) <— completely unexpected
> 
> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.678991] NILFS (sda1): broken superblock, retrying with spare superblock (blocksize = 1024)
> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.679835] NILFS (sda1): broken superblock, retrying with spare superblock (blocksize = 4096)
> Aug  5 19:21:13 ssdfs-test-0070 kernel: [  912.706795] NILFS (sda1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
> Aug  5 19:21:13 ssdfs-test-0070 nilfs_cleanerd[4751]: start
> Aug  5 19:21:13 ssdfs-test-0070 nilfs_cleanerd[4751]: pause (clean check)
> 
> sudo umount /mnt/test
> 
> sudo mount -t bcachefs /dev/sda1 /mnt/test/
> mount: /mnt/test: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.
> 
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311715] bcachefs (sda1): mounting version 0.14: btree_ptr_sectors_written opts=noshard_inode_numbers,journal_reclaim_delay=1000,nojournal_transaction_names
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311753] bcachefs (sda1): recovering from clean shutdown, journal seq 4
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782] bcachefs (sda1): Version upgrade required:
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782] Doing incompatible version upgrade from 0.14: btree_ptr_sectors_written to 1.7: mi_btree_bitmap
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.311782]   running recovery passes: check_allocations,check_alloc_info,check_lrus,check_btree_backpointers,check_backpointers_to_extents,check_extents_to_backpointers,check_alloc_to_lru_refs,bucket_gens_init,check_snapshot_trees,check_snapshots,check_subvols,check_subvol_children,delete_dead_snapshots,check_inodes,check_extents,check_indirect_extents,check_dirents,check_xattrs,check_root,check_subvolume_structure,check_directory_structure,check_nlinks,delete_dead_inodes,set_fs_needs_rebalance
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431462] bcachefs (sda1): alloc_read... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431675] bcachefs (sda1): stripes_read... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431688] bcachefs (sda1): snapshots_read... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.431702] bcachefs (sda1): check_allocations...
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.469609] dev 0 has wrong free buckets: got 0, should be 7537, fixing
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.469683]  done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471013] bcachefs (sda1): going read-write
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471766] bcachefs (sda1): journal_replay... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.471794] bcachefs (sda1): check_alloc_info... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.472921] bcachefs (sda1): check_lrus... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.473309] bcachefs (sda1): check_btree_backpointers... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.473960] bcachefs (sda1): check_backpointers_to_extents... done
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474483] bcachefs (sda1): check_extents_to_backpointers...
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474582] missing backpointer for btree=inodes l=1 u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq d7dbe59ccc0e54fa written 24 min_key POS_MIN durability: 1 ptr: 0:78:0 gen 1
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474590]   got:   u64s 5 type deleted 0:20447232:0 len 0 ver 0
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474595]   want:  u64s 9 type backpointer 0:20447232:0 len 0 ver 0: bucket=0:78:0 btree=inodes l=1 offset=0:0 len=256 pos=SPOS_MAX, shutting down
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474645] bcachefs (sda1): inconsistency detected - emergency read only at journal seq 4
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474664] bcachefs (sda1): bch2_check_extents_to_backpointers(): error fsck_errors_not_fixed
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474682] bcachefs (sda1): bch2_fs_recovery(): error fsck_errors_not_fixed
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474692] bcachefs (sda1): bch2_fs_start(): error starting filesystem fsck_errors_not_fixed
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.474842] bcachefs (sda1): unshutdown complete, journal seq 4
> Aug  5 19:23:01 ssdfs-test-0070 kernel: [ 1020.595522] bcachefs: bch2_mount() error: fsck_errors_not_fixed
> 
> Thanks,
> Slava.
> 
> 
> 
> 
> 

