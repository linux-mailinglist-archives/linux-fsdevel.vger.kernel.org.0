Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437769E5ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjBURZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 12:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjBURZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:25:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD923647
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 09:25:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LGhhgF019761;
        Tue, 21 Feb 2023 17:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VeUcFODN/vE4PrFvgHitZwQPg8rwwNI3tqT/n3BWIss=;
 b=ChAeJ1Sna9o4BDRMULHgFP9O/CeYU23+/NxVAnfkq+NmWGAKcJ6PbrbdCjLAbOOjBIH2
 sywNJQbntv8oRzqCxMLF1XDm568viwWT4tj2lyUL2LY+Na5KZ1iC3PfXoXsPSg0vOG7u
 iLF3c5jT+nzrMUsE9vEnyR81mVONqLJvJfJgg3BTd0tIOYOUgLPj+KYiG/dV2zzhTK51
 WYv5pyzrQPvL6RwoVCFAOTLaPBELbyB/HY8qWQlleg2zoo9U2Jxvnriq5ZSUNrHy1WwM
 RtaHe1MtQc1ERAC9NofKYx/Cdb5O4PibBUHEdZ8h1iOJKdDqxBexWQXlvXPU7pwKgC+/ Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dntqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 17:24:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LG9UMj023169;
        Tue, 21 Feb 2023 17:24:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45ephg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 17:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfnrYF8Ke8AXwW2c9U6j9z7jwvKqSMoWJCKS2zxP5srDs2zyORWnacVmp1u2gH/sjQ3uq2egsrQfU9n45ey8S1R729OzNQMb5JKvDGqXEflNBAcfH8HCa+Lb5usBfUArOgJd3pHTBQPZ6khnGQ4CtCPLj4H6+L7yVCgkgCDxMG8Re27QXj5SXFNju5zLCvcSUgxUX45vXI9u97xU9bH9ums3/EUtbjoMAyNeWtJ4/oqY2HVCZ1hSwFX5fXXWl7NrTrMrWsAPasxRyM9l/psofw6RaCimv2ADwgua0IlrgnSPxnAWyNSvM83PGGQ3aHn0hWtcvLaB/R7CwrHUmN/tVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeUcFODN/vE4PrFvgHitZwQPg8rwwNI3tqT/n3BWIss=;
 b=narmUNZ72M3izrGiG9uXVVBegD2D8YSGgCn2i2MxDUoMhL9f+I9IZupJ72XJpkQSpkItaRL8KX6ReczidA000V/acnPowt2b4qjeXuWGhvqWjekv8PnsF6kOJge7VRnb0QcXT0DluWAayjCGKIXHY+pFXe7oReUHnWOJDF3CxsRv2t//3Fyru7E51L2vPnqfeoMyBU91iB3EWoyC+oI21xb6/StQm/znx0AEdTauFJ33mxXWHkiM6fQxZW8jM1GA0LkCKxtkDjPfTZ7MIsybolRtOufToIoLn0j04I9JgEeisisMX42yQE+pou6ZmX3poCUR8S6Q9+KgrS4M34qWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeUcFODN/vE4PrFvgHitZwQPg8rwwNI3tqT/n3BWIss=;
 b=OBbP2xMCS8abEk9tmdAcgLlIcajCnC+7CTJa74NQ3BsZCT6Rhr9AxXxOApTjQ+4jAZvjltqRg5BkYHCD5U61mSJjDHGoXPoZM7pxigpD1w4xL1Zx5ZnimBoHrv+lhBK+0p2sUvc4nI6SNQBRuYcFfZV7DyXMATmPaI3d/cS1F40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 17:24:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6134.016; Tue, 21 Feb 2023
 17:24:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
Thread-Topic: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
Thread-Index: AQHZRhVake7pth+yaEiYhtqGfgrJbK7ZnyYAgAAHgIA=
Date:   Tue, 21 Feb 2023 17:24:54 +0000
Message-ID: <D684F907-E3B3-4DBC-AD1C-30D95FBADBA4@oracle.com>
References: <2896937.1676998541@warthog.procyon.org.uk>
 <FAD49DB3-977E-4DFE-BC51-B3B3272FBF4A@oracle.com>
In-Reply-To: <FAD49DB3-977E-4DFE-BC51-B3B3272FBF4A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7501:EE_
x-ms-office365-filtering-correlation-id: 5504e145-90b3-4215-f0ec-08db14308c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQ/Hbrr7xStV7v7HbNTg9GlEalmaSQnv1yoF7w+Qw2ylEsWEjM7dT1jZol95r2KqGJ/8PZWIgMhj/Xe+uPhAyN1UKnpa+xb5C2BtsFFHl1mRLZE3RdIpuXb7kVqLBLnBcv6ngdTjNco0Y2PFrtCfUeNH119J2rLhN0gI7n1eJb/tyDr4QjgySIpl3yk6c41Id13E357pTOnQNy17y3et30m06d97LdE9QUjRjI297kEPTv1hee3Mjq6I9C1qdm8003Lv3nW+6Y2B+lxByyFUt4TW6GVwySRWSF/JeP3hr1TAeVF+w97wGlqz+4MptM5PPl1pqt6s/9QUcpCLd79RJc8X48zqri5vv7RpcrKOetx2+xFcjJi8EEilEZvxCWE97ThnD2uoaDWbuhRlGATA92QokABDOD8uuDw6mNnq4UZdqFOBp5b6SCidUNlsYQExgt04QZGkVXddliExjQrmqMT1Xvsd2hcC+gYhNDL83mAzjj0vlXQP7aLi+Qhx03dDitmuk3wa8xMKj8zhedUTD6Hc25yd4b3OCLGRpVtf/2LPmOliwRdocuVVsefhlmeUc+MVhNZpyKPQsMJLyU6I8N+o83B1wEQLneoEOGsEG0heInC3JbGN2pIMtu81uifNVYCpv8RKn42d+IL2fU+ddyLJD5Rj747sEylnDPjBVUWanU6N9rFnDRHwEw+NBeGjz0AFRPXyzTN8WTfqK6phGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(54906003)(83380400001)(316002)(6486002)(966005)(36756003)(478600001)(71200400001)(26005)(53546011)(6512007)(6506007)(33656002)(186003)(2616005)(8936002)(2906002)(38100700002)(15650500001)(5660300002)(41300700001)(38070700005)(86362001)(122000001)(66946007)(76116006)(66476007)(6916009)(4326008)(8676002)(66446008)(64756008)(66556008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVncFd3ZFUvbTY2YkQvY1ZQUERpSGVEU1RaWDVQcWU3bkhCVDV3aksrV05K?=
 =?utf-8?B?TFZ0c3JFVzMxeHVCM1VXbjNOaTNFbFphNHRxZk1ZSkJjRC9nbDJ5TWRIOEdH?=
 =?utf-8?B?SnBUSDRPNU02SE1IbXJiS3RWQ0NOQVRFaFdBeTlSdmJZSDA1MEVoM25uZ1Fk?=
 =?utf-8?B?Vk54am4rc3U4V1FxUWEzd2tzSG5Ib05EekNQN2lWKzFxTjhzK1JJVjFyVkh6?=
 =?utf-8?B?RFNlN0NWWFI4WnpWZ1pndVlhMmszS25aOHQ5c1c0SjM5Yjlucklnb1M5OFNB?=
 =?utf-8?B?cG40aTB5ZlZ6d1UrSEJValFrZFNhM0czV0Y2ZjNpVmpEVVlPOVQrM0NtbkRY?=
 =?utf-8?B?eUpITUZEV3FGK3FKelBRSXhrcnBNbHh1bGo0SnFmbTdnYjdEUHRqbmVBWlZl?=
 =?utf-8?B?dGM2cGRLRUpRcnFYSUFxZmlaem95THBTOFh0NjEzN0RlSStSQWFKUGpRRFpi?=
 =?utf-8?B?NGlEN3h2dDVNa25qZGdXT01TRTVHbE5rdUVtQktKdWZmcDFJTnJQRXhrSStC?=
 =?utf-8?B?NjQyY3Z5SDVwaDViYkQ3V3BhS2lJRXJwd1ptQVBiU3Y1Z21LdmFhdC8vV2J6?=
 =?utf-8?B?OHYxdnp3V3hHZFYrSDNsUkFFS2dudHZCNWxHK1VCQTBIQnRnSDk0MDR2YmQv?=
 =?utf-8?B?UXorK1BJVnRrN1VlTlBxKy9Qc1pEQ3BhU05vY1U3c0xHTkFEdG1NMkZmM3Rk?=
 =?utf-8?B?UDV6TFYxekdiN0JnNWRpbzFBQlVwaDRPaDJtaEpJZVd3OFRsekZzNUowdjJX?=
 =?utf-8?B?NHlpUTBVYWdoWkVkL2dVTDhURHI2cUhRL0F5WC9SQ1JqdDN1bGM3cEozT0g1?=
 =?utf-8?B?QVdmUC9ud1NkTE9IeGhsNG1FTWRCbXZLazRBdm5lL2p3YXUyRjdCTmFPV0p6?=
 =?utf-8?B?dlVac2RqblE0UE5KNkNCOXZKeVVFazZHdzFHVFFTbmlCRGNOc0hJTG9sbmhh?=
 =?utf-8?B?Q1ZyMzlaUmk3aDAzckc1SVQyMW1lL1FaTGw1MmpRRDJteWxta25QM094eFNV?=
 =?utf-8?B?M1E2ekRYNWEvRUdQSlZ1dDhBalZaQVNaYWYwaitydWVzVk01cUVLUm5aMkda?=
 =?utf-8?B?ZFVZeUsxY2Q0ck44V3ZudFA2Z1JjckxpSktCUmhhbDh5dC82TmN1QTRPZk5u?=
 =?utf-8?B?UENvdWt5OFAzcTNEMUFZWnc4UzJBdmRueks3MGZxT3U2NEIzTG9UelBBNS9V?=
 =?utf-8?B?VEk2U1piS0s3UGI2enhZMUozWmpvT296Tm9vMVVtYTFHYVBkOHJEaWZKWUY0?=
 =?utf-8?B?UndrMEREYkR2cTMzc2h0Y3F6QlYwU0szdmE1RUVIdWpKSnk5aDE1STNjZ2dN?=
 =?utf-8?B?eTdOeVQ2Tnd0MEZBbzBoWHdHbXhTdHM5VVlNRHdNWHk3dXc3Y1RsV040UnFS?=
 =?utf-8?B?Q1hzb1ZiZEtRN2lUNzF2VUZ4Q3ZFMlBzWWZ0QTNtZEpyZmk0MVg4RXJ6UU1R?=
 =?utf-8?B?N2YwTFV3SnpWMlFrVG5OQ0pCd055aHFEZ3pwTFIwOE85L1l5aUpDZ1RSOWQw?=
 =?utf-8?B?MVNrWXNJQ29wdmw3MmtkNW5Vdks4NVVrNS9YTmZIVit3T0MvTkFlQ2VoV2tu?=
 =?utf-8?B?ZUo0T1FRM3lrc3hpWVM4WVd6dmV0RHZlb01Qb1VGUjE1bml0enN4ZUZST05S?=
 =?utf-8?B?Q1N0RzgxN1c3aTNJT0FqTDNZMlFMMHhkWjVjTjU2YjZyY3JCb3UvNHBKeWdu?=
 =?utf-8?B?ajFiQjMxbHZQd3hDUWpXSHVyOGthQVdLcktob1YwYzk4MEZBd2xLMVkvell3?=
 =?utf-8?B?cWZyMkhsTjhSVkFCak41bWplbU56UVNMK09qRTRERjBIZVNHYmpHd3NNSFBG?=
 =?utf-8?B?WnZRU3h5SUlhSkhnUXUxQXdnMFhUMko2SnNHZHNLRldLQ2RKOXlSY2NrWVB5?=
 =?utf-8?B?elpHK2UwbzVUTFc4QkVpRFlsUEJ6OTlsU2tLWStnelp6cno2a0VNYWpGczJZ?=
 =?utf-8?B?YXZ6eldXME9ndVJBazVMSklIL3k5emVTTGw5MGR6T3I5WHludGlqTnBlVDBs?=
 =?utf-8?B?Tmh0NVBlb3NLRmhGS0tObitQNHRUb003QWZldU85Z0tzNVV5M0tVczFTOVlx?=
 =?utf-8?B?bE0vbXRyUmJIYTJMTExvSnF1TkIrMW5ZeG1jclhESnRUZk9Qc05KbFJnZEl4?=
 =?utf-8?B?a0orN3BkVy9ybWFQdHFpMlUwWDUwK2djazBsZEJvUU16TW1nb3JYREVSaXBM?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBDFF49CF94C3647BD1C1C0FCCFFC259@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F/blA7QCoV1Czpjyx706h9Pct4SX2IB3ctl7PHXehJzc98tW6yI/JF30/zF3h9gcdg6mEd7jVsKQ3JTR1aFDB5/vbB0/murSkkSSaxu81Kzp+qcz+ZEyMBlXsbd0smBXtgUjWczW9aRLMPIKZU5puDOI1mq9mfuDBknA8pAeavE01lDMbyk+Y73SVI9Ckj2nyPEkQrtrwx15LuNxlaVXDlEpZkCkBP2fuP/+w+oLuzUO9Rjqkwe6rxsSzJK9Gwb/FszGf0EUMaC1ijqWH6jcW0URJEZNBGCHGP/YzZ5u0Zb5NdT7sOdZ6UHQUW0HR/ZIZC0JtQNkNtJsw88i9RaTpZIjhUio2cgY0WTBWB1o1wSLBxQSsOKOyGmCtEFQXb65DzBfiqHUvEHX7J1bBoXAUCK/2bBYYb7OqUwtLIE9AZexHjN5e5YoyH+qYg+Q2D9UfjVcLscOxBmFNHndNlSWzTyPGgjrKnSh170k0/JxOKmqwnwlVLiE4KuJCm23euvsApjLSkHOjKsDIlhoP/UslvC39N9QXzJmdy3eBxHSEdkRxn9RcDiVy2VdmO2NofcRxe/ZJgJ4kgsszmTyZ0uuyV2+is7D0r1u/oce+QVPSEpT+c9GkOjHc7Uug6EaUFWqpYBkrXkcJwFc9TvGwtBMq+IltgMILeDmFADqEBZXSpJKAMZRVfWaicbHfhKA8rpuzLLjwq44CiR7ykbb/jXfsludU6YbpUDsY96DJMxuRfb5hu1ujE9XY/15VQRP56sx/1BACjNK5as3YEHZTwyOVeE6EWg4uEal5Q6PO3uRccM3vsgvaNx0vicAne9qisMPoXFs/lVd8PidCntBAjzAghPVvFC1Ky6V/8/chkYrzmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5504e145-90b3-4215-f0ec-08db14308c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 17:24:54.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyklSLCZ211KOho3eoJAVKBpqkq5l+voK0GrOxF7rh66lg69mobucMND0ge+M9EIAs7ySHdKuSxgNuuO4/Bluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_10,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210147
X-Proofpoint-GUID: Ls89Qv0R2BYbfasoJxAUWyUHc1t5uSkN
X-Proofpoint-ORIG-GUID: Ls89Qv0R2BYbfasoJxAUWyUHc1t5uSkN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEZlYiAyMSwgMjAyMywgYXQgMTE6NTggQU0sIENodWNrIExldmVyIElJSSA8Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gRmViIDIxLCAyMDIzLCBhdCAxMTo1
NSBBTSwgRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+PiANCj4+
IA0KPj4gU2luY2UgdGhlIGZpcnN0IGRheSBvZiB0aGUgTFNTIGlzIHRoZSBzYW1lIGFzIHRoZSBm
aW5hbCBkYXkgb2YgTFNGIGFuZCBpbiB0aGUNCj4+IHNhbWUgdmVudWUsIGFyZSB0aGVyZSBhbnkg
ZmlsZXN5c3RlbSArIHNlY3VyaXR5IHN1YmplY3RzIHRoYXQgd291bGQgbWVyaXQgYQ0KPj4gY29t
bW9uIHNlc3Npb24/DQo+PiANCj4+IExTRi9NTSwgTWF5IDjigJMxMCwgIFZhbmNvdXZlciwgQkMg
KENhbmFkYSkNCj4+IGh0dHBzOi8vZXZlbnRzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbHNmbW0NCj4+
IA0KPj4gTFNTLU5BLCBNYXkgMTAtMTIsIFZhbmNvdXZlciwgQkMgKENhbmFkYSkNCj4+IGh0dHBz
Oi8vZXZlbnRzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbGludXgtc2VjdXJpdHktc3VtbWl0LW5vcnRo
LWFtZXJpY2ENCj4gDQo+IFR3byBJIGtub3cgYWJvdXQ6DQo+IA0KPiBOZXR3b3JrIGZpbGVzeXN0
ZW1zIGhhdmUgb25nb2luZyBpbnRlcmVzdCBpbiB0aGUga2VybmVsJ3MgS2VyYmVyb3MNCj4gaW5m
cmFzdHJ1Y3R1cmUuDQo+IA0KPiBOVk1lIGFuZCBORlMgZm9sa3MgYXJlIHdvcmtpbmcgb24gYSBU
TFMgaGFuZHNoYWtlIHVwY2FsbCBtZWNoYW5pc20uDQoNCkEgcmVsYXRlZCB0b3BpYyBpczogd2h5
IGRvIHdlIGhhdmUgdG8gaGF2ZSBhbiB1cGNhbGwgZm9yIHRoaW5ncw0KbGlrZSB0cmFuc3BvcnQg
c2VjdXJpdHkgbGF5ZXIgaGFuZHNoYWtlcz8gQW4gdXBjYWxsIGZvciB0aGlzIGlzDQpnb2luZyB0
byBjcmFtcCBvdXIgYWJpbGl0eSB0byBzdXBwb3J0IFRMUy1wcm90ZWN0ZWQgcm9vdCBwYXJ0aXRp
b25zDQphbmQgTkZTUk9PVCwgZm9yIGluc3RhbmNlLg0KDQpUaGUgbWFpbiBjb21wbGFpbnQgd2Ug
YXJlIGF3YXJlIG9mIGlzIHRoYXQgdGhlIGtlcm5lbCdzIGNyeXB0bw0KbGlicmFyeSBsYWdzIGJl
aGluZCB1c2VyIHNwYWNlIGNyeXB0by4gV2hhdCBpcyBiZWluZyBkb25lIHRvIGtlZXANCnRoZSBr
ZXJuZWwgY3J5cHRvIGxpYnJhcnkgbW9kZXJuPyBBbHRlcm5hdGVseSwgYXJlIHRoZXJlIHNvbHV0
aW9ucw0KdGhhdCB3b3VsZCBlbmFibGUgdGhlIGtlcm5lbCB0byBzYWZlbHkgaW52b2tlIHVzZXIg
c3BhY2UgbGlicmFyaWVzDQp3aXRob3V0IHJlcXVpcmluZyBhbiB1cGNhbGwvcmVtb3RlIHByb2Nl
ZHVyZSBjYWxsIG1lY2hhbmlzbT8NCg0KDQpOb3RlIHRoYXQgVExTdjEuMyBpcyBub3QgdGhlIG9u
bHkgY29uc3VtZXIgb2Ygc3VjaCBhIG1lY2hhbmlzbS4NClRoZXJlIGFyZSBvdGhlciB0cmFuc3Bv
cnQgbGF5ZXIgcHJvdG9jb2xzIHRoYXQgcmVxdWlyZSBhDQpzdWJzdGFudGlhbCBoYW5kc2hha2Ug
KGVnLCBtdXR1YWwgYXV0aGVudGljYXRpb24gYW5kL29yIGNpcGhlcg0KbmVnb3RpYXRpb24pLiBU
aGVyZSBoYXMgYmVlbiByZWNlbnQgd29yayBmb3IgZXhhbXBsZSBvbg0KbmVnb3RpYXRpbmcgd2l0
aCBjb21wdXRhdGlvbmFsIHN0b3JhZ2Ugd2hlcmUgc29tZSBhdHRlc3RhdGlvbg0Kb3Igb3RoZXIg
c2VjdXJpdHkgc3RlcHMgYXJlIHJlcXVpcmVkIGJlZm9yZSB0aGUgQ1MgZGV2aWNlIGNhbg0KYmUg
dHJ1c3RlZC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
