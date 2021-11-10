Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651244C036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJLls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 06:41:48 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40869 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKJLls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:41:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UvuiQIh_1636544338;
Received: from guwendeMacBook-Pro.local(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0UvuiQIh_1636544338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 19:38:59 +0800
Subject: Re: [PATCH] fasync: Use tabs instead of spaces in code indent
To:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
        xuanzhuo@linux.alibaba.com, guwen@linux.alibaba.com
References: <1636525756-68970-1-git-send-email-guwen@linux.alibaba.com>
 <70778cdf726d59d852a3b1262760fb71574f0e91.camel@kernel.org>
From:   Wen Gu <guwen@linux.alibaba.com>
Message-ID: <a7036706-6262-9278-4228-0ad15fdd7394@linux.alibaba.com>
Date:   Wed, 10 Nov 2021 19:38:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <70778cdf726d59d852a3b1262760fb71574f0e91.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/10 6:58 pm, Jeff Layton wrote:
> On Wed, 2021-11-10 at 14:29 +0800, Wen Gu wrote:
>> When I investigated about fasync_list in SMC network subsystem,
>> I happened to find that here uses spaces instead of tabs in code
>> indent and fix this by the way.
>>
>> Fixes: f7347ce4ee7c ("fasync: re-organize fasync entry insertion to
>> allow it under a spinlock")
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>> ---
>>   fs/fcntl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index 9c6c6a3..36ba188 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -927,7 +927,7 @@ void fasync_free(struct fasync_struct *new)
>>    */
>>   struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasync_struct **fapp, struct fasync_struct *new)
>>   {
>> -        struct fasync_struct *fa, **fp;
>> +	struct fasync_struct *fa, **fp;
>>   
>>   	spin_lock(&filp->f_lock);
>>   	spin_lock(&fasync_lock);
> 
> Hi Wen,
> 
> I usually don't take patches that just fix whitespace like this. The
> reason is that these sorts of patches tend to make backporting difficult
> as they introduce merge conflicts for no good reason.
> 
> When you're making substantial changes in an area, then please do go
> ahead and fix up whitespace in the same area, but patches that just fix
> up whitespace are more trouble than they are worth.
> 
> Sorry,
> 

Thank you for the reminding. I didn't realize my unintentional action 
would bring trouble to the backport. I will keep this in mind.

Thanks,
Wen Gu
