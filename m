Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0326C2FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 12:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCULAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 07:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCULAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:00:22 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C921FC0;
        Tue, 21 Mar 2023 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679396416; i=@fujitsu.com;
        bh=9Q4eeFSM3h3UH6eFVO+VHu7SN3t55EOvO+MXrJMIkpY=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=UMguMWEQcsy/gU+BcV2qqgTv6JqGEjLcSsLaPMGYln9uljBw8oSgeUoazkPj11zDm
         pde0jerQBEi51VLmaOO2bTwakjJMKzO1LIENvc5n28K6bVwS+k36si/yk2qEhL1eX7
         9HxJyTwai36PT0NUoGnT7MUPnt8eMqOIIRicBw0A/2+3pRHR+Dh3MKQyBuBHQKtSjh
         BZMiK0CXbIh/wovnRk1T6PELCEMR7DzZT62g4H9TdaWnNUqyY8kXuLADdFPKJXJX3I
         79mvNLaYPcRCFyfldzZevP6AN/q2pMCo8pvp9HTceDmYRAoW0o0WPe+Ot91IZHo6es
         8JrjkZe4u7W+A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRWlGSWpSXmKPExsViZ8ORpGvRJ5l
  iMO+TisWc9WvYLKZPvcBoseXYPUaLy0/4LE5PWMRksfv1TTaLPXtPsljcW/Of1WLXnx3sFit/
  /GG1+P1jDpsDt8epRRIem1doeSze85LJY9OqTjaPTZ8msXucmPGbxePF5pmMHh+f3mLx+LxJL
  oAzijUzLym/IoE14+n8dSwF91Ur1i4waWBsku9i5OIQEtjIKLGt6QgLhLOESWLtlUusXYycQM
  42RolNv01AbF4BO4mWh+cZuxg5OFgEVCWmtfFBhAUlTs58wgJiiwokSxw738oGUiIs4CdxYY0
  5SJhNQEfiwoK/YBNFBNQkJk3awQxiMwu0MEls6a6AWPuQUWLu2y6wBKeAvcT6C49ZIIosJBa/
  OcgOYctLNG+dDVYjIaAkcfHrHVYIu0KicfohJghbTeLquU3MExiFZiE5bxaSUbOQjFrAyLyK0
  aw4tagstUjX0FwvqSgzPaMkNzEzRy+xSjdRL7VUtzy1uETXUC+xvFgvtbhYr7gyNzknRS8vtW
  QTIzAqU4qZy3cwbu/7q3eIUZKDSUmU95eJZIoQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd5T3UA
  5waLU9NSKtMwcYIKASUtw8CiJ8C6qAErzFhck5hZnpkOkTjHqcqxtOLCXWYglLz8vVUqcN6oX
  qEgApCijNA9uBCxZXWKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzLujA2gKT2ZeCdymV0BHM
  AEdETdDAuSIkkSElFQDU5ttySvna9/PR2wpsJ8yf5Egz4OpkbILvSZqXOs41Hhr/4XeRfK3K3
  3/3W032z83qHhxwlleNk2+3XLf7RO7A6b7LDjN5Jp++MYD1SNr//yx/NwsmVe29vLmvE6fU0/
  mlnftKdC68mb6rrDHt74nJs9f+/LaxdRdVw1u5/zvlT4SMnWiVNI297r3bDtMyzc36Utv18uW
  D9kSq7Ip1Zf5vJOs2peyOSE9W3Q/p8emOfCnHlLZuNXrVNn7Kzu5NhfVVh9f8mnJGu4jWf/2N
  V/Sm/Sh3pJBNL5gk7HO5MzO4zqx/1RPCDrny3CpTVyZ/6nOPSJtbW/pZdd423exi+s1M44/O8
  dSkyf7ZQ//VIt+cyWW4oxEQy3mouJEANcsYpbRAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-21.tower-585.messagelabs.com!1679396408!13765!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11941 invoked from network); 21 Mar 2023 11:00:08 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-21.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Mar 2023 11:00:08 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 1E7811B0;
        Tue, 21 Mar 2023 11:00:08 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 1295F1AF;
        Tue, 21 Mar 2023 11:00:08 +0000 (GMT)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 21 Mar 2023 11:00:03 +0000
Message-ID: <b1d9fc03-1a71-a75f-f87b-5819991e4eb2@fujitsu.com>
Date:   Tue, 21 Mar 2023 18:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-4-git-send-email-ruansy.fnst@fujitsu.com>
 <20230227000759.GZ360264@dread.disaster.area>
 <56e0a5e8-74db-95eb-d6fb-5d4a3b5cb156@fujitsu.com>
In-Reply-To: <56e0a5e8-74db-95eb-d6fb-5d4a3b5cb156@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/2/27 18:06, Shiyang Ruan 写道:
> 
> 
> 在 2023/2/27 8:07, Dave Chinner 写道:
>> On Fri, Feb 17, 2023 at 02:48:32PM +0000, Shiyang Ruan wrote:
>>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>>> (or mapped device) on it to unmap all files in use and notify processes
>>> who are using those files.
>>>
>>> Call trace:
>>> trigger unbind
>>>   -> unbind_store()
>>>    -> ... (skip)
>>>     -> devres_release_all()   # was pmem driver ->remove() in v1
>>>      -> kill_dax()
>>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, 
>>> MF_MEM_PRE_REMOVE)
>>>        -> xfs_dax_notify_failure()
>>>
>>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>>> event.  So do not shutdown filesystem directly if something not
>>> supported, or if failure range includes metadata area.  Make sure all
>>> files and processes are handled correctly.
>>>
>>> [1]: 
>>> https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>
>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>
>> .....
>>
>>> ---
>>> @@ -225,6 +242,15 @@ xfs_dax_notify_failure(
>>>       if (offset + len - 1 > ddev_end)
>>>           len = ddev_end - offset + 1;
>>> +    if (mf_flags & MF_MEM_PRE_REMOVE) {
>>> +        xfs_info(mp, "device is about to be removed!");
>>> +        error = freeze_super(mp->m_super);
>>> +        if (error)
>>> +            return error;
>>> +        /* invalidate_inode_pages2() invalidates dax mapping */
>>> +        super_drop_pagecache(mp->m_super, invalidate_inode_pages2);
>>> +    }
>>
>> Why do you still need to drop the pagecache here? My suggestion was
>> to replace it with freezing the filesystem at this point is to stop
>> it being dirtied further before the device remove actually occurs.
>> The userspace processes will be killed, their DAX mappings reclaimed
>> and the filesystem shut down before device removal occurs, so
>> super_drop_pagecache() is largely superfluous as it doesn't actually
>> provide any protection against racing with new mappings or dirtying
>> of existing/newly created mappings.
>>
>> Freezing doesn't stop the creation of new mappings, either, it just
>> cleans all the dirty mappings and halts anything that is trying to
> 
> This is the point I wasn't aware of.
> 
>> dirty existing clean mappings. It's not until we kill the userspace
>> processes that new mappings will be stopped, and it's not until we
>> shut the filesystem down that the filesystem itself will stop
>> accessing the storage.
>>
>> Hence I don't see why you retained super_drop_pagecache() here at
>> all. Can you explain why it is still needed?
> 
> 
> So I was just afraid that it's not enough for rmap & processes killer to 
> invalidate the dax mappings.  If something error happened during the 
> rmap walker, the fs will shutdown and there is no chance to invalidate 
> the rest mappings whose user didn't be killed yet.
> 
> Now that freezing the fs is enough, I will remove the drop cache code.

I removed the drop cache code, then kernel always went into crash when 
running the test[1].  After the investigation, I found that the crash is 
cause by accessing (invalidate dax pages when umounting fs) the page of 
a pmem while the pmem has been removed.

According to the design, the dax page should have been invalidated by 
mf_dax_kill_procs() but it didn't.  I found two reasons:
  1. collect_procs_fsdax() only kills the current process
  2. unmap_mapping_range() doesn't invalidate the dax pages 
(disassociate dax entry in fs/dax.c), which causes the crash in my test

So, I think we should:
  1. pass the mf_flag to collect_procs_fsdax() to let it collect all 
processes associated with the file on the XFS.
  2. drop cache is still needed, but just drop the associated files' 
cache after mf_dax_kill_procs(), instead of dropping cache of the whole 
filesystem.

Then the logic shuld be looked like this:
unbind
  `-> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
    `-> xfs_dax_notify_failure()
      `-> freeze_super()
      `-> do xfs rmap
        `-> mf_dax_kill_procs()
          `-> collect_procs_fsdax()   // all associated
          `-> unmap_and_kill()
        `-> invalidate_inode_pages2() // drop file's cache
      `-> thaw_super()


[1] The step of unbind test:
  1. create fsdax namespace on a pmem
  2. mkfs.xfs on it
  3. run fsx test in background
  4. wait 1s
  5. echo "pfn0.1" > unbind
  6. wait 1s
  7. umount xfs       --> crash happened


--
Thanks,
Ruan.

> 
> 
> -- 
> Thanks,
> Ruan.
> 
>>
>> -Dave.
