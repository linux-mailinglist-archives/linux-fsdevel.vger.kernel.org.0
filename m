Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D723C395
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHECqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:46:15 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35801 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgHECqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:46:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id E28E67A0;
        Tue,  4 Aug 2020 22:46:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 22:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        IvuYjKO9pN6K+vAWRqibzIqM3OYU4+K+s3T9Dk3ouIw=; b=vlM5EUwQ/x4UJ7E8
        YhXZ1kPKw2NUQ42oCMDwCd2H/E4euiu1P6vLO/niY/fETbXRFv825WU5PeIOrDnQ
        OhgKrQmi3itObSKr+yrGAUkRjAklhk7eOyjUJzqDxj0pXNS5DQn+zMMNHNhPAabw
        ZBakQztcAhAItSsZW+YmJ/XOBNZUTNwvAU1A4kvSVGtO7Ss7ITkn+/AnQ/9CeKnT
        LmEYYnSfuRzM0oaZqozKwZ9++GtAYj20gdp9bQyRcv8Nj/Y7PLyawcr4iY3pif3O
        nh/tby7f3Qneizm9SvKKCSYyfwmiVT8BedLoRIRIPVy6KK9IkHzUjLzZ4kVFvSC5
        Ba0KnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=IvuYjKO9pN6K+vAWRqibzIqM3OYU4+K+s3T9Dk3ou
        Iw=; b=MVUmKnJOSbu7/gD/q8HCdCRczqaTofFTAlP43Ct1aS5op7QYW+1wXe8gn
        RvWRDeha4WPVRqJte36BxgXm3b8Zp3U6t4Z6RSWQzgd0ME5CA+pwZKhagBXtc1r3
        HYxKo2U6V5u8FFvtYd4gg/5x2H1fH4kkaXh6SJBRFqLWL1WZ3gqaS8J0QwHsY+M+
        wDhQt0ZxrgcalFW6KZPf1Slm54lXYvMVFMPz4Z8DTjgKqN19JqQ2w+W/xZ4+54z7
        9Ge60+Yk6aVaDF9KUukztyXsdOhigxTahRLJZA2d6Fc/6MVjp1Jp/OFjOPwjOgqp
        qF565/31vWAPBxT/XWyHVQFqm+DLQ==
X-ME-Sender: <xms:cx0qX5PFVUVHJpiteDyg-Cg3vScQq7_xhMSDQZJuR0LFEWgum5hceA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeejgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:cx0qX79NgXqC3EAzu4qfJdZsGrXNvqKjt0np5riXE8UOhEgFHw7MFA>
    <xmx:cx0qX4QMXJoBvyzqg0XBduTNwHazfsyLOsHneqSgPwxIpzoxaW8sFQ>
    <xmx:cx0qX1tYA7Oj487kuUZ69qWZklkAsYSYqV5XWE77jA9DpjrsPYq4FQ>
    <xmx:dB0qX95F28B-p_RjsFRrLz3o9ANfcmd3bJDiNGriQ-9SOf-rSZv_SeHABD4>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FD983280060;
        Tue,  4 Aug 2020 22:46:06 -0400 (EDT)
Message-ID: <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 10:46:02 +0800
In-Reply-To: <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
         <20200804135641.GE32719@miu.piliscsaba.redhat.com>
         <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 10:05 +0800, Ian Kent wrote:
> On Tue, 2020-08-04 at 15:56 +0200, Miklos Szeredi wrote:
> > On Mon, Aug 03, 2020 at 02:37:50PM +0100, David Howells wrote:
> > > Provide support for the handling of an overrun in a watch
> > > queue.  In the
> > > event that an overrun occurs, the watcher needs to be able to
> > > find
> > > out what
> > > it was that they missed.  To this end, previous patches added
> > > event
> > > counters to struct mount.
> > 
> > So this is optimizing the buffer overrun case?
> > 
> > Shoun't we just make sure that the likelyhood of overruns is low
> > and
> > if it
> > happens, just reinitialize everthing from scratch (shouldn't be
> > *that*
> > expensive).
> 
> But maybe not possible if you are using notifications for tracking
> state in user space, you need to know when the thing you have needs
> to be synced because you missed something and it's during the
> notification processing you actually have the object that may need
> to be refreshed.
> 
> > Trying to find out what was missed seems like just adding
> > complexity
> > for no good
> > reason.

Coming back to an actual use case.

What I said above is one aspect but, since I'm looking at this right
now with systemd, and I do have the legacy code to fall back to, the
"just reset everything" suggestion does make sense.

But I'm struggling to see how I can identify notification buffer
overrun in libmount, and overrun is just one possibility for lost
notifications, so I like the idea that, as a library user, I can
work out that I need to take action based on what I have in the
notifications themselves.

Ian

