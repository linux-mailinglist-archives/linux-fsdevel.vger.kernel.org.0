Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF0104D86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKUIKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 03:10:55 -0500
Received: from mout.web.de ([212.227.15.4]:33967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfKUIKx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574323754;
        bh=CnfvxTO/B0eFqClFnccevYsRuKuGN2Qa3bTydjoAqn4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jDgoPgk7k2jEmgc12yULZvrJJfljF2fy5I694s0o+jWro6Iicw8HkoDUysa7DRg+c
         HCkLU1BccLR9UMyZDYZGyZ6Kdg4R/H/u8fluakD03/7j2JGj00dmK731wYXIkXE2sJ
         VLRBXpDmNUW7p/e6cK4GopBgFsSnwZITA6Ou5+5w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGAB5-1ialvJ0MOF-00FA8y; Thu, 21
 Nov 2019 09:09:14 +0100
Subject: Re: [PATCH v4 10/13] exfat: add nls operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052920epcas1p3e5b6c0251e869e265d19798dbeebab4e@epcas1p3.samsung.com>
 <20191121052618.31117-11-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <df089831-038c-3b39-6ec7-684d1f698756@web.de>
Date:   Thu, 21 Nov 2019 09:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121052618.31117-11-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wEqKUINu6N3Avxz+4LY7uQsH6NGHgbgzJXWDufoPUWER1LyXV4q
 9WSvJ63EI+XpcNNHKlrR4/D2qpvaZiSAVbZfCa20LnMIW5iFkR6cl/KO5k31XUwAfRcW1S5
 qeQXXLiR+NvdJjtFfbiX+MurdOuicMa4SqjBsso+TGCryubHS4Ns85SGmiAmhu/MRtHV+p8
 6lAKy9QWgzcUcsKdBsJ4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FA6ykY/Nj/o=:wDAa5FCLyuRlwIDzb8OAGk
 +LBZyGBEb4wapYMOTUipILVMovjmvFrSJ/nC7lrBfsbODek3fe/wBOXZ5MdxFU0FFA1WXuEyQ
 2k/BPjB/v2yaqUrBd7+CYSG3vm0aRVC0LSBO//gnHTjlsrobnH8tzChUT05QQnh8hdSn8Q8oV
 TZMtxCkJ2DdQomovfjWLh7bGQLznUJhr0rYDkWq6h62Ni0qexAB1idR1M74QL16evcs9wlMsN
 brK4luerH0GoVJPefwkLnidcP9c9Rh5a2jUmY3f9YhccuWaE9gBuYYs66lzhlyC1u3qlZQEA4
 RK7o/vtxmi1SJAKQ4HFWy8aaCU3MVMqqPj/hvJJZIugvn0E/MmrhMOm6ug3DIdDzi5YeJqLmG
 KG95WVk9h3w0bDjA7eFHx2MMsXdPCKhcMIurZVI4yysWlf5zyLdwaVO9+DnQJ6eqIJ5DXjb1o
 u+MToCjWHBicYQvMwHZWNUhPv+vk5VnwIrjyEVB3CsCB08BCWhPmdm9NZ/LuVXJgXyIFhlr4A
 psLXsDT7C9uRnDZZS7MsdJDnwvXECoST5T3OS8MWFEB7kQlmtlDIR2Y1jd7sCSr+WEz3HAmmM
 wtpWZK6CHmJ25nej47sJTwfNpfwHlLwO1HmK2ZLtbAgCvW/cXkbFDva6SHQvlVOpmuUAhpPdw
 np+Dldrp2QQTH6oh5tPmsOnwr+DR+g2kEULhUoiXtmerpgWMx/mOVvagjWlQtSoOE8j+j/BK/
 QRj5e8/zssepxXf0Kc2DaLmsQ+Rq52uD1DxGj1Wd9yP4rJD9NB5nTNqg5ZLaYZ3IX95fSBapm
 uy9M2dX3WBRRbS9eavw+ijnSRSX4Ft/s41rIeBa81WxUDDQmIvFFpAZ3sGvs/ealg4qJAyY/J
 bKUMFePM15U0ofI2WZkioEVymVSKDqmicB7kuf1YlrPY//rfEnuMhc2mb6Bt4rEl7/7GPkA1T
 22XoWOoYkmfjmLzDG5NzF3Sa/wcnj6SQNKlCuCKKZBHQskKzgudpBWTO9eck2+ztTHoILCjc6
 x71W0r4mDqlXQCitTw0FF8n7TSf++M1Wbs1rVdOUCHjN8aBCutY9PE0lTS8o/ZDomcmkqPnaB
 +vEY4k5/UVu1sQErDRisir6Z/MyrL8J2FYtRuXWxxd1WND8I7A23UL6l1iJ3A3Lz6gK2vac51
 fo+4MgCNR5RdDTEkjMcKhkIlp2AqErAA8VgJa4wpNwHWP0AAUB8K+UpCj9SMgCWxgvIecYo+V
 kJoS6lEypSTx0QIaYLqfaz91lwkRdM5EkzlPt0eZz42BIpQQI8wOiNn/N+2c=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/nls.c
=E2=80=A6
> +static int exfat_load_upcase_table(struct super_block *sb,
> +		sector_t sector, unsigned long long num_sectors,
> +		unsigned int utbl_checksum)
> +{
=E2=80=A6
> +	int ret =3D -EIO;
=E2=80=A6
> +	while (sector < num_sectors) {
> +		bh =3D sb_bread(sb, sector);
> +		if (!bh) {
> +			exfat_msg(sb, KERN_ERR,
> +				"failed to read sector(0x%llx)\n", sector);
> +			goto release_bh;
> +		}
=E2=80=A6
> +	}
> +
> +	if (index >=3D 0xFFFF && utbl_checksum =3D=3D checksum) {
> +		brelse(bh);
> +		return 0;
> +	}
> +
> +	exfat_msg(sb, KERN_ERR,
> +			"failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_ch=
ksum : 0x%08x)\n",
> +			index, checksum, utbl_checksum);
> +
> +	ret =3D -EINVAL;

Can a blank line be omitted between the message and the error code?


> +release_bh:
> +	brelse(bh);
> +	exfat_free_upcase_table(sb);
> +	return ret;
> +}

I got the impression that the resource management is still questionable
for this function implementation.

1. Now I suggest to move the call of the function =E2=80=9Cbrelse=E2=80=9D=
 to the end
   of the while loop. The label =E2=80=9Crelease_bh=E2=80=9D would be rena=
med to =E2=80=9Cfree_table=E2=80=9D then.

2. Can a variable initialisation be converted to the assignment =E2=80=9Cr=
et =3D -EIO;=E2=80=9D
   in an if branch?

Regards,
Markus
