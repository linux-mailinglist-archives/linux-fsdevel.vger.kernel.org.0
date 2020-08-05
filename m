Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF123D066
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHETsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:48:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39006 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbgHEQ6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:58:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D79E28EE1DD;
        Wed,  5 Aug 2020 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596639691;
        bh=5KjscTjJ2rT9ybNg+PHjihmjqEcOr8OKbSKYiE1mN1I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B1prvCHaxEOP6CSKSR0sHnRVt+H7uKCtNBlJKR80V92AyV4g/UjhOaObGhccE1cxU
         h67RP5SGz6mKGuFNlGpONxtoRbl7VGSuPWAch2yCZ1IyNcoEJYsxbLlHDD3W5DNw4C
         EiJrjXIJ5VmBGYjtG0XlF6FaVWV2wOa28tr7BgzY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FBfBPUShTYhM; Wed,  5 Aug 2020 08:01:31 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3D9978EE0F8;
        Wed,  5 Aug 2020 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596639691;
        bh=5KjscTjJ2rT9ybNg+PHjihmjqEcOr8OKbSKYiE1mN1I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B1prvCHaxEOP6CSKSR0sHnRVt+H7uKCtNBlJKR80V92AyV4g/UjhOaObGhccE1cxU
         h67RP5SGz6mKGuFNlGpONxtoRbl7VGSuPWAch2yCZ1IyNcoEJYsxbLlHDD3W5DNw4C
         EiJrjXIJ5VmBGYjtG0XlF6FaVWV2wOa28tr7BgzY=
Message-ID: <1596639689.3457.17.camel@HansenPartnership.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc:     snitzer@redhat.com, zohar@linux.ibm.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        corbet@lwn.net, jmorris@namei.org, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, mdsakib@microsoft.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Wed, 05 Aug 2020 08:01:29 -0700
In-Reply-To: <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
         <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
         <20200802143143.GB20261@amd>
         <1596386606.4087.20.camel@HansenPartnership.com>
         <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 09:07 -0700, Deven Bowers wrote:
> On 8/2/2020 9:43 AM, James Bottomley wrote:
> > On Sun, 2020-08-02 at 16:31 +0200, Pavel Machek wrote:
> > > On Sun 2020-08-02 10:03:00, Sasha Levin wrote:
> > > > On Sun, Aug 02, 2020 at 01:55:45PM +0200, Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > > IPE is a Linux Security Module which allows for a
> > > > > > configurable policy to enforce integrity requirements on
> > > > > > the whole system. It attempts to solve the issue of Code
> > > > > > Integrity: that any code being executed (or files being
> > > > > > read), are identical to the version that was built by a
> > > > > > trusted source.
> > > > > 
> > > > > How is that different from security/integrity/ima?
> > > > 
> > > > Maybe if you would have read the cover letter all the way down
> > > > to the 5th paragraph which explains how IPE is different from
> > > > IMA we could avoided this mail exchange...
> > > 
> > > "
> > > IPE differs from other LSMs which provide integrity checking (for
> > > instance, IMA), as it has no dependency on the filesystem
> > > metadata itself.
> > > The attributes that IPE checks are deterministic properties that
> > > exist solely in the kernel. Additionally, IPE provides no
> > > additional mechanisms of verifying these files (e.g. IMA
> > > Signatures) - all of the attributes of verifying files are
> > > existing features within the kernel, such as dm-verity
> > > or fsverity.
> > > "
> > > 
> > > That is not really helpful.
> 
> Perhaps I can explain (and re-word this paragraph) a bit better.
> 
> As James indicates, IPE does try to close the gap of the IMA
> limitation with xattr. I honestly wasn’t familiar with the appended
> signatures, which seems fine.
> 
> Regardless, this isn’t the larger benefit that IPE provides. The
> larger benefit of this is how IPE separates _mechanisms_ (properties)
> to enforce integrity requirements, from _policy_. The LSM provides
> policy, while things like dm-verity provide mechanism.

Colour me confused here, but I thought that's exactly what IMA does. 
The mechanism is the gates and the policy is simply a list of rules
which are applied when a gate is triggered.  The policy necessarily has
to be tailored to the information available at the gate (so the bprm
exec gate knows filesystem things like the inode for instance) but the
whole thing looks very extensible.

> So to speak, IPE acts as the glue for other mechanisms to leverage a
> customizable, system-wide policy to enforce. While this initial
> patchset only onboards dm-verity, there’s also potential for MAC
> labels, fs-verity, authenticated BTRFS, dm-integrity, etc. IPE
> leverages existing systems in the kernel, while IMA uses its own.

Is this about who does the measurement?  I think there's no reason at
all why IMA can't leverage existing measurements, it's just nothing to
leverage existed when it was created.

> Another difference is the general coverage. IMA has some difficulties
> in covering mprotect[1], IPE doesn’t (the MAP_ANONYMOUS indicated by
> Jann in that thread would be denied as the file struct would be null,
> with IPE’s current set of supported mechanisms. mprotect would
> continue to function as expected if you change to PROT_EXEC).

I don't really think a debate over who does what and why is productive
at this stage.  I just note that IMA policy could be updated to deny
MAP_ANONYMOUS, but no-one's asked for that (probably because of the
huge application breakage that would ensue).  The policy is a product
of the use case and the current use case for IMA is working with
existing filesystem semantics.

> > Perhaps the big question is: If we used the existing IMA appended
> > signature for detached signatures (effectively becoming the
> > "properties" referred to in the cover letter) and hooked IMA into
> > device mapper using additional policy terms, would that satisfy all
> > the requirements this new LSM has?
> 
> Well, Mimi, what do you think? Should we integrate all the features
> of IPE into IMA, or do you think they are sufficiently different in
> architecture that it would be worth it to keep the code base in
> separate LSMs?

I'll leave Mimi to answer, but really this is exactly the question that
should have been asked before writing IPE.  However, since we have the
cart before the horse, let me break the above down into two specific
questions.

   1. Could we implement IPE in IMA (as in would extensions to IMA cover
      everything).  I think the answers above indicate this is a "yes".
   2. Should we extend IMA to implement it?  This is really whether from a
      usability standpoint two seperate LSMs would make sense to cover the
      different use cases.  I've got to say the least attractive thing
      about separation is the fact that you now both have a policy parser.
       You've tried to differentiate yours by making it more Kconfig
      based, but policy has a way of becoming user space supplied because
      the distros hate config options, so I think you're going to end up
      with a policy parser very like IMAs.

James

