Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131BB7660A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjG1ARK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 20:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG1ARI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:17:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14702685;
        Thu, 27 Jul 2023 17:17:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 16AEA5C018A;
        Thu, 27 Jul 2023 20:17:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 27 Jul 2023 20:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690503422; x=1690589822; bh=B9vNmwATli/9YytihPIv5vkCD7D8T9gClaI
        0PewxNUQ=; b=XBaViwcdJeDS3sg6zo2VPk2SK6SLw6wWFQrY7wbduhfDbssyD2m
        /WCt1fLFQcbQABhuZIBgqqqT2TvOfakTPPkyOAmWrLnVs/XZaXTqzxlJcVWCjOKN
        B16wGl3bfaNV6rNOjcvZ7sPV2H2982B6r3pxQ6kX1cnUz9yGcpUoXqbs/cXWcLPD
        xsS4IZkRcSsNsU39f+AXuCtyuQJ77qPPdsFQihY2DKA20dzmohu5OHMY2LlN/tBm
        zUG4qit2as01U2aNdcEtJSHnNgX3kM1vi+cJyVMU4MtPYu/bjsRXFbIKSSTgkqrc
        umqI42b9jrAUeEnfOA5Mo/f/Ze+yicwIWFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690503422; x=1690589822; bh=B9vNmwATli/9YytihPIv5vkCD7D8T9gClaI
        0PewxNUQ=; b=Qx7Rzow6uR7McQ7/H8Jhf7Ic5WpZvfNhSk7YJa4lCy9EG9g8olb
        rNEYxuPtuB7w5kEc1Iaq4Iz3Jk0pLw7JOv014uRTI2R2b2rj0FeXFjBBti8AiJ05
        SxZgq2Jh2fmMbFUGt3VxK/3cm4D+DKktW2FBbW3fIywkTMdl/5tt0SW0ysJvspo/
        8pOukq6vc4h3LwBVJFXpXTcA8WQ81ugcu0JIMp5/JlD62bX8KQzawcpNFV4DpQZi
        jnC0Ide8VOy7dU+8TF9leSKeQySXxyPTLnI19pjq79rVCYQRvHKIKyfmsfU+fVDQ
        9SYzMDY6Jk3/GqimabqhQt07ag33mxn0KEw==
X-ME-Sender: <xms:_QjDZLLzVGdC9VxpgI2zubv1xCCoVjg57N9KsYnOhIkHlV2CT8WSpw>
    <xme:_QjDZPLKK57A9Au9hVHP2vZkAqOPQ_W8AGoWgxrNqgkCCPdHWyPrVUDutnbgS4tNy
    HFVVHsos2m5>
X-ME-Received: <xmr:_QjDZDstc5tDNa9724iIhF1fbHiu5kTpiq-SV_0k_dxoxgsCm-avT3IKo120eWSm3G9L5XQefJHaSmWxwhHj3bIlui0QE36CKMtULacsTZ2zgnfvcso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:_QjDZEaw9MvzrX1P5qj0FhiQY6b5NqwVNF81nrbN0FkGiq9UCdbPWg>
    <xmx:_QjDZCa2WR6cuardEt_7txyWx6hIiDQ5BgqdivnW4P-rPYopq9vd7A>
    <xmx:_QjDZIBOx-Uz2otSNhQ_S3b6avmxXnaWv-Ee2HpnNWHGBCPQDjhApw>
    <xmx:_gjDZOSLoHrXD-5RUr0bSoVyWLpBTo6ol9uaihqGgCzlyDyXLSCefA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 20:16:55 -0400 (EDT)
Message-ID: <70d667af-661b-6f62-aa29-a3b8610feda6@themaw.net>
Date:   Fri, 28 Jul 2023 08:16:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Imran Khan <imran.f.khan@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
 <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
 <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
 <db933d76-1432-f671-8712-d94de35277d8@themaw.net> <20230718190009.GC411@mutt>
 <76fcd1fe-b5f5-dd6b-c74d-30c2300f3963@themaw.net>
 <ce407424e98bf5f2b186df5d28dd5749a6cbfa45.camel@themaw.net>
 <15eddad0-e73b-2686-b5ba-eaacc57b8947@themaw.net>
 <3505769d-9e7a-e76d-3aa7-286d689345b6@oracle.com>
 <996e11bf-5f22-3ab7-2951-92109649195d@themaw.net>
In-Reply-To: <996e11bf-5f22-3ab7-2951-92109649195d@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/7/23 08:00, Ian Kent wrote:
> On 27/7/23 12:30, Imran Khan wrote:
>> Hello Ian,
>> Sorry for late reply. I was about to reply this week.
>>
>> On 27/7/2023 10:38 am, Ian Kent wrote:
>>> On 20/7/23 10:03, Ian Kent wrote:
>>>> On Wed, 2023-07-19 at 12:23 +0800, Ian Kent wrote:
>> [...]
>>>> I do see a problem with recent changes.
>>>>
>>>> I'll send this off to Greg after I've done some testing (primarily 
>>>> just
>>>> compile and function).
>>>>
>>>> Here's a patch which describes what I found.
>>>>
>>>> Comments are, of course, welcome, ;)
>>> Anders I was hoping you would check if/what lockdep trace
>>>
>>> you get with this patch.
>>>
>>>
>>> Imran, I was hoping you would comment on my change as it
>>>
>>> relates to the kernfs_iattr_rwsem changes.
>>>
>>>
>>> Ian
>>>
>>>> kernfs: fix missing kernfs_iattr_rwsem locking
>>>>
>>>> From: Ian Kent <raven@themaw.net>
>>>>
>>>> When the kernfs_iattr_rwsem was introduced a case was missed.
>>>>
>>>> The update of the kernfs directory node child count was also protected
>>>> by the kernfs_rwsem and needs to be included in the change so that the
>>>> child count (and so the inode n_link attribute) does not change while
>>>> holding the rwsem for read.
>>>>
>> kernfs direcytory node's child count changes in 
>> kernfs_(un)link_sibling and
>> these are getting invoked while adding (kernfs_add_one),
>> removing(__kernfs_remove) or moving (kernfs_rename_ns)a node. Each of 
>> these
>> operations proceed under kernfs_rwsem and I see each invocation of
>> kernfs_link/unlink_sibling during the above mentioned operations is 
>> happening
>> under kernfs_rwsem.
>> So the child count should still be protected by kernfs_rwsem and we 
>> should not
>> need to acquire kernfs_iattr_rwsem in kernfs_link/unlink_sibling.
>
> Yes, that's exactly what I intended (assuming you mean write lock in 
> those cases)
>
> when I did it so now I wonder what I saw that lead to my patch, I'll 
> need to look
>
> again ...

Ahh, I see why I thought this ...

It's the hunk:

@@ -285,10 +285,10 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
         kn = inode->i_private;
         root = kernfs_root(kn);

-       down_read(&root->kernfs_rwsem);
+       down_read(&root->kernfs_iattr_rwsem);
         kernfs_refresh_inode(kn, inode);
         ret = generic_permission(&nop_mnt_idmap, inode, mask);
-       up_read(&root->kernfs_rwsem);
+       up_read(&root->kernfs_iattr_rwsem);

         return ret;
  }

which takes away the kernfs_rwsem and introduces the possibility of

the change. It may be more instructive to add back taking the read

lock of kernfs_rwsem in .permission() than altering the sibling link

and unlink functions, I mean I even caught myself on it.


Ian

>
>
>>
>> Kindly let me know your thoughts. I would still like to see new 
>> lockdep traces
>> with this change.
>
> Indeed, I hope Anders can find time to get the trace.
>
>
> Ian
>
>>
>> Thanks,
>> Imran
>>
>>>> Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
>>>> attributes)
>>>>
>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>> Cc: Anders Roxell <anders.roxell@linaro.org>
>>>> Cc: Imran Khan <imran.f.khan@oracle.com>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Minchan Kim <minchan@kernel.org>
>>>> Cc: Eric Sandeen <sandeen@sandeen.net>
>>>> ---
>>>>    fs/kernfs/dir.c |    4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>>> index 45b6919903e6..6e84bb69602e 100644
>>>> --- a/fs/kernfs/dir.c
>>>> +++ b/fs/kernfs/dir.c
>>>> @@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node
>>>> *kn)
>>>>        rb_insert_color(&kn->rb, &kn->parent->dir.children);
>>>>          /* successfully added, account subdir number */
>>>> + down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>>            kn->parent->dir.subdirs++;
>>>>        kernfs_inc_rev(kn->parent);
>>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>          return 0;
>>>>    }
>>>> @@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct
>>>> kernfs_node *kn)
>>>>        if (RB_EMPTY_NODE(&kn->rb))
>>>>            return false;
>>>>    + down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>        if (kernfs_type(kn) == KERNFS_DIR)
>>>>            kn->parent->dir.subdirs--;
>>>>        kernfs_inc_rev(kn->parent);
>>>> +    up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>>>>          rb_erase(&kn->rb, &kn->parent->dir.children);
>>>>        RB_CLEAR_NODE(&kn->rb);
>>>>
