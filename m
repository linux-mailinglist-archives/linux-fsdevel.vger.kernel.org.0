Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9B677447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAWDLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 22:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWDLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:11:54 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA41042C;
        Sun, 22 Jan 2023 19:11:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 67C755C009E;
        Sun, 22 Jan 2023 22:11:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 22 Jan 2023 22:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674443507; x=
        1674529907; bh=QScSxmRcZr3Sphkxe/Gr2K9Ozgkh2rX21xaMYFUcXeA=; b=X
        Rz0FTrWqQ+EJ7yUY/O8AQsIdrId9wmVuXjNukkjOoso9OZRjLMMnCchrb2u/HhQO
        rMTlmsnwdKLiDSmb3+vCXsxNvPzRAXcLsGQx8sjlzYZx08a1gP+9r5SvbfkoWqi/
        KvRkklMQ2JvvzGrOkvfu0V3B50ysor7yALbKvsmXPejDi2DVeZk5b9YkARltmlZk
        9R1HvZfc4I6azXVqIDuRhqIxxDxtw+k6qY98YKX1FqUdRCxsMA+hYfRY2bFsM+bZ
        pKCfywJMP6xsuN4rvRcp+qVnDf2lvgXgPRPFTSA3xoM/lg6wLeLmbUJM3uIPVT5a
        tqMX5H37k8okAos+3MYLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674443507; x=
        1674529907; bh=QScSxmRcZr3Sphkxe/Gr2K9Ozgkh2rX21xaMYFUcXeA=; b=L
        J1aYcd0veWpTyt9ZaDOmd+ayRpsALvuz0UKGJT7VZGMiuyRYPbp+cBHAk4BZBiIJ
        icG5IgT3/Jj0a6LAuHt6gHwOA7NO1giD4tHP/kc63UpA1BdgQAGcXZa6hW/armNP
        7ll42iDkw7SD1j1WoKioBbLJ2ey8yltUts8SGptgBihLY3wNWwIU9kx5spdDLkhv
        fn9sxp9Y2aRfM3jDEd7b988uXAM3rS01nmvZlv+axocWujSE++CzR8uodUTkVDHs
        /j1B0IODckPnHTF2q1f6jfRYX2xA1/yTNybzIdd8VO/eDLeEieT1K0SMBb2jh5KK
        w5xw8TLk7/0xyX+KQ2fyw==
X-ME-Sender: <xms:8vrNY2VbbKHZ7pMNTIFRG8ko7aXjygSWEcp_0Fr_yQtyD4aksUaTGg>
    <xme:8vrNYynEUTSuVqae64K8_WYEdtUDiS3tmKWlOj4aMs9ZItyQn5wTnphOlZ8_biqxe
    bUmzzs14LsB>
X-ME-Received: <xmr:8vrNY6azORiJtQnNEvxWnEl8PaosotNnL1fCZTslvkEms4HP41M5_ckiaVqEDbmtNa31F0uGgMJbNyKKwqWEMZTTo_IERs9qlPCevZAQrqT-Cwmptssd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddujedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epieevleekgfdtgedufedufedtleetjeetvdehueelvedvleeuhfdutdeigeevleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:8vrNY9UN5P3Q7A2aK-L6eBQCGxr1tzA9_5Xy4TzANpFbsfx7xXpdVA>
    <xmx:8vrNYwkGJ7FpgrUCwr7nyiD0Vpmicdo_gL74ZZZJcRvRpM_xelyM9Q>
    <xmx:8vrNYydEPFxLp-wFgtBjisQ6fMuofyjWI1Yd-UAefia7Vo2bwEBfjw>
    <xmx:8_rNY6euF6RA2GxyQDcMWq2mZTslBnpYVyxsgn1Es78Ign8_VMoWGw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jan 2023 22:11:41 -0500 (EST)
Message-ID: <db933d76-1432-f671-8712-d94de35277d8@themaw.net>
Date:   Mon, 23 Jan 2023 11:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
From:   Ian Kent <raven@themaw.net>
To:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
In-Reply-To: <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/12/22 21:07, Ian Kent wrote:
>
> On 29/12/22 17:20, Arnd Bergmann wrote:
>> On Fri, Dec 23, 2022, at 00:11, Ian Kent wrote:
>>> On 21/12/22 21:34, Anders Roxell wrote:
>>>> On 2022-10-31 12:30, Tejun Heo wrote:
>>>>> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
>>>>>> The kernfs write lock is held when the kernfs node inode attributes
>>>>>> are updated. Therefore, when either kernfs_iop_getattr() or
>>>>>> kernfs_iop_permission() are called the kernfs node inode attributes
>>>>>> won't change.
>>>>>>
>>>>>> Consequently concurrent kernfs_refresh_inode() calls always copy the
>>>>>> same values from the kernfs node.
>>>>>>
>>>>>> So there's no need to take the inode i_lock to get consistent values
>>>>>> for generic_fillattr() and generic_permission(), the kernfs read 
>>>>>> lock
>>>>>> is sufficient.
>>>>>>
>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>> Hi,
>>>>
>>>> Building an allmodconfig arm64 kernel on yesterdays next-20221220 and
>>>> booting that in qemu I see the following "BUG: KCSAN: data-race in
>>>> set_nlink / set_nlink".
>>>
>>> I'll check if I missed any places where set_link() could be
>>> called where the link count could be different.
>>>
>>>
>>> If there aren't any the question will then be can writing the
>>> same value to this location in multiple concurrent threads
>>> corrupt it?
>> I think the race that is getting reported for set_nlink()
>> is about this bit getting called simulatenously on multiple
>> CPUs with only the read lock held for the inode:
>>
>>       /* Yes, some filesystems do change nlink from zero to one */
>>       if (inode->i_nlink == 0)
>> atomic_long_dec(&inode->i_sb->s_remove_count);
>>       inode->__i_nlink = nlink;
>>
>> Since i_nlink and __i_nlink refer to the same memory location,
>> the 'inode->i_nlink == 0' check can be true for all of them
>> before the nonzero nlink value gets set, and this results in
>> s_remove_count being decremented more than once.
>
>
> Thanks for the comment Arnd.


Hello all,


I've been looking at this and after consulting Miklos and his pointing

out that it looks like a false positive the urgency dropped off a bit. So

apologies for taking so long to report back.


Anyway it needs some description of conclusions reached so far.


I'm still looking around but in short, kernfs will set directories to <# of

directory entries> + 2 unconditionally for directories. I can't yet find

any other places where i_nlink is set or changed and if there are none

then i_nlink will never be set to zero so the race should not occur.


Consequently my claim is this is a real false positive.


There are the file system operations that may be passed at mount time

but given the way kernfs sets i_nlink it pretty much dictates those 
operations

(if there were any that modify it and there don't appear to be any) leave it

alone.


So it just doesn't make sense for users of kernfs to fiddle with i_nlink ...


Ian





