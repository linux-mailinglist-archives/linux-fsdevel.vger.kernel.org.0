Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C462C25A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiKPPV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiKPPVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:21:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49E4FF89;
        Wed, 16 Nov 2022 07:21:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGF0P3Y029096;
        Wed, 16 Nov 2022 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dLqqRrYbPHqRAzMghjpTCeMY5SBlQ+19p8DXCJD7weM=;
 b=V2+I6TEuB7GmfK8Cgt42r0+LA7a+1KtsckwAp689B+wVXmv4SxtR6DDUfjGxSzjn9iRS
 8mFUA1VIttOIB8T96He90Y7Pq3BB4KWV0vT03ecn8E+pNziBsXhJDQ/t20Z++sPz4LS/
 MDq1X3bqWek3jSdscjQjH4PD5i3i5ln9ceQdiVsdJgIoyI2IIkqD+DoKVm1TFQN6AfNn
 c9RcxE2Ra8xwtHq532FoSX4JGd6i89F7T+Wf9o+UU2ak6VbJey1yJAPafS+TWEXiHSLf
 PKi9AHb1w7fUDJyj3nV2Chw0SF+MUx4PRMsJBYHGES3ysFaAkG6/uKvoNV/TecJuVyGX WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdw01y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:21:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGE1gvd016791;
        Wed, 16 Nov 2022 15:21:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1xcx0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 15:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYMMWRma0LePoI6iGbDhygF8KGjg7KlGaa2Zgp61sf+PZ6wQOiTfISafHEFGRjYdmK0uT8vrarkTDcrb67VC4/3bBVDCUouObi1JSNBXAgQ6AiMpecfMjuxYvTiSibudfOBXwZYCUWChkFwGdkuDKUDFBdb8Gue2haTYlS3oC01ML3/CVlyFoD5PlYBQNVa6LP8X9fMqWGPaJJR8nNhn+Cu4T0eMyTb/dK3/ZQzriIu9sYHi1aGLGs+z8XZq7XkwG4ih2fJlllId3YWHZATiLh9nezjAxtJu1+v4KoINLRm4jyjz+STbpLSVvhTdpuDDe2/dz1m76g7FG+/3U3738Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLqqRrYbPHqRAzMghjpTCeMY5SBlQ+19p8DXCJD7weM=;
 b=c+yptL/+TPhA2DsrkR/tmWMwhTy2F8JRQZJd5WBpNNcUjstSA4wB7vOoc/9aTkgsevfAW9HFjhznR+I7PBhSygE6h3oMgqvGpLDI7q7JHmK6gfLrA2MzCUfGgGKFxFmIG3D4JdzU59Ax5LkvA5SgXd6RfxOAn88lZJ28uCk4QSpPMUIqNLbFMjYFPD6VeOsFiZG2NPpGvkX/Nkw0dGKmsWd5Bkpyir79JAELCVfI3dO7JsXoYUSDrHRa85KuzgrXXpjK3ZOJ+DqGf/jyO+VT5bhjATxx+Ap7S4vSAf7kaYSi8womLb5F9S8G0km9+gb3ZNlVODGVrQSeqFNTvkPxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLqqRrYbPHqRAzMghjpTCeMY5SBlQ+19p8DXCJD7weM=;
 b=zi4hERWGtsWATzRaYusSqUks+Bllml6bpXyOgjBBEQN3UdRr+HQebP9/nwZQJGkPnqGCxxaMFE3s9k7e9LR2UiyAAsNlq5l3CzK8JyH4mERQQyh02hpy1qehb7L4tMfwJlpp3hH8Ebcvz5yqyr7NgciB9dem/ifG7pMoDAFsnXo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 15:21:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 15:21:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 7/7] nfsd: use locks_inode_context helper
Thread-Topic: [PATCH 7/7] nfsd: use locks_inode_context helper
Thread-Index: AQHY+c6Vlu0TAlt2Q06byNQrxnDNh65BqngA
Date:   Wed, 16 Nov 2022 15:21:05 +0000
Message-ID: <406B1FC6-23B1-429D-B9BD-33EF0DD7C908@oracle.com>
References: <20221116151726.129217-1-jlayton@kernel.org>
 <20221116151726.129217-8-jlayton@kernel.org>
In-Reply-To: <20221116151726.129217-8-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5149:EE_
x-ms-office365-filtering-correlation-id: 9e96f862-2823-427d-6e46-08dac7e62e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4fScdZP/b42fFTE02JAs7V3R98+WV7lBq3xtANQBA9dORQc6EwP9FN8HLNZ0wzwApsCo8IO+uqzPD8DS16ztiCCX0Hbwlr7jTte9gJy1jYM/qiZ3Sk9ced9WgGykJ11dfY3qA610WujJzXgVJfx8reCdW4NxjAzeCKqFJ0Hfe9mKQxRpSQSxRrIg5c3azorPPLm3l5OPkp95Tz1rg/R0FxPe9FPLOoQ8p/Yy2MQU0ePNhuVgUJgKcL1lvBMNxFCkHsZNTexhl5ejgTpoI370DnamfbqMeUv16nfgc6q7BlA5ZY5THlB+sEJbjDg94CidnOiR1EZbDuX0xjbRiWGQvE4H2VDykMKxweWQn9M0SjCNjiEWJKWoFG+VnoYzaBVj9LCJ0pZxMV0YjykPNSDxPJlhjzRxxIbIfty5c+quQX6IlUgzN5UNwxVWXWNc1OpTNyRGilqkT1mTC9OvhiVZcYLUC1rWz2OdzxCy4aFxbuXp+YYJgq0stZTI8aSa0a9a6JpmGVx5zeOJHvZPPDcwei2564prXVzo8YrZy5Q7g5JorzlDuohPIXn4MF625l5F8uFMfwgVd9USNmshfr2kMqV8o+m7UcCHcwDDaRaG8Uoij6hMsAYttPphO8Gs4J6KaaLCRrLRBrDdG7FPErySK4oRmr6rfnmf4FjZUVwDRpd2AHZHNFv1vHeBKQQVDPJqII4eoU7xoJYDiB0+D3uFcFLXp28ev6drlF1GMpa/saKcr1Ocn0tF0o0DZzxFaWlaiU3AM+YRk1t95J9dl3C5amtbbSpHa/CIeCOq8GkO1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(4326008)(86362001)(76116006)(83380400001)(91956017)(8676002)(66556008)(66946007)(66476007)(66446008)(64756008)(5660300002)(36756003)(8936002)(41300700001)(33656002)(38100700002)(6512007)(26005)(186003)(6486002)(122000001)(478600001)(6506007)(53546011)(2616005)(54906003)(316002)(38070700005)(71200400001)(6916009)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSW66YeoNz5ppLHdOWZlKFlHiSHrDqFseXLApXYZUxKwX9Xqs4/p27jDy0+7?=
 =?us-ascii?Q?K3vZJAHuUlDrsy9S/GgIU+llRkBZNZgD+8uB70uo0SBzA72Z9DaG/5VuP91g?=
 =?us-ascii?Q?WLPD8aWJOyyWzNAs1XahfJ8iOSW3FsRBkSoXOE8fdyIhV52Tn5I/QgrEgp6d?=
 =?us-ascii?Q?lBYLpKQ2He7EysLpL5FaspsH6J3lrDLrexK7dxmZy4cD9qQraoHPVN0BLp/G?=
 =?us-ascii?Q?rZrWMeo+GbuDKfCoaW9gm1FUyQW2qtiaCPYIrrDJCpVxEYKJqveSAGsTk/k1?=
 =?us-ascii?Q?297QIkN2AJ79S0FBfhdMJ3Rvz9VWzrPiX0xfRaN2F/t0O0uLDrwLgSKagMmq?=
 =?us-ascii?Q?c4U0bwq3kZiR/64F9yWYKIkb4rsajTcsvXg2JrBcdXedkS3ulRCX/VFkD/fQ?=
 =?us-ascii?Q?r7JF+Gt1n7W4+FOH4GGW/Z/MMVyY3VP5yiceaFleYCIGU2aVIo/03UvYzb5v?=
 =?us-ascii?Q?G2wLpTAb4P0u2ta8Y0icBIzJWEPLRIw182eL7nfDVJRF40EZbvRqGwd9YoN3?=
 =?us-ascii?Q?m7Wc1OCBPqN3GbRb3zYvEa1AFa/2RD0R7VvlRrzicfl22iaSdve0fbonwGU7?=
 =?us-ascii?Q?/Vzz1/b9/YtUD8uDQQ8Y13l0PNLNe9AQ3eKW8x/P2RBvE40LrQtYzGfe3bCa?=
 =?us-ascii?Q?lynucUVxYzfxMPHC5prtEghXp6B63l0r2hZoyctTAKgJBnYhvu101iCzabeV?=
 =?us-ascii?Q?lvY9xslNUKBrV3tuCpAF2i0Iyw82xc/TQ70+cKmqyi6qtOaoBCYqpjtpQb4r?=
 =?us-ascii?Q?jF8Geigxt0sbWuhBvplo/MbQSs+loO6BnSmqTdhS6GLPp7rHpZRKEg3ToZbD?=
 =?us-ascii?Q?HIR5quYx1IqS7AGf5koANRVMD0lcznKSPapXJEQveUdpcumfYKLcCxC13V4b?=
 =?us-ascii?Q?f7fgOp0aczyRsDUUHtUnnoZD6WH0g+/gipShBF3YrhQoky3ZVCN1bTJh74+z?=
 =?us-ascii?Q?0WN/UwEUPAM4FEU+ISOx0ym+UoI6uzrRg3XuvdpzajiUscsbcHTvLM93/oq1?=
 =?us-ascii?Q?NzomNJEawdjkAg8GOJlXt+11knUIlOY5+mvX7El2WV4I0rONa0ziHW/5VYLj?=
 =?us-ascii?Q?T4xkQpww1T/woREc5FhJJ3ZQ/fY9jHVJiGK7Bq6e00xCHsU0drPCr3zmfC90?=
 =?us-ascii?Q?2Hhj1Z1VundCTGUvUjsK3G37nqulzrqfgvksAT4ILqPb92FHrYcXAgSsRqjN?=
 =?us-ascii?Q?IVh4lSOx9OGjF1ScWaNXkdvBPBFd1TPhLE91M/3EYxeBDTN7Mlx9oZK8eqLE?=
 =?us-ascii?Q?ifBPBUvs1tmV274QN3ObsAyHFXIOrtWsx/EEy43NhVMushE0jFPaW3PIAsIn?=
 =?us-ascii?Q?KXPpnashiIoR6dgz/FsF/gV9ZrwOMrS/drKy+GT55rVVV68Aln9YaeAfOfgr?=
 =?us-ascii?Q?EfpXfrtit1ot/ptcYu6aRVpOguU5ABxzenjbMddFlwyAeJO39TzwG2KFM8jz?=
 =?us-ascii?Q?T3yaBmqXMMwT3To1txkCW+ycyucqglALYyQxsDmxZUb3K0cDHDYrs14DNj7u?=
 =?us-ascii?Q?5MmvB49anjaolK9XMeEVPqqneOLDJSdLqto+XGtVNk03mDVoSZyjoavBkKJJ?=
 =?us-ascii?Q?e/kR41fYgleGjJYqDYtNLSpKdOxFvbjFE6p9FSVFwgFT4JP5PlA7z9wKU6hB?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10FBDF29027D6243A1B4E6AEC7D4919E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s4gI8icd4p8ZUT968kLBI/n33UCsvVoHYh2fgTC0oNfO8pUAUJSp3bEw/IU+?=
 =?us-ascii?Q?MX2r0v+xMvrBcX0Hi0FzVjM8D3Iyb02vKMPMCL83cSBj5m2bR4Xjssa6ViOP?=
 =?us-ascii?Q?50BKWtKhCsmSh+TDFvct6+t2SApvfc6vLF4b2RaTppDMmBfCCPACwKoeCh/L?=
 =?us-ascii?Q?l3+oUFZMRaiyJBwu8mEcbFkvK0tcU5ytkL84N3FIfs3vlmFZM+7Ot9WX/uBt?=
 =?us-ascii?Q?6Buj/Iub+6MS00NvRyQF0IaHOaCQ+X4zlau/E+hGn8eO3gEYJ7WxUaUZ6PYM?=
 =?us-ascii?Q?sNviDg7jE2hZwUezhGYEwd/qX//FQNPW9igwcj3kZ+1H8U3RW+vlQBF5hkAf?=
 =?us-ascii?Q?RUpS3xQ3DEK7kj6wIffLlruGqQbKIXLWMA49HZ8MjP8GKI0ALDkPQCkeBb9G?=
 =?us-ascii?Q?EtZjBTV0DBFzpKV+JL0WxsEIwCubuXCv8VGrtQbSi3bwpYi/Ad24U9KI4CeA?=
 =?us-ascii?Q?CunjoHIB29Lin/D30CAgd8z28k+MMJbBy+YL7WhOvj5TPUd+NuX+jYfqRBB5?=
 =?us-ascii?Q?v3ErBve2/9vk5THkZz0p549qazWPD+FdCvQQoPF7MKn233HlUWGf7ml22QcC?=
 =?us-ascii?Q?/ZlWhf50QtmA04R7nCqxPtbVivc+uuOZ2a+VYQ2L6tpPArQSZDSm7S9JvRTO?=
 =?us-ascii?Q?N2fOEq/I/pNN6MIOm29WDYxFe726Mb1QTahwPGifBdRUSFVROkrpt+dFLK0M?=
 =?us-ascii?Q?CfCR0bhvsSxrJLPMEivmtkUbFUL95E45jgQRwQ7V5YHRjZVuxKbmHZWv3FPr?=
 =?us-ascii?Q?ECEnik1AYWR015368r3KS6IpisHIjwP6Kkv0MTk1qlMuYKgahTo7eNWmhqra?=
 =?us-ascii?Q?OypfJr5WMXhYoO+7NpPhiIR1AdhkVL/IUO3L0z8peNQ2wF15xrwH9QsTfxbV?=
 =?us-ascii?Q?BwUBGvz0yaYSDOLnnlAI42xVp5TMj9XUlGBiJVkb6bexSx7AAy74zBaLYYy8?=
 =?us-ascii?Q?wmiAOjEo/Ug1nFSs8CB3DNcq+eKy6loJsocDhDNLYtQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e96f862-2823-427d-6e46-08dac7e62e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 15:21:05.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1KqYpiNmKoSck/9Sr0N1lPHHdoT87Fm+Xd3m+V2FZY3maYZJZ6qMO6HkRc+RpURVcpZqopkej1E3IgT1GGH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160106
X-Proofpoint-ORIG-GUID: -QiN6h4KPw1rgYIOlAi60onhMvpTUGEt
X-Proofpoint-GUID: -QiN6h4KPw1rgYIOlAi60onhMvpTUGEt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 16, 2022, at 10:17 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd currently doesn't access i_flctx safely everywhere. This requires a
> smp_load_acquire, as the pointer is set via cmpxchg (a release
> operation).
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfs4state.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 836bd825ca4a..da8d0ea66229 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4758,7 +4758,7 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsi=
gned int deny_type)
>=20
> static bool nfsd4_deleg_present(const struct inode *inode)
> {
> -	struct file_lock_context *ctx =3D smp_load_acquire(&inode->i_flctx);
> +	struct file_lock_context *ctx =3D locks_inode_context(inode);
>=20
> 	return ctx && !list_empty_careful(&ctx->flc_lease);
> }
> @@ -5897,7 +5897,7 @@ nfs4_lockowner_has_blockers(struct nfs4_lockowner *=
lo)
>=20
> 	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> 		nf =3D stp->st_stid.sc_file;
> -		ctx =3D nf->fi_inode->i_flctx;
> +		ctx =3D locks_inode_context(nf->fi_inode);
> 		if (!ctx)
> 			continue;
> 		if (locks_owner_has_blockers(ctx, lo))
> @@ -7713,7 +7713,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_l=
ockowner *lowner)
> 	}
>=20
> 	inode =3D locks_inode(nf->nf_file);
> -	flctx =3D inode->i_flctx;
> +	flctx =3D locks_inode_context(inode);
>=20
> 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
> 		spin_lock(&flctx->flc_lock);
> --=20
> 2.38.1
>=20

--
Chuck Lever



