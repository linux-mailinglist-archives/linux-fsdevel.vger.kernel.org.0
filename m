Return-Path: <linux-fsdevel+bounces-926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5B7D3841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C5B20D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B01A262;
	Mon, 23 Oct 2023 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667E134A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 13:40:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141C91;
	Mon, 23 Oct 2023 06:40:48 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SDbmp6R1Bzcdmh;
	Mon, 23 Oct 2023 21:35:54 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 21:40:44 +0800
Message-ID: <0c2de951-cd14-f1c7-fd9b-697563ad8092@huawei.com>
Date: Mon, 23 Oct 2023 21:40:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook
	<keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>, yangerkun
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
 <826dbab6-f6e0-fc02-e5d3-141c00a2a141@huawei.com>
 <ZTZktSo8oIUD5unq@smile.fi.intel.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZTZktSo8oIUD5unq@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

Hello!

On 2023/10/23 20:19, Andy Shevchenko wrote:
> On Sat, Oct 21, 2023 at 09:48:38AM +0800, Baokun Li wrote:
>> On 2023/10/20 23:06, Andy Shevchenko wrote:
>>> On Fri, Oct 20, 2023 at 05:51:59PM +0300, Andy Shevchenko wrote:
>>>> On Thu, Oct 19, 2023 at 11:43:47AM -0700, Linus Torvalds wrote:
> ...
>
>>>> I even rebuilt again with just rebased on top of e64db1c50eb5 and it doesn't
>>>> boot, so we found the culprit that triggers this issue.
>> This patch does not seem to cause this problem. Just like linus said, this
>> patch
>> has only two slight differences from the previous:
>> 1) Change "if (err)" to "if (err < 0)"
>>      In all the implementations of dq_op->write_dquot(), the returned value
>> of err
>>      is not greater than 0. Therefore, this does not cause behavior
>> inconsistency.
>> 2) Adding quota_error()
>>      quota_error() does not seem to cause a boot failure.
>>
>> Also, you mentioned that the root file system is initramfs. If no other file
>> system
>> that supports quota is automatically mounted during startup, it seems that
>> quota
>> does not cause this problem logically.
>>
>> In my opinion, as Josh mentioned, replace the CONFIG_DEBUG_LIST related
>> BUG()/BUG_ON() with WARN_ON(), and then check whether the system can be
>> started normally. If yes, it indicates that the panic is caused by the list
>> corruption, then, check for the items that may damage the list. If WARN_ON()
>> is recorded in the dmesg log of the machine after the startup, it is easier
>> to locate the problem.
> I mentioned that I have checked that, but okay, lemme double check it.
> I took the test-mrfld-jr branch and applied that patch on top.
> And as expected no luck.
By "okay" do you mean that after replacing BUG()/BUG_ON() with WARN_ON()
you can boot up normally but don't see any prints, or does the 
replacement have
no effect and still fails to boot up?
> fstab I have, btw is this
>
> $ cat output/target/etc/fstab
> # <file system> <mount pt>      <type>  <options>       <dump>  <pass>
> /dev/root       /               ext2    rw,noauto       0       1
> proc            /proc           proc    defaults        0       0
> devpts          /dev/pts        devpts  defaults,gid=5,mode=620,ptmxmode=0666   0       0
> tmpfs           /dev/shm        tmpfs   mode=0777       0       0
> tmpfs           /tmp            tmpfs   mode=1777       0       0
> tmpfs           /run            tmpfs   mode=0755,nosuid,nodev  0       0
> sysfs           /sys            sysfs   defaults        0       0
>
> Not sure if /dev/root affects this all, it's Buildroot + Busybox in initramfs
> at the end.
>
> On the booted machine
> (clang build of my main branch, based on the latest -rcX):
>
> Welcome to Buildroot
> buildroot login: root
>
> # uname -a
> Linux buildroot 6.6.0-rc7-00142-g9266a02ba229 #28 SMP PREEMPT_DYNAMIC Mon Oct 23 15:00:17 EEST 2023 x86_64 GNU/Linux
>
> # mount
> rootfs on / type rootfs (rw,size=453412k,nr_inodes=113353)
> devtmpfs on /dev type devtmpfs (rw,relatime,size=453412k,nr_inodes=113353,mode=755)
> proc on /proc type proc (rw,relatime)
> devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=666)
> tmpfs on /dev/shm type tmpfs (rw,relatime,mode=777)
> tmpfs on /tmp type tmpfs (rw,relatime)
> tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,mode=755)
> sysfs on /sys type sysfs (rw,relatime)
>
> What is fishy here is the size of rootfs, it's only 30M compressed side,
> I can't be ~450M decompressed. I just noticed this, dunno if it's related.
>
Of the filesystems mounted above, only ext2 (aka rootfs) supports quota,
but it doesn't appear to have quota enabled.
If the quota change is causing ext2 to fail to load the root directory,
you can now do the following checks:

1) Compare the binary generated by ext2  before and after the quota patch.
2) `dumpe2fs -h /dev/root` to see if there are any useful error messages
saved on disk superblock.

Thanks!
-- 
With Best Regards,
Baokun Li
.

