Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A305868A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbfHHSTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 14:19:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729925AbfHHSTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:19:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78I7KXN135599
        for <linux-fsdevel@vger.kernel.org>; Thu, 8 Aug 2019 14:19:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8pk3nvq9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 14:19:46 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <leonardo@linux.ibm.com>;
        Thu, 8 Aug 2019 19:19:45 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 19:19:44 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78IJh9U52953596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 18:19:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30944112062;
        Thu,  8 Aug 2019 18:19:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96239112061;
        Thu,  8 Aug 2019 18:19:42 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.40])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 18:19:42 +0000 (GMT)
Subject: Re: [PATCH 1/1] fs/splice.c: Fix old documentation about moving
 pages
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 08 Aug 2019 15:19:41 -0300
In-Reply-To: <20190801223852.16042-1-leonardo@linux.ibm.com>
References: <20190801223852.16042-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yWqOe3H3Bx7NH7P7c4Zo"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080818-2213-0000-0000-000003BA4864
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243951; UDB=6.00656253; IPR=6.01025429;
 MB=3.00028095; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 18:19:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080818-2214-0000-0000-00005F92CA70
Message-Id: <52a42a7ab5052c7d35c98bca6439ff00e323a947.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080162
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-yWqOe3H3Bx7NH7P7c4Zo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 19:38 -0300, Leonardo Bras wrote:
> Since commit 485ddb4b9741 ("1/2 splice: dont steal")' (2007),
> the SPLICE_F_MOVE support was removed (became a no-op according
> to man pages), and thus disabling steal operation that would make
> moving pages possible.
>=20
> This fixes the comment, making clear pages are not moved.
>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  fs/splice.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/splice.c b/fs/splice.c
> index 14cb602d9a2f..0ba151c40cef 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -671,8 +671,7 @@ ssize_t splice_from_pipe(struct pipe_inode_info *pipe=
, struct file *out,
>   * @flags:	splice modifier flags
>   *
>   * Description:
> - *    Will either move or copy pages (determined by @flags options) from
> - *    the given pipe inode to the given file.
> + *    Will copy pages from the given pipe inode to the given file.
>   *    This one is ->write_iter-based.
>   *
>   */

Could you give any feedback on this patch?

--=-yWqOe3H3Bx7NH7P7c4Zo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl1MZ70ACgkQlQYWtz9S
ttSKCxAAyVy9d2MaMh99ZvG+CtSZa9O3lImfsXKdkkin/kiZnObUGQn6/LhWZT7u
VY1S7c+obycYe9muQ5WSH1F0bLDdbDl0vtkL2NMIuh7ippvU6YjMfm4cEgcZzHzD
sn4T/IJzYy5bA6r3Q/zPey+VKx8JQ7Wc1g9B0YmDD0xhSy3Q65rwv81HDuSwV95c
Tf9YULStVY+q+4dnCBcN66wGWu2g/LYpDwJWFTkL2hWYAMBKCi/B28qn67OLIiQs
05C5QAxkirb9PKvHGg1aobs5rYUEv3xUMPev2ByCLdRFcR5nUDTXjYgQHIqGCCD0
AcIOYQNr6u1ULvUr+63S8BTFD1N/eNenzKFXDS5uFCr2hcCsJDqHA/KTcbW4Rxpg
FqT/q9I59DTJHBCaa5rMzMHWNgQOeiG+vUA718QGmaGSjB0YVp5CaEMkleiL+npE
qOlXASccDgUqc9XpP3fMSF3BkJfvmxG85c5tDC9QCjacLPntKq1zdKQRECiBiuzF
q4MX+AkjRNNZJgmPep3G7IaPUkaQ6IVRyc8ZPX8YwPCz+A5wk1PJP5W6pcguhBub
fgSDBDo1+YQeRkLyDe/nQ45fDRju+9ugXsUaUdjopPGw96/aTe/Dl92VbnkOuT0B
eyU9BEEpliDnxxv4rDvG3feLRxuQv01VRzM6mJssRywRO0KaGQM=
=EBCJ
-----END PGP SIGNATURE-----

--=-yWqOe3H3Bx7NH7P7c4Zo--

