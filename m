Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9C706F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEQRNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQRNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 13:13:44 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD683C30;
        Wed, 17 May 2023 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1684343620; i=@fujitsu.com;
        bh=a+C4Lijc0DDX2QslyttoIa32t1xmY+p+E/ypLSLFsew=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=efNFUU4wejhU40SDNCvs8h77b0phW72mg/TmKepDUZExicQsnitkwFBGd8Rmg6Axf
         c5nWUG257zQJkYffE9MxtoXeo/64Mvf6+SxPgrDfpurFT9e21UK552GX9a8YqVXzui
         XNwNfvvQSOktIHrPG/AqyBe4o1h28xcoJaJjNSJtYz2RAtL0/EICwmGmZ6ETJqT7rR
         FaDePHTduuh3SvyqZrLYI8hH1UDdjvE9xQQuQ2rlCp93PMHCkFjX7UqGjBM/HFtaoG
         e6Wz1uCNaFGxrgh+2pZ4qGnqakHvBs5S1h0KXS/VEO9m7VoTEkFu91htQzee+gBzOQ
         00MU3oUb4ipvA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRWlGSWpSXmKPExsViZ8ORqOvMnZp
  i8Oi5usW2dbvZLS4/4bN4vnwxo8WevSdZLHb92cFucWPCU0YHNo9NqzrZPN7vu8rmsX7LVRaP
  z5vkAliiWDPzkvIrElgzPq5tZCxYplhxaOkJ1gbG51JdjFwcQgJbGCXOf+9kgXBWMEkcPvcGy
  tnKKLH12G22LkZODl4BO4mT59aA2SwCqhKHJr9hhIgLSpyc+YQFxBYVSJGYsXExM4gtLBApMe
  94F5gtIhAg0bBiHyvIUGaBNkaJqwd/Q23YySjxYdZbJpAqNgEdiQsL/rKC2JwCZhJLb+4A28Y
  sYCGx+M1BdghbXqJ562ywqRICChI3Jq1igbCrJC6+n8kGYatJXD23iXkCo9AsJAfOQjJqFpJR
  CxiZVzGaFqcWlaUW6ZroJRVlpmeU5CZm5uglVukm6qWW6panFpfoGukllhfrpRYX6xVX5ibnp
  OjlpZZsYgRGT0qxUscOxus7/+odYpTkYFIS5a3ZmJIixJeUn1KZkVicEV9UmpNafIhRhoNDSY
  J3EntqipBgUWp6akVaZg4wkmHSEhw8SiK87GxAad7igsTc4sx0iNQpRl2Ojy+nHmQWYsnLz0u
  VEufdwwVUJABSlFGaBzcCllQuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmfcIJNIUnM68E
  btMroCOYgI4o3ZgMckRJIkJKqoFpgZDpiZ++PFtYXdh/hMX0XjIP1ta6F+e1PNyqXfXym8U6M
  5Yc3B3VXfXU4rvX3KQXES6qMWHqjz6/5fzPtdLohYjpo1ncXj+2TAg66v7vRJ8Se5Zua8DTa2
  tM1wr8fMyn271u1fa9TzR4tS/ODeAxCraNT2a9YXqrVtZS8iVrknyypQFHqNH9B1mbkjOZnaQ
  mGD085OEgYaI66+OUBxfvLbxVfEVd6csb3xPaT5/WdE/+8KjrgbB474P9uVztlbHvmr6ZKd08
  kSMqu/nfsnDWiFkzvkW/UvhayzXlyvIf03h4kwJjnijFnX8lmRyQc7+w839AQfALzX0Caksbl
  XWdTpn7zdhw84hYA1djbKESS3FGoqEWc1FxIgCb4fJSpQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-18.tower-548.messagelabs.com!1684343619!26996!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4559 invoked from network); 17 May 2023 17:13:39 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-18.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 May 2023 17:13:39 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 546A9100191;
        Wed, 17 May 2023 18:13:39 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 473C3100043;
        Wed, 17 May 2023 18:13:39 +0100 (BST)
Received: from [10.167.201.2] (10.167.201.2) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 17 May 2023 18:13:35 +0100
Message-ID: <0456fe2d-889d-b2e2-57c0-2dfb1f626339@fujitsu.com>
Date:   Thu, 18 May 2023 01:13:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] vfs: allow filesystem freeze callers to denote who
 froze the fs
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
References: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
 <168308293892.734377.10931394426623343285.stgit@frogsfrogsfrogs>
 <ZFc1wVFeHsi7rK01@bombadil.infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ZFc1wVFeHsi7rK01@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.201.2]
X-ClientProxiedBy: G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/5/7 13:23, Luis Chamberlain 写道:
> On Tue, May 02, 2023 at 08:02:18PM -0700, Darrick J. Wong wrote:
>> diff --git a/fs/super.c b/fs/super.c
>> index 04bc62ab7dfe..01891f9e6d5e 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1736,18 +1747,33 @@ int freeze_super(struct super_block *sb)
>>   	up_write(&sb->s_umount);
>>   	return 0;
>>   }
>> +
>> +/*
>> + * freeze_super - lock the filesystem and force it into a consistent state
>> + * @sb: the super to lock
>> + *
>> + * Syncs the super to make sure the filesystem is consistent and calls the fs's
>> + * freeze_fs.  Subsequent calls to this without first thawing the fs will return
>> + * -EBUSY.  See the comment for __freeze_super for more information.
>> + */
>> +int freeze_super(struct super_block *sb)
>> +{
>> +	return __freeze_super(sb, USERSPACE_FREEZE_COOKIE);
>> +}
>>   EXPORT_SYMBOL(freeze_super);
>>   
>> -static int thaw_super_locked(struct super_block *sb)
>> +static int thaw_super_locked(struct super_block *sb, unsigned long cookie)
>>   {
>>   	int error;
>>   
>> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
>> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
>> +	    sb->s_writers.freeze_cookie != cookie) {
>>   		up_write(&sb->s_umount);
>>   		return -EINVAL;
> 
> We get the same by just having drivers use freeze_super(sb, true) in the
> patches I have, ie, we treat it a user-initiated.
> 
> On freeze() we have:
> 
> int freeze_super(struct super_block *sb, bool usercall)
> {
> 	int ret;
> 	
> 	if(!usercall && sb_is_frozen(sb))
> 		return 0;
> 
> 	if (!sb_is_unfrozen(sb))
> 	return -EBUSY;
> 	...
> }
> 
> On thaw we end up with:
> 
> int thaw_super(struct super_block *sb, bool usercall)
> {
> 	int error;
> 
> 	if (!usercall) {
> 		/*
> 		 * If userspace initiated the freeze don't let the kernel
> 		 *  thaw it on return from a kernel initiated freeze.
> 		 */
> 		 if (sb_is_unfrozen(sb) || sb_is_frozen_by_user(sb))
> 		 	return 0;
> 	}
> 
> 	if (!sb_is_frozen(sb))
> 		return -EINVAL;
> 	...
> }
> 
> As I had it, I had made the drivers and the bdev freeze use the usercall as
> true and so there is no change.
> 
> In case there is a filesystem already frozen then which was initiated by
> the filesystem, for whatever reason, the filesystem the kernel auto-freeze
> will chug on happy with the system freeze, it bails out withour error
> and moves on to the next filesystem to freeze.
> 
> Upon thaw, the kernel auto-thaw will detect that the filesystem was
> frozen by user on sb_is_frozen_by_user() and so will just bail and not
> thaw it.

Hi, Luis

Thanks for the great idea.  I also need this upgraded API for a unbind 
mechanism on pmem device, which is finally called in 
xfs_notify_failure.c where we want to freeze the fs to prevent any other 
new file mappings from being created.  In my case, I think we should 
think it as a kernel-initiated freeze, and hope it won't be thaw by 
others, especially userspace-initiated thaw.

In my understanding of your implementation, if there is a 
userspace-initiated thaw, with @usercall is set true, thaw_super(sb, 
true) will ignore any others' freeze and thaw the fs anyway.  But, 
except in my case, I think the order of userspace-initiated freeze/thaw 
may be messed up due to bugs in the user app, then the kernel-initiated 
freeze state could be accidentally broken...  In my opinion, the kernel 
code is more reliable.  Therefore, kernel-initiated freeze should be 
exclusive at least.


--
Thanks,
Ruan.

> 
> If the mechanism you want to introduce is to allow a filesystem to even
> prevent kernel auto-freeze with -EBUSY it begs the question if that
> shouldn't also prevent suspend. Because it would anyway as you have it
> right now with your patch but it would return -EINVAL. I also ask because of
> the possible issues with the filesystem not going to suspend but the backing
> or other possible related devices going to suspend.
> 
> Since I think the goal is to prevent the kernel auto-freeze due to
> online fsck to complete, then I think you *do* want to prevent full
> system suspend from moving forward. In that case, why not just have
> the filesystem check for that and return -EBUSY on its respective
> filesystem sb->s_op->freeze_fs(sb) callback?
> 
>    Luis
