Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414BC23D52A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFBrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 21:47:55 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:33477 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHFBry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:47:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id B3836D43;
        Wed,  5 Aug 2020 21:47:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Aug 2020 21:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        U/mBUsHb71A738YQ5oNiB6WYMuEfMjRBkpOFnVl3kck=; b=SbMcZbCujvCFqvMG
        UYR2zXtt8MdtVE6zCyaBbYKHz6/FBXAFbOgKg02VuGsGEVcRNYpNR7qyAsAkcP+i
        x5NTNCq90+2Xo0WQXAcOd87Oknpx4mKWlV4ChRhpu1iPox6Hd31qhdTZXabRGFtd
        Z6mRTpX7sHtoblLP23SoSTczxYxklD1b/JjRWk5ohE3Ljg40DfbsDge0FoByNf6p
        PSX/Db2HUGV1Ynz4jePO0u1Q5CNScjDSUkINwI7dCgCSnz62hu8wAoikK7JH2c0K
        xUXLUx7td3ABBIPyrRcdhcxx3KWThrf7eBDVS+ONxkVJtq2eSwlLE+rxvLiChpjc
        c5or7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=U/mBUsHb71A738YQ5oNiB6WYMuEfMjRBkpOFnVl3k
        ck=; b=GSa5KQgndYXvTiLwV902ReZEGcG6iZqZL2q2MA56f91jcSXIr5+9piJ6r
        HbcMxVP1pb9TmRUIEIQoC4eyFtHQ9LxaXUp2rVhQPv6PvFohFJbklhwl/CRQLS5R
        i3FBLgCNY/xjscE5bqHOva3pBeqx3ANZcUW0EecigD2hqEQMkOBCdMZtiWJmCIy8
        kynUr+f0+E9m0AQ2hoeGCCrEI97PgP8HipKrwbGO0CEJQy/GAPDjqu3PiCXJ9w/l
        bWzXGdv/XCrqbGVt4UmYl91l9tutor6QaMDiMEK1xm4pA7zg9ifooHj1g8mgIPCt
        20HL7XwAzaDWgWJhy9lXE2t15qhpQ==
X-ME-Sender: <xms:R2ErX-Ow0TFcTtDZrZeKOB7EXkGcFyJWbTfpwaJoU1lJLKqSgS_eiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeelgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrdehvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:R2ErX89ebs4xGXj3osgQqYAy76fviH262DcjF9AhUz5dcG_abpUbRQ>
    <xmx:R2ErX1SwYO5T_NvB8DU9zVrp31k0l-VE0UPfdhT8i-mESmigYto58A>
    <xmx:R2ErX-v36Qd5Efi5Q5w8Y-K6ArBRt249ARC-EA4B-pNs2oia7VukoQ>
    <xmx:SGErX27p6Gko2FlPisZFLjpUCL0wiWWZvxt3AzDh2CqzDPeWIkGwgxjfrs8>
Received: from mickey.themaw.net (unknown [118.208.52.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id B32DF328005E;
        Wed,  5 Aug 2020 21:47:46 -0400 (EDT)
Message-ID: <25a6f18404b55e3991ffa0874e6bec78eed7463d.camel@themaw.net>
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
Date:   Thu, 06 Aug 2020 09:47:43 +0800
In-Reply-To: <CAJfpeguvTspY7pi52n1aznebCF2jYki40hy5idkgu1D2y6C6mg@mail.gmail.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
         <20200804135641.GE32719@miu.piliscsaba.redhat.com>
         <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
         <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
         <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
         <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
         <CAJfpeguvTspY7pi52n1aznebCF2jYki40hy5idkgu1D2y6C6mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 13:27 +0200, Miklos Szeredi wrote:
> On Wed, Aug 5, 2020 at 1:23 PM Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2020-08-05 at 09:45 +0200, Miklos Szeredi wrote:
> > > Hmm, what's the other possibility for lost notifications?
> > 
> > In user space that is:
> > 
> > Multi-threaded application races, single threaded applications and
> > signal processing races, other bugs ...
> 
> Okay, let's fix the bugs then.

It's the the bugs you don't know about that get you, in this case
the world "is" actually out to get you, ;)

Ian

