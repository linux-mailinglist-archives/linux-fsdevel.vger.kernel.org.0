Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBF52304D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiEKKJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiEKKI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 06:08:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDD7A828;
        Wed, 11 May 2022 03:08:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 299615C01BF;
        Wed, 11 May 2022 06:08:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 11 May 2022 06:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1652263735; x=
        1652350135; bh=/JrNB2Fx41iDaNUHQ1Mupt47psUq7cPRK1CxJ1DI5H8=; b=U
        iPyQU1umS2dHaDmIxM9V+ihgsBbZvm5ytXkgUqxRqTufJ147iBMcLm780ZYmdRW+
        ea3/H/NSyIYFUnnqTcg4aREbTo6yDcMWD+9zhpBV0Qgz7/yDTCsOwO7wi8d8UDTU
        PVyc45yYFSEVz0CTKI2dd/JLHqsY8+JoMXTrySFBkDu5sQn2JJDYvbxRyyVEeuZI
        Z/VFGC/zXL3tDV8LO7ngioWrer7y+oXETypQs013Syh9tUFsN8FmZjgEnNIFIFqN
        yCLH49d1e/vjdSM0ERoAqFJx7wLnVPGxGjLK1UszSleLWPhPGQunRffrrsIBPZAA
        PKxS0QuRfzNYxU1ve41DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652263735; x=1652350135; bh=/JrNB2Fx41iDa
        NUHQ1Mupt47psUq7cPRK1CxJ1DI5H8=; b=oroW1ukq0czGLRH4pqXhuDnfREq2t
        L4kkxKkx2YMj8QbPj+rYrTcWm5lL+yulCUZ9b71M9Zd9fVDS04djzHSwXFEeEhJ9
        /pbuoEHsj/7qLAEGBtgNqeORCiWFbzCwJ2K37cC1jdVNvI8nrEq78WRS81+oucMv
        s9OXIweiOk4nDNRvv4rPiJDI+jKMQUfS/gv/1C6kNCTo4wubXmmh8S0smDim2DoU
        5n0kP8SYkZnjxVLaca7GxXrhVXloVUyTMIZqdXeMiMk72SxDsPWjTXsb1t+vnuWb
        XlFj3KongPnx74x7NSplfXVsMxh8/Bl+LDiSQdruPA91ONOmKVXyzSlww==
X-ME-Sender: <xms:Not7YsX8ZK6a3gxP28dxvoZu3a9EgIbpyWur-VLms1Bzqo9q22lDOg>
    <xme:Not7Ygm6qh9KkwFM2YlawRYHc8UZG4gYCHtT12beTzDgtlWSnhDd7hYeJf0YNK3m1
    VxaOdXC5EZpRRiS>
X-ME-Received: <xmr:Not7YgakgSTTHXUbfKR2BU0K8nHSXwHoB5a9t0TOobHcUgHozhbjg9oYyuMfnKN4meQcBOhhTo-Mxj1ZjW8pql88glArjNwxiXvRoE2EHBjRR3oai90L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefgheevteeuveelkedtudekffefvdehueevffej
    iedvjeelhedvtdevudekjeehjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:N4t7YrWm-7LMG0nESAsUEVo6qs-zXigUTN1876dar1oFv_iVRh6eOg>
    <xmx:N4t7YmldDC41dFHMbcZV7aiWh5u8HVoRsAKykBEuYVyEmIRU695ZGg>
    <xmx:N4t7Yge44mJ5zTcm79Vs9QsvC_9HVWVuOmu2nPZ2ah1cTEhu_GARsA>
    <xmx:N4t7YnC0Z1tFku0c-FNXo6Z4mF4JNOpqd6m12QYDnh4_FTAEYzG_qw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 May 2022 06:08:54 -0400 (EDT)
Message-ID: <f512b616-e252-205a-d8e5-4ea7fef53edc@fastmail.fm>
Date:   Wed, 11 May 2022 12:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Content-Language: en-US
To:     =?UTF-8?Q?Jean-Pierre_Andr=c3=a9?= <jean-pierre.andre@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
 <YnPeqPTny1Eeat9r@redhat.com>
 <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
 <YnUsw4O3F4wgtxTr@redhat.com> <78c2beed-b221-71b4-019f-b82522d98f1e@ddn.com>
 <YnVV2Rr4NMyFj5oF@redhat.com> <90fbe06b-4af7-c9ce-4aca-393aed709722@ddn.com>
 <a712f535-7e34-4967-d335-f3680f9c4b6f@wanadoo.fr>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <a712f535-7e34-4967-d335-f3680f9c4b6f@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/7/22 12:42, Jean-Pierre André wrote:
> Bernd Schubert wrote on 5/6/22 8:45 PM:
>>
>>
>> On 5/6/22 19:07, Vivek Goyal wrote:
>>> I looked at fuse_lowlevel API and passthrough_ll.c and there is no
>>> assumption whether FUSE_LOOKUP has already been called by client
>>> before calling FUSE_CREATE. Similarly, I looked at virtiofs code
>>> and I can't see any such assumption there as well.
>>
>> The current linux kernel code does this right now, skipping the lookup 
>> just changes behavior.  Personally I would see it as bug if the 
>> userspace implementation does not handle EEXIST for FUSE_CREATE. 
>> Implementation developer and especially users might see it differently 
>> if a kernel update breaks/changes things out of the sudden. 
>> passthrough_ll.c is not the issue here, it handles it correctly, but 
>> what about the XYZ other file systems out there - do you want to check 
>> them one by one, including closed source ones? And wouldn't even a 
>> single broken application count as regression?
>>
>>>
>>> https://github.com/qemu/qemu/blob/master/tools/virtiofsd/passthrough_ll.c 
>>>
>>>
>>> So I am sort of lost. May be you can help me understsand this.
>>
>> I guess it would be more interesting to look at different file systems 
>> that are not overlay based. Like ntfs-3g - I have not looked at the 
>> code yet, but especially disk based file system didn't have a reason 
>> so far to handle EEXIST. And
> 
> AFAIK ntfs-3g proper does not keep a context across calls and does
> not know what LOOKUP was preparing a CREATE. However this may have
> consequences in the high level of libfuse for managing the file tree.

I don't think high level is effected. I'm really just scared to break

> 
> The kernel apparently issues a LOOKUP to decide whether issuing a
> CREATE (create+open) or an OPEN. If it sent blindly a CREATE,
> ntfs-3g would return EEXIST if the name was already present in
> the directory.

Ok, so ntfs-3g is ok - which leaves N-1 file systems to check...

> 
> For a test, can you suggest a way to force ignore of such lookup
> within libfuse, without applying your kernel patches ? Is there a
> way to detect the purpose of a lookup ? (A possible way is to
> hardcode a directory inode within which the lookups return ENOENT).


What I mean is that we need to check the code or test N file systems - 
if ntfs-3g handles it, N-1 are left...

I we all agree on that there is no issue in skipping the lookup - fine 
with me - it slightly simplifies the patches.


Thanks,
Bernd
