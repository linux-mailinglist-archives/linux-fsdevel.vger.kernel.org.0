Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9992B2028CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFUEzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 00:55:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgFUEzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:55:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E3ED55C00D9;
        Sun, 21 Jun 2020 00:55:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 21 Jun 2020 00:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        f+V9My7t/LV5Z1d5BR8PtxKFjib8M82ampdGENj43xs=; b=jbmmzG5p80Saoabi
        K3WnNtkDePNaiYrrpVhfTl522U7K1gt8nJ4Mfe3HRuusCQm5YwoOj84iuzptt+R8
        QS9aGToJwxnUrAoYa1U/LJBbb6dX0TWCK6pvQ2NMYYvDfeMzhuo5jhCN9ZnVUfRX
        oIUfY28YH/ANehBFvPzcJQP1g8pgnWr6D/M12OwczwjyqgBUPmWT8wQ8YHaDWgQ8
        Z3OPRVirGKvdMhNgPtr0yLznqSJvHplfMWF0SgMWR/wgfZuWwEJfl2cXEjmAbkS9
        tQfTwn/E4b0k4kB3+xBQuDB0Ln1itiBCzPFnXi28zW0FR3WsZM50jv6QhK6sUMJi
        0yzu9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=f+V9My7t/LV5Z1d5BR8PtxKFjib8M82ampdGENj43
        xs=; b=eMAb+jtW5tMrk2tCc6qgBU8MBeO4LpnSCyLWwf9n/BQjSmtoV+DRIWFsM
        BCygPTW4+XGCgFvJ+V2CnOpbeROigIjQI4+gRaGlgbROJe0akYvd2vUsomgKuyGz
        7xTY98IaTSSLH19ntblIafoKcHCc++6vr8dkqcMwA9vMz1l1ND9VD1nULDPSjiYI
        QiMFjD2MzbRZVUFuIHiwfyQoiYTS9SLvE69kSXHhCdgaa/MRc154yOHBMY8pLAKg
        YFo08HAUe/YDJ1IW6CDyYfHM3VYb53puSSuxXxgrL7T83DIlnIYgKcYaVJyGGN99
        P/nMMSlZ0yLsXLJE5r1GmUa04+Ssg==
X-ME-Sender: <xms:S-juXu_4mcnUs8U8t5Ll8Yt_2sptLmf2hkrISK2BixOyYUTWHoD0Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejledgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepheekrdejrdduleegrdekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:S-juXuvTfzIWNDDp6BGf1vqPn4D6zDo7EqCHYkRIyM6qUiENz0qyUQ>
    <xmx:S-juXkC11nbHTRnab62GYXQf_L4Ef3dp4_7aEIT0xBfDl9esTGb2CQ>
    <xmx:S-juXmcYJlyvoDo08j59L6OfsNQ7hGxYhOaDZhI-gtdvCHVWc5rYRg>
    <xmx:TOjuXu3MPW_LjjcDfWoug0r4HVQ_TpI78HcytGFvLplsWfbTuhRR9w>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6513F30614FA;
        Sun, 21 Jun 2020 00:55:36 -0400 (EDT)
Message-ID: <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 21 Jun 2020 12:55:33 +0800
In-Reply-To: <20200619222356.GA13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-06-19 at 18:23 -0400, Tejun Heo wrote:
> On Fri, Jun 19, 2020 at 01:41:39PM -0700, Rick Lindsley wrote:
> > On 6/19/20 8:38 AM, Tejun Heo wrote:
> > 
> > > I don't have strong objections to the series but the rationales
> > > don't seem
> > > particularly strong. It's solving a suspected problem but only
> > > half way. It
> > > isn't clear whether this can be the long term solution for the
> > > problem
> > > machine and whether it will benefit anyone else in a meaningful
> > > way either.
> > 
> > I don't understand your statement about solving the problem
> > halfway. Could
> > you elaborate?
> 
> Spending 5 minutes during boot creating sysfs objects doesn't seem
> like a
> particularly good solution and I don't know whether anyone else would
> experience similar issues. Again, not necessarily against improving
> the
> scalability of kernfs code but the use case seems a bit out there.
> 
> > > I think Greg already asked this but how are the 100,000+ memory
> > > objects
> > > used? Is that justified in the first place?
> > 
> > They are used for hotplugging and partitioning memory. The size of
> > the
> > segments (and thus the number of them) is dictated by the
> > underlying
> > hardware.
> 
> This sounds so bad. There gotta be a better interface for that,
> right?

I'm still struggling a bit to grasp what your getting at but ...

Maybe your talking about the underlying notifications system where
a notification is sent for every event.

There's nothing new about that problem and it's becoming increasingly
clear that existing kernel notification sub-systems don't scale well.

Mount handling is a current example which is one of the areas David
Howells is trying to improve and that's taken years now to get as
far as it has.

It seems to me that any improvements in the area here would have a
different solution, perhaps something along the lines of multiple
notification merging, increased context carried in notifications,
or the like. Something like the notification merging to reduce
notification volume might eventually be useful for David's
notifications sub-system too (and, I think the design of that
sub-system could probably accommodate that sort of change away
from the problematic anonymous notification sub-systems we have
now).

But it's taken a long time to get that far with that project and
the case here would have a far more significant impact on a fairly
large number of sub-systems, both kernel and user space, so all I
can hope for with this discussion is to raise awareness of the need
so that it's recognised and thought about approaches to improving
it can happen.

So, while the questions you ask are valid and your concerns real,
it's unrealistic to think there's a simple solution that can be
implemented in short order. Problem awareness is all that can be done
now so that fundamental and probably wide spread improvements might
be able to be implemented over time.

But if I misunderstand your thinking on this please elaborate further.

Ian

