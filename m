Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F62559CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiFXOqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiFXOpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:45:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837726F795;
        Fri, 24 Jun 2022 07:43:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODhtTv018532;
        Fri, 24 Jun 2022 14:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eFCf7YfIsXG86tO1z49NTZcrqWQPHZl7o+yP2BH/7F0=;
 b=rWoT6ZaY0q3r56aUbf+rmFjmNI0I78kRYnkENlOQDFoXCE/tyI1jSfxTyaOJGz1fhBsQ
 Awd2AONjUipId95u4L/ZeT7FIJ2aQFkxBIsT66Tq5/LEb1Ik5gN81QqiHlyr0LYH7g8O
 99WEp5fZbbQHuGh7yV/nY1r3ohV7OOH/2o1ntOeCKpXfyAeC7f9qZirW5cUjBQnObka6
 xoKd/wtIqw4TPdDq8pok4OvL02g+WxMqT1qkYhpd7DqjhKWKAXnxP7YEPfbCO3VpuXYn
 XiHQGlXkJD3QETKnArlOzsndEBr8pqMAH6HnoiMwBAciVkBAU9Z/wyYnFfxYrL1jR59i wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g264tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OEf5TP008040;
        Fri, 24 Jun 2022 14:43:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5fntdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVDaj+Vy7EqRFXbmkpv39taO+5eIyhvJhbUmbKo1KrlLls0YJArICpW4pKvxMJDs74BBkg+K8Jh1dLEJe4gPNxaIqaFoKbIPNzwODGepy40+rBdrfcFAdDQa2wb5CUQB5d8aFJ6rtPeS4ysSrihBZSYmeAuCRkbt4ydY7WNWeMD2IGBt+LXeLSHj33LOWZ28CojkOuctXqoAZ5lPfXVWDxRitbi6W54rNYGcjsSgtRcUVLEa4iGIjq1GI9OxAachZW9AEJ/iFfXt2RyakCn1hmzIog0IipzfHhof67oTc0h2RslKhuw/IpLLtp2mANgQkZzjVItx0FCoewDJ1cSKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFCf7YfIsXG86tO1z49NTZcrqWQPHZl7o+yP2BH/7F0=;
 b=Dcw6e1rZPP3BdpqViodezbwIvoS/UZeN6JPnUbiq/szAI+kyKcWulgSncoGa01k5yG2iaMz6BHdWfJJRxWYDCSrKxzjV5xLbSGWRpBiyhh+/LomDbrSGFVSGwCikP1G52mEGp+oi4nv9CmTih1zhOoa6evdVwP2SeIPUyGIh8G31xbKJbXquFS0nRx2UPoq/vOxOmOWlJ9/zvICKtxQ+Fj+VQPrjOmZgKfvCqjLr5ZbBdJ+XtF9KGD+vvIdBnnwi8UUgcjscuV4ZwMNFTYvYSDPm9tCmde23vL124kk+c1nUEoQhRwDBY0oatJ4f1R74b4s3wYWSgysoRxJsp+EAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFCf7YfIsXG86tO1z49NTZcrqWQPHZl7o+yP2BH/7F0=;
 b=p/NYAgmNPIdpn3lseldeai1O2ozJGOHSdTh1rmORS+NBD3YWO72iTN74xhq3G7omcZiO/mUQaUrCw1xkrCttvEJ2zQbNzwydttV6WE2r1tUHCdVI9XywBHnjTTDr6Davh5YsBP0oLbAE5ZbNlAGHv9vWoHjwWA/kc1s+JYLXKTs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:43:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 14:43:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] nfsd: reduce locking in nfsd_lookup()
Thread-Topic: [PATCH 10/12] nfsd: reduce locking in nfsd_lookup()
Thread-Index: AQHYf3xbCRsWwLxT2Eq2ewj3XE19Eq1espCA
Date:   Fri, 24 Jun 2022 14:43:30 +0000
Message-ID: <4355E5E5-335B-4F3D-AB76-23240C6ED424@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230202.21248.2917435222861526857.stgit@noble.brown>
In-Reply-To: <165516230202.21248.2917435222861526857.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5381183-82ac-40f5-38f5-08da55efe7f0
x-ms-traffictypediagnostic: DM6PR10MB4236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vd8WPefh0jzWax1kkRiMQnk25wuP4vkzFKGZUqOMryVOHX8XQUvIJScc5SGPmGNNIdXK0h2ReqgJQTeyiCMVOUpJaytEuf7+2ZyEGgoU2nRh447tB1mU76xMzWQdrwDYzix823/ce7P1amdSH6WfEX3ni1ZP6XuHfnXgqv0Q8nrsqT4qDmAo16XXLb9uIizazyWIiuXvEGJJWj/ZjfosjWg7np9WB6EVWvCQa8OiFZqCujNLFfMw92vk9pJgxKxbotavE9m+xfts7FmZ+7gsV04I4rcUnhOuxBy0TqsNMDOli8Wzql6106i3jyDG9E7ETrE3CBt1X95+g1Nelpz+9Ig++Pitwc1GwR8olFSEvYjgYpWMAw5c4HGfU/0VxfIL5RuQliMOjXz90ROwLZAkZz2i9UWN+mBqzXZonOgbdnFeUysMJJgy+b1H672+rwqFzOJG/Jd/whv/mXprd8EE6gVN9DOY6vn//gMz6bvN1IQSVOl9krEjgCRdG7/m71zXOgVomQPHFvGK3Od3Zuohu+M5NBsEjUwgQgEEcw69t2tmD0ykNWsBcLybuZgAOVUCuRj9gKGiIpY9GJmtGujjnDO3vedv0+/8BZTRp6tRPAHrAZ0bpUFnb2bhzTa93hxnjSJCZPE/YE6do2s4GpL9wfoow1cgpXHXe0IrJUHHzHBX43bO30W9L2KsN+HwMbuZ2O+BvooVY4rNY6oKoz45efgYjADro6qyIOUfxr1P4KRCLycex0DazEF0Lqc3LItBmT0wKC5P2zOdmgUSW7vk7vDPcz1gkYuy8VKbtW9f1TmE3QKbAD0ICBZVIYsKAzwBod3u9YVRshrxakMMz/utPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(53546011)(6506007)(6486002)(38070700005)(478600001)(71200400001)(122000001)(26005)(2616005)(83380400001)(33656002)(8936002)(41300700001)(2906002)(36756003)(91956017)(6916009)(76116006)(5660300002)(4326008)(66946007)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(186003)(86362001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Cd4ezSN5iNEBu9FDHGvP1UZnxYWA5BXmmoFEWpbhkZFNT01lp2UebSP+hBF?=
 =?us-ascii?Q?Y/gigPAYNet8bigKcIGr+hlhqFsCMqS9fTFmM5H/nFhLX7NlIDA80bnNzuei?=
 =?us-ascii?Q?yCMxCU6149DaKYiKSmM4CPlxNg5ECNyBCwtubytbAgymoF1m4Cy57SHvx74P?=
 =?us-ascii?Q?elPHQC2FO207vbC6ua4yPILOz9Ai9yKGc/J2D8exX6RrpGCw+fjeef+l7UjE?=
 =?us-ascii?Q?HrFhTLa3qwQOf6DTP9XvzCdzKm/hXai05lY+NmQYyIg5a1oG5KZXPcipvzwg?=
 =?us-ascii?Q?jich4tgWNutLP+gc8hbdHZpM+LG/SWKVUJSDYTGxpUv2USCn2XQJRH+sjNrM?=
 =?us-ascii?Q?q7x3BSIaunF3hZHAIJ0Gdb5at2prkgtb2YtbCKDJAyZySZCrDFwulRmQMgEZ?=
 =?us-ascii?Q?ICaeC8Otr6nhfgNVj4nuuRLUKeXOsaAK3JNukVk633Yqt8ZnhcsDjMRr7kIF?=
 =?us-ascii?Q?11T7Ud5hI575yKj86IOSWaTgFDqus0Do4Z854+/28BlsfRJ2w8FqNjD3QK1z?=
 =?us-ascii?Q?ZuRYlsmdeawJ+Dop9qUvRbvWINHHAA089AVSwIAJUp3b/WEmln6eHTDhCu7H?=
 =?us-ascii?Q?FkbtBy4ZQsXAZ2qYGwg3ZcNiqDiX9EunDK4YtbONDNLI0dHoVXosRL58HNmv?=
 =?us-ascii?Q?mrYKNIhqqduMIbfjvs0Z1HB8nm6NX9Ed4aFrIUWCQE4/xPuqGdcs6bd3BOke?=
 =?us-ascii?Q?89fL1sO8+dRq40G5stJp1EdwbRc6J32Xmk59RSo1h9XWATi0n1TbfMbAf4Gi?=
 =?us-ascii?Q?EeuG/4Qs5Opoa3ISHAQwOyWgMepMDJgyhJGB2j9JL5yRr/uzHJfMlOC/axnG?=
 =?us-ascii?Q?9QJoeulGnKin99B65poIx998QYPkxcghK08oBw2fiOhj5sC5de6/uOQ3C4X1?=
 =?us-ascii?Q?7xP5xCWDOXEKVCdHqaxjTrHHlqjyaX8oG/kXrZQCgpKKwkYpnyQj9rLI1s0h?=
 =?us-ascii?Q?y+lEAfg61b4LsfUTLXQk3Q5zxgrHCvSkSq4nMfgloYq7QHmAIx7QMZ0BEVFF?=
 =?us-ascii?Q?cOj2dBM1UR6k70GIqsc0g+v7B1ODMikaVtz5ZrJrLObJIkUJtUBaAwBHAVx4?=
 =?us-ascii?Q?1BI37eQDlqGGAcSG/RSBT6y3voMrfTbBif/U2MkInLFxg409nDAf56yYt2K4?=
 =?us-ascii?Q?kRpIPHhTzmbqZSg+/HeZ9ZPS9uRFA2Y3saEUUn7dV8lgYHf9o5CYxaT89NJ/?=
 =?us-ascii?Q?ARNkMyGtjqDgfYb1MB+9oSkfBW0LoNZlvkQ7an4qTiS7l2ToFy6H427vWROq?=
 =?us-ascii?Q?gaSUCVcmUkGTZXeDtio9J4H2Rt1yqaWEUBNR7mQlT46lvgG0zYFLe0IRh3fr?=
 =?us-ascii?Q?TlaGsd1WTUn5clk/jBokn1SOD2UlPQdj9pLbF1GRFNduPSaO6MXwXRiDq9Rh?=
 =?us-ascii?Q?71bYZ7fJ5Nz2rZEtfIw7nsGrFbcakYcUSDMToaGAfqW4w2F+umgj/MT1FetE?=
 =?us-ascii?Q?rWkmQijIYC8cvD0o3aKrxKiZ+tb0gwTeB96hvDwDU+s/vZ0JoU4HO4+790mG?=
 =?us-ascii?Q?bADAQlZ3Ucv0fA1hZbBAW/QH7z251lReXdSnBBR9lhdueqRYVlL9m3v5NL+N?=
 =?us-ascii?Q?Fy8astwI/3f56kecWPCB/cx1w3ysFpzET5csMDheHSrfYHwNzxrKnInA3t2T?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <480E0E250CB5294EBCD8A4B231D52B67@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5381183-82ac-40f5-38f5-08da55efe7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:43:30.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFVC1JW5d5O3pnqnRNNjRDD+YL09hEKBpWWzSWdzQ3WxBFqgPvIrfhv3u71Ii/wroZwDNSSvigfOURurjdmBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240057
X-Proofpoint-GUID: SGaeQfYF1GT1JKTx9LDMMJOs4z-4aKyA
X-Proofpoint-ORIG-GUID: SGaeQfYF1GT1JKTx9LDMMJOs4z-4aKyA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 13, 2022, at 7:18 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> nfsd_lookup() takes an exclusive lock on the parent inode, but many
> callers don't want the lock and may not need to lock at all if the
> result is in the dcache.
>=20
> Also this is the only place where the fh_locked flag is needed, as
> nfsd_lookup() may or may not return with the inode locked, and the
> fh_locked flag tells which.
>=20
> Change nfsd_lookup() to be passed a pointer to an int flag.
> If the pointer is NULL, don't take the lock.
> If not, record in the int whether the lock is held.
> Then in that one place that care, pass a pointer to an int, and be sure
> to unlock if necessary.

I feel it would be more helpful if the above paragraph were
instead part of a kdoc style documenting comment for
nfsd_lookup(). Can you make that change a part of this patch?

The new API for nfsd_lookup() is making me squirm:

@locked functions as both an input parameter (setting it to
NULL changes function behavior) and an output parameter. That's
always had a bit of a code smell to me. Generally I would create
a separate version of nfsd_lookup() to handle the NFSv4-specific
case, but that would amount to quite a bit of code duplication.

"locked" is a non-descript, perhaps overloaded, name.

Using a boolean would be a better choice for an output type
that can assume only two unique values, but "int" isn't
atypical in this code.

I don't really have any better suggestions, though, so:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |    2 +-
> fs/nfsd/nfs4proc.c |   27 +++++++++++++--------------
> fs/nfsd/nfsproc.c  |    2 +-
> fs/nfsd/vfs.c      |   36 +++++++++++++++++++++++++-----------
> fs/nfsd/vfs.h      |    8 +++++---
> 5 files changed, 45 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 0fdbb9504a87..d85b110d58dd 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
>=20
> 	resp->status =3D nfsd_lookup(rqstp, &resp->dirfh,
> 				   argp->name, argp->len,
> -				   &resp->fh);
> +				   &resp->fh, NULL);
> 	return rpc_success;
> }
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71a4b8ef77f0..79434e29b63f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -411,7 +411,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> }
>=20
> static __be32
> -do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te, struct nfsd4_open *open, struct svc_fh **resfh)
> +do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te,
> +	       struct nfsd4_open *open, struct svc_fh **resfh,
> +	       int *locked)
> {
> 	struct svc_fh *current_fh =3D &cstate->current_fh;
> 	int accmode;
> @@ -455,14 +457,9 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate, stru
> 			open->op_bmval[1] |=3D (FATTR4_WORD1_TIME_ACCESS |
> 						FATTR4_WORD1_TIME_MODIFY);
> 	} else
> -		/*
> -		 * Note this may exit with the parent still locked.
> -		 * We will hold the lock until nfsd4_open's final
> -		 * lookup, to prevent renames or unlinks until we've had
> -		 * a chance to an acquire a delegation if appropriate.
> -		 */
> 		status =3D nfsd_lookup(rqstp, current_fh,
> -				     open->op_fname, open->op_fnamelen, *resfh);
> +				     open->op_fname, open->op_fnamelen, *resfh,
> +				     locked);
> 	if (status)
> 		goto out;
> 	status =3D nfsd_check_obj_isreg(*resfh);
> @@ -537,6 +534,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> 	bool reclaim =3D false;
> +	int locked =3D 0;
>=20
> 	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
> 		(int)open->op_fnamelen, open->op_fname,
> @@ -598,7 +596,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 	switch (open->op_claim_type) {
> 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
> 	case NFS4_OPEN_CLAIM_NULL:
> -		status =3D do_open_lookup(rqstp, cstate, open, &resfh);
> +		status =3D do_open_lookup(rqstp, cstate, open, &resfh, &locked);
> 		if (status)
> 			goto out;
> 		break;
> @@ -636,6 +634,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 		fput(open->op_filp);
> 		open->op_filp =3D NULL;
> 	}
> +	if (locked)
> +		inode_unlock(cstate->current_fh.fh_dentry->d_inode);
> 	if (resfh && resfh !=3D &cstate->current_fh) {
> 		fh_dup2(&cstate->current_fh, resfh);
> 		fh_put(resfh);
> @@ -920,7 +920,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp=
, struct svc_fh *fh)
> 		return nfserr_noent;
> 	}
> 	fh_put(&tmp_fh);
> -	return nfsd_lookup(rqstp, fh, "..", 2, fh);
> +	return nfsd_lookup(rqstp, fh, "..", 2, fh, NULL);
> }
>=20
> static __be32
> @@ -936,7 +936,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> {
> 	return nfsd_lookup(rqstp, &cstate->current_fh,
> 			   u->lookup.lo_name, u->lookup.lo_len,
> -			   &cstate->current_fh);
> +			   &cstate->current_fh, NULL);
> }
>=20
> static __be32
> @@ -1078,11 +1078,10 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> 	if (err)
> 		return err;
> 	err =3D nfsd_lookup_dentry(rqstp, &cstate->current_fh,
> -				    secinfo->si_name, secinfo->si_namelen,
> -				    &exp, &dentry);
> +				 secinfo->si_name, secinfo->si_namelen,
> +				 &exp, &dentry, NULL);
> 	if (err)
> 		return err;
> -	fh_unlock(&cstate->current_fh);
> 	if (d_really_is_negative(dentry)) {
> 		exp_put(exp);
> 		err =3D nfserr_noent;
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 2dccf77634e8..465d70e053f6 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -133,7 +133,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
>=20
> 	fh_init(&resp->fh, NFS_FHSIZE);
> 	resp->status =3D nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
> -				   &resp->fh);
> +				   &resp->fh, NULL);
> 	fh_put(&argp->fh);
> 	if (resp->status !=3D nfs_ok)
> 		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index b0df216ab3e4..4c2e431100ba 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -172,7 +172,8 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc=
_export *exp)
> __be32
> nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		   const char *name, unsigned int len,
> -		   struct svc_export **exp_ret, struct dentry **dentry_ret)
> +		   struct svc_export **exp_ret, struct dentry **dentry_ret,
> +		   int *locked)
> {
> 	struct svc_export	*exp;
> 	struct dentry		*dparent;
> @@ -184,6 +185,9 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> 	dparent =3D fhp->fh_dentry;
> 	exp =3D exp_get(fhp->fh_export);
>=20
> +	if (locked)
> +		*locked =3D 0;
> +
> 	/* Lookup the name, but don't follow links */
> 	if (isdotent(name, len)) {
> 		if (len=3D=3D1)
> @@ -199,13 +203,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 				goto out_nfserr;
> 		}
> 	} else {
> -		/*
> -		 * In the nfsd4_open() case, this may be held across
> -		 * subsequent open and delegation acquisition which may
> -		 * need to take the child's i_mutex:
> -		 */
> -		fh_lock_nested(fhp, I_MUTEX_PARENT);
> -		dentry =3D lookup_one_len(name, dparent, len);
> +		if (locked) {
> +			inode_lock_nested(dparent->d_inode, I_MUTEX_PARENT);
> +			dentry =3D lookup_one_len(name, dparent, len);
> +			if (IS_ERR(dentry))
> +				inode_unlock(dparent->d_inode);
> +			else
> +				*locked =3D 1;
> +		} else
> +			dentry =3D lookup_one_len_unlocked(name, dparent, len);
> 		host_err =3D PTR_ERR(dentry);
> 		if (IS_ERR(dentry))
> 			goto out_nfserr;
> @@ -218,7 +224,10 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 			 * something that we might be about to delegate,
> 			 * and a mountpoint won't be renamed:
> 			 */
> -			fh_unlock(fhp);
> +			if (locked && *locked) {
> +				inode_unlock(dparent->d_inode);
> +				*locked =3D 0;
> +			}
> 			if ((host_err =3D nfsd_cross_mnt(rqstp, &dentry, &exp))) {
> 				dput(dentry);
> 				goto out_nfserr;
> @@ -248,7 +257,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  */
> __be32
> nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> -				unsigned int len, struct svc_fh *resfh)
> +	    unsigned int len, struct svc_fh *resfh,
> +	    int *locked)
> {
> 	struct svc_export	*exp;
> 	struct dentry		*dentry;
> @@ -257,7 +267,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fh=
p, const char *name,
> 	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
> 	if (err)
> 		return err;
> -	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> +	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry, locked=
);
> 	if (err)
> 		return err;
> 	err =3D check_nfsd_access(exp, rqstp);
> @@ -273,6 +283,10 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *f=
hp, const char *name,
> out:
> 	dput(dentry);
> 	exp_put(exp);
> +	if (err && locked && *locked) {
> +		inode_unlock(fhp->fh_dentry->d_inode);
> +		*locked =3D 0;
> +	}
> 	return err;
> }
>=20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 26347d76f44a..b7d41b73dd79 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -45,10 +45,12 @@ typedef int (*nfsd_filldir_t)(void *, const char *, i=
nt, loff_t, u64, unsigned);
> int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> 		                struct svc_export **expp);
> __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
> -				const char *, unsigned int, struct svc_fh *);
> +			    const char *, unsigned int, struct svc_fh *,
> +			    int *);
> __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
> -				const char *, unsigned int,
> -				struct svc_export **, struct dentry **);
> +				    const char *, unsigned int,
> +				    struct svc_export **, struct dentry **,
> +				    int *);
> __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> 				struct iattr *, int, time64_t);
> int nfsd_mountpoint(struct dentry *, struct svc_export *);
>=20
>=20

--
Chuck Lever



