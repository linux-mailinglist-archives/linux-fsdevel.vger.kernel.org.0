Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784B9906CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfHPRZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 13:25:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbfHPRZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:25:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GHMZ6Y029674;
        Fri, 16 Aug 2019 13:24:58 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udyxct0yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 13:24:58 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GHK63D022862;
        Fri, 16 Aug 2019 17:24:57 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 2u9nj7mme7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 17:24:57 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GHOt9f57278732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 17:24:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB56CBE04F;
        Fri, 16 Aug 2019 17:24:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 996B8BE053;
        Fri, 16 Aug 2019 17:24:54 +0000 (GMT)
Received: from LeoBras (unknown [9.85.220.147])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 17:24:54 +0000 (GMT)
Message-ID: <631f282f177871a0961d25f3afc98b4b805436e7.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] fs/splice.c: Fix old documentation about moving
 pages
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 16 Aug 2019 14:24:52 -0300
In-Reply-To: <52a42a7ab5052c7d35c98bca6439ff00e323a947.camel@linux.ibm.com>
References: <20190801223852.16042-1-leonardo@linux.ibm.com>
         <52a42a7ab5052c7d35c98bca6439ff00e323a947.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6eSmA4V1izZy5SvSP69H"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160179
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-6eSmA4V1izZy5SvSP69H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 15:19 -0300, Leonardo Bras wrote:
> On Thu, 2019-08-01 at 19:38 -0300, Leonardo Bras wrote:
> > Since commit 485ddb4b9741 ("1/2 splice: dont steal")' (2007),
> > the SPLICE_F_MOVE support was removed (became a no-op according
> > to man pages), and thus disabling steal operation that would make
> > moving pages possible.
> >=20
> > This fixes the comment, making clear pages are not moved.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > ---
> >  fs/splice.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/fs/splice.c b/fs/splice.c
> > index 14cb602d9a2f..0ba151c40cef 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -671,8 +671,7 @@ ssize_t splice_from_pipe(struct pipe_inode_info *pi=
pe, struct file *out,
> >   * @flags:	splice modifier flags
> >   *
> >   * Description:
> > - *    Will either move or copy pages (determined by @flags options) fr=
om
> > - *    the given pipe inode to the given file.
> > + *    Will copy pages from the given pipe inode to the given file.
> >   *    This one is ->write_iter-based.
> >   *
> >   */
>=20
> Could you give any feedback on this patch?
Please provide feedback on this patch


--=-6eSmA4V1izZy5SvSP69H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl1W5uQACgkQlQYWtz9S
ttRY+Q//ThglhmvaCla8EYm+QsG82zy+ruaCSQt7j76ztvcCa+clDdPehf0TWNbU
dtNgNpMra58EGW1Rw2oNAJ20PV9daBdebF+8gi1wzgVpJSTbVKp30RonDJ+Oe0zf
PWyPLykM2fq/MyyEYEoPigona6klnfoEOP35Mqyl/MB6DOv/Mn+obeJ5V/RFF5mc
DBhDYSXrPqu57ibWnb/qaQ42xy2q8QJp56cw/4yeoy5yvPAvghG2mvWnscZoGJmm
/zrmyuLslQjOhbXD19AB9oKZNfk0IBXnxcfsNKRnP+/B9c2M0xb6qZBvXhS//GV4
aTjObgbkN/Y1K9K9ntiXDb+MiLbH/GHx603x8HzMSLz3ThpmjopEnby+B4/1WUR6
GZPI0srXLpefmUFSQR2IseJjkLw9D1aU1expZJAd+adencqWlpaQ0DIYKbzPMyWP
fLb2ZplKt3JNvDG1i8vetUQtyKDvVRG6VaYSP7deNKRLM6AeWW9TfsOxmsxQCU++
736PEmC15TwALx4NtjlS8yBFImmmXYdEoSAeb3wnZARdxaL8Upya3JUUUK8rW6aR
eKpw0NxQrn8S6ygOyijafF16BhVhzLUC482TgBJffGLVCBrkOcOqG+q2JQl3OjWz
/NOd5fbXK4Vyo/JgzjoGnkjThy+zS9XyG1N6VJa0GwGrV+ZLseM=
=LUdQ
-----END PGP SIGNATURE-----

--=-6eSmA4V1izZy5SvSP69H--

