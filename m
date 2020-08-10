Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6082413E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 01:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHJXg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgHJXg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:36:58 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065CC06174A;
        Mon, 10 Aug 2020 16:36:53 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y18so9039393ilp.10;
        Mon, 10 Aug 2020 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LKyAC8SmzXgvrrYpq/s/3TsU/WRs+a9c0PUjRq1OPBQ=;
        b=JlpYrwH8LuYxS/kUo816+90tW0+/ylAfqYVP9WkSSIXWKS3+fXoIPBSsPTXz2V3n+V
         zfZjMbVssR/VpKiSgjUnAf/P3DOv2eNyNduLJeu4owJi5tGfGWS5Ew4ooZigMhEA5VxR
         3maepQLkw6Gz7N+bsh46aLUgeLKvPqrQxXsZ/VInB84fAR/q3ofXK7vWEerCetXXYW0r
         BB+wUPLUssFy9WzQaaMgPg+DFTUtT6PrMdo+buwwPVDSbcB0TqzV0zsdl8KTpwJ9m4hf
         EwgGlp/joouyPXwhKZaHTR2Fekur8oaosXQK9E/BnvFHhfwtmh8JARTWM1TDRtQNrIJ5
         0atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LKyAC8SmzXgvrrYpq/s/3TsU/WRs+a9c0PUjRq1OPBQ=;
        b=cNwLScCUv+Q3pkO31O18CFnOVi8hKXXb1UXG0eZaQyNTXLIKL+9B1bUI18czvgcEEf
         OE3rrr1wQcGV/KNoTICMRX2ffSfLTlvg5Vak8ooFjQxcIZPHp9nbLYqx7FvtQq6cjf0c
         0UWtmf26eQ0VdZYxbGj0gvSmvGNyG2OZh5PatmC1RtTITj5g+JTqJJGx2IjS85Lee1wO
         rnTWHBx5Lrvp2flg8C4IaYAb5BuwQI6q5fQunHUi16yU+EVB9MVFWEEFNlZfwI12unA/
         FCk2Qp1f5vH+SL09Tv8nh/j61BbLaVDPlChWje3RdxxYJnmEznLyLWoGFuxPvYhKQdxY
         CfeQ==
X-Gm-Message-State: AOAM533/KfXHfMAOc/wMFlSqUoevVSyXO+27lABqCtsMVcLEql/6VUbH
        UVH6OjGbAEUBIlvk8G0tYgo=
X-Google-Smtp-Source: ABdhPJy1S3g3p98Xi9EcsXNS6CmJzbt5rxJnpB8itBPIozhsJmELv5fUbjHEUzglUQlam96oFkStKA==
X-Received: by 2002:a92:8b11:: with SMTP id i17mr19417396ild.212.1597102610889;
        Mon, 10 Aug 2020 16:36:50 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o11sm11353713iom.25.2020.08.10.16.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2020 16:36:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597073737.3966.12.camel@HansenPartnership.com>
Date:   Mon, 10 Aug 2020 19:36:47 -0400
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
Message-Id: <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
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
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 10, 2020, at 11:35 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Sun, 2020-08-09 at 13:16 -0400, Mimi Zohar wrote:
>> On Sat, 2020-08-08 at 13:47 -0400, Chuck Lever wrote:
>>>> On Aug 5, 2020, at 2:15 PM, Mimi Zohar <zohar@linux.ibm.com>
>>>> wrote:
>>=20
>> <snip>
>>=20
>>>> If block layer integrity was enough, there wouldn't have been a
>>>> need for fs-verity.   Even fs-verity is limited to read only
>>>> filesystems, which makes validating file integrity so much
>>>> easier.  =46rom the beginning, we've said that fs-verity signatures
>>>> should be included in the measurement list.  (I thought someone
>>>> signed on to add that support to IMA, but have not yet seen
>>>> anything.)
>>>=20
>>> Mimi, when you and I discussed this during LSS NA 2019, I didn't
>>> fully understand that you expected me to implement signed Merkle
>>> trees for all filesystems. At the time, it sounded to me like you
>>> wanted signed Merkle trees only for NFS files. Is that still the
>>> case?
>>=20
>> I definitely do not expect you to support signed Merkle trees for all
>> filesystems.  My interested is from an IMA perspective of measuring
>> and verifying the fs-verity Merkle tree root (and header info)
>> signature. This is independent of which filesystems support it.
>>=20
>>>=20
>>> The first priority (for me, anyway) therefore is getting the
>>> ability to move IMA metadata between NFS clients and servers
>>> shoveled into the NFS protocol, but that's been blocked for various
>>> legal reasons.
>>=20
>> Up to now, verifying remote filesystem file integrity has been out of
>> scope for IMA.   With fs-verity file signatures I can at least grasp
>> how remote file integrity could possibly work.  I don't understand
>> how remote file integrity with existing IMA formats could be
>> supported. You might want to consider writing a whitepaper, which
>> could later be used as the basis for a patch set cover letter.
>=20
> I think, before this, we can help with the basics (and perhaps we
> should sort them out before we start documenting what we'll do).

Thanks for the help! I just want to emphasize that documentation
(eg, a specification) will be critical for remote filesystems.

If any of this is to be supported by a remote filesystem, then we
need an unencumbered description of the new metadata format rather
than code. GPL-encumbered formats cannot be contributed to the NFS
standard, and are probably difficult for other filesystems that are
not Linux-native, like SMB, as well.


> The
> first basic is that a merkle tree allows unit at a time verification.=20=

> First of all we should agree on the unit.  Since we always fault a =
page
> at a time, I think our merkle tree unit should be a page not a block.

Remote filesystems will need to agree that the size of that unit is
the same everywhere, or the unit size could be stored in the per-file
metadata.


> Next, we should agree where the check gates for the per page accesses
> should be ... definitely somewhere in readpage, I suspect and finally
> we should agree how the merkle tree is presented at the gate.  I think
> there are three ways:
>=20
>   1. Ahead of time transfer:  The merkle tree is transferred and =
verified
>      at some time before the accesses begin, so we already have a
>      verified copy and can compare against the lower leaf.
>   2. Async transfer:  We provide an async mechanism to transfer the
>      necessary components, so when presented with a unit, we check the
>      log n components required to get to the root
>   3. The protocol actually provides the capability of 2 (like the SCSI
>      DIF/DIX), so to IMA all the pieces get presented instead of IMA
>      having to manage the tree

A Merkle tree is potentially large enough that it cannot be stored in
an extended attribute. In addition, an extended attribute is not a
byte stream that you can seek into or read small parts of, it is
retrieved in a single shot.

For this reason, the idea was to save only the signature of the tree's
root on durable storage. The client would retrieve that signature
possibly at open time, and reconstruct the tree at that time.

Or the tree could be partially constructed on-demand at the time each
unit is to be checked (say, as part of 2. above).

The client would have to reconstruct that tree again if memory pressure
caused some or all of the tree to be evicted, so perhaps an on-demand
mechanism is preferable.


> There are also a load of minor things like how we get the head hash,
> which must be presented and verified ahead of time for each of the
> above 3.

Also, changes to a file's content and its tree signature are not
atomic. If a file is mutable, then there is the period between when
the file content has changed and when the signature is updated.
Some discussion of how a client is to behave in those situations will
be necessary.


--
Chuck Lever
chucklever@gmail.com



