Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD06C54AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCVTPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 15:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCVTPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:15:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F0497C5;
        Wed, 22 Mar 2023 12:15:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g17so24777576lfv.4;
        Wed, 22 Mar 2023 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679512512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCBOvdCKd4EqIlOnayTxMvjd+KY/f+rwaK56Y7Wx9rI=;
        b=QQKl+EQIuLgIWW+CDj2/TlrdtUO0L68jIHNmhN+F2aZQknmUnrA92+rQwESJ57H6jn
         36KMM4RGtls5WBSsB5a9ym1Wc4YSZdb1MR4vVCHb7zhKQjuYkLv5GA3/2vQj1qpSYMvS
         ZRxN31yMd3rO/qynuyE7jSPddERYpoUv2K9InOXlSzXKu8qogb6+p0YLHe7y7/Gc21vo
         R4y9gxCfnn1I6ugbRpTJOMDEjlyukmNVKdn4peDKTjwZ5yvsgkC/8yVqFh9h9OxaYqEv
         qZSrFZtns2tArlohtOHGlh/geR59d6vTojKXf1LHmWV1VWcptGNxqzyONGdiGt2NYmJ/
         bTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCBOvdCKd4EqIlOnayTxMvjd+KY/f+rwaK56Y7Wx9rI=;
        b=y5xSaVnzh6EcZpuC4yghdoavsYFl+7l0Qeo8mNWX66SV0jhLmqmmluTgQ8/rEMMVbg
         m5UiB3xKsXmP+r/6xCNBpY7PHdk7DkZzYflCQ1NHGj9fDlYTqeGUaiIcza31IksJySES
         av4mugX65NZN7U/jmeTITC+tO1mfU7dRs6P2pZAnQWO9V6gEoN9W2quUgIU+pYCI+8PC
         VqvKsmZAfngvKElay+LRO/BZjjxtXTu9NQEMtpo3pCV4OhF727vvMGZUr46h0xMvs9eM
         rQVhAvIzG6YbLIJtMVnvO+1I8a0sj5kgdKR8DvasmeYvpbxkk/tTunODsolNHkNfyaOf
         PJAA==
X-Gm-Message-State: AO0yUKVU+ufBFBC8eAiLtgBAuDy5Edsl2sNngpSSuVjP+z60UcNbXA5s
        47HWkDwGALuSAeNXnKwSK38=
X-Google-Smtp-Source: AK7set8QC1xqmQlCK6G97WU8ztT4PvHsdLL5/PtfWwcwvb3Mwf29QeUzPsYgrBWEl2542LYgyzX2Jg==
X-Received: by 2002:ac2:44d9:0:b0:4dd:ad88:ba5c with SMTP id d25-20020ac244d9000000b004ddad88ba5cmr2335638lfm.4.1679512512076;
        Wed, 22 Mar 2023 12:15:12 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id o7-20020a05651238a700b004b4b600c093sm2652682lft.92.2023.03.22.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:15:11 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 22 Mar 2023 20:15:09 +0100
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBtTvdzgAmsGkQzV@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZBs/MGH+xUAZXNTz@casper.infradead.org>
 <ZBtCl34dolg2YE+3@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtCl34dolg2YE+3@pc636>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:01:59PM +0100, Uladzislau Rezki wrote:
> On Wed, Mar 22, 2023 at 05:47:28PM +0000, Matthew Wilcox wrote:
> > On Wed, Mar 22, 2023 at 02:18:19PM +0100, Uladzislau Rezki wrote:
> > > Hello, Dave.
> > > 
> > > > 
> > > > I'm travelling right now, but give me a few days and I'll test this
> > > > against the XFS workloads that hammer the global vmalloc spin lock
> > > > really, really badly. XFS can use vm_map_ram and vmalloc really
> > > > heavily for metadata buffers and hit the global spin lock from every
> > > > CPU in the system at the same time (i.e. highly concurrent
> > > > workloads). vmalloc is also heavily used in the hottest path
> > > > throught the journal where we process and calculate delta changes to
> > > > several million items every second, again spread across every CPU in
> > > > the system at the same time.
> > > > 
> > > > We really need the global spinlock to go away completely, but in the
> > > > mean time a shared read lock should help a little bit....
> > > > 
> > > Could you please share some steps how to run your workloads in order to
> > > touch vmalloc() code. I would like to have a look at it in more detail
> > > just for understanding the workloads.
> > > 
> > > Meanwhile my grep agains xfs shows:
> > > 
> > > <snip>
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./
> > 
> > You're missing:
> > 
> > fs/xfs/xfs_buf.c:                       bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> > 
> > which i suspect is the majority of Dave's workload.  That will almost
> > certainly take the vb_alloc() path.
> >
> Then it has nothing to do with vmalloc contention(i mean global KVA allocator), IMHO.
> Unless:
> 
> <snip>
> void *vm_map_ram(struct page **pages, unsigned int count, int node)
> {
> 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> 	unsigned long addr;
> 	void *mem;
> 
> 	if (likely(count <= VMAP_MAX_ALLOC)) {
> 		mem = vb_alloc(size, GFP_KERNEL);
> 		if (IS_ERR(mem))
> 			return NULL;
> 		addr = (unsigned long)mem;
> 	} else {
> 		struct vmap_area *va;
> 		va = alloc_vmap_area(size, PAGE_SIZE,
> 				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> 		if (IS_ERR(va))
> 			return NULL;
> <snip>
> 
> number of pages > VMAP_MAX_ALLOC.
> 
> That is why i have asked about workloads because i would like to understand
> where a "problem" is. A vm_map_ram() access the global vmap space but it happens 
> when a new vmap block is required and i also think it is not a problem.
> 
> But who knows, therefore it makes sense to have a lock at workload.
> 
There is a lock-stat statistics for vm_map_ram()/vm_unmap_ram() test.
I did it on 64 CPUs system with running 64 threads doing mapping/unmapping
of 1 page. Each thread does 10 000 000 mapping + unmapping in a loop:

<snip>
root@pc638:/home/urezki# cat /proc/lock_stat
lock_stat version 0.4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

vmap_area_lock:       2554079        2554276           0.06         213.61    11719647.67           4.59        2986513        3005712           0.05          67.02     3573323.37           1.19
  --------------
  vmap_area_lock        1297948          [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
  vmap_area_lock        1256330          [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
  vmap_area_lock              1          [<00000000c95c05a7>] find_vm_area+0x16/0x70
  --------------
  vmap_area_lock        1738590          [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
  vmap_area_lock         815688          [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
  vmap_area_lock              1          [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170

.....................................................................................................................................................................................................

vmap_blocks.xa_lock:        862689         862698           0.05          77.74      849325.39           0.98        3005156        3005709           0.12          31.11     1920242.82           0.64
  -------------------
  vmap_blocks.xa_lock         378418          [<00000000625a5626>] vm_map_ram+0x359/0x4a0
  vmap_blocks.xa_lock         484280          [<00000000caa2ef03>] xa_erase+0xe/0x30
  -------------------
  vmap_blocks.xa_lock         576226          [<00000000caa2ef03>] xa_erase+0xe/0x30
  vmap_blocks.xa_lock         286472          [<00000000625a5626>] vm_map_ram+0x359/0x4a0

....................................................................................................................................................................................................

free_vmap_area_lock:        394960         394961           0.05         124.78      448241.23           1.13        1514508        1515077           0.12          30.48     1179167.01           0.78
  -------------------
  free_vmap_area_lock         385970          [<00000000955bd641>] alloc_vmap_area+0xe5/0x910
  free_vmap_area_lock           4692          [<00000000230abf7e>] __purge_vmap_area_lazy+0x10a/0x7d0
  free_vmap_area_lock           4299          [<00000000eed9ff9e>] alloc_vmap_area+0x497/0x910
  -------------------
  free_vmap_area_lock         371734          [<00000000955bd641>] alloc_vmap_area+0xe5/0x910
  free_vmap_area_lock          17007          [<00000000230abf7e>] __purge_vmap_area_lazy+0x10a/0x7d0
  free_vmap_area_lock           6220          [<00000000eed9ff9e>] alloc_vmap_area+0x497/0x910

.....................................................................................................................................................................................................

purge_vmap_area_lock:        169307         169312           0.05          31.08       81655.21           0.48        1514794        1515078           0.05          67.73      912391.12           0.60
  --------------------
  purge_vmap_area_lock         166409          [<0000000050938075>] free_vmap_area_noflush+0x65/0x370
  purge_vmap_area_lock           2903          [<00000000fb8b57f7>] __purge_vmap_area_lazy+0x47/0x7d0
  --------------------
  purge_vmap_area_lock         167511          [<0000000050938075>] free_vmap_area_noflush+0x65/0x370
  purge_vmap_area_lock           1801          [<00000000fb8b57f7>] __purge_vmap_area_lazy+0x47/0x7d0
<snip>

alloc_vmap_area is a top and second one is xa_lock. But the test i have
done is pretty high concurrent scenario.

--
Uladzislau Rezki
