Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4477E5B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjHPPyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbjHPPyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:54:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01891DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:54:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CFBBC5C00C7;
        Wed, 16 Aug 2023 11:54:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 16 Aug 2023 11:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692201259; x=1692287659; bh=t/Qqp7HnqpQKAyVn04332oE44ALeGU8ZlU3
        k/ZO0/U4=; b=G6ST5LfobU1lr7BLXLtikEXTIk/J07xOe4sHkdX2hCZAXY+Az/I
        kzN0Z/v73yCi4l/4SGLHJizqX6dTkE75/2gJvKh1qBhkV5b9zxFIqcPCzWYUNIAs
        VvkEm/9u6ow5Z/LJTdJJ1tYegt5clT0rmDGKyvhImRdvBs5lMhsH1V7GMh27Ce04
        g7T7EHUI1abjgymuYS58KSHQ5rDMsCF3OsABbPHrFcF0mJvxt4zAFGeVd1UmIxry
        VLZixEzRktBQcdGKFDMXcJhCGBcT3ZJUoRrIS6Z/R8Om45vWl1fWYwVGdWjNuFqs
        lj2rSMynAaeGP0rqF8kWA8COyDiB5eCibNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692201259; x=1692287659; bh=t/Qqp7HnqpQKAyVn04332oE44ALeGU8ZlU3
        k/ZO0/U4=; b=V/GCmiqKvvujAqQS4J+RPADs8UtZanuq01hFNB97qZNLPFvBtTS
        lWDa5znrqnNCc8rq5lLnAUZDV0hcB4kEnE3MQrNn/bmnjAumL0DKnvyhRAjYYr1o
        PEIENAFOqyKT/LhhdkBjz2uB7y9zoCbovO+VWHNGDAxOwQxRj4dQJj2z5+VIdti4
        I3V/bhze0VyAJgpcu2h7VH1ZTA/9SC6K98C1GrFl08upEwagjGkUFs7tziCxLd6H
        iA55VAvjSsfgCm10cB6z2nLC1esuRElGzHtLcG4b2aljsASNHqH2YdSgqRulXdRv
        3zhU9lSA9AKwE+L95OgPjdTwhx/HhdjPG+w==
X-ME-Sender: <xms:KvHcZE0t-EZpaNst9CZzTo7LTHXgphbH-pfPJtOhbrSqLZkI_WDONA>
    <xme:KvHcZPGTUAE5XLe8hSEdjZkFki8e0nRWvM2KijhtIkK2PD6tqw4z0AT4piVmQkZi5
    iGxssKb6d1A49O7>
X-ME-Received: <xmr:KvHcZM7bxUv2gNxdF5qh9XhV9jtXivLppUTuUFFmGoS7oLw9kuCmqtdTIDCsq_XqtA8KTd_sMgn1KMZaJRwS7GPMBfhhQxg-o2KQk81EExrbnaEo_ioWDc7Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:KvHcZN0WhZGEO1OlzykEMIys8BWKEnP_30X5D0CAu2szrUVqoKHbZQ>
    <xmx:KvHcZHEONX440hpDa5ueDXkkAMAuRutUuEVkAorKz_j5hcdFnffOsA>
    <xmx:KvHcZG9IozZpHYgvr17vENRrTiouREVp1Eh2actmetGeMiN6ambvDA>
    <xmx:K_HcZINh_E5LJvN02IgXg7fWHDIR0uFVIKUOBhiqTSeKjHSIRs9Z2g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 11:54:17 -0400 (EDT)
Message-ID: <4a926581-a156-1580-c554-90896cd338e4@fastmail.fm>
Date:   Wed, 16 Aug 2023 17:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
 <20230816143313.2591328-4-bschubert@ddn.com>
 <CAJfpegtEj1gyTG+mJLrPEerR3VuNNHhp7uYmU5R8a0x-Sv=BVw@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtEj1gyTG+mJLrPEerR3VuNNHhp7uYmU5R8a0x-Sv=BVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/16/23 17:25, Miklos Szeredi wrote:
> On Wed, 16 Aug 2023 at 16:34, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> From: Miklos Szeredi <miklos@szeredi.hu>
>>
>> atomic_open() will do an open-by-name or create-and-open
>> depending on the flags.
>>
>> If file was created, then the old positive dentry is obviously
>> stale, so it will be invalidated and a new one will be allocated.
>>
>> If not created, then check whether it's the same inode (same as in
>> ->d_revalidate()) and if not, invalidate & allocate new dentry.
>>
>> Changes (v7 global series) from Miklos initial patch (by Bernd):
>> - LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
>>    calls into the file system when revalidate by atomic open is
>>    supported - this is to avoid that ->d_revalidate() would skip
>>    revalidate and set DCACHE_ATOMIC_OPEN, although vfs
>>    does not supported it in the given code path (for example
>>    when LOOKUP_RCU is set)).
>> - Support atomic-open-revalidate in lookup_fast() - allow atomic
>>    open for positive dentries without O_CREAT being set.
>>
>> Changes (v8 global series)
>> - Introduce enum for d_revalidate return values
>> - LOOKUP_ATOMIC_REVALIDATE is removed again
>> - DCACHE_ATOMIC_OPEN flag is replaced by D_REVALIDATE_ATOMIC
>>    return value
>>
>> Co-developed-by: Bernd Schubert <bschubert@ddn.com>
>> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> ---
>>   fs/namei.c            | 25 +++++++++++++++++++------
>>   include/linux/namei.h |  6 ++++++
>>   2 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index e4fe0879ae55..8381ec7645f5 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -858,7 +858,7 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
>>          if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
>>                  return dentry->d_op->d_revalidate(dentry, flags);
>>          else
>> -               return 1;
>> +               return D_REVALIDATE_VALID;
>>   }
>>
>>   /**
>> @@ -1611,10 +1611,11 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>>   }
>>   EXPORT_SYMBOL(lookup_one_qstr_excl);
>>
>> -static struct dentry *lookup_fast(struct nameidata *nd)
>> +static struct dentry *lookup_fast(struct nameidata *nd, int *atomic_revalidate)
> 
> bool?
> 
>>   {
>>          struct dentry *dentry, *parent = nd->path.dentry;
>>          int status = 1;
>> +       *atomic_revalidate = 0;
>>
>>          /*
>>           * Rename seqlock is not required here because in the off chance
>> @@ -1656,6 +1657,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
>>                  dput(dentry);
>>                  return ERR_PTR(status);
>>          }
>> +
>> +       if (status == D_REVALIDATE_ATOMIC)
>> +               *atomic_revalidate = 1;
>> +
>>          return dentry;
>>   }
>>
>> @@ -1981,6 +1986,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
>>   static const char *walk_component(struct nameidata *nd, int flags)
>>   {
>>          struct dentry *dentry;
>> +       int atomic_revalidate;
>>          /*
>>           * "." and ".." are special - ".." especially so because it has
>>           * to be able to know about the current root directory and
>> @@ -1991,7 +1997,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
>>                          put_link(nd);
>>                  return handle_dots(nd, nd->last_type);
>>          }
>> -       dentry = lookup_fast(nd);
>> +       dentry = lookup_fast(nd, &atomic_revalidate);
>>          if (IS_ERR(dentry))
>>                  return ERR_CAST(dentry);
>>          if (unlikely(!dentry)) {
>> @@ -1999,6 +2005,9 @@ static const char *walk_component(struct nameidata *nd, int flags)
>>                  if (IS_ERR(dentry))
>>                          return ERR_CAST(dentry);
>>          }
>> +
>> +       WARN_ON(atomic_revalidate);
>> +
>>          if (!(flags & WALK_MORE) && nd->depth)
>>                  put_link(nd);
>>          return step_into(nd, flags, dentry);
>> @@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>>                  dput(dentry);
>>                  dentry = NULL;
>>          }
>> -       if (dentry->d_inode) {
>> +       if (dentry->d_inode && error != D_REVALIDATE_ATOMIC) {
>>                  /* Cached positive dentry: will open in f_op->open */
>>                  return dentry;
>>          }
>> @@ -3523,15 +3532,19 @@ static const char *open_last_lookups(struct nameidata *nd,
>>          }
>>
>>          if (!(open_flag & O_CREAT)) {
>> +               int atomic_revalidate;
>>                  if (nd->last.name[nd->last.len])
>>                          nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>>                  /* we _can_ be in RCU mode here */
>> -               dentry = lookup_fast(nd);
>> +               dentry = lookup_fast(nd, &atomic_revalidate);
>>                  if (IS_ERR(dentry))
>>                          return ERR_CAST(dentry);
>> +               if (dentry && unlikely(atomic_revalidate)) {
> 
> Need to assert !LOOKUP_RCU

Are you sure? There is the BUG_ON(nd->flags & LOOKUP_RCU) directly after 
- should be enough?

> 
>> +                       dput(dentry);
>> +                       dentry = NULL;
>> +               }
> 
> Feels a shame to throw away the dentry.  May be worth adding a helper
> for the plain atomic open, most of the complexity of lookup_open() is
> because of O_CREAT, so this should be much simplified.

Thanks, I'm going to look into it.

> 
>>                  if (likely(dentry))
>>                          goto finish_lookup;
>> -
> 
> Adding/removing empty lines is just a distraction, so it shouldn't be
> done unless it serves a real purpose.

Ah sorry, accidentally. I'm going to travel the next two days, going to 
update it on Monday (or at best over the weekend).

Thanks,
Bernd
