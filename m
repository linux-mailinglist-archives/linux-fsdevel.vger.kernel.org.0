Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B6242C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHLPmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:42:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56520 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgHLPmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:42:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7E6238EE1DD;
        Wed, 12 Aug 2020 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597246949;
        bh=UjcYuUcmKYlnECOJFMR+GyD6MJoGsB5ezQg+t/+kKdI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xLII+0kf/CLesZ7RqkPnkP+Fi4qQBxjTcyKa3nw9i0v76X4wMu6tIwBu45r/cU0W7
         1Beb11EPHhciApYzYgOQ6sEj99EQbPGD3oV61R8/MQXG7oUlYQDHk/eZqy7KQ55Fy0
         AF4BvQON0u+g5WlLRCFyFqSz4f1mzP57IVdksLgM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AHFsU6pG-8oB; Wed, 12 Aug 2020 08:42:29 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 11FF68EE0C7;
        Wed, 12 Aug 2020 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597246949;
        bh=UjcYuUcmKYlnECOJFMR+GyD6MJoGsB5ezQg+t/+kKdI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xLII+0kf/CLesZ7RqkPnkP+Fi4qQBxjTcyKa3nw9i0v76X4wMu6tIwBu45r/cU0W7
         1Beb11EPHhciApYzYgOQ6sEj99EQbPGD3oV61R8/MQXG7oUlYQDHk/eZqy7KQ55Fy0
         AF4BvQON0u+g5WlLRCFyFqSz4f1mzP57IVdksLgM=
Message-ID: <1597246946.7293.9.camel@HansenPartnership.com>
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
Date:   Wed, 12 Aug 2020 08:42:26 -0700
In-Reply-To: <2CA41152-6445-4716-B5EE-2D14E5C59368@gmail.com>
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
         <1597170509.4325.55.camel@HansenPartnership.com>
         <2CA41152-6445-4716-B5EE-2D14E5C59368@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-12 at 09:56 -0400, Chuck Lever wrote:
> > On Aug 11, 2020, at 2:28 PM, James Bottomley <James.Bottomley@Hanse
> > nPartnership.com> wrote:
> > 
> > On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
> > > Mimi's earlier point is that any IMA metadata format that
> > > involves unsigned digests is exposed to an alteration attack at
> > > rest or in transit, thus will not provide a robust end-to-end
> > > integrity guarantee.
> > 
> > I don't believe that is Mimi's point, because it's mostly not
> > correct: the xattr mechanism does provide this today.  The point is
> > the mechanism we use for storing IMA hashes and signatures today is
> > xattrs because they have robust security properties for local
> > filesystems that the kernel enforces.  This use goes beyond IMA,
> > selinux labels for instance use this property as well.
> 
> I don't buy this for a second. If storing a security label in a
> local xattr is so secure, we wouldn't have any need for EVM.

What don't you buy?  Security xattrs can only be updated by local root.
 If you trust local root, the xattr mechanism is fine ... it's the only
one a lot of LSMs use, for instance.  If you don't trust local root or
worry about offline backups, you use EVM.  A thing isn't secure or
insecure, it depends on the threat model.  However, if you don't trust
the NFS server it doesn't matter whether you do or don't trust local
root, you can't believe the contents of the xattr.

> > What I think you're saying is that NFS can't provide the robust
> > security for xattrs we've been relying on, so you need some other
> > mechanism for storing them.
> 
> For NFS, there's a network traversal which is an attack surface.
> 
> A local xattr can be attacked as well: a device or bus malfunction
> can corrupt the content of an xattr, or a privileged user can modify
> it.
> 
> How does that metadata get from the software provider to the end
> user? It's got to go over a network, stored in various ways, some
> of which will not be trusted. To attain an unbroken chain of
> provenance, that metadata has to be signed.
> 
> I don't think the question is the storage mechanism, but rather the
> protection mechanism. Signing the metadata protects it in all of
> these cases.

I think we're saying about the same thing.  For most people the
security mechanism of local xattrs is sufficient.  If you're paranoid,
you don't believe it is and you use EVM.

> > I think Mimi's other point is actually that IMA uses a flat hash
> > which we derive by reading the entire file and then watching for
> > mutations. Since you cannot guarantee we get notice of mutation
> > with NFS, the entire IMA mechanism can't really be applied in its
> > current form and we have to resort to chunk at a time verifications
> > that a Merkel tree would provide.
> 
> I'm not sure what you mean by this. An NFS client relies on
> notification of mutation to maintain the integrity of its cache of
> NFS file content, and it's done that since the 1980s.

Mutation detection is part of the current IMA security model.  If IMA
sees a file mutate it has to be rehashed the next time it passes the
gate.  If we can't trust the NFS server, we can't trust the NFS
mutation notification and we have to have a different mechanism to
check the file.

> In addition to examining a file's mtime and ctime as maintained by
> the NFS server, a client can rely on the file's NFSv4 change
> attribute or an NFSv4 delegation.

And that's secure in the face of a malicious or compromised server?

The bottom line is still, I think we can't use linear hashes with an
open/exec/mmap gate with NFS and we have to move to chunk at a time
verification like that provided by a merkel tree.

James

