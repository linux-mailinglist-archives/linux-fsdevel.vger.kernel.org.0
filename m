Return-Path: <linux-fsdevel+bounces-5031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0238077C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148B41F202CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBD6EB52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzMaWllY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16078D4D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8Nv22+uHx2DcR0gnjVmYRbs07ZeTxXTzJRP8zvG/YoI=; b=FzMaWllYuSuoULhCX0c3ueOIyb
	6TE9vG/k+IGAbdGJbTdRvNVFNQap4vm1eHQ6xOQJaZFEOjw6q8c8qf/nBTW3/wEKPfTCI9KcBiMU0
	CTpxV6M/lA2D+hgxGG7lDRUUnEou6sZmHkEugobHgOmlZUR9XjMTqzNaovuggIghZliEW+KNRUAcx
	ZxvYrb+Je7k5pacONGY+jT6UWlK7sjb8ZUaE7PeiFTirKbaiv1weyEYXMmH7EC88Wlc5vjDlsAAj6
	yXdTO9ppLMBCaMtPXQVzzTt5YNlNF2WzZ/NlRW+cAd0miJ8toqLzHiivPLXcSAulroiB5wHSm5QSL
	ODDulnmw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAv5K-00Ao4S-2e;
	Wed, 06 Dec 2023 16:49:18 +0000
Message-ID: <bec63fe6-b9d7-4aff-bee6-d5c137554d71@infradead.org>
Date: Wed, 6 Dec 2023 08:49:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: vboxsf: fix a kernel-doc warning
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20231206025355.31814-1-rdunlap@infradead.org>
 <0fb8fe4f-cb5d-4c74-9bdc-34ff04024f62@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0fb8fe4f-cb5d-4c74-9bdc-34ff04024f62@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/6/23 06:57, Hans de Goede wrote:
> Hi Randy,
> 
> On 12/6/23 03:53, Randy Dunlap wrote:
>> Fix function parameters to prevent kernel-doc warnings.
>>
>> vboxsf_wrappers.c:132: warning: Function parameter or member 'create_parms' not described in 'vboxsf_create'
>> vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> vboxsf is not really undergoing any active development,
> can this be merged through the Documentation tree?
> 
> Regards,
> 
> Hans

I have no idea, but we can ask Jon.

Jon, can you merge this patch thru the Documentation tree?


>> ---
>>  fs/vboxsf/vboxsf_wrappers.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff -- a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
>> --- a/fs/vboxsf/vboxsf_wrappers.c
>> +++ b/fs/vboxsf/vboxsf_wrappers.c
>> @@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
>>   * vboxsf_create - Create a new file or folder
>>   * @root:         Root of the shared folder in which to create the file
>>   * @parsed_path:  The path of the file or folder relative to the shared folder
>> - * @param:        create_parms Parameters for file/folder creation.
>> + * @create_parms: Parameters for file/folder creation.
>>   *
>>   * Create a new file or folder or open an existing one in a shared folder.
>>   * Note this function always returns 0 / success unless an exceptional condition
>>
> 

Thanks.
-- 
~Randy

