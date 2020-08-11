Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2155241CB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgHKOtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgHKOtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:49:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C288C06174A;
        Tue, 11 Aug 2020 07:49:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s189so12896151iod.2;
        Tue, 11 Aug 2020 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ssCUdk2zq99A1t5Xbqgx8UHBKHD/0i4VjYZSywQf6Uc=;
        b=tsrEuY3o4X9TS9eNPKmGL8SV9jQR98h1+Qw7n4HhH8F64d2iClm13g94edtSDseXqK
         vtIDlP0enCa4wmIM3Rwdpv21yNiHfhxI1DfGciMMAn0bSfFRbuw0ygS/4kQzKiiGzwND
         0wqPzGc0jeTzOuzlU2UyZ9V0lERy0OpijrmO9qiYAoF15OWpF2nj19E3NGY8gBFvR3kT
         Wt69neh1rDM4ZPd2UDov3+OsgjQ3i4QxXRgh9Dre8XDcopVYcFQxI0RJe6h4RdvLMjSL
         GWpYl/qMY5dr8nHJHpjw2NWHWdLYjPtr8Bw/ZJZVKs20rF0HIfawPCmleG8uDnfCxb9V
         H3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ssCUdk2zq99A1t5Xbqgx8UHBKHD/0i4VjYZSywQf6Uc=;
        b=j6XPy6G+4sMuNKjDr8PH1xo2lvEBzOfYm0mArOoIIBPVaCjKlrNNLZucUQ0sZebF3K
         fjD8D3dE0Be85GqDaCCPBncQZc1AY/E1ZzI3Z+c9vKYpf+n4uOl/GKAbKYzsotrmoYFi
         zfUFnF5cD51lmNhzlTR13/TtwpOSTX9v1WyKRGA30AzU72krAPjKSLL3O1hdxAhToo2a
         aRMfXU/3roR4u8KS0Y/ofg6+VFiqXeNgJvgo0mkq6OfWcBWn1DwGu/QXi2rYfZc0Xh0O
         nbsDobmIBIm8gLaRwfMDA+juHqleCvwgnMKdESBi/z3JTM1IYByE9WiegVXRvr/zlatE
         oY3w==
X-Gm-Message-State: AOAM530LXEfBWooGXODmF4GLwXtnsk0WE13wzFW1E9LDhThkxqlxD8p5
        ZlsQrkC4lMAKQdXvSHLp7eg=
X-Google-Smtp-Source: ABdhPJx9oBpKDQjhGxFTArOcdwz/YcDQe6ebrHQfAhI5awzlneg9cuaJfws7mJgcTr8p8Q++EoRMAA==
X-Received: by 2002:a05:6638:1b5:: with SMTP id b21mr27017984jaq.125.1597157342319;
        Tue, 11 Aug 2020 07:49:02 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x5sm12687773iol.36.2020.08.11.07.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:49:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597124623.30793.14.camel@HansenPartnership.com>
Date:   Tue, 11 Aug 2020 10:48:58 -0400
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
 <1597073737.3966.12.camel@HansenPartnership.com>
 <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
 <1597124623.30793.14.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 1:43 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Mon, 2020-08-10 at 19:36 -0400, Chuck Lever wrote:
>>> On Aug 10, 2020, at 11:35 AM, James Bottomley
>>> <James.Bottomley@HansenPartnership.com> wrote:
>>> On Sun, 2020-08-09 at 13:16 -0400, Mimi Zohar wrote:
>>>> On Sat, 2020-08-08 at 13:47 -0400, Chuck Lever wrote:
> [...]
>>>>> The first priority (for me, anyway) therefore is getting the
>>>>> ability to move IMA metadata between NFS clients and servers
>>>>> shoveled into the NFS protocol, but that's been blocked for
>>>>> various legal reasons.
>>>>=20
>>>> Up to now, verifying remote filesystem file integrity has been
>>>> out of scope for IMA.   With fs-verity file signatures I can at
>>>> least grasp how remote file integrity could possibly work.  I
>>>> don't understand how remote file integrity with existing IMA
>>>> formats could be supported. You might want to consider writing a
>>>> whitepaper, which could later be used as the basis for a patch
>>>> set cover letter.
>>>=20
>>> I think, before this, we can help with the basics (and perhaps we
>>> should sort them out before we start documenting what we'll do).
>>=20
>> Thanks for the help! I just want to emphasize that documentation
>> (eg, a specification) will be critical for remote filesystems.
>>=20
>> If any of this is to be supported by a remote filesystem, then we
>> need an unencumbered description of the new metadata format rather
>> than code. GPL-encumbered formats cannot be contributed to the NFS
>> standard, and are probably difficult for other filesystems that are
>> not Linux-native, like SMB, as well.
>=20
> I don't understand what you mean by GPL encumbered formats.  The GPL =
is
> a code licence not a data or document licence.

IETF contributions occur under a BSD-style license incompatible
with the GPL.

https://trustee.ietf.org/trust-legal-provisions.html

Non-Linux implementers (of OEM storage devices) rely on such standards
processes to indemnify them against licensing claims.

Today, there is no specification for existing IMA metadata formats,
there is only code. My lawyer tells me that because the code that
implements these formats is under GPL, the formats themselves cannot
be contributed to, say, the IETF without express permission from the
authors of that code. There are a lot of authors of the Linux IMA
code, so this is proving to be an impediment to contribution. That
blocks the ability to provide a fully-specified NFS protocol
extension to support IMA metadata formats.


> The way the spec
> process works in Linux is that we implement or evolve a data format
> under a GPL implementaiton, but that implementation doesn't implicate
> the later standardisation of the data format and people are free to
> reimplement under any licence they choose.

That technology transfer can happen only if all the authors of that
prototype agree to contribute to a standard. That's much easier if
that agreement comes before an implementation is done. The current
IMA code base is more than a decade old, and there are more than a
hundred authors who have contributed to that base.

Thus IMO we want an unencumbered description of any IMA metadata
format that is to be contributed to an open standards body (as it
would have to be to extend, say, the NFS protocol).

I'm happy to write that specification, as long as any contributions
here are unencumbered and acknowledged. In fact, I have been working
on a (so far, flawed) NFS extension:

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/

Now, for example, the components of a putative Merkle-based IMA
metadata format are all already open:

- The unit size is just an integer

- A certificate fingerprint is a de facto standard, and the
fingerprint digest algorithms are all standardized

- Merkle trees are public domain, I believe, and we're not adding
any special sauce here

- Digital signing algorithms are all standardized

Wondering if we want to hash and save the file's mtime and size too.


>>> The first basic is that a merkle tree allows unit at a time
>>> verification. First of all we should agree on the unit.  Since we
>>> always fault a page at a time, I think our merkle tree unit should
>>> be a page not a block.
>>=20
>> Remote filesystems will need to agree that the size of that unit is
>> the same everywhere, or the unit size could be stored in the per-file
>> metadata.
>>=20
>>=20
>>> Next, we should agree where the check gates for the per page
>>> accesses should be ... definitely somewhere in readpage, I suspect
>>> and finally we should agree how the merkle tree is presented at the
>>> gate.  I think there are three ways:
>>>=20
>>>  1. Ahead of time transfer:  The merkle tree is transferred and
>>> verified
>>>     at some time before the accesses begin, so we already have a
>>>     verified copy and can compare against the lower leaf.
>>>  2. Async transfer:  We provide an async mechanism to transfer the
>>>     necessary components, so when presented with a unit, we check
>>> the
>>>     log n components required to get to the root
>>>  3. The protocol actually provides the capability of 2 (like the
>>> SCSI
>>>     DIF/DIX), so to IMA all the pieces get presented instead of
>>> IMA
>>>     having to manage the tree
>>=20
>> A Merkle tree is potentially large enough that it cannot be stored in
>> an extended attribute. In addition, an extended attribute is not a
>> byte stream that you can seek into or read small parts of, it is
>> retrieved in a single shot.
>=20
> Well you wouldn't store the tree would you, just the head hash.  The
> rest of the tree can be derived from the data.  You need to =
distinguish
> between what you *must* have to verify integrity (the head hash,
> possibly signed)

We're dealing with an untrusted storage device, and for a remote
filesystem, an untrusted network.

Mimi's earlier point is that any IMA metadata format that involves
unsigned digests is exposed to an alteration attack at rest or in
transit, thus will not provide a robust end-to-end integrity
guarantee.

Therefore, tree root digests must be cryptographically signed to be
properly protected in these environments. Verifying that signature
should be done infrequently relative to reading a file's content.


> and what is nice to have to speed up the verification
> process.  The choice for the latter is cache or reconstruct depending
> on the resources available.  If the tree gets cached on the server,
> that would be a server implementation detail invisible to the client.

We assume that storage targets (for block or file) are not trusted.
Therefore storage clients cannot rely on intermediate results (eg,
middle nodes in a Merkle tree) unless those results are generated
within the client's trust envelope.

So: if the storage target is considered inside the client's trust
envelope, it can cache or store durably any intermediate parts of
the verification process. If not, the network and file storage is
considered untrusted, and the client has to rely on nothing but the
signed digest of the tree root.

We could build a scheme around, say, fscache, that might save the
intermediate results durably and locally.


>> For this reason, the idea was to save only the signature of the
>> tree's root on durable storage. The client would retrieve that
>> signature possibly at open time, and reconstruct the tree at that
>> time.
>=20
> Right that's the integrity data you must have.
>=20
>> Or the tree could be partially constructed on-demand at the time each
>> unit is to be checked (say, as part of 2. above).
>=20
> Whether it's reconstructed or cached can be an implementation detail.
> You clearly have to reconstruct once, but whether you have to do it
> again depends on the memory available for caching and all the other
> resource calls in the system.
>=20
>> The client would have to reconstruct that tree again if memory
>> pressure caused some or all of the tree to be evicted, so perhaps an
>> on-demand mechanism is preferable.
>=20
> Right, but I think that's implementation detail.  Probably what we =
need
> is a way to get the log(N) verification hashes from the server and =
it's
> up to the client whether it caches them or not.

Agreed, these are implementation details. But see above about the
trustworthiness of the intermediate hashes. If they are conveyed
on an untrusted network, then they can't be trusted either.


>>> There are also a load of minor things like how we get the head
>>> hash, which must be presented and verified ahead of time for each
>>> of the above 3.
>>=20
>> Also, changes to a file's content and its tree signature are not
>> atomic. If a file is mutable, then there is the period between when
>> the file content has changed and when the signature is updated.
>> Some discussion of how a client is to behave in those situations will
>> be necessary.
>=20
> For IMA, if you write to a checked file, it gets rechecked the next
> time the gate (open/exec/mmap) is triggered.  This means you must
> complete the update and have the new integrity data in-place before
> triggering the check.  I think this could apply equally to a merkel
> tree based system.  It's a sort of Doctor, Doctor it hurts when I do
> this situation.

I imagine it's a common situation where a "yum update" process is
modifying executables while clients are running them. To prevent
a read from pulling refreshed content before the new tree root is
available, it would have to block temporarily until the verification
process succeeds with the updated tree root.


--
Chuck Lever
chucklever@gmail.com



