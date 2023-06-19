Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33982735C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFSQ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 12:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjFSQz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:55:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7C10CF;
        Mon, 19 Jun 2023 09:55:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66767d628e2so838571b3a.2;
        Mon, 19 Jun 2023 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687193749; x=1689785749;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxDIao8zntmXEA6FKw+kDSMi6WO9785iPyhmkdhUvII=;
        b=eCl/ah1Yjec+yhpgBnhuEUCZk8+JWvRkQtkOaQ26hc0TN3cx9XSULuJjtY9sDJJTpw
         QfjP0JoY7Tktii3UexG9OVuYrcQgJFfamAIVfZNOUQZv7QSYdQp4pS8PduIa5HUmj6mS
         IlT4m5Aj/jXs/1CrwItKVH14ZPE6r+qzHGaJNMuvuzluSh32dWSNU5+J/ottiQdr1L6N
         Y0EtC1lIlQHGh0uTgEYDx4g/HboP3FXoBWkYzrHjJaPrFgPwmi2UIGFmBmEWrdQvothO
         vTAyZVBBxeKCjHI+q++6AgJSsVsNSzU8vlDrxcCp1IDmBOtZDrM5S3k1iLFZzIAbFfPi
         SqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193749; x=1689785749;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxDIao8zntmXEA6FKw+kDSMi6WO9785iPyhmkdhUvII=;
        b=E/HjsbQnfWQ4+sGITrixNgTecH8Kq9KRR6CrROldFU/d1H4BxBo22+AjeRaH1LKxG4
         x0GZYqgWIcV+8VRtbllLc75BcoD6qZpk0WN5hNeKebT0I0AoHOP4HFXMZrpxCxhxsqOH
         ZavwBw3VaCcOxllFHBISCzmYsAtH5Smi9sXUayGyxT8z3435jHY4YtNf0PcIXRwvQJML
         VM7CqAglM9ZZGKGH+WS6KPUF/AXE/LVSSqhYPv82QBsxZu6MT7d0+M8QZmlrVbuI7J4Y
         yMEKNSr9cU6QbDm6qmNZ3C3LmWl2zRn9bcYmTRHVFqVm4QSEw+4mTVbZyED0GUaX3wiE
         7Vkw==
X-Gm-Message-State: AC+VfDyLSjA/ec64IaHKY+qfJxozNPHC9y+sMHEfp/MNajXqoOoPDsZ5
        g2it6mvJnQOxAFiLgdwSmcw=
X-Google-Smtp-Source: ACHHUZ66yOJXO5JzQ/P7ZESVDMB8EOCTALKqz92SHdY2Ck4y0/91k0PGEdRfPUukjLBbOsEOtkBAYQ==
X-Received: by 2002:a05:6a21:9983:b0:121:bf66:a715 with SMTP id ve3-20020a056a21998300b00121bf66a715mr2268068pzb.45.1687193749392;
        Mon, 19 Jun 2023 09:55:49 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b00668821499c3sm1461950pfn.156.2023.06.19.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:48 -0700 (PDT)
Date:   Mon, 19 Jun 2023 22:25:44 +0530
Message-Id: <87legfmlwv.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <CAHc6FU70U9HXe3=THWO6K5uzvz7c0BH38K0GytUbZdgiXMfh+Q@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> On Mon, Jun 19, 2023 at 4:29 AM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
>> When filesystem blocksize is less than folio size (either with
>> mapping_large_folio_support() or with blocksize < pagesize) and when the
>> folio is uptodate in pagecache, then even a byte write can cause
>> an entire folio to be written to disk during writeback. This happens
>> because we currently don't have a mechanism to track per-block dirty
>> state within struct iomap_folio_state. We currently only track uptodate
>> state.
>>
>> This patch implements support for tracking per-block dirty state in
>> iomap_folio_state->state bitmap. This should help improve the filesystem
>> write performance and help reduce write amplification.
>>
>> Performance testing of below fio workload reveals ~16x performance
>> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
>> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>>
>> 1. <test_randwrite.fio>
>> [global]
>>         ioengine=psync
>>         rw=randwrite
>>         overwrite=1
>>         pre_read=1
>>         direct=0
>>         bs=4k
>>         size=1G
>>         dir=./
>>         numjobs=8
>>         fdatasync=1
>>         runtime=60
>>         iodepth=64
>>         group_reporting=1
>>
>> [fio-run]
>>
>> 2. Also our internal performance team reported that this patch improves
>>    their database workload performance by around ~83% (with XFS on Power)
>>
>> Reported-by: Aravinda Herle <araherle@in.ibm.com>
>> Reported-by: Brian Foster <bfoster@redhat.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/gfs2/aops.c         |   2 +-
>>  fs/iomap/buffered-io.c | 189 ++++++++++++++++++++++++++++++++++++-----
>>  fs/xfs/xfs_aops.c      |   2 +-
>>  fs/zonefs/file.c       |   2 +-
>>  include/linux/iomap.h  |   1 +
>>  5 files changed, 171 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
>> index a5f4be6b9213..75efec3c3b71 100644
>> --- a/fs/gfs2/aops.c
>> +++ b/fs/gfs2/aops.c
>> @@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
>>         .writepages = gfs2_writepages,
>>         .read_folio = gfs2_read_folio,
>>         .readahead = gfs2_readahead,
>> -       .dirty_folio = filemap_dirty_folio,
>> +       .dirty_folio = iomap_dirty_folio,
>>         .release_folio = iomap_release_folio,
>>         .invalidate_folio = iomap_invalidate_folio,
>>         .bmap = gfs2_bmap,
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 391d918ddd22..50f5840bb5f9 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -25,7 +25,7 @@
>>
>>  typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
>>  /*
>> - * Structure allocated for each folio to track per-block uptodate state
>> + * Structure allocated for each folio to track per-block uptodate, dirty state
>>   * and I/O completions.
>>   */
>>  struct iomap_folio_state {
>> @@ -35,31 +35,55 @@ struct iomap_folio_state {
>>         unsigned long           state[];
>>  };
>>
>> +enum iomap_block_state {
>> +       IOMAP_ST_UPTODATE,
>> +       IOMAP_ST_DIRTY,
>> +
>> +       IOMAP_ST_MAX,
>> +};
>> +
>> +static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
>> +               enum iomap_block_state state, unsigned int *first_blkp,
>> +               unsigned int *nr_blksp)
>> +{
>> +       struct inode *inode = folio->mapping->host;
>> +       unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +       unsigned int first = off >> inode->i_blkbits;
>> +       unsigned int last = (off + len - 1) >> inode->i_blkbits;
>> +
>> +       *first_blkp = first + (state * blks_per_folio);
>> +       *nr_blksp = last - first + 1;
>> +}
>> +
>>  static struct bio_set iomap_ioend_bioset;
>>
>>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>>                                                struct iomap_folio_state *ifs)
>>  {
>>         struct inode *inode = folio->mapping->host;
>> +       unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +       unsigned int nr_blks = (IOMAP_ST_UPTODATE + 1) * blks_per_folio;
>
> This nr_blks calculation doesn't make sense.
>

About this, I have replied with more details here [1]

[1]: https://lore.kernel.org/linux-xfs/87o7lbmnam.fsf@doe.com/


>> -       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>> +       return bitmap_full(ifs->state, nr_blks);
>
> Could you please change this to:
>
> BUILD_BUG_ON(IOMAP_ST_UPTODATE != 0);

ditto

> return bitmap_full(ifs->state, blks_per_folio);
>
> Also, I'm seeing that the value of i_blocks_per_folio() is assigned to
> local variables with various names in several places (blks_per_folio,
> nr_blocks, nblocks). Maybe this could be made consistent.
>

I remember giving it a try, but then it was really not worth it because
all of above naming also does make sense in the way they are getting
used currently in the code. So, I think as long as it is clear behind
what those variables means and how are they getting used, it should be
ok, IMO. 

-ritesh

