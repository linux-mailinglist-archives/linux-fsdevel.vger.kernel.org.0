Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE77658D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiL2NHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2NHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:07:21 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056411A16;
        Thu, 29 Dec 2022 05:07:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9A6B3320077A;
        Thu, 29 Dec 2022 08:07:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 08:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1672319234; x=
        1672405634; bh=GjS9uAu17vnvhI0aGaceh4NUi+jNxFgOsEd2AjFNTKI=; b=f
        LzfP4MOG5yJOaWGKTMftXO9zhwJ1HDReWUz/RA/SlIaWwppSRqXUplpZxxHvB3be
        eu2WFcEj3ztEp/wt+rP8VnwcmyDNeyVrizONrCN0tEh0pI1lYIW9AJPfhtNNzfOQ
        k51zs/+sCRnB2yQuYy0lhwRGS2JP3SaKcNgflzUnF2XTNdhM0yXdEDCx553bbqpu
        vvk0LLHmfsUDvvOlCLMJTpOkLPk4+np7NdG4PTJa9Med1pYRR7CUXO3SAqxL36pw
        cOiNgGAWVEG2t8oVD3CjnTx+79KcLpE/WbRoCB8kWyBQuR8P55yq/WI3SPHKJm9v
        FL5GyE5yfi3b/0iNIClIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672319234; x=
        1672405634; bh=GjS9uAu17vnvhI0aGaceh4NUi+jNxFgOsEd2AjFNTKI=; b=W
        VDz8fLsKBaeqVgesqeO8BfR3D/YlwMmNr6Bq2MgDnZw11pMf3EsBydJ5HTOq6iHs
        bBYHrZKZTjo3hMGBMrprLC/qtXtVjjPIKMrSoaa449b7sjnQ1YskGQ7rvqAXvlkQ
        aV1lpMTEVu1Lth8DuHTbti9eyI8ViL8VL8VAimYuXs+8cbSxNX2MJQ34NQ/bJr3N
        13zgnWnn0qamWAXrVAbGLFebw0B//tTnnzP+OPcXOZ/kgA21FjQX92VqALqSFiiT
        58HJAQMmzA7dRTpcrBuWqNYFq6eauz64L6d+wy77zilQC6pOvncBLG+QEU0jeFH8
        RQn5g0fDgSZ9mzTqZQW3Q==
X-ME-Sender: <xms:ApGtYztwBYLoA-JyxETvKu3ECXSb99e3mrvyEIahTYEbnJB4PByFFA>
    <xme:ApGtY0fnfyeII2QxMu27jap8WMnHW2vSj23ffW67EFdbHTmj6M1KAnS73xnlrJ0DO
    Wg_Xo3WWG0P>
X-ME-Received: <xmr:ApGtY2ybE3rdJQL38BqfUxZ25i3EcSLJyK39iSUnSRYy3fyl5qwgWncWUyEwG9yqdN0cbdbx5h6DgiL3qIxd8wuB6h2an9u7blP8fhRuBIDZPzHuMlbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:ApGtYyOhb8zAvlR8_uoqXhi1SnPLB9B_b8o_FnKcXErOn_LEC78UfQ>
    <xmx:ApGtYz_S1HhKpZevHHcUcPFpoN-v-5CvIvRVUlst2FOGmorLiQ96yg>
    <xmx:ApGtYyW7fJwrIn82s2aJXqttoxdVTfZTQWsLO9fdKx6hTfgFwLY04w>
    <xmx:ApGtYyXhe6D9OsNEa_5zP2p80tUAi-IkGNJfz9fDQx4NhG4k6WUhEw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 08:07:09 -0500 (EST)
Message-ID: <9e35cf66-79ef-1f13-dc6b-b013c73a9fc6@themaw.net>
Date:   Thu, 29 Dec 2022 21:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
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
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/12/22 17:20, Arnd Bergmann wrote:
> On Fri, Dec 23, 2022, at 00:11, Ian Kent wrote:
>> On 21/12/22 21:34, Anders Roxell wrote:
>>> On 2022-10-31 12:30, Tejun Heo wrote:
>>>> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
>>>>> The kernfs write lock is held when the kernfs node inode attributes
>>>>> are updated. Therefore, when either kernfs_iop_getattr() or
>>>>> kernfs_iop_permission() are called the kernfs node inode attributes
>>>>> won't change.
>>>>>
>>>>> Consequently concurrent kernfs_refresh_inode() calls always copy the
>>>>> same values from the kernfs node.
>>>>>
>>>>> So there's no need to take the inode i_lock to get consistent values
>>>>> for generic_fillattr() and generic_permission(), the kernfs read lock
>>>>> is sufficient.
>>>>>
>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>> Hi,
>>>
>>> Building an allmodconfig arm64 kernel on yesterdays next-20221220 and
>>> booting that in qemu I see the following "BUG: KCSAN: data-race in
>>> set_nlink / set_nlink".
>>
>> I'll check if I missed any places where set_link() could be
>> called where the link count could be different.
>>
>>
>> If there aren't any the question will then be can writing the
>> same value to this location in multiple concurrent threads
>> corrupt it?
> I think the race that is getting reported for set_nlink()
> is about this bit getting called simulatenously on multiple
> CPUs with only the read lock held for the inode:
>
>       /* Yes, some filesystems do change nlink from zero to one */
>       if (inode->i_nlink == 0)
>                 atomic_long_dec(&inode->i_sb->s_remove_count);
>       inode->__i_nlink = nlink;
>
> Since i_nlink and __i_nlink refer to the same memory location,
> the 'inode->i_nlink == 0' check can be true for all of them
> before the nonzero nlink value gets set, and this results in
> s_remove_count being decremented more than once.


Thanks for the comment Arnd.


I'll certainly have a close look at that.

It will be a little while though, given the season, ;).


Ian

