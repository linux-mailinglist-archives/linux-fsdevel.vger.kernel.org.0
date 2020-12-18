Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2107D2DDF2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 08:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgLRHhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 02:37:18 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:33841 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgLRHhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:37:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 06202731;
        Fri, 18 Dec 2020 02:36:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 18 Dec 2020 02:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        oNrnppqXVyZZsnrfC7QvF2z0b2HE7/tpZAOWIxhjw+I=; b=0tzapeiGp6R+xdis
        g2xowaqaL9vs1HGYGKLevcIAcron92qMZfJTG8y2cLj6DjBj9FqUWVgxnfERW1G7
        PmatoDi5KfYW8SV9QbSCoHI3j0JvzIfMaDoHJNsxRgqCYG+JKRrx/grtwXW6hhuU
        UZeVhQoec0HQaukAubR7eTayNxipVq7j8YAhBn19bK1F9aQrf7eWHVwJTnDF4ehr
        AaDQhKfEha7hXp+PvcwtVMi8g/o0xgw7DmJ3UWOiPHBBqhTweGpmfEyU0lJ0UkYe
        NRwKLOnO6BZyHwfY2cyEdHaENEGBXK1iqtNHnD/IGLh/el5ITiX2oOxcC7JKSrzU
        tbQ0wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=oNrnppqXVyZZsnrfC7QvF2z0b2HE7/tpZAOWIxhjw
        +I=; b=Q2xUbKQkxnz0xBS76KMJeF1UxTHFZGveGDaUx9pMaipPvRxoNHSqlJT2l
        4qOf2UcbUFDcYQwwcidEYg3aytBF++GX0gcvhypXCO+FhV9srUIg2PgbwJsLxaXi
        bf15yLw8nBkMOcu4S0QoP4vqrw918KLcFT+oelz1u72ZhrlHFR3nv6EHYZIA6pNr
        FQGNpXyyOWknQIhbFMwP8bq8ry/9ilPNanCVJyeHtIFrUUXAJbdaTvXULhwvUc17
        Qtni+gIb7oF89pT5ARzCxjAyceTbaBe2Ow83GUL8j8zOU1j1NTuRokU8owYKhwgL
        RdAZrA6LRdc8ePndjLXoY8GRSN0bQ==
X-ME-Sender: <xms:_VvcX5oCOIdvIOOh0sLJV-MFl-XJm_oKJwkwgW9mG59jJyg0ZOy1zA>
    <xme:_VvcX7qTHR__6-4v-J2cBH3K_azmUZyu5SsYVWmSKipY4pI2ih4jy83i2BEopwPQc
    1pyaPwr-co5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epfeefteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecu
    kfhppedutdeirdeiledrvdegjedrvddtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:_VvcX2NaKUV02b31n2CbwcK9sAihY5xwFseuymWjbjGVrQroOjet5g>
    <xmx:_VvcX07a9wvM9gDYg7qT_HdOdV0PhNWhDbhVWnot9tQNWno08TqErQ>
    <xmx:_VvcX47L1eaqc8cm2YBjKSnFpZC08YVks3DrlO-xZUuJZtWqIGjcBQ>
    <xmx:_1vcX3aAW8QBLm4e4LDxp_Qc420KJOSCL65jODHtJYtvtj89RB_B1naXgLQ>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id D252F108005B;
        Fri, 18 Dec 2020 02:36:25 -0500 (EST)
Message-ID: <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Date:   Fri, 18 Dec 2020 15:36:21 +0800
In-Reply-To: <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
References: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
         <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
         <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
         <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
         <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
         <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
         <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
         <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
         <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
         <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
         <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> Hello,
> 
> On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > What could be done is to make the kernfs node attr_mutex
> > > a pointer and dynamically allocate it but even that is too
> > > costly a size addition to the kernfs node structure as
> > > Tejun has said.
> > 
> > I guess the question to ask is, is there really a need to
> > call kernfs_refresh_inode() from functions that are usually
> > reading/checking functions.
> > 
> > Would it be sufficient to refresh the inode in the write/set
> > operations in (if there's any) places where things like
> > setattr_copy() is not already called?
> > 
> > Perhaps GKH or Tejun could comment on this?
> 
> My memory is a bit hazy but invalidations on reads is how sysfs
> namespace is
> implemented, so I don't think there's an easy around that. The only
> thing I
> can think of is embedding the lock into attrs and doing xchg dance
> when
> attaching it.

Sounds like your saying it would be ok to add a lock to the
attrs structure, am I correct?

Assuming it is then, to keep things simple, use two locks.

One global lock for the allocation and an attrs lock for all the
attrs field updates including the kernfs_refresh_inode() update.

The critical section for the global lock could be reduced and it
changed to a spin lock.

In __kernfs_iattrs() we would have something like:

take the allocation lock
do the allocated checks
  assign if existing attrs
  release the allocation lock
  return existing if found
othewise
  release the allocation lock

allocate and initialize attrs

take the allocation lock
check if someone beat us to it
  free and grab exiting attrs
otherwise
  assign the new attrs
release the allocation lock
return attrs

Add a spinlock to the attrs struct and use it everywhere for
field updates.

Am I on the right track or can you see problems with this?

Ian

