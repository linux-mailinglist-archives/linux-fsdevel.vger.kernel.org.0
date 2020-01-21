Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDE14351B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 02:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUBTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 20:19:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:38879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgAUBTI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579569515;
        bh=oTlDEaLG5Nt0gzAEawE+XlzOYsXgyEVHFpGYMOChapE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dKLKbQcSiOI+R9LjHdqwIF6CHK8wD6g1KEkrxx4JNw1t1wpWgCEUQ3anLo+l+T0ue
         azHEkjIeGIH0CyZR3o5QKqdaL6I+BaJ25WofN6fcEXcFO5NaD7kqsj6l8OZwnUi0wf
         lH9ts1T9KVK4vG0ewHez6Krac/IVATamV3D/HRX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V0H-1jceQP1dYV-013wBA; Tue, 21
 Jan 2020 02:18:35 +0100
Subject: Re: [LFS/MM TOPIC] fs reflink issues, fs online scrub/check, etc
To:     Steve French <smfrench@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org, xfs <xfs@oss.sgi.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
References: <20160210191715.GB6339@birch.djwong.org>
 <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
Date:   Tue, 21 Jan 2020 09:18:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qq0KCP7NpJNIkStCipMQK0TD8KG42ST8M"
X-Provags-ID: V03:K1:nwZCbeQSpGnB2OP/IQcoN6qmmAGA9WF86eZ1MGwdwKrtPU3TsUP
 uTCHnk95e52IGQfJT94uPzXnLhwphqLzc5OEOmwv0xfwzPruw3XU0UP/I/Gs9XA7Xw6mF7p
 QL1UYcu61PmFZzIwZS9XYRXeHeUYQLvuw8tlrtb6oLqsZHOeKmbdG8iyZQDJq+Mim0gNL8m
 oYoptp2wBv8mIXcBFPRFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NRZkb8C+WZE=:R/MVio9tLvSLETSSqIKRRe
 sxQXNIq2x3k6PR+12wd2VKF1OuVQq8nJk56ZglSUwMwuwqjAUR6d1l2QQ6mdnUYP1FkmDBy/u
 mUj6OQ1X1ARU95cmreWjpQ6fWPXztzEslPSQkUcSOjR++60RtRgS2Y6xwbSacveNVTz/J+JFI
 UkycC5xWqSyPsJ8LOKZlDBIsdsE5AvmQgSuz+e8YY9ixGpxHxH8GicqOmQf0IqDkT86nS6/RT
 1uskG72unlEvxmqvuBYP6iYApa+K7rpbiLreothL502D/FWxg4yEDbKFLbfb7M0mdgG02S2Ny
 cdmSeE8lOCadp66DLFY+n/6aeAr84GQoXC8/dHul13ZlWDa9jNgl5HsdPt1PM8e/9vzA6THyS
 4X9ScLtjy3omu7No8Vef+4Br4huWrCDaNyG76wqkUWnhGO8hrsjgKwriKXmhO5ajbVhqwL4lO
 pRO6kpcuS11tde13mucRI/L9d6A0H74YIemoU9mKo0VRpAqgG4QyUagc5xX2SA85QTFNqMf6D
 0358qDFCkKFNIuo7D5EIxqt0KFqYVzFXE+mI7e9ccQMLq0ObY3R3CYZaXCIr+JXKxYGM84MSh
 80mc3Ee6ky3vUwaGVREoMeDQBm3i9fAg1rtOimouam5+FXhN2N8Ei/PKProDOpluxTSHY41o5
 EOU30874WuAi9sYKpzI/j4cPNLxLcPtdak/OTXl4gIYAxoXyzIg88B8OUN3ENIZiKMgV2+Cil
 Dc8yNheM53tFioht/NZHNbTp6S/pzxW/n8aQBaSUYO2E38fh4bs4+YLLlSjXIhWP8d+IZ4170
 xePGHK2BtpyODDBcJRl/51LHitby2y+FoNUrwA7mPK8mosbSKjjBp5RrGI9Qemetr9nYMCalK
 S9wm6aE8oBQm989FA3mwgGcZVc0zNhEtcNFkMTeLM3U0Cmae0Th4qqKfRrSk0bZX4AEPCKQ27
 0QUoUkx261XNZoj8rNJQ8F1RBHT6XU86gak9pGpEKzfn7GT1ilsUG/xe9XjK2rAHXgLuPmcNb
 8YT0tx04SjYbBdPp46IOIJUeaccZPhj7HEkYdjXgc4jcncghQTJHfUJ5tf7J88dS13HRIudL4
 f5CnqMZHYd7/BXy+kRzPdokSu5K0fOh6uWjQxr8iXaOagmHphvuN6eRH53qJ4PQ/BOBeRkLyS
 Owqk4UzJCkYg1r838p8JlM5/NA+lm0wLecUslAR+bZwjE/xCGC1zIT5QvUELgKvGlfacr6iTr
 tBpFDgIIMG8LFokKGNJC4iwGuRKdDPxG+eZomRR86fOvTutsma6KOXa08XWg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qq0KCP7NpJNIkStCipMQK0TD8KG42ST8M
Content-Type: multipart/mixed; boundary="XlLjsP7dgzWpBqYJzOXOyVoQQEB9Mc2Iu"

--XlLjsP7dgzWpBqYJzOXOyVoQQEB9Mc2Iu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Didn't see the original mail, so reply here.

On 2020/1/21 =E4=B8=8A=E5=8D=888:58, Steve French wrote:
> Since SMB3 protocol has at least three ways to do copy offload (server
> side copy),
> the reflink topic is of interest to me and likely useful to discuss
> for Samba server as
> well as client (cifs.ko)
>=20
> On Wed, Feb 10, 2016 at 1:19 PM Darrick J. Wong <darrick.wong@oracle.co=
m> wrote:
>>
>> [resend, email exploded, sorry...]
>>
>> Hi,
>>
>> I want to discuss a few FS related topics that I haven't already seen =
on
>> the mailing lists:
>>
>>  * Shared pagecache pages for reflinked files (and by extension making=
 dax
>>    work with reflink on xfs)

IIRC Goldwyn Rodrigues <rgoldwyn@suse.com> is working on this, mostly
for btrfs, but should also apply to other fses.

>>
>>  * Providing a simple interface for scrubbing filesystem metadata in t=
he
>>    background (the online check thing).  Ideally we'd make it easy to =
discover
>>    what kind of metadata there is to check and provide a simple interf=
ace to
>>    check the metadata, once discovered.  This is a tricky interface to=
pic
>>    since FS design differs pretty widely.

Although btrfs has already implemented scrub for a long time, and btrfs
is coming over the point where kernel can detects more problems than
btrfs-check, I still hesitate to call it "check the metadata".

It looks more like "extended metadata sanity verification", other than
full cross-ref check implemented in user-space tools.

Currently, btrfs (and I guess xfs too) can detect corrupted metadata by:
- checksum
  All modern fses have similar mechanism.

- internal fields checking at read time
  At least btrfs is trying to do a byte-per-byte check for each fields.
  And latest such check has killed tons of fuzzed images (I guess that's
  why a lot of such CVE/fuzzed image reporters only want to report on
  older kernels).

  But this is mostly based on the fact that btrfs on-disk fields has a
  lot of redundancy. E.g. btrfs uses bytenr, not block count, allowing
  us to detect bit flips in lower bits easily.
  So not all fs could follow this step.

  But this provides us a good centralized place to validate most tree
  blocks.

  Maybe other fs devs could share such details too?

- runtime sanity check across metadata boundaries
  This is the traditional methods.

So is that xfs online scrub just a similar thing, or a full cross-ref che=
ck?

And if so, can we find a less confusing naming for the interface first?

>>
>>  * Rudimentary online repair and rebuilding (xfs) from secondary metad=
ata

My guess is, it's checksum and copy based.
Or just like btrfs, if checksum passes but internal checks still failed,
just try next copy?

>>
>>  * Working out the variances in the btrfs/xfs/ocfs2/nfs reflink implem=
entations
>>    and making sure they all get test coverage

That would be great!

Thanks,
Qu

>>
>> I would also like participate in some of the proposed discussions:
>>
>>  * The ext4 summit (and whatever meeting of XFS devs may happen)
>>
>>  * Integrating existing filesystems into pmem, or hallway bofs about d=
esigning
>>    new filesystems for pmem
>>
>>  * Actually seeing the fs developers (well, everyone!) in person again=
 :)
>>
>> --Darrick
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsdeve=
l" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20


--XlLjsP7dgzWpBqYJzOXOyVoQQEB9Mc2Iu--

--Qq0KCP7NpJNIkStCipMQK0TD8KG42ST8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mUWQACgkQwj2R86El
/qg2hQf/bV2A+E7hSFyFmFewaDjGQSjWWiJvxOnW3FDWEufZ3w6hgWm0YrjoB1hu
j4lkKCmp9NUQzp9ZSE5OYrziQHq11HPj9TH1pLmjDi3AyKAC7Ep4jPQJCmnXSv+W
bzrheqRjqeGvICJJOh+ksc2YR4mH6bbNWn4MstBjDG6d3JvHwiNU6Bjq4mVaUN03
RNkB0JUeYC/0rZHK18CYVYrHs1c6uVIjmpKXr1KEgPFdDVhxAPjmjrKGU6C3icOv
D8HfGW4PgYnKTWFSA7kopeafkqf0OgPUNe61IM6jtXpqP9aF2QOhEriI8P9zdNW3
o36PossEk/B3pnurdUAMG6cBeDyBhQ==
=gYmi
-----END PGP SIGNATURE-----

--Qq0KCP7NpJNIkStCipMQK0TD8KG42ST8M--
