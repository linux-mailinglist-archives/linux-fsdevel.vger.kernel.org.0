Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292975A46B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiH2KCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2KCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:02:30 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AB5EDDF;
        Mon, 29 Aug 2022 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661767344; i=@fujitsu.com;
        bh=dk7CW0RgFnm2w8LkfxMFDMaV4x7pu5LS2/dYqlV9UW0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=c7lnzBydVYjppzDwG7pfKqNrLrQ31NIF8tGahIPpT4RLFYSR9BOMsRktFxe/1IKxi
         euXa/4ahDuYyEp7G2S2NIFm2nGoqCakoAsxCJJamgY29QJYV3U8HIGOohhLO3+BrwB
         qIbvtHdHEHIO+B1BmdDnrZph/bDjXI0q7RxMSoDSl1EZsFCC59Ms9jYm8SK4MOmSMs
         TtTU//lKxIP57hRdnRX9BCvhKY7O7bj4AzWd1PBIx0nvE9AHKeHAbS38APlW5j55O0
         UI55jL2geilMTIB1fj9LnIv9zEcm4CcfEnY3pUi4y493uJ2hiVtQAgXLJ1Sd2U85m6
         dLNX6+L/kXCVA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRWlGSWpSXmKPExsViZ8ORqLu+jyf
  ZYP9RQYvpUy8wWmw5do/R4vITPovTExYxWex+fZPNYs/ekywWl3fNYbO4t+Y/q8WuPzvYLVb+
  +MPqwOVxapGEx+YVWh6L97xk8ti0qpPNY9OnSeweLzbPZPT4+PQWi8fnTXIBHFGsmXlJ+RUJr
  BmHH99nKzijUTHr4SrWBsZfCl2MXBxCAlsYJU6vb2GBcFYwSdz+tI8VwtnBKLHqxFS2LkZODl
  4BO4nlS46yg9gsAqoSK+5eYYaIC0qcnPmEBcQWFUiWuHt4PZgtLOApcXDZO7BeEYFjTBKbLmq
  BDGUW2MAocWL+REaQhJBArcT12xfAGtgEdCQuLPjLCmJzCnhJzPp3FmwZs4CFxOI3B6FseYnm
  rbOBFnNwSAgoSczsjgcJSwhUSrR++MUCYatJXD23iXkCo9AsJOfNQjJpFpJJCxiZVzHaJBVlp
  meU5CZm5ugaGhjoGhqa6lqa6RpaGuslVukm6qWW6ublF5Vk6BrqJZYX66UWF+sVV+Ym56To5a
  WWbGIExmRKccLBHYwr9v3SO8QoycGkJMrblMuTLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC17U
  XKCdYlJqeWpGWmQNMDzBpCQ4eJRHeO91Aad7igsTc4sx0iNQpRkuOtQ0H9jJzLL56BUhOnf1v
  P7MQS15+XqqUOO8EkHkCIA0ZpXlw42Ap7BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV4mY
  EIU4snMK4Hb+groICaggx4u4QY5qCQRISXVwFQ08c+G+kzz+47xq8KeunrZBYjNvRXd0LysTV
  hLKujm19fM7npaUq/rWBYEiV9STtR5GFKpVx/FpxcodMV81XPrRvuD+2w7vn44KN2dIWq7ZL3
  /BrWrt+wF+pVfBHVWPL/1WYyP/c/O96bX9kWYL32S5KxXef1L4AauAHMmt0usFn9+On17mjWl
  37w9eZKy/svXDEcfbIn+9sEo6pRGxCc/Y6a/N6sfC67ePfnavx8n7XayBmtw71p07Z9V6IfV0
  00n3Zr1+ZFfQccFU4FZjLH5Uuo6AduTPC+bvHRtOlGu0Cy8w2/+/c88Kyabb5jKsuS7Ut2vDd
  lhzR4S+36E/3jl+cclJqj6MtPjrEnGLUosxRmJhlrMRcWJAEX71nzcAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-732.messagelabs.com!1661767342!161496!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2046 invoked from network); 29 Aug 2022 10:02:23 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-15.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Aug 2022 10:02:23 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 93EF210019E;
        Mon, 29 Aug 2022 11:02:22 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 8591C10019B;
        Mon, 29 Aug 2022 11:02:22 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 29 Aug 2022 11:02:17 +0100
Message-ID: <72fa9657-741a-e099-baf8-4615145d7bd1@fujitsu.com>
Date:   Mon, 29 Aug 2022 18:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v7] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <63093cbd43f67_259e5b2946d@dwillia2-xfh.jf.intel.com.notmuch>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <63093cbd43f67_259e5b2946d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/8/27 5:35, Dan Williams 写道:
> Shiyang Ruan wrote:
>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>> (or mapped device) on it to unmap all files in use and notify processes
>> who are using those files.
>>
>> Call trace:
>> trigger unbind
>>    -> unbind_store()
>>     -> ... (skip)
>>      -> devres_release_all()
>>       -> kill_dax()
>>        -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>>         -> xfs_dax_notify_failure()
>>
>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>> event.  So do not shutdown filesystem directly if something not
>> supported, or if failure range includes metadata area.  Make sure all
>> files and processes are handled correctly.
>>
>> ==
>> Changes since v6:
>>     1. Rebase on 6.0-rc2 and Darrick's patch[2].
>>
>> Changes since v5:
>>     1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
>>     2. hold s_umount before sync_filesystem()
>>     3. do sync_filesystem() after SB_BORN check
>>     4. Rebased on next-20220714
>>
>> [1]:
>> https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>> [2]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> ---
>>    drivers/dax/super.c         |  3 ++-
>>    fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
>>    include/linux/mm.h          |  1 +
>>    3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 9b5e2a5eb0ae..cf9a64563fbe 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>>    		return;
>>     	if (dax_dev->holder_data != NULL)
>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
>> +				MF_MEM_PRE_REMOVE);
>>     	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>    	synchronize_srcu(&dax_srcu);
>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>> index 65d5eb20878e..a9769f17e998 100644
>> --- a/fs/xfs/xfs_notify_failure.c
>> +++ b/fs/xfs/xfs_notify_failure.c
>> @@ -77,6 +77,9 @@ xfs_dax_failure_fn(
>>     	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>>    	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>> +		/* Do not shutdown so early when device is to be removed */
>> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>    		notify->want_shutdown = true;
>>    		return 0;
>>    	}
>> @@ -182,12 +185,22 @@ xfs_dax_notify_failure(
>>    	struct xfs_mount	*mp = dax_holder(dax_dev);
>>    	u64			ddev_start;
>>    	u64			ddev_end;
>> +	int			error;
>>     	if (!(mp->m_sb.sb_flags & SB_BORN)) {
> 
> How are you testing the SB_BORN interactions? I have a fix for this
> pending here:
> 
> https://lore.kernel.org/nvdimm/166153428094.2758201.7936572520826540019.stgit@dwillia2-xfh.jf.intel.com/

That was my mistake.  Yes, it should be mp->m_super->s_flags.

(I remember my testcase did pass in my dev version, but now that seems 
impossible.  I think something was wrong when I did the test.)

> 
>>    		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>>    		return -EIO;
>>    	}
>>    +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> 
> It appears this patch is corrupted here. I confirmed that b4 sees the
> same when trying to apply it.

Can't this patch be applied?  It is based on 6.0-rc2 + Darrick's patch. 
It's also ok to rebase on 6.0-rc3 + Darrick's patch.

> 
>> +		xfs_info(mp, "device is about to be removed!");
>> +		down_write(&mp->m_super->s_umount);
>> +		error = sync_filesystem(mp->m_super);
> 
> This syncs to make data persistent, but for DAX this also needs to get
> invalidate all current DAX mappings. I do not see that in these changes.

I'll add it.


--
Thanks,
Ruan.

> 
>> +		up_write(&mp->m_super->s_umount);
>> +		if (error)
>> +			return error;
>> +	}
>> +
>>    	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>>    		xfs_warn(mp,
>>    			 "notify_failure() not supported on realtime device!");
>> @@ -196,6 +209,8 @@ xfs_dax_notify_failure(
>>     	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>>    	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		if (mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>    		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>>    		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>    		return -EFSCORRUPTED;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 982f2607180b..2c7c132e6512 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3176,6 +3176,7 @@ enum mf_flags {
>>    	MF_UNPOISON = 1 << 4,
>>    	MF_SW_SIMULATED = 1 << 5,
>>    	MF_NO_RETRY = 1 << 6,
>> +	MF_MEM_PRE_REMOVE = 1 << 7,
>>    };
>>    int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>    		      unsigned long count, int mf_flags);
>> -- 
>> 2.37.2
>>
>>
> 
> 
