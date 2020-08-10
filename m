Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0C240BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHJRNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 13:13:11 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57290 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgHJRNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:13:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 999ED8EE1C0;
        Mon, 10 Aug 2020 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597079588;
        bh=ZSUuR8ps3gaheFekbtCVfg8z7Gr1pV6yqoiecRqqW8c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iYCWO6Kd4nTdCv5g6xAbDjadaFzWlmhhoNj9TpbEWpJn5ZDHYArz/NgmrHI32upGU
         CkiiHnu0oDclBoXTkOvdoqyhPba3bX4nZInPWPf1ZhwQLcVm9Mct4z4I7990dd4LBS
         pGJMM7XnYmkDK80UUVcaInTgnsKlXcycISGTQ5eg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kjQAlOlinWBO; Mon, 10 Aug 2020 10:13:08 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 22EBE8EE12E;
        Mon, 10 Aug 2020 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597079588;
        bh=ZSUuR8ps3gaheFekbtCVfg8z7Gr1pV6yqoiecRqqW8c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iYCWO6Kd4nTdCv5g6xAbDjadaFzWlmhhoNj9TpbEWpJn5ZDHYArz/NgmrHI32upGU
         CkiiHnu0oDclBoXTkOvdoqyhPba3bX4nZInPWPf1ZhwQLcVm9Mct4z4I7990dd4LBS
         pGJMM7XnYmkDK80UUVcaInTgnsKlXcycISGTQ5eg=
Message-ID: <1597079586.3966.34.camel@HansenPartnership.com>
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
Date:   Mon, 10 Aug 2020 10:13:06 -0700
In-Reply-To: <4664ab7dc3b324084df323bfa4670d5bfde76e66.camel@linux.ibm.com>
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
         <1597073737.3966.12.camel@HansenPartnership.com>
         <4664ab7dc3b324084df323bfa4670d5bfde76e66.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-10 at 12:35 -0400, Mimi Zohar wrote:
> On Mon, 2020-08-10 at 08:35 -0700, James Bottomley wrote:
[...]
> > > Up to now, verifying remote filesystem file integrity has been
> > > out of scope for IMA.   With fs-verity file signatures I can at
> > > least grasp how remote file integrity could possibly work.  I
> > > don't understand how remote file integrity with existing IMA
> > > formats could be supported. You might want to consider writing a
> > > whitepaper, which could later be used as the basis for a patch
> > > set cover letter.
> > 
> > I think, before this, we can help with the basics (and perhaps we
> > should sort them out before we start documenting what we'll do).
> 
> I'm not opposed to doing that, but you're taking this discussion in a
> totally different direction.  The current discussion is about NFSv4
> supporting the existing IMA signatures, not only fs-verity
> signatures. I'd like to understand how that is possible and for the
> community to weigh in on whether it makes sense.

Well, I see the NFS problem as being chunk at a time, right, which is
merkle tree, or is there a different chunk at a time mechanism we want
to use?  IMA currently verifies signature on open/exec and then
controls updates.  Since for NFS we only control the client, we can't
do that on an NFS server, so we really do need verification at read
time ... unless we're threading IMA back to the NFS server?

> > The first basic is that a merkle tree allows unit at a time
> > verification. First of all we should agree on the unit.  Since we
> > always fault a page at a time, I think our merkle tree unit should
> > be a page not a block. Next, we should agree where the check gates
> > for the per page accesses should be ... definitely somewhere in
> > readpage, I suspect and finally we should agree how the merkle tree
> > is presented at the gate.  I think there are three ways:
> > 
> >    1. Ahead of time transfer:  The merkle tree is transferred and
> > verified
> >       at some time before the accesses begin, so we already have a
> >       verified copy and can compare against the lower leaf.
> >    2. Async transfer:  We provide an async mechanism to transfer
> > the
> >       necessary components, so when presented with a unit, we check
> > the
> >       log n components required to get to the root
> >    3. The protocol actually provides the capability of 2 (like the
> > SCSI
> >       DIF/DIX), so to IMA all the pieces get presented instead of
> > IMA
> >       having to manage the tree
> > 
> > There are also a load of minor things like how we get the head
> > hash, which must be presented and verified ahead of time for each
> > of the above 3.
> 
>  
> I was under the impression that IMA support for fs-verity signatures
> would be limited to including the fs-verity signature in the
> measurement list and verifying the fs-verity signature.   As fs-
> verity is limited to immutable files, this could be done on file
> open.  fs-verity would be responsible for enforcing the block/page
> data integrity.   From a local filesystem perspective, I think that
> is all that is necessary.

The fs-verity use case is a bit of a crippled one because it's
immutable.  I think NFS represents more the general case where you
can't rely on immutability and have to verify at chunk read time.  If
we get chunk at a time working for NFS, it should work also for fs-
verity and we wouldn't need to have two special paths.

I think, even for NFS we would only really need to log the open, so
same as you imagine for fs-verity.  As long as the chunk read hashes
match, we can be silent because everything is going OK, so we only need
to determine what to do and log on mismatch (which isn't expected to
happen for fs-verity).

> In terms of remote file systems,  the main issue is transporting and
> storing the Merkle tree.  As fs-verity is limited to immutable files,
> this could still be done on file open.

Right, I mentioned that in my options ... we need some "supply
integrity" hook ... or possibly multiple hooks for a variety of
possible methods.

James

