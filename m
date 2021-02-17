Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2E31E2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 23:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhBQWus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhBQWtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:49:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FACC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 14:48:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so150155plh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 14:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5FGambquWRCnmEDAddAps0vXdGYlhW3gLoUARcwDn64=;
        b=zO/rxXStBmtNluVqR0Bib4i5ZEWJfNTiXbDEd+szSAyJE5cn4TZy9gaem18BLvzL7M
         /X//OV30Rvy/KvZd2pJiZEuhNFLFztiVW7TLiiMSQNese+i++TgZVzMC6laFjsT25wh5
         xCbJUx+8BrB/FDZaVOPeC01EtVE0wYroV+/ULmOTlUorZwp0IBmUNBMEaf3Ok04O85w4
         cA3KOvccozAfDkHuocUi3xrTbPzK+0dSfW8kPHcxwt+OeyzHVG7fHkfZbWLdjXPq1crE
         jK9CES4HLZL7PEK+rPb81Pv9WMB+gleBPgfM8Jq4q/sM8AEfqEMMqu3Wc3P1mpYvUw4D
         79qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5FGambquWRCnmEDAddAps0vXdGYlhW3gLoUARcwDn64=;
        b=FIpBcBpUleAYVTrhC0u79x5aeiUV2lyyRiAK+OTm4xDZr5YvtAbLtxX2nQA51WMGS/
         AmdLeist7/p1Cl+h20NqMeCNynwc3XTLJvks5Co/0YUS268XXKaV9RMOLEUok/xf5lYF
         T6rs76FLuZkKJngfWMIx62xoTJR5bIrWzpNtyMcnIF2Tct2ekkyNpUZoxhtFVt5r28Ke
         s3wdMm+4jTz9BujRydJwXOQOK6WdK7dwxedNjxZu6nMcyAApvO5ycxYOBf76uEHz3kyS
         chPEUlzGxD7+HG2zRyWWibVZfRctRR8KN8B6FrscYrLNtx/Dxn8HHh/HZthyWJhQTzhJ
         MFYQ==
X-Gm-Message-State: AOAM531UJ5zRyIVwjLZOCRltpWh3I2QVE65Iho6ToYMmGC9v0Nd6xcvD
        EQijsRDxbEMtBT0UnH0fRGfwvA==
X-Google-Smtp-Source: ABdhPJz73J94yOfKdh6BPxHWEMlUZGppoEURcqikxY0NlLJiHBYXjvQZgaLJ1A6b+IZ3J1u1peJMBQ==
X-Received: by 2002:a17:90b:164b:: with SMTP id il11mr1047845pjb.65.1613602124109;
        Wed, 17 Feb 2021 14:48:44 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w3sm3223464pjt.4.2021.02.17.14.48.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 14:48:43 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4D2308D5-B601-446D-BFE3-D573421E6A2B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Date:   Wed, 17 Feb 2021 15:48:39 -0700
In-Reply-To: <YC0/ZsQbKntSpl97@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca> <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu> <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu>
 <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
 <YC0/ZsQbKntSpl97@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_4D2308D5-B601-446D-BFE3-D573421E6A2B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 17, 2021, at 9:08 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Tue, Feb 16, 2021 at 08:01:11PM -0800, Daniel Rosenberg wrote:
>> I'm not sure what the conflict is, at least format-wise. Naturally,
>> there would need to be some work to reconcile the two patches, but my
>> patch only alters the format for directories which are encrypted and
>> casefolded, which always must have the additional hash field. In the
>> case of dirdata along with encryption and casefolding, couldn't we
>> have the dirdata simply follow after the existing data? Since we
>> always already know the length, it'd be unambiguous where that would
>> start. Casefolding can only be altered on an empty directory, and you
>> can only enable encryption for an empty directory, so I'm not too
>> concerned there. I feel like having it swapping between the different
>> methods makes it more prone to bugs, although it would be doable. I've
>> started rebasing the dirdata patch on my end to see how easy it is to
>> mix the two. At a glance, they touch a lot of the same areas in
>> similar ways, so it shouldn't be too hard. It's more of a question of
>> which way we want to resolve that, and which patch goes first.
>> 
>> I've been trying to figure out how many devices in the field are using
>> casefolded encryption, but haven't found out yet. The code is
>> definitely available though, so I would not be surprised if it's being
>> used, or is about to be.
> 
> The problem is in how the space after the filename in a directory is
> encoded.  The dirdata format is (mildly) expandable, supporting up to
> 4 different metadata chunks after the filename, using a very
> compatctly encoded TLV (or moral equivalent) scheme.  For directory
> inodes that have both the encyption and compression flags set, we have
> a single blob which gets used as the IV for the crypto.
> 
> So it's the difference between a simple blob that is only used for one
> thing in this particular case, and something which is the moral
> equivalent of simple ASN.1 or protobuf encoding.
> 
> Currently, datadata has defined uses for 2 of the 4 "chunks", which is
> used in Lustre servers.  The proposal which Andreas has suggested is
> if the dirdata feature is supported, then the 3rd dirdata chunk would
> be used for the case where we currently used by the
> encrypted-casefolded extension, and the 4th would get reserved for a
> to-be-defined extension mechanism.
> 
> If there ext4 encrypted/casefold is not yet in use, and we can get the
> changes out to all potential users before they release products out
> into the field, then one approach would be to only support
> encrypted/casefold when dirdata is also enabled.
> 
> If ext4 encrypted/casefold is in use, my suggestion is that we support
> both encrypted/casefold && !dirdata as you have currently implemented
> it, and encrypted/casefold && dirdata as Andreas has proposed.
> 
> IIRC, supporting that Andreas's scheme essentially means that we use
> the top four bits in the rec_len field to indicate which chunks are
> present, and then for each chunk which is present, there is a 1 byte
> length followed by payload.  So that means in the case where it's
> encrypted/casefold && dirdata, the required storage of the directory
> entry would take one additional byte, plus setting a bit indicating
> that the encrypted/casefold dirdata chunk was present.

I think your email already covers pretty much all of the points.

One small difference between current "raw" encrypted/casefold hash vs.
dirdata is that the former is 4-byte aligned within the dirent, while
dirdata is packed.  So in 3/4 cases dirdata would take the same amount
of space (the 1-byte length would use one of the 1-3 bytes of padding
vs. the raw format), since the next dirent needs to be aligned anyway.

The other implication here is that the 8-byte hash may need to be
copied out of the dirent into a local variable before use, due to
alignment issues, but I'm not sure if that is actually needed or not.

> So, no, they aren't incompatible ultimatly, but it might require a
> tiny bit more work to integrate the combined support for dirdata plus
> encrypted/casefold.  One way we can do this, if we have to support the
> current encrypted/casefold format because it's out there in deployed
> implementations already, is to integrate encrypted/casefold &&
> !dirdata first upstream, and then when we integrate dirdata into
> upstream, we'll have to add support for the encrypted/casefold &&
> dirdata case.  This means that we'll have two variants of the on-disk
> format to test and support, but I don't think it's the going to be
> that difficult.

It would be possible to detect if the encrypted/casefold+dirdata
variant is in use, because the dirdata variant would have the 0x40
bit set in the file_type byte.  It isn't possible to positively
identify the "raw" non-dirdata variant, but the assumption would be
if (rec_len >= round_up(name_len, 4) + 8) in an encrypted+casefold
directory that the "raw" hash must be present in the dirent.

Cheers, Andreas






--Apple-Mail=_4D2308D5-B601-446D-BFE3-D573421E6A2B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAtnUcACgkQcqXauRfM
H+D5DQ/+ObqzY+vq6AkWIAKb1KbsUf8FYgIoaXGlQGR5CSTlogB+l81EwffEcydf
UdgTyPkSI2yvCsTR1Cuv2d06ZfgET/FRi4K9lnkdJJFNaVVWcXA2kWZmhiF8mvTZ
AqxizfqEX+wSy8LYAwpk0MBMsSuYbGbor2eRfCk2RXRj9/Hf9F87N99WGRrlz9Xb
3+3Bi81KHmIfXVChW3/3VoAsHNUAf/ojlvWYrjWsKXR+OLf92OSJT6nRQd2HF8bQ
oSYc4jyII1Sl7VxOFblYVcc7/DnIKv/EUGp3YYF9qympz3RsdL29THmgI1l9eEfR
11I71PzCOYnACRX5jERWgxTdAgHdc/pmOtldEnWi2C7Afw91j1/thsDONxeau07e
OQ/yI5Ud4hMWbdwk8BTMsGJIDW0mhZPVZr+aEst8YzJvrJGytuNvLTrmnA4sxym9
RyafJRbFsJw8PE/ypw+WOEhj+jXK0uIH6Er8zZWTCNj2CAoCQ6fLFqu3lSLFd8Nz
N4idzf/ab2CNzJ+dGC120jcSkXGo03WueVT8B075rHNBjyHQPvIQVInuYWMQ0KC/
GE0guZdF/LKNaDkKmrQRROw5cNBp2iun/wgX5/HYqw6nnFBDywBuor848awdNovW
PDyW1Dgig2pJ63Kfc1jVQwYg2v7w9XT0zwpShJAkYkF+Oqw0U3M=
=gAcv
-----END PGP SIGNATURE-----

--Apple-Mail=_4D2308D5-B601-446D-BFE3-D573421E6A2B--
