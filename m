Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE36D564B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 03:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjDDBwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 21:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDDBwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:52:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A8B4
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 18:52:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D91433200912;
        Mon,  3 Apr 2023 21:52:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Apr 2023 21:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680573160; x=1680659560; bh=6QBSqk0m7gPVqBLQ1BupZhOV6Ead0SRn9TL
        hYFE1bXw=; b=a939VzUPSkxVAFoTIPysWRWfDvAPZFrx5IT2Mhqj9MuHQ7y8/9i
        D/c9e0uUDgONVXeVYKnckcGW+ZcluryA0eDhxplf/Ldoko28gY4rMWFlgHLYHNJp
        YtI7AZk63vSPyUvvEOdllDn7eDj25/i6yeCuMKw3RN8W6YFjb8ITh8KSfJ9kHidl
        k1srtUA7tyVgRd1IK0AA40psWYYNRCD4+Nc13dIihLIKRxqfD378+K5Eqlbu6p5t
        cD5+1uskJLFvUsz6ljwp3MJGAxhvoY4zuZaT86aMmIfAjexu8A4TJxSffCSB8S+P
        jLIV3sCoI7KZj4Ixc6dRc6ld9zq6Ssp3ztg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680573160; x=1680659560; bh=6QBSqk0m7gPVqBLQ1BupZhOV6Ead0SRn9TL
        hYFE1bXw=; b=ZhxIdKMhmk5CSk5flpUm0M/U6NMM0LmihcJEIHqAxWeOJ1GlCAC
        VjboR79z/GpGh7NfTSM0ySTfV1SeMMShafVZmEltw7rm52qek/Y98J/+1XnLXy3G
        ax1xqVfseJmomFHg0zjlaFjd5Tdo7SvhYbWg97OGeMnDpuDBJoDy1kzF61NuXeJq
        xtkqtkDbDvuDwAhL9RQOM15NhIS+yR1cKDoHeaVwU0+yaFrgnOvvvxGu+qLWsG69
        Q1AjbpmfJpI/JnoFcW/yAbRTQp+sKTwRd4KCMkx6G2wZuyu7gkW+ULVanF3NwLJJ
        er6zJ5F0BYw4gPWcdDuoY0iv0i+jyht3YLA==
X-ME-Sender: <xms:54IrZNllAMDAMoFNhFOfcEV59fahsuZ64C-jT05IEmt_Ai8xKogL0A>
    <xme:54IrZI1vrnWZRAHPM3APE-cOyF0lzzfWwMESLsaBbP-NZHfEqx-4E2OIe6AEedSEv
    BOo4AjenauK>
X-ME-Received: <xmr:54IrZDqF2uak-hfNy8J3n5QtFlKcaPLYmG2rbZ6zaMSEg1cNXoDDDhyXZkWbD5R1SN-CcCuBFQl34JWp571oPkJrcLDG7yvkYgPUCufHW3RfRBSy9L6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeikedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:54IrZNlBGAFBbBFKSY42evyh7mboR5SriPBNufJe6_5wKBfBVLFhyg>
    <xmx:54IrZL3DzGAN66EtL_xd4sGhg4DG6aLZT5_we2dyuHnprKYtf5nHhw>
    <xmx:54IrZMvBLQgWsZwYXPmQzT3O3jAP1PyhIjUqnrUJAXgGNpVmI7UFAg>
    <xmx:6IIrZJMeVbITTATcMesehFuvSG-zgz0JUPeo9NObExq5SWL-4svq9g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 21:52:33 -0400 (EDT)
Message-ID: <a5581bc7-c522-33a1-4e11-31b71bafd8cc@themaw.net>
Date:   Tue, 4 Apr 2023 09:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] Legacy mount option "sloppy" support
To:     Christian Brauner <brauner@kernel.org>
Cc:     Karel Zak <kzak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>, Steve Dickson <steved@redhat.com>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
 <20230328184815.ycgxqen7difgnjt3@ws.net.home>
 <27b8d5a5-9ab9-c418-ce9c-0faf90677bde@themaw.net>
 <20230403-disarm-awhile-621819599ecb@brauner>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230403-disarm-awhile-621819599ecb@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/23 21:08, Christian Brauner wrote:
> On Wed, Mar 29, 2023 at 09:03:51AM +0800, Ian Kent wrote:
>> On 29/3/23 02:48, Karel Zak wrote:
>>> On Fri, Mar 24, 2023 at 01:39:09PM +0800, Ian Kent wrote:
>>>> Karel do you find what I'm saying is accurate?
>>>> Do you think we will be able to get rid of the sloppy option over
>>>> time with the move to use the mount API?
>>> The question is what we're talking about :-)
>>>
>>> For mount(8) and libmount, there is nothing like the "sloppy" mount option.
>>>
>>> If you use it in your fstab or as "mount -o sloppy" on the command line,
>>> then it's used as any other fs-specific mount option; the library copies
>>> the string to mount(2) or fsconfig(2) syscall. The library has no clue
>>> what the string means (it's the same as "mount -o foobar").
>> Which is what the problem really is.
>>
>>
>> If anyone uses this option with a file system that has previously
>>
>> allowed it then mounts fail if it isn't handled properly. Then the
>>
>> intended purpose of it is irrelevant because it causes a fail.
>>
>>
>> I guess the notion of ignoring it for fsconfig(), assuming it isn't
>>
>> actually needed for the option handling, might not be a viable idea
>>
>> ... although I haven't actually added that to fsconfig(), I probably
>>
>> should add that to this series.
>>
>>
>> But first the question of whether the option is actually needed anymore
>>
>> by those that allow it needs to be answered.
>>
>>
>> In case anyone has forgotten it was introduced because, at one time
>>
>> different OSes supported slightly different options for for the same
>>
>> thing and one could not include multiple options for the same thing
>>
>> in automount map entries without causing the mount to fail.
>>
>>
>> So we also need to answer, is this option conflict still present for
>>
>> any of the file systems that allow it, currently nfs, cifs and ntfs
>>
>> (I'll need to look up the ntfs maintainer but lets answer this for
>>
>> nfs and cifs first).
>>
>>
>> If it isn't actually needed ignoring it in fsconfig() (a deprecation
>>
>> warning would be in order) and eventually getting rid of it would be
>>
>> a good idea, yes?
> Yes, I think this is a good idea.
> The whole reason for this mount option seems a bit hacky tbh so getting
> rid of it would be great.

Thanks for thinking about this Christian.

It is something that has concerned me for a long time now.


I know the impression that people get is that it's hacky and it's

accurate to an extent but there was real need and value for it at

one point (although it was around before my time).


But now we get tripped up because trying to get rid of it causes

the problem of the option itself not working which tends to obscure

the actual use case of users.


I think the change to use the mount API is the best opportunity we've

had to clean this up in forever, particularly since the mount API

makes it particularly hard to continue to use it.


I'm still thinking about it and I'll post an updated patch and

accompanying discussion at some point. At the very least we need a

clear upstream position on it to allow those of us with customers

that think they need it to pass on the deprecation notice and reasoning.


It might end up we have to revisit it but at least if that's the case

we should have more detailed use cases that are current.


Ian

