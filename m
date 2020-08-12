Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC3242C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLPv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:51:26 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56702 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgHLPvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:51:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 72FB68EE1E5;
        Wed, 12 Aug 2020 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597247484;
        bh=+M44FI+gFzjgWGz17wPIjNuU1mPjCW1F5/zFjc3Nc88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ScQOuqd3qNMM6ORoKcpNR3RYVK6vnRaBwQEeiRVrrvTPdjgJmH3DffLpjUmfS5SzE
         3nIwiQOeQf0V7ZUjoRF2xP65+evu6LLpNfrqKqWkQEPLubR5SFc9CgF/WyDTuOZO8M
         BkIxrthipgyDGerQmnxKF55e8vLiujMSIDgjmSQ8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SMLlUWr0kVGi; Wed, 12 Aug 2020 08:51:24 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 087128EE0C7;
        Wed, 12 Aug 2020 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597247484;
        bh=+M44FI+gFzjgWGz17wPIjNuU1mPjCW1F5/zFjc3Nc88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ScQOuqd3qNMM6ORoKcpNR3RYVK6vnRaBwQEeiRVrrvTPdjgJmH3DffLpjUmfS5SzE
         3nIwiQOeQf0V7ZUjoRF2xP65+evu6LLpNfrqKqWkQEPLubR5SFc9CgF/WyDTuOZO8M
         BkIxrthipgyDGerQmnxKF55e8vLiujMSIDgjmSQ8=
Message-ID: <1597247482.7293.18.camel@HansenPartnership.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
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
Date:   Wed, 12 Aug 2020 08:51:22 -0700
In-Reply-To: <02D551EF-C975-4B91-86CA-356FA0FF515C@gmail.com>
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
         <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
         <1597124623.30793.14.camel@HansenPartnership.com>
         <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
         <1597161218.4325.38.camel@HansenPartnership.com>
         <02D551EF-C975-4B91-86CA-356FA0FF515C@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-12 at 10:15 -0400, Chuck Lever wrote:
> > On Aug 11, 2020, at 11:53 AM, James Bottomley
> > <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
[...]
> > > > 
> > > > and what is nice to have to speed up the verification
> > > > process.  The choice for the latter is cache or reconstruct
> > > > depending on the resources available.  If the tree gets cached
> > > > on the server, that would be a server implementation detail
> > > > invisible to the client.
> > > 
> > > We assume that storage targets (for block or file) are not
> > > trusted. Therefore storage clients cannot rely on intermediate
> > > results (eg, middle nodes in a Merkle tree) unless those results
> > > are generated within the client's trust envelope.
> > 
> > Yes, they can ... because supplied nodes can be verified.  That's
> > the whole point of a merkle tree.  As long as I'm sure of the root
> > hash I can verify all the rest even if supplied by an untrusted
> > source.  If you consider a simple merkle tree covering 4 blocks:
> > 
> >       R
> >     /   \
> >  H11     H12
> >  / \     / \
> > H21 H22 H23 H24
> > >    |   |   |
> > 
> > B1   B2  B3  B4
> > 
> > Assume I have the verified root hash R.  If you supply B3 you also
> > supply H24 and H11 as proof.  I verify by hashing B3 to produce H23
> > then hash H23 and H24 to produce H12 and if H12 and your supplied
> > H11 hash to R the tree is correct and the B3 you supplied must
> > likewise be correct.
> 
> I'm not sure what you are proving here. Obviously this has to work
> in order for a client to reconstruct the file's Merkle tree given
> only R and the file content.

You implied the server can't be trusted to generate the merkel tree. 
I'm showing above it can because of the tree path based verification.

> It's the construction of the tree and verification of the hashes that
> are potentially expensive. The point of caching intermediate hashes
> is so that the client verifies them as few times as possible.  I
> don't see value in caching those hashes on an untrusted server --
> the client will have to reverify them anyway, and there will be no
> savings.

I'm not making any claim about server caching, I'm just saying the
client can request pieces of the tree from the server without having to
reconstruct the whole thing itself because it can verify their
correctness.

> Cache once, as close as you can to where the data will be used.
> 
> 
> > > So: if the storage target is considered inside the client's trust
> > > envelope, it can cache or store durably any intermediate parts of
> > > the verification process. If not, the network and file storage is
> > > considered untrusted, and the client has to rely on nothing but
> > > the signed digest of the tree root.
> > > 
> > > We could build a scheme around, say, fscache, that might save the
> > > intermediate results durably and locally.
> > 
> > I agree we want caching on the client, but we can always page in
> > from the remote as long as we page enough to verify up to R, so
> > we're always sure the remote supplied genuine information.
> 
> Agreed.
> 
> 
> > > > > For this reason, the idea was to save only the signature of
> > > > > the tree's root on durable storage. The client would retrieve
> > > > > that signature possibly at open time, and reconstruct the
> > > > > tree at that time.
> > > > 
> > > > Right that's the integrity data you must have.
> > > > 
> > > > > Or the tree could be partially constructed on-demand at the
> > > > > time each unit is to be checked (say, as part of 2. above).
> > > > 
> > > > Whether it's reconstructed or cached can be an implementation
> > > > detail. You clearly have to reconstruct once, but whether you
> > > > have to do it again depends on the memory available for caching
> > > > and all the other resource calls in the system.
> > > > 
> > > > > The client would have to reconstruct that tree again if
> > > > > memory pressure caused some or all of the tree to be evicted,
> > > > > so perhaps an on-demand mechanism is preferable.
> > > > 
> > > > Right, but I think that's implementation detail.  Probably what
> > > > we need is a way to get the log(N) verification hashes from the
> > > > server and it's up to the client whether it caches them or not.
> > > 
> > > Agreed, these are implementation details. But see above about the
> > > trustworthiness of the intermediate hashes. If they are conveyed
> > > on an untrusted network, then they can't be trusted either.
> > 
> > Yes, they can, provided enough of them are asked for to verify.  If
> > you look at the simple example above, suppose I have cached H11 and
> > H12, but I've lost the entire H2X layer.  I want to verify B3 so I
> > also ask you for your copy of H24.  Then I generate H23 from B3 and
> > Hash H23 and H24.  If this doesn't hash to H12 I know either you
> > supplied me the wrong block or lied about H24.  However, if it all
> > hashes correctly I know you supplied me with both the correct B3
> > and the correct H24.
> 
> My point is there is a difference between a trusted cache and an
> untrusted cache. I argue there is not much value in a cache where
> the hashes have to be verified again.

And my point isn't about caching, it's about where the tree comes from.
 I claim and you agree the client can get the tree from the server a
piece at a time (because it can path verify it) and doesn't have to
generate it itself.  How much of the tree the client has to store and
whether the server caches, reads it in from somewhere or reconstructs
it is an implementation detail.

James

