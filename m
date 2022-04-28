Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4C5137AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiD1PHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiD1PHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:07:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6FB3DD5;
        Thu, 28 Apr 2022 08:04:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SDGw7b032176;
        Thu, 28 Apr 2022 15:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xpHLy33ACu56MmmkwydlS06/eRzck8oHStYEnUSRzxg=;
 b=ldUDD4tiVdmFskGyR/E111E93DuEdrHesujrUguD23so7NvkPCBrwPIDRyOETQ9UzWFx
 wmll3YDHe5qQ1TbkvsiidX/D5wDDaFvABIGGLoKYx3uZ/cxIxkWB8N+uIh0bCV6pPC5t
 jpNYAAuNxspdWQsDwJEC0nixkXgou1fjlXh2IJ4WteFNlun60Dskr4g2AuTiyXHsrH1j
 AhtaXNBCs//rPeNLfXdHTq3pxe/kYILIbiIYVEhqLEBEAKBjJ8glmHubCVzsOP6fhgAw
 z4UO0mTKl0aQr6Fx0nUehdp0zptJtZgWDcGkvPRnqVp977DlylwrQVN14m0lPfkR3F2f KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb103s5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:03:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SEodh0016479;
        Thu, 28 Apr 2022 15:03:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ynxvve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFTJC4vJnMlI7Opwh+JCrXv2x9tDc4eX21bRRqxG+cn3qRcRb7rJ0j/fjQOqoJlZGqfvr243E2LhNLdP8ZOjBNTYaiScAzgGsreL+C0fgJ6ZSeFU7EKkKox6Yzwcn0jHPLIAdhL/Xy1A4o3v/SAVV0pDaKmTBOuHzbYj+xlO+Vtx5G5sImNzTcj28VK6VsgXdzyV/+gOHVtA0ta/0HO29Y4qfOKd3phLg4b/qizC22PbUaOUJPEXOfigUouxQ7BmeAhd6yZN4v1Mzej5/4TEsc3h1rtqmgEE7+6DAug+7qtXzHz4VzLXYh2OeQwfFwXQ40Udombv7RNQt3a3SLvz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpHLy33ACu56MmmkwydlS06/eRzck8oHStYEnUSRzxg=;
 b=UG8yCqpTaPXD8vq6ttL+smWcqwYG+U19bc/deoAQf+y8D24xXznpFo5c44HSP2eF4kYd10HFgzYggsbvl64TUfxSjHBuQOtVcXAOfLcTTQiGKMQUjI+1/g+AHOQPZQ3O5cJAZs11VNlxeUxv+wEr9S/MxRX27KnOVAs6+hrzCf/E6aauHm6O7ggLN/co70j9a6bBLPZ8DSf7ytjVVyZPhNNChA4CXHkgs+/6N4pk17zIjDLE9H/WUCOR17zc5E6dvI7tBN7rMSvBGwtMrhRLPMNxJCznw49KHwIciTEDV1noTywFFRRKBRFNfTdKBC1JSscdLLTWUNnFw1CBC1ZK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpHLy33ACu56MmmkwydlS06/eRzck8oHStYEnUSRzxg=;
 b=xUxAd13PVhoD/FbgUl8XJmjBP2NeILwoCFow7YRDuxTGUnWs0KHhNZ8JGNTjnOY2e3PliH46jX+JVwM+BPFJcqqPjo8VY44jaZ24baMfuPkUnOGfV6KlqiHQXSdxZbyHOfCB2MyOBtraA/hpko5WoFyaosRkPh81fJEc3ebM6vU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5015.namprd10.prod.outlook.com (2603:10b6:408:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 15:03:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 15:03:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYWs6CPuCkiaNLVUqe4GH4xweRu60FbLsA
Date:   Thu, 28 Apr 2022 15:03:53 +0000
Message-ID: <82D9D8C2-8873-4B76-8708-E25F708353F0@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3d40aef-6542-4af9-98c6-08da29284f63
x-ms-traffictypediagnostic: BN0PR10MB5015:EE_
x-microsoft-antispam-prvs: <BN0PR10MB5015043687FE096AC8E8241B93FD9@BN0PR10MB5015.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxgFUd+0alH+OEPMLLbBdqLAJ/2kcPydogPBhREjHyc54vc5nrBf4iXtW7YT+J75obDS/Hd9ZGZAc+tCUPEprKivB/3SKZSclRMA0EKb+ftb9g14Q0nBADer39wlxrUFnko3hetcS+HqvBOSPI0xwPBgIZgqBC4NJxSf6zXkMqlgXDv7bREEvfbs3cnly59tMqpri95H4nCZsvApWG2veg/bwaU7TXkkdxMDD0HkrEjCUEpcqz9RoUeSqS3POAsjGc50hj1RcBQA0ePAqYfK9tRWjQoaYti1uEi5XDTCuaVXPzX9+AIwunN09pGFH1Ve5rtAE57uR3b+cTFYSZ7jZCTcp/eWoHo7z+OUkZYZLOfiBqrRc8/6y5jaOduggBJJOwjzzWznMJtakZEKfXRBp+9ghAl+AQrAzrMVQbtkyQ34oRovNmeVtBjv+NsVf8EVWZzuh8GIWJOdSJRyoXvR3Q2jQuon0mBUJnZ2lxVnhdnewfVdGBNGSgLBxi3kJEtxLQHsA6mo/o3o1L4NR5DqdiizIYQ5JXtHA0uUtOs9MWUg2Y+P2nPJrBNqwMsqQwJp6bbPvgcRDVrUAMGT0k+uuKCSwTLx7kKRXxQjlTVJXibzW7rS2bl9Iwgvki6mGyY7sw90q5PlOOYq4cVIodBGUkwnconWpT1KosY0ENTFxwjRArB/FfIcI+iuNf40yYlPMB6mi/rhaeHHE4nroDbRN7/v8V8mVYiA8V3LGvBJxAHfqYQk+PV3wWIoNsAdDHwwNCEtlRkCo+gRzpfYFY+B4gvO+Y8Fbtyme+v18fSu5uvhHVfdF5aqHZoxQX2WieOfm1zlBSK9YL+z4JtE5j6rqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(30864003)(5660300002)(6506007)(6512007)(37006003)(6636002)(38070700005)(38100700002)(2906002)(53546011)(186003)(8936002)(33656002)(36756003)(2616005)(83380400001)(6486002)(508600001)(71200400001)(966005)(122000001)(76116006)(86362001)(66946007)(91956017)(6862004)(316002)(66446008)(66476007)(66556008)(8676002)(64756008)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8RiPilLZgA4zKNXAuZS0JzlzJLYT1MeYehwBsU6Wlaq2jTfPXvJannXxPAs?=
 =?us-ascii?Q?C9BW03A4XJAeML9wvwjY14uh8wwvaZXN6ZlA8Nd74OIXYqkSJDkHpgXV1UpE?=
 =?us-ascii?Q?os/Yi18KmG6Dz61X0omWuxp36P01GOA4CVmoRajH2YRZsTUr+GI+KubjAP5s?=
 =?us-ascii?Q?BfoW4OpsYhjuMZ0YqH2qqpGTOvpKZoIwvP7FT5Fop+Y5fvMO+M1DfXXLC6Pz?=
 =?us-ascii?Q?bVnPia1S8ZaOTAKjbQLwGlUdvPjjGqMaekYqCMY2Z80YfsogRHZwoH63K1TF?=
 =?us-ascii?Q?T1itKf82UWwIO8PR/aDRqw5jgddLKvIHau0HFO/486fp5UWVIqHiqfdmvna5?=
 =?us-ascii?Q?UFuAKc5RnArvkaqrAkoatoycjJjKd6iC/BNJBXQoOjNfOM6b7Pf6Usgs0bi8?=
 =?us-ascii?Q?WOujPLqkx0UJxSPlVJAbykkH9bSdSrn0O2uWAtbxtBiQ/FgSsmT1qu2EDGmk?=
 =?us-ascii?Q?AvHOioV67t2D5keHvpJnQgYL8vX0/aDxm3QcFQ5ZKCEDgbrZpSy+0xQaFccv?=
 =?us-ascii?Q?jgBeOUJFCGIH5QEi2jYSItpSpqfQKllUBazqBSnROvGl4e13Kd2NFHKTcCUP?=
 =?us-ascii?Q?315+oN7OMUtdZsfJsB/EiGCrWiGUZhHk0BDxWlD8AcWjdnUstCLXMSI35r3l?=
 =?us-ascii?Q?j04rJN7MKz81UQ/thtrbLNe4ltrKTJQsikFgscG/QgIk71xUsr75s/jp/7cP?=
 =?us-ascii?Q?lDyCV2GI+yZCzusrt1CQeRrl3pkxtezNu2LzliG3Ka8Cm+1sz3q0qRuft/bw?=
 =?us-ascii?Q?b38F547r+wOooW6Z6c/tPWBM7D5Akzv/BAAKyfUaJh5LwCVs+Q3VTcXXRILM?=
 =?us-ascii?Q?Vko/pXcII31r06QYdnkGWWoqJp7iMlWHf8BAkuGBWIGz/dPwUjOznQrg6K4M?=
 =?us-ascii?Q?Sxqpzpo5blV/wZVa2uHOvWN16OMEMiK5xtpwt7yK8kgdss2BJ+V8xszQZFnA?=
 =?us-ascii?Q?FfPopiiS8XuwoOCc5b7u9Ijx4RQC28NomwuoxlNRH/01o9C2iaOOjaU8drRv?=
 =?us-ascii?Q?pbxML21xP6gfEqP4gTwAQmjiApyHYguP4CvpmfnAJtG1aiq38RjbkBGiBRwX?=
 =?us-ascii?Q?NMnVLjtr+NR/Slvi3I5bPoT4MFSVZjIJqm6MbIPL6p+mW8g39fyhS3OZWGpg?=
 =?us-ascii?Q?Y+Qef8qSN7dkODZy+L2EdgDRqXAP71VRb2leqG7NTH469adKc4XgA2ATefKm?=
 =?us-ascii?Q?cmUqCdGiltwQhuUNg7fcPRB1mmNkfCq/WgU5s4HjyQKI7BmA/uIR+Uak1tsw?=
 =?us-ascii?Q?1j0I4u4wZg9cAwDxO73zrC2hoLxRcbA+wOqId+fhGLIbOhIRWKe+9JsY1PvQ?=
 =?us-ascii?Q?4/l04ELi94AWoEd55sOMx8kkOmUgbFEDMjkjhcSB2onHxYZZgBE4xCN+2GjX?=
 =?us-ascii?Q?HtF0hRk0shfcaOK+ZA69od+pADkkJTkrkbkkulmA1JtCu26dHCaFsUUNt+kR?=
 =?us-ascii?Q?GnunFEt4r2UC/9b9oYY/Pjxszcn+jiA/pxbQ6/BYS0liDFF7ZmZbVjQjn/8L?=
 =?us-ascii?Q?s9dDkaF4/pZD3uLzrpK7DVjPJz5kUHqwduWEcrgQjhD7ttZl2Y+Mj/4buxM4?=
 =?us-ascii?Q?uU7pj625Ci5Sslt4GTrPQMm7fzhN4JWiJQUm2elaD3N7dQMGmph2/ZXgfQ9i?=
 =?us-ascii?Q?hfdPrOGakzrqNnTVT41A/UMrBOZmOLXX2ipdN+dU3PbdIsHzTG9x4KBm4/rk?=
 =?us-ascii?Q?2f0F/BCaqMNX0J/v4ysGi3CZUdS/eTyNfxJ9/KpXcur197OVlBIRDyN4mcjm?=
 =?us-ascii?Q?ZxCVb8xfH1a4T3gBaVrYSjkfrAYxo2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9E130A5FB8AAD4CBBD9B4CCA3CB0831@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d40aef-6542-4af9-98c6-08da29284f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 15:03:53.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGFKCFifaeeKm8IpigtSSs6idSAHrvSwgXOyVjIaqPKnz2qiK1kC42u/MLGMR0OqRoD4X/hLj6G7Hpdo5q4czQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280091
X-Proofpoint-ORIG-GUID: AuQ5FxTxcg8_TpBvb1lqC0tmRKbJqgJn
X-Proofpoint-GUID: AuQ5FxTxcg8_TpBvb1lqC0tmRKbJqgJn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 28, 2022, at 3:06 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Chuck, Bruce
>=20
> This series of patches implement the NFSv4 Courteous Server.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> v2:
>=20
> . add new callback, lm_expire_lock, to lock_manager_operations to
>  allow the lock manager to take appropriate action with conflict lock.
>=20
> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>=20
> . expire courtesy client after 24hr if client has not reconnected.
>=20
> . do not allow expired client to become courtesy client if there are
>  waiters for client's locks.
>=20
> . modify client_info_show to show courtesy client and seconds from
>  last renew.
>=20
> . fix a problem with NFSv4.1 server where the it keeps returning
>  SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>  the courtesy client reconnects, causing the client to keep sending
>  BCTS requests to server.
>=20
> v3:
>=20
> . modified posix_test_lock to check and resolve conflict locks
>  to handle NLM TEST and NFSv4 LOCKT requests.
>=20
> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>=20
> v4:
>=20
> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_loc=
k
>  by asking the laudromat thread to destroy the courtesy client.
>=20
> . handle NFSv4 share reservation conflicts with courtesy client. This
>  includes conflicts between access mode and deny mode and vice versa.
>=20
> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>=20
> v5:
>=20
> . fix recursive locking of file_rwsem from posix_lock_file.=20
>=20
> . retest with LOCKDEP enabled.
>=20
> v6:
>=20
> . merge witn 5.15-rc7
>=20
> . fix a bug in nfs4_check_deny_bmap that did not check for matched
>  nfs4_file before checking for access/deny conflict. This bug causes
>  pynfs OPEN18 to fail since the server taking too long to release
>  lots of un-conflict clients' state.
>=20
> . enhance share reservation conflict handler to handle case where
>  a large number of conflict courtesy clients need to be expired.
>  The 1st 100 clients are expired synchronously and the rest are
>  expired in the background by the laundromat and NFS4ERR_DELAY
>  is returned to the NFS client. This is needed to prevent the
>  NFS client from timing out waiting got the reply.
>=20
> v7:
>=20
> . Fix race condition in posix_test_lock and posix_lock_inode after
>  dropping spinlock.
>=20
> . Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
>  callback
>=20
> . Always resolve share reservation conflicts asynchrously.
>=20
> . Fix bug in nfs4_laundromat where spinlock is not used when
>  scanning cl_ownerstr_hashtbl.
>=20
> . Fix bug in nfs4_laundromat where idr_get_next was called
>  with incorrect 'id'.=20
>=20
> . Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
>=20
> v8:
>=20
> . Fix warning in nfsd4_fl_expire_lock reported by test robot.
>=20
> v9:
>=20
> . Simplify lm_expire_lock API by (1) remove the 'testonly' flag
>  and (2) specifying return value as true/false to indicate
>  whether conflict was succesfully resolved.
>=20
> . Rework nfsd4_fl_expire_lock to mark client with
>  NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
>  the client in the background.
>=20
> . Add a spinlock in nfs4_client to synchronize access to the
>  NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
>  handle race conditions when resolving lock and share reservation
>  conflict.
>=20
> . Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
>  are now consisdered 'dead', waiting for the laundromat to expire
>  it. This client is no longer allowed to use its states if it
>  reconnects before the laundromat finishes expiring the client.
>=20
>  For v4.1 client, the detection is done in the processing of the
>  SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
>  to re-establish new clientid and session.
>  For v4.0 client, the detection is done in the processing of the
>  RENEW and state-related ops and return NFS4ERR_EXPIRE to force
>  the client to re-establish new clientid.
>=20
> v10:
>=20
>  Resolve deadlock in v9 by avoiding getting cl_client and
>  cl_cs_lock together. The laundromat needs to determine whether
>  the expired client has any state and also has no blockers on
>  its locks. Both of these conditions are allowed to change after
>  the laundromat transits an expired client to courtesy client.
>  When this happens, the laundromat will detect it on the next
>  run and and expire the courtesy client.
>=20
>  Remove client persistent record before marking it as COURTESY_CLIENT
>  and add client persistent record before clearing the COURTESY_CLIENT
>  flag to allow the courtesy client to transist to normal client to
>  continue to use its state.
>=20
>  Lock/delegation/share reversation conflict with courtesy client is
>  resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>  effectively disable it, then allow the current request to proceed
>  immediately.
>=20
>  Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed
>  to reconnect to reuse itsstate. It is expired by the laundromat
>  asynchronously in the background.
>=20
>  Move processing of expired clients from nfs4_laudromat to a
>  separate function, nfs4_get_client_reaplist, that creates the
>  reaplist and also to process courtesy clients.
>=20
>  Update Documentation/filesystems/locking.rst to include new
>  lm_lock_conflict call.
>=20
>  Modify leases_conflict to call lm_breaker_owns_lease only if
>  there is real conflict.  This is to allow the lock manager to
>  resolve the delegation conflict if possible.
>=20
> v11:
>=20
>  Add comment for lm_lock_conflict callback.
>=20
>  Replace static const courtesy_client_expiry with macro.
>=20
>  Remove courtesy_clnt argument from find_in_sessionid_hashtbl.
>  Callers use nfs4_client->cl_cs_client boolean to determined if
>  it's the courtesy client and take appropriate actions.
>=20
>  Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
>  with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.
>=20
> v12:
>=20
>  Remove unnecessary comment in nfs4_get_client_reaplist.
>=20
>  Replace nfs4_client->cl_cs_client boolean with
>  NFSD4_CLIENT_COURTESY_CLNT flag.
>=20
>  Remove courtesy_clnt argument from find_client_in_id_table and
>  find_clp_in_name_tree. Callers use NFSD4_CLIENT_COURTESY_CLNT to
>  determined if it's the courtesy client and take appropriate actions.
>=20
> v13:
>=20
>  Merge with 5.17-rc3.
>=20
>  Cleanup Documentation/filesystems/locking.rst: replace i_lock
>  with flc_lock, update API's that use flc_lock.
>=20
>  Rename lm_lock_conflict to lm_lock_expired().
>=20
>  Remove comment of lm_lock_expired API in lock_manager_operations.
>  Same information is in patch description.
>=20
>  Update commit messages of 4/4.
>=20
>  Add some comment for NFSD4_CLIENT_COURTESY_CLNT.
>=20
>  Add nfsd4_discard_courtesy_clnt() to eliminate duplicate code of
>  discarding courtesy client; setting NFSD4_DESTROY_COURTESY_CLIENT.
>=20
> v14:
>=20
> . merge with Chuck's public for-next branch.
>=20
> . remove courtesy_client_expiry, use client's last renew time.
>=20
> . simplify comment of nfs4_check_access_deny_bmap.
>=20
> . add comment about race condition in nfs4_get_client_reaplist.
>=20
> . add list_del when walking cslist in nfs4_get_client_reaplist.
>=20
> . remove duplicate INIT_LIST_HEAD(&reaplist) from nfs4_laundromat
>=20
> . Modify find_confirmed_client and find_confirmed_client_by_name
>  to detect courtesy client and destroy it.
>=20
> . refactor lookup_clientid to use find_client_in_id_table
>  directly instead of find_confirmed_client.
>=20
> . refactor nfsd4_setclientid to call find_clp_in_name_tree
>  directly instead of find_confirmed_client_by_name.
>=20
> . remove comment of NFSD4_CLIENT_COURTESY.
>=20
> . replace NFSD4_CLIENT_DESTROY_COURTESY with NFSD4_CLIENT_EXPIRED.
>=20
> . replace NFSD4_CLIENT_COURTESY_CLNT with NFSD4_CLIENT_RECONNECTED.
>=20
> v15:
>=20
> . add helper locks_has_blockers_locked in fs.h to check for
>  lock blockers
>=20
> . rename nfs4_conflict_clients to nfs4_resolve_deny_conflicts_locked
>=20
> . update nfs4_upgrade_open() to handle courtesy clients.
>=20
> . add helper nfs4_check_and_expire_courtesy_client and
>  nfs4_is_courtesy_client_expired to deduplicate some code.
>=20
> . update nfs4_anylock_blocker:
>   . replace list_for_each_entry_safe with list_for_each_entry
>   . break nfs4_anylock_blocker into 2 smaller functions.
>=20
> . update nfs4_get_client_reaplist:
>   . remove unnecessary commets
>   . acquire cl_cs_lock before setting NFSD4_CLIENT_COURTESY flag
>=20
> . update client_info_show to show 'time since last renew: 00:00:38'
>  instead of 'seconds from last renew: 38'.
>=20
> v16:
>=20
> . update client_info_show to display 'status' as
>  'confirmed/unconfirmed/courtesy'
>=20
> . replace helper locks_has_blockers_locked in fs.h in v15 with new
>  locks_owner_has_blockers call in fs/locks.c
>=20
> . update nfs4_lockowner_has_blockers to use locks_owner_has_blockers
>=20
> . move nfs4_check_and_expire_courtesy_client from 5/11 to 4/11
>=20
> . remove unnecessary check for NULL clp in find_in_sessionid_hashtb
>=20
> . fix typo in commit messages
>=20
> v17:
>=20
> . replace flags used for courtesy client with enum courtesy_client_state
>=20
> . add state table in nfsd/state.h
>=20
> . make nfsd4_expire_courtesy_clnt, nfsd4_discard_courtesy_clnt and
>  nfsd4_courtesy_clnt_expired as static inline.
>=20
> . update nfsd_breaker_owns_lease to use dl->dl_stid.sc_client directly
>=20
> . fix kernel test robot warning when CONFIG_FILE_LOCKING not defined.
>=20
> v18:
>=20
> . modify 0005-NFSD-Update-nfs4_get_vfs_file-to-handle-courtesy-cli.patch =
to:
>=20
>    . remove nfs4_check_access_deny_bmap, fold this functionality
>      into nfs4_resolve_deny_conflicts_locked by making use of
>      bmap_to_share_mode.
>=20
>    . move nfs4_resolve_deny_conflicts_locked into nfs4_file_get_access
>      and nfs4_file_check_deny.=20
>=20
> v19:
>=20
> . modify 0002-NFSD-Add-courtesy-client-state-macro-and-spinlock-to.patch =
to
>=20
>    . add NFSD4_CLIENT_ACTIVE
>=20
>    . redo Courtesy client state table
>=20
> . modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch =
and
>  0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch to:
>=20
>    . set cl_cs_client_stare to NFSD4_CLIENT_ACTIVE when reactive
>      courtesy client =20
>=20
> v20:
>=20
> . modify 0006-NFSD-Update-find_clp_in_name_tree-to-handle-courtesy.patch =
to:
> 	. add nfsd4_discard_reconnect_clnt
> 	. replace call to nfsd4_discard_courtesy_clnt with
> 	  nfsd4_discard_reconnect_clnt
>=20
> . modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch =
to:
> 	. replace call to nfsd4_discard_courtesy_clnt with
> 	  nfsd4_discard_reconnect_clnt
>=20
> . modify 0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch
> 	. replace call to nfsd4_discard_courtesy_clnt with
> 	  nfsd4_discard_reconnect_clnt
>=20
> v21:
>=20
> . merged with 5.18.0-rc3
>=20
> . Redo based on Bruce's suggestion by breaking the patches into functiona=
lity
>  and also don't remove client record of courtesy client until the client =
is
>  actually expired.
>=20
>  0001: courteous server framework with support for client with delegation=
 only.
>        This patch also handles COURTESY and EXPIRABLE reconnect.
>        Conflict is resolved by set the courtesy client to EXPIRABLE, let =
the
>        laundromat expires the client on next run and return NFS4ERR_DELAY
>        OPEN request.
>=20
>  0002: add support for opens/share reservation to courteous server
>        Conflict is resolved by set the courtesy client to EXPIRABLE, let =
the
>        laundromat expires the client on next run and return NFS4ERR_DELAY
>        OPEN request.
>=20
>  0003: mv creation/destroying laundromat workqueue from nfs4_state_start =
and
>        and nfs4_state_shutdown_net to init_nfsd and exit_nfsd.
>=20
>  0004: fs/lock: add locks_owner_has_blockers helper
>=20
>  0005: add 2 callbacks to lock_manager_operations for resolving lock conf=
lict
>=20
>  0006: add support for locks to courteous server, making use of 0004 and =
0005
>        Conflict is resolved by set the courtesy client to EXPIRABLE, run =
the
>        laundromat immediately and wait for it to complete before returnin=
g to
>        fs/lock code to recheck the lock list from the beginning.
>=20
>        NOTE: I could not get queue_work/queue_delay_work and flush_workqu=
eue
>        to work as expected, I have to use mod_delayed_work and flush_work=
queue
>        to get the laundromat to run immediately.
>=20
>        When we check for blockers in nfs4_anylock_blockers, we do not che=
ck
>        for client with delegation conflict. This is because we already ho=
ld
>        the client_lock and to check for delegation conflict we need the s=
tate_lock
>        and scanning the del_recall_lru list each time. So to avoid this o=
verhead
>        and potential deadlock (not sure about lock of ordering of these l=
ocks)
>        we check and set the COURTESY client with delegation being recalle=
d to
>        EXPIRABLE later in nfs4_laundromat.
>=20
>  0007: show state of courtesy client in client info.
>=20
> v22:
>=20
> . modify 0001:
> 	. allow EXPIRABLE client to reconnect.
>        . modify try_to_expire_client to return false if cl_state is
>          either COURTEY or EXPIRABLE.
>        . remove try_to_activate_client and set cl_state to ACTIVE in
>          get_client_locked and renew_client_locked.
>        . remove unnecessary cl_cs_lock. Synchronization between expiring
>          client and client reconnect is provided by mark_client_expired_l=
ocked
>          and get_client_locked or renew_client_locked
>=20
> . modify 0003:
>        . fix 'ld' error with laundry_wq when CONFIG_NFSD is defined
>          and CONFIG_NFSD_V4 is not defined.
>=20
> v23:
> 	. rework try_to_expire_client to return true when cl_state in EXPIRABLE
> 	  and its callers to work accordingly.
>=20
> 	. add missing mod_delay_work in nfsd4_lm_lock_expirable.
>=20
> 	. add check for cl_rpc_users before setting client state to COURTESY
> 	  in nfs4_get_client_reaplist.
>=20
>        . setting client to COURTESY before nfs4_anylock_blockers to handl=
e
>          race between the laundromat and thread resolving lock conflict.
>=20
> 	. cleanup 2 fs/lock callbacks: lm_lock_expirable to return bool and
>          lm_expire_lock takes no argument.
>=20

v23 has been pushed to the nfsd-courteous-server topic branch in

   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


--
Chuck Lever



