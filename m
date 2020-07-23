Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E291D22B143
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGWOZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 10:25:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33348 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgGWOZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:25:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200723142537euoutp01c5bd94faaceb1e6a0ef0fdcf76eb2648~kZ9YQmaqq2632726327euoutp01Y;
        Thu, 23 Jul 2020 14:25:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200723142537euoutp01c5bd94faaceb1e6a0ef0fdcf76eb2648~kZ9YQmaqq2632726327euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595514337;
        bh=XblqhHotE04vqI3vJOD38XY1WNUqiSxUmdSjsxQlq7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4IBioIro44iP3nNPLVSmAdcUdBN9z6FHBVorMZx9vbcOzejdJnSTVjo/iODmazmr
         XpL4AMJbU/jZ9ueEq47GFTDH+c1sRIQV8CXawP8ENQt0GMeobwug/iW8CWcI7KDeIs
         i+oEknw+sJviGQ7iR/ndm45d8mpeJQKnTVHKjGIw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200723142536eucas1p14b526f8e42a720c90c14fbb3a8d7e42f~kZ9YDBYsc2192821928eucas1p1-;
        Thu, 23 Jul 2020 14:25:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.8B.06318.0ED991F5; Thu, 23
        Jul 2020 15:25:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200723142536eucas1p1105d54cc19853bca536322ee57a2e764~kZ9XpIAzk0638806388eucas1p1e;
        Thu, 23 Jul 2020 14:25:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200723142536eusmtrp26b31166e14f44aadaedac1e77ab26c23~kZ9Xn7ny12608626086eusmtrp2f;
        Thu, 23 Jul 2020 14:25:36 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-59-5f199de09441
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.40.06017.0ED991F5; Thu, 23
        Jul 2020 15:25:36 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200723142536eusmtip10ae41042e0de0f09aeb9bf6c7b8fe384~kZ9XeRlCr0172601726eusmtip1O;
        Thu, 23 Jul 2020 14:25:36 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Date:   Thu, 23 Jul 2020 16:25:34 +0200
In-Reply-To: <20200723092200.GA19922@lst.de> (Christoph Hellwig's message of
        "Thu, 23 Jul 2020 11:22:00 +0200")
Message-ID: <dleftjblk6b95t.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHveecPXvasXk7mB5FWEyDaWNyOUaapOGMD8ZHudVunSm0u9mj
        whhiXEOZjNJFaV2yUdGsHVsha9kuUqMxk9ugqYnVTkOiC9J2aqZvv+d5/v/n8s7LkOw7mR+z
        S79PMOo1iSpaQVmfDzQHfboyI3rJt19B3L3LFTLOfPsZwWXf8+VqHtZTXGtVAc2dKqpCXJnj
        g5xzlvylufYMt5xr/uuUhSv4ytIzNF93eYjiq9+k0XyGpRTxvZUBfGWHm+Drjv+UbZZvVYTG
        CYm7UgRjcFiMIiGn10oldbH789MHqDTknpKOvBjAy6D9xmMiHSkYFt9CkN5yl5KCnwgedL+n
        PSoW9yJo7Js37ui54hoTlSDIOWoipaALgav+3YiDYWishrKyLR7DNKyCTlcT8mhI/ImAH09s
        pKcwFa+G34Xf5R6m8AKoa+gYzXvhvXD9y1vCw0q8Et66a0Y10/EqsHz5KJfyPlCf20F5mMQ6
        yG3uHh0AuE8Or/JPENKqkVCQaxnjqeByWuQSz4RhWxHhWRTwEbiYtULynkNgLeinJM1qeP9y
        kJZ4LVj/vUCS3hva3D7SXG/IsuaQUloJp0+ykno+lGfWjHXxg/OuW0hiHuwdRWNvVUiA0+yk
        LqA5eRPOyZtwTt5IWxIvhIqqYCm9GG4WfyMlXgPl5T3UVSQrRb5CsqiLF8QQvZCqFjU6MVkf
        r4416CrRyDdr/Ofse4Ae/dHaEWaQarISDs+IZmWaFPGAzo7mj3Rqv3u7BflReoNeUE1TRjQ1
        7mSVcZoDBwWjIdqYnCiIduTPUCpfZYjp6w4Wx2v2CXsEIUkwjlcJxssvDd1JDY0y1E+3DrED
        tk2RxQ2XDtHacNuf+8rAmBT6s9mSMFjcs747wlHhcGzvPPMwacP148OB2sJY0aB2+G82mWbP
        jQmvvsadCIj+Navp1MuwnVsyW0uC1qW2vDY3HfP11x7ilwcqnn6ure2fpAuwnrVvVHPC6TtR
        u7etn5LdVlClUVFigmbpItIoav4DMO3P624DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7oP5krGGxybJG6xccZ6VouVq48y
        WUzbKG6xZ+9JFovLu+awWbTP38VosfbIXXaL48v/slk86nvLbnH+73FWBy6PTas62TxOzPjN
        4rH7ZgObR9+WVYwenzfJeWx68pbJ40TLF9YA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOmft7EUPBeqmN31k6WB8S1/FyMnh4SAicT7ua9Y
        uhi5OIQEljJKfNx7jL2LkQMoISWxcm46RI2wxJ9rXWwQNU8ZJVZumsoKUsMmoCexdm0ESI2I
        gJLE01dnGUFsZoHrTBIHZ5iA2MIC1hLf531kh+idxyRxfOVxFpAEi4CqxIlTT5hBbE6BQokl
        L24xgdi8AuYSt97uYQexRQUsJba8uM8OEReUODnzCQvEgmyJr6ufM09gFJiFJDULSWoW0HnM
        ApoS63fpQ4S1JZYtfM0MYdtKrFv3nmUBI+sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwEjc
        duznlh2MXe+CDzEKcDAq8fBK1EnGC7EmlhVX5h5iVAEa82jD6guMUix5+XmpSiK8TmdPxwnx
        piRWVqUW5ccXleakFh9iNAX6cyKzlGhyPjB55JXEG5oamltYGpobmxubWSiJ83YIHIwREkhP
        LEnNTk0tSC2C6WPi4JRqYMxY9NZA/Fb8lhObOd//2avhYaciO+XXXo4yD7Ol71htZ1YL7b36
        39xj75xDzYXlU6pD5R/OiU6VX/7t0urY4n1iGVxzBQ4v5bHO4MhWmbXkV0icxuHVn1S23Ty8
        hK2lzLvH82KL084KpjyWyQcEmiYWPXjnPrXHuMjjuGnduv2GG4OvJs6P71ViKc5INNRiLipO
        BAACTmjg5gIAAA==
X-CMS-MailID: 20200723142536eucas1p1105d54cc19853bca536322ee57a2e764
X-Msg-Generator: CA
X-RootMTR: 20200717205549eucas1p13fca9a8496836faa71df515524743648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200717205549eucas1p13fca9a8496836faa71df515524743648
References: <20200714190427.4332-1-hch@lst.de>
        <20200714190427.4332-17-hch@lst.de>
        <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com>
        <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
        <20200718100035.GA8856@lst.de> <20200723092200.GA19922@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-07-23 czw 11:22>, when Christoph Hellwig wrote:
> On Sat, Jul 18, 2020 at 12:00:35PM +0200, Christoph Hellwig wrote:
>> On Fri, Jul 17, 2020 at 10:55:48PM +0200, Marek Szyprowski wrote:
>>> On 14.07.2020 21:04, Christoph Hellwig wrote:
>>>> Just use d_genocide instead of iterating through the root directory
>>>> with cumbersome userspace-like APIs.  This also ensures we actually
>>>> remove files that are not direct children of the root entry, which
>>>> the old code failed to do.
>>>>
>>>> Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>=20
>>> This patch breaks initrd support ;-(
>>>=20
>>> I use initrd to deploy kernel modules on my test machines. It was
>>> automatically mounted on /initrd. /lib/modules is just a symlink to
>>> /initrd. I know that initrd support is marked as deprecated, but it
>>> would be really nice to give people some time to update their
>>> machines before breaking the stuff.
>>=20
>> Looks like your setup did rely on the /dev/ notes from the built-in
>> initramfs to be preserved.

Our initrd image contains only the modules directory and 5.8.0-rc5-next-202=
00717
in it.

>> Can you comment out the call to d_genocide?  It seems like for your
>> the fact that clean_rootfs didn't actually clean up was a feature and
>> not a bug.
>>=20
>> I guess the old, pre-2008 code also wouldn't have worked for you in
>> that case.
>
> Did you get a chance to try this?

Indeed, commenting out d_genocide() helps.

Kind regards,
=C5=81S

PS. Marek is currently out of office.
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl8Znd4ACgkQsK4enJil
gBCbRwf/a8zcYpq6fg33J7fIlOcoksF9Af2NtQiylKh+dwApPMNMHisMvMZSiqjJ
2e7fkz2A/7RgmFIuZy4INXlKBO1BUKC8iePYl8keZNbpc+r3Tn8dx4+uCFq0zVGZ
CbIcosS97UJ5sdDRvdBPPHISN4ujFnVkSrmvFbFLLRpVF0+RxKpaPLLFc/OHlp9s
KX0vJSICnxsS4sabz/HYURUoRqsMwqo+O/di8aCurcBR/1hVU93ypL0a1KulGx8W
XucamIFSYjMSUjb2/UGxA2wK4OnvY7PRORBFqzc7jnyBFfd3SHnVnUQ8LIqykF/x
VuX6fRL3WIeruj3QAxeYcm0uZaqzXQ==
=uiDC
-----END PGP SIGNATURE-----
--=-=-=--
