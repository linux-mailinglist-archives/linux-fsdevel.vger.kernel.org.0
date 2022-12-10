Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F41648FA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLJQJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 11:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJQJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:09:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106819038;
        Sat, 10 Dec 2022 08:09:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BAFTJtb001510;
        Sat, 10 Dec 2022 16:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IEGl/+Ylx/r7vXv0P6G63Dc8Y7BBwJG2jgLnQnkWIHA=;
 b=lgdjrtyF6Md9iSrxrrEMMuOpsZ0q8SkPACM3OvCgTPA9PIRCqiNeRL/jNpq5uJT70p52
 GCCeHMlniNU72A8WaO6dSj6Me2tDYElFiTYJXiv9FyVVqFe66B01KNJiEVVx4mPqJb9N
 uw+vXBqL+bAdQlSu+cgjjcFTiUO8LIQbpoVdt4BvuqXfsxiLY5lJHMMYnMMSOZphQjWV
 IKd4c+cndr3neAQzdqDoERXlRXvgIogWYJ9KHhqdgGOdL+F+Klj702PuwyPHtAAGqe0A
 tkEiXHVQCoGAQEwaA8d6mZxo6yQKqIlLyT9JNTAHtaxZjHwnK+HtPu5e0nR73p9r88hV RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqsrgbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 16:09:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BAFSiW1011454;
        Sat, 10 Dec 2022 16:09:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj8586r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 16:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBX2zw6z8h+x/hbOArTBhNfKgWeUVvQhw3m1/PlyQ4zPsAYBX3JYflPlh3OZCwtcLN2AJCEYJ2LFBREsN0zLcdDKR1z5tS5o6w2U7B2B0ENEa1q0OJl8jupY4hdZbOz77gvto1RJ/mk35XgImVx2LrOL3x5LYSoObeews9iHlEZVBe62r4KqPhkjw5sZyjOO+dtKaFOmnTbSWu0OOM89tiNJZxu1Z8adiO4AdfpAOTcrfvC3lTkz7ngxvqwjDwXKbUtQkQx+w1sSzfE2tBpxXocSJNkPAO4yJN8ItL4wSx8IflS+3ND/NUuT1QK7PDuojN15pV+y042lU1x7z8v2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEGl/+Ylx/r7vXv0P6G63Dc8Y7BBwJG2jgLnQnkWIHA=;
 b=ZJq9nlps+qSfAdPjw5pINGONdjuOVpAT8Mj+cpuvf04TVEShn3LEuB4nvtmg6q2RdN2N2JYemU83MYyRH2aL3Fx8SXLeNFQ35vBqMYvJ6jt1yX7JsblHKXwR+g+5f6v+DULUqGKT4yhguVrCadmvSmpCeLljzQL1Wa0Awz95nFHU8RtiNa1bU0UtLfBOcit/ppMnv29jhfeOtNsD00FXPuMizLgvZiufa+ylQdulyEszq3JfQpZH9lq7scjZ684msmDab9eeDrnVgW5DT/jP7s2BNtfs8QUiSFH7P8lF68RrL8CvC7QwTqeu9WDk20oDw6H+xxi5EQQ0qNKWxy417A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEGl/+Ylx/r7vXv0P6G63Dc8Y7BBwJG2jgLnQnkWIHA=;
 b=VsGMYClVsOPqcySi+M356VpUl07E16VG65K67kRdtzb5Y4qirQ+wc7x7P+LT5Di4QINZYl1gZljsDdQ8s4h10BtZ5EyQT2c916JZS64c0IEaFk09uFKvEjjp15p86LyS9mG3/hd+jkj2IIzPfBJEExVgcGe14aGMWZB3GgFYjvU=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Sat, 10 Dec
 2022 16:09:05 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 16:09:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when re-exporting
Thread-Topic: [PATCH 0/3 v2] NFS: NFSD: Allow crossing mounts when
 re-exporting
Thread-Index: AQHZChf8XdRuFhfYVUuBoBZu4IH8sa5nT0OA
Date:   Sat, 10 Dec 2022 16:09:05 +0000
Message-ID: <1AFA78FF-3F09-47E3-BE13-F5BB7F9C779C@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
In-Reply-To: <20221207084309.8499-1-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|SJ1PR10MB5908:EE_
x-ms-office365-filtering-correlation-id: 15e5d887-ab3f-4312-5082-08dadac8dcb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkvM3NGVXIfJhfuLOF6+OPYPuPo12AfqvlA+AnrC+IOIppsVMXN7vHWHiFL7M2XFRtDc3wx/CxY9HOt3la5j1jN3nzFUZu8o5iprC2ZjmaksxWga2gPVnQYtCWggDQcOAPoYHh74IhUrrJVVug19zbFDe1kfgfDHScNNDHhe+6lMZfTckAshXysaj3ZQ71NbGLl5FVd+UzPFKMLSLGFAHksw+rsD1PBGDfxyVdBdm8o0wNAuACXg3L1dtl+Hp9M4bwnN+ZiqTFtE4ZnMRd91BY4t+GiHHAa1PtYEBNYUV0buBtK34nsuIrhx98jqrn5bMi486S4FYPaAJy4wRbFD1oRmHFswp83IJGnOfByQJiMjQ7PHEnNPm9OECooGA6TTcP9KbdfXT2+mQwHoYmndMyvzAW5P2Ob3YHHGDuRZR8rifkBgSIataZluyXKsVjQhF2qhZ814ro7WuUDwqi/ml8dYmr9NvfCmitMEApUpbhV4aoffyMrqWnvZht7SjueNCBjowqVINwZgLZ1UXRBqh0+k8ipeASOfGvQYCTlq8ygRodxqLW7LP1VLTbpzMGvsMKvQ0b8GPLETu0smlHDoMnw6GJwx3dN8kc9ID/v3j2eQJCnNluMpeO8CMmGVMgEQqNFCmqBIqAXVCb3/V0+0i93CwtN0IDuiz+e57GFLdyfnC3vXMG4aZlxVnxtqVTI+TwJ3nozqdjKn/aDzfF2qV5SRDkIuVDbu/luPHX1uA3MsBUa+Gd9Lr7zA5J1KlFX++THNM3YX2Ce8JXqGSz3FJj/NtjIjKiSmAKKwB1a0SBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(38100700002)(2906002)(7416002)(66946007)(66446008)(66556008)(41300700001)(66476007)(2616005)(8676002)(5660300002)(64756008)(76116006)(33656002)(8936002)(36756003)(122000001)(86362001)(478600001)(83380400001)(66899015)(966005)(4326008)(6486002)(6916009)(6512007)(71200400001)(38070700005)(26005)(6506007)(186003)(316002)(54906003)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nuSMUczSC9+ymGWkYwDd8hXhyNsSFsyzOTVSWtf9wDveOxQCFwpqTndcaKRL?=
 =?us-ascii?Q?JQcojW2k6QW8GLC+h+52R54bPdgI3uMvt/kuArrDEFQgbLQZFwCshv/Fdj3D?=
 =?us-ascii?Q?5ELibJBU3WpF08nHnHhgCX/M2RkBuerbm7Kl1OHncn7PvR2Z0C5ElSv4m2PP?=
 =?us-ascii?Q?NP9W9pRDXo5jzXMjWdDBEWQBkMH7CaMpfDKXaGX3NxjG47jfB5VieG3ytn57?=
 =?us-ascii?Q?TaL7jnLq2odCtXm+D+AJ7XJyqCwFNOcMw2ttkfkMHDej8TYMit30sOa7ea4w?=
 =?us-ascii?Q?p3ytWLORSset6iyWD6f/FJJG+upe+3fT9pzohLZezD9RBQfVKkeROSw6HPiz?=
 =?us-ascii?Q?xNSu7klygBQ3hpFmvm/2bmtBY9tJJkQMf4OQ8F+MwuE5MVydNPMfAOow2FCs?=
 =?us-ascii?Q?0QrDO7DgmIdqmLkIOr5XlyIZY39huPjZM86b8aw7KXaYq3oLNdC9ht2wj59M?=
 =?us-ascii?Q?C2vRmgELKKjJCLoWEBktMXN8jCO0WPwq7MDrLGbdhNc9HUvZ7mXMNd8exneU?=
 =?us-ascii?Q?zk44PT4rfvL+bTOp8MRM/3FhONp3gZYbyZABrRWENkAsxlKw8t0DEu9JvUSP?=
 =?us-ascii?Q?Et6it2QhrWPnQd+d+LqIzEzP5OqIINDadXCQ4uSgpaVmup59FnLghSuADBBD?=
 =?us-ascii?Q?oANIdfeBO9Paeb7Ptc6GsZPnzopnx7AVnIH3paCm1thDhgOYryT4cN5byGOI?=
 =?us-ascii?Q?UVjdv3fWcTQTqXiFn/G89gqROXT6jGn0U31n3pqT0TLeq1XP9FbjK2M92eMz?=
 =?us-ascii?Q?TWbrHoDuvLln1+8B3sVqwOQUD3Lh1YQnntgvZc9JZwJqMFSt9pI2BB7snPL9?=
 =?us-ascii?Q?YpSGyFZM1YziQTLDNxtP9bJd3LvNyZdD7TaHQmpRsjOaXKm7ofX95kz6I2As?=
 =?us-ascii?Q?07Q24nydY/NcOtExYZ/MdJuANlNLy8hvh4jNFATSgf0pJeR17zMpZlPcVS30?=
 =?us-ascii?Q?qx9EhgTKsfrN0lZ1+33fjfTZF95jaEW/n9IjX47EgszJQ+nr7KJ7e9Z8tE29?=
 =?us-ascii?Q?guOSwkZ46n0P5mgIodAl2qj+h4vZRNz677CZjKHx0PrbW2vrL5zkK7eUDJ4e?=
 =?us-ascii?Q?VKj3B3GZdGQ7uX3onKid0hnQdDHBhF+Vr1yh1RoQmbiQRaTsGqYBbAnhHSJb?=
 =?us-ascii?Q?BqMI1oy/umbMSY+NoITeXs14zklG7sUL4ni+epmFYDatXiwEMG2q0zmfYLzq?=
 =?us-ascii?Q?NYM2tHWSUddwGqfe23PcaoqlqB46kjfxUTFXtf0c3NUzEpfxgEtl8Ie3znUn?=
 =?us-ascii?Q?ahMT43j8Azg6vF5XgkJHUjxT0+aYK3N65f/qKZ62wEC/CPzJJRFJlHJUIVPr?=
 =?us-ascii?Q?xMCbpSvFvFtMPnk5rkbHKdVpvR6iMNISti9y4a+GE2mxk2SfjMPElcCnQ1DT?=
 =?us-ascii?Q?X0aGGfYNxqsLvJRIuOsTINFcFeWpnvnZQkZF5ECONbT2PwIjHYlRrzXVxGTx?=
 =?us-ascii?Q?QjHJk2WESlTGJUvg9Ntg0BC7P/qJ5/Gyh1HUOPrxBDbMhZv7liro//IiThAD?=
 =?us-ascii?Q?bWEK8ou+OVuBpywdddk1MJjmlpHUd7vpBUzQls8z6hr0sHbIoj2xliapLXvx?=
 =?us-ascii?Q?Q/vX+l3XumFQUfc8dAeZgxWwJ6DMfOLihelA86HH/0XCYvY737yLLXPRyeNN?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34B45318855445469B284739E6D03DE2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e5d887-ab3f-4312-5082-08dadac8dcb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 16:09:05.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYPu6cQp/oYPGW0Ot/Rm0ygwI+kAJyvgV6dMudFLrCA9LKwuaN+bYeQYFTfEfFxy/uj4s8sJuBgmN72ZKIpN3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_06,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=943 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212100146
X-Proofpoint-ORIG-GUID: ktye45PP4s5iIRTNAssdfKpXDEt9487q
X-Proofpoint-GUID: ktye45PP4s5iIRTNAssdfKpXDEt9487q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
>=20
> Currently when re-exporting a NFS share the NFS cross mount feature does
> not work [0].
> This patch series outlines an approach to address the problem.
>=20
> Crossing mounts does not work for two reasons:
>=20
> 1. As soon the NFS client (on the re-exporting server) sees a different
> filesystem id, it installs an automount. That way the other filesystem
> will be mounted automatically when someone enters the directory.
> But the cross mount logic of KNFS does not know about automount.
> This patch series addresses the problem and teach both KNFSD
> and the exportfs logic of NFS to deal with automount.
>=20
> 2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to in=
stall
> a new export for the target mount point. Beside of authentication rpc.mou=
ntd
> also has to find a filesystem id for the new export. Is the to be exporte=
d
> filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it =
and
> refuses to export. In the logs you'll see errors such as:
>=20
> mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or f=
sid=3D required
>=20
> To deal with that I've changed rpc.mountd to use generate and store fsids=
 [1].
> Since the kernel side of my changes did change for a long time I decided =
to
> try upstreaming it first.
> A 3rd iteration of my rpc.mountd will happen soon.
>=20
> [0] https://marc.info/?l=3Dlinux-nfs&m=3D161653016627277&w=3D2
> [1] https://lore.kernel.org/linux-nfs/20220217131531.2890-1-richard@nod.a=
t/
>=20
> Changes since v1:
> https://lore.kernel.org/linux-nfs/20221117191151.14262-1-richard@nod.at/
>=20
> - Use LOOKUP_AUTOMOUNT only when NFSEXP_CROSSMOUNT is set (Jeff Layton)
>=20
> Richard Weinberger (3):
>  NFSD: Teach nfsd_mountpoint() auto mounts
>  fs: namei: Allow follow_down() to uncover auto mounts
>  NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
>=20
> fs/namei.c            | 6 +++---
> fs/nfs/export.c       | 2 +-
> fs/nfsd/vfs.c         | 8 ++++++--
> include/linux/namei.h | 2 +-
> 4 files changed, 11 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.26.2
>=20

This series is a bit late for inclusion in v6.2. The next opportunity
will be v6.3 in a couple of months. I prefer to have a "final" version
of patches by -rc5.

I'm waiting for review comments on v2 of this series.


--
Chuck Lever



