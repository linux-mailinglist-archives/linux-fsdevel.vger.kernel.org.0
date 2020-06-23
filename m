Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F34204BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgFWICD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 04:02:03 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58103 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731158AbgFWICD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:02:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A37CAB03;
        Tue, 23 Jun 2020 04:02:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jun 2020 04:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        EowhW+kD2yT5LgJGwHwjZQOkf7JqzXlze9AGD4FoS40=; b=gT3KZ5263dC6R2dr
        UiEYOfSZW6jjNjc+v8rkZhLGi59vFIt1g/o6UJfSymkuPWCwQbaKf6e6s1gWLSRU
        MVNB3idfxsvXdGY2M1zLoV8N2qzubXmLrT5jGM4SnzdszNhnXXu2aFeSwaCiFhmS
        Y7WBRmFCsQYAN+mj8Si9NFB8/z3F//jEs3SDtcOLFbEoHoJELiroSA4pQv1CJdhL
        wV041CbO9KxqcAS00jxjoOOyKPUV6HPW38/LKJ2rRj3m1HKNRWu74gG0jP6wehmF
        zhgNG+igO6TcY3KXzrxeevU7UNHbAqGpCA2+p+rZctcvnApFI2RQWNhWSbQ2e1PR
        xnVfzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=EowhW+kD2yT5LgJGwHwjZQOkf7JqzXlze9AGD4FoS
        40=; b=Y6AdPbeIeAXUluTCS2vkHsgTYU/8bKoJ68eLrqtP+H6BIQXE5hbLjvPhT
        Q8DTHKtvJhejCP752REA1JKn4NxKB2E+8OkKXIF6eha4ETp1fOR3pno/18TpexQO
        FgyfS2nZu+lWkcKH/vyNFKQKG9wij3+HKaZ5kgTXmXV/SG1U+28lPJbgXHATGrMr
        XjGS7WlIRhSotL/HqBJZsvI+S42KKe/m7MjIWbz76goH/+iUq8s0793jO+qZbE65
        giovL2FJdbkhs5O5i/RMe4X0ueQo/VF9MFTlm+RCjJzmWDoX31MAqNUewqc1rssT
        3rUhBLEWBZjjesI6usMulgEGILCoA==
X-ME-Sender: <xms:97bxXsToDapd8K6DsArfryRxbAZKPnQq1htdSk_wdUfQRu6Ut7HqDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epfeefteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecu
    kfhppeduudekrddvtdekrdehgedrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:97bxXpxPsru9MB4iusaj8jiXuRaPKpxj4_4cSutpOaePDub9VLHagw>
    <xmx:97bxXp1losG19UPJ_dEiBit1gRXDokK-ledPwEspxwfy8LEGBN61gA>
    <xmx:97bxXgC-D3HBjRGMoMAWcXdSZP0tXNPeHf72ORB7bv3UZeagoAUKCw>
    <xmx:-bbxXjbP-vdSLHZPDsfin_-Drl87Hgr2MumjuachXKmVGANxc8iDOw>
Received: from mickey.themaw.net (unknown [118.208.54.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7928F3280067;
        Tue, 23 Jun 2020 04:01:56 -0400 (EDT)
Message-ID: <e42b81944272dc3b70b0588948f71bc44d15762d.camel@themaw.net>
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
Date:   Tue, 23 Jun 2020 16:01:52 +0800
In-Reply-To: <20200623060236.GA3818201@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
         <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
         <20200622174845.GB13061@mtj.duckdns.org>
         <20200622180306.GA1917323@kroah.com>
         <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
         <20200623060236.GA3818201@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-06-23 at 08:02 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 23, 2020 at 01:09:08PM +0800, Ian Kent wrote:
> > On Mon, 2020-06-22 at 20:03 +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 22, 2020 at 01:48:45PM -0400, Tejun Heo wrote:
> > > > Hello, Ian.
> > > > 
> > > > On Sun, Jun 21, 2020 at 12:55:33PM +0800, Ian Kent wrote:
> > > > > > > They are used for hotplugging and partitioning memory.
> > > > > > > The
> > > > > > > size of
> > > > > > > the
> > > > > > > segments (and thus the number of them) is dictated by the
> > > > > > > underlying
> > > > > > > hardware.
> > > > > > 
> > > > > > This sounds so bad. There gotta be a better interface for
> > > > > > that,
> > > > > > right?
> > > > > 
> > > > > I'm still struggling a bit to grasp what your getting at but
> > > > > ...
> > > > 
> > > > I was more trying to say that the sysfs device interface with
> > > > per-
> > > > object
> > > > directory isn't the right interface for this sort of usage at
> > > > all.
> > > > Are these
> > > > even real hardware pieces which can be plugged in and out?
> > > > While
> > > > being a
> > > > discrete piece of hardware isn't a requirement to be a device
> > > > model
> > > > device,
> > > > the whole thing is designed with such use cases on mind. It
> > > > definitely isn't
> > > > the right design for representing six digit number of logical
> > > > entities.
> > > > 
> > > > It should be obvious that representing each consecutive memory
> > > > range with a
> > > > separate directory entry is far from an optimal way of
> > > > representing
> > > > something like this. It's outright silly.
> > > 
> > > I agree.  And again, Ian, you are just "kicking the problem down
> > > the
> > > road" if we accept these patches.  Please fix this up properly so
> > > that
> > > this interface is correctly fixed to not do looney things like
> > > this.
> > 
> > Fine, mitigating this problem isn't the end of the story, and you
> > don't want to do accept a change to mitigate it because that could
> > mean no further discussion on it and no further work toward solving
> > it.
> > 
> > But it seems to me a "proper" solution to this will cross a number
> > of areas so this isn't just "my" problem and, as you point out,
> > it's
> > likely to become increasingly problematic over time.
> > 
> > So what are your ideas and recommendations on how to handle hotplug
> > memory at this granularity for this much RAM (and larger amounts)?
> 
> First off, this is not my platform, and not my problem, so it's funny
> you ask me :)

Sorry, but I don't think it's funny at all.

It's not "my platform" either, I'm just the poor old sole that
took this on because, on the face of it, it's a file system
problem as claimed by others that looked at it and promptly
washed their hands of it.

I don't see how asking for your advice is out of order at all.

> 
> Anyway, as I have said before, my first guesses would be:
> 	- increase the granularity size of the "memory chunks",
> reducing
> 	  the number of devices you create.

Yes, I didn't get that from your initial comments but you've said
it a couple of times recently and I do get it now.

I'll try and find someone appropriate to consult about that and
see where it goes.

> 	- delay creating the devices until way after booting, or do it
> 	  on a totally different path/thread/workqueue/whatever to
> 	  prevent delay at booting

When you first said this it sounded like a ugly workaround to me.
But perhaps it isn't (I'm not really convinced it is TBH), so it's
probably worth trying to follow up on too.

> 
> And then there's always:
> 	- don't create them at all, only only do so if userspace asks
> 	  you to.

At first glance the impression I get from this is that it's an even
uglier work around than delaying it but it might actually the most
sensible way to handle this, as it's been called, silliness.

We do have the inode flag S_AUTOMOUNT that will cause the dcache flag
DCACHE_NEED_AUTOMOUNT to be set on the dentry and that will cause
the dentry op ->d_automount() to be called on access so, from a path
walk perspective, the dentries could just appear when needed.

The question I'd need to answer is do the kernfs nodes exist so
->d_automount() can discover if the node lookup is valid, and I think
the answer might be yes (but we would need to suppress udev
notifications for S_AUTOMOUNT nodes).

The catch will be that this is "not" mounting per-se, so anything
I do would probably be seen as an ugly hack that subverts the VFS
automount support.

If I could find a way to reconcile that I could probably do this.

Al, what say you on this?

> 
> You all have the userspace tools/users for this interface and know it
> best to know what will work for them.  If you don't, then hey, let's
> just delete the whole thing and see who screams :)

Please, no joking, I'm finding it hard enough to cope with this
disappointment as it is, ;)

Ian

