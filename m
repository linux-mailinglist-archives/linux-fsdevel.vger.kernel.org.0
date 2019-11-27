Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8604E10AB3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 08:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfK0HlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 02:41:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43826 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfK0HlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:41:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id l14so16284447lfh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fvlez50dkLc3ycj12T6MpGIcHBcasKqBK4u/T3P3tA8=;
        b=14RkV+ioZLf9NHRY1e6D34GGuK3RdBfEZZJRKPmO/tjHqg76uGuGsgvzcqPNoe1Rxo
         jOpqwubNKq4WxL50bhsAV4eUCCefHZJs+qxmSaV05/vXGgxbaALGgonXLrib81mGlv1w
         G2KM8csxAubSeg/h4yOO0Z7bQcP8zb9ScGGx6x+Jdm8vbbDP1VioTHy1U3WCFE36rB2U
         404Pz42ptmQi3Bta3H+1bhfOBgk7Fzsj8jeW/X19KBwqkM3Da0EHT6/WU5Tc7yvPdqpC
         nhcbCOVaxihSLyU4LV0X7cLfmKVJSuRX2PVT3+p65f7RVf1Nreh2b/u2tLkygsE2k2zx
         LYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvlez50dkLc3ycj12T6MpGIcHBcasKqBK4u/T3P3tA8=;
        b=g05JSJ6kSXYvoX3LuVbTnDp67KXWkyZFRQUo/aao+Ynnz8e5XFG0r+aq1KnzN+5CEV
         XBY+aek22Zov6qd8A6kuw1+wScH7X+HGJqygGVd0Et31JXVzHLtHbjTvKZ6QyV3gqpm4
         GrdB6TtTPQrw5vj20cpTb/bPcHrFwWECY1FGTb1ODGABoLeM2Xhk0jK4bPOoWVQmmX7H
         MQxFPeJ8VVG1Gtb2lzTYcPBBiwtdggYrYlQL5uCGsuhdr04yBtb++rPSWf2J6ZQ31fwT
         1q5qvQ1fcp2RYjbLeva2wMR8cnHzlc3f7jSRG5ABm9Zpc8q9ddZQpy+E8HzqV2VEHPaV
         zTAQ==
X-Gm-Message-State: APjAAAWJniunPszHC6bTt8667Lr0Wwnf5jWPATpWxHQRaH09z7SPMa4c
        3EwzLvbUpix3idu815iXFsP9GTFtmyVxpc7H/H0=
X-Google-Smtp-Source: APXvYqzZd1w8eXl2HmBm1Lx6joX3Pi8mHUFHepMR1vu3mTBmNdqnQY5kRDDK+XY6DyFio3WFXVvP7w==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr21940056lfh.12.1574840460448;
        Tue, 26 Nov 2019 23:41:00 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id k9sm6438058lfj.97.2019.11.26.23.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 23:40:59 -0800 (PST)
Message-ID: <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Daniel Phillips <daniel@phunq.net>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date:   Wed, 27 Nov 2019 10:40:59 +0300
In-Reply-To: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-11-26 at 17:47 -0800, Daniel Phillips wrote:
> Hi folks,
> 
> Here is my somewhat tardy followup to my Three Things post from
> earlier
> this fall. I give you Thing 1, Shardmap. What I hope to accomplish
> today
> is to initiate a conversation with Ext4 developers, and other
> interested
> observers, which will eventually result in merging the new Shardmap
> directory index code into Ext4, thereby solving a number of
> longstanding
> issues with the venerable and somewhat problematic HTree.
> 
> HTree is the most used directory index in the known universe. HTree
> does
> some things fantastically well, particularly in the most common range
> of
> directory sizes, but also exhibits some well known flaws and at least
> one
> previously unknown flaw, explained below. Shardmap is a new index
> design,
> just seven years old, an O(1) extensible hash table, meant to address
> all
> of HTree's flaws while improving performance and scaling into the
> previously inaccessible billion file per directory range. Subject to
> verifying these claims, it would seem to be logical to move on to the
> logistics of porting Shardmap to Ext4 as an optional index algorithm,
> eventually deprecating HTree.
> 


As far as I know, usually, a folder contains dozens or hundreds
files/folders in average. There are many research works that had showed
this fact. Do you mean some special use-case when folder could contain
the billion files? Could you share some research work that describes
some practical use-case with billion files per folder?

If you are talking about improving the performance then do you mean
some special open-source implementation?


> Shardmap equals or outperforms HTree at all scales, with the single
> exception of one theoretical case with a likewise theoretical
> solution.
> Shardmap is O(1) in all operations - insert, delete, lookup and
> readdir,
> while HTree is O(log N) in the first three and suffers from a
> relatively
> large constant readdir overhead. This is not the only reason Shardmap
> is
> faster than HTree, far from it.
> 
> I will break performance discussion down into four ranges:
>    1) unindexed single block, to about 300 entries
>    2) indexed up to 30 thousand entries
>    3) indexed up to 3 million entries
>    4) indexed up to 1 billion entries.
> 
> In theory, Shardmap and HTree are exactly tied in the common single
> block case, because creating the index is delayed in both cases until
> there are at least two blocks to index. However, Shardmap broke away
> from the traditional Ext2 entry block format in order to improve
> block
> level operation efficiency and to prevent record fragmentation under
> heavy aging, and is therefore significantly faster than HTree even in
> the single block case.
> 
> Shardmap does not function at all in the fourth range, up to 1
> billion
> entries, because its Btree has at most 2 levels. This simple flaw
> could be
> corrected without much difficulty but Shardmap would remain superior
> for
> a number of reasons.
> 
> The most interesting case is the 300 to 30 thousand entry range,
> where
> Htree and Shardmap should theoretically be nearly equal, each
> requiring
> two accesses per lookup. However, HTree does two radix tree lookups
> while
> Shardmap does one, and the other lookup is in a cached memory object.
> Coupled with the faster record level operations, Shardmap is
> significantly
> faster in this range. In the 30 thousand to 3 million range,
> Shardmap's
> performance advantage further widens in accordance with O(1) / O(log
> N).
> 
> For inserts, Shardmap's streaming update strategy is far superior to
> HTree's random index block write approach. HTree will tend to dirty
> every
> index block under heavy insert load, so that every index block must
> be
> written to media per commit, causing serious write multiplication
> issues. In fact, all Btree schemes suffer from this issue, which on
> the
> face of it appears to be enough reason to eliminate the Btree as a
> realistic design alternative. Shardmap dramatically reduces such per
> commit write multiplication by appending new index entries linearly
> to
> the tail blocks of a small number of index shards. For delete,
> Shardmap avoids write multiplication by appending tombstone entries
> to
> index shards, thereby addressing a well known HTree delete
> performance
> issue.


Do you mean Copy-On-Write policy here or some special technique? How
could be good Shardmap for the SSD use-case? Do you mean that we could
reduce write amplification issue for NAND flash case?


> 
> HTree has always suffered from a serious mismatch between name
> storage
> order and inode storage order, greatly exacerbated by the large
> number
> of directory entries and inodes stored per block (false sharing). In
> particular, a typical HTree hash order directory traversal accesses
> the
> inode table randomly, multiplying both the cache footprint and write
> traffic. Historically, this was the cause of many performance
> complaints
> about HTree, though to be sure, such complaints have fallen off with
> the advent of solid state storage. Even so, this issue will continue
> rear
> its ugly head when users push the boundaries of cache and directory
> size
> (google telldir+horror). Shardmap avoids this issue entirely by
> storing
> and traversing directory entries in simple, classic linear order.
> 
> This touches on the single most significant difference between
> Shardmap
> and HTree: Shardmap strictly separates its index from record entry
> blocks,
> while HTree embeds entries directly in the BTree index. The HTree
> strategy performs impressively well at low to medium directory
> scales,
> but at higher scales it causes significantly more cache pressure, due
> to
> the fact that the cache footprint of any randomly accessed index is
> necessarily the entire index. In contrast, Shardmap stores directory
> entries permanently in creation order, so that directory traversal is
> in simple linear order with effectively zero overhead. This avoids
> perhaps HTree's most dubious design feature, its arcane and not
> completely
> reliable hash order readdir traversal, which miraculously has avoided
> serious meltdown over these past two decades due to a legendary hack
> by
> Ted and subsequent careful adaptation to handle various corner cases.
> Nowhere in Shardmap will you find any such arcane and marginally
> supportable code, which should be a great relief to Ext4 maintainers.
> Or to put it another way, if somebody out there wishes to export a
> billion file directory using NFSv2, Shardmap will not be the reason
> why that does not work whereas HTree most probably would be.
> 
> Besides separating out the index from entry records and accessing
> those
> records linearly in most situations, Shardmap also benefits from a
> very
> compact index design. Even if a directory has a billion entries, each
> index entry is only eight bytes in size. This exercise in structure
> compaction proved possible because the number of hash bits needed for
> the
> hash code decreases as the number of index shards increases, freeing
> up
> bits for larger block numbers as the directory expands. Shardmap
> therefore implements an index entry as several variable sized fields.
> This strategy works well up to the billion entry range, above which
> the
> number of hash index collisions (each of which must be resolved by
> accessing an underlying record block) starts to increase noticeably.
> This is really the only factor that limits Shardmap performance above
> a billion entries. Should we wish Shardmap to scale to trillions of
> entries without losing performance, we will need to increase the
> index
> entry size to ten bytes or so, or come up with some as yet unknown
> clever improvement (potential thesis project goes here).
> 
> There are many additional technical details of Shardmap that ought to
> be
> explained, however today my primary purpose is simply to introduce
> what
> I view as a compelling case for obsoleting HTree. To that end, fewer
> words are better and this post is already quite long enough. I would
> love
> to get into some other interesting details, for example, the Bigmap
> free
> space mapping strategy, but that really needs its own post to do it
> justice, as do a number of other subjects.
> 
> Wrapping up, what about that theoretical case where HTree outperforms
> Shardmap? This is theoretical because one needs to operate on a huge
> directory with tiny cache to trigger it. Both Shardmap and HTree will
> exhibit read multiplication under such conditions, due to frequent
> cache evictions, however the Shardmap read multiplication will be
> many
> times higher than HTree because of its coarser cache granularity. In
> the
> unlikely event that we ever need to fix this, one viable solution is
> to
> add paging support for Shardmap's in-memory cache structure, a
> standard
> technique sometimes called "anticache".
> 
> That is it for today. There remains much to explain about Shardmap
> both
> within and beyond the Ext4 context. For example, Shardmap has proved
> to
> work very well as a standalone key value store, particularly with
> persistent memory. In fact, we have benchmarked Shardmap at over
> three
> million atomic, durable database operations per second on an Intel
> Optane server, which might well be a new world record. The details of
> how this was done are fascinating, however this post is far too small
> to
> contain them today. Perhaps this should be thing 1(b) for next week.
> 


Let's imagine that it needs to implement the Shardmap approach. Could
you estimate the implementation and stabilization time? How expensive
and long-term efforts could it be?

Thanks,
Viacheslav Dubeyko.


