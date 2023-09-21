Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCC7A97BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIUR1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIUR1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:27:05 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E70CC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2725C32009C1;
        Thu, 21 Sep 2023 04:09:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Sep 2023 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695283757; x=1695370157; bh=nA0/jPVwk0exPLmG+4I7iW/AUsZGMC1LZMc
        vxEBfYI4=; b=gPUtJgVD46tgWLGeIo8wKKlgGlWVsHuFbQEbAiKubz2ykFbZtrV
        3M2vT8/g3mr9Ol9Avj7891KY0sewWH+RjNe35OZw0lmrvFrFUuGbcOm34VqYn3yJ
        ZFSzVcOLfWC1CtrddKQ3PVyVJyD5Jd0yV6p3+fv1gW5zpMCbZH2UvLmHOe6qZjXZ
        /xeRN7XSPcMfTC3h/oR/bprhJm1PYUuANuYZxEqp7Nw2cE4mqRa0NwreX225fIBk
        T5YHoJd5UNKnp3se2B/bO48M7loRs0y919nmFW+FalgqQ4L34vtGaB8lyos2XcRR
        K90SXiHJ2lcyY54SUdszjkMHPd7ieKIpgWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695283757; x=1695370157; bh=nA0/jPVwk0exPLmG+4I7iW/AUsZGMC1LZMc
        vxEBfYI4=; b=lh9qbkPmTpxdvR3s0cmmpepyJakzNJydH9Oqm1Oh1T+emcFmXEl
        XvenWxM2l0UWptLj+MsTgz/+/7OCavVDWL8SlTUAomDdTGn4etVoUShBg/mnvnjT
        GoYYzNsE8dFiyJbRGMwImQNhaCwwNJ/8YeLCayNVrNdVuhzgevoQTbDjTmzGkyQH
        hCPZD7mMaX6WCTCvCsNvebEhaIH0J/xbceWfyxlOzl7crP+Khi16aev5mDPEPn6W
        Oj8Tb4/5ujvtTy38Tyj4Mr7N7lm1BDfOj/bOS/ZXv4wqoFgce9QoiKoVmNXMDY+u
        047M7YCHYIq1I1nXKrqcGHqrj2NLcth8oow==
X-ME-Sender: <xms:LfoLZYqgUFDlkfqgw_0z2s3TNOZycropObweM9GtzJf4kSWg-E5LTw>
    <xme:LfoLZepyvpVCOeKA8uQVIyxxUTNwINTcHA_coEhgsWBfxQr5bK_qAGR8UiW2dpK8X
    aBA3wqHTn9PcHje>
X-ME-Received: <xmr:LfoLZdOBbbDudnmOO0gclquM-UnitawHCufKCYwCacyaQYOg1kmI7UprO8x8_8cHcxTvkXEK29BUFg1vIpoB-N_U-4eOTjDsvLc6-yCTOkttBp0SeRIv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfehleejjeeg
    leeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgt
    hhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:LfoLZf5Eq24K--yjzRUCm67ynXejoTjZU_j3rf8DvLUDIyQ-07REHg>
    <xmx:LfoLZX5YVBmQzbZSi-d_1G6D5EwNC1I9vBGJVyn0vYwkoMGPJfr0bw>
    <xmx:LfoLZfh9eeka2hPloyBBx406yqoqwPAE8RE0HtoMn_4KhMgAhgNKjQ>
    <xmx:LfoLZdQF_vcMQE3yCXfGORIuZ-uJjbwcQvILAwT6PjuJVEulE30n5A>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 04:09:16 -0400 (EDT)
Message-ID: <9a135af5-2acf-42ed-b30e-f79ac7c86e25@fastmail.fm>
Date:   Thu, 21 Sep 2023 10:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
To:     Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <20230920173445.3943581-5-bschubert@ddn.com>
 <CAOQ4uxjsfjEBo3obU9EPZuwkHXu_aPo+BJgVCOdN7V6bSRGXvA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxjsfjEBo3obU9EPZuwkHXu_aPo+BJgVCOdN7V6bSRGXvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/21/23 08:16, Amir Goldstein wrote:
> On Thu, Sep 21, 2023 at 12:48 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This was suggested by Miklos based on review from the previous
>> patch that introduced atomic open for positive dentries.
>> In open_last_lookups() the dentry was not used anymore when atomic
>> revalidate was available, which required to release the dentry,
>> then code fall through to lookup_open was done, which resulted
>> in another d_lookup and also d_revalidate. All of that can
>> be avoided by the new atomic_revalidate_open() function.
>>
>> Another included change is the introduction of an enum as
>> d_revalidate return code.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: linux-fsdevel@vger.kernel.org
>> ---
>>   fs/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index f01b278ac0ef..8ad7a0dfa596 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3388,6 +3388,44 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>>          return dentry;
>>   }
>>
>> +static struct dentry *atomic_revalidate_open(struct dentry *dentry,
>> +                                            struct nameidata *nd,
>> +                                            struct file *file,
>> +                                            const struct open_flags *op,
>> +                                            bool *got_write)
>> +{
>> +       struct mnt_idmap *idmap;
>> +       struct dentry *dir = nd->path.dentry;
>> +       struct inode *dir_inode = dir->d_inode;
>> +       int open_flag = op->open_flag;
>> +       umode_t mode = op->mode;
>> +
>> +       if (unlikely(IS_DEADDIR(dir_inode)))
>> +               return ERR_PTR(-ENOENT);
>> +
>> +       file->f_mode &= ~FMODE_CREATED;
>> +
>> +       if (unlikely(open_flag & O_CREAT)) {
>> +               WARN_ON(1);
> 
>        if (WARN_ON_ONCE(open_flag & O_CREAT)) {
> 
> is more compact and produces a nicer print

Thanks a lot for your review Amir! Nice, I hadn't noticed that
these macros actually return a value. Also updated the related
fuse patch, which had a similar construct.

> 
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
>> +               *got_write = !mnt_want_write(nd->path.mnt);
>> +       else
>> +               *got_write = false;
>> +
>> +       if (!got_write)
>> +               open_flag &= ~O_TRUNC;
>> +
>> +       inode_lock_shared(dir->d_inode);
>> +       dentry = atomic_open(nd, dentry, file, open_flag, mode);
>> +       inode_unlock_shared(dir->d_inode);
>> +
>> +       return dentry;
>> +
>> +}
>> +
>>   /*
>>    * Look up and maybe create and open the last component.
>>    *
>> @@ -3541,8 +3579,10 @@ static const char *open_last_lookups(struct nameidata *nd,
>>                  if (IS_ERR(dentry))
>>                          return ERR_CAST(dentry);
>>                  if (dentry && unlikely(atomic_revalidate)) {
>> -                       dput(dentry);
>> -                       dentry = NULL;
>> +                       BUG_ON(nd->flags & LOOKUP_RCU);
> 
> The assertion means that someone wrote bad code
> it does not mean that the kernel internal state is hopelessly corrupted.
> Please avoid BUG_ON and use WARN_ON_ONCE and if possible
> (seems to be the case here) also take the graceful error path.
> It's better to fail an open than to crash the kernel.

Thanks, updated. I had used BUG_ON because there is a similar BUG_ON a
few lines below. Added another RFC patch to covert that one as well.
I'm going to wait a few days for possible other reviews and will then send
out the new version. The updated v10 branch is here

https://github.com/bsbernd/linux/tree/atomic-open-for-6.5-v10


Thanks,
Bernd
