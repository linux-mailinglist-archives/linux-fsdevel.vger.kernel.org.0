Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA57A970A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjIURLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjIURKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A1A27A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A316632009F8;
        Thu, 21 Sep 2023 05:16:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Sep 2023 05:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695287783; x=1695374183; bh=VEYeuxPVa1NSxd06FnInDh1UW+GcBPk4AAG
        bHbpnU7g=; b=mV43RzPcuZSN19rko+9igKF3bicIiBkFq8wNWfLZe2uvSrHLedA
        iDcFg2SIOEMgLaYSv1+Q5gYGC2QwnuWJIt9iEksKArcrwr1jsGSMswMTxz1IZqZX
        85QQs/EUes5bPlUPC1iBb7apanoypZcBTHCEfKMw7/J7bA78cSok0wPbFHpVFttt
        YsATtIF8+pXsCtiFiIdQfMUc+HRoUaEYU39YZGKA/Wy3VLXyckb1LrHQBmjKVw2j
        KLVxUQ+RxrdGW4xOKycE0EZx6lYXVFT6v/AtpUThzlX+UfxGgojJN1bleA2ovBBN
        alWSwKg6HVHkSH/woQJDS0N7mfPMf3dz/cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695287783; x=1695374183; bh=VEYeuxPVa1NSxd06FnInDh1UW+GcBPk4AAG
        bHbpnU7g=; b=T/+rWlqqn8ewP3Kbv25sxAtcAn56TCe3mMRc8kD7BYxEffFgRHI
        spGBDspy84NGVgtt2U6xileFZT5droWgmeBedLLKaJyo56NZXdbzImr8x7I2INRV
        28hiaGyCx9xQ9/Q+rEP6f3T21e77WiokFfFCBtHecV5Fxr4xSpzyayWAnXGynLZa
        EQ/tBn6KfTZfSiWxKdt7shyonp6uMVyv6OfXKmbn+gQYL1zeoQm78J4pIwTxfZYx
        b+LGLG4V6eJGuBR1/ASdoWQkNZMoZVgpNhPcVOQ2cv2WnbUYJIXTJ2rY3orzSIa/
        EOQb9eziU0yp6UpvVPs8ZdOVPaDWKC4b+Vw==
X-ME-Sender: <xms:5gkMZebYT94A41E0L_rMF1hQqOBECBERzNaNgsaEgk7rwxtxhowD0g>
    <xme:5gkMZRYa3BRbU_qWSvNoZ82PVY1M5GufKJBZrmn2A2DMv_OqNd9mq8dfqn28_GFsY
    8if_rIvGMLME2bk>
X-ME-Received: <xmr:5gkMZY83z7h6gCr2OwWYwY0ifli1kgwfLRa5ObBnhiLvQfp7R4fig8SZ269XpLSUpiffg4rOlkur0gYy6ySzK7ChGQKhjywUhf7O0-XjlzcleuDomK0O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedtkeeileeghedukefghfdtuddvudfgheel
    jeejgeelueffueekheefheffveelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:5gkMZQqO3FoQIRgbBGCjCoyVXseu8vm8qMTpCnaycF9clkqbCJ1N-A>
    <xmx:5gkMZZo6AbHRNmybiGVLN92cSivaj6L9nJ3naAHQq8Rq0-3egOBMSA>
    <xmx:5gkMZeTrCosOfAy78U9wcDn2aFTaGxTbPZrD1l9Rt9WunpadrabeFw>
    <xmx:5wkMZSDBZtOjkqP6KjXeebLEIRCEecQGkDuTw_yuz8uf4-qWCNWpgQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 05:16:21 -0400 (EDT)
Message-ID: <b63b4785-5589-47e5-b60e-3134cc0f5195@fastmail.fm>
Date:   Thu, 21 Sep 2023 11:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
Content-Language: en-US, de-DE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <20230920173445.3943581-5-bschubert@ddn.com>
 <CAOQ4uxjsfjEBo3obU9EPZuwkHXu_aPo+BJgVCOdN7V6bSRGXvA@mail.gmail.com>
 <9a135af5-2acf-42ed-b30e-f79ac7c86e25@fastmail.fm>
 <CAOQ4uxjouwKB4p=V-fWa_vx4_FpyHpS1xm5vwr_sdFRiQTwWTg@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxjouwKB4p=V-fWa_vx4_FpyHpS1xm5vwr_sdFRiQTwWTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/21/23 10:29, Amir Goldstein wrote:
> On Thu, Sep 21, 2023 at 11:09 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 9/21/23 08:16, Amir Goldstein wrote:
>>> On Thu, Sep 21, 2023 at 12:48 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> This was suggested by Miklos based on review from the previous
>>>> patch that introduced atomic open for positive dentries.
>>>> In open_last_lookups() the dentry was not used anymore when atomic
>>>> revalidate was available, which required to release the dentry,
>>>> then code fall through to lookup_open was done, which resulted
>>>> in another d_lookup and also d_revalidate. All of that can
>>>> be avoided by the new atomic_revalidate_open() function.
>>>>
>>>> Another included change is the introduction of an enum as
>>>> d_revalidate return code.
>>>>
>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>>>> Cc: Dharmendra Singh <dsingh@ddn.com>
>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> ---
>>>>    fs/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 43 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/namei.c b/fs/namei.c
>>>> index f01b278ac0ef..8ad7a0dfa596 100644
>>>> --- a/fs/namei.c
>>>> +++ b/fs/namei.c
>>>> @@ -3388,6 +3388,44 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>>>>           return dentry;
>>>>    }
>>>>
>>>> +static struct dentry *atomic_revalidate_open(struct dentry *dentry,
>>>> +                                            struct nameidata *nd,
>>>> +                                            struct file *file,
>>>> +                                            const struct open_flags *op,
>>>> +                                            bool *got_write)
>>>> +{
>>>> +       struct mnt_idmap *idmap;
>>>> +       struct dentry *dir = nd->path.dentry;
>>>> +       struct inode *dir_inode = dir->d_inode;
>>>> +       int open_flag = op->open_flag;
>>>> +       umode_t mode = op->mode;
>>>> +
>>>> +       if (unlikely(IS_DEADDIR(dir_inode)))
>>>> +               return ERR_PTR(-ENOENT);
>>>> +
>>>> +       file->f_mode &= ~FMODE_CREATED;
>>>> +
>>>> +       if (unlikely(open_flag & O_CREAT)) {
>>>> +               WARN_ON(1);
>>>
>>>         if (WARN_ON_ONCE(open_flag & O_CREAT)) {
>>>
>>> is more compact and produces a nicer print
>>
>> Thanks a lot for your review Amir! Nice, I hadn't noticed that
>> these macros actually return a value. Also updated the related
>> fuse patch, which had a similar construct.
>>
>>>
>>>> +               return ERR_PTR(-EINVAL);
>>>> +       }
>>>> +
>>>> +       if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
>>>> +               *got_write = !mnt_want_write(nd->path.mnt);
>>>> +       else
>>>> +               *got_write = false;
>>>> +
>>>> +       if (!got_write)
>>>> +               open_flag &= ~O_TRUNC;
>>>> +
>>>> +       inode_lock_shared(dir->d_inode);
>>>> +       dentry = atomic_open(nd, dentry, file, open_flag, mode);
>>>> +       inode_unlock_shared(dir->d_inode);
>>>> +
>>>> +       return dentry;
>>>> +
>>>> +}
>>>> +
>>>>    /*
>>>>     * Look up and maybe create and open the last component.
>>>>     *
>>>> @@ -3541,8 +3579,10 @@ static const char *open_last_lookups(struct nameidata *nd,
>>>>                   if (IS_ERR(dentry))
>>>>                           return ERR_CAST(dentry);
>>>>                   if (dentry && unlikely(atomic_revalidate)) {
>>>> -                       dput(dentry);
>>>> -                       dentry = NULL;
>>>> +                       BUG_ON(nd->flags & LOOKUP_RCU);
>>>
>>> The assertion means that someone wrote bad code
>>> it does not mean that the kernel internal state is hopelessly corrupted.
>>> Please avoid BUG_ON and use WARN_ON_ONCE and if possible
>>> (seems to be the case here) also take the graceful error path.
>>> It's better to fail an open than to crash the kernel.
>>
>> Thanks, updated. I had used BUG_ON because there is a similar BUG_ON a
>> few lines below.
> 
> checkpatch strictly forbids new BUG_ON:
> "Do not crash the kernel unless it is absolutely unavoidable-- use
>   WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants"
> 
> But it's true that vfs code has several of those.

Yeah sorry, I had seen the warning, but ignored it, in favor of code
consistency.

> 
>> Added another RFC patch to covert that one as well.
>> I'm going to wait a few days for possible other reviews and will then send
>> out the new version. The updated v10 branch is here
>>
>> https://github.com/bsbernd/linux/tree/atomic-open-for-6.5-v10
>>
> 
> IIUC, patches 3,4 are independent vfs optimization.
> Is that correct?

Hmm, not exactly. Patches 3 is a dependency for patch 5-7. So far
atomic open didn't handle positive dentries / revalidate.
Patch 3 adds support for that, the file system then needs to
signal in its ->d_revalidate return code that it wants
atomic_open to do the revalidation (which adds a bit complexity to
the atomic_open method). Patch 3 has then two cases,
O_CREATE and plain open without O_CREATE. Patch 4 is an
optimization for patch 3, for plain open. I actually start
to wonder if I shouldn't remove plain open from patch 3
and to add that in patch 4. Probably easier to read. Thanks for
making me think about that :)

> 
> Since you are going to need review of vfs maintainers
> and since Christian would probably want to merge them
> via the vfs tree, I think it would be better for you to post
> them separately from your series if possible, so Miklos
> would be able to pick up the fuse patches when they are
> reviewed.

Only the new patch 8 is independent, I'm going to send that out
separately today.


Thanks,
Bernd
