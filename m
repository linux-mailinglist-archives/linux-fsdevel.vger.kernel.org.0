Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959A6C0E02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCTKCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCTKCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:02:41 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F823331;
        Mon, 20 Mar 2023 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679306535; i=@fujitsu.com;
        bh=JQVuSNZFthB5eaa2uExzHRckw2C1GiZyyqaJs7XqeF0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=vXbSXxVbvSiEcK+ermKWu1Xm0Ifs6FvrbasrZQ6jMUaTtJbYg9kIUWJ6loAwvqtN0
         kzNWoHhDp8j7bOtgIEKjW5TNF7e09d1a01zP7LddK94ppKLcc3DGqsSMVesjWgIzId
         fKVdtkSxGt0Auw20pOnYM8LA9ack8+ITvT8GgyIJN/HM1vOIvqtKheymw8LoGyGM8w
         RtrJdn2ORqjQPRRs5EOYUaU5bpkmMMXw1cmwA5irIDCgAl5I7gfU9mb6kSY3vh946l
         m9vhJg1oGuJebg81d5WhxXP1jPz6p+1GgolBEjo4JJK4DgX9BrS0uxfiMOEdw/n0ME
         u7vVfff1Gyk5g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsViZ8ORqKuuL5F
  iMP0mt8Wc9WvYLKZPvcBoseXYPUaLy0/4LPbsPclicXnXHDaLXX92sFus/PGH1YHD49QiCY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnp83iQXwBbFmpmXlF+RwJrx+lw/a8EMm4pjbV8YGxhvGHQxc
  nIICWxhlFizQLuLkQvIXs4k8erEbHYIZxujROusuSxdjBwcvAJ2Ej9ni4E0sAioSvQ29DGC2L
  wCghInZz5hAbFFBZIljp1vZQMpFxaIl3h9yBwkLCKgKXHk2zUmkJHMAmcZJY5uPsQEsThPYtv
  C/WC9bAI6EhcW/GUFsTkFTCUmzZzABmIzC1hILH5zkB3Clpdo3jqbGcSWEFCSuPj1DiuEXSHR
  OB1ipoSAmsTVc5uYJzAKzUJy3iwko2YhGbWAkXkVo1lxalFZapGuoYVeUlFmekZJbmJmjl5il
  W6iXmqpbnlqcYmukV5iebFeanGxXnFlbnJOil5easkmRmB0pRQrf9jBuLTvr94hRkkOJiVR3u
  NvxFOE+JLyUyozEosz4otKc1KLDzHKcHAoSfBy60ikCAkWpaanVqRl5gAjHSYtwcGjJMIrIgG
  U5i0uSMwtzkyHSJ1iNOZY23BgLzPHxz8X9zILseTl56VKifM+AZkkAFKaUZoHNwiWgC4xykoJ
  8zIyMDAI8RSkFuVmlqDKv2IU52BUEuadCDKFJzOvBG7fK6BTmIBOuT9JBOSUkkSElFQDU7pyS
  +kJNfXIyqLE65MTr78+dEK/tfHf0pOhB9cbtuTue9vXzpny/Ez45Tf+TjvURcM+Xe0OLK+wqF
  uWfyxvc0lTTXH3dc7NcsEL/qmtdfwQMe/WFA3PJ8a/OkvCM5YEy2zY/y3i2TWbStt1BuuSa73
  61m9LcU0xzdsW+C9+4/ErU47tNJzP9Kg9utNnMZ/19C8CMgZ+fr6sXY8iGnjfxyU8uPPbaPUL
  57+y5/kYmJvS183ZfiSdp4z95qVG38WRmXkzE3bpuq3aOIU3atlmrg8H8v5fbHq2Ue79mew9D
  v4lz019xfJMPxtcMmC+2G7IbPu+6tzFMtufYitlwgoLTupJXii7Nt1y86PJt9YUKLEUZyQaaj
  EXFScCAKng5Tu7AwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-571.messagelabs.com!1679306534!507999!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4954 invoked from network); 20 Mar 2023 10:02:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-13.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Mar 2023 10:02:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C416B1001A3;
        Mon, 20 Mar 2023 10:02:14 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B703A100043;
        Mon, 20 Mar 2023 10:02:14 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Mar 2023 10:02:11 +0000
Message-ID: <011cd163-4e6b-40b9-beeb-7fbc55b3a369@fujitsu.com>
Date:   Mon, 20 Mar 2023 18:02:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] xfs: check shared state of when CoW, update reflink
 flag when io ends
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <david@fromorbit.com>, <dan.j.williams@intel.com>,
        <akpm@linux-foundation.org>
References: <1679025588-21-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230317203505.GK11394@frogsfrogsfrogs>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230317203505.GK11394@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/18 4:35, Darrick J. Wong 写道:
> On Fri, Mar 17, 2023 at 03:59:48AM +0000, Shiyang Ruan wrote:
>> As is mentioned[1] before, the generic/388 will randomly fail with dmesg
>> warning.  This case uses fsstress with a lot of random operations.  It is hard
>> to  reproduce.  Finally I found a 100% reproduce condition, which is setting
>> the seed to 1677104360.  So I changed the generic/388 code: removed the loop
>> and used the code below instad:
>> ```
>> ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
>> ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
>> _check_dmesg_for dax_insert_entry
>> ```
>>
>> According to the operations log, and kernel debug log I added, I found that
>> the reflink flag of one inode won't be unset even if there's no more shared
>> extents any more.
>>    Then write to this file again.  Because of the reflink flag, xfs thinks it
>>      needs cow, and extent(called it extA) will be CoWed to a new
>>      extent(called it extB) incorrectly.  And extA is not used any more,
>>      but didn't be unmapped (didn't do dax_disassociate_entry()).
> 
> IOWs, dax_iomap_copy_around (or something very near it) should be
> calling dax_disassociate_entry on the source range after copying extA's
> contents to extB to drop its page->shared count?

If extA is a shared extent, its pages will be disassociated correctly by 
invalidate_inode_pages2_range() in dax_iomap_iter().

But the problem is that extA is not shared but now be CoWed, 
invalidate_inode_pages2_range() is also called but it can't disassociate 
the old page (because the page is marked dirty, can't be invalidated)

Is the behavior to do CoW on a non-shared extent allowed?

> 
>>    The next time we mapwrite to another file, xfs will allocate extA for it,
>>      page fault handler do dax_associate_entry().  BUT bucause the extA didn't
>>      be unmapped, it still stores old file's info in page->mapping,->index.
>>      Then, It reports dmesg warning when it try to sotre the new file's info.
>>
>> So, I think:
>>    1. reflink flag should be updated after CoW operations.
>>    2. xfs_reflink_allocate_cow() should add "if extent is shared" to determine
>>       xfs do CoW or not.
>>
>> I made the fix patch, it can resolve the fail of generic/388.  But it causes
>> other cases fail: generic/127, generic/263, generic/616, xfs/315 xfs/421. I'm
>> not sure if the fix is right, or I have missed something somewhere.  Please
>> give me some advice.
>>
>> Thank you very much!!
>>
>> [1]: https://lore.kernel.org/linux-xfs/1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   fs/xfs/xfs_reflink.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_reflink.h |  2 ++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index f5dc46ce9803..a6b07f5c1db2 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -154,6 +154,40 @@ xfs_reflink_find_shared(
>>   	return error;
>>   }
>>   
>> +int xfs_reflink_extent_is_shared(
>> +	struct xfs_inode	*ip,
>> +	struct xfs_bmbt_irec	*irec,
>> +	bool			*shared)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_perag	*pag;
>> +	xfs_agblock_t		agbno;
>> +	xfs_extlen_t		aglen;
>> +	xfs_agblock_t		fbno;
>> +	xfs_extlen_t		flen;
>> +	int			error = 0;
>> +
>> +	*shared = false;
>> +
>> +	/* Holes, unwritten, and delalloc extents cannot be shared */
>> +	if (!xfs_bmap_is_written_extent(irec))
>> +		return 0;
>> +
>> +	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, irec->br_startblock));
>> +	agbno = XFS_FSB_TO_AGBNO(mp, irec->br_startblock);
>> +	aglen = irec->br_blockcount;
>> +	error = xfs_reflink_find_shared(pag, NULL, agbno, aglen, &fbno, &flen,
>> +			true);
>> +	xfs_perag_put(pag);
>> +	if (error)
>> +		return error;
>> +
>> +	if (fbno != NULLAGBLOCK)
>> +		*shared = true;
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Trim the mapping to the next block where there's a change in the
>>    * shared/unshared status.  More specifically, this means that we
>> @@ -533,6 +567,12 @@ xfs_reflink_allocate_cow(
>>   		xfs_ifork_init_cow(ip);
>>   	}
>>   
>> +	error = xfs_reflink_extent_is_shared(ip, imap, shared);
>> +	if (error)
>> +		return error;
>> +	if (!*shared)
>> +		return 0;
>> +
>>   	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>>   	if (error || !*shared)
>>   		return error;
>> @@ -834,6 +874,10 @@ xfs_reflink_end_cow_extent(
>>   	/* Remove the mapping from the CoW fork. */
>>   	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
>>   
>> +	error = xfs_reflink_clear_inode_flag(ip, &tp);
> 
> This will disable COW on /all/ blocks in the entire file, including the
> shared ones.  At a bare minimum you'd have to scan the entire data fork
> to ensure there are no shared extents.  That's probably why doing this
> causes so many new regressions.

This function will search for shared extent before actually clearing the 
flag.  If no shared extent found, the flag won't be cleared.  The name 
of this function is not very accurate.

BTW, in my thought, the reflink flag is to indicate if a file is now 
containing any shared extents or not.  So, it should be cleared 
immediately if no extents shared any more.  Is this right?



--
Thanks,
Ruan.

PS: Let me paste the log of failed tests:
generic/127, generic/263, generic/616 are fsx tests.  Their fail message 
are meaningless.  I am looking into their difference between good/bad 
results.

xfs/315 0s ... - output mismatch (see 
/root/xts/results//dax_reflink/xfs/315.out.bad)
     --- tests/xfs/315.out       2022-08-03 10:56:02.696212673 +0800
     +++ /root/xts/results//dax_reflink/xfs/315.out.bad  2023-03-20 
17:48:01.780369739 +0800
     @@ -7,7 +7,6 @@
      Inject error
      CoW a few blocks
      FS should be shut down, touch will fail
     -touch: cannot touch 'SCRATCH_MNT/badfs': Input/output error
      Remount to replay log
      FS should be online, touch should succeed
      Check files again
     ...
     (Run 'diff -u /root/xts/tests/xfs/315.out 
/root/xts/results//dax_reflink/xfs/315.out.bad'  to see the entire diff)
xfs/421 1s ... - output mismatch (see 
/root/xts/results//dax_reflink/xfs/421.out.bad)
     --- tests/xfs/421.out       2022-08-03 10:56:02.706212718 +0800
     +++ /root/xts/results//dax_reflink/xfs/421.out.bad  2023-03-20 
17:48:02.222369739 +0800
     @@ -14,8 +14,6 @@
      Whence     Result
      DATA       0
      HOLE       131072
     -DATA       196608
     -HOLE       262144
      Compare files
      c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-421/file1
     ...
     (Run 'diff -u /root/xts/tests/xfs/421.out 
/root/xts/results//dax_reflink/xfs/421.out.bad'  to see the entire diff)

> 
> --D
> 
>> +	if (error)
>> +		goto out_cancel;
>> +
>>   	error = xfs_trans_commit(tp);
>>   	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>>   	if (error)
>> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
>> index 65c5dfe17ecf..d5835814bce6 100644
>> --- a/fs/xfs/xfs_reflink.h
>> +++ b/fs/xfs/xfs_reflink.h
>> @@ -16,6 +16,8 @@ static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
>>   	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
>>   }
>>   
>> +int xfs_reflink_extent_is_shared(struct xfs_inode *ip,
>> +		struct xfs_bmbt_irec *irec, bool *shared);
>>   extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
>>   		struct xfs_bmbt_irec *irec, bool *shared);
>>   int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>> -- 
>> 2.39.2
>>
