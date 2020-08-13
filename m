Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7B243BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMOnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMOnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:43:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25CC061757;
        Thu, 13 Aug 2020 07:43:02 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q14so2307573ilm.2;
        Thu, 13 Aug 2020 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KILfYV/I05r54w/N5CnfJ8WQSq/xdrIhozq/NImqQxA=;
        b=u6yr2cPYLbsp0FY2jcfsj63AymEpRTt8W3791CfmIUPIk/5L3SvNbtHZRVZWBrlbPk
         jKv3ONmiIYd5hAExxn/hZgIwXgq5eHVQVUeeI8edHrzV7aK5MlHkMEUSSNIl1ycr+b1D
         Fpng/plc1joX8uAJQyUhLNFtln8+irNRYbKn8sqgvyZGmWJED1QzUqmCTucDZB35begs
         DhZEFAbwh1vXutp+wb3VOmcdf0aQ3uL3mYh818/lbvxt312DIqq6GHGsugK4Zn2Z3LyL
         N5a2KQWmF5sL2LJwPM4wnmaNMsBgN23Hx+ulLtnWCSjZve6lk3oGKbzR26CAKJZXupsD
         7vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KILfYV/I05r54w/N5CnfJ8WQSq/xdrIhozq/NImqQxA=;
        b=S2KX/ci/Th0oZqrmd1qyfveuLsNEX77u+MvB/+R8ybCogN6MLje51oOYx2z8X/R71K
         as7PFyIJVbPZ5YwS4zPyERQtpL6dtnZfqDo1aFRJuBklaO5NabH44xeSrcoeVT8l0/05
         iJ9B/3CsKepGAG8tRGh+kXnPRY+6M2L/ogOCjv+oWPzBU7CP7VUWNTci1hVUBbeTAmyX
         3RsnAnF2YN3sP6pouRP/XVjVLl4C4/H8I4J4gRHudW/flQSo5xb+rqPBmqXHD/EswzHQ
         SstpX7H2lP7N65hOUUKlQWVyJQkwlnnfT3Wq8bba3Iv0ElVKNO6/jD6PD5DioxNSHWfG
         PKpw==
X-Gm-Message-State: AOAM530+TTkSoMxA6rqFsRy/J1GkmuILrTziuVVHNLdtx82SoYr7SfCV
        1vz6ah7L2KcOeO1g83O2cvU=
X-Google-Smtp-Source: ABdhPJxgrClyrzQX/PJcUbPmit0CzIEDPN6RcrMwhHvO56Hl7Nl5nMW+4QTSjkyJORRGbVY/nG4opg==
X-Received: by 2002:a05:6e02:d48:: with SMTP id h8mr5047638ilj.295.1597329781813;
        Thu, 13 Aug 2020 07:43:01 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v17sm2821661ilj.33.2020.08.13.07.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:43:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597247482.7293.18.camel@HansenPartnership.com>
Date:   Thu, 13 Aug 2020 10:42:57 -0400
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
Message-Id: <D470BA4B-EF1A-49CA-AFB9-0F7FFC4C6001@gmail.com>
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
 <02D551EF-C975-4B91-86CA-356FA0FF515C@gmail.com>
 <1597247482.7293.18.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 12, 2020, at 11:51 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Wed, 2020-08-12 at 10:15 -0400, Chuck Lever wrote:
>>> On Aug 11, 2020, at 11:53 AM, James Bottomley
>>> <James.Bottomley@HansenPartnership.com> wrote:
>>>=20
>>> On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
> [...]
>>>>>=20
>>>>> and what is nice to have to speed up the verification
>>>>> process.  The choice for the latter is cache or reconstruct
>>>>> depending on the resources available.  If the tree gets cached
>>>>> on the server, that would be a server implementation detail
>>>>> invisible to the client.
>>>>=20
>>>> We assume that storage targets (for block or file) are not
>>>> trusted. Therefore storage clients cannot rely on intermediate
>>>> results (eg, middle nodes in a Merkle tree) unless those results
>>>> are generated within the client's trust envelope.
>>>=20
>>> Yes, they can ... because supplied nodes can be verified.  That's
>>> the whole point of a merkle tree.  As long as I'm sure of the root
>>> hash I can verify all the rest even if supplied by an untrusted
>>> source.  If you consider a simple merkle tree covering 4 blocks:
>>>=20
>>>      R
>>>    /   \
>>> H11     H12
>>> / \     / \
>>> H21 H22 H23 H24
>>>>   |   |   |
>>>=20
>>> B1   B2  B3  B4
>>>=20
>>> Assume I have the verified root hash R.  If you supply B3 you also
>>> supply H24 and H11 as proof.  I verify by hashing B3 to produce H23
>>> then hash H23 and H24 to produce H12 and if H12 and your supplied
>>> H11 hash to R the tree is correct and the B3 you supplied must
>>> likewise be correct.
>>=20
>> I'm not sure what you are proving here. Obviously this has to work
>> in order for a client to reconstruct the file's Merkle tree given
>> only R and the file content.
>=20
> You implied the server can't be trusted to generate the merkel tree.=20=

> I'm showing above it can because of the tree path based verification.

What I was implying is that clients can't trust intermediate Merkle
tree content that is not also signed. So far we are talking about
signing only the tree root.

The storage server can store the tree durably, but if the intermediate
parts of the tree are not signed, the client has to verify them anyway,
and that reduces the value of storing potentially large data structures.


>> It's the construction of the tree and verification of the hashes that
>> are potentially expensive. The point of caching intermediate hashes
>> is so that the client verifies them as few times as possible.  I
>> don't see value in caching those hashes on an untrusted server --
>> the client will have to reverify them anyway, and there will be no
>> savings.
>=20
> I'm not making any claim about server caching, I'm just saying the
> client can request pieces of the tree from the server without having =
to
> reconstruct the whole thing itself because it can verify their
> correctness.

To be clear, my concern is about how much of the tree might be stored
in a Merkle-based metadata format. I just don't see that it has much
value to store more than the signed tree root, because the client will
have to reconstitute or verify some tree contents on most every read.

For sufficiently large files, the tree itself can be larger than what
can be stored in an xattr. This is the same problem that fs-verity
faces. And, as I stated earlier, xattr objects are read in their
entirety, they can't be seeked into or read piecemeal.

What it seemed to me that you were suggesting was an offloaded cache
of the Merkle tree. Either the whole tree is stored on the storage
server, or the storage server provides a service that reconstitutes
that tree on behalf of clients. (Please correct me if I misunderstood).
I just don't think that will be practicable or provide the kind of
benefit you might want.


>> Cache once, as close as you can to where the data will be used.
>>=20
>>=20
>>>> So: if the storage target is considered inside the client's trust
>>>> envelope, it can cache or store durably any intermediate parts of
>>>> the verification process. If not, the network and file storage is
>>>> considered untrusted, and the client has to rely on nothing but
>>>> the signed digest of the tree root.
>>>>=20
>>>> We could build a scheme around, say, fscache, that might save the
>>>> intermediate results durably and locally.
>>>=20
>>> I agree we want caching on the client, but we can always page in
>>> from the remote as long as we page enough to verify up to R, so
>>> we're always sure the remote supplied genuine information.
>>=20
>> Agreed.
>>=20
>>=20
>>>>>> For this reason, the idea was to save only the signature of
>>>>>> the tree's root on durable storage. The client would retrieve
>>>>>> that signature possibly at open time, and reconstruct the
>>>>>> tree at that time.
>>>>>=20
>>>>> Right that's the integrity data you must have.
>>>>>=20
>>>>>> Or the tree could be partially constructed on-demand at the
>>>>>> time each unit is to be checked (say, as part of 2. above).
>>>>>=20
>>>>> Whether it's reconstructed or cached can be an implementation
>>>>> detail. You clearly have to reconstruct once, but whether you
>>>>> have to do it again depends on the memory available for caching
>>>>> and all the other resource calls in the system.
>>>>>=20
>>>>>> The client would have to reconstruct that tree again if
>>>>>> memory pressure caused some or all of the tree to be evicted,
>>>>>> so perhaps an on-demand mechanism is preferable.
>>>>>=20
>>>>> Right, but I think that's implementation detail.  Probably what
>>>>> we need is a way to get the log(N) verification hashes from the
>>>>> server and it's up to the client whether it caches them or not.
>>>>=20
>>>> Agreed, these are implementation details. But see above about the
>>>> trustworthiness of the intermediate hashes. If they are conveyed
>>>> on an untrusted network, then they can't be trusted either.
>>>=20
>>> Yes, they can, provided enough of them are asked for to verify.  If
>>> you look at the simple example above, suppose I have cached H11 and
>>> H12, but I've lost the entire H2X layer.  I want to verify B3 so I
>>> also ask you for your copy of H24.  Then I generate H23 from B3 and
>>> Hash H23 and H24.  If this doesn't hash to H12 I know either you
>>> supplied me the wrong block or lied about H24.  However, if it all
>>> hashes correctly I know you supplied me with both the correct B3
>>> and the correct H24.
>>=20
>> My point is there is a difference between a trusted cache and an
>> untrusted cache. I argue there is not much value in a cache where
>> the hashes have to be verified again.
>=20
> And my point isn't about caching, it's about where the tree comes =
from.
> I claim and you agree the client can get the tree from the server a
> piece at a time (because it can path verify it) and doesn't have to
> generate it itself.

OK, let's focus on where the tree comes from. It is certainly
possible to build protocol to exchange parts of a Merkle tree. The
question is how it might be stored on the server. There are some
underlying assumptions about the metadata storage mechanism that
should be stated up front.

Current forms of IMA metadata are limited in size and stored in a
container that is read and written in a single operation. If we stick
with that container format, I don't see a way to store a Merkle tree
in there for all file sizes.

Thus it seems to me that we cannot begin to consider the tree-on-the-
server model unless there is a proposed storage mechanism for that
whole tree. Otherwise, the client must have the primary role in
unpacking and verifying the tree.

Storing only the tree root in the metadata means the metadata format
is nicely bounded in size.


> How much of the tree the client has to store and
> whether the server caches, reads it in from somewhere or reconstructs
> it is an implementation detail.

Sure.


--
Chuck Lever
chucklever@gmail.com



