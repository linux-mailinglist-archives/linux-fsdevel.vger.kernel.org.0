Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0168B3A4BD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 03:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFLBKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 21:10:13 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55959 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhFLBKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:10:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 730B7580B30;
        Fri, 11 Jun 2021 21:08:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Jun 2021 21:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        w6subIA/IDQ7YOvElThWfYFkjzN9b3K5fV3mF6TevK0=; b=kpaAMS/00/yF1y2+
        Xp6ItdL77EInVKcl2FoC3aqscnaEoz+EsxSmTSufJCAhDDJ9ugx5F0IpMWXNQ1fb
        5/r/MRs7JSo3RraT4gVaQZFJezyjyzHPMr/dgzbGJZMcquSR9SVre1huBYYbsWMY
        e3PE098lWjiacBkM6cvsf/s0ccMw3cXNJjl0bCOYEp0utiRTE+GVIq4GXYG/vZOY
        44r9Pwj+IJbR3bPfEpXNi6zGjGg7W0GItVrrsChMxPaAjHiJd43kftQQlfTYLVGn
        hngmpCIjCY1gbLV9r6fd2iEYADFGTdbYey4Sz9Spf/yTGZ04x6bsefIdFKF0uA9S
        bLBE2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=w6subIA/IDQ7YOvElThWfYFkjzN9b3K5fV3mF6Tev
        K0=; b=QFYeSef1BZHL724vOEIhtoXp7JYIs0D2QX7g1P2OM+u5DonAeRSXJs9NE
        OtPD1RZGN8dKivbHrRcRqnMHACuxroD78IzWCkyOeJ5716acY5PJjUzIGGU3q9wJ
        Y9ddPv/7qlt4XsFchO0BTlu1hcnvPdIOdMPLOriPPvsVS0eBMyLg5MeKu0m7YlzO
        fEMgOoAzQWMlq1mtU6+wcZ0VutBwVQ6li3ABjD14ib26lWIhqHunrR311GFgK0N0
        qfkRqguHz4IzYr6DBmo/PK2Kt4LuO73JvUJ1ZRZ/G0iq7wlcRITdXcZgEy7/tULQ
        44kLLSc80R6TFggDaZfaJrAFHLukQ==
X-ME-Sender: <xms:_QjEYPbiGqHWSYfWrMkKtnBBqiVs6gXGozh_3QbSiOewNfX_cLoMlA>
    <xme:_QjEYObCGZeKSCLV6tH6pVlgT8BHBM7ul_tFfXlc6CFpdYwE59Bvz5YGLiBgElbCI
    vXS_WRskOH_>
X-ME-Received: <xmr:_QjEYB_4epIWui_Rn1vsHvuhLy04tMLJPo8UWUR35DbWmZzxYINT8Ua9brB8EWqs8wxzv_oVIIlpdQdDUd2X4QxyP50TTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:_QjEYFrrvrx5rnIZl6utt_G4mwTf4fIWMZBcr9QgfT1Tko8LUv0eCQ>
    <xmx:_QjEYKrV-CMiklOoJWbWy0jAibzBaNIVNPrDmAXIDq4qu6Z7cBGorw>
    <xmx:_QjEYLRRiMZmi7uRLqJS66_sMAZZRb7jLWR6WOqTS1DVIUzY7I2C-w>
    <xmx:_gjEYHQ5Zj2_eyg2I1sZ4RIEZpCB2v9LINgTN2tDxjMni2xaEYDdKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 21:08:08 -0400 (EDT)
Message-ID: <ab91ce6f0c1b2e9549fc6e966db7514a988d0bf1.camel@themaw.net>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Jun 2021 09:08:05 +0800
In-Reply-To: <2ee74cbed729d66a38a5c7de9c4608d02fb89f26.camel@themaw.net>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
         <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
         <2ee74cbed729d66a38a5c7de9c4608d02fb89f26.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-06-12 at 08:43 +0800, Ian Kent wrote:
> On Sat, 2021-06-12 at 00:07 +0000, Al Viro wrote:
> > On Wed, Jun 09, 2021 at 04:50:27PM +0800, Ian Kent wrote:
> > 
> > > +       if (d_really_is_negative(dentry)) {
> > > +               struct dentry *d_parent = dget_parent(dentry);
> > > +               struct kernfs_node *parent;
> > 
> > What the hell is dget_parent() for?  You don't do anything blocking
> > here, so why not simply grab dentry->d_lock - that'll stabilize
> > the value of ->d_parent just fine.  Just don't forget to drop the
> > lock before returning and that's it...
> 
> Thanks Al, I'll change it.

But if I change to take the read lock to ensure there's no operation
in progress for the revision check I would need the dget_parent(), yes?

> 
> > 
> > > +               /* If the kernfs parent node has changed discard
> > > and
> > > +                * proceed to ->lookup.
> > > +                */
> > > +               parent = kernfs_dentry_node(d_parent);
> > > +               if (parent) {
> > > +                       if (kernfs_dir_changed(parent, dentry)) {
> > > +                               dput(d_parent);
> > > +                               return 0;
> > > +                       }
> > > +               }
> > > +               dput(d_parent);
> > > +
> > > +               /* The kernfs node doesn't exist, leave the
> > > dentry
> > > +                * negative and return success.
> > > +                */
> > > +               return 1;
> > > +       }
> 


