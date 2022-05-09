Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C0E520151
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiEIPpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiEIPpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 11:45:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888411CB1B;
        Mon,  9 May 2022 08:41:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249EFfOS013766;
        Mon, 9 May 2022 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VqH6v3yOKYAVkZedus1cGcbdjei5uqayHNwAZ+njXN0=;
 b=c1yv2/3jPDXSCs0MiWw+K/Q875i2Usdi0fQ0bos4oXcw+1BFrd+LbiAOyCEhUeK2X4o+
 uTQegb2pL1sC/1XONIP4mkNAGdGXXkDmW9BqfICaTBAKS1/9zlGJzgCjQfBS1tzzd5UN
 H2T4ZBP3IeTdaJqoNjz5CerpzCSG1zwha/CLSxU9v2q3UUPuYao9O9wFgKdtQxeOU68N
 tDZ7FiYpuSBciJwJ0Y6Z1mMkQ9VfQMloI1ftRCT0LjF88OHJ+4RAiIJ0aLICYz0UJh8x
 k+IY/UpMbCf1KnGGWOlRS7WwYKx7toiMwQ6DUY7kcFIsLhUKWr5FXzI+JDoe0YQw8GlE WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9kun0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:41:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249FZEC3031422;
        Mon, 9 May 2022 15:41:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf7152p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEckbwq5e1hr8Hfi7tZf8noeYIWuRR+rOgElhdzYDE12NfMmhUahan5Pn5wS6Rv0OmH65AHF5eKm3Q5ops2g75fJ4CtnuIdaZAjMzWWM8y0zjoPs0it7jZiUHf6saJ+4FJfnJTjhfmTMTYcP3T63hMcqmV1gwL9RpSNpKADr2nIpyIB9tU4sly+w4TczuvQqBxtdl5H5W9uwb4V3kQpGEOG19M1wgPqjj4l96g8ucterCQ+N0OobHuul9tt04XceAOWoDAcr16ccl//WlBYmgHYFD1lSi7FbIiKeHCzpEr8E9ZRPHly2POnRUjA+cuVEfsY/s7B+SZGoLvC6Uv2+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqH6v3yOKYAVkZedus1cGcbdjei5uqayHNwAZ+njXN0=;
 b=nVeD/wvc8Hr12Sk9N8//lweCvEz2yYarhRQGMpIY6uLzelwnXG5t8Mu4w+rN4S5bwjlvGPLUdhCxHpv2vrtTtAGzv86cZfZfeTcRfK+WxwXsTYdHpaEa+JwZ1whGxP40hbDhNWueXiohnwrpibh7j0QZA43Moy15mf4AfvYSVriXwvOqzhUFMZrf/NtA0n8+T+0wpDl59Ahpxsb+cpCKL1gmI1+YIKx0nSKcGptiZsw9qsF+yayfh/KTf6kHGxor7N2zbS4KUs+iF+b4N9boLtWO11mvyHh9Y8LPb2DmpMyeryGYZJCjFEud6a2BTYdvkwch96kM2MwHI3ggJgO07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqH6v3yOKYAVkZedus1cGcbdjei5uqayHNwAZ+njXN0=;
 b=yY0vRATIGo5sMXyLCDax/4oGcQdNuPbZMEih/WB5PMfN5POuS/Fz9Y5APiWp+bvSx1Zwm9o/qo2bQ8ysWqiDdMdoTtUOednyIjuDBG+1t6VOAslC79gqveVfasjIomX4zvoJ+uM8eUQeXnD6HM/yb1zz3SAgc9V3UR99TyHEjTQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 15:41:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:41:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>, Dai Ngo <dai.ngo@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v25 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Thread-Topic: [PATCH RFC v25 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Thread-Index: AQHYXmpU3Z7gf2O/OEmZiiJR98bOma0Wua2A
Date:   Mon, 9 May 2022 15:41:32 +0000
Message-ID: <96DC929C-F07D-443A-931D-47E4CE9C07BE@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
 <1651526367-1522-6-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1651526367-1522-6-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d50190be-0886-4bb7-e179-08da31d2649e
x-ms-traffictypediagnostic: BYAPR10MB2629:EE_
x-microsoft-antispam-prvs: <BYAPR10MB262905703055387187D46B4F93C69@BYAPR10MB2629.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nJQrP//knncDtWxymvgf8P1OIy3Znkz2+NHCHPbREltVRyN4EWs3THq8ITcfhAspMyG9seLnobt9eiRTVb6RSkLRM99iAP/W2726XmsQWZvp1Ni34fvUhIGYQBJXoYNO6nFdcwO3cRec77AMwQbxLWXDtqgn1rDKaKxregxnmHQAaGof7NjGArIA9eATrEtLBjrcccvoIXnGN2GLpNgNygyFR3wytw2Uxppg9NKCyycmD5IVqfCv6JzF1SntPrtjs0Ee3hhUnMidKjasSWLokd2feG9cRdlvgiM28ETPfq9vjmpxgGs0vdhqHAq7fD9N6J73zdt36mryYjMA0OEYYF2WSsHG9CQ8kfjgCxkiqDm4Uuf3lh2G4unzCofBqPxIRE0eXRueLVw2VgZg2pzH+/iUy/Je93BWZA8HBlULCOsay07NP088/LKjROvCW9wkHcIaf6Qaaw4LPDd1bY4D4z5oXmRWkgdB3qmPO6xPE3a33Kx/1lOpv4SmQyqBq7YuNRhnPAv4JdLsPcY22JiUs0QjyK/LOGwSM0AtZmihbdzAz5OHR0yIVJuVWWKG/1MpaJrD8HYL4wybr4hMK7I/8jMhu06eLd2O8/QmPAqy/BtAtlAYpzg9JqdbRqiubheV9IkImmeJXNpbTOSTmWFLwaU4+DqHiO4Lhdxkns+MmrdH9ZU7JqFYtBETiCmyt+fcsTKbBn/vaBNZemf65sL6VfsnNBtX00IFoW3AS9PIXLhozkUqJzi1jlA3QpnM3x9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(91956017)(36756003)(71200400001)(4326008)(8676002)(508600001)(2906002)(66946007)(76116006)(66446008)(64756008)(33656002)(66556008)(66476007)(83380400001)(6916009)(6506007)(122000001)(186003)(6512007)(26005)(2616005)(53546011)(38070700005)(5660300002)(6486002)(316002)(38100700002)(54906003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tAKfzN91hZYyXd73RRQd/6PdDXDUEOGPtYoNPcaliShZgnCQkYNhGQ/ms7Ho?=
 =?us-ascii?Q?i7e5ietzrXdF7iRkPj3aER/l/xH4eBmJO8DWBxoLmxMvNk2/VtMu6Kubr44f?=
 =?us-ascii?Q?39WN1hHjdDD5Is57Gm8euwgf9WK5jV6CrisK7C21KgcRnF52OdviBfyQY9li?=
 =?us-ascii?Q?eXpgVlI4M3IdLryVZT/uPwGw/1BcP0/3uze//1gwJXM4TsN2XSi/5Bzw+oJB?=
 =?us-ascii?Q?KYAseF41AacyAG9JXE6oS4Idb5vG/U+epMFMUfmeFyll2hfh/Wu5yChpyAq6?=
 =?us-ascii?Q?xsab1cAjsgmAzh6NO63JsBAdyRs8ia4hybcIaHLKVlN6yplxS+ZNCFbDg4bq?=
 =?us-ascii?Q?d/niCA4dLGCgevK2XYmkpPNiClpQqSwayNnY5lsirw/RBVdub7l/zrNhWtGF?=
 =?us-ascii?Q?FCW3AuyctESRpjYYcvRGzoYsk/1nyt/8auZrMK+3i1ZM3ohYMvuV9dBTSvU5?=
 =?us-ascii?Q?R9ePMim6AWUMDZ5JLniMevzrNGbRrIVgmxZdUcY4CK8TBvXRaL8BEGqyS4aS?=
 =?us-ascii?Q?+FBV12GpuVOyEk4g8QynMroJGkBbOol14tuCPTGgriDJe+dmIAkHoBti5+/j?=
 =?us-ascii?Q?wfLaWWoBkPQ/dk2Fygx+nfdo49IN6BN1vlFf09HoHapeih0g1ucSlUzArC3Q?=
 =?us-ascii?Q?Z4X+EGTe2Rcs3zxVzyrptwB5ij4M3FM7Wn5qBO1es7Pr5Fg6szxLfbNB0GVO?=
 =?us-ascii?Q?vpgym2TeF2TL4y3BbnWQXAesTpsopH2VTZw9O9BFj3xjSjOs2lSFn5YiuaSq?=
 =?us-ascii?Q?dWz8Ao4kI3tiSRTqh4LvLqt71IBIGA2qi76wDA3JHZKOzlvYQmM3c/tdFRl0?=
 =?us-ascii?Q?OdOT04e1Z0FpoE/rZP0FDHwh5eaNyTiQYme2lBiZhFWBSwfyxEqpgSMB0mMb?=
 =?us-ascii?Q?76w0CNWu2pGfRfmbZxyMjCOhxStsZ0QpT+/ccMlGugDNDXlK4KEIZKsIlJqK?=
 =?us-ascii?Q?aNou+YmPL9LalT0DX2K7dgUpaD5kLNwzw2LjAej/m/wGKpouz/m9JTShE1Yp?=
 =?us-ascii?Q?o6LIzynAtny3aJh49tcB3cMJ5lwLULORIMKZGpHEmiG5b1ObBb7lLfBf26J6?=
 =?us-ascii?Q?M+ptKi2h2yntLMAPapiHdr0bZMriKrNoapk7mbmheKxlHL10kroM2SjD/3mV?=
 =?us-ascii?Q?0kYLnLwasQEFs8+Z2Cn6zh0pF56EsnVjNQSTkxJtVf/rFVfXQlt8/ydKmeCP?=
 =?us-ascii?Q?N460MJmfw+NAM2qMY6KHVDxGVOi99NIYkny8E3hITxj5N82bH5foIz7B7pUj?=
 =?us-ascii?Q?svNINoqYihSFQpPR6rdlhxJCzISMj956qx6/mRUzdwq+AHBXs83+9/zCqSHe?=
 =?us-ascii?Q?LlyC2Ui37m4YTpaX2zKf3uvZ+JziXpuSmEkoHSPQ9myIDCsO4wqE3QJsjDDT?=
 =?us-ascii?Q?j1hjB4nKcVfnapH8faDOsTE+ZMV+ZDGeI6DiFhAQosJydsjlnBxDPMjwjeUh?=
 =?us-ascii?Q?G3xQ79n7zlYsr6YACsJrXQX58U73quwo7XDSk2X7jeabqzKc1Y2YOQ5fjDh+?=
 =?us-ascii?Q?5JhGoedql+bFjM+lNwEuurEKCj0l1t1FlK+wZ52FSDYPU6uAnahDJs0pCA0o?=
 =?us-ascii?Q?M1e+ZUVCF51RjmCTXvubqPBD3pTWT67j9i2dCPg3/g1ZJGn+U8qXf+MmtkGf?=
 =?us-ascii?Q?K255TYtR+FZq8Pg4aI4rQl3fAMiRE50aCzV0w/rSGghnlyzLiyjVNfdSgSTj?=
 =?us-ascii?Q?7V/H4UKRYM07mADxk/nnpkqbSzN87Z6C4jZzTceLrbipCWtn1Z6Q88cSozX6?=
 =?us-ascii?Q?BfYyz53mpB3Ri//iVFCYHLGSU54GC3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84D725241E5A0142B06C55627FC29708@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50190be-0886-4bb7-e179-08da31d2649e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 15:41:32.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPP6r7i+KhNmUPTyIwnryHu9xmqTMGs8lnwzhzG2YEBS2xnj5z23THn49jjSJbi2TouxffuYtPEjJuyBiEl+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2629
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_04:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090088
X-Proofpoint-GUID: HIuIoEwnApEhlhSj-ZS3ZSKbVw3-aXTB
X-Proofpoint-ORIG-GUID: HIuIoEwnApEhlhSj-ZS3ZSKbVw3-aXTB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 2, 2022, at 5:19 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
> lock_manager_operations to allow the lock manager to take appropriate
> action to resolve the lock conflict if possible.
>=20
> A new field, lm_mod_owner, is also added to lock_manager_operations.
> The lm_mod_owner is used by the fs/lock code to make sure the lock
> manager module such as nfsd, is not freed while lock conflict is being
> resolved.
>=20
> lm_lock_expirable checks and returns true to indicate that the lock
> conflict can be resolved else return false. This callback must be
> called with the flc_lock held so it can not block.
>=20
> lm_expire_lock is called to resolve the lock conflict if the returned
> value from lm_lock_expirable is true. This callback is called without
> the flc_lock held since it's allowed to block. Upon returning from
> this callback, the lock conflict should be resolved and the caller is
> expected to restart the conflict check from the beginnning of the list.
>=20
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.
>=20
> Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Jeff, May I add your Reviewed-by or Acked-by to 4/7 and 5/7 in this series?


> ---
> Documentation/filesystems/locking.rst |  4 ++++
> fs/locks.c                            | 33 ++++++++++++++++++++++++++++++=
---
> include/linux/fs.h                    |  3 +++
> 3 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index c26d854275a0..0997a258361a 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -428,6 +428,8 @@ prototypes::
> 	void (*lm_break)(struct file_lock *); /* break_lease callback */
> 	int (*lm_change)(struct file_lock **, int);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +        bool (*lm_lock_expirable)(struct file_lock *);
> +        void (*lm_expire_lock)(void);
>=20
> locking rules:
>=20
> @@ -439,6 +441,8 @@ lm_grant:		no		no			no
> lm_break:		yes		no			no
> lm_change		yes		no			no
> lm_breaker_owns_lease:	yes     	no			no
> +lm_lock_expirable	yes		no			no
> +lm_expire_lock		no		no			yes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index c369841ef7d1..ca28e0e50e56 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -902,6 +902,8 @@ posix_test_lock(struct file *filp, struct file_lock *=
fl)
> 	struct file_lock *cfl;
> 	struct file_lock_context *ctx;
> 	struct inode *inode =3D locks_inode(filp);
> +	void *owner;
> +	void (*func)(void);
>=20
> 	ctx =3D smp_load_acquire(&inode->i_flctx);
> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> @@ -909,12 +911,23 @@ posix_test_lock(struct file *filp, struct file_lock=
 *fl)
> 		return;
> 	}
>=20
> +retry:
> 	spin_lock(&ctx->flc_lock);
> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
> +			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
> +			owner =3D cfl->fl_lmops->lm_mod_owner;
> +			func =3D cfl->fl_lmops->lm_expire_lock;
> +			__module_get(owner);
> +			spin_unlock(&ctx->flc_lock);
> +			(*func)();
> +			module_put(owner);
> +			goto retry;
> 		}
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
> 	}
> 	fl->fl_type =3D F_UNLCK;
> out:
> @@ -1088,6 +1101,8 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
> 	int error;
> 	bool added =3D false;
> 	LIST_HEAD(dispose);
> +	void *owner;
> +	void (*func)(void);
>=20
> 	ctx =3D locks_get_lock_context(inode, request->fl_type);
> 	if (!ctx)
> @@ -1106,6 +1121,7 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
> 		new_fl2 =3D locks_alloc_lock();
> 	}
>=20
> +retry:
> 	percpu_down_read(&file_rwsem);
> 	spin_lock(&ctx->flc_lock);
> 	/*
> @@ -1117,6 +1133,17 @@ static int posix_lock_inode(struct inode *inode, s=
truct file_lock *request,
> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> 			if (!posix_locks_conflict(request, fl))
> 				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
> +				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
> +				owner =3D fl->fl_lmops->lm_mod_owner;
> +				func =3D fl->fl_lmops->lm_expire_lock;
> +				__module_get(owner);
> +				spin_unlock(&ctx->flc_lock);
> +				percpu_up_read(&file_rwsem);
> +				(*func)();
> +				module_put(owner);
> +				goto retry;
> +			}
> 			if (conflock)
> 				locks_copy_conflock(conflock, fl);
> 			error =3D -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b8ed7f974fb4..aa6c1bbdb8c4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1029,6 +1029,7 @@ struct file_lock_operations {
> };
>=20
> struct lock_manager_operations {
> +	void *lm_mod_owner;
> 	fl_owner_t (*lm_get_owner)(fl_owner_t);
> 	void (*lm_put_owner)(fl_owner_t);
> 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
> @@ -1037,6 +1038,8 @@ struct lock_manager_operations {
> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> 	void (*lm_setup)(struct file_lock *, void **);
> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_expirable)(struct file_lock *cfl);
> +	void (*lm_expire_lock)(void);
> };
>=20
> struct lock_manager {
> --=20
> 2.9.5
>=20

--
Chuck Lever



