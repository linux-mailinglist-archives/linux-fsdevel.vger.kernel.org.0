Return-Path: <linux-fsdevel+bounces-72260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD534CEB02F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 02:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57C863024D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 01:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAE2D7DF6;
	Wed, 31 Dec 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZD69KrY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6853BB44;
	Wed, 31 Dec 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145532; cv=none; b=nc41VqOhdkOtK/dGlcsIOEhZb+9PZd1VbKzSSuM70ui3UaMGhW2oJ5V+EmOgyFH5ed8N4yuq/obYDpP/1q8ahWs5Mo9T9ykP3qAkVP6A3MkqGdsMzpwSuFYpaeF2xdvVKuaIIGzKvcuI69DO30zr6UW9KTGtpIIqJVhh4AH/VWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145532; c=relaxed/simple;
	bh=er4R6GStLvulkoQdZVkuzGPzRYTk33FsSgqJgj1pQcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVKIX82Y9PMYgySmqDbKDP8t6WGRG8yUjkRT/MVtTIen8GnvuJZtb2YhM2l06j3B0X+58brApgu7O1z+PqC9iPi3ddqEHbZqvmUKERdqpcDreF+ECRY/U0zbCZjkuv+9W/YK0ETr/F7gQO0uLwKzY2QiD6ciVmWIyJrTnFEebQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZD69KrY0; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=MdOTbZy6Ph3s14jjtoezAg6zDQg55Buw3Y24j/xc7ic=;
	b=ZD69KrY09lC7WDN3LaLr5cF2l2kwUNYUs/04tHq8tSCDyHHen6Xj0kDQyBiJeu
	W+Aa9mR/V1bFaZt6cdIVmbTHMaT8KXLHywl11ZCoDBapIMiPDzEDxNAlGblf3+Nu
	tIVb5OKV46KO+eM4F15r0bmyV02yRfr624AHUChF9qZFU=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDH1KQRgFRpJGPuDA--.23496S2;
	Wed, 31 Dec 2025 09:44:51 +0800 (CST)
Message-ID: <29ca8dd9-3a00-490a-8a20-7d187b7ab7ff@163.com>
Date: Wed, 31 Dec 2025 09:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] exfat: remove unused parameters from
 exfat_get_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "jack@suse.cz"
 <jack@suse.cz>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "willy@infradead.org" <willy@infradead.org>
References: <PUZPR04MB6316EAFF1D1D002551408CD181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316EAFF1D1D002551408CD181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDH1KQRgFRpJGPuDA--.23496S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWrAw45ZFW5Kw4kXF4xJFb_yoW8GFy7pr
	s7JFy8tay3XFWxGF40qFs5X34fJ3ZrGrWDJFsxAr15Ar90yr109a1qkr43Aa1kCw4rurWf
	t3W3Gr1a9rnxG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziQtxkUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xOTMWlUgBPMYgAA3G

On 12/30/25 17:05, Yuezhang.Mo@sony.com wrote:
>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
>> index f9501c3a3666..1062ce470cb1 100644
>> --- a/fs/exfat/inode.c
>> +++ b/fs/exfat/inode.c
>> @@ -157,28 +157,26 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>                                *clu += clu_offset;
>>                }
>>        } else if (ei->type == TYPE_FILE) {
>> -             unsigned int fclus = 0;
>>                int err = exfat_get_cluster(inode, clu_offset,
>> -                             &fclus, clu, &last_clu, 1);
>> +                             clu, &last_clu);
>>                if (err)
>>                        return -EIO;
>> -
>> -             clu_offset -= fclus;
>>        } else {
>> +             unsigned int fclus = 0;
>>                /* hint information */
>>                if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
>>                    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
>> -                     clu_offset -= ei->hint_bmap.off;
>>                        /* hint_bmap.clu should be valid */
>>                        WARN_ON(ei->hint_bmap.clu < 2);
>> +                     fclus = ei->hint_bmap.off;
>>                        *clu = ei->hint_bmap.clu;
>>                }
>>   
>> -             while (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
>> +             while (fclus < clu_offset && *clu != EXFAT_EOF_CLUSTER) {
>>                        last_clu = *clu;
>>                        if (exfat_get_next_cluster(sb, clu))
>>                                return -EIO;
>> -                     clu_offset--;
>> +                     fclus++;
>>                }
> 
> exfat_map_cluster() is only used for files. The code in this 'else' block is never executed and
> can be cleaned up.

Thanks for confirming that. It was confusing me.

I'll clear this up in the next version.


Thanks,

> 
>>        }
> 


