Return-Path: <linux-fsdevel+bounces-7370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F426824399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B265F281962
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5523778;
	Thu,  4 Jan 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TPbwZSvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638812421B;
	Thu,  4 Jan 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LOa0rXuduH4TlLOa0rJH71; Thu, 04 Jan 2024 15:20:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704378016;
	bh=Q9FqaBRUlUJ8QVrn0N9cxjxXK+HP850wiUfYJxgq3pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TPbwZSviMLHuvYbnXJii9RDt0jfzC+RqGtoks9U5QwVOElbSmFoctY2tATq3+SLXE
	 +i5fSeP3I4tisKbYA1fSPj0helfmtrtH3zw7vt3Z0+el3VHhhKSIZzY3QNMrB+p25j
	 zbWz3kHfvmatrN4qUWvTUOU0JgiW2KjjWz434AwEvzmyPd4IdEh9ZqYAmoT1g4sr+g
	 Fd6/NlUrDvGuFSRqLQZCoHC2aWYi6TLjpTVxncyBEzxpkbjp38yHGziyUJRmnJz0Aa
	 262/6XBCiRpQH+Z+bAJ3kQ5pXQwohp3BXpTW/eqWW8P9PgFBtqzOJ5s6VJqgW9Yhwq
	 qZoErV2YXipkg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Jan 2024 15:20:16 +0100
X-ME-IP: 92.140.202.140
Message-ID: <51ce6e78-023b-4914-96c0-ed1bd664d188@wanadoo.fr>
Date: Thu, 4 Jan 2024 15:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Remove usage of the deprecated ida_simple_xx()
 API
Content-Language: fr, en-US
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <2752888783edaed8576777e1763dc0489fd07000.1702963000.git.christophe.jaillet@wanadoo.fr>
 <b4c96284-1ae8-498b-84ae-34a9f65e9da8@redhat.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b4c96284-1ae8-498b-84ae-34a9f65e9da8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/12/2023 à 10:39, Hans de Goede a écrit :
> Hi,
> 
> On 12/19/23 06:17, Christophe JAILLET wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> This is less verbose.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> vboxsf is not really undergoing any active development,
> if there is a tree which is collecting other ida related
> patches feel free to route this through that tree.

There is still a bit of work to remove the remaining ida_simple_get() 
calls, so we still have time.

Based on another experience when phasing out an old API, I would say at 
least 2-3 months.

If this one is still around when nearly all the other calls have been 
handled, i'll come back to it to see the best way to have is merged in a 
tree or in another, so that the old API can be removed.

CJ

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
>> ---
>>   fs/vboxsf/super.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
>> index 1fb8f4df60cb..cd8486bc91bd 100644
>> --- a/fs/vboxsf/super.c
>> +++ b/fs/vboxsf/super.c
>> @@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>>   		}
>>   	}
>>   
>> -	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
>> +	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
>>   	if (sbi->bdi_id < 0) {
>>   		err = sbi->bdi_id;
>>   		goto fail_free;
>> @@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	vboxsf_unmap_folder(sbi->root);
>>   fail_free:
>>   	if (sbi->bdi_id >= 0)
>> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>>   	if (sbi->nls)
>>   		unload_nls(sbi->nls);
>>   	idr_destroy(&sbi->ino_idr);
>> @@ -268,7 +268,7 @@ static void vboxsf_put_super(struct super_block *sb)
>>   
>>   	vboxsf_unmap_folder(sbi->root);
>>   	if (sbi->bdi_id >= 0)
>> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>>   	if (sbi->nls)
>>   		unload_nls(sbi->nls);
>>   
> 
> 
> 


