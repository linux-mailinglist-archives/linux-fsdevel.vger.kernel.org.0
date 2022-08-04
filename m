Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED65895AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiHDBg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 21:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbiHDBg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:36:58 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEFA5D0DD;
        Wed,  3 Aug 2022 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659577013; i=@fujitsu.com;
        bh=RzfBUxm2e+0u6f5z03qEi8YXRUiCis7xn6IbNdE5OmY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=AGkrjHtXb0C2WhUMOk9QamCI3DGCctzewDri863e/yeYShl0KOyH9C4b1yzzCfIYW
         FQDXiWTpJb3gurEXTcy+qygdbBGOkHPwtNkgcTUgRXnekJ722SWLY0I2sUZWLizIvX
         1SYBD1dAq72IXb/7OC4B9ETDnW2VK6iWR1CEe0JBNOYdCEjXo8ti6+6oG8WyoyPG/I
         63apvbrbLRlMm03pztZ3lQH/OFv8yPHE7tf1mb++xjcswipL7Fh+THTVD/uLhsSmw+
         5bHPIePqczwuj4evGG8azBr0Zsdafr9L1w3OqXlSTCVgg9QcXlYRoDGwl0V1g3mSJU
         xn76jYhAE7wbQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRWlGSWpSXmKPExsViZ8ORpLta6XW
  SwaQtjBZbjt1jtLj8hM/i9IRFTBZ79p5ksbi8aw6bxa4/O9gtVv74w+rA7nFqkYTH5hVaHptW
  dbJ5vNg8k9Hj8ya5ANYo1sy8pPyKBNaM4weaGAveqVW8PPWMrYHxinwXIxeHkMBGRomF9/ewQ
  zhLmCT6bz1lg3C2MUo8XXyMpYuRk4NXwE7i2cL/jCA2i4CKxOKFH9gh4oISJ2c+Aarh4BAVSJ
  b4ttcIJCws4CuxdlMfM4gtIqApceTbNSaQmcwCJ5kkmk5sYoJYcJZJ4nbnFyaQKjYBHYkLC/6
  ygticAhoSp7bPArOZBSwkFr85yA5hy0s0b53NDLJMQkBJYmZ3PEhYQqBCYtasNiYIW03i6rlN
  zBMYhWYhOW8WkkmzkExawMi8itE6qSgzPaMkNzEzR9fQwEDX0NBU19gCSBnqJVbpJuqlluqWp
  xaX6BrpJZYX66UWF+sVV+Ym56To5aWWbGIERlVKsVr+Dsa/K3/qHWKU5GBSEuWtPPUqSYgvKT
  +lMiOxOCO+qDQntfgQowwHh5IEr6vi6yQhwaLU9NSKtMwcYITDpCU4eJREeHXkgNK8xQWJucW
  Z6RCpU4zGHOd37t/LzLG24cBeZiGWvPy8VClx3kcKQKUCIKUZpXlwg2CJ5xKjrJQwLyMDA4MQ
  T0FqUW5mCar8K0ZxDkYlYd6b8kBTeDLzSuD2vQI6hQnkFK4XIKeUJCKkpBqYZB6seHrO7ELU4
  oXSx/6HGSRvnxBXWe+9QbVF+Ep7s11f84avU9KqbTV3/rtzfUeinsSWDbcS1OYFbLpf/UdXT8
  fQortuUuerL32zc+0+RiXHWc28a2CwNbxHUbmy/e3EpAyz2abn/m9d+JlZ+aDeZIXshRJuXzw
  KVnCvuD+law/Hugnds0SfTkhXMajynZBoonPgscws3mfz5qRuXyrzoGdizyFhpUkTY+JOn121
  w0q4+r9Ec23IJv72acKT06tmWE99pd6m0S6au/DWBfWDWVM+LhauyQiTPuiy/sK0HKdS/cNHG
  htyEp8Y6J7e5Hhx5my/HbU3UjYbBCoZnS4q67iue1Dg1ZdIt9Y6l81uSizFGYmGWsxFxYkAiK
  hwsrcDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-565.messagelabs.com!1659577002!445523!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4843 invoked from network); 4 Aug 2022 01:36:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Aug 2022 01:36:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A912B1AD;
        Thu,  4 Aug 2022 02:36:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9D75E1AC;
        Thu,  4 Aug 2022 02:36:42 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 4 Aug 2022 02:36:39 +0100
Message-ID: <ece5e040-35cd-3570-728e-b010fab52c70@fujitsu.com>
Date:   Thu, 4 Aug 2022 09:36:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YusYDMXLYxzqMENY@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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



在 2022/8/4 8:51, Darrick J. Wong 写道:
> On Wed, Aug 03, 2022 at 06:47:24AM +0000, ruansy.fnst@fujitsu.com wrote:
>>
>>
>> 在 2022/7/29 12:54, Darrick J. Wong 写道:
>>> On Fri, Jul 29, 2022 at 03:55:24AM +0000, ruansy.fnst@fujitsu.com wrote:
>>>>
>>>>
>>>> 在 2022/7/22 0:16, Darrick J. Wong 写道:
>>>>> On Thu, Jul 21, 2022 at 02:06:10PM +0000, ruansy.fnst@fujitsu.com wrote:
>>>>>> 在 2022/7/1 8:31, Darrick J. Wong 写道:
>>>>>>> On Thu, Jun 09, 2022 at 10:34:35PM +0800, Shiyang Ruan wrote:
>>>>>>>> Failure notification is not supported on partitions.  So, when we mount
>>>>>>>> a reflink enabled xfs on a partition with dax option, let it fail with
>>>>>>>> -EINVAL code.
>>>>>>>>
>>>>>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>>>>>
>>>>>>> Looks good to me, though I think this patch applies to ... wherever all
>>>>>>> those rmap+reflink+dax patches went.  I think that's akpm's tree, right?
>>>>>>>
>>>>>>> Ideally this would go in through there to keep the pieces together, but
>>>>>>> I don't mind tossing this in at the end of the 5.20 merge window if akpm
>>>>>>> is unwilling.
>>>>>>
>>>>>> BTW, since these patches (dax&reflink&rmap + THIS + pmem-unbind) are
>>>>>> waiting to be merged, is it time to think about "removing the
>>>>>> experimental tag" again?  :)
>>>>>
>>>>> It's probably time to take up that question again.
>>>>>
>>>>> Yesterday I tried running generic/470 (aka the MAP_SYNC test) and it
>>>>> didn't succeed because it sets up dmlogwrites atop dmthinp atop pmem,
>>>>> and at least one of those dm layers no longer allows fsdax pass-through,
>>>>> so XFS silently turned mount -o dax into -o dax=never. :(
>>>>
>>>> Hi Darrick,
>>>>
>>>> I tried generic/470 but it didn't run:
>>>>      [not run] Cannot use thin-pool devices on DAX capable block devices.
>>>>
>>>> Did you modify the _require_dm_target() in common/rc?  I added thin-pool
>>>> to not to check dax capability:
>>>>
>>>>            case $target in
>>>>            stripe|linear|log-writes|thin-pool)  # add thin-pool here
>>>>                    ;;
>>>>
>>>> then the case finally ran and it silently turned off dax as you said.
>>>>
>>>> Are the steps for reproduction correct? If so, I will continue to
>>>> investigate this problem.
>>>
>>> Ah, yes, I did add thin-pool to that case statement.  Sorry I forgot to
>>> mention that.  I suspect that the removal of dm support for pmem is
>>> going to force us to completely redesign this test.  I can't really
>>> think of how, though, since there's no good way that I know of to gain a
>>> point-in-time snapshot of a pmem device.
>>
>> Hi Darrick,
>>
>>   > removal of dm support for pmem
>> I think here we are saying about xfstest who removed the support, not
>> kernel?
>>
>> I found some xfstests commits:
>> fc7b3903894a6213c765d64df91847f4460336a2  # common/rc: add the restriction.
>> fc5870da485aec0f9196a0f2bed32f73f6b2c664  # generic/470: use thin-pool
>>
>> So, this case was never able to run since the second commit?  (I didn't
>> notice the not run case.  I thought it was expected to be not run.)
>>
>> And according to the first commit, the restriction was added because
>> some of dm devices don't support dax.  So my understanding is: we should
>> redesign the case to make the it work, and firstly, we should add dax
>> support for dm devices in kernel.
> 
> dm devices used to have fsdax support; I think Christoph is actively
> removing (or already has removed) all that support.
> 
>> In addition, is there any other testcase has the same problem?  so that
>> we can deal with them together.
> 
> The last I checked, there aren't any that require MAP_SYNC or pmem aside
> from g/470 and the three poison notification tests that you sent a few
> days ago.

Ok.  Got it.  Thank you!


--
Ruan.

> 
> --D
> 
>>
>> --
>> Thanks,
>> Ruan
>>
>>
>>>
>>> --D
>>>
>>>>
>>>> --
>>>> Thanks,
>>>> Ruan.
>>>>
>>>>
>>>>
>>>>>
>>>>> I'm not sure how to fix that...
>>>>>
>>>>> --D
>>>>>
>>>>>>
>>>>>> --
>>>>>> Thanks,
>>>>>> Ruan.
>>>>>>
>>>>>>>
>>>>>>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>>>>>>>
>>>>>>> --D
>>>>>>>
>>>>>>>> ---
>>>>>>>>      fs/xfs/xfs_super.c | 6 ++++--
>>>>>>>>      1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>>>>>>>> index 8495ef076ffc..a3c221841fa6 100644
>>>>>>>> --- a/fs/xfs/xfs_super.c
>>>>>>>> +++ b/fs/xfs/xfs_super.c
>>>>>>>> @@ -348,8 +348,10 @@ xfs_setup_dax_always(
>>>>>>>>      		goto disable_dax;
>>>>>>>>      	}
>>>>>>>>      
>>>>>>>> -	if (xfs_has_reflink(mp)) {
>>>>>>>> -		xfs_alert(mp, "DAX and reflink cannot be used together!");
>>>>>>>> +	if (xfs_has_reflink(mp) &&
>>>>>>>> +	    bdev_is_partition(mp->m_ddev_targp->bt_bdev)) {
>>>>>>>> +		xfs_alert(mp,
>>>>>>>> +			"DAX and reflink cannot work with multi-partitions!");
>>>>>>>>      		return -EINVAL;
>>>>>>>>      	}
>>>>>>>>      
>>>>>>>> -- 
>>>>>>>> 2.36.1
>>>>>>>>
>>>>>>>>
>>>>>>>>
