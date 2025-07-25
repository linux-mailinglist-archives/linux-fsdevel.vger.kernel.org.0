Return-Path: <linux-fsdevel+bounces-56057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5BB126D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B623AEACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20A255E2F;
	Fri, 25 Jul 2025 22:22:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541827470;
	Fri, 25 Jul 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482144; cv=none; b=j/+xr/+JBYQVs/tmX4YWXiaOvSNwQG79B11QoiFLm6zTh6PqdneA+4iFrUeYyTqibyDBTueG1cv0lHaSOa+j5uxHMuk6D06xXeBMAOQKbjLWKY8OCG1zfq0CvJSnOg10FtbNHUt1JT8reIsipPK5lJS9Db51FempvkwTw7YNc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482144; c=relaxed/simple;
	bh=lFFLlRkX+9KJb+HAAy1ydEvV3EqdGHy+GY0S2G+536c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dc16Awn2z5sZHK6Qy3rZlNUdbRlrSX5639P8Jh7W0zHyPm3VC1Ve4Ldv/ECL0AK55Jt/ZJ/2Wwhl7xpC9d+nSpB9tQZadat3b1GnsjSj67FOkn0Utd4S0IwJi9dCjBmtrtSsmC1sf9jxYy1Iu2wcGoQGP33QILN9K4vOVrdexC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56PMM4ir051778;
	Sat, 26 Jul 2025 07:22:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56PMM4YX051775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Jul 2025 07:22:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e6f71dcc-80e0-4cfe-91cf-8adb4d4effb7@I-love.SAKURA.ne.jp>
Date: Sat, 26 Jul 2025 07:22:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <2103722d0e10bbd71ad6f93550668cea717381bc.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2103722d0e10bbd71ad6f93550668cea717381bc.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/26 2:42, Viacheslav Dubeyko wrote:
>>>
>>> I don't see any sense to introduce flags here. First of all, please, don't use
>>> hardcoded values but you should use declared constants from hfs.h (for example,
>>> HFS_EXT_CNID instead of 3). Secondly, you can simply compare the i_ino with
>>> constants, for example:
>>
>> This will save a lot of computational power compared to switch().
>>
> 
> Even if you would like to use flags, then the logic must to be simple and
> understandable. You still can use special inline function and do not create a
> mess in hfs_read_inode(). Especially, you can declare the mask one time in
> header, for example, but not to prepare the bad_cnid_list for every function
> call. Currently, the code looks really messy.

No, since this is "static const u16", the compiler will prepare it at build time
than every function call. Also since it is a simple u16, the compiler would
generate simple code like

  test ax, an_imm16_constant_value_determined_at_build_time
  jnz somewhere

which is much faster than

  cmp eax, HFS_EXT_CNID
  je somewhere
  cmp eax, other_cnid_1
  je somewhere
  cmp eax, other_cnid_2
  je somewhere
  cmp eax, other_cnid_3
  je somewhere
  cmp eax, other_cnid_4
  je somewhere

based on switch() in is_inode_id_invalid() shown below.

We can replace "static const u16" with "#define" if you prefer.

> 
>>>
>>> bool is_inode_id_invalid(u64 ino) {
>>>       switch (inode->i_ino) {
>>>       case HFS_EXT_CNID:
>>>       ...
>>>           return true;
>>>
>>>       }
>>>
>>>       return false;
>>> }



> So, 1, 2, 5, 15, etc can be accepted by hfs_read_inode().
> 0, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14 is invalid values for hfs_read_inode().

OK. This list will be useful for hardening, but we can't use this list for fixing
the bug reported at https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b .


