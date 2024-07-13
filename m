Return-Path: <linux-fsdevel+bounces-23633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245C9304BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 11:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563991C212A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85D4CB4E;
	Sat, 13 Jul 2024 09:33:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51E14006;
	Sat, 13 Jul 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720863232; cv=none; b=k36fOj9du/nGFTDmnh9JjGgyKHUFOJ824XYvODiA7YbRtHikj70r1lscCGp5DSVOyAf40//umRdtm+XR+IymZP7B0VlcmBc7InIcd5QLANqMSxQ5HfKXvax6C79Kun7oOfnNGNsK/DOjbaxc8fyDcXu1D4iOFpUJpjfxM3ChswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720863232; c=relaxed/simple;
	bh=qP+ZWRJw9XdA41KriPewH6eyrYWfvyN3N5xFr5B/tRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMNmjc2Vhvz4aD6P8WwukqcItSyZT5VuuhNyh9KhabmkRFwy6xLFhFWo0tdxJZE2NeoLYVBX5I4W+WjpSCBBJe4vkXWGN7A0/BiDfI53Iiu7zYqzIvgDmUvnCRZNXlF0PhlDoxmCqFJtYvqBwGqg+Ec3c/9MYby0ka76IrkGH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WLjvL2M1hz4f3jcr;
	Sat, 13 Jul 2024 17:33:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E1731A0181;
	Sat, 13 Jul 2024 17:33:46 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgCHazn3SZJmNY0DAA--.2101S3;
	Sat, 13 Jul 2024 17:33:45 +0800 (CST)
Message-ID: <afa05166-6def-d3ac-dd22-8b605f5e37d7@huaweicloud.com>
Date: Sat, 13 Jul 2024 17:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH RFC 2/2] NFSv4: set sb_flags to second superblock
To: dhowells@redhat.com, marc.dionne@auristor.com, raven@themaw.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
 trond.myklebust@hammerspace.com, anna@kernel.org, sfrench@samba.org,
 pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 tom@talpey.com, bharathsm@microsoft.com, djwong@kernel.org
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 zhangxiaoxu5@huawei.com, lilingfeng3@huawei.com
References: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
 <20240604112636.236517-3-lilingfeng@huaweicloud.com>
 <ca71d3c4-0b87-8a1e-a442-236d91674a87@huaweicloud.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <ca71d3c4-0b87-8a1e-a442-236d91674a87@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazn3SZJmNY0DAA--.2101S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1xuFW5JF15Cr1fKr4kWFg_yoW5KF13pF
	WxAFyjkrWkJF18Wa10yFZ5Xa4Sv348Za1UJFn3Zas7ZrWUXrn2q3W2grWYgFy8Zr4xur1U
	XF48tF13uF13AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0S
	jxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04xRDUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Friendly ping ...

Thanks

在 2024/6/14 11:14, Li Lingfeng 写道:
> I think this may be a problem, but I'm unable to come up with a 
> suitable solution. Would you mind providing some suggestions?
>
> 在 2024/6/4 19:26, Li Lingfeng 写道:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> During the process of mounting an NFSv4 client, two superblocks will be
>> created in sequence. The first superblock corresponds to the root
>> directory exported by the server, and the second superblock 
>> corresponds to
>> the directory that will be actually mounted. The first superblock will
>> eventually be destroyed.
>> The flag passed from user mode will only be passed to the first
>> superblock, resulting in the actual used superblock not carrying the 
>> flag
>> passed from user mode(fs_context_for_submount() will set sb_flags as 0).
>>
>> If the 'ro' parameter is used in two consecutive mount commands, only 
>> the
>> first execution will create a new vfsmount, and the kernel will return
>> EBUSY on the second execution. However, if a remount command with the 
>> 'ro'
>> parameter is executed between the two mount commands, both mount 
>> commands
>> will create new vfsmounts.
>>
>> The superblock generated after the first mount command does not have the
>> 'ro' flag, and the read-only status of the file system is implemented by
>> checking the read-only flag of the vfsmount. After executing the remount
>> command, the 'ro' flag will be added to the superblock. When the second
>> mount command is executed, the comparison result between the superblock
>> with the 'ro' flag and the fs_context without the flag in the
>> nfs_compare_mount_options() function will be different, resulting in the
>> creation of a new vfsmount.
>>
>> This problem can be reproduced by performing the following operations:
>> mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
>> mount -t nfs -o remount,ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
>> mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
>> Two vfsmounts are generated:
>> [root@localhost ~]# mount | grep nfs
>> 192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
>> rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2, 
>>
>> sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)
>> 192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
>> rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2, 
>>
>> sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)
>>
>> Fix this by setting sb_flags to second superblock.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/namespace.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
>> index 887aeacedebd..8b3d75af60d4 100644
>> --- a/fs/nfs/namespace.c
>> +++ b/fs/nfs/namespace.c
>> @@ -158,7 +158,7 @@ struct vfsmount *nfs_d_automount(struct path 
>> *path, unsigned int sb_flags)
>>       /* Open a new filesystem context, transferring parameters from the
>>        * parent superblock, including the network namespace.
>>        */
>> -    fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, 
>> path->dentry, 0);
>> +    fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, 
>> path->dentry, sb_flags);
>>       if (IS_ERR(fc))
>>           return ERR_CAST(fc);


