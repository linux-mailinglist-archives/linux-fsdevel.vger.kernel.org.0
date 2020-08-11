Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF2242194
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHKVDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:03:48 -0400
Received: from namei.org ([65.99.196.166]:58742 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgHKVDs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:03:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 07BL3Cw3013028;
        Tue, 11 Aug 2020 21:03:12 GMT
Date:   Wed, 12 Aug 2020 07:03:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Chuck Lever <chucklever@gmail.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
In-Reply-To: <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
Message-ID: <alpine.LRH.2.21.2008120643370.10591@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com> <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm> <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com> <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com> <alpine.LRH.2.21.2008050934060.28225@namei.org> <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com> <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Aug 2020, Chuck Lever wrote:

> My interest is in code integrity enforcement for executables stored
> in NFS files.
> 
> My struggle with IPE is that due to its dependence on dm-verity, it
> does not seem to able to protect content that is stored separately
> from its execution environment and accessed via a file access
> protocol (FUSE, SMB, NFS, etc).

It's not dependent on DM-Verity, that's just one possible integrity 
verification mechanism, and one of two supported in this initial 
version. The other is 'boot_verified' for a verified or otherwise trusted 
rootfs. Future versions will support FS-Verity, at least.

IPE was designed to be extensible in this way, with a strong separation of 
mechanism and policy.

Whatever is implemented for NFS should be able to plug in to IPE pretty 
easily.


-- 
James Morris
<jmorris@namei.org>

