Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F65B4F9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIKPQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIKPQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:16:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C94303C0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 08:16:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2E9293200344;
        Sun, 11 Sep 2022 11:16:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 11 Sep 2022 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662909367; x=
        1662995767; bh=Gy/TUo+ZwWNey5UIGp+rXgLX63+CESPhlc5tylJxFr0=; b=B
        1EiuJVH8jccbH6TXD7TsYcVplrMttBuTYCzzeomJcOmLgYM+M4zV4NAyPJ6eAtuB
        96v5/vwuM2Axy8l2yHEd27tcpw3CjpcGLnn5+cJB9uHNY9gZlhIcZWqAaLva6Bqm
        z35qDVH0pRE5BUICWukuPYGVZ1cxJonX2RSyragfzveWLsRzlHQ2wMVev/pL6fbh
        ST+83QO6vsiYpzhEbihZDUIUijSixc1/MY56M1W+0wgmrc6L4me7UKI6KW9CNCGJ
        hMtvVOh9byytOJPXuicLdD2LvnmTQhieoJqtHuTLZua8fLn9YIWL6nW2DQQW4beG
        OQCzidxMhXv7Qm4rlbuZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662909367; x=
        1662995767; bh=Gy/TUo+ZwWNey5UIGp+rXgLX63+CESPhlc5tylJxFr0=; b=R
        TzSpcTVhH2w60LrL2EfHKKP7CWRvHzSXVBJHhomP9lueWfEkGyK47TugCkOfslUT
        aJ6GqtXMikZ+wWDVn24v9WRA+2amIQGH24rrxf7J7dTcDnfZYjJ4MtqiWmURvURN
        I+9/XxZGX1Mroc/0Ow1qqKEtt6bulZ43KIyiOE/4UeG4bb+OPw78642G4XOiNt/3
        J0ThppC2eGsAVunpYB5le93rLg4cSfMTHj8OjZxjTTqiF8vs0061mzOaShUJDfye
        7ODzaIN8zNGCYxGRKUUyQG7ItMf3Di4QiDySmhOXg3EToLeodY/V4NqFlM4dNRj3
        jjpLowVRIbtqH8/P7X6kQ==
X-ME-Sender: <xms:t_sdY6pR0CVZfW7yFdBRu_DyjHGXMtNFOnRpI9BMSNt1cgFHRU_XCw>
    <xme:t_sdY4qdvz99Ui2dyHXIn2xDcusTmk2hXomGR69bD-8XtQ7DbT4Gn4YWXtBTOcyAB
    cXGtP6f-oardDiS>
X-ME-Received: <xmr:t_sdY_NnuCrb15uGBB1CCQ2Urci6Y4Z6qqqkFtBiFdEa9HJwC26Hqg3BNoPWE2c6Gqw6gg3xxSrqpiMWW37z_oR-Ua4oryMGj1zvLwAdvhK_8NBl-nDV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedutddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedukeehleekjeehvddvieeftdeuleeiiedu
    tdelhfevueeludfgleejveeitdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:t_sdY54A0LCjABGsHC2hXzIA4kjhy8Qz5TfXGd-OmdhsstKyZeBfUQ>
    <xmx:t_sdY577CftJGYRvmW1BtwvledXNIhqsuNxE2JNrx-TlWwgD9p9KZA>
    <xmx:t_sdY5iy3lW7okgqgiTOj9bXHG8cG8OVfFvnBUocl-p_V8BzhH3DNQ>
    <xmx:t_sdYznTQYBncBxvywEnxUAq_KiPmdJQho2a2XyMC2CvoIKc4KVHfg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Sep 2022 11:16:06 -0400 (EDT)
Message-ID: <52a25e2e-8756-b9a9-db7e-61807933a395@fastmail.fm>
Date:   Sun, 11 Sep 2022 17:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file
 handles)
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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
Content-Language: de-CH
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
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



On 9/11/22 12:14, Amir Goldstein wrote:
> On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> One proposal was to add  LOOKUP_HANDLE operation that is similar to
>> LOOKUP except it takes a {variable length handle, name} as input and
>> returns a variable length handle *and* a u64 node_id that can be used
>> normally for all other operations.
>>
>> The advantage of such a scheme for virtio-fs (and possibly other fuse
>> based fs) would be that userspace need not keep a refcounted object
>> around until the kernel sends a FORGET, but can prune its node ID
>> based cache at any time.   If that happens and a request from the
>> client (kernel) comes in with a stale node ID, the server will return
>> -ESTALE and the client can ask for a new node ID with a special
>> lookup_handle(fh, NULL).
>>
>> Disadvantages being:
>>
>>   - cost of generating a file handle on all lookups
>>   - cost of storing file handle in kernel icache
>>
>> I don't think either of those are problematic in the virtiofs case.
>> The cost of having to keep fds open while the client has them in its
>> cache is much higher.
>>
> 
> I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> implementation of persistent file handles for FUSE.
> 
> The purpose is "proper" NFS export support for FUSE.
> "proper" being survives server restart.

Wouldn't fuse just need to get struct export_operations additions to 
encode and decode handles?

> 
> I realize there is an ongoing effort to use file handles in the virtiofsd
> instead of open fds and that LOOKUP_HANDLE could assist in that
> effort, but that is an added benefit.
> 
> I have a C++ implementation [1] which sort of supports persistent
> file handles, but not in a generic manner.

How does this interact with exportfs?

> 
> If anyone knows of any WIP on LOOKUP_HANDLE please let me know.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/libfuse/commits/fuse_passthrough


Thanks,
Bernd
