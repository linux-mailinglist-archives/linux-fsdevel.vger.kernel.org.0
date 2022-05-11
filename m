Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9E5231EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiEKLiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiEKLit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 07:38:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6767D04;
        Wed, 11 May 2022 04:38:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D7C635C014F;
        Wed, 11 May 2022 07:38:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 11 May 2022 07:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1652269124; x=
        1652355524; bh=naHO6ZQmGjggpueMIWFDjJ4Dzl3sF5KaKGDmAIp+dNs=; b=u
        SIOuZ56mhsXd7xEOXv5K7zjz6AJVSdWQUd+AIgDodOThG7/wa5R5pBFJXUOY9V+7
        7Tl2OVkBZzwwTLzQLufi5eYLUwzL58+DyEqHDH+C7UKTNLBhBZHSl8k3xpfNfpn1
        hmhnVUJHfbdSiBiIjUN3hrb4d0YyGRDcZsE6I9pOe2GTILIONhomeynQ1XGbabcO
        yCMdKNiDBrqjcZ+y7/9o7VxBZqX0GjCvO4n0FEohJemigTu/6rMBXDBsZw9E8MUL
        ZY+L8VXeauZWrQXRWPXYbYf6SDn3ntgpy9M82BQNogbnZMaL12wHdx3514gLTZtq
        3tDOnbCCVZ9lZMOR5lbGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652269124; x=1652355524; bh=naHO6ZQmGjggp
        ueMIWFDjJ4Dzl3sF5KaKGDmAIp+dNs=; b=cGWEsBRq7x06IGCwJd1/TslEeZIRY
        24+U3Pwrbob1R/phWjPauZT2RgVeypZi3/7wnS6TqGkRBy0ziE0nASgFJk8jjmOf
        7c23wTGG0e0Vv9NSbJnKKpfINhizi2vWBZAftZH265jdXVECd1VIL9Hhi1fPCono
        cThKeFA+0a2ZKVn7yWZm9BzMQxpAXraltkKDBtBgXGb73wwdMsC8LWBRtlQaRX4e
        VciEQ/Hj7lvRsbyMQo8JFyw/k1K/hFN+Jbpo/GIzkOsj3/Viz0F0Od2QeJsb0W9M
        OrUF/ckEk7ra6cmKK5yJ0RR6bO+bNidPo+lkzp4Rq6mXyQmU4cMyXfYRQ==
X-ME-Sender: <xms:RKB7YstHkghPzKzAYeWNtfnL_JvLhDQGxDMNH-WYY74LEaNv3ADnaA>
    <xme:RKB7YpcP45NkEF7spc6w0DiMMU08lmf5LtkLIPPLuea6dsZORWKO1vfJeVwe8vaw8
    uMOwAs3EavAA7D2>
X-ME-Received: <xmr:RKB7YnylQ0DxUMHzy8FYaA8UbuiFfKSDlGhHsGIwPavz_zCImRcrhPW7RBw-_QvpeMMt1BLjywWJhXf5gv9i0c23Og8FqeEh4WSkxNZgoD6v_4nR6Sr2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeeileeigfeuudegueevtefghfffvdfhtdetvdfh
    ueefueeugfdujeehteeuffdtudenucffohhmrghinhepnhgrrhhkihhvvgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:RKB7YvNJrn7BrSsF5qabElg_lCl6eBQ62Wx8xJADNcSWzzputNyK8Q>
    <xmx:RKB7Ys-S7agNS46jsVhumYKvAf_oHhy_e7ts2XAjg5CMNisb9f3Sqw>
    <xmx:RKB7YnUYyLhwx2BylO4aAvUJ26xUp9sPP5B9lPYgbjk9Fx6JezXbYA>
    <xmx:RKB7YgbciW6J1PeafdIXOdUgtI2vtYJNwI6-EdsnlNrMTRuxFW-ocw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 May 2022 07:38:43 -0400 (EDT)
Message-ID: <692c1682-ce10-7136-675b-2975f6a1aa01@fastmail.fm>
Date:   Wed, 11 May 2022 13:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220511013057.245827-1-dlunev@chromium.org>
 <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
 <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
 <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/11/22 13:19, Daniil Lunev wrote:
>> At a glance it's a gross hack.   I can think of more than one way in
>> which this could be achieved without adding a new field to struct
>> super_block.
> Can you advise what would be a better way to achieve that?
> 
>> But...  what I'd really prefer is if the underlying issue of fuse vs.
>> suspend was properly addressed instead of adding band-aids.  And that
>> takes lots more resources, for sure, and the result is not guaranteed.
>> But you could at least give it a try.
> We do have a limited success with userspace level sequencing of processes,
> but on the kernel level - it is all quite untrivial, as you mentioned.
> I did some
> research, and what I found pretty much a 9 years old thread which went
> nowhere at the end [1]. We would also prefer if suspend just worked (and
> we have a person looking into what is actually breaking with suspend), but
> there is an unbounded amount of time for how long the investigation and
> search for a solution may be ongoing given the complexity of the problem,
> and in the meantime there is no way to work around the problem.
> 
> Thanks,
> Daniil
> 
> [1] https://linux-kernel.vger.kernel.narkive.com/UeBWfN1V/patch-fuse-make-fuse-daemon-frozen-along-with-kernel-threads

So that sounds like anything that is waiting for a response cannot be 
frozen? Assuming there is an outstanding NFS request and the NFS server 
is down, suspend would not work until the NFS server comes back?

Thanks,
Bernd
