Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586B72D98EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439456AbgLNNbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 08:31:33 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39059 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439357AbgLNNbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:31:20 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3333A5804FD;
        Mon, 14 Dec 2020 08:30:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 14 Dec 2020 08:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        TJmkM4jF4LL5/+kspmbrSwMYJtpXZf5QP3Byw4FqUjk=; b=efNUPekA2cyH/Xhz
        hofdMYtC+KJg/KI0OiNFAyr7gNMbCh/+ePc161Xunn7h5qqSk0iZHbNy7fKSZUi7
        1h0uUNmjbUy4ZAYCgIbAYmisnzbcexvbZ0vgXzWeZOGsDHtyZAdPXDPeqT/EC8Yk
        jr52677EaMbD2gb/o//+Q6liNC0il/2fXDgVGJ2AtaMxgz1kYAfaPCFekAR2kWef
        e4g92Oec9aG+cnFwKqElB5di1YNxRtyd0EoFmHxhsS0e0yxAq4LKFWqu/4tmQ63/
        vUsHeHhpbf98dtt6nA7saCG6HKT1Hle6y3ZyFCh9GONUMZK5/CXOYcm8worTVuvj
        mZRkgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=TJmkM4jF4LL5/+kspmbrSwMYJtpXZf5QP3Byw4FqU
        jk=; b=SoA76dWfxMXRsgTURtn3D4a4cb7NEHsfVMI1d/Be/utAc6dapZr2HAET8
        j3EMkaOwtF4JutFGudLHnNkM0zIzFNw2oyy41Z8KJ1FdRrvP4rjHhOWYLfVAQqlW
        UuPuaxJHA/F0zQReUjqGcMaSSdyRo0F8ih7/9SVr9V2L1t4zYm7odBJNG7UGWeZ8
        7GU0xlQeC5BxC8Roult6SN4c17twUDm/bir7LCfKVf5ntY5Cfhu4aJnwEFb927Do
        TodCSv6lFHo1PlOkXKK1HVpyhfBW4715X7iDT556PG1pG1R4YZJGxzOVWBDVGnQ3
        8Htg+twqrKgt/fbMNcW65jvZzxx9Q==
X-ME-Sender: <xms:8mjXXyX77k7J6-bMaeKlrrOhQhNCYASNUjZllj0qyLXtozrcASnBJQ>
    <xme:8mjXX4PfFMm4kv3-w7DvmPIt4s5QlueZf4NNWY6i62Cl7qTrkabvfDUcGnfdUWZDL
    axCAVAHFLfe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefhedrudefle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:8mjXX2bUSLenX1xqnzvmtyAt6NNQ7WhhkCFjAlocTA-UnUEdxSmp-w>
    <xmx:8mjXX8obXO8MWlbVxX9JMmnYXij1cgkvpl2FchyUVebkz0sC1RAehw>
    <xmx:8mjXX6bUMV4ognH_qYoDBWAIaxeMlMGKHdDz_ZrvZeSOOG5ZrGZkoA>
    <xmx:9GjXX650zEj1WigEmEcTSoVfxE68jcZyHcYWmwVr3yM0bHg6_NS7fw>
Received: from mickey.themaw.net (unknown [121.44.135.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6AF41080066;
        Mon, 14 Dec 2020 08:30:22 -0500 (EST)
Message-ID: <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, Tejun Heo <tj@kernel.org>,
        viro@zeniv.linux.org.uk
Date:   Mon, 14 Dec 2020 21:30:19 +0800
In-Reply-To: <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
         <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
         <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
         <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net> wrote:
> > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > For the patches, there is a mutex_lock in kn->attr_mutex, as
> > > > > Tejun
> > > > > mentioned here
> > > > > (
> > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > ),
> > > > > maybe a global
> > > > > rwsem for kn->iattr will be better??
> > > > 
> > > > I wasn't sure about that, IIRC a spin lock could be used around
> > > > the
> > > > initial check and checked again at the end which would probably
> > > > have
> > > > been much faster but much less conservative and a bit more ugly
> > > > so
> > > > I just went the conservative path since there was so much
> > > > change
> > > > already.
> > > 
> > > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't
> > > remember
> > > it.
> > > 
> > > Based on what Tejun said it sounds like that needs work.
> > 
> > Those attribute handling patches were meant to allow taking the rw
> > sem read lock instead of the write lock for kernfs_refresh_inode()
> > updates, with the added locking to protect the inode attributes
> > update since it's called from the VFS both with and without the
> > inode lock.
> 
> Oh, understood. I was asking also because lock on kn->attr_mutex
> drags
> concurrent performance.
> 
> > Looking around it looks like kernfs_iattrs() is called from
> > multiple
> > places without a node database lock at all.
> > 
> > I'm thinking that, to keep my proposed change straight forward
> > and on topic, I should just leave kernfs_refresh_inode() taking
> > the node db write lock for now and consider the attributes handling
> > as a separate change. Once that's done we could reconsider what's
> > needed to use the node db read lock in kernfs_refresh_inode().
> 
> You meant taking write lock of kernfs_rwsem for
> kernfs_refresh_inode()??
> It may be a lot slower in my benchmark, let me test it.

Yes, but make sure the write lock of kernfs_rwsem is being taken
not the read lock.

That's a mistake I had initially?

Still, that attributes handling is, I think, sufficient to warrant
a separate change since it looks like it might need work, the kernfs
node db probably should be kept stable for those attribute updates
but equally the existence of an instantiated dentry might mitigate
the it.

Some people might just know whether it's ok or not but I would like
to check the callers to work out what's going on.

In any case it's academic if GCH isn't willing to consider the series
for review and possible merge.

Ian

