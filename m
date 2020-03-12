Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99A918263A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 01:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgCLAcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 20:32:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45238 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbgCLAcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:32:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so2284060pfg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=UUThLe0vtyed0mOPAXEzGdnym1P9ENKEhDNAdx+UxnE=;
        b=k/JkCEOuIf2Dz0MTUxYs8ElfJN5H4vBKwZQ8ffY2z8DVdvnGM1flXL339AUsNnEgbF
         cJ6NkhfPzCPNjx1xSWNDdwpznlJRlHTJmbE8BqgjvvxGiBPsVYuRF1IzVa/pV5IF0g9B
         QTCbGqEk7lSobpcRbtZVRO9scqD9Tl49BX7NeWe1Xa//qjETbz2lwhvsuJ03DoaRPTNu
         MxE0FUMrJoowfl/HeWORVYORnS2rYzxtX/3da+cfYgUnNgLrU+JuZYkNSzXWE60KVsr9
         RPNeFtnIi0919JMBO5NTJ1QZgTf+TwhMXyp72dLs1a6pIH457VTQMw7DOKg6/XR/MEyk
         4FlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=UUThLe0vtyed0mOPAXEzGdnym1P9ENKEhDNAdx+UxnE=;
        b=B83oGhDbjCBUnAV+gzDEeVpujZnRmBqbK+QkVRJJZdihJYvkD3TW83q5lLzEoGJc7Y
         uiE+3qSUo83TQjX9pPfKPZMJfb9ryFDCNAiqzxVhlw2Vbxr9DPnzNqZy/BbwdVJZ+9Wl
         1FluN0011FYzpemroViR9Yvj2pZzhbRx4TlPXVvcl+2cQamaMFUC+Q/pFGqEZK+LJ6PX
         5mpkmVnUQhC8+3lfDshqyjq/eUsMbSYPNqzfHYN0D1IXOW9YIuua+6wxGw/KbxOudonh
         l0mxodIe7B//JohsUt8dXZbAog1nsdgjTCmaUEfcN1MF/MTOnVM3jyd4rVuZ2ELNWEjz
         w2kQ==
X-Gm-Message-State: ANhLgQ3lFsHyMhKa/JQ58iY4b96VbNp0Hv6cGvRt1xqPMnzkAA+xYZEl
        wRw4/mG31OL+oPKn6S7jVbSmww==
X-Google-Smtp-Source: ADFU+vv2OfvmHLSmtaV3DHFdco2ejt749GNgr78PBEkpzxAnsRYYPiD7WA+DcZpVd0yo6CmVWLFxag==
X-Received: by 2002:a63:cc0d:: with SMTP id x13mr4948277pgf.388.1583973131456;
        Wed, 11 Mar 2020 17:32:11 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c20sm1753713pfi.205.2020.03.11.17.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 17:32:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B6B72600-AB08-42F5-A9FF-0A0D2189CAFB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FC33B82C-22A5-4BDF-AE66-F782DCCC64EB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
Date:   Wed, 11 Mar 2020 18:31:29 -0600
In-Reply-To: <46c1ed68-ba2f-5738-1257-8fd1b6b87023@virtuozzo.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com,
        Dmitry Monakhov <dmonakhov@gmail.com>,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
 <C4175F35-E9D4-4B79-B1A0-047A51DE3287@dilger.ca>
 <46c1ed68-ba2f-5738-1257-8fd1b6b87023@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_FC33B82C-22A5-4BDF-AE66-F782DCCC64EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 11, 2020, at 2:29 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 11.03.2020 22:26, Andreas Dilger wrote:
>> On Mar 3, 2020, at 2:57 AM, Kirill Tkhai <ktkhai@virtuozzo.com> =
wrote:
>>>=20
>>> On 02.03.2020 19:56, Theodore Y. Ts'o wrote:
>>>> Kirill,
>>>>=20
>>>> In a couple of your comments on this patch series, you mentioned
>>>> "defragmentation".  Is that because you're trying to use this as =
part
>>>> of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?
>>>>=20
>>>> If that's the case, you should note that input parameter for that
>>>> ioctl is:
>>>>=20
>>>> struct move_extent {
>>>> 	__u32 reserved;		/* should be zero */
>>>> 	__u32 donor_fd;		/* donor file descriptor */
>>>> 	__u64 orig_start;	/* logical start offset in block for =
orig */
>>>> 	__u64 donor_start;	/* logical start offset in block for =
donor */
>>>> 	__u64 len;		/* block length to be moved */
>>>> 	__u64 moved_len;	/* moved block length */
>>>> };
>>>>=20
>>>> Note that the donor_start is separate from the start of the file =
that
>>>> is being defragged.  So you could have the userspace application
>>>> fallocate a large chunk of space for that donor file, and then use
>>>> that donor file to defrag multiple files if you want to close pack
>>>> them.
>>>=20
>>> The practice shows it's not so. Your suggestion was the first thing =
we tried,
>>> but it works bad and just doubles/triples IO.
>>>=20
>>> Let we have two files of 512Kb, and they are placed in separate 1Mb =
clusters:
>>>=20
>>> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
>>>=20
>>> We want to pack both of files in the same 1Mb cluster. Packed =
together on block
>>> device, they will be in the same server of underlining distributed =
storage file
>>> system. This gives a big performance improvement, and this is the =
price I aimed.
>>>=20
>>> In case of I fallocate a large hunk for both of them, I have to move =
them
>>> both to this new hunk. So, instead of moving 512Kb of data, we will =
have to move
>>> 1Mb of data, i.e. double size, which is counterproductive.
>>>=20
>>> Imaging another situation, when we have
>>> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
>>>=20
>>> Here we may just move [4Kb file] into [4Kb free]. But your =
suggestion again
>>> forces us to move 1Mb instead of 4Kb, which makes IO 256 times =
worse! This is
>>> terrible! And this is the thing I try prevent with finding a new =
interface.
>>=20
>> One idea I had, which may work for your use case, is to run =
fallocate() on
>> the *1MB-4KB file* to allocate the last 4KB in that hunk, then use =
that block
>> as the donor file for the 1MB+4KB file.  The ext4 allocation =
algorithms should
>> always give you that 4KB chunk if it is free, and that avoids the =
need to try
>> and force the allocator to select that block through some other =
method.
>=20
> Do you mean the following:
>=20
> 1)fallocate() 4K at the end of *1MB-4KB* the first file (=3D=3D> this =
increases the file length).

You can use FALLOCATE_KEEP_SIZE to avoid changing the size of the file.

> 2)EXT4_IOC_MOVE_EXT *4KB* the second file in that new hunk.
> 3)truncate 4KB at the end of the first file.
>=20
> If so, this can't be an online defrag, since some process may want to =
increase
> *1MB-4KB* file in between. This will just bring to data corruption.

You previously stated that one of the main reasons to do the defrag is =
because
the files are not being modified.  It would be possible to detect the =
case of
the file being modified by the file version and/or size and/or time =
change
before removing the fallocated block.

> Another problem is that power lose between 1 and 3 will result in that =
file
> length remain *1MB* instead of *1MB-4KB*.

With FALLOCATE_KEEP_SIZE you can just use this file as the donor file to
allocate the blocks, then migrate it to another file without having =
written
anything into it.

Cheers, Andreas






--Apple-Mail=_FC33B82C-22A5-4BDF-AE66-F782DCCC64EB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5pguIACgkQcqXauRfM
H+AE7RAAnA3cgpyKCEFCkjl7MVsIz+VvNn49sNbnnOjpoS/WE8z8eMrUcbY8oNbf
m/h7QJDTI3o23dzhUlHZmnkPZAV3lOAfodn4EKKDNsr9z4eimTHrURN5fsNPmkRE
EHKX88yaJYwnaxG/7YEUrw96Tt3JQ/v3c5rD9BbwwB+2XJ50wtnOmm+c4377zlW6
3Ja2hoeHsKGh9z5yXHqTd45vaBzyDBxKpZ1nY6ZpsxPdia1Y3LcaWKtX8Vx/qWxq
UpOT1yQTB2eDbs0QlvZUJCxCF20mVhzVVZPpDo7+JYE4JgyP1iLhnOlFm3Gg/JUT
OWNIJIvYHzUkJDTmbU9O5/eOY3FTrcEvXmFQk7tLfCPNJcmPzFx2SvynCGUdzZJP
usRCltfc9WegneLxfftvuNpze8N02l+HFQZVUbt5hc/wIx5c/C3hT+7T3GT5yz+u
S/zHZrSj+QtriUBgTaO6PeWBF1j6NaU41vDf93N+zztSAegxoCQSNpubBcq5D/Fu
4slqHHXKo4Pd2R7nn98quuGrQZEGIiOhIB3jl/jE5yHYUegKHzX5qufS6vb9oF0x
goD8CtIwB4nlp2I4JoJepT05AItNMr8wYOHqPNoW78ktzCrtkO+ghTqkQbbdV2gg
uP49eJGsamiqqGF/mGo3bDkpqho79NbuVO0edZLrgW59+I2U5dM=
=dpd9
-----END PGP SIGNATURE-----

--Apple-Mail=_FC33B82C-22A5-4BDF-AE66-F782DCCC64EB--
