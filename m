Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1E58ECA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiHJNCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHJNBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:01:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AF761B0F;
        Wed, 10 Aug 2022 06:01:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E50E5C0358;
        Wed, 10 Aug 2022 09:01:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Aug 2022 09:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1660136492; x=
        1660222892; bh=D2dDj1/YvO3PoXFbhxtyDvrJjuK0U5n+THc//8l/nSg=; b=0
        uEws4l4g6w2vrXp4GfCdWCnTh+CSrYDl4BIH9cfZm8TNqDt0C1F4/kQu0PjMlz/7
        IPok/mc8SanD4aZtIwfFt3wz2LHUZHri/bel2AmR1Prp9nlTkTF6qmPVN0tIj/SG
        AfDJZIQi/OtqscaGUmTWTXaL5dG5bm8QhmTP5cvPLeVGBHXnrd6OuRALPdmLZh0P
        391bvUHNo4eiljos5XQkZkKDPqPNvYRQ7wUkPdLCjbDv2+IbqC85GVUeNyErpJJl
        Xi5ccgqV8fBFhUdrjhrfRsKvfLDnbr+zSzq/FQyQOZoqf7NVUUjgMvKqO13XQ9Lt
        V53LdIwYZE1PGG+9FgXmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660136492; x=
        1660222892; bh=D2dDj1/YvO3PoXFbhxtyDvrJjuK0U5n+THc//8l/nSg=; b=g
        4PUnbuBsbuWyDlmRz2cl0jHM/Wz9W+AAacy4xwFeYEc7jLDtN4vqJfBrNQvPBg+U
        sY+nbk3DIt8+312Frgxpo5/eh0pZPP0UD4YIRuWX+vyTew6o8ohjY3wbA8F7WD/4
        zVNvmYG1ldBGhPRo+DJx/GazOdXyvRtuvR9PUM86q4SoybRXO3yu2xuT86kgeiOZ
        +nLUeLICLrWZ/MA7NQLAdZ8LqfDRUKkal0QJhULVY3dYUG/Vl6WeDoqfDVDanteq
        o93PFZ8iw+tAFheEtKPh+kjKUtwONChc1p5w/P8cdILsF5vFYUAcltY0hTM2gHKL
        PcviV0zo6aBwQ7dSp/n7w==
X-ME-Sender: <xms:K6zzYgaufmFQYN3G-XE3GD_vN0bwiRO7qVkN-7J17C4m-ECwAF-3mA>
    <xme:K6zzYraYxzysb-4EsfTXXjMDMY0mKilEmSyoJfChHtgKlkxJitcAAAyZvnFn1wjKy
    V_hf6iZuIsn>
X-ME-Received: <xmr:K6zzYq_hV8cfHgpYJ6ceTOAWwdug0m5PGJ7AYoOtsfGjkd4S1UUHhQcSgtIkrFVyScAdWozwAS1-XhSHVQ0PJvovtPIO8-mAKQhyK7RMb71iJgYeYlm2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgeevhedvleejleevkeduvdfgtefgtdfgffevtdetudekteekheeluddthfdtleehnecu
    ffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:K6zzYqq9Zeku69vjGyL7qCQ8y-siPza__UiByZwdf1sH727kGsR_sA>
    <xmx:K6zzYrpBtEloIhq5qRx6uVC9MvBI9Bs9Pdmml3lfQfUOmueKype-Fw>
    <xmx:K6zzYoS0K7lSIZ-quO3NK8tJ9UPkIejLJ1CbewJieP-GkVbetvyABg>
    <xmx:LKzzYsnReg1zR2o7eA9WFra5rnD8htQ9ljHUtQvVHnPniq_-dR8abg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 09:01:28 -0400 (EDT)
Message-ID: <3364aae7-9247-21aa-9ea4-36348462df4c@themaw.net>
Date:   Wed, 10 Aug 2022 21:01:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC][PATCH] uapi: Remove the inclusion of linux/mount.h from
 uapi/linux/fs.h
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163410.1659964655@warthog.procyon.org.uk>
 <87zggce9fd.fsf@oldenburg.str.redhat.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <87zggce9fd.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/22 17:26, Florian Weimer wrote:
> * David Howells:
>
>> We're seeing issues in autofs and xfstests whereby linux/mount.h (the UAPI
>> version) as included indirectly by linux/fs.h is conflicting with
>> sys/mount.h (there's a struct and an enum).
>>
>> Would it be possible to just remove the #include from linux/fs.h (as patch
>> below) and rely on those hopefully few things that need mount flags that don't
>> use the glibc header for them working around it by configuration?
> Wasn't <linux/mount.h> split from <linux/fs.h> relatively recently, and
> userspace is probably using <linux/fs.h> to get the mount flag
> definitions?

Not sure myself but this is in the user space kernel includes

and sys/mount.h has pretty much what linux/mount.h has plus a

few function declarations. It's almost a complete duplication.


The reality is that the enum declaration could be changed to

#defines (not a preferred approach) which leaves only the

struct mount_attr which is the difficult one to resolve.


>
> In retrospect, it would have been better to add the new fsmount stuff to
> a separate header file, so that we could include that easily from
> <sys/mount.h> on the glibc side.  Adhemerval posted a glibc patch to
> fake that (for recent compilers):
>
>    [PATCH] linux: Fix sys/mount.h usage with kernel headers
>    <https://sourceware.org/pipermail/libc-alpha/2022-August/141316.html>
>
> I think it should work reliably, so that's probably the direction we are
> going to move in.

Looked a lot more complicated than I thought it could be, enough

that I can't say if it will work so I'll take your word for it.


Ian

