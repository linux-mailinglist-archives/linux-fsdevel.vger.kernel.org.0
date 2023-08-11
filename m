Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D777944F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjHKQX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKQX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:23:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C219AE
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 09:23:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7CBC532002FB;
        Fri, 11 Aug 2023 12:23:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Aug 2023 12:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691771033; x=1691857433; bh=nl
        Y+x7iFrzUADh1g0YAdjpoez/ND1yARZuPgd5smBl8=; b=fiyLxYxKYejFs5VV7H
        h6I3KGeThesGYjLTipNhNC31yzIVh1704OjnbM4zJyujGX5EALauXukrmnsH05cQ
        vuf1GRDW5ZthMUMj8/xhAAZUQXJ78ZZZ/m9KN/GenTXnihKRQQ4UfWvP7RlDFHUq
        INj7Kb/2BaIGrE6lySMGxCPZysyOSRWNQIDZK1yopqbtfeophKPatINpJQ/uOzOe
        e39TAp9BarVg8OGL9FLuGcF2cfBYHaZaEJBD3HlLQXGsXTpWSexOApccgFC4AvQo
        yIC3tbkKmh0ha9XtCBXdjCtecrXjOfd3CDRywBj8qyZ2hgBHfk6zuLN8+tFFyyre
        lJmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691771033; x=1691857433; bh=nlY+x7iFrzUAD
        h1g0YAdjpoez/ND1yARZuPgd5smBl8=; b=V0YvKXtL16yTRTKSiDxxmGmbZ7Df5
        kL1Sk8qaaLEIYlyjG+fMuYVMOMXjdN9S9syctrHfx1basXScmZ1cmWDhA7Lb5CI9
        ROizRwAeqrY890u3wN2Z+W2G2Fpev7xTffJRvZa5PmXKokzI2rwn3JV2Rzr21qDG
        LhnjXJGPbfsnlCtFVFCYT5y1IKyDMQjLnCDVnK8gkLnrNqtecncnkoQ5yLBVSSXz
        2QSP4DmIk8YD73otxs32Nljo2LlF83xf3VqXiA2JvEOH4AtDPjCHQjbacg6iHxYy
        27pIC4/9hBF6DNL0qN6gK7IePoYbYWdgSbdgjh+FiXPY1mkBfFqp4NvBw==
X-ME-Sender: <xms:mGDWZLjFkvh8s8jv6esF2dHNbCACxbqW9sO7LJD3VokrTMYZTirJNA>
    <xme:mGDWZICbt9HR-pIsbaQgg7r0BCdT_MVNuLCR9IH4TnKNCf9vWn9bpHxIiiT7XfGeC
    nmgKPcwixT3swPXSSk>
X-ME-Received: <xmr:mGDWZLGNQpJeWgepOAau780nWc3vYu5Bi4asHNonawr_i5BR180ja_NvLidrMwqTFypeye3v1CZdxojG9t6gXhSLCJvLuji8Piuq0S8dAuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdugeeu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:mGDWZITGsnNEI-FqvxgO6hODQXhJL37ZuAOaTJ6OrIwgnaLXqamI6w>
    <xmx:mGDWZIzibJet-YLhX_XwJpIeLi3BfNXvvvBJAoowtsNmD7NgNKYdZw>
    <xmx:mGDWZO7Z3A4W4oM7YgeYTEvYLyxMoIT4vgEHSFJ704hCVhfJsxOr0w>
    <xmx:mWDWZCtel6DdikHeuuIjso6-kzXxQkEG12qPlUIhg8R9dPvc042eaA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Aug 2023 12:23:51 -0400 (EDT)
References: <20230808170858.397542-1-shr@devkernel.io>
 <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
 <107af1a4-a6ff-9048-07bd-248336e44980@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com
Subject: Re: [PATCH v1] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Fri, 11 Aug 2023 09:23:17 -0700
In-reply-to: <107af1a4-a6ff-9048-07bd-248336e44980@redhat.com>
Message-ID: <qvqwv8dlwnsc.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 08.08.23 19:17, Andrew Morton wrote:
>> On Tue,  8 Aug 2023 10:08:58 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>>
>>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>>> is enabled we can query how effective KSM is overall. However we cannot
>>> easily query if an individual VMA benefits from KSM.
>>>
>>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>>> how many of the pages are KSM pages.
>>>
>>> Here is a typical output:
>>>
>>> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
>>> Size:             262144 kB
>>> KernelPageSize:        4 kB
>>> MMUPageSize:           4 kB
>>> Rss:               51212 kB
>>> Pss:                8276 kB
>>> Shared_Clean:        172 kB
>>> Shared_Dirty:      42996 kB
>>> Private_Clean:       196 kB
>>> Private_Dirty:      7848 kB
>>> Referenced:        15388 kB
>>> Anonymous:         51212 kB
>>> KSM:               41376 kB
>>> LazyFree:              0 kB
>>> AnonHugePages:         0 kB
>>> ShmemPmdMapped:        0 kB
>>> FilePmdMapped:         0 kB
>>> Shared_Hugetlb:        0 kB
>>> Private_Hugetlb:       0 kB
>>> Swap:             202016 kB
>>> SwapPss:            3882 kB
>>> Locked:                0 kB
>>> THPeligible:    0
>>> ProtectionKey:         0
>>> ksm_state:          0
>>> ksm_skip_base:      0
>>> ksm_skip_count:     0
>>> VmFlags: rd wr mr mw me nr mg anon
>>>
>>> This information also helps with the following workflow:
>>> - First enable KSM for all the VMA's of a process with prctl.
>>> - Then analyze with the above smaps report which VMA's benefit the most
>>> - Change the application (if possible) to add the corresponding madvise
>>> calls for the VMA's that benefit the most
>> smaps is documented in Documentation/filesystems/proc.rst, please.
>> (And it looks a bit out of date).
>> Did you consider adding this info to smaps_rollup as well?
>
> It would be great to resend that patch to linux-mm + kernel. Otherwise I'll have
> to do some digging / downloading from linux-fsdevel ;)

I'll cc linux-mm + kernel on the next version.
