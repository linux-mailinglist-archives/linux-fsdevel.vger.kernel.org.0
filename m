Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9346D6C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhLHPUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:20:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhLHPUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:20:37 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9bJD025815;
        Wed, 8 Dec 2021 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yRFERDqbC1B0mVXQ1wBB+/8D6dRAFhTWnoWB+2mAuBg=;
 b=wTvEAQxQjroL0QkLfWzQxtJcQU0UCYn5pSf4zg91UMaNRzeqfeo3sZ5CebQXfPSY4Kjw
 3wLal8H2HB/2yQgKp/v7i4WIx9Ni/dDs2/sb/rVkJWiWeCY39YUe5v/dCB/iyIuyF7q5
 +xkGonHgWGbR9imo72WpfNddTHZxyPc2tXr+XqPN8SzZymJYOytFv7EiN8PrWYwCMeZJ
 RScmhZmqLciK9tpRPaxa1gJQzBw9nXulmblOO+TK2VC83lI58lqjc+YMZP9VNxTUrb8D
 ker/DRcynhi1Nimq62ON5ymDkQijO3rbOfC7Ir2Z8xoeQd4BQPPtR3gCoFnC3GT1ceCz Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mrqw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:17:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FC9ca081122;
        Wed, 8 Dec 2021 15:17:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3cr056fp23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 15:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxWDmnLDjmhplb/kePpn6b6DRU1MW6t58xtJl+3hqYbiULYnQZuHECBKOUzPu8Obo4lPuWQhfNxWPk/R/Ijy8Tt39OZ8PpwXUv/5062ZG9MEAqepD4+UeU4NPLDDJOaZQlK7c5dc8vqBqEFFiRkPoFoLy/swa0J2Ch0xxGoV6agubgXnC3KKjaMzZ5bKFz+RHfKm3fVU/sbftBeYlFN5voshBI60xjUiKhay35/2qrzB5i7nPSMA+f1yvKO1JCbs557K9ShdVOdsVE39bjvELpDqzuXVVIHmta51zn+QZlV+XZhtkNKOUoRDj4CwoEj8g1NJ9XlfFzYlPNzjNV/SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRFERDqbC1B0mVXQ1wBB+/8D6dRAFhTWnoWB+2mAuBg=;
 b=esn4tKbpuSXmVJnBjspHr0wpwWP7tYxqXD8Tvaq8F3rKzei4Rb6NxDpcR/Cbb21oxHSbKhzn2ApyXftm9suQ9ou+Ksxhtuf2JNLDRKWFl7JjZBc+PNXCiUa2/RK7dCeeyt6z8r39XQTI3Cc+7ZvWEhR4kJH1v8cZziX9Nb1TQEgUxchHbgkumc8WW5CifZglF1nIdG3/TCBr3usu/17musYdkK/H47W4VXtVKHl5aQodsgRZI18Uapn7wngNBqDuY3tYqei+IlOIq2lmCm0gAe8ipuuS5BBxjZIZpbQ3a0/ug2Eqf6VdDRIDSivD6pl2qq/Y8rhsS0lOb5e28ZUuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRFERDqbC1B0mVXQ1wBB+/8D6dRAFhTWnoWB+2mAuBg=;
 b=wRbWIFW8WlyvXXCIfe9x5hOwIzJCmKVHcdPMvvYjoVrU6Xh/Zo8eaxSWmNZJNzmkZir8CsFnvMLRY8d5dXUOarWK//9VgLm3Hi9Eq616rynVrhaPnk0KX7jH+RpdJPNcnKka+Dab1jH5b6wmiHTOmLiADCgpMA7YwoYbLRtGGHI=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3912.namprd10.prod.outlook.com (2603:10b6:610:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 15:17:01 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 15:17:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssTAZRABZ1HqkCYuoltcOnBFawl4NyAgAAeY4CAAAz7AIAABiuAgAGDrICAAAnhAIABF8IA
Date:   Wed, 8 Dec 2021 15:17:01 +0000
Message-ID: <78FF0684-CB24-468E-B8C9-7FC6B9F8230D@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
 <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
 <20211206225249.GE20244@fieldses.org>
 <DEB6A7B8-0772-487F-8861-BEB924259860@oracle.com>
 <20211207223542.GA14522@fieldses.org>
In-Reply-To: <20211207223542.GA14522@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b8fe4e-1097-49ab-780e-08d9ba5dc8fc
x-ms-traffictypediagnostic: CH2PR10MB3912:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3912EE11F5D7FD6BF646207A936F9@CH2PR10MB3912.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqhbVYZB0VWHDGJux7N5SD3QleexP7cJLLUD0OMs2FTuUtREv6DgCw0PE6ZXb/95OMYW1AbYCnz0YCCiw+Se7yQ3WSyEwKLl4s7UJb1pqBvlhxJ+hZh7HdotUolySmpzPaoHqzAY9oT1+JXFYsFoxq+fy5wgsK3sv7nyMKyr7NJ2ZunVi989+Z3BjOvEN3IvrkZy3pKkHi7uoBklYe5b3/7Mup3UIFnhioccB+3JThm0v6uZqsskg/hcIchDGGj/Y9MZMY74mDa6sZNTed+DZ5BSP+++ep3azoST8czyIaLMTw7GV7MocgISv6g2IyOghxmc0Iw5zHGKyO1zi5tnj1+d/To5qCt5SdMUM8/nfmYPDmdgu++Yy0oAxJc9NyIRsVnHghGRrpHmAPaOHwo36wWUlYYbqzosfvGNXOcnSFh6q1h1EgrTZl1/jt2SCVE33j0y62AsV4KPPuM/fpyxnD9kr1rbxSjk1eMm3KG2lExTMWY+FIxueq0w4Xqo42ZLzRy9tA3xtDIwil+uwzazxRr0u1pWmk44jh9dDzxAwgFk5h5uHQncWd3BzwLAU488q84bpa/jzkCjpmeFSMZ0Nx7xJ/9XcOLPuDSqjt8ZUT+aMsrNVm9urDscmSOgb/wVTTMRXAsHN4vQkDhGVvUDVXS0NYiQYwjZ36zmTBwekUyghbmq9miTI6e59ehd4JzuknFnEUVAwdrTKPZrojku5gT0FZ3JAVu76VGLKsEMhZ1oHH0DvZMgoV/Tio/k7GLcnuHPojcyIOP1iFMMx8Cb4EdYUDEcbbKKfw/b4lEogdKrLBCbbpWRU3UV6f77EPURIbuoChe+/Whso8HW2de8kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(8936002)(54906003)(66946007)(76116006)(66476007)(66556008)(64756008)(6512007)(66446008)(5660300002)(4326008)(2906002)(71200400001)(966005)(38070700005)(8676002)(26005)(36756003)(6486002)(186003)(6916009)(2616005)(86362001)(6506007)(38100700002)(33656002)(122000001)(53546011)(83380400001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rp6FaQGhtLw9ZD2OYhwrNTyRmLd437PfVlYCDlDhd0Cyprgdxv8LI0Z/UkGV?=
 =?us-ascii?Q?RBiOj0t0sCS4ynt6USBD2svt0LmqbPXHAjsKhmGFUhlZMxELnbhd1DWt4O8w?=
 =?us-ascii?Q?Xo3WwzL2ulqcLrjRIuFeHOPG3BuWR6TPuMrkSUA5JkHwOSROG8W3Xmw9GR0g?=
 =?us-ascii?Q?eGOcqDhFG5UNA6A+lcqeHDOOxtoY5l6daNCXaXajQfn5CGh8fNQ+dx4QGThS?=
 =?us-ascii?Q?mARfoceMRTAivVo2sPn40zq5LelO1Dov8k+cH5QAd+aMfX4hzrBSq+evOZvr?=
 =?us-ascii?Q?12oKA2ZTiLfWr1QjDes3fugL5lIcavHOti1X8GxOS5B/ClPje6DVk4tE3dd9?=
 =?us-ascii?Q?+0lr+vn2h0BvOj5zUOotb4hq/ajxcq++Lk70/j1lpjVGhFWDorTxcVzZC3JZ?=
 =?us-ascii?Q?7k9UAhQGXj3ph6qwseaxuhmdvMELSR+KuJdxjEFy+jXn4SfLmpsu3dhIYjbD?=
 =?us-ascii?Q?uMdBpEAPVsvVCPbMDUdtOdwXbREExHmibCG7fZ0uwfBvTmTcA2ApJ2782ETh?=
 =?us-ascii?Q?XXNadQoHrVdYgsmrkvUnR9WPtN4w8kWHsgd4xC/WoeTIir6pHYtiMzGkX9Hq?=
 =?us-ascii?Q?dMFTw7juQ8nhkH1dhMlvxba/GlTItpbEvK690xYXtwqoUSlkRcf3Xj3j60dc?=
 =?us-ascii?Q?eEfieplmfxd4bMd0J9KL2MLx7mWxnTQZVDUjbn+xURqYCTimuRKjL/9nQC8P?=
 =?us-ascii?Q?eL02ZL4iRMIkrUcQK6zLHLsPl14W6K+iO5JPJFoJr/kTrpDEVr3ogRR0LuSW?=
 =?us-ascii?Q?W21Lz1ztRTQd2MCTNJJzqKrWv6ZDjaiS1Dvw5bRs/IrxCjBGGwuE63+QVnNc?=
 =?us-ascii?Q?B4BSOwt80G05E1jTv0ZDa93xdg+NvbOF/1aERy9rf7H2PPXfSPqYlj1i8YVx?=
 =?us-ascii?Q?ZUeU3SJtld8pmHBz2EeutJfGniukKdnzC4ywqj17nhhFd8HGtOGV3LNKV/eK?=
 =?us-ascii?Q?wQy70Tp1sLpGp4poZwX6TuSzR9Sk+Ms8VUEYx8cUrQtQakS7dnDlkk5RoAuR?=
 =?us-ascii?Q?PovlFr+tTZmg4objEoS4zip8bQGkHIlFn0VLJ5DtPwQ7vjXHp56gRI6ck33C?=
 =?us-ascii?Q?dNQs90urrCsFOBmJlauPVWzL34LnBs22Sx7e5GNtmNeNQUrldn2Mme1dPnJ9?=
 =?us-ascii?Q?FLTwYYfH5EbpYQRtyAaYNUrJDiWRPBKNN37EcsSyGU1sl6bkxmgMkecfIbWS?=
 =?us-ascii?Q?asDvKzexv1kBbnY0+czuwicktgMAVciX0CUpwO6ooiYU/nKMu848G0Y5Knw7?=
 =?us-ascii?Q?p9v07CGjOVcI8taRwGGNFhh6NM4tyXYZsOpGXpMBssJbxgwvohOybE2TUi5T?=
 =?us-ascii?Q?5ip0CjrlJu4rY77HTxwduXGctK57VoFxoDPntOKssa5n1QwdxFAvcwzWcaN5?=
 =?us-ascii?Q?BiCjr9XJGpJgz5V6+kLSEFs1IEAuwwCSxevaXV7jzAf+W5Qqw9Wr4YTr2u9X?=
 =?us-ascii?Q?RI34BK5enN9K1D/WLtpB6O8kXzfCRabBO4l8reArOq/NIXcB7SMSurtglgzz?=
 =?us-ascii?Q?qwLyxqlKzuKhUngz85gaR3bWEbDkLK1shHnFzS73FNR6glp7kPzmqrf26dFy?=
 =?us-ascii?Q?EGjDdm+LWW5CnEvnGcxXs5pQulcHhgi1VAkVJlc/D3KYYqSvmJqKu6uFf8xo?=
 =?us-ascii?Q?YxnBj8ZdTxokqosbboUApXs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B50D824EF06DEA4B96F3D8953D0FF19B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b8fe4e-1097-49ab-780e-08d9ba5dc8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 15:17:01.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMFafiIJo9+HDkdMC8cNKRGUUJBRckBMtPIizm85XjHTVQJcYFyeIO2e9i3CU8wvBsb407hMlTzJEBMfMHS1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3912
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080094
X-Proofpoint-GUID: EpRTwVhtZCVBc0bDhAIjoEgtdtLnKyQ7
X-Proofpoint-ORIG-GUID: EpRTwVhtZCVBc0bDhAIjoEgtdtLnKyQ7
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 7, 2021, at 5:35 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, Dec 07, 2021 at 10:00:22PM +0000, Chuck Lever III wrote:
>> Thanks for clarifying! If you are feeling industrious, it would be nice
>> for this to be documented somewhere in the source code....
>=20
> I did that, then noticed I was duplicating a comment I'd already written
> elsewhere, so, how about the following?
>=20
> --b.
>=20
> From 2e3f00c5f29f033fd5db05ef713d0d9fa27d6db1 Mon Sep 17 00:00:00 2001
> From: "J. Bruce Fields" <bfields@redhat.com>
> Date: Tue, 7 Dec 2021 17:32:21 -0500
> Subject: [PATCH] nfsd: improve stateid access bitmask documentation
>=20
> The use of the bitmaps is confusing.  Add a cross-reference to make it
> easier to find the existing comment.  Add an updated reference with URL
> to make it quicker to look up.  And a bit more editorializing about the
> value of this.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 14 ++++++++++----
> fs/nfsd/state.h     |  4 ++++
> 2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0031e006f4dc..f07fe7562d4d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -360,11 +360,13 @@ static const struct nfsd4_callback_ops nfsd4_cb_not=
ify_lock_ops =3D {
>  * st_{access,deny}_bmap field of the stateid, in order to track not
>  * only what share bits are currently in force, but also what
>  * combinations of share bits previous opens have used.  This allows us
> - * to enforce the recommendation of rfc 3530 14.2.19 that the server
> - * return an error if the client attempt to downgrade to a combination
> - * of share bits not explicable by closing some of its previous opens.
> + * to enforce the recommendation in
> + * https://datatracker.ietf.org/doc/html/rfc7530#section-16.19.4 that
> + * the server return an error if the client attempt to downgrade to a
> + * combination of share bits not explicable by closing some of its
> + * previous opens.
>  *
> - * XXX: This enforcement is actually incomplete, since we don't keep
> + * This enforcement is arguably incomplete, since we don't keep
>  * track of access/deny bit combinations; so, e.g., we allow:
>  *
>  *	OPEN allow read, deny write
> @@ -372,6 +374,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_noti=
fy_lock_ops =3D {
>  *	DOWNGRADE allow read, deny none
>  *
>  * which we should reject.
> + *
> + * But you could also argue that what our current code is already
> + * overkill, since it only exists to return NFS4ERR_INVAL on incorrect
> + * client behavior.

Thanks for the patch! This sentence seems to have too many words.


>  */
> static unsigned int
> bmap_to_share_mode(unsigned long bmap)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..6eb3c7157214 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -568,6 +568,10 @@ struct nfs4_ol_stateid {
> 	struct list_head		st_locks;
> 	struct nfs4_stateowner		*st_stateowner;
> 	struct nfs4_clnt_odstate	*st_clnt_odstate;
> +/*
> + * These bitmasks use 3 separate bits for READ, ALLOW, and BOTH; see the
> + * comment above bmap_to_share_mode() for explanation:
> + */
> 	unsigned char			st_access_bmap;
> 	unsigned char			st_deny_bmap;
> 	struct nfs4_ol_stateid		*st_openstp;
> --=20
> 2.33.1
>=20

--
Chuck Lever



