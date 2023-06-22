Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643B73AD20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFVXW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 19:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjFVXW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:22:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202413E;
        Thu, 22 Jun 2023 16:22:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MIIqa0005813;
        Thu, 22 Jun 2023 23:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aFIuUdwTOdI+ESUS/bY8/dlkUf92ayx8tiZStrjaJVQ=;
 b=DEcHky/RMsJAQKtXPbNiKM6ZnsOcFXiEVAdSQYeaj51pQ0nV/ppNeiFNuXMI8kWlfliU
 V7hLofzb7wzz50y+CwmERDw4sVtl8hkpPzl22YqavCK4RFXxab4JCnOSAL0d7yAVD3GT
 kHOPs+uWQmwsUOWrUOF3ktdJD31SB9Urf8JDT0hO2FU/xQGQN97GVzptFxdoacPqU5gH
 oWXwZaVqB9W6u7GmH75/4CcSFh7+FmdhCOr16hUnr8/qKCmCTyd7+qAwYWvBmAGFrJO7
 nR5krPl0Td3T8g2RFQF65Nh4nn+B89mXautTGyNIs1enUmDnJBnYPcGH5zJMuWsFzRQa yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcu40t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 23:22:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MMdtLO029627;
        Thu, 22 Jun 2023 23:22:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939e926h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 23:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAGX3TnA1dI+cs6wc9urYKJHTqsBrkuNGfo82PvTqe1ZY2zNpc3n/XBbh3cUmdRqsRLU9WsgYx3UJqcEJlQtAGUVwyr9FKNsPUjnil9FWddQ5RqdEHUf++nlzOIVQIcuZVHGGcU/d5RJHp/sT6TbFB4W9RnFy/Yf/e+lgGlkJG6KnviQXaHrCw/6Otb5Qm1zSo4zgjbHtE1Q4rRfsHDmXy7cEH0g1Co8ixMnLuqG/0v9mNfxnVVxV+IQRQOVwi/KZfKeyWXZWku9j2Vz9AXXBgLjVui3ACbBWGISTK6H6AoJcTgLJvN6er60cVHOzsF47sr+UU9TbTZ6ex7Dt60fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFIuUdwTOdI+ESUS/bY8/dlkUf92ayx8tiZStrjaJVQ=;
 b=GbSdznTusBuDbnPuvUwHzDY2YEh79kUYkScNxSRkisZnUekAUlqMEJVwn/DT3ZrJeRcmaLrlcJKkjn93WK99PdJXglXBc6ai4hkUtlr8/ElfBshUnaniUlijqg1DxzfgiXy1UoWRhix5oxDo0DcXV2w6qW/Ui7umE6jzU6hHczQaq41EHco3n3kkCKskcu/0H8Jb1BKlHQ/7nz5o6GiHcGPRPqatkLDKZJftmGWg0UfH2Ev1c806Jboki+yC/Vnt+xGZeHzj7/NgeHbs5xCKTaCvlLXoqJbZBG+8iYAFsmhfDbzavrRTSxY+3I5P8ivMLw6kZ1w2EhkbYWAfnMB52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFIuUdwTOdI+ESUS/bY8/dlkUf92ayx8tiZStrjaJVQ=;
 b=DKYIIWIrASo9votsXWrYztujXrIs1NQZq8n9kiVy6O6xFBVBTlT52ElCfBeJkAm8mQGNnLkupRJ82N/ZSNEK0qr9sO53uRTQgSkhYiGKypvjCkthZvUlo5ErGnDW1vNX2XrpQuiy7OnQaJCxPiUl0D9bfGo4KOtgaKKrKQxSyHE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 23:22:12 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::c47d:6b46:cca6:7183]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::c47d:6b46:cca6:7183%4]) with mapi id 15.20.6521.026; Thu, 22 Jun 2023
 23:22:12 +0000
From:   Allison Henderson <allison.henderson@oracle.com>
To:     "bongiojp@gmail.com" <bongiojp@gmail.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Thread-Topic: [PATCH 0/1] iomap regression for aio dio 4k writes
Thread-Index: AQHZpGemLQxFaGEY8UKjr2rFQnKyHa+Xd+6A
Date:   Thu, 22 Jun 2023 23:22:12 +0000
Message-ID: <c5f32ae1c760f3296c2d2dcff0399f331e94d775.camel@oracle.com>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
In-Reply-To: <20230621174114.1320834-1-bongiojp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|PH0PR10MB4744:EE_
x-ms-office365-filtering-correlation-id: e3047c9f-5f49-41b7-a7cf-08db737781fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybgzYye3L9mAYDEDSsbejKRX53WCzji76IFGIjPgq0StXu8aXQ3J5pzSPNSaoqgLDWADwFYZHRWvT24Osc679Z5kb6KiHtp1BrX9tcWtEyLcIypRJKrgfs0dml/CDjzNkxR5eDQJCSFv07lLpx7q1sS+k4GV48cf64696/LzOpT3dxbq6Gm+Pi9sI353ZLjfR7KTuUke1mIHdFb+5Nsmv/uIUrPf91VmjDGCLPDCWLILJvLp3eYPNJAzowaAZnQjKMQ11D4Oifjt6+tND1tzOTifx2esBrx+K8YMpQnB2oLt1gaay4m4lMM3jdGf0XKBU4OUIlDlc9I6k5LjHn9mkbX5TmEPE/9wRXrACKxJ1b6E3lfAYf0H7VSEZDUL3iKELz10KfZ5fR0KkSux9ASe9GpfAAZHkGtddV5HhCvgLg1JjiTAXnAY3ooADb6uKxasqWSKP3Z6tFBs+pOFBT7m9qsQq42fwHzKZA9nLUNm6twXMvuGEBrODvrcNJon4+hc1mPv0M+DbpaDe6kp1x43dCCgcQ/z1h3jEGV8qBJcTibhPcZfBPvhLR9KbBqRdXQGnVLa5OeBRQNhlEJ83EdpxBBYDCHnSGaMfCntGuYwjII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(76116006)(66446008)(478600001)(66946007)(54906003)(66476007)(64756008)(71200400001)(38070700005)(36756003)(66556008)(316002)(86362001)(6512007)(110136005)(186003)(6486002)(6506007)(966005)(38100700002)(2616005)(83380400001)(26005)(8936002)(5660300002)(8676002)(41300700001)(2906002)(4326008)(122000001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG9GYmwxWDlLcTZMSitHU05NKzJYTnhGam9Pa0xRd2Fod005SHBneURXLzYz?=
 =?utf-8?B?T0lBMnBza1l5eUZRVzhONDhnRVRUTjF0WCtYaGRhNDF6VzZNcmwrUVNvSFN2?=
 =?utf-8?B?bXNISzl4TkZScHdhZDF3VnU0WXFSVGNnc2VpM0o5VVllbEdQS2VtVWszWUJp?=
 =?utf-8?B?dXg0K1QrcE5HYWJUZHNwSzF6eldlbTh6YXVSTHNxd0FoWTIwSkZ4b25aWkdH?=
 =?utf-8?B?eDJjSE1LMlg3NEFUbm52V1J4ZmJOL1BzR3V0QlFMSWJQUWRsVmRObUdta2V2?=
 =?utf-8?B?Z0pGblBRT01DaVRaNFVHaUNKLytrbStFZ0RRUWVvUEIwL3RJTFlyY2JQNlZI?=
 =?utf-8?B?TWVKbHFyMkUySHRpZmwxSUQxNS9JY0ZtTDVCV0hGdDVyemZRd1dueEJDTXR1?=
 =?utf-8?B?M1BEcHpkS3ZEU1hHOXIzdjNTV3c4UktXTVlRUWFaMTBVY3BKL3pJbG1OVnh3?=
 =?utf-8?B?YXJOTjU1dVpkcmFhdzlCSEYyWUlaM2I5NW83dUVxdUg2RWFHbm5vSVltM29r?=
 =?utf-8?B?SG1OMjluaHNjSW11K3pIMXN1ODJCQUpFNG1QS29qSmIvLzN6cFovZ050NjJR?=
 =?utf-8?B?MXNVR1dYbWQ2QmY4dW55Y3ZFQzZNcEFCSWlKcDFDQ29pU1JLblFCMGZiRnBj?=
 =?utf-8?B?WTBMQStiU1JIYkhXajRodzFFaGdrWklLcVNxYjVvM0lIN1VndmRjZS9vV09D?=
 =?utf-8?B?MzUyT3pXN2RxalRUTTY5K0krUno0d05hUEhzWFRmVXlYY1E2OFR3SkR1dXZx?=
 =?utf-8?B?bWpUUnptK2RORUlpM0tLQXF1cWNSbzFTZFBIcGVHN2s5cklEK0ZiTTNVSFpW?=
 =?utf-8?B?Vi8za21OR3ZSaEdqZlpkQ2QybTlLa1JEaDZsWXBvUkZtWWVyclEzQVowS2g0?=
 =?utf-8?B?N3ZQMmhKQUE4SmxodDc4WWlPTlhlWlh5Z3Y4YUpqdEhPNzZqd1NOb0d3WWQ5?=
 =?utf-8?B?Rmx2TWZiK3ZMb3VYNkR1SG9UcGJJaFErM2kzMS9XVXNLVW1rT1pPSDV2dGk4?=
 =?utf-8?B?emZWblc0Wjk1WFhJUkNBb2NpdnlyZjNHTjJhdlp1TXYrbGQ4UkRiSDlhZ2J1?=
 =?utf-8?B?UkdGNm5BanBuaHVSTXNZUFQ0bk9uclJLN0ZMM2pIMjAxc3NBNy9PTjZjNWUx?=
 =?utf-8?B?MUJiSGRZNjFGendsdzJ4RWJzeXdMbkdsR0VrN1M0U0E4QUN4dm5lNThJVVVO?=
 =?utf-8?B?VzVpTUNZTTdUdVNNd3d2VHBYcXFiZ2k4YllFc1I3dkVPU1FzZEpHY1dRNnRH?=
 =?utf-8?B?bXh5RTYzd0lHZ3dUVzZRZy9iK2VDeVJ6aFprWlcvMXFsbmFJV21MblBHMTRz?=
 =?utf-8?B?cm1icWgrQzV4MXJSVzFQQk1JU05iMEFIbFdXaGgySXRYc2x3NGl2NkVMTFVY?=
 =?utf-8?B?VUg2RFh2TFdmVGV4cmRGbGovZkJScEIzM1c0MDVUdEJ6UzlkTmxNVzFiaUM5?=
 =?utf-8?B?UlJmejk0MUcrckk0SmNUVSszenRjV1AzRk9vWHpkZjQveWg5WlVmeVhON3VJ?=
 =?utf-8?B?Q2E0VitreDdjQWc1N1FUM0pNeWtIaEh0TXl4WHUyMnMwR3IxZVEwM2NmbzBs?=
 =?utf-8?B?M3J1T1dMSUtscm40Q3BtZkpBajY0RXZMU0NqOUR4b0I3UU9XSFBlekpSZ2cy?=
 =?utf-8?B?U2U4aU9xUXdoNWsySGk5K1ZrR0JjaUxNM1krSlVpOWthSDNlN1lsTm9QVURN?=
 =?utf-8?B?dW03ZXhFZFFPVzRTTTV2elk5c09qMG9FMU9sN05UVFZoZ0lkWVU0V0VFdnN2?=
 =?utf-8?B?Y2taVDU1c2pqWnZQNG12UDdjUGhLUWlwZUo0OG5JUHJDQlpURGhuR01zb2xP?=
 =?utf-8?B?d0FDb1M5bWRVRXQxdlQvTmhBZWVhUzlCZGs5a0FxbDFXOU94NndFbUZMVDJ0?=
 =?utf-8?B?WFBtdHdMZ2NXaDNHc2ZxM3h5MW1ucjFsMmk5WWE1b1puTFNGZUVLTFRRQkdW?=
 =?utf-8?B?UTg4aDVLYWdaVG8xcDY0MWF2L013NnB4eHNEWkcxZ0ZFVEJNNFVtOUdldFNa?=
 =?utf-8?B?ZFRmcTRWTURRbE1XM2hyQklqUXVpYyt5QUdFR3hxaHUzTUtjb09FdkZTcU42?=
 =?utf-8?B?TTRFenBROHFQVGJHaFEzcFZRZGxkZHo0ajhmTGNRUk5BQ0MzaWovZkRTTUJz?=
 =?utf-8?B?N0xLNXpieW1BOW43L1lIYTZhUUV1aFVtc3JITlNGVFNncklNTW5WUm5obmEr?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44A9A5040EAE6E47A8C49BB03F4685E7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VUaKy3H+X6+8nJSMYNd90IeeUm4YOD3iaefTXoFiyhhf28YCPwcNcX0om5+GfNZcv1+Llo+i7dwlaSOnJtVxaX1RMFEeMH+WRH2CKjO/9ewlkvUhsHtRk2nHOi/1EQAXKtdKu1ni8mpypbs5U5ZB5cdW8baDgbDabmUey1I+CsFhSyNsvlYDV1bujOjAezzrNBb2tjFL+zDnZe15qQMi1VtT7/npAuJOmqcS952VdtYfxfID96KAzJJfpQ43NLW/QYdEzjE8NhGtWj2sRDh2VialTWMZiAd1oqPNdwWRA7AanR8KVURsjcr/RoiZoq5ACZEO1gSZ/CneuskVaC+kREHecMpHJVUFRsE98WneGcHkSdoRhhJMKm3K6I2Rh4I8ntPeShfN20gKdt297jSLZ4nArx2xwVFBQK2QOwaHX5CyD+hXaV5mh75W8FJplFrUTA9z6CHWA+0vb6ZRKcxePFGGDxHk3xyuot3VGKOzzBKA0mO0nxVie7wtPQUPNJNig/ZHgbyOYbctW5EKCVtVz/dgDBEWnt9w8sIFRSJbyd/yqRbP7pRBs4cox6HPn7qj96s4ojXNZAUzJ4ppNxeNXtLSiJ9O78ni+M1rg1ZU2HlFIYGGoj+OnqyU0pCRXLsba45HWf/0unfSUHNePoaU7dXu/yjenygCcemoXeawrZaiW3RQ72Ymvwmw2WWH8vgomdM+WYhv5L1Qh2vFxotpAWRPdqAHl9LzT5wl8o/UgQX7ssDSyzldbsM4Xa2OORpQzRmoXtm7Ey7AULJYegU3S/hxZeslV1O4DzrIWh9r0s+nRR+bTcbJFxE9/gUahaE13GYY+SMwOKWVjBsbOz0lsA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3047c9f-5f49-41b7-a7cf-08db737781fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 23:22:12.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MI06/2MMGVNGua78qQFM148rZhqHrZcf330UWqZtWxqp+yGLheC8E/WEhD1jTE5HPWRcO65F8OfQ0Pb9hCuJcOPU3oY0fx64H84wKblgt7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_17,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=778 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220201
X-Proofpoint-GUID: xeII8sYGvhyvbB69aNSsExgUcEdIkmfi
X-Proofpoint-ORIG-GUID: xeII8sYGvhyvbB69aNSsExgUcEdIkmfi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDEwOjI5IC0wNzAwLCBKZXJlbXkgQm9uZ2lvIHdyb3RlOg0K
PiBIaSBEYXJyaWNrIGFuZCBBbGxpc29uLA0KPiANCj4gVGhlcmUgaGFzIGJlZW4gYSBzdGFuZGlu
ZyBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGludm9sdmluZyBBSU8gRElPDQo+IDRrLWFsaWduZWQg
d3JpdGVzIG9uIGV4dDQgYmFja2VkIGJ5IGEgZmFzdCBsb2NhbCBTU0Qgc2luY2UgdGhlIHN3aXRj
aA0KPiB0byBpb21hcC4gSSB0aGluayBpdCB3YXMgb3JpZ2luYWxseSByZXBvcnRlZCBhbmQgaW52
ZXN0aWdhdGVkIGluIHRoaXMNCj4gdGhyZWFkOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzg3bGY3cmtmZnYuZnNmQGNvbGxhYm9yYS5j
b20vX187ISFBQ1dWNU45TTJSVjk5aFEhTDZwVTAtZzVYV2o1Mjk4aGozZXRMajlMVzExdDVHYTdj
dlRNMWlEZjE1OG4xZ1RMb3QwcjBXRUxvenNsbHMwTHZKOFg5dmlsODFwT25fQ1FNZ0haeVEkDQo+
IMKgDQo+IA0KPiBTaG9ydCB2ZXJzaW9uOg0KPiBQcmUtaW9tYXAsIGZvciBleHQ0IGFzeW5jIGRp
cmVjdCB3cml0ZXMsIGFmdGVyIHRoZSBiaW8gaXMgd3JpdHRlbiB0bw0KPiBkaXNrDQo+IHRoZSBj
b21wbGV0aW9uIGZ1bmN0aW9uIGlzIGNhbGxlZCBkaXJlY3RseSBkdXJpbmcgdGhlIGVuZGlvIHN0
YWdlLg0KPiANCj4gUG9zdC1pb21hcCwgZm9yIGRpcmVjdCB3cml0ZXMsIGFmdGVyIHRoZSBiaW8g
aXMgd3JpdHRlbiB0byBkaXNrLCB0aGUNCj4gY29tcGxldGlvbg0KPiBmdW5jdGlvbiBpcyBkZWZl
cnJlZCB0byBhIHdvcmsgcXVldWUuIFRoaXMgYWRkcyBsYXRlbmN5IHRoYXQgaW1wYWN0cw0KPiBw
ZXJmb3JtYW5jZSBtb3N0IG5vdGljZWFibHkgaW4gdmVyeSBmYXN0IFNTRHMuDQo+IA0KPiBEZXRh
aWxlZCB2ZXJzaW9uOg0KPiBBIHBvc3NpYmxlIGV4cGxhbmF0aW9uIGlzIGJlbG93LCBmb2xsb3dl
ZCBieSBhIGZldyBxdWVzdGlvbnMgdG8NCj4gZmlndXJlDQo+IG91dCB0aGUgcmlnaHQgd2F5IHRv
IGZpeCBpdC4NCj4gDQo+IEluIDQuMTUsIGV4dDQgdXNlcyBmcy9kaXJlY3QtaW8uYy4gV2hlbiBh
biBBSU8gRElPIHdyaXRlIGhhcw0KPiBjb21wbGV0ZWQNCj4gaW4gdGhlIG52bWUgZHJpdmVyLCB0
aGUgaW50ZXJydXB0IGhhbmRsZXIgZm9yIHRoZSB3cml0ZSByZXF1ZXN0IGVuZHMNCj4gaW4gY2Fs
bGluZyBiaW9fZW5kaW8oKSB3aGljaCBlbmRzIHVwIGNhbGxpbmcgZGlvX2Jpb19lbmRfYWlvKCku
IEENCj4gZGlmZmVyZW50IGVuZF9pbyBmdW5jdGlvbiBpcyB1c2VkIGZvciBhc3luYyBhbmQgc3lu
YyBpby4gSWYgdGhlcmUgYXJlDQo+IG5vIHBhZ2VzIG1hcHBlZCBpbiBtZW1vcnkgZm9yIHRoZSB3
cml0ZSBvcGVyYXRpb24ncyBpbm9kZSwgdGhlbiB0aGUNCj4gY29tcGxldGlvbiBmdW5jdGlvbiBm
b3IgZXh0NCBpcyBjYWxsZWQgZGlyZWN0bHkuIElmIHRoZXJlIGFyZSBwYWdlcw0KPiBtYXBwZWQs
IHRoZW4gdGhleSBtaWdodCBiZSBkaXJ0eSBhbmQgbmVlZCB0byBiZSB1cGRhdGVkIGFuZCB3b3Jr
DQo+IGlzIGRlZmVycmVkIHRvIGEgd29yayBxdWV1ZS4NCj4gDQo+IEhlcmUgaXMgdGhlIHJlbGV2
YW50IDQuMTUgY29kZToNCj4gDQo+IGZzL2RpcmVjdC1pby5jOiBkaW9fYmlvX2VuZF9haW8oKQ0K
PiBpZiAoZGlvLT5yZXN1bHQpDQo+IMKgwqDCoMKgwqDCoMKgIGRlZmVyX2NvbXBsZXRpb24gPSBk
aW8tPmRlZmVyX2NvbXBsZXRpb24gfHwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZGlvX29wID09IFJFUV9PUF9XUklURSAmJg0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpby0+aW5v
ZGUtPmlfbWFwcGluZy0+bnJwYWdlcyk7DQo+IGlmIChkZWZlcl9jb21wbGV0aW9uKSB7DQo+IMKg
wqDCoMKgwqDCoMKgIElOSVRfV09SSygmZGlvLT5jb21wbGV0ZV93b3JrLCBkaW9fYWlvX2NvbXBs
ZXRlX3dvcmspOw0KPiDCoMKgwqDCoMKgwqDCoCBxdWV1ZV93b3JrKGRpby0+aW5vZGUtPmlfc2It
PnNfZGlvX2RvbmVfd3EsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
ZGlvLT5jb21wbGV0ZV93b3JrKTsNCj4gfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqAgZGlvX2Nv
bXBsZXRlKGRpbywgMCwgRElPX0NPTVBMRVRFX0FTWU5DKTsNCj4gfQ0KPiANCj4gQWZ0ZXIgZXh0
NCBzd2l0Y2hlZCB0byB1c2luZyBpb21hcCwgdGhlIGVuZGlvIGZ1bmN0aW9uIGJlY2FtZQ0KPiBp
b21hcF9kaW9fYmlvX2VuZF9pbygpIGluIGZzL2lvbWFwL2RpcmVjdC1pby5jLiBJbiBpb21hcCB0
aGUgc2FtZSBlbmQNCj4gaW8NCj4gZnVuY3Rpb24gaXMgdXNlZCBmb3IgYm90aCBhc3luYyBhbmQg
c3luYyBpby4gQWxsIHdyaXRlIHJlcXVlc3RzIHdpbGwNCj4gZGVmZXIgaW8gY29tcGxldGlvbiB0
byBhIHdvcmsgcXVldWUgZXZlbiBpZiB0aGVyZSBhcmUgbm8gbWFwcGVkIHBhZ2VzDQo+IGZvciB0
aGUgaW5vZGUuDQo+IA0KPiBIZXJlIGlzIHRoZSByZWxldmFudCBjb2RlIGluIGxhdGVzdCBrZXJu
ZWwgKHBvc3QtaW9tYXApIC4uLg0KPiANCj4gZnMvaW9tYXAvZGlyZWN0LWlvLmM6IGlvbWFwX2Rp
b19iaW9fZW5kX2lvKCkNCj4gaWYgKGRpby0+d2FpdF9mb3JfY29tcGxldGlvbikgew0KPiDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IHRhc2tfc3RydWN0ICp3YWl0ZXIgPSBkaW8tPnN1Ym1pdC53
YWl0ZXI7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBXUklURV9PTkNFKGRpby0+c3VibWl0LndhaXRl
ciwgTlVMTCk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfd2FrZV9pb190YXNrKHdhaXRlcik7
DQo+IMKgwqAgfSBlbHNlIGlmIChkaW8tPmZsYWdzICYgSU9NQVBfRElPX1dSSVRFKSB7DQo+IMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZGlvLT5pb2Ni
LT5raV9maWxwKTsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqAgV1JJVEVfT05DRShkaW8tPmlvY2It
PnByaXZhdGUsIE5VTEwpOw0KPiDCoMKgwqDCoMKgwqDCoMKgIElOSVRfV09SSygmZGlvLT5haW8u
d29yaywgaW9tYXBfZGlvX2NvbXBsZXRlX3dvcmspOw0KPiDCoMKgwqDCoMKgwqDCoMKgIHF1ZXVl
X3dvcmsoaW5vZGUtPmlfc2ItPnNfZGlvX2RvbmVfd3EsICZkaW8tPmFpby53b3JrKTsNCj4gwqDC
oCB9IGVsc2Ugew0KPiDCoMKgwqDCoMKgwqDCoMKgIFdSSVRFX09OQ0UoZGlvLT5pb2NiLT5wcml2
YXRlLCBOVUxMKTsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpb21hcF9kaW9fY29tcGxldGVfd29yaygm
ZGlvLT5haW8ud29yayk7DQo+IH0NCj4gDQo+IFdpdGggdGhlIGF0dGFjaGVkIHBhdGNoLCBJIHNl
ZSBzaWduaWZpY2FudGx5IGJldHRlciBwZXJmb3JtYW5jZSBpbg0KPiA1LjEwIHRoYW4gNC4xNS4g
NS4xMCBpcyB0aGUgbGF0ZXN0IGtlcm5lbCB3aGVyZSBJIGhhdmUgZHJpdmVyIHN1cHBvcnQNCj4g
Zm9yIGFuIFNTRCB0aGF0IGlzIGZhc3QgZW5vdWdoIHRvIHJlcHJvZHVjZSB0aGUgcmVncmVzc2lv
bi4gSQ0KPiB2ZXJpZmllZCB0aGF0IHVwc3RyZWFtIGlvbWFwIHdvcmtzIHRoZSBzYW1lLg0KPiAN
Cj4gVGVzdCByZXN1bHRzIHVzaW5nIHRoZSByZXByb2R1Y3Rpb24gc2NyaXB0IGZyb20gdGhlIG9y
aWdpbmFsIHJlcG9ydA0KPiBhbmQgdGVzdGluZyB3aXRoIDRrLzhrLzEyay8xNmsgYmxvY2tzaXpl
cyBhbmQgd3JpdGUtb25seToNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
cGVvcGxlLmNvbGxhYm9yYS5jb20vKmtyaXNtYW4vZGlvL3dlZWsyMS9iZW5jaC5zaF9fO2ZnISFB
Q1dWNU45TTJSVjk5aFEhTDZwVTAtZzVYV2o1Mjk4aGozZXRMajlMVzExdDVHYTdjdlRNMWlEZjE1
OG4xZ1RMb3QwcjBXRUxvenNsbHMwTHZKOFg5dmlsODFwT25fQ3BuaFZYZmckDQo+IMKgDQo+IA0K
PiBmaW8gYmVuY2htYXJrIGNvbW1hbmQ6DQo+IGZpbyAtLWlvZW5naW5lIGxpYmFpbyAtLXNpemU9
MkcgLS1kaXJlY3Q9MSAtLWZpbGVuYW1lPSR7TU5UfS9maWxlIC0tDQo+IGlvZGVwdGg9NjQgXA0K
PiAtLXRpbWVfYmFzZWQ9MSAtLXRocmVhZD0xIC0tb3ZlcndyaXRlPTEgLS1icz0ke0JTfSAtLXJ3
PSRSVyBcDQo+IC0tbmFtZSAiYHVuYW1lIC1yYC0ke1RZUEV9LSR7Uld9LSR7QlN9LSR7RlN9IiBc
DQo+IC0tcnVudGltZT0xMDAgLS1vdXRwdXQtZm9ybWF0PXRlcnNlID4+ICR7TE9HfQ0KPiANCj4g
Rm9yIDQuMTUsIHdpdGggYWxsIHdyaXRlIGNvbXBsZXRpb25zIGNhbGxlZCBpbiBpbyBoYW5kbGVy
Og0KPiA0azrCoCBidz0xMDU2TWlCL3MNCj4gOGs6wqAgYnc9MjA4Mk1pQi9zDQo+IDEyazogYnc9
MjMzMk1pQi9zDQo+IDE2azogYnc9MjQ1M01pQi9zDQo+IA0KPiBGb3IgdW5tb2RpZmllZCA1LjEw
LCB3aXRoIGFsbCB3cml0ZSBjb21wbGV0aW9ucyBkZWZlcnJlZDoNCj4gNGs6wqAgYnc9MTAwNE1p
Qi9zDQo+IDhrOsKgIGJ3PTIwNzRNaUIvcw0KPiAxMms6IGJ3PTIzMDlNaUIvcw0KPiAxNms6IGJ3
PTI0NjVNaUIvcw0KPiANCj4gRm9yIG1vZGlmaWVkIDUuMTAsIHdpdGggYWxsIHdyaXRlIGNvbXBs
ZXRpb25zIGNhbGxlZCBpbiBpbyBoYW5kbGVyOg0KPiA0azrCoCBidz0xMTkzTWlCL3MNCj4gOGs6
wqAgYnc9MjI1OE1pQi9zDQo+IDEyazogYnc9MjM0Nk1pQi9zDQo+IDE2azogYnc9MjQ0Nk1pQi9z
DQo+IA0KPiBRdWVzdGlvbnM6DQo+IA0KPiBXaHkgZGlkIGlvbWFwIGZyb20gdGhlIGJlZ2lubmlu
ZyBub3QgbWFrZSB0aGUgYXN5bmMvc3luYyBpbyBhbmQNCj4gbWFwcGVkL3VubWFwcGVkIGRpc3Rp
bmN0aW9uIHRoYXQgZnMvZGlyZWN0LWlvLmMgZGlkPw0KPiANCj4gU2luY2Ugbm8gaXNzdWVzIGhh
dmUgYmVlbiBmb3VuZCBmb3IgZXh0NCBjYWxsaW5nIGNvbXBsZXRpb24gd29yaw0KPiBkaXJlY3Rs
eSBpbiB0aGUgaW8gaGFuZGxlciBwcmUtaW9tYXAsIGl0IGlzIHVubGlrZWx5IHRoYXQgdGhpcyBp
cw0KPiB1bnNhZmUgKHNsZWVwaW5nIHdpdGhpbiBhbiBpbyBoYW5kbGVyIGNhbGxiYWNrKS4gSG93
ZXZlciwgdGhpcyBtYXkNCj4gbm90DQo+IGJlIHRydWUgZm9yIGFsbCBmaWxlc3lzdGVtcy4gRG9l
cyBYRlMgcG90ZW50aWFsbHkgc2xlZXAgaW4gaXRzDQo+IGNvbXBsZXRpb24gY29kZT8NCj4gDQo+
IEFsbGlzb24sIFRlZCBtZW50aW9uZWQgeW91IHNhdyBhIHNpbWlsYXIgcHJvYmxlbSB3aGVuIGRv
aW5nDQo+IHBlcmZvcm1hbmNlIHRlc3RpbmcgZm9yIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBVbmJy
ZWFrYWJsZSBMaW51eC4gQ2FuDQo+IHlvdSB0ZXN0L3ZlcmlmeSB0aGlzIHBhdGNoIGFkZHJlc3Nl
cyB5b3VyIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gYXMNCj4gd2VsbD8NCkhpIEplcmVteSzCoA0K
DQpTdXJlIEkgY2FuIGxpbmsgdGhpcyBwYXRjaCB0byB0aGUgYnVnIHJlcG9ydCB0byBzZWUgaWYg
dGhlIHRlc3RlciBzZWVzDQphbnkgaW1wcm92ZW1lbnRzLiAgSWYgYW55dGhpbmcsIEkgdGhpbmsg
aXQncyBhIGdvb2QgZGF0YSBwb2ludCB0byBoYXZlLA0KZXZlbiBpZiB3ZSBhcmUgc3RpbGwgY29u
c2lkZXJpbmcgb3RoZXIgc29sdXRpb25zLiAgVGhhbmtzIQ0KDQpBbGxpc29uDQoNCj4gDQo+IEpl
cmVteSBCb25naW8gKDEpOg0KPiDCoCBGb3IgRElPIHdyaXRlcyB3aXRoIG5vIG1hcHBlZCBwYWdl
cyBmb3IgaW5vZGUsIHNraXAgZGVmZXJyaW5nDQo+IMKgwqDCoCBjb21wbGV0aW9uLg0KPiANCj4g
wqBmcy9pb21hcC9kaXJlY3QtaW8uYyB8IDQgKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQoNCg==
