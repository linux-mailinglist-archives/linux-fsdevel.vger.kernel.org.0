Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B3243C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHMPKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:10:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40852 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgHMPKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 31D6D8EE1E5;
        Thu, 13 Aug 2020 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597331419;
        bh=3o0Gk5U5c/tgboU6is0RXdqjpM4d/4IJwBiUFG8jMuA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UXxGSZzb46QTJOqy/JWeOyqw626U8bbIwuEYbPim6fbMyyL04cdp0qwwJKvmyfbNr
         UEM7+n2fjQro3OPR+d/0IwaOPThCF0S2IiZVh8i0RvltCmlgynmf81fQxVjRPrZJrD
         VwN5qGlaATNYTzytjZ828B9lKPRGjJv7sHKFKj4I=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxbPeuibIPjQ; Thu, 13 Aug 2020 08:10:19 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B99EB8EE0F8;
        Thu, 13 Aug 2020 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597331418;
        bh=3o0Gk5U5c/tgboU6is0RXdqjpM4d/4IJwBiUFG8jMuA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=x+VnzAVj+2h2xN4tfyE/FLRLHz0e4JjMHIuRNpMRmGGydOuuD3MXZ92u9QxCCpuy8
         /P6QJ618zgdYz9/h9V2XOl+QoySrm5cdkOm6q1yiNBqMdfPyKCaoZZignH3VT/LZKu
         KlGKtuSb51ELidAyvRI6WiT5Zd7nq6+fKNWHN0PQ=
Message-ID: <1597331416.3708.26.camel@HansenPartnership.com>
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
Date:   Thu, 13 Aug 2020 08:10:16 -0700
In-Reply-To: <D470BA4B-EF1A-49CA-AFB9-0F7FFC4C6001@gmail.com>
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
         <1597247482.7293.18.camel@HansenPartnership.com>
         <D470BA4B-EF1A-49CA-AFB9-0F7FFC4C6001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-08-13 at 10:42 -0400, Chuck Lever wrote:
> > On Aug 12, 2020, at 11:51 AM, James Bottomley <James.Bottomley@Hans
> > enPartnership.com> wrote:
> > On Wed, 2020-08-12 at 10:15 -0400, Chuck Lever wrote:
> > > > On Aug 11, 2020, at 11:53 AM, James Bottomley
> > > > <James.Bottomley@HansenPartnership.com> wrote:
> > > > On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
[...]
> > > > > > > The client would have to reconstruct that tree again if
> > > > > > > memory pressure caused some or all of the tree to be
> > > > > > > evicted, so perhaps an on-demand mechanism is preferable.
> > > > > > 
> > > > > > Right, but I think that's implementation detail.  Probably
> > > > > > what we need is a way to get the log(N) verification hashes
> > > > > > from the server and it's up to the client whether it caches
> > > > > > them or not.
> > > > > 
> > > > > Agreed, these are implementation details. But see above about
> > > > > the trustworthiness of the intermediate hashes. If they are
> > > > > conveyed on an untrusted network, then they can't be trusted
> > > > > either.
> > > > 
> > > > Yes, they can, provided enough of them are asked for to
> > > > verify.  If you look at the simple example above, suppose I
> > > > have cached H11 and H12, but I've lost the entire H2X layer.  I
> > > > want to verify B3 so I also ask you for your copy of H24.  Then
> > > > I generate H23 from B3 and Hash H23 and H24.  If this doesn't
> > > > hash to H12 I know either you supplied me the wrong block or
> > > > lied about H24.  However, if it all hashes correctly I know you
> > > > supplied me with both the correct B3 and the correct H24.
> > > 
> > > My point is there is a difference between a trusted cache and an
> > > untrusted cache. I argue there is not much value in a cache where
> > > the hashes have to be verified again.
> > 
> > And my point isn't about caching, it's about where the tree comes
> > from. I claim and you agree the client can get the tree from the
> > server a piece at a time (because it can path verify it) and
> > doesn't have to generate it itself.
> 
> OK, let's focus on where the tree comes from. It is certainly
> possible to build protocol to exchange parts of a Merkle tree.

Which is what I think we need to extend IMA to do.

>  The question is how it might be stored on the server.

I think the only thing the server has to guarantee to store is the head
hash, possibly signed.

>  There are some underlying assumptions about the metadata storage
> mechanism that should be stated up front.
> 
> Current forms of IMA metadata are limited in size and stored in a
> container that is read and written in a single operation. If we stick
> with that container format, I don't see a way to store a Merkle tree
> in there for all file sizes.

Well, I don't think you need to.  The only thing that needs to be
stored is the head hash.  Everything else can be reconstructed.  If you
asked me to implement it locally, I'd probably put the head hash in an
xattr but use a CAM based cache for the merkel trees and construct the
tree on first access if it weren't already in the cache.

However, the above isn't what fs-verity does: it stores the tree in a
hidden section of the file.  That's why I don't think we'd mandate
anything about tree storage.  Just describe the partial retrieval
properties we'd like and leave the rest as an implementation detail.

> Thus it seems to me that we cannot begin to consider the tree-on-the-
> server model unless there is a proposed storage mechanism for that
> whole tree. Otherwise, the client must have the primary role in
> unpacking and verifying the tree.

Well, as I said,  I don't think you need to store the tree.  You
certainly could decide to store the entire tree (as fs-verity does) if
it fitted your use case, but it's not required.  Perhaps even in my
case I'd make the CAM based cache persistent, like android's dalvik
cache.

James


> Storing only the tree root in the metadata means the metadata format
> is nicely bounded in size.
