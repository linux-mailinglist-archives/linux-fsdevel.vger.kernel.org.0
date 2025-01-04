Return-Path: <linux-fsdevel+bounces-38377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD45A011F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 03:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264D416471F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455E126C08;
	Sat,  4 Jan 2025 02:41:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117971F92A;
	Sat,  4 Jan 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735958496; cv=none; b=muW8S8pobqBseRCJNv/EM6l3+Q4jzhpTbJULxE+5J25wDtNoiQE63krx67+7AVa9jfoy8UPbE0mkxTBL699QhLnGpiP/YsYI2try6wmLA3CKC8I/01YGM1BEkU8fXP2FWmWAtPVwmWUU1OPXMBtRJVepsQv+NtaqJ68EJPlH0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735958496; c=relaxed/simple;
	bh=P17ZKE8IdzIOrtVVFRzvpTeOG9MabmcqW2X8NxgYLl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oaeCr1PetVW7Xh3GV2i4g+n6Bf/ms/k5mWrbYmKAklevTTAQHblAoNUko+klCpq+Yew6FolsxwtxLr/h6U/tqSy03fFgsmvs8mMRj1ethq1P8IfF05sEex7PXzWJaVWjamsCfJ247QhzUZKZpQM6oiVpm0m97Vwfzja44P0jpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YQ4Nx317Fzcbpd;
	Sat,  4 Jan 2025 10:37:53 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id DF6DE14011A;
	Sat,  4 Jan 2025 10:41:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 4 Jan
 2025 10:41:28 +0800
Message-ID: <5eb2ad64-c6ea-45f8-9ba1-7de5c68d59aa@huawei.com>
Date: Sat, 4 Jan 2025 10:41:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtCVUcgUkVQT1JUXSBleHQ0OiDigJxlcnJvcnM9cmVtb3VudC1y?=
 =?UTF-8?B?b+KAnSBoYXMgYmVjb21lIOKAnGVycm9ycz1zaHV0ZG93buKAnT8=?=
To: Theodore Ts'o <tytso@mit.edu>
CC: Jan Kara <jack@suse.cz>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<sunyongjian1@huawei.com>, Yang Erkun <yangerkun@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <20250103153517.GB1284777@mit.edu> <20250103155406.GC1284777@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250103155406.GC1284777@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Ted,

On 2025/1/3 23:54, Theodore Ts'o wrote:
> On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
>> I don't see how setting the shutdown flag causes reads to fail.  That
>> was true in an early version of the ext4 patch which implemented
>> shutdown support, but one of the XFS developers (I don't remember if
>> it was Dave or Cristoph) objected because XFS did not cause the
>> read_pages function to fail.  Are you seeing this with an upstream
>> kernel, or with a patched kernel?  The upstream kernel does *not* have
>> the check in ext4_readpages() or ext4_read_folio() (post folio
>> conversion).
> OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:
>
> root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
> /dev/vdc contains a ext4 file system
> 	last mounted on /vdc on Fri Jan  3 10:38:21 2025
> root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
We are discussing "errors=remount-ro," as the title states, not the
continue mode. The key code leading to the behavior change is as follows,
therefore the continue mode is not affected.

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -657,7 +657,7 @@ static void ext4_handle_error(struct super_block 
*sb, bool force_ro, int error,
                 WARN_ON_ONCE(1);

         if (!continue_fs && !sb_rdonly(sb)) {
-               ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
+               set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
                 if (journal)
                         jbd2_journal_abort(journal, -EIO);
         }

See the end for problem reproduction.

> [   24.780982] EXT4-fs (vdc): mounted filesystem f8595206-fe57-486c-80dd-48b03d41ebdb r/w with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# cp /etc/motd /vdc/motd
> root@kvm-xfstests:~# echo testing > /sys/fs/ext4/vdc/trigger_fs_error
> [   42.943141] EXT4-fs error (device vdc): trigger_test_error:129: comm bash: testing
> root@kvm-xfstests:~# cat /vdc/motd
>
> The programs included with the Debian GNU/Linux system are free software;
> the exact distribution terms for each program are described in the
> individual files in /usr/share/doc/*/copyright.
>
> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> permitted by applicable law.
> root@kvm-xfstests:~#
>
>
> HOWEVER, testing with shutdown ioctl, both ext4 and xfs are failing with EIO:
Yes, this is as expected.
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> [    7.969168] XFS (vdc): Mounting V5 Filesystem 7834ea96-eab0-46c5-9b18-c8f054fa9cf4
> [    7.978539] XFS (vdc): Ending clean mount
> root@kvm-xfstests:~# cp /etc/motd /vdc
> root@kvm-xfstests:~# /root/xfstests/src/godown -v /vdc
> Opening "/vdc"
> Calling XFS_IOC_GOINGDOWN
> [   29.354609] XFS (vdc): User initiated shutdown received.
> [   29.356123] XFS (vdc): Log I/O Error (0x6) detected at xfs_fs_goingdown+0x55/0xb0 (fs/xfs/xfs_fsops.c:452).  Shutting down filesystem.
> [   29.357092] XFS (vdc): Please unmount the filesystem and rectify the problem(s)
> root@kvm-xfstests:~# cat /vdc/motd
> cat: /vdc/motd: Input/output error
> root@kvm-xfstests:~#
>
> So I take back what I said earlier, but I am a bit confused why it
> worked after simulating an file system error using "echo testing >
> /sys/fs/ext4/vdc/trigger_fs_error".
>
It's because "errors=remount-ro" wasn't used when mounting...

Here's a replication:

root@kvm-xfstests:~# mount -o errors=remount-ro /dev/vdc /mnt/test
[  115.731007] EXT4-fs (vdc): mounted filesystem 
0838f08f-c04e-440c-a9a5-417677efb03e r/w with ordered data mode. Quota 
mode: none.
root@kvm-xfstests:~# echo test > /mnt/test/file
root@kvm-xfstests:~# cat /mnt/test/file
test
root@kvm-xfstests:~# echo 1 > /sys/fs/ext4/vdc/trigger_fs_error
[  131.537649] EXT4-fs error (device vdc): trigger_test_error:129: comm 
bash: 1
[  131.538226] Aborting journal on device vdc-8.
[  131.538844] EXT4-fs (vdc): Remounting filesystem read-only
root@kvm-xfstests:~# cat /mnt/test/file
cat: /mnt/test/file: Input/output error
root@kvm-xfstests:~# uname -a
Linux kvm-xfstests 6.13.0-rc4-xfstests-g6cfe3548f8f5-dirty #284 SMP 
PREEMPT_DYNAMIC Fri Dec 27 10:39:02 CST 2024 x86_64 GNU/Linux


Regards,
Baokun


