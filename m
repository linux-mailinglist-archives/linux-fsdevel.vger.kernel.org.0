Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A02409C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgHJPfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:35:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55864 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728752AbgHJPfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:35:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E27C78EE1DD;
        Mon, 10 Aug 2020 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597073741;
        bh=H6RkvIzpfXOLSmHTbzR8XGbmPVN5aMmAbFV+0MS/vCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cVt1iMuKWH4Bg+bLnyRSpUB/wXbG1V4IcQrDFdM+He/KopgifO7HNehQkYRafWpR7
         B7RZHTNO5ffSnIB2urr4t5jxmwSfl4SQgYlbRQkBhgcHt8qoHLUYBwA7Q6vT3o6/tt
         pW81Sr83Alr3AG3vWPtlKAQ4u+snVOqOmdggu00Q=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NaS3pjwBelNS; Mon, 10 Aug 2020 08:35:40 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 490FA8EE12E;
        Mon, 10 Aug 2020 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597073740;
        bh=H6RkvIzpfXOLSmHTbzR8XGbmPVN5aMmAbFV+0MS/vCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MjwJxpgTQz4M0HQgOVHVrw7HDPZ5iwScXAZ3T0CV5ey1CM8n8Q+96pCZP7NtESu7J
         Aa755rKZNaN6eMUTRHzcTFugAubBvvES0Y0Tz+SDho/oQczzL4HdAtuVcZFPuzBhG3
         6CMTxxSQ5umiDNicSAXPubohnY0HnMFKrU59s060=
Message-ID: <1597073737.3966.12.camel@HansenPartnership.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Chuck Lever <chucklever@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Mon, 10 Aug 2020 08:35:37 -0700
In-Reply-To: <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
         <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
         <20200802143143.GB20261@amd>
         <1596386606.4087.20.camel@HansenPartnership.com>
         <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
         <1596639689.3457.17.camel@HansenPartnership.com>
         <alpine.LRH.2.21.2008050934060.28225@namei.org>
         <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
         <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
         <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-08-09 at 13:16 -0400, Mimi Zohar wrote:
> On Sat, 2020-08-08 at 13:47 -0400, Chuck Lever wrote:
> > > On Aug 5, 2020, at 2:15 PM, Mimi Zohar <zohar@linux.ibm.com>
> > > wrote:
> 
> <snip>
> 
> > > If block layer integrity was enough, there wouldn't have been a
> > > need for fs-verity.   Even fs-verity is limited to read only
> > > filesystems, which makes validating file integrity so much
> > > easier.  From the beginning, we've said that fs-verity signatures
> > > should be included in the measurement list.  (I thought someone
> > > signed on to add that support to IMA, but have not yet seen
> > > anything.)
> > 
> > Mimi, when you and I discussed this during LSS NA 2019, I didn't
> > fully understand that you expected me to implement signed Merkle
> > trees for all filesystems. At the time, it sounded to me like you
> > wanted signed Merkle trees only for NFS files. Is that still the
> > case?
> 
> I definitely do not expect you to support signed Merkle trees for all
> filesystems.  My interested is from an IMA perspective of measuring
> and verifying the fs-verity Merkle tree root (and header info)
> signature. This is independent of which filesystems support it.
> 
> > 
> > The first priority (for me, anyway) therefore is getting the
> > ability to move IMA metadata between NFS clients and servers
> > shoveled into the NFS protocol, but that's been blocked for various
> > legal reasons.
> 
> Up to now, verifying remote filesystem file integrity has been out of
> scope for IMA.   With fs-verity file signatures I can at least grasp
> how remote file integrity could possibly work.  I don't understand
> how remote file integrity with existing IMA formats could be
> supported. You might want to consider writing a whitepaper, which
> could later be used as the basis for a patch set cover letter.

I think, before this, we can help with the basics (and perhaps we
should sort them out before we start documenting what we'll do).  The
first basic is that a merkle tree allows unit at a time verification. 
First of all we should agree on the unit.  Since we always fault a page
at a time, I think our merkle tree unit should be a page not a block. 
Next, we should agree where the check gates for the per page accesses
should be ... definitely somewhere in readpage, I suspect and finally
we should agree how the merkle tree is presented at the gate.  I think
there are three ways:

   1. Ahead of time transfer:  The merkle tree is transferred and verified
      at some time before the accesses begin, so we already have a
      verified copy and can compare against the lower leaf.
   2. Async transfer:  We provide an async mechanism to transfer the
      necessary components, so when presented with a unit, we check the
      log n components required to get to the root
   3. The protocol actually provides the capability of 2 (like the SCSI
      DIF/DIX), so to IMA all the pieces get presented instead of IMA
      having to manage the tree

There are also a load of minor things like how we get the head hash,
which must be presented and verified ahead of time for each of the
above 3.

James



