Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E973FD7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF0OMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjF0OMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:12:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7F30C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 07:11:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RD6a7f009394;
        Tue, 27 Jun 2023 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+aEY077wa9PhTnsPbG7OLtAqDZQKMTnXbm57iEjAb4E=;
 b=o3OjTebmTFLIElCHRs+LGf6Ez5drMftTnZxqucOldKZLJ2N4IqYY5ZfmOYsPjc98lNVm
 SbNyXc7KJv6BdFxvtKiW0KFhXdPll+jufe4/KoTooh0xMV133THtaUhZDlG76dBJHyCL
 0EWrwyi3Vbl517qD2cw+yBHXWZuD6mITRBZknCtYZDqaMx7SXxzvHiCK9rvqU8r0ORTV
 hGKO2a2exyiflRGKoEDkJpVr1jhuhxRDDOe5k+UKBycWIiEogUcp2aztWPMeqwY3RTc9
 WZV2ECbpGOmGgX1XmySs4FTT+e0qEJ8phROT4mKVUJZsF+egDRraykPYQTToSn/e/EAA Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30w6bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:11:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDWgJi038205;
        Tue, 27 Jun 2023 14:11:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxb2b17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4a4OSQpcHhgTzoatatZgSGmvcXol2MGAdwZkagMZtTCBjJ996DFa1Z3v0JOGZQQfHrD9Pfy1nXY62gNXOieiiD/pD/j78yQigaGJhRHkfjrS1n4OMOopdOchCRJG9+zcHfL1QUCO1JOnbLQJTiIa5eBTmy9u/8Rw/tz2hMvYA38IHfhTsOSGkNQw0S6Bzkw+n+PzpH2e3sHFw/VY7lXDxQKPGWoSmyxO4JSteRmvhcFnoj29xxkI6vznZ3/u1+wMiEMiE9Y0zWIhQ/grWkdgNkkM8zk1oOFa/07oHnSLVJyZSuHOMCEZ2XDRdYP3NVK/pPauvdyKnzuVf1ClbDnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aEY077wa9PhTnsPbG7OLtAqDZQKMTnXbm57iEjAb4E=;
 b=WG5fZ9Uq+rqay2kedlYHVtorncamOLY90wIIDCIrGi90DemqtcWZZhPRxkPw0bfymwQ89xps4pYIhjPGJIji20Vy0gL4gDLKbHIhv4ZdTb+dmFQLKdZC30PJ7hoRgQ5/sOtcnXkxYBAyQ8XGBwe3Zl95InFts+WP3EBn33lTjwx/1awTwq6cJKfsbRIqMuDPL7amFb3A5NBhZiuKub/ZDemrR9kI/9Pk7qI/T+Arh4xAWF70Ww2raoFosHV4nvsNKjC5G7QfcH06ilAtFyuKHGKOA031Z2WbNGYguLB+xWvLvsJjjlpLx/p24QIEfoqCuSX9ZnYQXJGFwXoA9FSQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aEY077wa9PhTnsPbG7OLtAqDZQKMTnXbm57iEjAb4E=;
 b=pRSKoKo6orv8duNyKjpZaC1EyamKbXPSjVC2cSeivHLT9kuXGmzbKF1WG9+nG1/m/6KBK7B9UrkruX0uJC0y9rGYeZJn+d1tHyXL2f+loz1rMTEnDwNLclLFxeP5sBjw5hsaLFZpoaJGOuJIuo8mrfSLampqFnicTKIpb8p061E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 14:11:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Tue, 27 Jun 2023
 14:11:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
CC:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] shmem: stable directory offsets
Thread-Topic: [PATCH v4 3/3] shmem: stable directory offsets
Thread-Index: AQHZqFsR1Vi0RTTWXUWGiJx9COfUia+esEuAgAABWwA=
Date:   Tue, 27 Jun 2023 14:11:02 +0000
Message-ID: <492B084E-B8D3-437A-A7C8-8EC75D6B97A1@oracle.com>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780370085.2142.4461798321197359310.stgit@manet.1015granger.net>
 <22e91db4-1003-d4b4-dd6c-f17d09488449@fastmail.fm>
In-Reply-To: <22e91db4-1003-d4b4-dd6c-f17d09488449@fastmail.fm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5678:EE_
x-ms-office365-filtering-correlation-id: 185e8498-a873-414c-3fef-08db77185713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLCAgK7cv46T/d3u1+LCa501XX05KTU0vAdb00Boj0JYKPmzRlx7QFmWmErFHStz6zvBIbcM0uJFY2cF1cpEU+9EbcWFKdrL1/CmRd8430wSM2djvLCS4Qoq0UoBolB45vPudzkho5E6Vh/wYS7RNODA4gh4C6HL/9I0Qde0YXb7Oj6it4fQihq1LDgekpoSDByMhs35IWMxeT1DYVT/IRA2ZPgiVMn6pR72op508sRnnXSHH+UwG/X3RMhP5+95mFjKu2v15UePWAvewKWqkie3JY61rkY9J6J46TDIfI3yyyoW61KQ5NboffSBMNQPvYSb74ooW7EZMu/7sYkEMf8vGHuFA7l/6ZMgUiyasCXqD/2Mn1A/Vf6iJjAu3fn2wykYR2gQc6yJhIlhfejnq3rEq6aU4geAfRPKCaBuHh6NWP9EV4XZWKzZTXPmg0N10OdEzg5PO3z7GZy7w2Be7zglIZZbui/eAEnn6rWtxcUpcW8BMzDkOJ09bvXqkdFU/icjsSIg7sPPHMLZ+Qkag43peZtSUQciPk2hp0SMPJaONyIA0nVcEcwImHURMtRHqY0gnzWAj/Rd5zoOsjd/V5v8bC1QATVRASYVJ1DQDFxn2tGnMEhVnqeaXOsyYsopCBAm3IrrVuR4pGtx6BBbHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(8676002)(8936002)(66946007)(76116006)(66446008)(66556008)(316002)(64756008)(66476007)(4326008)(6512007)(186003)(6506007)(6916009)(26005)(53546011)(6486002)(54906003)(2616005)(71200400001)(41300700001)(91956017)(2906002)(5660300002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001)(36756003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iwE4Nn/AgFjCda4m5ABzWT6dx9jU6YgCrGSskMizz2IWz6jOLoY2CLHl84Qk?=
 =?us-ascii?Q?MmfLK3u9M7aAbaepSvOdn9gHFcZVwvbmZO8Zs4xUQnMw1Gq8wNrnqm26Qk3e?=
 =?us-ascii?Q?KY2RSnTrinbgDfhfUXsHAp52gFkd6404/lmRfyJeVjvRrDgos2VA96etE+vb?=
 =?us-ascii?Q?saAbfXvewIDALOl7/rRy+LJF9trgVPzU14MEvBUV26MsyGAe/krMpaZ660+e?=
 =?us-ascii?Q?EIZR5LPrIWq9cuBevgs1N7U0olXncUHy/w8MCoaJRGJHsGNjYSTMNbtWrYIV?=
 =?us-ascii?Q?9BICeTWX5hS2SHyEfQAuu8vhxHytkHRiuMTla4nxklQXxWOdNGRelIrYGhHf?=
 =?us-ascii?Q?ditBnt+10fcySqMXeFoTG4aXqdbqYOn5EVqrJ9PV7VbUV726eV4w4b4SwxCd?=
 =?us-ascii?Q?udyvyGBor4ZSgt5QUP9Qt2ntSCac3ebEV2+R8s7UOL9/40W8RAxLT3q17lw+?=
 =?us-ascii?Q?nE1Ly9wqw2ToIYGON+2Xfhye4hWrgLpS/b4MaeRQl1WCIb0j8FJCOy6cfaHy?=
 =?us-ascii?Q?F8YrHH4zv+haPVPJ/MApq9BEqSli0COeRCAFkFNSmPZaSPBdJyzJoS9iM6LX?=
 =?us-ascii?Q?ze24ZI0T2sSZPEeRU/yc77MxRKoT2YZFUCD4zTR+RF1ieInelq9ow3SLRHI/?=
 =?us-ascii?Q?sjwUOy6/25cdblOZk58EZmQ5dj1lvAnLB4GD3FgqxN5wMjI2RI5TR5y2CHm9?=
 =?us-ascii?Q?xK3ZBYnMqFL882J1tGNZthUlQugEde4L58lh/4USNhTWrm5/y942YTwHLn9g?=
 =?us-ascii?Q?qmI7f8YPZolQjDSApP/KQhNIs9AuNXXMvxJOpkA3ecNIEexTaq1nZgi54jsE?=
 =?us-ascii?Q?Kqh3RDNgl/pL0hf6Vd0NjdHIbROh78zNHt0o0pKvVkTIFl8doo2O7Mtht/Re?=
 =?us-ascii?Q?9TPzmJ0lV8Z7lQbjlE+lvX9EwUAbAC+ZKtfRqwd39Q6ESQnuOSzjyQbZgntg?=
 =?us-ascii?Q?eMUjacpHMcfA1e9M77HODWW6zsZqEqwWFgDopyRPTA2f6WAj6pmiKIMWSoAH?=
 =?us-ascii?Q?vxV81jRdx+G/xdVrsurENm/YnBMHAxQzQLYjC0VDOFlgp1Ycd81TeXGjioZo?=
 =?us-ascii?Q?hyfogWHVrjVHIkOerYIkGSNJh4oBOK/ztKyPri83OiGywSv0WPksH8VfZqKU?=
 =?us-ascii?Q?IaK9xVrDHc6ZyB7hRE3MZoUTtgpakDctpVo/v+Te1/LGIIYLn/ugrASADmUx?=
 =?us-ascii?Q?7ufnJ3NhxnLDhU/xrXKvfpZ7v7oNgOkFAlbcQCw/xpJyqd3C5hJmUqZspizf?=
 =?us-ascii?Q?8b7JnzOo7QsrI0EzAJadHqLoSylsRJ6NWlh6uWSGCa6c3/5xcF87K7P/vGth?=
 =?us-ascii?Q?UEifpQAMReSDv4n+dwFVzfixWVCw+zexZ/LRGj6WxMohtB8Esgzbp40lvfdw?=
 =?us-ascii?Q?Par/ZbebCflvgc3GJZnMHYz7Elen5RRoDuUirNB90OldI6ucgXN1RbGkLp5a?=
 =?us-ascii?Q?NNWkTYl5wbe6royinxLaC+9Tr9rvLGtsUyY2Q6z5kKsONdY5a0VvD56Ivysf?=
 =?us-ascii?Q?/w0x1xa56eaAkjfY4i0yFCmJZtwtnuPP/C8C0p4dJQv8WFMlEWLNZvnYjCmN?=
 =?us-ascii?Q?A97orOHuFyu9iYFfzjZf4jnok2sf5uCYgIIytPM2qZjjlaQeQgUJY/eZIBo3?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <333219AE9A8D064CA71EBEC39F64D3B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GsguZKfm6nG2RHl8CbcC09FuzarEybey111BnG8ArQn3crRrq+OjrE4AzeTe?=
 =?us-ascii?Q?ksCimveQQFW4A15txz+UIQMwJQHn8qNPtdfCIIsJh4ekgQPbZx0G+PDSGn4v?=
 =?us-ascii?Q?klFd4B70NXhYaYnlTS22tf4kycQNk7S+eaX/lKQs6VhPGT8Yh6RQnPxjDIZR?=
 =?us-ascii?Q?R3y+9HsCL2fHgtPWTyGnVBhjvMEn8945yjIQYNQVHzWrZgGZr5EBTG8xzuSm?=
 =?us-ascii?Q?7AD7+Sm/s1ruZ2OAzlyCY5SML/DKtlKycivyFOzxRmaFheIgrVr08/0IIhrZ?=
 =?us-ascii?Q?xZ7mq+uvR3m3rOvQwP4YeCzW3NGWuN+DfyIHtECwOncfjt5az2zxi0+BrLHI?=
 =?us-ascii?Q?ETLvCXex92Yg8j7eJSnBb9RcBLVcyRTdwebR6zkOCtZj8oVCcJ74ON/RBLwt?=
 =?us-ascii?Q?CC0Ww4HkOOh9XkUWhhkr54QwlyvTW5/dx5Ad2Tqi6GBeSJGCjb14kDfvIl7t?=
 =?us-ascii?Q?ncmLCVbYsvtyZ/SvEsf7yRMlViqUtRVk1I4N9XZ1YnvELq8yMACgjQu/UnBR?=
 =?us-ascii?Q?fv+kzWm8pmbbwCzDCf2SFW3AgaZr6jtPbIXgoJ+Yryu403PEdQyifNBMmPtb?=
 =?us-ascii?Q?Z+8YroNPFODWbT6Lspj/wijWru3RlGgK6+qjCKT8wiD2fFIOLUtUIiCE6DTD?=
 =?us-ascii?Q?O+Pxs/iVZXeySWDX7+DY8IEykD/nAITWZiTRbpAeSxhNnZrcmvz4S/czBH5d?=
 =?us-ascii?Q?yfgwuR3Dp3054tFzZv7ERcoGC+ZBk4XRfidHMC3TvoqiZI/0HKspDLzX+wXZ?=
 =?us-ascii?Q?nfnKScySJNu3+eYywk0DzNAzm6F0R8FBkGgW935iQinPRSG2CipRrjtTcc2I?=
 =?us-ascii?Q?0GTJqRKfeD0/2u4eKzPau+1mncSJ55jWXDaa7dRDQe4jkCwbCESnXUG/vA0U?=
 =?us-ascii?Q?UR5aOLwDj3wrxinpATLJfudad06KyFty9L/oQL3+VN+aJK8PQqqX9aboBVUA?=
 =?us-ascii?Q?eN4N7q3/SFV2yrNKm16Ab7HyaF6e7BgNdH+TGdGlLBdxAEjwIwOz1F39yrOY?=
 =?us-ascii?Q?glRG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185e8498-a873-414c-3fef-08db77185713
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 14:11:02.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYgXjgYG7I1C+v8hAy6ECShJZPhaPulnGwmpCK4WePOIiUgWr1HgI0RokmYF7G7P/cVPlVVIVjUIqB8Jvgawtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270131
X-Proofpoint-ORIG-GUID: I52PMztzkkp8LNT-m5n5QjB0badCgBNW
X-Proofpoint-GUID: I52PMztzkkp8LNT-m5n5QjB0badCgBNW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 27, 2023, at 10:06 AM, Bernd Schubert <bernd.schubert@fastmail.fm>=
 wrote:
>=20
>=20
>=20
> On 6/26/23 20:21, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> The current cursor-based directory offset mechanism doesn't work
>> when a tmpfs filesystem is exported via NFS. This is because NFS
>> clients do not open directories. Each server-side READDIR operation
>> has to open the directory, read it, then close it. The cursor state
>> for that directory, being associated strictly with the opened
>> struct file, is thus discarded after each NFS READDIR operation.
>> Directory offsets are cached not only by NFS clients, but also by
>> user space libraries on those clients. Essentially there is no way
>> to invalidate those caches when directory offsets have changed on
>> an NFS server after the offset-to-dentry mapping changes. Thus the
>> whole application stack depends on unchanging directory offsets.
>> The solution we've come up with is to make the directory offset for
>> each file in a tmpfs filesystem stable for the life of the directory
>> entry it represents.
>> shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
>> directory offset (an loff_t integer) to the memory address of a
>> struct dentry.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  mm/shmem.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++------=
-
>>  1 file changed, 47 insertions(+), 7 deletions(-)
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 721f9fd064aa..89012f3583b1 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2410,7 +2410,8 @@ static struct inode *shmem_get_inode(struct mnt_id=
map *idmap, struct super_block
>>   /* Some things misbehave if size =3D=3D 0 on a directory */
>>   inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
>>   inode->i_op =3D &shmem_dir_inode_operations;
>> - inode->i_fop =3D &simple_dir_operations;
>> + inode->i_fop =3D &stable_dir_operations;
>> + stable_offset_init(inode);
>>   break;
>>   case S_IFLNK:
>>   /*
>> @@ -2950,7 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode=
 *dir,
>>   if (error && error !=3D -EOPNOTSUPP)
>>   goto out_iput;
>>  - error =3D 0;
>> + error =3D stable_offset_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>>   inode_inc_iversion(dir);
>> @@ -3027,6 +3031,13 @@ static int shmem_link(struct dentry *old_dentry, =
struct inode *dir, struct dentr
>>   goto out;
>>   }
>>  + ret =3D stable_offset_add(dir, dentry);
>> + if (ret) {
>> + if (inode->i_nlink)
>> + shmem_free_inode(inode->i_sb);
>> + goto out;
>> + }
>> +
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inod=
e);
>>   inode_inc_iversion(dir);
>> @@ -3045,6 +3056,8 @@ static int shmem_unlink(struct inode *dir, struct =
dentry *dentry)
>>   if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>>   shmem_free_inode(inode->i_sb);
>>  + stable_offset_remove(dir, dentry);
>> +
>>   dir->i_size -=3D BOGO_DIRENT_SIZE;
>>   inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inod=
e);
>>   inode_inc_iversion(dir);
>> @@ -3103,24 +3116,41 @@ static int shmem_rename2(struct mnt_idmap *idmap=
,
>>  {
>>   struct inode *inode =3D d_inode(old_dentry);
>>   int they_are_dirs =3D S_ISDIR(inode->i_mode);
>> + int error;
>>     if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>>   return -EINVAL;
>>  - if (flags & RENAME_EXCHANGE)
>> + if (flags & RENAME_EXCHANGE) {
>> + error =3D stable_offset_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>=20
> Won't this fail in stable_offset_add() with -EBUSY, because dentry->d_off=
set is set?
>=20
>> + error =3D stable_offset_add(old_dir, new_dentry);
>> + if (error) {
>> + stable_offset_remove(new_dir, old_dentry);
>> + return error;
>> + }
>> + stable_offset_remove(old_dir, old_dentry);
>> + stable_offset_remove(new_dir, new_dentry);
>=20
> Assuming stable_offset_add() would have succeeded (somehow), old_dentry a=
nd new_dentry would have gotten reset their dentry->d_offset?

Probably. I can have another look.


>> +
>> + /* Always returns zero */
>>   return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry=
);
>> + }
>=20
> Hmm, let's assume simple_rename_exchange() fails, stable entries are now =
the other way around?

Today it never fails. We can add an assertion here.

Otherwise cleaning up after a simple_rename_exchange() failure is going to =
be even more hairy.


> I actually start to wonder if we need to introduce error injection for RE=
NAME_EXCHANGE, I think it the most complex part in the series.

And it's the least frequently used mode of rename.


>>     if (!simple_empty(new_dentry))
>>   return -ENOTEMPTY;
>>     if (flags & RENAME_WHITEOUT) {
>> - int error;
>> -
>>   error =3D shmem_whiteout(idmap, old_dir, old_dentry);
>>   if (error)
>>   return error;
>>   }
>>  + stable_offset_remove(old_dir, old_dentry);
>> + error =3D stable_offset_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>> +
>>   if (d_really_is_positive(new_dentry)) {
>>   (void) shmem_unlink(new_dir, new_dentry);
>>   if (they_are_dirs) {
>> @@ -3164,19 +3194,23 @@ static int shmem_symlink(struct mnt_idmap *idmap=
, struct inode *dir,
>>   if (error && error !=3D -EOPNOTSUPP)
>>   goto out_iput;
>>  + error =3D stable_offset_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>>   inode->i_size =3D len-1;
>>   if (len <=3D SHORT_SYMLINK_LEN) {
>>   inode->i_link =3D kmemdup(symname, len, GFP_KERNEL);
>>   if (!inode->i_link) {
>>   error =3D -ENOMEM;
>> - goto out_iput;
>> + goto out_remove_offset;
>>   }
>>   inode->i_op =3D &shmem_short_symlink_operations;
>>   } else {
>>   inode_nohighmem(inode);
>>   error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
>>   if (error)
>> - goto out_iput;
>> + goto out_remove_offset;
>>   inode->i_mapping->a_ops =3D &shmem_aops;
>>   inode->i_op =3D &shmem_symlink_inode_operations;
>>   memcpy(folio_address(folio), symname, len);
>> @@ -3185,12 +3219,16 @@ static int shmem_symlink(struct mnt_idmap *idmap=
, struct inode *dir,
>>   folio_unlock(folio);
>>   folio_put(folio);
>>   }
>> +
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>>   inode_inc_iversion(dir);
>>   d_instantiate(dentry, inode);
>>   dget(dentry);
>>   return 0;
>> +
>> +out_remove_offset:
>> + stable_offset_remove(dir, dentry);
>>  out_iput:
>>   iput(inode);
>>   return error;
>> @@ -3920,6 +3958,8 @@ static void shmem_destroy_inode(struct inode *inod=
e)
>>  {
>>   if (S_ISREG(inode->i_mode))
>>   mpol_free_shared_policy(&SHMEM_I(inode)->policy);
>> + if (S_ISDIR(inode->i_mode))
>> + stable_offset_destroy(inode);
>>  }
>>    static void shmem_init_inode(void *foo)


--
Chuck Lever


