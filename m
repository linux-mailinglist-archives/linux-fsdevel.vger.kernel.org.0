Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD97628388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiKNPI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiKNPIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:08:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910A2CDDD;
        Mon, 14 Nov 2022 07:08:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEk5C9004939;
        Mon, 14 Nov 2022 15:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PS4hf9h/P5x5MVXpOJ7qXJ++x/FyQ73ADFmWLqkaXag=;
 b=dGqN8/u8CcajxouiSt0LcQykmmTkAW2nhwSD3pzwXJQXW8+T6Fpy/azPQciKLtRt/786
 51ltSde3mx6J6FxY3O/11e+ONq7WmWHvv+vkYikrlUuxQrtMqh+2N2kEWSBP6AORdSm8
 ZaXQ8M1B8mmHEEv2sRZ4T6NL3d9I4vWiFF89bDpn0mxIgkLnW376mivaPnyIyQCiPIgu
 TIKNpwK/WJBKtLVOWCj2D9Nju1C30Y34lnmOegYtCHL2+eSbstdb8PCm/mRcQ7Os793f
 R8WSYFvEherqB6MFUcyWxAH7ixtKiZxaBJFKdPy664+ifczwH4/cctKdXfdJwenlpS+K sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1gwja6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:08:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEExfGj034900;
        Mon, 14 Nov 2022 15:08:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x48ay1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH3DgUR9EJTdolEISKhfCbdfmRASdg0Z/Dk5HatejXRhCzjqfll0h3z2SqTgcnfEz3DHtcUxRjbdwdENvvtKJP4JILYMaJVQverl6VjUGZycv6p/ne9sD1FdruflCZBgy+hUAiYgFW43GLh9rlOcsMSUei4IAcNClBGaUnY5WksWZvmLg7F39hU1do02rBbmO1tuvl8X6A01qIEdPydXW4RfHAncI5lAZvpWIrT03lkxOslyFiaKGQamzMb0OF2K9EwbsbSV/57ZJ1jYr4p9gHTBD4JC5pqAatzRWbWYZ1GOxtiAySHlip2ou8qRm3DaC/6SOwcOSGK5jmlG0MF4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS4hf9h/P5x5MVXpOJ7qXJ++x/FyQ73ADFmWLqkaXag=;
 b=O8OHtmhvVZ2KewB7b+RTtDKNpkNb5zcYRuFxWyfwtNMsO/pctcy6D9rI9ONTYUX9W4UnnKWl+ZRGg4IXsKk9Uq8yvhETjKp1qkDMVBRSz4Y1hOvBlnmPv4pmcvOWRiCXcVe8XDJlgMynWCrBuqd9WI3rDlFq1eqbpCP8UVV21RqMD+hWfIJSyVhTG27VoEajPcO8FGxm2fG8uO8sJfnc7zNFm08JvjlwVBhzyUhYJiFObigSThmj1xarf2Y6dlue58yZIzd7PFzv1HzF2nvruvPtqpFB/nYeq/y7uUtVm+VVNpGypRSybEvpoWsnHHEOi/NR2uO1wlkEBLsLaQ/+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4hf9h/P5x5MVXpOJ7qXJ++x/FyQ73ADFmWLqkaXag=;
 b=a++dVt0s61AgUgi/e3n7H0Xnd5iVck9XAVXFjQQQtTY8LVCnTfQe67zIwwFKGFP0RDdlFP6/8ZSPvhEvPm2MWGupKhK3Z6z9E+TDu3RJXgc5vDVTWKIK2hEdlWRXRu+2waaE9+iJW3j8t/MP0bdYy05YwE3tDye5hsWvBux8aXE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:08:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:08:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] filelock: remove redundant filp arguments from API
Thread-Topic: [PATCH 0/3] filelock: remove redundant filp arguments from API
Thread-Index: AQHY+Do5vmCcmi57O0qMMT1RNEW8Uq4+hVMA
Date:   Mon, 14 Nov 2022 15:08:03 +0000
Message-ID: <3C490193-AFF8-479E-ACEF-ADD02E3E15D5@oracle.com>
References: <20221114150240.198648-1-jlayton@kernel.org>
In-Reply-To: <20221114150240.198648-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6819:EE_
x-ms-office365-filtering-correlation-id: 6546ded0-3139-4ece-6fe1-08dac65206f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jD7K2CM7nyfl8fMb2Z6HcipeJbn7J2LVvvng70rZQIlbWKysuHW2/Xo12k+fpbK2xUxnztmA+wTbqww7aEXrhLiFAmFvpnCKgF5v3Q6JsefnUnT+ZclgpUIoU09th5NUVxFh58eHcsWTLkAeETGTBhEiOU24BfipvSikaGgke6qakuK9lt+W5Z96c0R5SrARfIII0eXrfij2pMmjFiNcZQ26YvYBXQxldQC54SbbY/C6Kl/+GRASNOHeXgIQpqTtlEjTKrnzcX805HyvGB2GPSgQcdzRd7WWYEQxXEKu3buI8tDvOW3Krn+u+htYAV9NI3SeK4qar4PHiek+qwY3lVOdu/jyS1ZvipCxlf7Kyyl11weUF/3Dpco9r9WZwmBhk7OUpKVrgoGNGYf7QqP763I91HDVx3zQkEmdZM9hayMeN3bNco/uScesE+4H514N02Vfa4kW2ak1ffUu65vYFEB4XAGLPsPFHCo/4u3ZU02a4ULrDFg9g+l6eUtJuF3Fu9hq78dLRrdiqj+5KNFt/9EQ6TjkoT8QhHYi5sn0xAFMTs6edcQ/UR+Az99YzLCFP0wwRjAwrYMrWmkN9ttvbhlqTu8rAOVLL2VQI5i3Sy3EuoWXNH9yoZxuiAifTDH98anO0lS2i2TXkwK97Qob9/sUeZd/uZOTNckZLkOOMUdFS6crYZvOzmncU/2O3Hcofe7sNuEzdy8vjBG+mkly5A7F6feNvRORB9SBDeaS1uZ/ZV1CXssJxpEROiO4MP602lJUVmOmwiXdcrR6q9pzWytwY34qnsDsf5zWzlQgr1F0BZuZzIMReUeopd4ULe5F/UO/RrFgPe7W+3QmDjc0rG331jmZatMKTmNh+Q+fXneXv6B5vVIr4X7T3fdRo1dl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(6512007)(26005)(6506007)(478600001)(53546011)(966005)(316002)(6916009)(54906003)(38070700005)(6486002)(71200400001)(36756003)(122000001)(38100700002)(86362001)(186003)(2616005)(83380400001)(33656002)(2906002)(91956017)(8936002)(41300700001)(66476007)(8676002)(66446008)(66556008)(64756008)(66946007)(76116006)(4326008)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYYrbUQ8ODIxCCJZ6d9HZk1kc7DSvZiAYfL6+LiZAbffeJFpm+/On+hJMN0q?=
 =?us-ascii?Q?XpQxfi8fDiJ2oaKLOKGR9aT4NCuyPp5WKYYIptK2E2/0WjhkE0q4zPDJJfV+?=
 =?us-ascii?Q?FQKN6UFXA1MybflaDUDYIwKmNAWxBFTtNW5kK4jenjS/iWY23ECG1zzD1RAC?=
 =?us-ascii?Q?v+rErGsIHZfB4psak1PN9M0nK/4X316SwZIJHG2PX5SVI5lJX+buz0EWCOcf?=
 =?us-ascii?Q?dl3AipPZKigeuQyDQFu/Y0ArNtEe+0SeCf+9GhvX7hfzv88px4iH982DWp6M?=
 =?us-ascii?Q?5blKrGkkh1rrpwGlzlhetbeCesj0TDyxS3GpQ70HZT2RA2Z3FoOwvO1tU6ha?=
 =?us-ascii?Q?dg1mzAPGS/3R5TEGApqVK1wCGiDVY2uEVkmHlSYsMu8SyPQt3mEnjGwfBm5s?=
 =?us-ascii?Q?uUP2GEymzmRwExNqg/o9otAz47BbAT47cv1hHAH+/kX8q1U9S3udurSboeDe?=
 =?us-ascii?Q?oRh9AfnwJlPXlGTrRRDakAjn9g9ihKDlWcoR97vobh0uIVSGzaJQo4PB32/z?=
 =?us-ascii?Q?EYm+8AafH8QNuHPXd3vMABcl1yjJkqnS9F/8ssdXN8NQoTX6T82Y/+zsAyEN?=
 =?us-ascii?Q?woEXosEXO1ojnoK+IBDBipq/db6mR8TkQR5fNhxRe59MK8ozZo3Ox390utor?=
 =?us-ascii?Q?0rBVmvhmqMKT7FgkRqlOrsSCN/8llKhACdkvichTtAX7+N1Xl4H1IdAI9syy?=
 =?us-ascii?Q?BaRw5nW41qaAbtp+Ll+sQ5lf88W4n5uPaPgjYITl+xOhaltQirMB0HfPtYQN?=
 =?us-ascii?Q?UnxlOMLk+LPJrk6o1x5eSb6D6qMf49BJ6z2jcu0lpgo1pc0AftAQ24eitpJn?=
 =?us-ascii?Q?MukPXHXhUuK92R5ZYt/fgiRDndFTJEySAe/V2r4qacTw6p+Mc0CwDlBo1lZL?=
 =?us-ascii?Q?8QiinV7nDP89k0pTdkZoeCoIdBZ8w/ngHpJ//qRmWvsLJAKKqf+LSDAODASF?=
 =?us-ascii?Q?tg6GpoKM1ly0fG0Jb/FaHPXIJS92r3NJxqnsPQQEPE0EnGIbTJ3XjSAUhRXM?=
 =?us-ascii?Q?lq2WzxvIBF5vCA52vOZSpk8Yd86HGcoFHLl1daGUofWqx8Kzhmq7w8xmt38M?=
 =?us-ascii?Q?91LKgCuhX1rrfhVIXNCbDwY3wclYRUAC0/Piz1kBuEGPfZNObWaV7wC23RWc?=
 =?us-ascii?Q?jwC35xlhS05vIXkxyrE0zj/k+0qv/F4Uu9sdDgPq30dS6QWZ2tHxrtE/cYVS?=
 =?us-ascii?Q?IZp9xPPp8d2Ljpht3yMBEJ82flfijtucSa3oweGoBlW8MmLTjRSzFFQCpX26?=
 =?us-ascii?Q?u992ywhLQIolSOUS629UYghxn9MkS+at4XGdq3ZN2YIn3AhgUF2GWFdGj7Zf?=
 =?us-ascii?Q?4IFl1B9QRp9DOU6M/DopSNM/VvTZINZv9O7hw9QclX4vfUi8vuGsdNbisyl2?=
 =?us-ascii?Q?v90Znh3HJ1BLZuyFN8HBiwm8iotBZX0AM7G7MRC+qXzHxGzyQaZLfOdnRZw1?=
 =?us-ascii?Q?W0BjhPXodRuR5GD4xlgMXcNbCQaQ5bDyVHKhxiVH7UuKt8W3pg+FOK4+Ver1?=
 =?us-ascii?Q?zBZxvQwYiufOuKXKAm0EbLH0X7CW9rclScK3ZOVLLoiH2SF0yBVcZiq46bAC?=
 =?us-ascii?Q?Om2J5a93ax52krVNgG9tPAbtu67CPDM1bwthFwPC3lHzDHe2lnBYAbTF975R?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49AD734A75E4CC4498DB364FC8B3A4A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jx/52xO53UB6RKmkxaNahDfV24fQDhQHWQN+QvXUogGb53V2hFDbmgXJqsbz0MUOX7OObqrqDVI93PI1RRA+fM4vUFXNCI1HglfhJnANPbzv62nC0qaKqust098X7grqc4r/ExENu656nZftJ2650FJ541f2/KjMlndU8BGYPCV2RS52FKaAka+IaUsfImDvUPXAbpRkGjBIH3x5kxBtliCnBHQbaQ9b1fF1fspnWaPVP/NlrbLalHL0UZ+CpXMWxUwT4nlHLLwL8v7lyMJUpShpxSoJeek3oepBcznTXyRbHQ8jNjGeyi35/P/RX/0jjSmSgAq7NGdRW4IjWweezbdDlbA+W10IrchW5+nB7/SGutC8Qg+JViDEHA3EvYAn31VE1Tv+3GVhtSqrZtXsT5SUXj6bcadUYHJwh/1ZE9tVzuBtxVB7bONTbcHawqs9C0Kf1CLsXXuxReKSExfASyDwQzNg/8nJGfbw/QP+OrYESVBEntQVYjxnKPvdsOCLDr2pk4nRGQfHkl2p/eNmwJ8bWMxmq1M+Fv5McZVr5D+mc75pIEqfCZ/uaNk6IbXGfBRuSW0cQcHE/V+alicqSnYAAFNPTIJe4eThm0Ur2wj/pSSwEO3t7rfqyq2b499D9w55L2QAOqNk9cCLaLNeW2G07VdKvL89dvhkAr1TINhMg49FHNiTAcD78Yj8jRDsF3c5kjFr3wQtkGdvtmcIhMs/8KobLuEVYzfcfXVFIA98MrR4fatKTtd4NhFpaBjesSdvTjSvxX442yLRhIH7ObbNS44AcXgu4CdN2zxljnYPn+ozphY8H3ePAxrWxm1cplzGOB6lTXM0u8145oqIR3mH2zvTROKwn9FKchr/EGjkljqR4pF5/BikdW/Ief0h
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6546ded0-3139-4ece-6fe1-08dac65206f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 15:08:03.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znxLHjlIJ6/7ggZKyvazeKKt5zXsx5dxsXOtQv0VqkpPCN6DGj7b67H9UJYDKI2FHnSfX+jaL5GIKw2Q2yxiiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140108
X-Proofpoint-ORIG-GUID: Umt5e3LpSmmclj1t1vz6yslrdtMRQlAR
X-Proofpoint-GUID: Umt5e3LpSmmclj1t1vz6yslrdtMRQlAR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 14, 2022, at 10:02 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Some of the exported functions in fs/locks.c take both a struct file
> argument and a struct file_lock. struct file_lock has a dedicated field
> to record which file it was set on (fl_file). This is redundant, and
> there have been some cases where the two didn't match [1], leading to
> bugs.

Hi Jeff, doesn't the same argument apply to f_ops->lock ? Do you
have a plan for updating that API as well?


> This patchset is intended to remove this ambiguity by eliminating the
> separate struct file argument from vfs_lock_file, vfs_test_lock and
> vfs_cancel_lock.
>=20
> Most callers are easy to vet to ensure that they set this correctly, but
> lockd had a few places where it wasn't doing the right thing. This
> series depends on the lockd patches I sent late last week [2].
>=20
> I'm targeting this series for v6.3. I'll plan to get it into linux-next
> soon unless there are objections.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D216582
> [2]: https://lore.kernel.org/linux-nfs/20221111215538.356543-1-jlayton@ke=
rnel.org/T/#t
>=20
> Jeff Layton (3):
>  filelock: remove redundant filp argument from vfs_lock_file
>  filelock: remove redundant filp argument from vfs_test_lock
>  filelock: remove redundant filp arg from vfs_cancel_lock
>=20
> fs/ksmbd/smb2pdu.c  |  4 ++--
> fs/lockd/svclock.c  | 21 +++++++--------------
> fs/lockd/svcsubs.c  |  4 ++--
> fs/locks.c          | 29 ++++++++++++++---------------
> fs/nfsd/nfs4state.c |  6 +++---
> include/linux/fs.h  | 14 +++++++-------
> 6 files changed, 35 insertions(+), 43 deletions(-)
>=20
> --=20
> 2.38.1
>=20

--
Chuck Lever



