Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F04241FAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgHKS2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 14:28:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbgHKS2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:28:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 12B4B8EE19D;
        Tue, 11 Aug 2020 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597170512;
        bh=3WEnw6QUJlA/ul3OQNUWXjoU13+yLZLQS09srF5MAho=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f8kSFMTUDNJBODH89PuFjILL2FIdhsJg734xkqUR/cnDMS0KoMreMUczSAhnUyPMA
         FTeH0AYqaAUb8S0lZlH/2MKXOBNx4BiGB+ITLubur3uSRnr1jBTuyfUMErztSAvCOK
         o6mPwANArB0pQb+2/z1bhs18+blmHF0lRNFSsct0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zuQo8S5FYJFD; Tue, 11 Aug 2020 11:28:31 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7EF748EE149;
        Tue, 11 Aug 2020 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597170511;
        bh=3WEnw6QUJlA/ul3OQNUWXjoU13+yLZLQS09srF5MAho=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OSDLkaQVZ4KRYf4a0s5X94LSMaapheTMG3B7iv1TDO9dOQ2MOULwugwtLeHe6qdeF
         qJgkWRBhCi9y0UIGoySKjkb+RHhMP2bUFkZ9nJkEdlUyNr1yc428zvmYrJhUC4gJZu
         kZoLKW8vwf99sZFDKUvV19sDo8EBD6kP0uULOtBM=
Message-ID: <1597170509.4325.55.camel@HansenPartnership.com>
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
Date:   Tue, 11 Aug 2020 11:28:29 -0700
In-Reply-To: <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
> Mimi's earlier point is that any IMA metadata format that involves
> unsigned digests is exposed to an alteration attack at rest or in
> transit, thus will not provide a robust end-to-end integrity
> guarantee.

I don't believe that is Mimi's point, because it's mostly not correct:
the xattr mechanism does provide this today.  The point is the
mechanism we use for storing IMA hashes and signatures today is xattrs
because they have robust security properties for local filesystems that
the kernel enforces.  This use goes beyond IMA, selinux labels for
instance use this property as well.

What I think you're saying is that NFS can't provide the robust
security for xattrs we've been relying on, so you need some other
mechanism for storing them.

I think Mimi's other point is actually that IMA uses a flat hash which
we derive by reading the entire file and then watching for mutations. 
Since you cannot guarantee we get notice of mutation with NFS, the
entire IMA mechanism can't really be applied in its current form and we
have to resort to chunk at a time verifications that a Merkel tree
would provide.  Doesn't this make moot any thinking about
standardisation in NFS for the current IMA flat hash mechanism because
we simply can't use it ... If I were to construct a prototype I'd have
to work out and securely cache the hash of ever chunk when verifying
the flat hash so I could recheck on every chunk read.  I think that's
infeasible for large files.

James

