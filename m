Return-Path: <linux-fsdevel+bounces-33213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B59B5914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58371F24278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EE175D5E;
	Wed, 30 Oct 2024 01:24:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96351EB56;
	Wed, 30 Oct 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251440; cv=none; b=f4hFHPlXM0i8kUMud0teAh1ztcd/xykBy7XTfzXf4wZiy6vac6TpkA1sCSiE86nzGnxZKKrxNXqr4IUftIkKBOjebXw9c+8ckJKH8m6PU5fV/C7bakLDL+FADnkGKPlTWzIyImpwiszxnjht3Cgv/a3S6dD9jwGoACgeLAxCdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251440; c=relaxed/simple;
	bh=lL8V5NUty93r1YUOPhe1iJCGajKaCXQAsHnJQX05T48=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFL+dJqoy/iWJjw+MfM0ILx/znY5gu1+m0C4qmMkrl63nFLvIGhoPJIFW76iWtvxp7TkfhvprgJX/NYMeoN1ya/K07eaW9MnjvasZlvwfkj42/gpvu449oXYUHggHo4L3Uu+1U302g4M23R5I++zeDMDkmWz7lF4ZGaSPyOfKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 5FD84100A5D;
	Wed, 30 Oct 2024 12:23:55 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NO2CKg0sGOBV; Wed, 30 Oct 2024 12:23:55 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 53425100A4C; Wed, 30 Oct 2024 12:23:55 +1100 (AEDT)
X-Spam-Level: 
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 638541009D6;
	Wed, 30 Oct 2024 12:23:53 +1100 (AEDT)
Message-ID: <a7e37f27-828f-4349-a990-c1fa119545b7@themaw.net>
Date: Wed, 30 Oct 2024 09:23:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2 (new
 mount APIs)
From: Ian Kent <raven@themaw.net>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, sandeen@redhat.com,
 Zorro Lang <zlang@redhat.com>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
 <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZyAasz2RBpMpGV8T@dread.disaster.area>
 <27b60bdf-435d-442a-842d-410bb9cc68c3@themaw.net>
 <6ea31595-7d95-4ad5-a46e-c90872813dcf@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <6ea31595-7d95-4ad5-a46e-c90872813dcf@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey, Amir, Miklos,


On 29/10/24 14:13, Ian Kent wrote:
>
> On 29/10/24 13:44, Ian Kent wrote:
>> On 29/10/24 07:13, Dave Chinner wrote:
>>> On Tue, Oct 29, 2024 at 03:28:04AM +0800, Zorro Lang wrote:
>>>> On Mon, Oct 28, 2024 at 01:22:52PM +0100, Christian Brauner wrote:
>>>>> On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Recently, I hit lots of fstests cases fail on overlayfs (xfs 
>>>>>> underlying, no
>>>>>> specific mount options), e.g.
>>>>>>
>>>>>> FSTYP         -- overlay
>>>>>> PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri 
>>>>>> Oct 25 14:29:18 EDT 2024
>>>>>> MKFS_OPTIONS  -- -m 
>>>>>> crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 
>>>>>> /mnt/fstests/SCRATCH_DIR
>>>>>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 
>>>>>> /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
>>>>>>
>>>>>> generic/294       [failed, exit status 1]- output mismatch (see 
>>>>>> /var/lib/xfstests/results//generic/294.out.bad)
>>>>>>      --- tests/generic/294.out    2024-10-25 14:38:32.098692473 
>>>>>> -0400
>>>>>>      +++ /var/lib/xfstests/results//generic/294.out.bad 
>>>>>> 2024-10-25 15:02:34.698605062 -0400
>>>>>>      @@ -1,5 +1,5 @@
>>>>>>       QA output created by 294
>>>>>>      -mknod: SCRATCH_MNT/294.test/testnode: File exists
>>>>>>      -mkdir: cannot create directory 
>>>>>> 'SCRATCH_MNT/294.test/testdir': File exists
>>>>>>      -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': 
>>>>>> Read-only file system
>>>>>>      -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': 
>>>>>> File exists
>>>>>>      +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system 
>>>>>> call failed: overlay: No changes allowed in reconfigure.
>>>>>>      +       dmesg(1) may have more information after failed 
>>>>>> mount system call.
>>>>> In the new mount api overlayfs has been changed to reject invalid 
>>>>> mount
>>>>> option on remount whereas in the old mount api we just igorned them.
>>>> Not only g/294 fails on new mount utils, not sure if all of them 
>>>> are from same issue.
>>>> If you need, I can paste all test failures (only from my side) at 
>>>> here.
>>>>
>>>>> If this a big problem then we need to change overlayfs to continue
>>>>> ignoring garbage mount options passed to it during remount.
>>>> Do you mean this behavior change is only for overlayfs, doesn't 
>>>> affect other fs?
>>> We tried this with XFS years ago, and reverted back to the old
>>> behaviour of silently ignoring mount options we don't support in
>>> remount. The filesystem code has no idea what mount API
>>> userspace is using for remount - it can't assume that it is ok to
>>> error out on unknown/unsupported options because it uses
>>> the fsreconfigure API internally....
>>
>> I expect that remounting to change options for overlayfs has very 
>> limited use
>>
>> cases. Perhaps remounting (the upper layer) read-only is useful ...
>
> Actually, my mistake, it looks like remount read-only might be the 
> only case that should
>
> be handled (provided the sb is not already read-only). In this case it 
> does a file system
>
> sync and returns the result of that but now fails unconditionally in 
> fsconfig().

What is the right thing to do here for overlayfs?

Does it even make sense to remount overlayfs to change mount options?


The file system sync on read-only-remount seems worth while so assuming 
it is kept

what should be returned from other remount requests, fail or silently 
fail as before?


Ian

>
>
>>
>>
>> The problem here is that xfstests wants to remount the mount 
>> read-only in this
>>
>> test which has never actually been done so xfstests reporting a 
>> failure has no
>>
>> value!
>>
>>
>> Ian
>>

