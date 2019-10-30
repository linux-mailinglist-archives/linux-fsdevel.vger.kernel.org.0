Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E41E9C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 14:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJ3NNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 09:13:10 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37290 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3NNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:13:09 -0400
Received: from [10.20.41.27] (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDxT11XjLldw_cZAA--.52S3;
        Wed, 30 Oct 2019 21:13:03 +0800 (CST)
Subject: Re: [PATCH] fsnotify: Use NULL instead of 0 for pointer
To:     Jan Kara <jack@suse.cz>
References: <1572356342-24776-1-git-send-email-yangtiezhu@loongson.cn>
 <20191030122149.GK28525@quack2.suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <dade5dda-6d1f-519d-e4e6-e29d2a44bed9@loongson.cn>
Date:   Wed, 30 Oct 2019 21:12:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191030122149.GK28525@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: QMiowPDxT11XjLldw_cZAA--.52S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr13Cr17Gr18XF18CFy3urg_yoW8Wr17p3
        97ta9YyayDGFyjg3W0vF4Yq3WayrW8KrWDJFsay34Iy3ZrXw1Fqr1xKw1Y9FykWFWSqa10
        gw4Yya98Zr47ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5xgA3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/2019 08:21 PM, Jan Kara wrote:
> On Tue 29-10-19 21:39:02, Tiezhu Yang wrote:
>> Fix the following sparse warning:
>>
>> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
>>
>> Fixes: be77196b809c ("fs, notify: add procfs fdinfo helper")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Thanks for the patch but similar patch already sits in my tree as commit
> ddd06c36bdb "fsnotify/fdinfo: exportfs_encode_inode_fh() takes pointer as
> 4th argument". I'll send it to Linus in the next merge window.
>
> 								Honza

Thanks for your reply. I can not find your tree about fs/notify
in the MAINTAINERS file, so this patch is based on Linus's tree.
Sorry for the noise, you can ignore it.

By the way, could you add your tree in the MAINTAINERS file?

Thanks,

Tiezhu Yang

>
>> ---
>>   fs/notify/fdinfo.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
>> index 1e2bfd2..cd2846e 100644
>> --- a/fs/notify/fdinfo.c
>> +++ b/fs/notify/fdinfo.c
>> @@ -50,7 +50,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>>   	f.handle.handle_bytes = sizeof(f.pad);
>>   	size = f.handle.handle_bytes >> 2;
>>   
>> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
>> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle,
>> +				       &size, NULL);
>>   	if ((ret == FILEID_INVALID) || (ret < 0)) {
>>   		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>>   		return;
>> -- 
>> 2.1.0
>>
>>

