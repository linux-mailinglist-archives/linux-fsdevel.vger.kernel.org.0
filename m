Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491F523B9B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgHDLjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 07:39:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55241 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgHDLjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:39:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB1925804D6;
        Tue,  4 Aug 2020 07:39:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 07:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        GQ35A9QLvt3V3tS5rPqimLchSew/FSuuzCyzXhgfQ1A=; b=kgmfeQ16/whTJorz
        oDXKB2tNiHs4zASSvo8rupSnw6le9xoRXka0xaj7eV1wl3KlXxBhK9jvlsTpW2I5
        xsqmOgAxEZ04mc47DOuGlA4WLwH8ReSGT3CX0oWl0cPaE9WRB0c2N5PNFPwImKjp
        UzO2vax/wxc0UYA6hmwLJxwZrqt5pa4iUidvhF6dqCQK426CwvYxw555f30uYIvR
        5H59ywR/VBrOYplxFR96RIqaR1p3Kpveny5vknoRtvERGVbcu6gcbZSXfoNGICLf
        JSUc+2qau2R1fVjOXNFZ5Wse4yAxvWD38Gjvifzg2oiXG9T4x8N2VfojR17r6pCH
        aNJubw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GQ35A9QLvt3V3tS5rPqimLchSew/FSuuzCyzXhgfQ
        1A=; b=SuTtTF54ZVjtLRGZxW/mCEyxi8WJ79N7TT0VougsywuI0KnekAV1lIaze
        Mx1dJTOV5LinaEM9B5OTBio4cyf+3MoG0+iQnJj+ueVaURezbQgrwYwqk/kjPkNc
        YqS8C6ENPzYQ3Ym50YC0gOcx/LETOp+69CC//o2YoAMmr/E+f7i4ojaapVtSI6SH
        Zp93f+pg0914IfG1V/AgFvOs8e+RYREM3C/TI0SzgWmbOTDPR/4l1Z1h+n1qUu22
        5ui/Ha//jDx8ms2B66MAeki0JL+UEbsOPON1qFpCa8eHEiYGFzONdv+6DCO1m6y7
        zvN+SH0dYq0xvo4S75gUgveK5q8yg==
X-ME-Sender: <xms:3EgpX400z3VYmHzvXLn-oWTZ1iL2u1k5Etyw-8b3mvwLK_HyCvjXew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrdegjedrudeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:3EgpXzEqYlIuPLrgIGwJdakWHmizB75srQO8z2eYXH5NDgNKEgOzmA>
    <xmx:3EgpXw5VQKDqee8BLKXJOzLC_HOH9vQlxbfxh6OuHS9C1VUnONq_OA>
    <xmx:3EgpXx03mtl9O9w5GDGW8D_W8prLa__CUW0Sw40CfzWxL_07Mloh9Q>
    <xmx:3UgpX6cESCXEwV8tzUkYv1s_c-6OOit-Sn19G8ePNtnYk8yaV_5zcw>
Received: from mickey.themaw.net (unknown [118.208.47.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id 61C5D30600A6;
        Tue,  4 Aug 2020 07:39:03 -0400 (EDT)
Message-ID: <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 19:38:59 +0800
In-Reply-To: <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 11:29 +0200, Miklos Szeredi wrote:
> On Thu, Jul 23, 2020 at 12:48 PM David Howells <dhowells@redhat.com>
> wrote:
> 
> > > >                 __u32   topology_changes;
> > > >                 __u32   attr_changes;
> > > >                 __u32   aux_topology_changes;
> > > 
> > > Being 32bit this introduces wraparound effects.  Is that really
> > > worth it?
> > 
> > You'd have to make 2 billion changes without whoever's monitoring
> > getting a
> > chance to update their counters.  But maybe it's not worth it
> > putting them
> > here.  If you'd prefer, I can make the counters all 64-bit and just
> > retrieve
> > them with fsinfo().
> 
> Yes, I think that would be preferable.

I think this is the source of the recommendation for removing the
change counters from the notification message, correct?

While it looks like I may not need those counters for systemd message
buffer overflow handling myself I think removing them from the
notification message isn't a sensible thing to do.

If you need to detect missing messages, perhaps due to message buffer
overflow, then you need change counters that are relevant to the
notification message itself. That's so the next time you get a message
for that object you can be sure that change counter comparisons you
you make relate to object notifications you have processed.

Yes, I know it isn't quite that simple, but tallying up what you have
processed in the current batch of messages (or in multiple batches of
messages if more than one read has been possible) to perform the check
is a user space responsibility. And it simply can't be done if the
counters consistency is in question which it would be if you need to
perform another system call to get it.

It's way more useful to have these in the notification than obtainable
via fsinfo() IMHO.

> 
> > > >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true
> > > > indicates that
> > > >         the notifcation was generated by an event (eg. SETATTR)
> > > > that was
> > > >         applied recursively.  The notification is only
> > > > generated for the
> > > >         object that initially triggered it.
> > > 
> > > Unused in this patchset.  Please don't add things to the API
> > > which are not
> > > used.
> > 
> > Christian Brauner has patches for mount_setattr() that will need to
> > use this.
> 
> Fine, then that patch can add the flag.
> 
> Thanks,
> Miklos

