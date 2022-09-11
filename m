Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C35B4FCE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIKPzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKPzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:55:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08027FF8
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 08:55:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 45A0532004CE;
        Sun, 11 Sep 2022 11:55:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 11 Sep 2022 11:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662911727; x=
        1662998127; bh=HVXy4nT+PPtgWi0AexaD2SJVUfcmZLMGRn3Mvo7Ir9o=; b=a
        l8zmTRaBiLHaw5kywywHyinKfEX0JFiYXoTIwlNOgYd5kvAAm0h2ErmUgwbJ3aJm
        bniI14emy62lRiM9yGES/mcXAHVBL0Zs21dZfHYwT3Pbjp2gRBhxVJGB8+lCar53
        O7qXsxfIDrbfcv9D6ctloBs/Y8N78ciJdm1rWcPwKRQ5SbIBUkQ17zcJmLb7+L3T
        QF0HbeGSK8eNcKtH4uEIWZ2ktWV15qQKx+wB+ax626eNZ2/tjGkuZPGIpbGB4Zq+
        Fg0mrJpChe0VA+1W8qA0NA0tCfhL1F9TwHh/+zBO8FYHbmm8wFIYhOXxkxpXAMBS
        /VF1xyo6Pla58NFH8EhXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662911727; x=
        1662998127; bh=HVXy4nT+PPtgWi0AexaD2SJVUfcmZLMGRn3Mvo7Ir9o=; b=P
        NhlLmySZzKsfryA11f5oHDsMwwcn98u2VZ3i7G7BZBY+HNfDEzwHa5qCqJOoXkvr
        0MByUk7Qjoi2QrYPi/GXbkX/Yqc8uIqkNy0KByvayXn7o15hqDn2HG1pxdIz5APY
        ZztME3A81zCkQ+STbDcGCiNpmFc85M1iOrAXPlWkbvl6xrofIP8juPltQ3st76D1
        YNhHSV3AlFmxc1zWnh7lgcNJdW148Bc0/HonOCx6BfEhcpWQY5c2v95rD0+qYIpc
        HFAvz6Q9rI7sHWJUKhHFlpjmZrmtVzcnBAk1/vUkwyn+PR72t1VT/84A6gvQXm9e
        vU2bxhv0dbMKR0rgjZfRw==
X-ME-Sender: <xms:7wQeY2KUOMf2hTNgIt_tytxgWFHQKyN_OqoY6IUSSz6N4DNZjt_H9A>
    <xme:7wQeY-JVtbYiHP7Ty7BUFU3LqDg_odwDB2GxD_ySjRIsthW-pVwanpX4xmkTAgrDC
    IfXj7BQlpAMigQx>
X-ME-Received: <xmr:7wQeY2v1FtZop2zCbCe8Yz-I0ax68xeyEgfeAKLck9NYOVBlZcBQJzUE32oTNBJApGgnEeyMEKV6wwr_87AiS_ZdmrY8YIgU328WRLhnAKo66DED97qq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedutddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:7wQeY7YMzBUCbu0766nwZ_3STJZIxQfUyKWz5inMoqJpcd49ubySAw>
    <xmx:7wQeY9axWGPaOfeS8tqmYqnNw6bMYlk8j2ZxrwXVeIOdo--KqchtSA>
    <xmx:7wQeY3CYuAKD2Fkd05t5OutHr40KuTyJaS_pD_dPjgf3wh-lWF5lOg>
    <xmx:7wQeYxGcUX4PU_yphfHzR0vFmqqCdVWlRO3rdtIDhJy_rtUvfuPkEQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Sep 2022 11:55:26 -0400 (EDT)
Message-ID: <fe32b1c3-08f3-8911-dead-d0f51dd0d015@fastmail.fm>
Date:   Sun, 11 Sep 2022 17:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file
 handles)
Content-Language: de-CH
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com>
 <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
 <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <52a25e2e-8756-b9a9-db7e-61807933a395@fastmail.fm>
 <CAOQ4uxiffF6FKs_My0qxgCnPeeXKSpvzp0-iyjxno=H=Hrn-3g@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxiffF6FKs_My0qxgCnPeeXKSpvzp0-iyjxno=H=Hrn-3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/11/22 17:29, Amir Goldstein wrote:
> On Sun, Sep 11, 2022 at 6:16 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 9/11/22 12:14, Amir Goldstein wrote:
>>> On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>
>>>> One proposal was to add  LOOKUP_HANDLE operation that is similar to
>>>> LOOKUP except it takes a {variable length handle, name} as input and
>>>> returns a variable length handle *and* a u64 node_id that can be used
>>>> normally for all other operations.
>>>>
>>>> The advantage of such a scheme for virtio-fs (and possibly other fuse
>>>> based fs) would be that userspace need not keep a refcounted object
>>>> around until the kernel sends a FORGET, but can prune its node ID
>>>> based cache at any time.   If that happens and a request from the
>>>> client (kernel) comes in with a stale node ID, the server will return
>>>> -ESTALE and the client can ask for a new node ID with a special
>>>> lookup_handle(fh, NULL).
>>>>
>>>> Disadvantages being:
>>>>
>>>>    - cost of generating a file handle on all lookups
>>>>    - cost of storing file handle in kernel icache
>>>>
>>>> I don't think either of those are problematic in the virtiofs case.
>>>> The cost of having to keep fds open while the client has them in its
>>>> cache is much higher.
>>>>
>>>
>>> I was thinking of taking a stab at LOOKUP_HANDLE for a generic
>>> implementation of persistent file handles for FUSE.
>>>
>>> The purpose is "proper" NFS export support for FUSE.
>>> "proper" being survives server restart.
>>
>> Wouldn't fuse just need to get struct export_operations additions to
>> encode and decode handles?
>>
> 
> FUSE already implements those, but not in a "proper" way, because
> there is nothing guaranteeing the persistence of the FUSE file handles.
> 
> As a result, when exporting some FUSE fs to NFS and the server is
> restarted, NFS client may read a file A and get the content of file B,
> because after server restart, FUSE file B got the node id that file A
> had before restart.

Sorry, right, it is just not passed through to user space. For the file 
systems I'm working on that doesn't work at all.

> 
> This is not a hypothetical use case, I have seen this happen.
> 
>>>
>>> I realize there is an ongoing effort to use file handles in the virtiofsd
>>> instead of open fds and that LOOKUP_HANDLE could assist in that
>>> effort, but that is an added benefit.
>>>
>>> I have a C++ implementation [1] which sort of supports persistent
>>> file handles, but not in a generic manner.
>>
>> How does this interact with exportfs?
>>
> 
> It makes use of internal fs knowledge to encode/decode ext4/xfs
> file handles into the 64bit FUSE node id.
> 
> This sort of works, but it is not generic.

Hmm, I guess I need to look at it.


Thanks,
Bernd
