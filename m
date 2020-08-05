Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88E23D293
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHEUOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:14:08 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:36325 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbgHEQX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id E931D95C;
        Wed,  5 Aug 2020 07:23:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Aug 2020 07:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        26J/RpIA9Dzs/j/8HMkMSuIzptW47JbejMg/q+iS3MA=; b=k+tuYhnIwwJqPC4a
        ARmLeCMtIylGfe41ZB2xKZDmYvrKjpecqduRXwP+9BBuVWQgIaFmKGJTo3YJYXAx
        Ypn3UJy81+Nvgtt39qeUW24jGFuqamg9GKZuaAL46pkTIrKEv0spYSGUItue51qM
        BMEYBbtZSz2Afm8rvLkRPQLA3UQu5OFEeZcXaBtC28KAaWyED2HYsD1gD22fjByH
        XaKZUEkNIEy+8yie9mVabtLESGXmRThqMwg8kT3n8Zks1mkufq0xGuTjVWrBZKJy
        t+U0BtxJPwxVTRyKfTgopI4oCy+E+f9Q/YEOlFvgNxyDd/r3mZ38tXZoMCCaxSe8
        BzA7cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=26J/RpIA9Dzs/j/8HMkMSuIzptW47JbejMg/q+iS3
        MA=; b=UlVjy0fzxkWVFYnPUQXHQ3/SyandLHZI25k0hCWN2r2/1tUCxtdEGSYjm
        GXKGrXAJ+D4IS9BdU05Xkvg4CRigWZWia+z/Rs8q9s8R/stmJ+fTTsh3K5yKFOem
        sQyOz2u1x9OepQCiE0ydYQhN55yHJPMCnEtdrWPUXDOEOUk4FPLvn0WPOC9D0Sxy
        93Xdzz7yWniafh0KlABxeImu8+TU6nNiOg1rz2EELtjJ21wVjypuFoLPPVVFFNQz
        hTD2PklgWGLzAxRJZAnJYy8D5VV2qhj/k7v9pPO6mIPWTh7vUkxwxSWcVeSGgrKc
        UmXy8Xn804pK0z1jYUQdrELOQxWwg==
X-ME-Sender: <xms:pZYqXyxcpqQd8fkTI6CfOrrv8tj2qzF8np8tJRa1_efpe0JMgQiGkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:pZYqX-TiKvrEJ-MB-FbK2Btrf7kE1Tw3EkDuTNy2v6yvzsOy2SlEgw>
    <xmx:pZYqX0XLq-Ut0c4cHHkycDFeDRjTfcKY2AARmx6vEU009KfSrHB6bQ>
    <xmx:pZYqX4j2RKFEQXdNPE9IPUWmO_fQ8BMKzSb1-ncgv31k1b-0y7ht3A>
    <xmx:ppYqX0vJJE9yQ9CN4XXM-SnCkV-X0bG9y8hV4wWuiBbvkYky1I3se41MUu4>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40FB530600B4;
        Wed,  5 Aug 2020 07:23:12 -0400 (EDT)
Message-ID: <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 19:23:07 +0800
In-Reply-To: <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
         <20200804135641.GE32719@miu.piliscsaba.redhat.com>
         <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
         <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
         <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 09:45 +0200, Miklos Szeredi wrote:
> On Wed, Aug 5, 2020 at 4:46 AM Ian Kent <raven@themaw.net> wrote:
> > Coming back to an actual use case.
> > 
> > What I said above is one aspect but, since I'm looking at this
> > right
> > now with systemd, and I do have the legacy code to fall back to,
> > the
> > "just reset everything" suggestion does make sense.
> > 
> > But I'm struggling to see how I can identify notification buffer
> > overrun in libmount, and overrun is just one possibility for lost
> > notifications, so I like the idea that, as a library user, I can
> > work out that I need to take action based on what I have in the
> > notifications themselves.
> 
> Hmm, what's the other possibility for lost notifications?

In user space that is:

Multi-threaded application races, single threaded applications and
signal processing races, other bugs ...

For example systemd has it's own event handling sub-system and handles
half a dozen or so event types of which the mount changes are one. It's
fairly complex so I find myself wondering if I can trust it and
wondering if there are undiscovered bugs in it. The answer to the
former is probably yes but the answer to the later is also probably
yes.

Maybe I just paranoid!
Ian


