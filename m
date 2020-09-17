Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64E326D2D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 06:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQEwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 00:52:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:57243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgIQEwc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:52:32 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 00:52:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600318343;
        bh=kQoxDSmnfJbFZ5jzvzcVS1lmkvrPjqxih9h2RaAxn0s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MRyOvPnb74HjTMFxzwv5fttJsiTBopJ3UbP5TsnPMJmo0xtyw8BEOT2IaTIFAk3NZ
         /FTbrElVADulLZp/Z9ttmq7Oyt5f7YiVEBGNo5IpSNfnQRUwUgvIhCJTU+sq0c7u3q
         NKON48saff08aBYP94yjnFKB0lIlU1fW1RRuza5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBlxW-1kDESL0r1Q-00CC5V; Thu, 17
 Sep 2020 06:46:57 +0200
Subject: Re: THP support for btrfs
To:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200917033021.GR5449@casper.infradead.org>
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
Message-ID: <7baf1a4c-1eed-7aa8-fcf1-12c947d8cd3d@gmx.com>
Date:   Thu, 17 Sep 2020 12:46:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917033021.GR5449@casper.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik"
X-Provags-ID: V03:K1:IQzrRWivPrWbGkAC2F9q5ewvnzAZYaivwVkTBUrb38qwGMBvsm9
 1qr11LlOS/VIUCYyqVzfZnRJxDP1zl1ODkGYZA/ICJx9SOflzzmzSoc41ej0O6/A7CHvGdT
 qrKOFQTskVcUObkEgXT+xVmyHhO5LoBEfoYJhMbHAVE0XoCQdWZNIFbwjSipN9LLZCGVpjy
 J/OOHw+AsT0yaKLgOWQTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VdfQYukqe/8=:Dqr3dikWVQgERhV8dIPeyQ
 1IsNCfJLK1LAImS+9LuFvXv/5RrDEBvrI86wAidm+7N/qNGVQLsoRLl8ypU2KVymGRAR8HrnR
 hRQR2baQ8YoHCWXWMcKiHBhkrBnE9/5+OspxkL0e5gmNanczjtmgVTQ/vxwwWkGNK/pCRMUcc
 oWw6RbiOoYyRDQ7ErOS9caE6wjrEbnFag7h8IjfaurwB2N/UtXDg8thgOGCJGOogOpxC8xr4+
 DmXr0mhytnKT9q+E1zpId6jHDwZyhZULLRjtXejAaT9fnKi0Ldi/BcLMR3il7a2ilY2UQfM/X
 odE8HaN3uW0JePzZ9Xv8HcJYg0ZWjzCj/PX2GoT4TMPylQ0ltRizr7P/hblJ2UBYq1R1fKemB
 pPyGE+rHytWzOc5kFMC6aeIaXcVFGkwJMbIoiZ7jssP5oRlbL9Ui6FMEsWTtyoumyznfrGiie
 89k7zgKeFrGieoMv88sCAxvsjs8N1+dSARF3dqkAnwtqC6Mm0zSGNToPfKciZBUWZNa95pni5
 Xymb/uRCWmqjkqnzbGeMBz877sVxppegGEJ9+QpHdd/YjrAMoqj4/lpguZEx742zkimFr0BxC
 4KgasfCpnUjG1dpzHgmZqty4a19xf/mbeH392+mfg6kjqT6xW0iJ78fI7F0CAq8tjmai/R3dT
 i/Z8CtgEdCL9e7hi3mSm2ATgmQ4mvnUgobdb+R3MX6WsAXZIHUFa3JEshqVhS49pO8kezaTzC
 uiWhDIx9bhX4Ef+x/I3/YEJeY1pZmCknk6OcR9SDDnx67ZkTFqtvvUPkJrx2Fe1qJHLG7vsXz
 YLRC8TDwp1NzYN1IqRkqOiiy7vvjN+hqtrTY1G7rMJt3uqwRqv7IflYqGxpbxFZzihO56LmrQ
 3uVF1QEc/a3llOR1DLzWDTg8Wh7mZeQzVvB2AErWjjrwCwtleoAQHcMHOtT8dnTwlLdKewBeG
 gi+vgrBnLk+yRWEQEs5Mif5flgMhvbmt5za0BYnLBdbZngsJ3t/p05ooeUz05P9fyxyGYx+2V
 wmsOmRHXF8Y1qFlSx4t0adLwE/aP8PZVKfhmL73qHN+FjqJp3HWoN+ZwhBjIrO+0Jg77MQ/1J
 0BgxdGbhE/7QeorSgAg6Imt4IMXOCBjEZDjC3j6xtKOQvIwPlI1qd0qvoeh7pciXUKXp3mmIi
 O6jdIascZvzHpuUO8dFIFeCKWqGGqMTpT/vdw4ctegtdYehOSPni2nkrNG7DDkkPt77tdJ0G5
 EuKY8Nib7Ya5iACGJAcN6QXpy7Hj3Wg1r6nd0PA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik
Content-Type: multipart/mixed; boundary="dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa"

--dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8A=E5=8D=8811:30, Matthew Wilcox wrote:
> I was pointed at the patches posted this week for sub-page support in
> btrfs, and I thought it might be a good idea to mention that THP suppor=
t
> is going to hit many of the same issues as sub-PAGE_SIZE blocks, so if
> you're thinking about sub-page block sizes, it might be a good idea to
> add THP support at the same time, or at least be aware of it when you'r=
e
> working on those patches to make THP work in the future.

That looks pretty interesting,

>=20
> While the patches have not entirely landed yet, complete (in that it
> passes xfstests on my laptop) support is available here:
> http://git.infradead.org/users/willy/pagecache.git
>=20
> About 40 of the 100 patches are in Andrew Morton's tree or the iomap
> tree waiting for the next merge window, and I'd like to get the rest
> upstream in the merge window after that.  About 20-25 of the patches ar=
e
> to iomap/xfs and the rest are generic MM/FS support.
>=20
> The first difference you'll see after setting the flag indicating
> that your filesystem supports THPs is transparent huge pages being
> passed to ->readahead().  You should submit I/Os to read every byte
> in those pages, not just the first PAGE_SIZE bytes ;-)  Likewise, when
> writepages/writepage is called, you'll want to write back every dirty
> byte in that page, not just the first PAGE_SIZE bytes.
>=20
> If there's a page error (I strongly recommend error injection), you'll
> also see these pages being passed to ->readpage and ->write_begin
> without being PageUptodate, and again, you'll have to handle reads
> for the parts of the page which are not Uptodate.
>=20
> You'll have to handle invalidatepage being called from the truncate /
> page split path.
>=20
> page_mkwrite can be called with a tail page.  You should be sure to mar=
k
> the entire page as dirty (we only track dirty state on a per-THP basis,=

> not per-subpage basis).
>=20
> ---
>=20
> I see btrfs is switching to iomap for the directIO path.  Has any
> consideration been given to switching to iomap for the buffered I/O pat=
h?

Yep, IIRC Goldwyn is already working on that.

Furthermore, we're even considering to utilize iomap for subpage
metadata support (currently we set metadata Private for metadata, and
for subpage, we don't utilize page::private at all)

But that would happen in the future, at least after RW subpage support.

And I'm definitely going to add that support in the future, and
hopefully with much smaller code change.

Thanks,
Qu

> Or is that just too much work?
>=20


--dO7wkxelbvp7sjBO6kt2r7YgiszVM2XUa--

--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9i6j0ACgkQwj2R86El
/qgDEQgAop1w63lLZce/NCVEy9pmV0Md1YjO6ZgSEISC6QCQ23+KGgmL9Ri/iqMT
ujD6UhkDcj8V65HmB4izYr4m0NJ0/6c9LqIqf7WsFFrQXnu9BsoEmcugAyVFrguI
kImT1YPO3rD7IOjzFGCw4hfYBpjn0UtylLs/CHnadivis92jIXNC03dRk2huZftZ
IMVwnt4NFSjNrjafK0HL5A46N6aujs8Zlvxj3BzaECv1IU3RMLppKZCRZNTZvefy
1HCYmE2h1tlSF9aE6eTyilVrTMwQm1PXhrYxTaO/zI1cLVxbFthOxU3/di+9BVek
mwkCXf0oTSA6p2P1vXa/wCxxhnIIVg==
=5azP
-----END PGP SIGNATURE-----

--8YVflac2Qfe8ArYRLd4ESRTswNNKGD5Ik--
