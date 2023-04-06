Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E96D93C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjDFKNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbjDFKNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:13:52 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA926A4;
        Thu,  6 Apr 2023 03:13:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC3E05821C6;
        Thu,  6 Apr 2023 06:13:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Apr 2023 06:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680776028; x=1680779628; bh=bBA7rsAiJx0Mf+CLTLAhKrfRRQaKuAim1uz
        YsGXHA34=; b=jWekyNIaj9US9/EkiLALLxgmaTGLp9r7UZn5jDkk0RDM0KPNF5z
        UMK6ecEnVy26YV+Z9PiTUx3ktktXQN5oSECvGROLW7TrhVN+L1VeJG417bTgQ7CE
        Smk/yBKz7ppsN4tkSYaicvlvuSdWQBzRbb5pTeABZ/S1QJBQpVedEypggPqw5h5j
        iFtn0TPOHfyhDiAaKvb428URrZtGlCZ9m9zJDW3hiAY0TtxmoCV0MBvk8BtttsOl
        SIDVi1XikFkIjBEmMnrwKrzwkd8EU5HBDEA3tS2tud+RjdKAuXYEzuLzvVIaoEBU
        ttNN+T/symi+Qv4xdexB2VdtNlJ1sBYSVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680776028; x=1680779628; bh=bBA7rsAiJx0Mf+CLTLAhKrfRRQaKuAim
        1uzYsGXHA34=; b=Fx+uDooMkxpX9uOe6vY7t/QuOGO4GCpZlcgkk6UJXFCEM8gP
        +bB+Kv2EHbV/yCvNMOAUVPcVEy/nKKPXh4U1F0SINCbP2mq7ySFUOdNwpWLg/F3o
        JpMSlJ+pYEbydGbUiy2tQuDry1wSIUUlR2GsmoO5RCq1is0/1vU6+GJ8P93ABFQM
        KCCU/+lyvARJSqmCbFK7iHwQKUejfRVFlNDYg6VnbLWTgjgCi84csIaP2KZP2RND
        0tT4d895QsuB8hNr7lwuCqrUIZacyESWnz6j/t/vobwm/DD5KJGRIh0UzYzFZ5v0
        7Zua1ealwITg5Ps0gm/XVfYuJgRzD8vRJkmTSw==
X-ME-Sender: <xms:WpsuZE0oCgoCLNZ6xY86KZNKXEw_-jHWliV__VeB61PbMi6DZg-UZg>
    <xme:WpsuZPFyepv-mERyREOrAtuUGwyUseQSWhgmLnTAysFCIyMEr8copwkzkm-gbl-Qi
    C5TEIJotsCCs9GUHsg>
X-ME-Received: <xmr:WpsuZM7O8yF8DkWw6-lu_6s1lBhS6YzKuXs9XOjDn86mkir9fMnMyUGI0GBYqrHOzNbbUQawx8UwYMMeNkyu2j7R5ejq_0jh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WpsuZN2NZw_I5NNbmq4KraI5W46jo2TsmIY_Vr-enYBsSqAckqc7vg>
    <xmx:WpsuZHG5i0JHUs6Ho-OOcZYeTmSInft03lPju2l1unu0urSU6RwrZg>
    <xmx:WpsuZG8XLFFtykina6flu9XLDlelgILBeyul5b2nZVBSA5G0yyT2Tw>
    <xmx:XJsuZO_jQnFlLCQHEDINuySJkxNnz1Qs1Nm7r-Kar_ncAKdAEa4A3g>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 06:13:40 -0400 (EDT)
Message-ID: <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
Date:   Thu, 6 Apr 2023 19:13:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rafael@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <2023040616-armory-unmade-4422@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/6/23 19:05, Greg KH wrote:
> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
>> BTW kill kobject_del() directly, because kobject_put() actually covers
>> kobject removal automatically.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>  fs/zonefs/sysfs.c  | 11 +++++------
>>  fs/zonefs/zonefs.h |  1 -
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>> index 8ccb65c2b419..f0783bf7a25c 100644
>> --- a/fs/zonefs/sysfs.c
>> +++ b/fs/zonefs/sysfs.c
>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>>  		return ret;
>>  	}
>>  
>> -	sbi->s_sysfs_registered = true;
> 
> You know this, why do you need to have a variable tell you this or not?

If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
fill_super will also return that error. vfs will then call kill_super, which
calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
added the kobj.

> 
>> -
>>  	return 0;
>>  }
>>  
>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>  {
>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>  
>> -	if (!sbi || !sbi->s_sysfs_registered)
> 
> How can either of these ever be true?  Note, sbi should be passed here
> to this function, not the super block as that is now unregistered from
> the system.  Looks like no one has really tested this codepath that much
> :(
> 
>> +	if (!sbi)
>>  		return;
> 
> this can not ever be true, right?

Yes it can, if someone attempt to mount a non zoned device. In that case,
fill_super returns early without setting sb->s_fs_info but vfs still calls
kill_super.

> 
> 
>>  
>> -	kobject_del(&sbi->s_kobj);
>> -	kobject_put(&sbi->s_kobj);
>> -	wait_for_completion(&sbi->s_kobj_unregister);
>> +	if (kobject_is_added(&sbi->s_kobj)) {
> 
> Again, not needed.
> 
> thanks,
> 
> greg k-h

