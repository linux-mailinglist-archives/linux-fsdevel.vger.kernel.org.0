Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1565899AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiHDJGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiHDJGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:06:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8D2BB01;
        Thu,  4 Aug 2022 02:06:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A23B5C01A6;
        Thu,  4 Aug 2022 05:06:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Aug 2022 05:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659604000; x=
        1659690400; bh=rFiIXjECfUiffiTGaGpcuH5wzCwxqCnwZxuo6PM6Lmo=; b=N
        3FX3KUcFoLOb/hd7V92ghCYY/QhJguPw3bWPOtarRtQQWBjcKwcuHtA7U8/+C/1f
        Ql79WMRN+XUkvNQCrTpTLxd53LUMO+sIjx2gUa47B3VU/5SWPv59Aur9xbcxfSrp
        rMrb2u/IwHj8uzzKnaIN+iiPTbSFAD2RNwvJOi6I74ufQSUyq5EqtbzRG08vXbgV
        pjygCy+gKWSCVPHAMYXsZPPlDMluUKMHkGTTBuZ1ynLpBQSvXfSNam7RO+Gy2rDw
        OJke9wBSmAzIIohxf9z4lRncC1ucNzM/ZqRKmHYxaJL44btAoSCmV1kg5lfxiyrK
        Fsfjs6h69sP6rrc4xzv3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659604000; x=1659690400; bh=rFiIXjECfUiffiTGaGpcuH5wzCwx
        qCnwZxuo6PM6Lmo=; b=tsR2gOBm0Ba/WRD+rKF0Erj3xXRSMRrf/m7eomHDseHj
        U3eRMSqFAfGxA9YQji63CL61AmJzVXfGehRAbA00iL8iDHRd6sqZF0gAWmCnnwRx
        gaqD7WZmhpdmRquhoWT9guII7n3nnHg+C3ai+gmYNCAX1Novuiow3j346IR/1cJF
        Z6TfVHGOHDBf5q95SXI01WGoULSIcPfAo7dwRGRT0skwJkOAuX8L6oai/hsN3/lI
        jkuGzZ3b7rwdhJkoN0BXQcCQXFLo09O/WC4owaaowfxwSwYJ6+9mp1pNQEAM9mjQ
        mA2W2+uYo1fTyzjAODrVxI5hf7WY9iO7EwvDLJmsPg==
X-ME-Sender: <xms:IIzrYqamPHg4JWLWDitvFjEH7TBMXf1dxdKVAgOIL4CrV0yYwOnOqw>
    <xme:IIzrYtY0ioznyafymCRtV4QVh4szLgmxp5KXBSl3Td0Yc-sVHTmx0kASJgzmVqlRT
    q4jMck-B0TjxkuatK8>
X-ME-Received: <xmr:IIzrYk8b-UJKglrbA9cU3EF1wZ2xqGO9QJLPvVT3CAgbZEfPQhrCyEOnzJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehhedthfeitdeugefhhffftdeigefhjeefleegiedvjeejtdev
    jeeivdekgfeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:IIzrYsoGUUY7VRFyI7eXHOwbVgdewAdKmiAg51WOREBDQKi6WWK31g>
    <xmx:IIzrYlokFWf96Wn9Te6dxitWJaifvQpbwl6l5Hxy4c6JxadAaU8Wxw>
    <xmx:IIzrYqTyh_LWCl1LQTpKxuZz72B_QJOE34GopGsERiWEaxz_imCGRQ>
    <xmx:IIzrYs2iGk_Hm4R4y0UbUdyEwTzP54eu63_bFiBFkbmqhtR3kzMGFQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Aug 2022 05:06:39 -0400 (EDT)
Date:   Thu, 4 Aug 2022 02:06:38 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Dump command line of faulting process to syslog
Message-ID: <YuuMHkMIssKcBYeX@localhost>
References: <20220801152016.36498-1-deller@gmx.de>
 <YugGFEjJvIwzifq7@localhost>
 <a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de>
 <Yut+0Fg7F99MI48J@localhost>
 <2f4c1abb-ca27-178a-31c3-5e422613e7e8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4c1abb-ca27-178a-31c3-5e422613e7e8@gmx.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:39:52AM +0200, Helge Deller wrote:
> On 8/4/22 10:09, Josh Triplett wrote:
> > On Tue, Aug 02, 2022 at 09:40:50PM +0200, Helge Deller wrote:
> >> On 8/1/22 18:57, Josh Triplett wrote:
> >>> However, it's also an information disclosure in various ways. The
> >>> arguments of a program are often more sensitive than the name, and logs
> >>> have a tendency to end up in various places, such as bug reports.
> >>>
> >>> An example of how this can be an issue:
> >>> - You receive an email or other message with a sensitive link to follow
> >>> - You open the link, which launches `firefox https://...`
> >>> - You continue browsing from that window
> >>> - Firefox crashes (and recovers and restarts, so you don't think
> >>>   anything of it)
> >>> - Later, you report a bug on a different piece of software, and the bug
> >>>   reporting process includes a copy of the kernel log
> >>
> >> Yes, that's a possible way how such information can leak.
> >>
> >>> I am *not* saying that we shouldn't do this; it seems quite helpful.
> >>> However, I think we need to arrange to treat this as sensitive
> >>> information, similar to kptr_restrict.
[...]
> > I don't think we should overload the meaning of dmesg_restrict. But
> > overloading kptr_restrict seems reasonable to me. (Including respecting
> > kptr_restrict==2 by not showing this at all.)
> 
> I'm fine with kptr_restrict, but I'm puzzled for which value of kptr_restrict
> the command line should be shown then.
> By looking at the meaning of kptr_restrict, I think the command line should be
> hidden for values 0-2.
> Do you suggest to add a new value "3" or am I missing something?

I'm suggesting treating it the same as a pointer value:

0: always show command line
1: show command line if read by privileged caller
2: never show command line

That could either use kptr_restrict or use a separate cmdline_restrict.
