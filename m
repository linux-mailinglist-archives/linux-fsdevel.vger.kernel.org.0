Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44F81F4CF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFJFcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 01:32:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:47517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgFJFcI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591767121;
        bh=msqaLqhxFiUjy1LVlI0iCTuuXeGECM1wVXQaZojvlyw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kzEND3nGLda/SHhcBucprH0K1ZgNhMQoP8f/UzWQ31YyG5iUCFNYHT/oMxBb98QVP
         MuOSL2NvRmPNn23g6BPg7AHZsdNFNQicztIIlfxHIdNoxZG8QnEe9cIoakd8QE4Fkz
         oYoPxS37roNzcG4m7siEhxdLZGRRjpd3DCRg1JNQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1jVbe41pR2-00M5Oo; Wed, 10
 Jun 2020 07:32:01 +0200
Subject: Re: [PATCH 0/3] Transient errors in Direct I/O
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, darrick.wong@oracle.com
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de
References: <20200605204838.10765-1-rgoldwyn@suse.de>
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
Message-ID: <3e11c9ae-15c5-c52a-2e8a-14756a5ef967@gmx.com>
Date:   Wed, 10 Jun 2020 13:31:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605204838.10765-1-rgoldwyn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UwriEpcEbvITRWTqK0nMzxsxDfm5vx2Ij"
X-Provags-ID: V03:K1:I/CFY2hVCL4VEu3RUsW4d3/oRmoGgZECWZ/o5/JTfhRMwVtsUbX
 fUp1s9Tiw0s0dM7Z3zeWVBJulKPBcSEw/TQ43AmRJX//hahXF7AMsHXBvPFKuRM5W1Pb/my
 4sbUjH8E1jUtl6KJMnAGTWt+rfZHxUG9pF8pLzZcdNnd1Ibvwgxof0/2Cd8EpZq7/OLh8ys
 ON//5cN9Bn2niNzwg/jaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:irRcDd7PUek=:otlDwxAH1Qul7sLq/qKPFB
 CUj+SIh0XhggJt1im/IuJOyhUm8sxf7s0kFdmX33v9HfZsumWJUU2Tza/23WQ5kkz8tyTFWDj
 63bHOWwP6F6jsqc9k/alKB2rYzEHSGYu9pczArnScSq7XdQSagNSaVsFHfflcFsR/upGfyDcK
 bD2v9lSRQTmPbJ16KkryHcVev7WLgh5/zcMBvRSQXc7x6C2ZhyKospGkNjxk6yGuhnu1JXZTu
 T4LzZbUta8Kc9tGV8Sc2h9KZftSmSV768KLdh4gIbu9aG4YIyO3mETtbyO6fXH4Tiuw67MtP4
 fqO/PjE8grrzlAJyo1a9JXpEy36GZfQaJHPcSHRJvZu+SxySgu0SE6T9SaxhQ2o4cqwFSJco4
 BTD7M3XZfxiAEu6K1odeDJzonC0wEDm+Hg4rvTW39GFtEJKNSE/NxvcFV5uZpTm2S1vT251JN
 i3QnumG87TCubVo5H06wwAi5r1maDMIAkpOSIlPfMZpC3Gz79k0Pk/To9NwarpK1pcLSRuf8E
 VEiN2Le3nAGt5xPh1wqdNh+a+5aJqqpbQgqyTDOAYYknBJHIsYl1+AnZZ50l6JMTiZZqJNWrb
 QkupdvjiaTvf3vMaCZJIg0XVxvAVDZMxubRxaDLFsgMT6+A2iWXajEZZ6lz+WGOVKZ8AYMQOA
 1B4YpQKZciFzGqvlQfyNYIyu8TevovENxyWMvq9lsbuwYRDAlMoH+miRrpa2a3gQUKuKPLMv/
 MuDsVwy6ofh7ufCkB+KbwFcWuE6YA8GiH1f4WCgjeiY0OY1FQAGXWYDFpkSlxG2WGYNzCB2dE
 HlfQEY2784WWiIvHoBc6iGIf6AO29L4Hdi90l343Kk/5bu65NgKbOJkBT5QbQUXzKenBTYTd9
 cge1rR+TH5STTvPzaPR2LyCzgl2+wco2T8Qzjnf07kPeTC+5aBRYzXTIx8yHquJ9/46LjqpEB
 k6z2ShZg+qd27NmicnefMyU6nv1R3TGjQOAnc4g/FsJu/2rbAYOfsN42QkIggFr4W0w7x6E91
 EJOMXPpO5TzuSnn2oB53VpJBSNwxDzzK4N4PWJEEUQdnniogwoq6i3D/GAZtXABCUjf+4QCgU
 Uxk1PRk8g9mJccHFEaqCjtxIu18sHHAe31gxhnrkQzSNdQ2V86CsX6lcr43/PwXfp6uxLtQnS
 SEwvdr4Uoj4vZjeSr46PGUwwmzZPu3mJNF5LLbJwK+LLlUm8PbmkL+TmNDdzIkX2RzhMMbJxF
 5itCgcssqAWkThunq
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwriEpcEbvITRWTqK0nMzxsxDfm5vx2Ij
Content-Type: multipart/mixed; boundary="5ytK7vIJ0N5OqTXf8ZIq2LLscYp7RtVMO"

--5ytK7vIJ0N5OqTXf8ZIq2LLscYp7RtVMO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/6 =E4=B8=8A=E5=8D=884:48, Goldwyn Rodrigues wrote:
> In current scenarios, for XFS, it would mean that a page invalidation
> would end up being a writeback error. So, if iomap returns zero, fall
> back to biffered I/O. XFS has never supported fallback to buffered I/O.=

> I hope it is not "never will" ;)
>=20
> With mixed buffered and direct writes in btrfs, the pages may not be
> released the extent may be locked in the ordered extents cleanup thread=
,

I'm wondering can we handle this case in a different way.

In fact btrfs has its own special handling for invalidating pages.
Btrfs will first look for any ordered extents covering the page, finish
the ordered extent manually, then invalidate the page.

I'm not sure why invalidate_inode_pages2_range() used in dio iomap code
does not use the fs specific invalidatepage(), but only do_lander_page()
then releasepage().

Shouldn'y we btrfs implement the lander_page() to handle ordered extents
properly?
Or is there any special requirement?

Thanks,
Qu

> which must make changes to the btrfs trees. In case of btrfs, if it is
> possible to wait, depending on the memory flags passed, wait for extent=

> bit to be cleared so direct I/O is executed so there is no need to
> fallback to buffered I/O.
>=20


--5ytK7vIJ0N5OqTXf8ZIq2LLscYp7RtVMO--

--UwriEpcEbvITRWTqK0nMzxsxDfm5vx2Ij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7gcEsACgkQwj2R86El
/qhvlwgAlD8i+I6diayq6iaCSku5xORSLe6pL5jSuWxWf6IWPJXH+35601zlpKmG
hkUP9gmaYlz44idlUkG8sunWMuZA44zkj87DYgFD1nbpJNgkV9zcGIoeIOHI60pJ
UVLr1I1pwwItYDIWx9YI3spsvRPmOeAO7rxn9jNQEjGfY+BDcLLJY0PQunU5jDuU
HTI3bzkf9/ahOZu7gfmxpCr7CnXFS+ORUbdS7ofCjfu/YELCZupOY0nanc+OH9Zr
dDSbvij+4nFRQWAqMg8r4KQV+RKB8LgHElerL9zshb+/I5RpIT1uU2Bn89guFsZK
vYJdp1Vr4qjh4AEBpUmq5Uixj3pDXg==
=lMP0
-----END PGP SIGNATURE-----

--UwriEpcEbvITRWTqK0nMzxsxDfm5vx2Ij--
