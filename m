Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD64BB0F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 05:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiBRE4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 23:56:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBRE4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:56:07 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 20:55:50 PST
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0A84130F;
        Thu, 17 Feb 2022 20:55:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C7AF15C021B;
        Thu, 17 Feb 2022 23:47:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Feb 2022 23:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=MAx0LbiRQY2/4y
        fvblXz5g/u+zDEUYP5tuDrUJ8qmwQ=; b=I7ZRQ1BmgnsxTccEzquz5498MFjt54
        0dJYI+ugMMV8NaSvSuz2sbYtS5IYKRAgu6jR1lQ0Y7Gv/2F8L+ZJHdo0TrYxnNqR
        GZkfW2HosNfWFjLrcLNbttXIKNOyc5xjL0DbS/I3WJ19aOwaQZ3r2Sv9Ftlrg+SK
        h+ohCUMKkH9RJQ/AGwPg4SA9prbbV2zQavd6h5YbiRGJ0mTTUe9YCmdWD+xEPQ9A
        RxSIvFQsG8WVTYhst2AqnUgNweB0wmVr7cF2uEwMGKrCrq4ig1hcsGlDfPyJ6SUZ
        0oVzXob/M7eQHESEy2LTyFL79o7R4UZwbq0Km7dYjaBrV5D2BAGnFolg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=MAx0LbiRQY2/4yfvblXz5g/u+zDEUYP5tuDrUJ8qm
        wQ=; b=KAUf4Dx8X7/lwkY78oioZj07RZWfgPCG54ojKLPgb3qHP51tvq/Z/fX34
        +tCzRQ/vq3J5KJrjqoX1B9vyY/a7C950qWZKZFvjt3Bze2iiZ5K7IitiODqX1/bp
        ZIz8k6vzor19SGtrTXNZ6F4Zl9QD++ZRMAZmRhrKjk7xCjHEvqZnYbjwKM/tcbis
        NG0JBvwn62H2WSJNascgg1o2wodJMWlA5RvogzYKElOJ45GawtWgGHPU0AEG71M+
        iduFCShz2qkyak82rYpq41v5jBmvnWMbsweuLGx8jVnvzF21/bLvW7Kb03rYXkPN
        B9gE0RpInvEKqrPvrBTk3jjZ7inyg==
X-ME-Sender: <xms:8SQPYlJjs6whUac1XfFfY3iKqagmwTQ4VIV0543opSBFTHPogf56hg>
    <xme:8SQPYhISK6fUF14TWPotQhEeAoxxWgvJlHHaBx55sMDoRq5ZErgPNmqirW9g9xCjg
    fA_9whkszep>
X-ME-Received: <xmr:8SQPYts1ixs12d6uS7BoyWyAXKrEXZ03NLpm3N2B3lntbb9wcFt4lOZiEm4DT1LNNyeDVqaDCNtgJMRy7i294EM1t8ykX5xGEfVHWPxXXc882DVzj-Nd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepve
    egfeekgfeiueeujeeigefgueffjeeuvddtheetfeegtdevtdetgedutefhtdfgnecuffho
    mhgrihhnpehsphhinhhitghsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:8iQPYmYccKG7iujCzCjDt_WdVh3vETEXUMx_w_ULFmQvE5br-xJjJQ>
    <xmx:8iQPYsZ_i1QJGDSrDCw_8EI-Y6NpuFJMEGkozygc6QTzPN9C2ATPSw>
    <xmx:8iQPYqDnn1OEYNLO_D8YIOH_X85TGw5vnxwMRF6GrqrOmLxiq40ceQ>
    <xmx:8iQPYrl_wLhzA2F0KG3QokhVasTWQsJuMurFv5x207Q28W6vDWZw_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 23:47:43 -0500 (EST)
Message-ID: <480248c2fdd2a098fd016aea832f297d711dfdff.camel@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
From:   Ian Kent <raven@themaw.net>
To:     NeilBrown <neilb@suse.de>, Stanislav Levin <slev@altlinux.org>
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Feb 2022 12:47:37 +0800
In-Reply-To: <164506664650.10228.15450975168088794628@noble.neil.brown.name>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
        , <164444398868.27779.4643380819577932837@noble.neil.brown.name>
        , <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
         <164506664650.10228.15450975168088794628@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-17 at 13:57 +1100, NeilBrown wrote:
> On Tue, 15 Feb 2022, Stanislav Levin wrote:
> > 
> > 
> > This seems duplicate of
> > https://www.spinics.net/lists/autofs/msg02389.html
> > 
> 
> Yes it is - thanks for the link.
> I wonder why the proposed fix isn't in git ....

I think we are refering to commits:
fc4c067b53f7 autofs-5.1.7 - make NFS version check flags consistent
26fb6b5408be autofs-5.1.7 - refactor get_nfs_info()
606795ecfaa1 autofs-5.1.7 - also require TCP_REQUESTED when setting NFS
port

> 
> Also, I cannot see that the new NS4_ONLY_REQUESTED is different from
> the
> existing NFS4_VERS_MASK.
> They are both set/cleared at exactly the same places.

Yes they are at the moment.

The aim there is, at some point, to have two seperate cases for NFSv4
mounts, one that may use rpcbind and one that does not such as when
traversing a firewall. Although I'm not clear on it myself the RFC
says, more or less, should (although that might have been must) not
need to use other than the NFS port, so no rpcbind should need to be
used.

Clearly the case seperation hasn't happened yet but I'm pretty sure
the current code did avoid the rpcbind usage for fstype=nfs4 which
is what was asked for at the time and what had been broken somewhere
along the line.

Ian
