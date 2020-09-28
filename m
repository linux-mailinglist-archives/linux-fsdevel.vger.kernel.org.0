Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2B27A8C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgI1Hgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 03:36:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20479 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgI1Hgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:36:35 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200928073630epoutp0252229998cd0bd57da66d1bd37a2e38de~44mTxuh2D0500105001epoutp023
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 07:36:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200928073630epoutp0252229998cd0bd57da66d1bd37a2e38de~44mTxuh2D0500105001epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601278590;
        bh=/eNg35GSx+5wKcMvCxYpylGbCIBkVaA6FzkgrihSYWE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VEYznmnJlRN2nOzZIEl4JecZVnQ8Z+jqIgYL0bh7Vm1PZTsaTcTAFYgH2SIN2kwzW
         UbcIY/MrJXWKG3JFa8QsJht1WqQtM53tiJavz+/shNFnLUbYOHa1HI598Bl9VIUdSh
         byYtKks52FtXv2K/d4HwoNctRbvHW9BOnljxmzKY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200928073630epcas1p188bcd59a492f0225edf3698d260da55f~44mTawYbQ0605706057epcas1p1l;
        Mon, 28 Sep 2020 07:36:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4C0Dq11nRQzMqYkW; Mon, 28 Sep
        2020 07:36:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.EC.09918.D72917F5; Mon, 28 Sep 2020 16:36:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200928073628epcas1p370edee44b209aa1a652492e04ead4b98~44mSDqt6v1994219942epcas1p3A;
        Mon, 28 Sep 2020 07:36:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200928073628epsmtrp1b76ab81dd7a5844ac21b75b1920ffa8d~44mSDAxZa0720907209epsmtrp1T;
        Mon, 28 Sep 2020 07:36:28 +0000 (GMT)
X-AuditID: b6c32a36-713ff700000026be-58-5f71927d6122
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.49.08604.C72917F5; Mon, 28 Sep 2020 16:36:28 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200928073628epsmtip1b726d12d45b234b77eb964550f0c3aa2~44mR0kwuf2573825738epsmtip1F;
        Mon, 28 Sep 2020 07:36:28 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
Subject: RE: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Date:   Mon, 28 Sep 2020 16:36:28 +0900
Message-ID: <8c9701d6956a$13898560$3a9c9020$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGgZsB+KXs97exselB5tzyGrN5ddgLZy8s5AfgkmQwBsa3Piam1eW8Q
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmgW7tpMJ4g/O/uCx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJNx7fVRpoKvAhWz/0k0MC7j7WLk5JAQMJE4OvEcexcjF4eQwA5GiSvzvzFCOJ8Y
        Jb6f+cYM4XxjlDiw6wWQwwHWMnG1OUR8L6PEkb27WUFGCQm8ZJT48zoTxGYT0JV4cuMnM4gt
        IqAncfLkdTYQm1mgkUnixMtsEJtTwFZiwYazjCC2sICnROOXNSwgNouAqsSW/h6wmbwClhI/
        Z8xngbAFJU7OfMICMUdbYtnC18wQLyhI7P50lBVil5vEzZ4uZogaEYnZnW1gD0gITOWQ+NM9
        iRGiwUWibdkkqGZhiVfHt7BD2FISL/vboOx6if/z17JDNLcwSjz8tI0J4nt7ifeXLEBMZgFN
        ifW79CHKFSV2/p7LCLGXT+LdV5D7Qap5JTrahCBKVCS+f9jJArPpyo+rTBMYlWYh+WwWks9m
        IflgFsKyBYwsqxjFUguKc9NTiw0LjJCjehMjOJFqme1gnPT2g94hRiYOxkOMEhzMSiK8vjkF
        8UK8KYmVValF+fFFpTmpxYcYTYFhPZFZSjQ5H5jK80riDU2NjI2NLUzMzM1MjZXEeR/eUogX
        EkhPLEnNTk0tSC2C6WPi4JRqYAqqTV9x59ZGbi/XCwtFf9798E7ou0iKZtSW98fL5pzM3N25
        +8mpWau+ZDG4snIli7mcvOpy+tXq84tYc/kevjfecfQO166SdB+uQ/k8H+fvlTU4MnUS956N
        hvN+/GhMKvb2Tih/fTm2hythv7F3rVB7y5eer+lZ/BsrzN/x+P/wKBcoCN4ecU6mhylYNk/8
        zLq/m9uz2KTFGxu0rvvKHDy2dp6t25N3L164P1X/syfx5sRju6ZNsymeZeG/vMc+cbtAwrqy
        fQcVE/7pb5U1NIrYuGqXptq0Unf9b4e/RUy91rVq/7P7WyVVSnYeZ/vCxzhfSmbm1KTmdYvf
        cE901HocfORsUeCztese/ZsQy/FMiaU4I9FQi7moOBEAf2ECmy0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTrdmUmG8wZe12hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlNB73KXgkULFixjy2BsaJvF2MHBwSAiYSE1ebdzFycQgJ
        7GaU6Fvezw4Rl5I4uE8TwhSWOHy4GKLkOaNE9+JHjF2MnBxsAroST278ZAaxRQT0JE6evM4G
        UsQs0Mwk0fqlmQmi4yWjxLqvfWBVnAK2Egs2nAXrFhbwlGj8soYFxGYRUJXY0t/DCmLzClhK
        /JwxnwXCFpQ4OfMJmM0soC3R+7CVEcZetvA12EwJAQWJ3Z+OskJc4SZxs6eLGaJGRGJ2Zxvz
        BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcU1qa
        Oxi3r/qgd4iRiYPxEKMEB7OSCK9vTkG8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4bhQvjhATS
        E0tSs1NTC1KLYLJMHJxSDUxbg1u93n41vOejpl/D0T35rpxGCk/1nPeLl0w5x67ya8qCU+mu
        iROi3zNOEJcKvTl7J0/ipiJ1t96oqfwciwo3BXlbbg58N9HNkps55thhppmy3tr857w0+xk7
        ln6cduC9mGtu772LGamzPxgpBB++9Gxv4yL9ppN/3U71rNmXK3/tZ+KtiRF/koskirU/9WZZ
        lWvXd+rcqNKVWC/vYHNB22fD9oqMYzM1pwXG7JXR/TV/ieqVqkMa3oXV8Z3ysxS3t6r6bmva
        unzVkcXx4vEmDNUzXXetrnjW4Mp+qvRlzGvJj8lLo12cmXRrwwP9JS/npfy93fhb/PnlaAbZ
        jOs/GGcof4h82rhizv3HlkosxRmJhlrMRcWJABAJKLQYAwAA
X-CMS-MailID: 20200928073628epcas1p370edee44b209aa1a652492e04ead4b98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
        <20200911044506.13912-1-kohada.t2@gmail.com>
        <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
        <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >> --- a/fs/exfat/namei.c
> >> +++ b/fs/exfat/namei.c
> >> =40=40 -1095,11 +1095,6 =40=40 static int exfat_move_file(struct inode
> >> *inode, struct exfat_chain *p_olddir,
> >>   	if (=21epmov)
> >>   		return -EIO;
> >>
> >> -	/* check if the source and target directory is the same */
> >> -	if (exfat_get_entry_type(epmov) =3D=3D TYPE_DIR &&
> >> -	    le32_to_cpu(epmov->dentry.stream.start_clu) =3D=3D p_newdir->dir=
)
> >> -		return -EINVAL;
> >> -
> >
> > It might check if the cluster numbers are same between source entry
> > and target directory.
>=20
> This checks if newdir is the move target itself.
> Example:
>    mv /mnt/dir0 /mnt/dir0/foo
>=20
> However, this check is not enough.
> We need to check newdir and all ancestors.
> Example:
>    mv /mnt/dir0 /mnt/dir0/dir1/foo
>    mv /mnt/dir0 /mnt/dir0/dir1/dir2/foo
>    ...
>=20
> This is probably a taboo for all layered filesystems.
>=20
>=20
> > Could you let me know what code you mentioned?
> > Or do you mean the codes on vfs?
>=20
> You can find in do_renameat2(). --- around 'fs/namei.c:4440'
> If the destination ancestors are itself, our driver will not be called.

I think, of course, vfs has been doing that.
So that code is unnecessary in normal situations.

That code comes from the old exfat implementation.
And as far as I understand, it seems to check once more =22the cluster numb=
er=22
even though it comes through vfs so that it tries detecting abnormal of on-=
disk.

Anyway, I agonized if it is really needed.
In conclusion, old code could be eliminated and your patch looks reasonable=
.
Thanks

Acked-by: Sungjong Seo <sj1557.seo=40samsung.com>

>=20
>=20
> BTW
> Are you busy now?
I'm sorry, I'm so busy for my full time work :(
Anyway, I'm trying to review serious bug patches or bug reports first.
Other patches, such as clean-up or code refactoring, may take some time to =
review.

> I am waiting for your reply about =22integrates dir-entry getting and
> validation=22 patch.
As I know, your patch is being under review by Namjae.

>=20
> BR
> ---
> Tetsuhiro Kohada <kohada.t2=40gmail.com>

