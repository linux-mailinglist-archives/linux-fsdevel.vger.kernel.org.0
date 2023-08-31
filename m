Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DEB78EFB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjHaOls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:41:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C5CDA;
        Thu, 31 Aug 2023 07:41:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 648865C00FC;
        Thu, 31 Aug 2023 10:41:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 31 Aug 2023 10:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693492903; x=1693579303; bh=wFwIXp/yx2ImRg0RwGwwtPx0vxaAWjiiPB6
        ptRXRRPg=; b=dINB9MAEoqniNuUTC1hBp5OaQt76Jhn35uOlHeJdMJJAjMPTMna
        cM2yU6jhqnqxe5a92PfUrtekwoIi+DnK5W2t+NnWA3RqaAmZ5zwJCuTpUU3AiilC
        Uypj9NKsFwHWrE2P9srehDwHJe6SzBqbuzuBoamk2VigGMQtEekosPgICPafdJwK
        /SkkrgZuwVsqpbg9rHrqnAydBBa4liZGf+pTTPm+mNJzO66KusDyYIg7Mi5pO/Ex
        Gvq3Cns/vi4SAX3KLTzakFBOORZ5V09CfJNMBoiTEF5ZjkoXMJnqjNsM3xs58/5r
        plzTGjWLyStPKE16BzgYfsZ5+PyXjar7Agg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693492903; x=1693579303; bh=wFwIXp/yx2ImRg0RwGwwtPx0vxaAWjiiPB6
        ptRXRRPg=; b=Ya9SkJnJjmJc2nYyfFhhovqR1BpODS5xOquA/+5g/QPwKJTxiFc
        1hHPG+9kbTMNX7arQMAhHfnvqjTRP8zKkoYBP8ANQou9ixZEMZHuSgffGXW0139+
        nQT463Fu1ZwfrrUHP3KnYw/eRYCvnSunn7pwoSgRwaKo/nQp0R+gbOMbfppd7YGA
        hnC1jAgHJ0D2K8A6all8V6jgFKEIk2WO2jTELWLwmP7YRgxm1CzuKbS5z9IwUr50
        7XRdNjIx3b4MkKdShz3M8nQzO+dVyFCDGHQZHD65tKu+IXOk0dnhFSbfuDtM8PW2
        pGG/TBqwfRUepZlZS7hkQgY0J6rz7JYZ64g==
X-ME-Sender: <xms:pqbwZNIFMP0HH4_SK-RWkoRynHcxuK_3wgt6h5Am6271cgbaXODI6Q>
    <xme:pqbwZJJCO7Q8P3vixjQhC4NVYhDmcHXMMV8Gxg3HVkt5CLs0YgjP9TekmXYcCup0S
    Tvp3Zu6TXb9F4pu>
X-ME-Received: <xmr:pqbwZFvcAu0dgOiAiEdBVUu-HMKrsVy0vnH_mzqW28RWbhwTnqswub7NRvBrk63FuBS5vwl45an5B34zri9egnEVnYEKxVqQcxXh6qu2_iO-yhAPRHJf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:pqbwZOYA-c44u-iLl6WI8eoPfXQb9dZIfE3x4ELvK34drkGCvXGGvQ>
    <xmx:pqbwZEbKH1tOwBc4YzQ0Jsb3X878GfWjF8EVbsALnd6vYe-BwrYumw>
    <xmx:pqbwZCCgsgmNDYDeasc6osGGY06wNVQQPqJL60kXK8Nxhlh0anj1Ng>
    <xmx:p6bwZE6VIhZkQelQDKZTvmgUIBaq-lnsWfH_DRX6ksFyyj5TciRpzw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 10:41:41 -0400 (EDT)
Message-ID: <5985c6e0-1a63-0b18-5ab2-9a0418f29559@fastmail.fm>
Date:   Thu, 31 Aug 2023 16:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Content-Language: en-US, de-DE
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230830181519.2964941-1-bschubert@ddn.com>
 <20230831101824.qdko4daizgh7phav@f>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230831101824.qdko4daizgh7phav@f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/23 12:18, Mateusz Guzik wrote:
> On Wed, Aug 30, 2023 at 08:15:17PM +0200, Bernd Schubert wrote:
>> While adding shared direct IO write locks to fuse Miklos noticed
>> that file_remove_privs() needs an exclusive lock. I then
>> noticed that btrfs actually has the same issue as I had in my patch,
>> it was calling into that function with a shared lock.
>> This series adds a new exported function file_needs_remove_privs(),
>> which used by the follow up btrfs patch and will be used by the
>> DIO code path in fuse as well. If that function returns any mask
>> the shared lock needs to be dropped and replaced by the exclusive
>> variant.
>>
> 
> No comments on the patchset itself.
> 
> So I figured an assert should be there on the write lock held, then the
> issue would have been automagically reported.
> 
> Turns out notify_change has the following:
>          WARN_ON_ONCE(!inode_is_locked(inode));
> 
> Which expands to:
> static inline int rwsem_is_locked(struct rw_semaphore *sem)
> {
>          return atomic_long_read(&sem->count) != 0;
> }
> 
> So it does check the lock, except it passes *any* locked state,
> including just readers.
> 
> According to git blame this regressed from commit 5955102c9984
> ("wrappers for ->i_mutex access") by Al -- a bunch of mutex_is_locked
> were replaced with inode_is_locked, which unintentionally provides
> weaker guarantees.
> 
> I don't see a rwsem helper for wlock check and I don't think it is all
> that beneficial to add. Instead, how about a bunch of lockdep, like so:
> diff --git a/fs/attr.c b/fs/attr.c
> index a8ae5f6d9b16..f47e718766d1 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>          struct timespec64 now;
>          unsigned int ia_valid = attr->ia_valid;
> 
> -       WARN_ON_ONCE(!inode_is_locked(inode));
> +       lockdep_assert_held_write(&inode->i_rwsem);
> 
>          error = may_setattr(idmap, inode, ia_valid);
>          if (error)
> 
> Alternatively hide it behind inode_assert_is_wlocked() or whatever other
> name.
> 
> I can do the churn if this sounds like a plan.
> 

I guess that might help to discover these issues. Maybe keep the 
existing WARN_ON_ONCE, as it would annotate a missing lock, when lockdep 
is turned off?

Another code path is file_modified() and I just wonder if there are more 
issues.

btrfs_punch_hole() takes inode->i_mmap_lock. Although I guess that 
should be found by the existing WARN_ON_ONCE? Actually same in 
btrfs_fallocate(). Or does btrfs always have IS_NOSEC?


Thanks,
Bernd
