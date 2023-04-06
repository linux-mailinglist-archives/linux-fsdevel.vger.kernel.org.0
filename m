Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9276D948D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjDFK6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjDFK6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:58:46 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B4D7AA0;
        Thu,  6 Apr 2023 03:58:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7C3DD5820D0;
        Thu,  6 Apr 2023 06:58:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Apr 2023 06:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680778724; x=1680782324; bh=Q2m1kci/EP4IG1lF0MfJfyKUGN/Uk8YX5ZS
        0D1+MIUk=; b=HXlgZjFU+cAzi8fVYZ3ieEuyXVgmr7WPTsesBy2rLFPMYCKpIyn
        v12cjlEDMTp1gBJBK2JCL9L+UUdyekKHC7Zl1tPF8XtFF8kTYGeBk+kdwT2QbaId
        ZgZCmGl/OsQO4k5Q3TP+QZ28CqAoNhT1KAJSG5EWmLq162ZRFYRrnqvsesqU6ruP
        k8Mwx/EuwvX31/uCswzZjU5vZlvEdDvoR+KGPudBQddh4+XJ/bfqA2lzMl9FqvU2
        kk6eVKSs4Hv1hVtC5kVpiCnCfu6bdUsfzuH8p2+V8RzUBhOPMHsWIn9++bWngpk+
        SMC6UJu2JU+X5Jl66ycRCqOeP1JR9RLR4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680778724; x=1680782324; bh=Q2m1kci/EP4IG1lF0MfJfyKUGN/Uk8YX
        5ZS0D1+MIUk=; b=RVcPjQRFbdo6hVuCZI4+6tK3Vq86w7l8TLKbX19OqrWM41Wd
        8JJf26gLcPAJLCXknkmubxbSe4pZC8R3JqWhLJF4OZlv0kK61yD54we5+4b9sm37
        FVNtqxBLsASydtPAh22nPyBvy6Hxn2rxYb7/eM7kdaBpCkLzE4Y43f62O/YaTdyV
        f+kalY7a2tPW9tAHSS9bCDewSzXvXf1e/iMXrCJvDMf/Yd1BFWUH8imnbPT6rg6P
        nYmzHNwinZG3tVpntBg2hhOEGI6JxIHzx+II8OwdNaGX1ORXAoIGK7eGMU645Tk/
        YeImSalhXU/YAAGAnGNOAZbPTKbKL1qxbbitFQ==
X-ME-Sender: <xms:46UuZPWWKtHuO5l0LFAk3w3YC-eb_XKzKbYBpAgJmrcIJeHy5omKCA>
    <xme:46UuZHmAlDonNJjvRk-Sftt76Y_ESVGzz54QnLSbZ2jjThl_0WONtP6l4ip5mt9Pk
    kfRIbPZP3stG8u0sBY>
X-ME-Received: <xmr:46UuZLbBk7Hay6gHYKlJ4OPlgPvdhcVxuAqJW6qjZSkky7dPEbtrTWypEQ4T4m6N-dvdrSfiYu-QaaAGPaUwJFqsMoYUrjvd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:46UuZKVqnghzZigo3_xc7UQ8d7BarGx6dTWkv96qclX1YWAI2tbSyA>
    <xmx:46UuZJlqo6Hc66G0ia8wUIQT7a_n1tQuMzypRSRkkqALEx7eUybdoQ>
    <xmx:46UuZHd1TBjHAAB_-5sN6JGRoJSXImiE-IkEeBzXS5cHS3azzwOKhg>
    <xmx:5KUuZPfT1txrBWxq7cLwYw1ahBDxMHmtYr80E9DOWMmcJXDtXSxkXA>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 06:58:40 -0400 (EDT)
Message-ID: <d732a8f6-4a0a-d7ff-af9c-f377fefd1283@fastmail.com>
Date:   Thu, 6 Apr 2023 19:58:38 +0900
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
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <2023040627-paver-recipient-3713@gregkh>
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

On 4/6/23 19:26, Greg KH wrote:
> On Thu, Apr 06, 2023 at 07:13:38PM +0900, Damien Le Moal wrote:
>> On 4/6/23 19:05, Greg KH wrote:
>>> On Thu, Apr 06, 2023 at 05:30:56PM +0800, Yangtao Li wrote:
>>>> Use kobject_is_added() instead of local `s_sysfs_registered` variables.
>>>> BTW kill kobject_del() directly, because kobject_put() actually covers
>>>> kobject removal automatically.
>>>>
>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>> ---
>>>>  fs/zonefs/sysfs.c  | 11 +++++------
>>>>  fs/zonefs/zonefs.h |  1 -
>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>>>> index 8ccb65c2b419..f0783bf7a25c 100644
>>>> --- a/fs/zonefs/sysfs.c
>>>> +++ b/fs/zonefs/sysfs.c
>>>> @@ -101,8 +101,6 @@ int zonefs_sysfs_register(struct super_block *sb)
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	sbi->s_sysfs_registered = true;
>>>
>>> You know this, why do you need to have a variable tell you this or not?
>>
>> If kobject_init_and_add() fails, zonefs_sysfs_register() returns an error and
>> fill_super will also return that error. vfs will then call kill_super, which
>> calls zonefs_sysfs_unregister(). For that case, we need to know that we actually
>> added the kobj.
> 
> Ok, but then why not just 0 out the kobject pointer here instead?  That
> way you will always know if it's a valid pointer or not and you don't
> have to rely on some other variable?  Use the one that you have already :)

but sbi->s_kobj is the kobject itself, not a pointer. I can still zero it out in
case of error to avoid using the added s_sysfs_registered bool. I would need to
check a field of s_kobj though, which is not super clean and makes the code
dependent on kobject internals. Not super nice in my opinion, unless I am
missing something.

> And you really don't even need to check anything, just pass in NULL to
> kobject_del() and friends, it should handle it.>
>>>> -
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -110,12 +108,13 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>>>  {
>>>>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>>>  
>>>> -	if (!sbi || !sbi->s_sysfs_registered)
>>>
>>> How can either of these ever be true?  Note, sbi should be passed here
>>> to this function, not the super block as that is now unregistered from
>>> the system.  Looks like no one has really tested this codepath that much
>>> :(
>>>
>>>> +	if (!sbi)
>>>>  		return;
>>>
>>> this can not ever be true, right?
>>
>> Yes it can, if someone attempt to mount a non zoned device. In that case,
>> fill_super returns early without setting sb->s_fs_info but vfs still calls
>> kill_super.
> 
> But you already had a sbi pointer in the place that this was called, so
> you "know" if you need to even call into here or not.  You are having to
> look up the same pointer multiple times in this call chain, there's no
> need for that.

I am not following here. Either we check that we have sbi here in
zonefs_sysfs_unregister(), or we conditionally call this function in
zonefs_kill_super() with a "if (sbi)". Either way, we need to check since sbi
can be NULL.

> 
> thanks,
> 
> greg k-h

