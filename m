Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFD242B1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLOP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHLOP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:15:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21051C061383;
        Wed, 12 Aug 2020 07:15:26 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so1727810ilc.11;
        Wed, 12 Aug 2020 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DDhY+P0lBC9pd05d4FvtB0mHakxKn00E1k9HqMtjaS8=;
        b=QY2+OpWE8jh+LJzD58J/dVkZ7Cqx5rWlkahr1UzEIvOz+6rVVRk2DfB5n29TKwvJ0I
         V6GZcPDm3kDdHo571/cKSN/n/9rx/FE0nV4t323nO1P1lad5MCHC4fUqOg2O/S+Ts+WM
         0KtcH5Pc1dz8YCtw8IfQvfsPVHY3wZt0JtnWeMP0V16GENmBkOya5902dhIa4+BK0DTe
         gYG7WyLVNzRzPaIPPrBhxWpb82j8+kv3l2dYCKnYva5hXfyjjl7B9DutFX0NhUd8vu2F
         vRx9YNrxTbsVlXtC8ASPoeUfSkRL9ykiHEDoHoRmjreox7DrH99CRP9EphKEfmhixuip
         fbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DDhY+P0lBC9pd05d4FvtB0mHakxKn00E1k9HqMtjaS8=;
        b=KVMg/0Ji1OYXQ2rQv+z0SgrWw1OZSuzTRpwA/o6K2Lh5MdobGchCYsq/kgkB5Zb4Rl
         cseo0FH4gfmtLnxPt2nEHsCimDI6kOyHJu3pANZlFczyNIoqKIuzxxEl77FT4fW5g+W5
         Vf6y85fQVGY7fwSK1Q7imHU9nNQ4pRIAmZo43WShwNniTth8hYw6n0hzEByVc6gRCPxy
         ogTOPcA/S8wSD9BZTo92XvgFEILmjmJQuRHM+vPzv2nYxUPll6OS85tqQSEwiI2wQ2PE
         kRitaW9fJ/ziTQnuaZII8dgPV4Tdu/Yh3GHqyRzjWNk2AkuB/kIqM6vqxQMO2g4u7VA4
         1szA==
X-Gm-Message-State: AOAM532s5ARgrFT4eg02gWfj0lY0nEmta844q3BbgZZruMZrLHuijuLm
        RHz5rVOie7IK9p1wOM4Xwv4=
X-Google-Smtp-Source: ABdhPJx9YDj09YBZkQf3zY2davXEvExj+ZReUjqVBxlIJohvcx3Xwo772HhM3JKHvRwiBfLt/XdEhw==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr29246989ilm.25.1597241725377;
        Wed, 12 Aug 2020 07:15:25 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v28sm1163544ili.27.2020.08.12.07.15.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:15:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597161218.4325.38.camel@HansenPartnership.com>
Date:   Wed, 12 Aug 2020 10:15:22 -0400
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
Message-Id: <02D551EF-C975-4B91-86CA-356FA0FF515C@gmail.com>
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
 <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
 <1597161218.4325.38.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 11:53 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
>>> On Aug 11, 2020, at 1:43 AM, James Bottomley <James.Bottomley@Hanse
>>> nPartnership.com> wrote:
>>>=20
>>> On Mon, 2020-08-10 at 19:36 -0400, Chuck Lever wrote:
>>>>> On Aug 10, 2020, at 11:35 AM, James Bottomley
>>>>> <James.Bottomley@HansenPartnership.com> wrote:
> [...]
>>>>> The first basic is that a merkle tree allows unit at a time
>>>>> verification. First of all we should agree on the unit.  Since
>>>>> we always fault a page at a time, I think our merkle tree unit
>>>>> should be a page not a block.
>>>>=20
>>>> Remote filesystems will need to agree that the size of that unit
>>>> is the same everywhere, or the unit size could be stored in the
>>>> per-filemetadata.
>>>>=20
>>>>=20
>>>>> Next, we should agree where the check gates for the per page
>>>>> accesses should be ... definitely somewhere in readpage, I
>>>>> suspect and finally we should agree how the merkle tree is
>>>>> presented at the gate.  I think there are three ways:
>>>>>=20
>>>>> 1. Ahead of time transfer:  The merkle tree is transferred and
>>>>> verified
>>>>>    at some time before the accesses begin, so we already have
>>>>> a
>>>>>    verified copy and can compare against the lower leaf.
>>>>> 2. Async transfer:  We provide an async mechanism to transfer
>>>>> the
>>>>>    necessary components, so when presented with a unit, we
>>>>> check the
>>>>>    log n components required to get to the root
>>>>> 3. The protocol actually provides the capability of 2 (like
>>>>> the SCSI
>>>>>    DIF/DIX), so to IMA all the pieces get presented instead of
>>>>> IMA
>>>>>    having to manage the tree
>>>>=20
>>>> A Merkle tree is potentially large enough that it cannot be
>>>> stored in an extended attribute. In addition, an extended
>>>> attribute is not a byte stream that you can seek into or read
>>>> small parts of, it is retrieved in a single shot.
>>>=20
>>> Well you wouldn't store the tree would you, just the head
>>> hash.  The rest of the tree can be derived from the data.  You need
>>> to distinguish between what you *must* have to verify integrity
>>> (the head hash, possibly signed)
>>=20
>> We're dealing with an untrusted storage device, and for a remote
>> filesystem, an untrusted network.
>>=20
>> Mimi's earlier point is that any IMA metadata format that involves
>> unsigned digests is exposed to an alteration attack at rest or in
>> transit, thus will not provide a robust end-to-end integrity
>> guarantee.
>>=20
>> Therefore, tree root digests must be cryptographically signed to be
>> properly protected in these environments. Verifying that signature
>> should be done infrequently relative to reading a file's content.
>=20
> I'm not disagreeing there has to be a way for the relying party to
> trust the root hash.
>=20
>>> and what is nice to have to speed up the verification
>>> process.  The choice for the latter is cache or reconstruct
>>> depending on the resources available.  If the tree gets cached on
>>> the server, that would be a server implementation detail invisible
>>> to the client.
>>=20
>> We assume that storage targets (for block or file) are not trusted.
>> Therefore storage clients cannot rely on intermediate results (eg,
>> middle nodes in a Merkle tree) unless those results are generated
>> within the client's trust envelope.
>=20
> Yes, they can ... because supplied nodes can be verified.  That's the
> whole point of a merkle tree.  As long as I'm sure of the root hash I
> can verify all the rest even if supplied by an untrusted source.  If
> you consider a simple merkle tree covering 4 blocks:
>=20
>       R
>     /   \
>  H11     H12
>  / \     / \
> H21 H22 H23 H24
> |    |   |   |
> B1   B2  B3  B4
>=20
> Assume I have the verified root hash R.  If you supply B3 you also
> supply H24 and H11 as proof.  I verify by hashing B3 to produce H23
> then hash H23 and H24 to produce H12 and if H12 and your supplied H11
> hash to R the tree is correct and the B3 you supplied must likewise be
> correct.

I'm not sure what you are proving here. Obviously this has to work
in order for a client to reconstruct the file's Merkle tree given
only R and the file content.

It's the construction of the tree and verification of the hashes that
are potentially expensive. The point of caching intermediate hashes
is so that the client verifies them as few times as possible.  I
don't see value in caching those hashes on an untrusted server --
the client will have to reverify them anyway, and there will be no
savings.

Cache once, as close as you can to where the data will be used.


>> So: if the storage target is considered inside the client's trust
>> envelope, it can cache or store durably any intermediate parts of
>> the verification process. If not, the network and file storage is
>> considered untrusted, and the client has to rely on nothing but the
>> signed digest of the tree root.
>>=20
>> We could build a scheme around, say, fscache, that might save the
>> intermediate results durably and locally.
>=20
> I agree we want caching on the client, but we can always page in from
> the remote as long as we page enough to verify up to R, so we're =
always
> sure the remote supplied genuine information.

Agreed.


>>>> For this reason, the idea was to save only the signature of the
>>>> tree's root on durable storage. The client would retrieve that
>>>> signature possibly at open time, and reconstruct the tree at that
>>>> time.
>>>=20
>>> Right that's the integrity data you must have.
>>>=20
>>>> Or the tree could be partially constructed on-demand at the time
>>>> each unit is to be checked (say, as part of 2. above).
>>>=20
>>> Whether it's reconstructed or cached can be an implementation
>>> detail. You clearly have to reconstruct once, but whether you have
>>> to do it again depends on the memory available for caching and all
>>> the other resource calls in the system.
>>>=20
>>>> The client would have to reconstruct that tree again if memory
>>>> pressure caused some or all of the tree to be evicted, so perhaps
>>>> an on-demand mechanism is preferable.
>>>=20
>>> Right, but I think that's implementation detail.  Probably what we
>>> need is a way to get the log(N) verification hashes from the server
>>> and it's up to the client whether it caches them or not.
>>=20
>> Agreed, these are implementation details. But see above about the
>> trustworthiness of the intermediate hashes. If they are conveyed
>> on an untrusted network, then they can't be trusted either.
>=20
> Yes, they can, provided enough of them are asked for to verify.  If =
you
> look at the simple example above, suppose I have cached H11 and H12,
> but I've lost the entire H2X layer.  I want to verify B3 so I also ask
> you for your copy of H24.  Then I generate H23 from B3 and Hash H23 =
and
> H24.  If this doesn't hash to H12 I know either you supplied me the
> wrong block or lied about H24.  However, if it all hashes correctly I
> know you supplied me with both the correct B3 and the correct H24.

My point is there is a difference between a trusted cache and an
untrusted cache. I argue there is not much value in a cache where
the hashes have to be verified again.


>>>>> There are also a load of minor things like how we get the head
>>>>> hash, which must be presented and verified ahead of time for
>>>>> each of the above 3.
>>>>=20
>>>> Also, changes to a file's content and its tree signature are not
>>>> atomic. If a file is mutable, then there is the period between
>>>> when the file content has changed and when the signature is
>>>> updated. Some discussion of how a client is to behave in those
>>>> situations will be necessary.
>>>=20
>>> For IMA, if you write to a checked file, it gets rechecked the next
>>> time the gate (open/exec/mmap) is triggered.  This means you must
>>> complete the update and have the new integrity data in-place before
>>> triggering the check.  I think this could apply equally to a merkel
>>> tree based system.  It's a sort of Doctor, Doctor it hurts when I
>>> do this situation.
>>=20
>> I imagine it's a common situation where a "yum update" process is
>> modifying executables while clients are running them. To prevent
>> a read from pulling refreshed content before the new tree root is
>> available, it would have to block temporarily until the verification
>> process succeeds with the updated tree root.
>=20
> No ... it's not.  Yum specifically worries about that today because if
> you update running binaries, it causes a crash.  Yum constructs the
> entire new file then atomically links it into place and deletes the =
old
> inode to prevent these crashes.  It never allows you to get into the
> situation where you can execute something that will be modified.=20
> That's also why you have to restart stuff after a yum update because =
if
> you didn't it would still be attached to the deleted inode.

Fair enough.

--
Chuck Lever
chucklever@gmail.com



