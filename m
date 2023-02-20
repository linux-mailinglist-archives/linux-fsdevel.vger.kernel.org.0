Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3393269C7E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBTJpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBTJpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:45:42 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7ECA11;
        Mon, 20 Feb 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676886339; i=@fujitsu.com;
        bh=8jOutu8Snpl3GZHRksRImCEI6NQPKVo5qp4nZAAklVM=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=HfwtHH5nTxMuUGb8i13Z+VL2DQjnyRAkkMnV4hd8Dqde11vGEQcNSxSWd8Fu3QZaj
         yRw577E5t94fjC2VIkbUcGGEP2gAr9AufliETuLlrDIJJEK+NfHcVv3paN41ze2ThC
         fRbv0L4D44s1WqmOn2Qd38B+TN+wNe4gnk1wHNHNQs2SaivpWASYEcLKMEZX4erWIc
         mS6CxrD9kOjIb449lp/rRe6XTsuCZB4qufgcVVdhmsS1+JEnuo+tMBHu25/6nRR9y0
         40lGiIAS/esrzA/o994b0P4UQIVB3biQSAHP2zCiVyPpgnt4SToJL89ggbyC2cdTKl
         +94/Kk2wXrDfg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRWlGSWpSXmKPExsViZ8MxSdfJ8XO
  ywYI5whZz1q9hs5g+9QKjxZZj9xgtLj/hszg9YRGTxe7XN9ks9uw9yWJxb81/Votdf3awW6z8
  8YfV4vePOWwO3B6nFkl4bF6h5bF4z0smj02rOtk8Nn2axO5xYsZvFo8Xm2cyenx8eovF4/Mmu
  QDOKNbMvKT8igTWjJmzr7IXbBCt+LSruIHxqFAXIxeHkMAWRokJRy6xQjgrmCRufb3BDuFsZ5
  Q4fncBUxcjJwevgJ3E9E/LmUFsFgFViR9HrkDFBSVOznzCAmKLCiRLHDvfygZiCws4Suw61sY
  KYrMJ6EhcWPAXyObgEBHQkHizxQhkPrNAC5PE8UkfGCGW7WCSaD5xhR2kgVPAXqLn9XmwocwC
  FhKL3xxkh7DlJZq3zmYGGSQhoCQxszseJCwhUCnR+uEXC4StJnH13CbmCYxCs5CcNwvJpFlIJ
  i1gZF7FaFqcWlSWWqRropdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJ
  Oil5dasokRGJcpxaxvdzD+7/2rd4hRkoNJSZR3k/DnZCG+pPyUyozE4oz4otKc1OJDjDIcHEo
  SvFp2QDnBotT01Iq0zBxgioBJS3DwKInw/rEGSvMWFyTmFmemQ6ROMepyrG04sJdZiCUvPy9V
  Spz3tz1QkQBIUUZpHtwIWLq6xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY194WaApPZl4J3
  KZXQEcwAR3h/uMDyBEliQgpqQampY0mXErCrw/omjv2NT5aELev9MiR41fXvXsvcc5HP0BU+4
  DHjw22mfG7ntxJbVbjcGvcciek6ufLa/9Wp/HVvNLWCPoa01ohFbE5J7Sw3zvUf/YMw96bq97
  OzN/Y/KNx6vyVSkW3heZtj9M/lWLvc9XD/K/50g+Rx+2eS3u8krWO+GvzXfiHVPGPe4V6IsXq
  bN6ez+ZVXA58aavsI7rJLmerBcOBk2rqM6TjPH+WLuH2KJPynP1xhep2c7H/rxtW8bB9Tn52/
  FLlhuZPFxfcO/dN8/jWoH3T3fqLXJ3WBIpuOD0pYFfNhDfbRVpiyhPbI7Wv5ai5vSoUPr2qvp
  vbP/f1L0nvxjff9uY6fLNQYinOSDTUYi4qTgQADVLACdIDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-8.tower-585.messagelabs.com!1676886338!174575!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12857 invoked from network); 20 Feb 2023 09:45:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-8.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2023 09:45:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id CE24C1000D7;
        Mon, 20 Feb 2023 09:45:37 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id C138E1000D2;
        Mon, 20 Feb 2023 09:45:37 +0000 (GMT)
Received: from [192.168.50.5] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Feb 2023 09:45:33 +0000
Message-ID: <addfe612-ba8e-c0a3-f498-28869823f925@fujitsu.com>
Date:   Mon, 20 Feb 2023 17:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>, <akpm@linux-foundation.org>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
 <Y++n53dzkCsH1qeK@casper.infradead.org>
 <d5e5c50f-6d16-5a52-e79d-3578acdc1d92@fujitsu.com>
 <Y/EYiSTpjhvjxpUw@casper.infradead.org>
 <55bfcacf-d034-46bc-37fb-16d2875f6d62@fujitsu.com>
In-Reply-To: <55bfcacf-d034-46bc-37fb-16d2875f6d62@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/2/20 17:39, Shiyang Ruan 写道:
> 
> 
> 在 2023/2/19 2:27, Matthew Wilcox 写道:
>> On Sat, Feb 18, 2023 at 09:16:43AM +0800, Shiyang Ruan wrote:
>>> 在 2023/2/18 0:14, Matthew Wilcox 写道:
>>>> On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
>>>>> -        invalidate_mapping_pages(inode->i_mapping, 0, -1);
>>>>> -        iput(toput_inode);
>>>>> -        toput_inode = inode;
>>>>> -
>>>>> -        cond_resched();
>>>>> -        spin_lock(&sb->s_inode_list_lock);
>>>>> -    }
>>>>> -    spin_unlock(&sb->s_inode_list_lock);
>>>>> -    iput(toput_inode);
>>>>> +    super_drop_pagecache(sb, invalidate_inode_pages);
>>>>
>>>> I thought I explained last time that you can do this with
>>>> invalidate_mapping_pages() / invalidate_inode_pages2_range() ?
>>>> Then you don't need to introduce invalidate_inode_pages().
>>>>
>>>>> +void super_drop_pagecache(struct super_block *sb,
>>>>> +    int (*invalidator)(struct address_space *))
>>>>
>>>> void super_drop_pagecache(struct super_block *sb,
>>>>         int (*invalidate)(struct address_space *, pgoff_t, pgoff_t))
>>>>
>>>>> +        invalidator(inode->i_mapping);
>>>>
>>>>         invalidate(inode->i_mapping, 0, -1)
>>>>
>>>> ... then all the changes to mm/truncate.c and filemap.h go away.
>>>
>>> Yes, I tried as you suggested, but I found that they don't have same 
>>> type of
>>> return value.
>>>
>>> int invalidate_inode_pages2_range(struct address_space *mapping,
>>>                   pgoff_t start, pgoff_t end);
>>>
>>> unsigned long invalidate_mapping_pages(struct address_space *mapping,
>>>         pgoff_t start, pgoff_t end);
>>
>> Oh, that's annoying.  Particularly annoying is that the return value
>> for invalidate_mapping_pages() is used by fs/inode.c to account for
>> the number of pages invalidate, and the return value for
>> invalidate_inode_pages2_range() is used by several filesystems
>> to know whether an error occurred.
>>
>> Hm.  Shouldn't you be checking for an error from
>> invalidate_inode_pages2_range()?  Seems like it can return -EBUSY for
>> DAX entries.
>>
>> With that in mind, the wrapper you actually want to exist is
>>
>> static int invalidate_inode_pages_range(struct address_space *mapping,
>>                 pgoff_t start, pgoff_t end)
>> {
>>     invalidate_mapping_pages(mapping, start, end);
>>     return 0;
>> }
>>
>> Right?
> 
> So, I should introduce this wrapper in fs/xfs/xfs_notify_failure.c 

Ahh... It's not fs/xfs/xfs_notify_failure.c, should be fs/drop_caches.c.

> because it is the only one who calls this wrapper.  Ok, got it!
> 
> 
> -- 
> Thanks,
> Ruan.
