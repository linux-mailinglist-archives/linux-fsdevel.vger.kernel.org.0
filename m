Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89B123F861
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHHRrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 13:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHHRrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:47:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A52C061756;
        Sat,  8 Aug 2020 10:47:52 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l15so4411118ils.2;
        Sat, 08 Aug 2020 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iAERPz4z58eGuOuIGzzCzTvYKP+G7EsrZYPNaIwIkBM=;
        b=P0gAuPQ47Tu14WAl0b/RnZ8e7XM1gkyf7C4ycQ3E8cmslLdc3NaUeP+dXiFtRrz/tw
         prwwEJtevGzqTEWjf4vI39cXT2gtu7vDdjMmD64XXE61xen1gO/P5uzWTUhsAYhvnSSH
         n3VQ0DabWJifz+ldMjW0lSq9ZP7B56sv1BSPTOTqvRHDneZGtU4fqqANw/9Hc8nMezRz
         w5CcLd112m/n6WBgMMnOMghbhEJ3l3E3gzRyt4m1SScrD5JBzjr0kJSzFwL+2zpvvtDq
         72oVdPWv6C75Eh8Q2xRKLhI0Dpazk07OGYNqNyCXwDvP5wzs9vQ+S/i/hMEdXoe0YLIc
         NHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iAERPz4z58eGuOuIGzzCzTvYKP+G7EsrZYPNaIwIkBM=;
        b=CUeZ3VAaMX0JH67jIK++diZ/CFgXwPEcQnJx60WCrV6YDFJOpc58hg1OAT6mLiz/Hv
         Somi3yWm7XzWqwlhtHOXIi0asdNUO2dx+akfoZVBIXmP4FThykLrQfgDMzGABnDn3Px7
         2kW1lfYnFHSThlnTjnY19likAGl9g9aOYMnnBDGYheyMvWRvYft5U7yQBPOuQMHYUGXQ
         CBO/10QrrJgHXb8pQRlq41mLGjrMWbww4rgYt14lx+PD+emp/iM2pig30zdooD0v1KQV
         4I0a/UfdosF/mKezys1p9TIlJo3zhL6KP+EzOUMPaDx70saGzmdC2chpUBZFIEv6TaUc
         arkQ==
X-Gm-Message-State: AOAM5309rAX1LMfzvCL10ZOkD2hdyoIpLcnybcNUZomxtw7PvXXgtvnt
        233hA24mWOkKzyu6pTQUEac=
X-Google-Smtp-Source: ABdhPJydDmiI01T5SSyOAkJmMCCoQ+jGkp7ojV9L+HpzqptYX/IPDvH/2YIt/u9cOo0zm++buEz1sw==
X-Received: by 2002:a92:340d:: with SMTP id b13mr10699165ila.78.1596908871622;
        Sat, 08 Aug 2020 10:47:51 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o74sm1908900ilb.40.2020.08.08.10.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 10:47:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
Date:   Sat, 8 Aug 2020 13:47:48 -0400
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 5, 2020, at 2:15 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2020-08-05 at 09:59 -0700, James Morris wrote:
>> On Wed, 5 Aug 2020, James Bottomley wrote:
>>=20
>>> I'll leave Mimi to answer, but really this is exactly the question =
that
>>> should have been asked before writing IPE.  However, since we have =
the
>>> cart before the horse, let me break the above down into two specific
>>> questions.
>>=20
>> The question is valid and it was asked. We decided to first prototype =
what=20
>> we needed and then evaluate if it should be integrated with IMA. We=20=

>> discussed this plan in person with Mimi (at LSS-NA in 2019), and =
presented=20
>> a more mature version of IPE to LSS-NA in 2020, with the expectation =
that=20
>> such a discussion may come up (it did not).
>=20
> When we first spoke the concepts weren't fully formulated, at least to
> me.
>>=20
>> These patches are still part of this process and 'RFC' status.
>>=20
>>>   1. Could we implement IPE in IMA (as in would extensions to IMA =
cover
>>>      everything).  I think the answers above indicate this is a =
"yes".
>>=20
>> It could be done, if needed.
>>=20
>>>   2. Should we extend IMA to implement it?  This is really whether =
from a
>>>      usability standpoint two seperate LSMs would make sense to =
cover the
>>>      different use cases.
>>=20
>> One issue here is that IMA is fundamentally a measurement & appraisal=20=

>> scheme which has been extended to include integrity enforcement. IPE =
was=20
>> designed from scratch to only perform integrity enforcement. As such, =
it=20
>> is a cleaner design -- "do one thing and do it well" is a good design=20=

>> pattern.
>>=20
>> In our use-case, we utilize _both_ IMA and IPE, for attestation and =
code=20
>> integrity respectively. It is useful to be able to separate these=20
>> concepts. They really are different:
>>=20
>> - Code integrity enforcement ensures that code running locally is of =
known=20
>> provenance and has not been modified prior to execution.

My interest is in code integrity enforcement for executables stored
in NFS files.

My struggle with IPE is that due to its dependence on dm-verity, it
does not seem to able to protect content that is stored separately
from its execution environment and accessed via a file access
protocol (FUSE, SMB, NFS, etc).


>> - Attestation is about measuring the health of a system and having =
that=20
>> measurement validated by a remote system. (Local attestation is =
useless).
>>=20
>> I'm not sure there is value in continuing to shoe-horn both of these =
into=20
>> IMA.
>=20
> True, IMA was originally limited to measurement and attestation, but
> most of the original EVM concepts were subsequently included in IMA.=20=

> (Remember, Reiner Sailer wrote the original IMA, which I inherited.  I
> was originially working on EVM code integrity.)  =46rom a naming
> perspective including EVM code integrity in IMA was a mistake.  My
> thinking at the time was that as IMA was already calculating the file
> hash, instead of re-calculating the file hash for integrity, calculate
> the file hash once and re-use it for multiple things - measurement,=20
> integrity, and audit.   At the same time define a single system wide
> policy.
>=20
> When we first started working on IMA, EVM, trusted, and encrypted =
keys,
> the general kernel community didn't see a need for any of it.  Thus, a
> lot of what was accomplished has been accomplished without the backing
> of the real core filesystem people.
>=20
> If block layer integrity was enough, there wouldn't have been a need
> for fs-verity.   Even fs-verity is limited to read only filesystems,
> which makes validating file integrity so much easier.  =46rom the
> beginning, we've said that fs-verity signatures should be included in
> the measurement list.  (I thought someone signed on to add that =
support
> to IMA, but have not yet seen anything.)

Mimi, when you and I discussed this during LSS NA 2019, I didn't fully
understand that you expected me to implement signed Merkle trees for all
filesystems. At the time, it sounded to me like you wanted signed Merkle
trees only for NFS files. Is that still the case?

The first priority (for me, anyway) therefore is getting the ability to
move IMA metadata between NFS clients and servers shoveled into the NFS
protocol, but that's been blocked for various legal reasons.

IMO we need agreement from everyone (integrity developers, FS
implementers, and Linux distributors) that a signed Merkle tree IMA
metadata format, stored in either an xattr or appended to an executable
file, will be the way forward for IMA in all filesystems.


> Going forward I see a lot of what we've accomplished being =
incorporated
> into the filesystems.  When IMA will be limited to defining a system
> wide policy, I'll have completed my job.
>=20
> Mimi
>=20
>>=20
>>> I've got to say the least attractive thing
>>>      about separation is the fact that you now both have a policy =
parser.
>>>       You've tried to differentiate yours by making it more Kconfig
>>>      based, but policy has a way of becoming user space supplied =
because
>>>      the distros hate config options, so I think you're going to end =
up
>>>      with a policy parser very like IMAs.

