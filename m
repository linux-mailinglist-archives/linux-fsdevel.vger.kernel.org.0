Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E96A3F20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjB0KHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB0KHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:07:03 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372911E5CF;
        Mon, 27 Feb 2023 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1677492416; i=@fujitsu.com;
        bh=kn2Vp6WJgOrQzbMBhvCHz2oSn3RJLwTNnYDWT0jl7Cc=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=koraLTrYlbR95you/2452Wtpd9PYBDutiyMgt9grAnNfYK1/oekpnio+WRVSkFPDu
         Mv0mToXi9or9cvmKLqXdY3tf9CJxivML3iYq1Bc27xuqMeyjfkC1v/cjvNYU09nAq3
         raDN0v3XwZIto+YIg+g6Dj+TXjokJtZWm3C1VcUa4PXhym8MRhLhs5C+bkT28rzZgm
         jB4mDG0mOtTgvf3lqa0Eaap5+4Fiuax/IpCy+hCk8dO8kKcw9GVQIeuEhOS9lomHDj
         HXpRlpxft83DnJTf6hn2RaYMK9TJ0HSQ8L6UdE3kjFE2A03L5GVRObwPCN3r8i94/u
         +8WJDDCzcFLKA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRWlGSWpSXmKPExsViZ8ORpLu14U+
  ywbQuAYs569ewWUyfeoHRYsuxe4wWl5/wWZyesIjJYvfrm2wWe/aeZLG4t+Y/q8WuPzvYLVb+
  +MNq8fvHHDYHbo9TiyQ8Nq/Q8li85yWTx6ZVnWwemz5NYvc4MeM3i8eLzTMZPT4+vcXi8XmTX
  ABnFGtmXlJ+RQJrxrqTm1kLLolXLGo9wtbAuE64i5GLQ0hgI6PE3M+rGSGcpUwS1xd1sUM42x
  kl5mzdB+RwcvAK2Encmj6XFcRmEVCVuL7hNFRcUOLkzCcsILaoQLLEsfOtbF2MHBzCAn4SF9a
  Yg4RFBNQkJk3awQxiMwu0MEls6a6AmL+WUWLfojawBJuAjsSFBX9ZQXo5Bawkbm9mhai3kFj8
  5iA7hC0v0bx1NjNIiYSAksTM7niQsIRApUTrh18sELaaxNVzm5gnMArNQnLcLCSTZiGZtICRe
  RWjeXFqUVlqka6huV5SUWZ6RkluYmaOXmKVbqJeaqluXn5RSYauoV5iebFeanGxXnFlbnJOil
  5easkmRmBkphQn3dnBuLPvr94hRkkOJiVR3kVOf5KF+JLyUyozEosz4otKc1KLDzHKcHAoSfA
  2lADlBItS01Mr0jJzgEkCJi3BwaMkwqteBJTmLS5IzC3OTIdInWJUlBLn9aoFSgiAJDJK8+Da
  YInpEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3qIqoCk8mXklcNNfAS1mAlq8/eEPkMUli
  QgpqQamVO9H95ecqvbN/MMgH//96FuBku3lp27qd0TuuHO3Uzp3+1r1Gel/uE77lKy9YypQe0
  2zQVtnx9G4MzU5hqHL0h/P64vcf3VOZ05vmlbsNTMV93zX+uwVT0UijrSJZMV58p1Rlr3xfO0
  MJY0qY7O43t0epiv+cjBrV87/JcPpcy3ndN+qX+3/2XMTT5xccvAE76aln/a9OResxRcdUTv9
  77HINNX5bBGX//i0dHVtidrHp38sa8OOP8wLhTNqpu35N9+OQz9gzd9sVo7fHt8jzgT8/G8jO
  olJ9LuC5IVIg3dszwI0T3Qtk9DZOXtrgJ2JRN1blc36ZWnFDidPa9js3LpT++vW7ddVvqUkGN
  xQYinOSDTUYi4qTgQAnarrQscDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-19.tower-728.messagelabs.com!1677492404!204198!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30840 invoked from network); 27 Feb 2023 10:06:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-19.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Feb 2023 10:06:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 83DF11AD;
        Mon, 27 Feb 2023 10:06:44 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 77AB51AC;
        Mon, 27 Feb 2023 10:06:44 +0000 (GMT)
Received: from [192.168.50.5] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 27 Feb 2023 10:06:40 +0000
Message-ID: <56e0a5e8-74db-95eb-d6fb-5d4a3b5cb156@fujitsu.com>
Date:   Mon, 27 Feb 2023 18:06:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-4-git-send-email-ruansy.fnst@fujitsu.com>
 <20230227000759.GZ360264@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230227000759.GZ360264@dread.disaster.area>
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



在 2023/2/27 8:07, Dave Chinner 写道:
> On Fri, Feb 17, 2023 at 02:48:32PM +0000, Shiyang Ruan wrote:
>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>> (or mapped device) on it to unmap all files in use and notify processes
>> who are using those files.
>>
>> Call trace:
>> trigger unbind
>>   -> unbind_store()
>>    -> ... (skip)
>>     -> devres_release_all()   # was pmem driver ->remove() in v1
>>      -> kill_dax()
>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>>        -> xfs_dax_notify_failure()
>>
>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>> event.  So do not shutdown filesystem directly if something not
>> supported, or if failure range includes metadata area.  Make sure all
>> files and processes are handled correctly.
>>
>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> .....
> 
>> ---
>> @@ -225,6 +242,15 @@ xfs_dax_notify_failure(
>>   	if (offset + len - 1 > ddev_end)
>>   		len = ddev_end - offset + 1;
>>   
>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
>> +		xfs_info(mp, "device is about to be removed!");
>> +		error = freeze_super(mp->m_super);
>> +		if (error)
>> +			return error;
>> +		/* invalidate_inode_pages2() invalidates dax mapping */
>> +		super_drop_pagecache(mp->m_super, invalidate_inode_pages2);
>> +	}
> 
> Why do you still need to drop the pagecache here? My suggestion was
> to replace it with freezing the filesystem at this point is to stop
> it being dirtied further before the device remove actually occurs.
> The userspace processes will be killed, their DAX mappings reclaimed
> and the filesystem shut down before device removal occurs, so
> super_drop_pagecache() is largely superfluous as it doesn't actually
> provide any protection against racing with new mappings or dirtying
> of existing/newly created mappings.
> 
> Freezing doesn't stop the creation of new mappings, either, it just
> cleans all the dirty mappings and halts anything that is trying to

This is the point I wasn't aware of.

> dirty existing clean mappings. It's not until we kill the userspace
> processes that new mappings will be stopped, and it's not until we
> shut the filesystem down that the filesystem itself will stop
> accessing the storage.
> 
> Hence I don't see why you retained super_drop_pagecache() here at
> all. Can you explain why it is still needed?


So I was just afraid that it's not enough for rmap & processes killer to 
invalidate the dax mappings.  If something error happened during the 
rmap walker, the fs will shutdown and there is no chance to invalidate 
the rest mappings whose user didn't be killed yet.

Now that freezing the fs is enough, I will remove the drop cache code.


--
Thanks,
Ruan.

> 
> -Dave.
