Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548B22C37D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGXKoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 06:44:15 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:50817 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgGXKoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:44:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id ADCC1734;
        Fri, 24 Jul 2020 06:44:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 Jul 2020 06:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        IMuqW1eWzjwrdDQGfj1YeCfnnLSlRPZHrKpHRGXycSw=; b=SkiyG8rGyUhOHAi+
        Xm//2tMphHh+kJKydj+txJBwL4Xx4H/yQ2qcqHgrMGdmCF8OKvcuuFIh37S1fkpb
        OI5LAzXDcejvcHWBz+/jE/GAQPcidrNhLCSHaAneN0sH2ef4f7T/ofyW9z1bUyRs
        jUPU5TjEE3dzAr/xK027OCDsADyuyqPoAUi0iCfy0xCv2jhe3mjyyNBQNxpQYqxY
        Sdu3Z5+1fME1nqb6Eqmzmuxf29yLE35xkZoybiLjX6Ib6fCdmz8Ybf3NMdvOsGOX
        1g5AHa4jiGKu/4cbvyEQ++XCX6XBQhuYc+rVsaPF16SGs69SWbi7jCEF5GlSS3Id
        srb5gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=IMuqW1eWzjwrdDQGfj1YeCfnnLSlRPZHrKpHRGXyc
        Sw=; b=DDKQ+KvlQlo1JLHV147fAh+wsfencJqlBsZt5ED5qpR2KU7E+GHrantXi
        5q8oHCait0ejOx7vEW6ZxKW0DqL3qU75nAhFZRcA2A99pcYF7ZwssD6KmDXIdryP
        MgCp/946byGHEtBLH2BURuzRJRmWvHnbC1/uGOv3s2ZtgPx1G2PJ7JU7EvKIRf31
        zxHh7b23ST9YUE+LfaY2c6GHp+/E1+bxDUO7zldoMYpKoCY/7qpYF3Gpol1y9JBa
        R6FsEo2TRLR6XfJva4DI84F+41QsCCwhcJLb+9/qIkwS7qoq4XRWvPNLoQ/eczS+
        k0RKkN/QwevkU7fc/yYNlmLCq8lhA==
X-ME-Sender: <xms:e7saX7v0R24W6tUJl9QwLRkPhmxJnuTRVw78y3JEF2kuPgbcFDLBNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrdefjedrudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:e7saX8dR3ahPXrIh2ZUwzLIpYYi6Iww7dkdVSmkkRE3xsOzOMdrd0A>
    <xmx:e7saX-zziKrlrzNbaMPdaXHXmXrAmesr7bz-kh1BEqhuuiMBh8V6_g>
    <xmx:e7saX6NP6XGzlKHCPqrt1U8geJy_d65Yscm_M2ljftYzd6-JhcLGAA>
    <xmx:fLsaX-Ue6A6fyJ4dG0lCmiVmCGISLUFHB12aIsjKL7-VALdMazX7uL5bO1w>
Received: from mickey.themaw.net (unknown [118.208.37.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8F2E3280065;
        Fri, 24 Jul 2020 06:44:05 -0400 (EDT)
Message-ID: <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 18:44:01 +0800
In-Reply-To: <2003787.1595585999@warthog.procyon.org.uk>
References: <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <2003787.1595585999@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-07-24 at 11:19 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > > What guarantees that mount_id is going to remain a 32bit entity?
> > 
> > You think it likely we'd have >4 billion concurrent mounts on a
> > system?  That
> > would require >1.2TiB of RAM just for the struct mount allocations.
> > 
> > But I can expand it to __u64.
> 
> That said, sys_name_to_handle_at() assumes it's a 32-bit signed
> integer, so
> we're currently limited to ~2 billion concurrent mounts:-/

I was wondering about id re-use.

Assuming that ids that are returned to the idr db are re-used
what would the chance that a recently used id would end up
being used?

Would that chance increase as ids are consumed and freed over
time?

Yeah, it's one of those questions ... ;)

Ian

