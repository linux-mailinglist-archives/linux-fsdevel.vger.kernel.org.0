Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684D5488117
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 04:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiAHD1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 22:27:03 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54591 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbiAHD1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:27:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BAA473201DE2;
        Fri,  7 Jan 2022 22:27:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jan 2022 22:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        Drod5sNhsivc7N2/9D6/o/MYUJj+1swCdtB1mjRfUVE=; b=H6bzfqlohtX1E02S
        lMgENfW6BZoWYoY4qWX6afdU+o7SZBkI5U5kYorNjlLXG4AJXKwQL2Qw4d9jo+gU
        f7PiJPMkGKY3P2TG/VV2qW9DxfTc6QxOBaLqt7wnR0gto22h2L0eVRFAHLvEIkHQ
        X+0d5AkOuuxI/4DvG9gDymUWmR5lQK+XnUWXwxEhOGF5A7oFtGKei0pBYTi8Rdje
        sYF70ldJJnguV09e0qNXvV1udHXoNG/mk+IfbPagVERK8ZNVNSQDLiTJ7Z0brhMv
        H5cMECBBQSTmHWWDNMRZJgnUmPddZk1MVQTsG4qhyjE1T00UbcTkvqv6CO/h1sTF
        Hgphyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Drod5sNhsivc7N2/9D6/o/MYUJj+1swCdtB1mjRfU
        VE=; b=C89yJ5nT3pfU2ZkVrJ4TMZnrdVI9f5BYx5qnI1Xn5jim7ppl9Wj/ygEcB
        ctj9FPXDmLo5V7uipjYojVy1jTy+Q9eRgC0Ho93PuQvIPbgMPntQOAxOfyP79RA5
        2YBiFAvJATL3FHubwdIqcQ8TxnUmJBlY2lBq2VtcEc3kFw+CEl5DA8NVEn1RAuE3
        ZtYmK/ICVmhi+gdQ5Kmv0XToPzbyenfmFvBLzr4nFS3TQxeAZQbnOIiy+K4Qw5HZ
        bfCS2ViZ1wLKBT+KVRSNSL04I8cdM05N5E0X2r321XUebSV4+Z/bzv1TUzUGWPQG
        5lg/G2sVNN5QMed/BHHMaePYT4/Wg==
X-ME-Sender: <xms:hATZYUiFCfiA54vfSlbtPv7PkM8yxADchs2rd0RyHZwlYx_-yNokmA>
    <xme:hATZYdCLIsCctHPuGDO4Wvo8pyQ-PwAQcDPSCoAQXOIL61ChzBUcB3yc-jJMX1fKT
    1eHErKcWRso>
X-ME-Received: <xmr:hATZYcG_chNUJqgkGT7B0Opb4Ma_tTexAGba0zLqQkOIyG2PAJ8unwF-nCNQtnVMxDqfrtD4Dy1risVKb76hPK2au9iX-6KRVFlBq5p6YEIN-ndZaxOT5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderudenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffledvtdelheevudevhfekjeefvdekteffueejtdduveeftdevheeuveeihfelffenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:hATZYVR38sidJbrDQVYeYSRYnL6vQhkO3H_bOQ_rQLw6pk8QLpgPpA>
    <xmx:hATZYRwLJnxaTVtgc5QiT0DMMAf2fa2Jmd9XfYVUfwpT_OXUkFc-QQ>
    <xmx:hATZYT5_5BCeVKLujUS_LlJYyBd49urxBi4VU6j_oRhhTnzHSL-31g>
    <xmx:hATZYfazFYVw_apl20Vv6LS9pdcF1pfqlrh9cmJ7VnELgOYmr-j7fA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 22:26:58 -0500 (EST)
Message-ID: <02d56c068933d8084daa68dcad3bc87be764078c.camel@themaw.net>
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Sat, 08 Jan 2022 11:26:52 +0800
In-Reply-To: <Ydh9uKldc0cbusbt@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
         <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
         <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
         <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk> <Ydh5If9ON/fRs7+N@bfoster>
         <Ydh9uKldc0cbusbt@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-07 at 17:51 +0000, Al Viro wrote:
> On Fri, Jan 07, 2022 at 12:32:17PM -0500, Brian Foster wrote:
> 
> > > Other problems here (aside of whitespace damage - was that a
> > > cut'n'paste of some kind?  Looks like 8859-1 NBSP for each
> > > leading space...) are
> > 
> > Hmm.. I don't see any whitespace damage, even if I pull the patch
> > back
> > from the mailing list into my tree..?
> 
> That had occured in Ian's reply, almost certainly.  Looks like
> whatever
> he's using for MUA (Evolution?) is misconfigured into doing
> whitespace
> damage - his next mail (in utf8, rather than 8859-1) had a scattering
> of
> U+00A0 in it...  Frankly, I'd never seen a decent GUI MUA, so I've no
> real experience with that thing and no suggestions on how to fix
> that.

Yes, your right, I've changed that.
I'll play around some more to see if I can verify things are working,
mutt should be able to tell me that ...

Ian
> 
> > >         * misleading name of the new helper - it sounds like
> > > "non-RCU side of complete_walk()" and that's not what it does
> > 
> > The intent was the opposite, of course. :P I'm not sure how you
> > infer
> > the above from _rcu(), but I'll name the helper whatever.
> > Suggestions?
> 
> s/non-// in the above (I really had been half-asleep).  What I'm
> saying is that this name invites an assumption that in RCU case
> complete_walk() is equivalent to it.  Which is wrong - that's
> what complete_walk() does as the first step if it needs to get
> out of RCU mode.


