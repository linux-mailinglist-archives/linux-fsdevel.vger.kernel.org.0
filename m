Return-Path: <linux-fsdevel+bounces-17471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4308ADDF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D771B231D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE912BCF9;
	Tue, 23 Apr 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="E3ZdJEKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BF1CAA2;
	Tue, 23 Apr 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855598; cv=none; b=en/bU9e/7wJeZEgvoFXnLwbHsg8p7RBlRtZgJT813hCrRokU/IWVzRAZ1tNd4A14b1Pwm6jcW1WxmQrSJ2CmY2rk+koz9xLT7rTKrjiLnv9RvLOBZpPOT+9G0TVQ5jDqhT/MOxcHCTg2C6dnnlirKjPuCZTsbs/YgIyHJGUu2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855598; c=relaxed/simple;
	bh=Zzp8mj6zW/Jm4wThhCDdvfxjFV4U+HMKiOpiV/HaZuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IANtuoiwAxgyLbLvVWigLJnAQ2LbAhPJXuCuiss6dAr71ybT4GfZA3MzRq0TSaiAknkOwllMdaealIQU+jKv3vonsH6puqbOJ0oelfqelVE+48GlUSj+YosKwjlmXOcaEhglUMObpkKHa2oY9SlbVq8Tzuupm+t8Vpgrozd3CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=E3ZdJEKH; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D9EF71E80;
	Tue, 23 Apr 2024 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713855142;
	bh=JOwWS5GfXukMyOR/UNU7ONa5eGBlcf6BRU7La5M7If4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E3ZdJEKHk0oEhyK+a8zB5KGFZcWbtsScEzkEukjgAv6nZ1CZHijXXEmBWuzmEt5hT
	 dKQT4KXmyfsc8CiSbm+09sQpEWMrlSlVoOU27NScJhw1YOKj9/0FaUGVuaO1zEC1OW
	 aDq/kV023VFgoPk7BFadbMBQRao2hOx6vIYG8DJM=
Received: from [192.168.211.160] (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:59:54 +0300
Message-ID: <bc467c0d-99d0-4de7-9d09-a5e155f7ba4e@paragon-software.com>
Date: Tue, 23 Apr 2024 09:59:53 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] fs/ntfs3: Taking DOS names into account during link
 counting
To: Johan Hovold <johan@kernel.org>
CC: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Anton Altaparmakov <anton@tuxera.com>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
 <0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com>
 <ZiC-TNxianVojCJv@hovoldconsulting.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <ZiC-TNxianVojCJv@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 18.04.2024 09:31, Johan Hovold wrote:
> On Wed, Apr 17, 2024 at 04:10:59PM +0300, Konstantin Komarov wrote:
>> When counting and checking hard links in an ntfs file record,
>>
>>     struct MFT_REC {
>>       struct NTFS_RECORD_HEADER rhdr; // 'FILE'
>>       __le16 seq;        // 0x10: Sequence number for this record.
>>   >>  __le16 hard_links;    // 0x12: The number of hard links to record.
>>       __le16 attr_off;    // 0x14: Offset to attributes.
>>     ...
>>
>> the ntfs3 driver ignored short names (DOS names), causing the link count
>> to be reduced by 1 and messages to be output to dmesg.
> I also reported seeing link counts being reduced by 2:
>
> [   78.307412] ntfs3: nvme0n1p3: ino=34e6, Correct links count -> 1 (3).
> [   78.307843] ntfs3: nvme0n1p3: ino=5bb23, Correct links count -> 1 (2).
> [   78.308509] ntfs3: nvme0n1p3: ino=5c722, Correct links count -> 1 (2).
> [   78.310018] ntfs3: nvme0n1p3: ino=5d761, Correct links count -> 1 (2).
> [   78.310717] ntfs3: nvme0n1p3: ino=33d18, Correct links count -> 1 (3).
> [   78.311179] ntfs3: nvme0n1p3: ino=5d75b, Correct links count -> 1 (3).
> [   78.311605] ntfs3: nvme0n1p3: ino=5c708, Correct links count -> 1 (3).
>
>   - https://lore.kernel.org/all/Zhz_axTjkJ6Aqeys@hovoldconsulting.com/
>
> Are you sure there are not further issues with this code?
>
>> For Windows, such a situation is a minor error, meaning chkdsk does not
>> report
>> errors on such a volume, and in the case of using the /f switch, it silently
>> corrects them, reporting that no errors were found. This does not affect
>> the consistency of the file system.
>>
>> Nevertheless, the behavior in the ntfs3 driver is incorrect and
>> changes the content of the file system. This patch should fix that.
> This patch is white space damaged and does not apply.
>
>> PS: most likely, there has been a confusion of concepts
>> MFT_REC::hard_links and inode::__i_nlink.
> I'd also expect a Fixes and CC stable tag here.
>
> And as this patch does not seem to depend on the rest of the series it
> should go first (along with any other bug fixes).
>
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Johan

Hi Johan,

We are in the process of extending the tests for link counting and 
related scenarios.

If I find bugs, I'll reply ASAP.

Thanks for highlighting the bug.


