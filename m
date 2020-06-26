Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB04D20A9D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgFZAUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 20:20:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36619 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgFZAUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:20:00 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 846CD5C0121;
        Thu, 25 Jun 2020 20:19:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jun 2020 20:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        GQgFWu1HoAe4qYZmeyW1FBUXYqQxMSPqjVBPju/eNA4=; b=h2g4+ljLWB9V6mWM
        tme2JNpXNbl3IhUliUwVdlCFu47jzfVRjPsNS6r0lKqT2kJmDRct3bCxbTXaJSpV
        OGzcaGhNlNSkshG2UJP3/nk5jP83G0EdO1pn2MO0gyphZ9qcwNFzysd0nrue1o4W
        d5srU5IJ5wlgDBgfIu9TIfS1ctFOUosXRdZuzw16YIACNx37HTvphjzBoiiAnf6E
        LO3UzoMmS5wJincJMre5vx6IFghhZslzR0/x/b8vu9mIB8CoI7M37tp4i1g2FhCP
        TqzvS21k/YRzgSGzGtCgAxVTfEihjKqPqOiJj3oS8T6AF8PhXP9520ExayHT4/5s
        iVwevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GQgFWu1HoAe4qYZmeyW1FBUXYqQxMSPqjVBPju/eN
        A4=; b=nmF6sHCXivcWeKbgd7KysucoCq8LWjFtci7fCnjHiZFBCqhKGeKuPrdLE
        jyXANV20nW78y2H/wuAfwepzbezHD5OqM2n4JOzxysXcSEasm3thdnk7Bb48YxoO
        RESsKzmzmfc3UJup+Hz+lX5eZPz5EfmK6WtZkUW9zNSOdAoDjfsHmRkeiKBEfBEB
        9VYg7/DHvYLM46SBSn0Ji/zN+O0F2NkqKlNjKtP6V7FGy8vJtvctCxdiArTtm0yj
        G/JVrHB/hXHaHGGiqsE9mV+JmUFSygAQDO5X3q9selXZmsiLkZQCE23XNy5VAh83
        BSRvHWfnDtrdvTInKBhKkfenfeNsQ==
X-ME-Sender: <xms:LT_1XismBSqQfWLILUy55xIBYemR4GInVx99RKWC7-Ghy4fD6U9rhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeltddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrheejrdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Lj_1Xnf-FUa0p6lI_z7sFQsthGzqRF72euM7cecZ2-73iOwKs8eWqg>
    <xmx:Lj_1XtyaEFnU0uW9cXZvZMJp77gAAoEbei3C0XXxrGMv0J41OjMpdA>
    <xmx:Lj_1XtMD56bEglgohcv7wuUTPB_-bqzFCYIQpV0-vmHvhx7LlcYuOA>
    <xmx:Lz_1XpmcEp0JlanqNNWBVYWZRNoPFv6xvXKQTLo9dzP1CZdipdyDFQ>
Received: from mickey.themaw.net (unknown [118.208.57.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85EF13067703;
        Thu, 25 Jun 2020 20:19:54 -0400 (EDT)
Message-ID: <bdb07787592f6d36ec1317eabd79f36097fd1ec2.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Jun 2020 08:19:50 +0800
In-Reply-To: <20200625094317.GA3299764@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
         <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
         <20200622175343.GC13061@mtj.duckdns.org>
         <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
         <20200623231348.GD13061@mtj.duckdns.org>
         <ac4a2c133da21856439f907989c3f9d781857cbf.camel@themaw.net>
         <20200625094317.GA3299764@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-06-25 at 11:43 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 25, 2020 at 04:15:19PM +0800, Ian Kent wrote:
> > On Tue, 2020-06-23 at 19:13 -0400, Tejun Heo wrote:
> > > Hello, Rick.
> > > 
> > > On Mon, Jun 22, 2020 at 02:22:34PM -0700, Rick Lindsley wrote:
> > > > > I don't know. The above highlights the absurdity of the
> > > > > approach
> > > > > itself to
> > > > > me. You seem to be aware of it too in writing: 250,000
> > > > > "devices".
> > > > 
> > > > Just because it is absurd doesn't mean it wasn't built that way
> > > > :)
> > > > 
> > > > I agree, and I'm trying to influence the next hardware design.
> > > > However,
> > > 
> > > I'm not saying that the hardware should not segment things into
> > > however many
> > > pieces that it wants / needs to. That part is fine.
> > > 
> > > > what's already out there is memory units that must be accessed
> > > > in
> > > > 256MB
> > > > blocks. If you want to remove/add a GB, that's really 4 blocks
> > > > of
> > > > memory
> > > > you're manipulating, to the hardware. Those blocks have to be
> > > > registered
> > > > and recognized by the kernel for that to work.
> > > 
> > > The problem is fitting that into an interface which wholly
> > > doesn't
> > > fit that
> > > particular requirement. It's not that difficult to imagine
> > > different
> > > ways to
> > > represent however many memory slots, right? It'd take work to
> > > make
> > > sure that
> > > integrates well with whatever tooling or use cases but once done
> > > this
> > > particular problem will be resolved permanently and the whole
> > > thing
> > > will
> > > look a lot less silly. Wouldn't that be better?
> > 
> > Well, no, I am finding it difficult to imagine different ways to
> > represent this but perhaps that's because I'm blinker eyed on what
> > a solution might look like because of my file system focus.
> > 
> > Can "anyone" throw out some ideas with a little more detail than we
> > have had so far so we can maybe start to formulate an actual plan
> > of
> > what needs to be done.
> 
> I think both Tejun and I have provided a number of alternatives for
> you
> all to look into, and yet you all keep saying that those are
> impossible
> for some unknown reason.

Yes, those comments are a starting point to be sure.
And continuing on that path isn't helping anyone.

That's why I'm asking for your input on what a solution you
would see as adequate might look like to you (and Tejun).

> 
> It's not up to me to tell you what to do to fix your broken
> interfaces
> as only you all know who is using this and how to handle those
> changes.

But it would be useful to go into a little more detail, based on
your own experience, about what you think a suitable solution might
be.

That surely needs to be taken into account and used to guide the
direction of our investigation of what we do.

> 
> It is up to me to say "don't do that!" and to refuse patches that
> don't
> solve the root problem here.  I'll review these later on (I have
> 1500+
> patches to review at the moment) as these are a nice
> micro-optimization...

Sure, and I get the "I don't want another post and run set of
patches that I have to maintain forever that don't fully solve
the problem" view and any ideas and perhaps a little more detail
on where we might go with this would be very much appreciated.

> 
> And as this conversation seems to just going in circles, I think this
> is
> going to be my last response to it...

Which is why I'm asking this, I really would like to see this
discussion change course and become useful.

Ian

