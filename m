Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E56D9502
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 13:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjDFLYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDFLYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:24:05 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BD6EB6;
        Thu,  6 Apr 2023 04:24:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9BE0C582089;
        Thu,  6 Apr 2023 07:24:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Apr 2023 07:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680780243; x=1680783843; bh=8mqNNjIcX5qc/Tx56KbRBl6BMXan1AA6YQt
        3ILlf2D8=; b=OfPDKUIx3qFvTnRXvtonABTm55+1CvG5Zdwi3+g7Fql3ngdbH/I
        ea2wpLFjo1uiMv1AtkZNrHJGibMPUEWcyByM6NhJzmb9B7BF7ip/Wkd12zA1e0pP
        3/ic6Kd8+oxDAGtXHPCvDp6NhHwAUUlb5cVDVZwKZDPYNg2NMkKgUh8cefzOvBqV
        CVqsxjNWIQ89E1LY2U7B2eHQPgktgRtF08RPVyaCOdSoisUsLjsqLzlQ5VI+s31H
        F6qN/dlRof5hon8e9vqVjTokIG4oDpVpVaPwcOwjFarjyoNrFMTkxi7lAh4XFg/n
        2eKi2cflJ2S3SwiBLNsZ07RMKEPvoOmNrSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680780243; x=1680783843; bh=8mqNNjIcX5qc/Tx56KbRBl6BMXan1AA6
        YQt3ILlf2D8=; b=cph75FLNA63AqDYKE4N+sRvPooBSI5Gn7xbP+quH3yTn7J6R
        Q62UNiDkiO4SpIHKeZYJ0B37CjPgOFXjItasxxSjNUNPcUFC3g2u4Zdqc1Ym22yy
        DECVFvjg89NpJsg7PCiTjJL3b+ZPfylw7wVPddSHhdnllASQkGG2Bu5WKbQkwKpS
        BB2EE3w8FaXDOEMlF7P2ylRysMpSwO2zjiFSSyk33rgjkswZkkAuNzAvGZ8ZEj+2
        RvC+Fv1mLgredlsDByFkpsREG8rnRHcNFOUVzf3cbB6qWwM+jTs1tZxxidmqTS8y
        yl//WS6blEbCMJezjuhbEm1qHlkT5x+MAubWJg==
X-ME-Sender: <xms:0asuZFxsqcWxKPfem8J2kpfFoozlgiSKKHOR2T9rCp3ezdaHBF7eCg>
    <xme:0asuZFTnQ1UUoOcJv2SLp6YudcHN80okN07Ldw4nP-Nt61IVngxee-bZ8XPKl4i9g
    r_0AyZMCvkGd1w2LdU>
X-ME-Received: <xmr:0asuZPVOj2CsSuML9wHoBd0S9Y1ap90Xgf9v5bU4PnkgW2mW_iaa99eWiBCa1EHtMEy71Xq1OhTbwY39IH7DhDlyTrc2lk3K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0asuZHgotGI04OW7x3LuQaVy7tE2sPthNS1sNg8BLbIGMvdx-MMTRQ>
    <xmx:0asuZHDP9H3QgSJ-SoqCpa4qlPksnLmrLhgKR_nhZ1qaMYnSVJEuWA>
    <xmx:0asuZAKPwW9oKQnHYcTlpPBm61oMfjE4yP-O7Je5IRsaXcpR_DP1GQ>
    <xmx:06suZEJmwa4MFDkYQAh7h61_xEn_2ExkASd93mau8BXmwanHJEUqUw>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 07:23:58 -0400 (EDT)
Message-ID: <003260d1-f1db-9d62-23fa-9acfba849782@fastmail.com>
Date:   Thu, 6 Apr 2023 20:23:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] zonefs: convert to use kobject_is_added()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-3-frank.li@vivo.com>
 <2023040616-armory-unmade-4422@gregkh>
 <8ca8c138-67fd-73ed-1ce5-c090d49f31e9@fastmail.com>
 <2023040627-paver-recipient-3713@gregkh>
 <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
 <2023040627-platter-twisted-c1e6@gregkh>
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <2023040627-platter-twisted-c1e6@gregkh>
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

On 4/6/23 20:18, Greg KH wrote:
> On Thu, Apr 06, 2023 at 07:58:38PM +0900, Damien Le Moal wrote:
>> On 4/6/23 19:26, Greg KH wrote:
>>> On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
>>>> On 4/6/23 19:05, Greg KH wrote:
>>>>> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
>>>>>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
>>>>>> BTW kill kobject_del() directly, because kobject_put() actually covers
>>>>>> kobject removal automatically.
>>>>>>
>>>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>>>> ---
>>>>>>  fs/zonefs/sysfs.c  | 11 +++++------
>>>>>>  fs/zonefs/zonefs.h |  1 -
>>>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>>>>>> index 8ccb65c2b419..f0783bf7a25c 100644
>>>>>> --- a/fs/zonefs/sysfs.c
>>>>>> +++ b/fs/zonefs/sysfs.c
>>>>>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>>>>>>  		return ret;
>>>>>>  	}
>>>>>>  
>>>>>> -	sbi->s_sysfs_registered = true;
>>>>>
>>>>> You know this, why do you need to have a variable tell you this or not?
>>>>
>>>> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
>>>> fill_super will also return that error. vfs will then call kill_super, which
>>>> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
>>>> added the kobj.
>>>
>>> Ok, but then why not just 0 out the kobject pointer here instead?  That
>>> way you will always know if it's a valid pointer or not and you don't
>>> have to rely on some other variable?  Use the one that you have already :)
>>
>> but sbi->s_kobj is the kobject itself, not a pointer.
> 
> Then it should not be there if the kobject is not valid as it should
> have been freed when the kobject_init_and_add() call failed, right?

What do you mean freed ? the kboject itself is a field of zonefs sbi. So the
kobject gets freed together with sbi.

>> I can still zero it out in
>> case of error to avoid using the added s_sysfs_registered bool. I would need to
>> check a field of s_kobj though, which is not super clean and makes the code
>> dependent on kobject internals. Not super nice in my opinion, unless I am
>> missing something.
> 
> See above, if a kobject fails to be registered, just remove the whole
> object as it's obviously "dead" now and you can not trust it.

Well yes, that is what s_sysfs_registered indicates, that the kobject is not
valid. I do not understand what you mean with "just remove the whole object".

>>> And you really don't even need to check anything, just pass in NULL to
>>> kobject_del() and friends, it should handle it.>
>>>>>> -
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>>>>>  {
>>>>>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>>>>>  
>>>>>> -	if (!sbi || !sbi->s_sysfs_registered)
>>>>>
>>>>> How can either of these ever be true?  Note, sbi should be passed here
>>>>> to this function, not the super block as that is now unregistered from
>>>>> the system.  Looks like no one has really tested this codepath that much
>>>>> :(
>>>>>
>>>>>> +	if (!sbi)
>>>>>>  		return;
>>>>>
>>>>> this can not ever be true, right?
>>>>
>>>> Yes it can, if someone attempt to mount a non zoned device. In that case,
>>>> fill_super returns early without setting sb->s_fs_info but vfs still calls
>>>> kill_super.
>>>
>>> But you already had a sbi pointer in the place that this was called, so
>>> you "know" if you need to even call into here or not.  You are having to
>>> look up the same pointer multiple times in this call chain, there's no
>>> need for that.
>>
>> I am not following here. Either we check that we have sbi here in
>> zonefs_sysfs_unregister(), or we conditionally call this function in
>> zonefs_kill_super() with a "if (sbi)". Either way, we need to check since sbi
>> can be NULL.
> 
> In zonefs_kill_super() you have get the spi at the top of the function,
> so use that, don't make zonefs_sysfs_unregister() have to compute it
> again.

That I can do, yes.

> 
> But again, if the kobject fails to be registered, you have to treat the
> memory contained there as not valid and get rid of it as soon as
> possible.

If the kobject add failed, we never touch it thanks to s_sysfs_registered. I
still do not see the issue here.

> 
> thanks,
> 
> greg k-h

