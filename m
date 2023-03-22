Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43586C4786
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCVKYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 06:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVKYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:24:46 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B64345B;
        Wed, 22 Mar 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679480682; i=@fujitsu.com;
        bh=Nhz8yw4hujGQqI1pQHVR8h0qElshoZ06SFGPRu/sOIo=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ZrLJlMAkxqoS6JjpsdoJXSSca1u1VzV/9OkaMrcFoiIWPUQzvPMV1DU9xJygmQ1J/
         h0yO0M+0gqWWy7ZOm8BFgF3Y9pJXAbT0msTJ9wveJJ4x+2tsDAgi2gBxRlLgD4sdSJ
         77kknEidYsvdLBmbt5aEKV2sE80lMUFDBf4hokbgoqla3kU68e1jKjiZktE6SWqDz+
         fRYBvy5sdk9olLfe4jKmAAFA6RAZpaPek6qNUxJNc0HvmokG02hVswbzg2lVJeos5O
         zwmFaIPk0SYXsgqPK6BdXEiP569ESQesDNCZu9m2KuHy4EhQi21vyI5DBK6GZtPnTY
         oo2ikNjEANong==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRWlGSWpSXmKPExsViZ8MxSTfzulS
  KwfKl8hZz1q9hs5g+9QKjxZZj9xgtLj/hs9iz9ySLxeVdc9gsdv3ZwW6x8scfVgcOj1OLJDwW
  73nJ5LFpVSebx4kZv1k8XmyeyejxeZNcAFsUa2ZeUn5FAmvG5+//2AvOelcsPziXqYFxvm0XI
  xeHkMAWRonGHe9ZIJzlTBJ/7nYwQzjbGCW6DzazdTFycvAK2Ems2buMEcRmEVCV2PN7MRNEXF
  Di5MwnLCC2qECyxLHzrUD1HBzCAvESrw+Zg4RFBDQljny7xgQyk1ngLKPE0c2HmCAWnGGUWH1
  mFztIFZuAjsSFBX9ZQWxOAVOJFYvPgMWZBSwkFr85CGXLSzRvnc0MYksIKElc/HqHFcKukGic
  fogJwlaTuHpuE/MERqFZSO6bhWTULCSjFjAyr2I0LU4tKkst0rXQSyrKTM8oyU3MzNFLrNJN1
  Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMsJRi1jc7GLf1/dU7xCjJwaQkyvv7gl
  SKEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneCZeAcoJFqempFWmZOcBoh0lLcPAoifDeBGnlLS5
  IzC3OTIdInWI05ljbcGAvM8fHPxf3Mgux5OXnpUqJ8ypfAyoVACnNKM2DGwRLQpcYZaWEeRkZ
  GBiEeApSi3IzS1DlXzGKczAqCfMKgNzDk5lXArfvFdApTECnxM2QADmlJBEhJdXAFH18QmLf/
  f6/laIlQX0qd5a+mcj6rD/M9YuuHa+VTLXPcos74heD3gW2GpdvVpSofKkofmRPil/R9pyWZY
  5fbZ42SKtzW204lW219e/MGidF0QcFTYcPc2reC6xwyn9iPl9QeHqS8alkk+NMoZaHOCVUdpR
  87Jivf/ZBd9P3MM65j1auYVJdlvPNuurAP5G8t23ns5bNPe7k+zrm1rmA4D0XXuzY9/IPw+e8
  YwL8a7y5VnC5mM44XlK0b46L/YbCRlGZoPqzvT+YFnFFffiWqCx6npFjr7/aFgYnA1uVtZPXX
  52bztOkf941MW/TRplfTDobWXLsuiO5Hq2OPVQ5keX3Tp7PdUxz3r7WeHhLiaU4I9FQi7moOB
  EA4flwAb0DAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-585.messagelabs.com!1679480681!103712!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21402 invoked from network); 22 Mar 2023 10:24:41 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-15.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Mar 2023 10:24:41 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1033B1000DC;
        Wed, 22 Mar 2023 10:24:41 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 027D01000DB;
        Wed, 22 Mar 2023 10:24:41 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 22 Mar 2023 10:24:37 +0000
Message-ID: <32c14f43-0d70-9ede-2710-b6cb4a3e7298@fujitsu.com>
Date:   Wed, 22 Mar 2023 18:24:31 +0800
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
 <011cd163-4e6b-40b9-beeb-7fbc55b3a369@fujitsu.com>
 <20230321151339.GA11376@frogsfrogsfrogs>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230321151339.GA11376@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/21 23:13, Darrick J. Wong 写道:
> On Mon, Mar 20, 2023 at 06:02:05PM +0800, Shiyang Ruan wrote:
>>
>>
>> 在 2023/3/18 4:35, Darrick J. Wong 写道:
>>> On Fri, Mar 17, 2023 at 03:59:48AM +0000, Shiyang Ruan wrote:
>>>> As is mentioned[1] before, the generic/388 will randomly fail with dmesg
>>>> warning.  This case uses fsstress with a lot of random operations.  It is hard
>>>> to  reproduce.  Finally I found a 100% reproduce condition, which is setting
>>>> the seed to 1677104360.  So I changed the generic/388 code: removed the loop
>>>> and used the code below instad:
>>>> ```
>>>> ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
>>>> ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
>>>> _check_dmesg_for dax_insert_entry
>>>> ```
>>>>
>>>> According to the operations log, and kernel debug log I added, I found that
>>>> the reflink flag of one inode won't be unset even if there's no more shared
>>>> extents any more.
>>>>     Then write to this file again.  Because of the reflink flag, xfs thinks it
>>>>       needs cow, and extent(called it extA) will be CoWed to a new
>>>>       extent(called it extB) incorrectly.  And extA is not used any more,
>>>>       but didn't be unmapped (didn't do dax_disassociate_entry()).
>>>
>>> IOWs, dax_iomap_copy_around (or something very near it) should be
>>> calling dax_disassociate_entry on the source range after copying extA's
>>> contents to extB to drop its page->shared count?
>>
>> If extA is a shared extent, its pages will be disassociated correctly by
>> invalidate_inode_pages2_range() in dax_iomap_iter().
>>
>> But the problem is that extA is not shared but now be CoWed,
> 
> Aha!  Ok, I hadn't realized that extA is not shared...
> 
>> invalidate_inode_pages2_range() is also called but it can't disassociate the
>> old page (because the page is marked dirty, can't be invalidated)
> 
> ...so what marked the old page dirty?   Was it the case that the
> unshared extA got marked dirty, then later someone created a cow
> reservation (extB, I guess) that covered the already dirty extA?
> 
> Should we be transferring the dirty state from A to B here before the
> invalidate_inode_pages2_range ?
> 
>> Is the behavior to do CoW on a non-shared extent allowed?
> 
> In general, yes, XFS allows COW on non-shared extents.  The (cow) extent
> size hint provides for cowing the unshared blocks adjacent to a shared
> block to try to combat fragmentation.

Ok, I did't realize its benifit.  Thanks a lot.

Now I've fixed it based on your suggestion and it works.  The failed 
cases all passed.  Now I'm running the generic/388 for many and many 
times to make sure it doesn't fail again.  I'll send the patch if the 
generic/388 is passed.

> 
>>>
>>>>     The next time we mapwrite to another file, xfs will allocate extA for it,
>>>>       page fault handler do dax_associate_entry().  BUT bucause the extA didn't
>>>>       be unmapped, it still stores old file's info in page->mapping,->index.
>>>>       Then, It reports dmesg warning when it try to sotre the new file's info.
>>>>
>>>> So, I think:
>>>>     1. reflink flag should be updated after CoW operations.
>>>>     2. xfs_reflink_allocate_cow() should add "if extent is shared" to determine
>>>>        xfs do CoW or not.
>>>>
>>>> I made the fix patch, it can resolve the fail of generic/388.  But it causes
>>>> other cases fail: generic/127, generic/263, generic/616, xfs/315 xfs/421. I'm
>>>> not sure if the fix is right, or I have missed something somewhere.  Please
>>>> give me some advice.
>>>>
>>>> Thank you very much!!
>>>>
>>>> [1]: https://lore.kernel.org/linux-xfs/1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com/
>>>>
>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>> ---
>>>>    fs/xfs/xfs_reflink.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    fs/xfs/xfs_reflink.h |  2 ++
>>>>    2 files changed, 46 insertions(+)
>>>>
>>>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>>>> index f5dc46ce9803..a6b07f5c1db2 100644
>>>> --- a/fs/xfs/xfs_reflink.c
>>>> +++ b/fs/xfs/xfs_reflink.c
>>>> @@ -154,6 +154,40 @@ xfs_reflink_find_shared(
>>>>    	return error;
>>>>    }
>>>> +int xfs_reflink_extent_is_shared(
>>>> +	struct xfs_inode	*ip,
>>>> +	struct xfs_bmbt_irec	*irec,
>>>> +	bool			*shared)
>>>> +{
>>>> +	struct xfs_mount	*mp = ip->i_mount;
>>>> +	struct xfs_perag	*pag;
>>>> +	xfs_agblock_t		agbno;
>>>> +	xfs_extlen_t		aglen;
>>>> +	xfs_agblock_t		fbno;
>>>> +	xfs_extlen_t		flen;
>>>> +	int			error = 0;
>>>> +
>>>> +	*shared = false;
>>>> +
>>>> +	/* Holes, unwritten, and delalloc extents cannot be shared */
>>>> +	if (!xfs_bmap_is_written_extent(irec))
>>>> +		return 0;
>>>> +
>>>> +	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, irec->br_startblock));
>>>> +	agbno = XFS_FSB_TO_AGBNO(mp, irec->br_startblock);
>>>> +	aglen = irec->br_blockcount;
>>>> +	error = xfs_reflink_find_shared(pag, NULL, agbno, aglen, &fbno, &flen,
>>>> +			true);
>>>> +	xfs_perag_put(pag);
>>>> +	if (error)
>>>> +		return error;
>>>> +
>>>> +	if (fbno != NULLAGBLOCK)
>>>> +		*shared = true;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /*
>>>>     * Trim the mapping to the next block where there's a change in the
>>>>     * shared/unshared status.  More specifically, this means that we
>>>> @@ -533,6 +567,12 @@ xfs_reflink_allocate_cow(
>>>>    		xfs_ifork_init_cow(ip);
>>>>    	}
>>>> +	error = xfs_reflink_extent_is_shared(ip, imap, shared);
>>>> +	if (error)
>>>> +		return error;
>>>> +	if (!*shared)
>>>> +		return 0;
>>>> +
>>>>    	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>>>>    	if (error || !*shared)
>>>>    		return error;
>>>> @@ -834,6 +874,10 @@ xfs_reflink_end_cow_extent(
>>>>    	/* Remove the mapping from the CoW fork. */
>>>>    	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
>>>> +	error = xfs_reflink_clear_inode_flag(ip, &tp);
>>>
>>> This will disable COW on /all/ blocks in the entire file, including the
>>> shared ones.  At a bare minimum you'd have to scan the entire data fork
>>> to ensure there are no shared extents.  That's probably why doing this
>>> causes so many new regressions.
>>
>> This function will search for shared extent before actually clearing the
>> flag.  If no shared extent found, the flag won't be cleared.  The name of
>> this function is not very accurate.
> 
> Oh, right.  I forgot that _reflink_clear_inode_flag walks the entire
> data fork looking for shared extents, and only clears the flag if it
> doesn't find any.
> 
> That said, if (say) this is a large sparse file with 300 million extent
> records and extent 299,999,999 is shared, this is going to make write
> completions realllllly slow, as each completion now has to perform its
> own walk...
> 
>> BTW, in my thought, the reflink flag is to indicate if a file is now
>> containing any shared extents or not.  So, it should be cleared immediately
>> if no extents shared any more.  Is this right?
> 
> ...which is why we don't clear the flag immediately.  Or ever.  Only
> repairs take the time to do that.

Got it.  Thank you very much!


--
Ruan.

> 
> --D
> 
>>
>>
>> --
>> Thanks,
>> Ruan.
>>
>> PS: Let me paste the log of failed tests:
>> generic/127, generic/263, generic/616 are fsx tests.  Their fail message are
>> meaningless.  I am looking into their difference between good/bad results.
>>
>> xfs/315 0s ... - output mismatch (see
>> /root/xts/results//dax_reflink/xfs/315.out.bad)
>>      --- tests/xfs/315.out       2022-08-03 10:56:02.696212673 +0800
>>      +++ /root/xts/results//dax_reflink/xfs/315.out.bad  2023-03-20
>> 17:48:01.780369739 +0800
>>      @@ -7,7 +7,6 @@
>>       Inject error
>>       CoW a few blocks
>>       FS should be shut down, touch will fail
>>      -touch: cannot touch 'SCRATCH_MNT/badfs': Input/output error
>>       Remount to replay log
>>       FS should be online, touch should succeed
>>       Check files again
>>      ...
>>      (Run 'diff -u /root/xts/tests/xfs/315.out
>> /root/xts/results//dax_reflink/xfs/315.out.bad'  to see the entire diff)
>> xfs/421 1s ... - output mismatch (see
>> /root/xts/results//dax_reflink/xfs/421.out.bad)
>>      --- tests/xfs/421.out       2022-08-03 10:56:02.706212718 +0800
>>      +++ /root/xts/results//dax_reflink/xfs/421.out.bad  2023-03-20
>> 17:48:02.222369739 +0800
>>      @@ -14,8 +14,6 @@
>>       Whence     Result
>>       DATA       0
>>       HOLE       131072
>>      -DATA       196608
>>      -HOLE       262144
>>       Compare files
>>       c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-421/file1
>>      ...
>>      (Run 'diff -u /root/xts/tests/xfs/421.out
>> /root/xts/results//dax_reflink/xfs/421.out.bad'  to see the entire diff)
>>
>>>
>>> --D
>>>
>>>> +	if (error)
>>>> +		goto out_cancel;
>>>> +
>>>>    	error = xfs_trans_commit(tp);
>>>>    	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>>>>    	if (error)
>>>> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
>>>> index 65c5dfe17ecf..d5835814bce6 100644
>>>> --- a/fs/xfs/xfs_reflink.h
>>>> +++ b/fs/xfs/xfs_reflink.h
>>>> @@ -16,6 +16,8 @@ static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
>>>>    	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
>>>>    }
>>>> +int xfs_reflink_extent_is_shared(struct xfs_inode *ip,
>>>> +		struct xfs_bmbt_irec *irec, bool *shared);
>>>>    extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
>>>>    		struct xfs_bmbt_irec *irec, bool *shared);
>>>>    int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>>>> -- 
>>>> 2.39.2
>>>>
