Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E962E9AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 00:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKQXhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 18:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQXhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:37:43 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB29769CC;
        Thu, 17 Nov 2022 15:37:42 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 924E05C0078;
        Thu, 17 Nov 2022 18:37:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Nov 2022 18:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668728260; x=
        1668814660; bh=TQyOyG2RKffQ9pXKTnrCZ6HzkCFg11bWWiOyqc7MfsU=; b=T
        tbFlz1KMJ1hg/tbPjSGig49v6z8K3cnuDZHY9J4Int0sG89oAmPd4hh5Pd/PrNKk
        bFgcW/wO6gY+lSAd+bhCqdFGc6vGWgAT9GotNr0ZHTqIzSnoVCS5A36uGwSg8GDS
        eiJajrqT6oou1tPRIuXl2V9SON/pSWIWD19q5dGvcrBcteIF6yChEdM32onFJIw7
        +5aJAI4yz/WmqfvyU+q5apFRcL/YozUvpolbQoS98MuSojjuyMpdn5PCeg5xP//J
        mFj7P08aIj7NT8f/6Y5oG2LI60l4wCjPVVz7YE38D/LY3gAruPQFwFJgVKTvZqYb
        wWcxZDExy08sZAaBw4t8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668728260; x=
        1668814660; bh=TQyOyG2RKffQ9pXKTnrCZ6HzkCFg11bWWiOyqc7MfsU=; b=r
        r5LL3vVMj8j2W/zONnBHYNJBRUCVTSfv5mM4hT7zgH6XPCx6bkjvoUISYHqsVJsN
        hBHKRtq6gxOQ2o4WZHphRyJDB2NeTgfPZG2L+cjqRtCsR+kG+0w8Pw9cbKpShm/i
        DxiwRnoevRNrWyZBZvTNvQkASasEElhnYYRqo9vEqJP+sQVq/Y4vkMcse5ZW/4cS
        ZBF+pfO6LNYr4LK9ZFNP8nJZN16XsyzxAL+afgO1oAZauy3ScHATiq6+5p4pApYj
        Fl0J316JLZ34J3+ETtvucm79XrFTb+EQa4zw0WwTRb0f51ojJ48aI8oebjeQsIp4
        hiQdbc/lGOcJr+YFyKBcw==
X-ME-Sender: <xms:w8V2Y9j1C1JGw928FNnajKQLa5KeKrpVmhaV3tJm8cBgmzf1zqGugw>
    <xme:w8V2YyDZDen1Y0VK2eQwT9iqF-n8_W2lfeEALTXMa0B0QRw0nR6mNb1v-g1qpgoj6
    ZmaWAEzZ-4->
X-ME-Received: <xmr:w8V2Y9GK2IysCjF3zwvoUti8WBtKIt3iH4Gem64vhY-Evsm3k20QbTYaEC3jbePZyViqY2Og7gvK8mo5QWH3sNpp_dIm7iYTIEKBRO0XdE6aF9OcMVC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeelgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egvdetvedvfeeivdeuueejgeetvdehlefhheethfekgfejueffgeeugfekudfhjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:w8V2YyRNegCeR8hE_ThZPxUkN0opfOnI3-MPSA8a6x0ppuAYvD1hBA>
    <xmx:w8V2Y6z01KZ-uAV3qVR-YoYdYgXH2zgRqFosvuKpAxgQXysFF8eUuA>
    <xmx:w8V2Y45R9ZP5Ee5T7QiaqS58F7RELwZ4LyEmd87dtdqOzHT7huAldA>
    <xmx:xMV2Y_oJUvRBhGznxF-CMZef1ggFC0IMlaCOF0ChhKXB-gTwlIo2sQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 18:37:34 -0500 (EST)
Message-ID: <459307a8-cb64-265e-7112-feafaec6a32f@themaw.net>
Date:   Fri, 18 Nov 2022 07:37:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto mounts
To:     Jeff Layton <jlayton@kernel.org>,
        Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        luis.turcitu@appsbroker.com, david@sigma-star.at
References: <20221117191151.14262-1-richard@nod.at>
 <20221117191151.14262-3-richard@nod.at>
 <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/11/22 05:01, Jeff Layton wrote:
> On Thu, 2022-11-17 at 20:11 +0100, Richard Weinberger wrote:
>> This function is only used by NFSD to cross mount points.
>> If a mount point is of type auto mount, follow_down() will
>> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
>> to have ->d_automount() called when NFSD walks down the
>> mount tree.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>   fs/namei.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 578c2110df02..000c4b84e6be 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -1462,7 +1462,7 @@ int follow_down(struct path *path)
>>   {
>>   	struct vfsmount *mnt = path->mnt;
>>   	bool jumped;
>> -	int ret = traverse_mounts(path, &jumped, NULL, 0);
>> +	int ret = traverse_mounts(path, &jumped, NULL, LOOKUP_AUTOMOUNT);
>>   
>>   	if (path->mnt != mnt)
>>   		mntput(mnt);
>
> What happens when CROSSMOUNT isn't enabled and someone tries to stroll
> into an automount point? I'm guessing the automount happens but the
> export is denied? It seems like LOOKUP_AUTOMOUNT ought to be conditional
> on the parent export having CROSSMOUNT set.
>
> There's also another caller of follow_down too, the UNIX98 pty code.
> This may be harmless for it, but it'd be best not to perturb that if we
> can help it.
>
> Maybe follow_down can grow a lookupflags argument?es, I think that's needed too.


Changing the core VFS unconditionally ricks breaking things.


For example this:

         if (!(lookup_flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
                            LOOKUP_OPEN | LOOKUP_CREATE | 
LOOKUP_AUTOMOUNT)) &&
             dentry->d_inode)

will never be true now so that, at the least, the handling of this case

will change for automount(8). I don't remember now the reasons behind

doing this but I do remember there was a special case that needed to

be handled by it.


Ian

