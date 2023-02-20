Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1869C7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBTJjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 04:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBTJjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:39:36 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B412860;
        Mon, 20 Feb 2023 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676885972; i=@fujitsu.com;
        bh=iwtDt6pMTmn83HHbscVVVGy2TY23z3NJU+FZAIhjnTk=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Llkg32qy/lNnZwX+JfWyATPOQAxVuUdaezPi+b6hsqxjSAb1XcWPlCb/GKGdkhSd2
         Lo8AXbRswBjXx05J6Gzrelp4P124oyUuxEpLUVqmlp547/K/oB82DD+BiUVfvcRYwC
         3xH7tb6r77aqbcLBWXX3LyJkG+ysYwxmkt42jU6uHAK6eV5AF2vvodes5bAgPww4Jx
         ACnubdCLUkGt0tUDNhHPUDVfYQO6eCq9F37+YeCnpmtP8iFIh4JjQ0zebFlVHnsebj
         ridS7N1OpE0SZWfqbGcOj6EplSEQMpc1UvKr3VUV6zpjQ68A4EShrwCJJ288mmY962
         XgQ9WzG9QSgvA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRWlGSWpSXmKPExsViZ8OxWfey/ed
  kgw/tFhZz1q9hs5g+9QKjxZZj9xgtLj/hszg9YRGTxe7XN9ks9uw9yWJxb81/Votdf3awW6z8
  8YfV4vePOWwO3B6nFkl4bF6h5bF4z0smj02rOtk8Nn2axO5xYsZvFo8Xm2cyenx8eovF4/Mmu
  QDOKNbMvKT8igTWjP2rX7EWdAlVzHyxnqmBcRF/FyMnh5DARkaJ00u4uxi5gOylTBLPDsxmhk
  hsZ5TYcskKxOYVsJPYtfwKO4jNIqAqsbbjETNEXFDi5MwnLCC2qECyxLHzrWwgtrCAo8SuY22
  sXYwcHCICGhJvthiBzGcWaGGSOD7pAyPEMiBn25RVjCANbAI6EhcW/AVr4BQwkXjfEg8SZhaw
  kFj85iA7hC0v0bwV5DYODgkBJYmZ3WAlEgKVEq0ffrFA2GoSV89tYp7AKDQLyXWzkEyahWTSA
  kbmVYzmxalFZalFuoYWeklFmekZJbmJmTl6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6xZW5yT
  kpenmpJZsYgXGZUpxYt4NxRd9fvUOMkhxMSqK8m4Q/JwvxJeWnVGYkFmfEF5XmpBYfYpTh4FC
  S4NWyA8oJFqWmp1akZeYAUwRMWoKDR0mE9481UJq3uCAxtzgzHSJ1ilGXY23Dgb3MQix5+Xmp
  UuK8PiAzBECKMkrz4EbA0tUlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK89rZAU3gy80rgN
  r0COoIJ6Aj3Hx9AjihJREhJNTBpq7SVbD+/VTtXfNWyDwlWYf3MfhcX+hwwmxAdNPfJ88O7e2
  Pk8l6UODNoRir5NRsFPEhXX/ZKIejeS59Zx6VYF2/fw5oi5pBiEC7Z63brVW1b2ybGiYtqS4T
  9dvIpvBRS+j+hdJpMpNGHG6/FZj3QMRevqpjiYPbNb8IN1a9Ldr/sEs1ZKC46K0IhdEaudHSm
  54lLZSbnmSxdTOyiP+ydwH9pcuP6pUnbuP58OS3y0T/kfpDbibei/z3azaVdmRXZX5VEPNl3d
  G7qEcnDU2dbLdi9wb22NFOJX7+dq8/+gtrB7ydNL4be5JiS9HBeRP81bt3ZGSIz1c5Nyr0U/W
  fVAq5J8x7UGjKwdPfxaCixFGckGmoxFxUnAgCOybnR0gMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-2.tower-745.messagelabs.com!1676885971!6843!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21262 invoked from network); 20 Feb 2023 09:39:31 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-2.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2023 09:39:31 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 3018B156;
        Mon, 20 Feb 2023 09:39:31 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 233C5154;
        Mon, 20 Feb 2023 09:39:31 +0000 (GMT)
Received: from [192.168.50.5] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Feb 2023 09:39:27 +0000
Message-ID: <55bfcacf-d034-46bc-37fb-16d2875f6d62@fujitsu.com>
Date:   Mon, 20 Feb 2023 17:39:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
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
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Y/EYiSTpjhvjxpUw@casper.infradead.org>
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



在 2023/2/19 2:27, Matthew Wilcox 写道:
> On Sat, Feb 18, 2023 at 09:16:43AM +0800, Shiyang Ruan wrote:
>> 在 2023/2/18 0:14, Matthew Wilcox 写道:
>>> On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
>>>> -		invalidate_mapping_pages(inode->i_mapping, 0, -1);
>>>> -		iput(toput_inode);
>>>> -		toput_inode = inode;
>>>> -
>>>> -		cond_resched();
>>>> -		spin_lock(&sb->s_inode_list_lock);
>>>> -	}
>>>> -	spin_unlock(&sb->s_inode_list_lock);
>>>> -	iput(toput_inode);
>>>> +	super_drop_pagecache(sb, invalidate_inode_pages);
>>>
>>> I thought I explained last time that you can do this with
>>> invalidate_mapping_pages() / invalidate_inode_pages2_range() ?
>>> Then you don't need to introduce invalidate_inode_pages().
>>>
>>>> +void super_drop_pagecache(struct super_block *sb,
>>>> +	int (*invalidator)(struct address_space *))
>>>
>>> void super_drop_pagecache(struct super_block *sb,
>>> 		int (*invalidate)(struct address_space *, pgoff_t, pgoff_t))
>>>
>>>> +		invalidator(inode->i_mapping);
>>>
>>> 		invalidate(inode->i_mapping, 0, -1)
>>>
>>> ... then all the changes to mm/truncate.c and filemap.h go away.
>>
>> Yes, I tried as you suggested, but I found that they don't have same type of
>> return value.
>>
>> int invalidate_inode_pages2_range(struct address_space *mapping,
>> 				  pgoff_t start, pgoff_t end);
>>
>> unsigned long invalidate_mapping_pages(struct address_space *mapping,
>> 		pgoff_t start, pgoff_t end);
> 
> Oh, that's annoying.  Particularly annoying is that the return value
> for invalidate_mapping_pages() is used by fs/inode.c to account for
> the number of pages invalidate, and the return value for
> invalidate_inode_pages2_range() is used by several filesystems
> to know whether an error occurred.
> 
> Hm.  Shouldn't you be checking for an error from
> invalidate_inode_pages2_range()?  Seems like it can return -EBUSY for
> DAX entries.
> 
> With that in mind, the wrapper you actually want to exist is
> 
> static int invalidate_inode_pages_range(struct address_space *mapping,
> 				pgoff_t start, pgoff_t end)
> {
> 	invalidate_mapping_pages(mapping, start, end);
> 	return 0;
> }
> 
> Right?

So, I should introduce this wrapper in fs/xfs/xfs_notify_failure.c 
because it is the only one who calls this wrapper.  Ok, got it!


--
Thanks,
Ruan.
