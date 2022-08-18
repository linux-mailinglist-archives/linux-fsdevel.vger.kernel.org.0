Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBBF598220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiHRLTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbiHRLTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:19:48 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B39C1E5;
        Thu, 18 Aug 2022 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1660821584; i=@fujitsu.com;
        bh=+EuciT7jIwu9FzBIejSJprVjCYvd9aSELh+pZeaxSVE=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=HxVv8CZ+cTQeJhUdS//KvIKoWyrVEodtRTXIsse6veoy+gqUb4GEP07iizLAp/pEM
         4MxUgsKZKwSFFVz0uevXqwKH8q0Vqac0A0lL1lWg5gVJa35u8Cxi3oJRV7bcg+mQbo
         v5dzXTyEKyP+fY/ncRYNZXDm0HMe/HoIJiffVcWGivxRcSnnkBeTeuYP72EnWpaalb
         WHI+YglQ117VmvKywzaYXIgiyPi6EgZnZspM3pLVa00RX9+tdWSFwpp/pFjEqtxa+v
         nmrGnyh2v40ESdqCuDAyi7ZEfCC4xitD79HwRhhIm/R02GIl/s0pB9prEZ/gwBKCI1
         PBqRyYcMK76sg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRWlGSWpSXmKPExsViZ8ORpOul8C/
  JYONbK4vpUy8wWmw5do/R4vITPovTExYxWex+fZPNYs/ekywWl3fNYbO4t+Y/q8WuPzvYLVb+
  +MPqwOVxapGEx+YVWh6L97xk8ti0qpPNY9OnSeweLzbPZPT4+PQWi8fnTXIBHFGsmXlJ+RUJr
  BkbZt1jK1hkUjGjewZjA+Me7S5GLg4hgY2MEmuav7NCOEuYJA70v2aDcLYzStyav4m9i5GDg1
  fATqKz3aeLkZODRUBVYvHxI6wgNq+AoMTJmU9YQGxRgWSJu4fXg9nCAr4S3+8fAqsREdCUOPL
  tGhPITGaB08wS/ZfPQ227wyRxf+E5RpAqNgEdiQsL/oJ1cApoSPxtmcgGYjMLWEgsfnOQHcKW
  l2jeOpsZ5CAJASWJmd3xIGEJgQqJWbPamCBsNYmr5zYxT2AUmoXkvllIJs1CMmkBI/MqRuuko
  sz0jJLcxMwcXUMDA11DQ1NdYxNdI0MLvcQq3US91FLd8tTiEl0jvcTyYr3U4mK94src5JwUvb
  zUkk2MwIhMKVa6tYNxw6qfeocYJTmYlER5Tz35myTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgve
  S7L8kIcGi1PTUirTMHGBygElLcPAoifD+FANK8xYXJOYWZ6ZDpE4xGnOsbTiwl5lj8dUre5mF
  WPLy81KlxHl55IFKBUBKM0rz4AbBktYlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8xnJAU
  3gy80rg9r0COoUJ6JRjF3+DnFKSiJCSamCKz+Jbtz7f+eQ728ZTndkyvefm/frk0iTz5cPT6f
  557Um60/KKzRMS5kg9jm0+lbira+2PuPZb9qEVLDxNfuecfH4F5y21ttRh/XhQb+eC5d7Sboc
  2esZJ/C1iOMchnLeg4XrO20/pDR38jPOSK95u/soc4cuuzWy0xWGBUORhBvP+Pnm9nqdPrn4I
  EFIqfxdxvLeSbdKnP+Fqn+e0GDIVqBYrNc7X7ArbJaczf873/lMT89pKLFmM+ndIujGG21sZ/
  ZhrxpNYp6m6O/fYV2aP5OiTsywtw3zafgfarO5e385bJXjj78KNjQlV04NYnt67Fchqnhm5wP
  q99KTn/9p7bumb3E0++sRz/p54JZbijERDLeai4kQAkXGRR9UDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-20.tower-565.messagelabs.com!1660821578!66821!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27156 invoked from network); 18 Aug 2022 11:19:38 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-20.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Aug 2022 11:19:38 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 90C001AF;
        Thu, 18 Aug 2022 12:19:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 7648E1B2;
        Thu, 18 Aug 2022 12:19:38 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 18 Aug 2022 12:19:34 +0100
Message-ID: <a638751a-ef0f-fa85-4076-5fff2272a669@fujitsu.com>
Date:   Thu, 18 Aug 2022 19:19:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
 <62d05eb8e663c_1643dc294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <YtXbD4e8mLHqWSwL@magnolia>
 <62d5e515de3a_929192941e@dwillia2-xfh.jf.intel.com.notmuch>
 <ef6fbc40-db59-eca5-e3e1-19f5809ec357@fujitsu.com>
 <Yun6qIonQbeqVvso@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Yun6qIonQbeqVvso@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/8/3 12:33, Darrick J. Wong 写道:
> On Wed, Aug 03, 2022 at 02:43:20AM +0000, ruansy.fnst@fujitsu.com wrote:
>>
>> 在 2022/7/19 6:56, Dan Williams 写道:
>>> Darrick J. Wong wrote:
>>>> On Thu, Jul 14, 2022 at 11:21:44AM -0700, Dan Williams wrote:
>>>>> ruansy.fnst@fujitsu.com wrote:
>>>>>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>>>>>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>>>>>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>>>>>> (or mapped device) on it to unmap all files in use and notify processes
>>>>>> who are using those files.
>>>>>>
>>>>>> Call trace:
>>>>>> trigger unbind
>>>>>>    -> unbind_store()
>>>>>>     -> ... (skip)
>>>>>>      -> devres_release_all()   # was pmem driver ->remove() in v1
>>>>>>       -> kill_dax()
>>>>>>        -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>>>>>>         -> xfs_dax_notify_failure()
>>>>>>
>>>>>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>>>>>> event.  So do not shutdown filesystem directly if something not
>>>>>> supported, or if failure range includes metadata area.  Make sure all
>>>>>> files and processes are handled correctly.
>>>>>>
>>>>>> ==
>>>>>> Changes since v5:
>>>>>>     1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
>>>>>>     2. hold s_umount before sync_filesystem()
>>>>>>     3. move sync_filesystem() after SB_BORN check
>>>>>>     4. Rebased on next-20220714
>>>>>>
>>>>>> Changes since v4:
>>>>>>     1. sync_filesystem() at the beginning when MF_MEM_REMOVE
>>>>>>     2. Rebased on next-20220706
>>>>>>
>>>>>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>>>>
>>>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>>>> ---
>>>>>>    drivers/dax/super.c         |  3 ++-
>>>>>>    fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
>>>>>>    include/linux/mm.h          |  1 +
>>>>>>    3 files changed, 18 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>>>>>> index 9b5e2a5eb0ae..cf9a64563fbe 100644
>>>>>> --- a/drivers/dax/super.c
>>>>>> +++ b/drivers/dax/super.c
>>>>>> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>>>>>>    		return;
>>>>>>    
>>>>>>    	if (dax_dev->holder_data != NULL)
>>>>>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
>>>>>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
>>>>>> +				MF_MEM_PRE_REMOVE);
>>>>>>    
>>>>>>    	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>>>>>    	synchronize_srcu(&dax_srcu);
>>>>>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>>>>>> index 69d9c83ea4b2..6da6747435eb 100644
>>>>>> --- a/fs/xfs/xfs_notify_failure.c
>>>>>> +++ b/fs/xfs/xfs_notify_failure.c
>>>>>> @@ -76,6 +76,9 @@ xfs_dax_failure_fn(
>>>>>>    
>>>>>>    	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>>>>>>    	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>>>>>> +		/* Do not shutdown so early when device is to be removed */
>>>>>> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
>>>>>> +			return 0;
>>>>>>    		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>>>>>    		return -EFSCORRUPTED;
>>>>>>    	}
>>>>>> @@ -174,12 +177,22 @@ xfs_dax_notify_failure(
>>>>>>    	struct xfs_mount	*mp = dax_holder(dax_dev);
>>>>>>    	u64			ddev_start;
>>>>>>    	u64			ddev_end;
>>>>>> +	int			error;
>>>>>>    
>>>>>>    	if (!(mp->m_sb.sb_flags & SB_BORN)) {
>>>>>>    		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>>>>>>    		return -EIO;
>>>>>>    	}
>>>>>>    
>>>>>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
>>>>>> +		xfs_info(mp, "device is about to be removed!");
>>>>>> +		down_write(&mp->m_super->s_umount);
>>>>>> +		error = sync_filesystem(mp->m_super);
>>>>>> +		up_write(&mp->m_super->s_umount);
>>>>>
>>>>> Are all mappings invalidated after this point?
>>>>
>>>> No; all this step does is pushes dirty filesystem [meta]data to pmem
>>>> before we lose DAXDEV_ALIVE...
>>>>
>>>>> The goal of the removal notification is to invalidate all DAX mappings
>>>>> that are no pointing to pfns that do not exist anymore, so just syncing
>>>>> does not seem like enough, and the shutdown is skipped above. What am I
>>>>> missing?
>>>>
>>>> ...however, the shutdown above only applies to filesystem metadata.  In
>>>> effect, we avoid the fs shutdown in MF_MEM_PRE_REMOVE mode, which
>>>> enables the mf_dax_kill_procs calls to proceed against mapped file data.
>>>> I have a nagging suspicion that in non-PREREMOVE mode, we can end up
>>>> shutting down the filesytem on an xattr block and the 'return
>>>> -EFSCORRUPTED' actually prevents us from reaching all the remaining file
>>>> data mappings.
>>>>
>>>> IOWs, I think that clause above really ought to have returned zero so
>>>> that we keep the filesystem up while we're tearing down mappings, and
>>>> only call xfs_force_shutdown() after we've had a chance to let
>>>> xfs_dax_notify_ddev_failure() tear down all the mappings.
>>>>
>>>> I missed that subtlety in the initial ~30 rounds of review, but I figure
>>>> at this point let's just land it in 5.20 and clean up that quirk for
>>>> -rc1.
>>>
>>> Sure, this is a good baseline to incrementally improve.
>>
>> Hi Dan, Darrick
>>
>> Do I need to fix somewhere on this patch?  I'm not sure if it is looked good...
> 
> Eh, wait for me to send the xfs pull request and then I'll clean things
> up and send you a patch. :)

Hi, Darrick

How is your patch going on?  Forgive me for being so annoying.  I'm 
afraid of missing your patch, so I'm asking for confirmation.


--
Thanks,
Ruan.

> 
> --D
> 
>>
>> --
>> Thanks,
>> Ruan.
>>
>>>
>>>>
>>>>> Notice that kill_dev_dax() does unmap_mapping_range() after invalidating
>>>>> the dax device and that ensures that all existing mappings are gone and
>>>>> cannot be re-established. As far as I can see a process with an existing
>>>>> dax mapping will still be able to use it after this runs, no?
>>>>
>>>> I'm not sure where in akpm's tree I find kill_dev_dax()?  I'm cribbing
>>>> off of:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/fs/xfs/xfs_notify_failure.c?h=mm-stable
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/drivers/dax/bus.c?h=mm-stable#n381
>>>
>>> Where the observation is that when device-dax is told that the device is
>>> going away it invalidates all the active mappings to that single
>>> character-device-inode. The hope being that in the fsdax case all the
>>> dax-mapped filesystem inodes would experience the same irreversible
>>> invalidation as the device is exiting.
