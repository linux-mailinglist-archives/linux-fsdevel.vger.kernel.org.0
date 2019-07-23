Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6C720DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfGWUgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 16:36:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732479AbfGWUgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:36:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NKHuK9029884;
        Tue, 23 Jul 2019 16:36:39 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx86vjm9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 16:36:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NKFK9U016214;
        Tue, 23 Jul 2019 20:36:38 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2tx61ms60f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 20:36:38 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NKabe137224834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 20:36:37 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B77CAE063;
        Tue, 23 Jul 2019 20:36:37 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54ADEAE05C;
        Tue, 23 Jul 2019 20:36:36 +0000 (GMT)
Received: from LeoBras (unknown [9.85.207.175])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 20:36:36 +0000 (GMT)
Message-ID: <4744130527879c7241d973fec622d6fa5be5daec.camel@linux.ibm.com>
Subject: Re: Question about vmsplice + SPLICE_F_GIFT
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 23 Jul 2019 17:36:33 -0300
In-Reply-To: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
References: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-I0b6DrXadNyZM7gXN1Vy"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230207
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-I0b6DrXadNyZM7gXN1Vy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-23 at 17:33 -0300, Leonardo Bras wrote:
> I have seen the SPLICE_F_MOVE being used on steal ops from the
> 'pipebuffer', but I couldn't find a way to call it from splice.

Sorry, typo here. I meant:

> I have seen the SPLICE_F_GIFT being used on steal ops [...]

--=-I0b6DrXadNyZM7gXN1Vy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl03b9EACgkQlQYWtz9S
ttRFYxAApKN+gxabuDSjoMhDSuSWXOdleSa9Zr4+nwTxyI5qlBttuFfkrBB18pqC
IAQBjRmaPerqs1s0K0RbpSmviubOYhW4A7o6vArWhvRswl1YtCv2pv7feg+p03FH
BnMyBFMQDhq+cR4xKhRrXohQOiD+wo+Gt/oktOunQaDzsbsGfn1Q/uNTqDDPXvph
4mlKHwfbFcl6XkvGemz78ca8ZtVze69e4B6Knde4+/A5W0V6pyZEGxUpB93fQzjC
myu9CdTl2kQu/8OC/DNBI1nokFS6b3hcl9aHNhu1r+BvbbMyDV0xS6QoTsMg1i1g
azmH7b4U4gEcqC2eqtXgLgvR1St1QYLfDkS1EqmEVwQngR8XE1GAgOspl4GmS6tZ
B8mBf7L77CRZkHRo51u86LZLs+utwExWrzybp/tEZnCNq/0UWId7jaZ84YhvHlbr
7IaIPiPxruR9L60FwKFiR/uniFfHOGxFoV5kUi8MZIcgrb7igyNgXlt0rrY5pbxH
itdXAlB1rRglb3yV3pKwbxrwLTAecfAxR+yVdymyu92+IUJTANN8usEZ4NEBLasc
T8RCeNphbm9dg/K13wWscOEg4XP0XJAzHTEQqieziHyxMQyZPHMQljwqKWEimY0b
YVpYVK7fdkatSdLJ0Q13CMGRPDly/6IHl8MRpq/hPVGgJUsenYg=
=CWcQ
-----END PGP SIGNATURE-----

--=-I0b6DrXadNyZM7gXN1Vy--

