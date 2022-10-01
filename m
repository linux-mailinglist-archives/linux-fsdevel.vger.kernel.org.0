Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83865F1D73
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJAQCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJAQCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:02:05 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577EF4E61B;
        Sat,  1 Oct 2022 09:02:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D96975C00BD;
        Sat,  1 Oct 2022 12:02:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 01 Oct 2022 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1664640121; x=
        1664726521; bh=DWs5cDrTNAg8qg36bgLWEHBWdku/VXbzKnY3VodDLTI=; b=l
        SiIZVlfC9lL3yBGqyo9kU96XhEpUIsRW6pJoOQTZu5JQb9G9DNlqvUezT+6wkYRC
        Vbfb+dO/favj+cEXFE8twLoNjmwCY0DzBGVXxDuWP55AwMGR14P2hR3VNcdvlnc8
        6Ay5aGguX+sAwdQv7wQApRErBe3T5G8N0PBYEwRCE0OT6ImLyupgAefgnPzwqqZ/
        2r3+CkL0SVfPr2rbXP4H/A51Dj18G15cs9unAKQ2Gew1HomkHGdh0EYOJ5EK98Ij
        zuKbg6y7BCI5GvjFhIPRWYZCi6Rwu6pUpAd5tM1iiLmLmUEBWhiNsZ3cqSiw4OAN
        5L8DbG2kDcFe3E9c0YpWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664640121; x=1664726521; bh=DWs5cDrTNAg8qg36bgLWEHBWdku/
        VXbzKnY3VodDLTI=; b=TbfsApETPYKiyvn6EdR9DxIr1p/2li90f1S0I+Qi0rPs
        BF2INv3c4OmB8icFtgNXOSkdxsB//nSnt4DtSxPq68lBWmBAs89zN0GO3Dgx9Sa6
        LwC++8f6sSfpbu6MN9nTkqBIWy7+XiDNv5BHU4ZxN5FUsFLG0RVQ1TZl98J7l+gc
        zbOCvDuW/KutbNFJfxe6K9RV5TIdYId4CwNIriAubHu+bSH81Z78Vsev13jUakei
        UE8N+n7riQvv9UPmNXKHCXb76Ibw4iPEzuc3bDnLVgpxfWtZtKargjpCSHDzorjF
        2aspEzgWA2rhcQ9c4ryP2zDvlyIGziPe6H+CXzBsWg==
X-ME-Sender: <xms:eWQ4Y0w25PKo1RnAG9_ej_EoXiOJpqoa0JA1lH5iygUewQ9xhrVy5A>
    <xme:eWQ4Y4SC-bFAbFeQvjRVI_XQHu7adz6Lu3UuMowY2kp4lKiTR7rUo52ZCzceENAyL
    DYmkWL_VS5gblI8kdA>
X-ME-Received: <xmr:eWQ4Y2WCj7ML2g_NxP6sEXDRGenkWeAWjT3BMK8PxJzQ3Nnz6Jt_rIce27pQPDOE5tN9MBrUO70HGsN5vOQXIXMNDgilgxByU_FJZhLXstppLOTy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehhedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegjeduuedtleefuefgvdeghfehuefhtefffeetvdffgeekteeh
    hfehtddvtdegieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhi
    phhlvghtthdrohhrgh
X-ME-Proxy: <xmx:eWQ4YyivQHPZg3nyAVA5tc6xbkjvO3Ltw-e4MXj2xO_A978kAB87Fw>
    <xmx:eWQ4Y2BIDJXBRpGQFXhZR-YuqqRp0YFt4LxAa7wuOsPTf1-BLyDn6w>
    <xmx:eWQ4YzKtp_iB7-UK59tD18NPexIkWwRlYSgZVO6Qixl7gIiAKuTT9w>
    <xmx:eWQ4Y953Cai8p6BZKlz1W5ufRvPcko6HEMTVgEWHNyvPTTdgALDSOQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Oct 2022 12:01:59 -0400 (EDT)
Date:   Sat, 1 Oct 2022 17:01:57 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <YzhkdZrb7vpodK6I@localhost>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
 <YyTY+OaClK+JHCOw@localhost>
 <202209161637.9EDAF6B18@keescook>
 <YyUZ0NHfFF+eVe24@localhost>
 <202209191256.893576D4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209191256.893576D4@keescook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:02:51PM -0700, Kees Cook wrote:
> On Sat, Sep 17, 2022 at 01:50:24AM +0100, Josh Triplett wrote:
> > On Fri, Sep 16, 2022 at 05:11:18PM -0700, Kees Cook wrote:
> > > I don't like the idea of penalizing the _succeeding_ case, though, which
> > > happens if we do the path walk twice. So, I went and refactoring the setup
> > > order, moving the do_open_execat() up into alloc_bprm() instead of where
> > > it was in bprm_exec(). The result makes it so it is, as you observed,
> > > before the mm creation and generally expensive argument copying. The
> > > difference to your patch seems to only be the allocation of the file
> > > table entry, but avoids the double lookup, so I'm hoping the result is
> > > actually even faster.
> > 
> > Thanks for giving this a try; I'd wondered how feasible it would be to
> > just do one lookup.
> > 
> > However, on the same test system with the same test setup, with your
> > refactor it seems to go slower:
> > fork/execvpe: 38087ns
> > fork/execve:  33758ns
> > 
> > For comparison, the previous numbers (which I re-confirmed):
> > 
> > Without fast-path:
> > fork/execvpe: 49876ns
> > fork/execve:  32773ns
> > 
> > With my original separate-lookup fast-path:
> > fork/execvpe: 36890ns
> > fork/execve:  31551ns
> 
> Hmm, this shows as slower in the *normal* case, which I find rather
> surprising -- it's the same work, just reordered.
> 
> Can you post a URL to your tests? I'd like to reproduce this and maybe
> throw perf at it as well.

Sure. Sorry for the delay, needed to integrate some fixes (such as
aarch64 support) and factor out the bits that won't build if you don't
have a patched liburing.

https://github.com/joshtriplett/spawnbench

- Josh Triplett
