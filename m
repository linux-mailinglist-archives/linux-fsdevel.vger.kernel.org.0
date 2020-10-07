Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8F286539
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgJGQuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgJGQuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:50:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B5C061755;
        Wed,  7 Oct 2020 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Nav6Oy18S0mncB3AAW0uN+jV/XzmjmJbW8GBwpVEUfw=; b=Frs5Gubuq3ricUN+drCNVuXFCQ
        mjI7QUo+b9QJ0YTE5NrJrGyyJTC4C7Xnqrmod9ynuk2Y4oiEYd+aqpRGhhGIukQecVxABVPSNgViH
        jXvjPC1UixiXhwHJ04SFdFoxR8VLpIunkTZG6/3+V/LmPruKj0WukyumMT+flkN7/b9TYSWUGvcd9
        EZ4oPxIyDyE1OJcZ/xUA2i8t/gu5hDGhZdmPy3Nk2nrEgX6vLDagbZaWR9br0Pnz4xXebGH+/oo50
        5hFO3Svf9XCI1rvN/DfQQ+Vat5rRqfQNhNOJGo/fHDm/oFL+uiPJmQZwQuGy0T2XOUVCxAWxyy/Ow
        zGOlf7dw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQCdf-0004Uj-U1; Wed, 07 Oct 2020 16:50:04 +0000
Subject: Re: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
To:     Tianxianting <tian.xianting@h3c.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200905071525.12259-1-tian.xianting@h3c.com>
 <3808373d663146c882c22397a1d6587f@h3c.com>
 <07de1867-e61c-07fb-8809-91d5e573329b@infradead.org>
 <e028ff27412d4a80aa273320482a801d@h3c.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b2bd4f65-3054-3c08-807f-f1e800c122ed@infradead.org>
Date:   Wed, 7 Oct 2020 09:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e028ff27412d4a80aa273320482a801d@h3c.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/20 8:20 AM, Tianxianting wrote:
> hi,
> 
> thanks Randy
> 
> I checked the latest code, seems this patch not applied currently.

Hi--

Please don't send html email.
I'm pretty sure that the mailing list has dropped (discarded) your email
because it was html.

Probably only Al and I received your email.

Al- Would you prefer that fs/ documentation patches go to someone else
for merging?  maybe Andrew?

Thanks.

PS: I can't tell if I am writing an html email or not... :(


> ________________________________
> 发件人: Randy Dunlap <rdunlap@infradead.org>
> 发送时间: Friday, September 11, 2020 10:57:24 AM
> 收件人: tianxianting (RD); viro@zeniv.linux.org.uk
> 抄送: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH] fs: use correct parameter in notes of generic_file_llseek_size()
> 
> On 9/10/20 7:06 PM, Tianxianting wrote:
>> Hi viro,
>> Could I get your feedback?
>> This patch fixed the build warning, I think it can be applied, thanks :)
>>
>> -----Original Message-----
>> From: tianxianting (RD)
>> Sent: Saturday, September 05, 2020 3:15 PM
>> To: viro@zeniv.linux.org.uk
>> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
>> Subject: [PATCH] fs: use correct parameter in notes of generic_file_llseek_size()
>>
>> Fix warning when compiling with W=1:
>> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
>> fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'
>>
>> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>> ---
>>  fs/read_write.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 5db58b8c7..058563ee2 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
>>   * @file:    file structure to seek on
>>   * @offset:  file offset to seek to
>>   * @whence:  type of seek
>> - * @size:    max size of this file in file system
>> + * @maxsize: max size of this file in file system
>>   * @eof:     offset used for SEEK_END position
>>   *
>>   * This is a variant of generic_file_llseek that allows passing in a custom
>>
> 
> 
> --
> ~Randy
> 

-- 
~Randy

