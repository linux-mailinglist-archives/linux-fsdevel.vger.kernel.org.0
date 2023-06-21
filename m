Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7273849B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjFUNNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjFUNNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:13:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14121BE2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 06:13:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAwcO030336;
        Wed, 21 Jun 2023 13:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JKUTBDLCuNTuargqyRPiJkahZTYXs7thuPYstnTlq3M=;
 b=kSrsc6I2CYGetVm8KpbB/l9Q6bLh+zAze/zXdrCoGFPdyvgZAXzMQG5JaRr4Ai4aEePV
 ABtgvxdgdpVTn6vPaWsOGvVJVQMybP247ZTttyuBb81dCeGqpbFSsCQTcjApxfGVuIqq
 f5W5k4dV+J3OlA5himW7CGfVKxq1I/jz0LNqJ1BGt3W2F67MWikCS8LQis5PC+KRlV+o
 zDLzD2J2d/mboog2T1T0PeCLW2swMwuUXnwaq3rl+E/nSAELDrbzsb7Gcb55dlJVB4r6
 HuUcW64E/UBLHuXI7iFhR/NJQP9UbjjD9GivtG5FOYHZoCTlDUqCc+3AJMBKF5cIvm4M Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etqg2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:12:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LBcfRr008371;
        Wed, 21 Jun 2023 13:12:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93969rqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J83IQIgbZv0vbZhU/MVwPoCOJvZVqkl5ksUUygrljsiGaobdFTwIfc5del7D1ks+4iAHI70/KwakAH6W1qlRT00wv6AbZ7XTEcUBBWt1wJHs/YlXibMPeqmKXlmiRaJSoECM/ceMiblcFo+JoNsL8rQEM8J3LVsLcXbFgrluB0+nRhlU8azFF8C7Bih3CnuM8bRG6xM8yg9RW92Hnk2Bygc+VCX9w1pFAxFOw3qUopxbFpTdJHDjJjxQVZ2Rfe91NWMeLt265stnzADEgsK/Cipxbgaq5fazcMmRhlus1KUSemXWHRy8jtIf/xQsDb51QBzi0TlRnWQloZk6ffJ/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKUTBDLCuNTuargqyRPiJkahZTYXs7thuPYstnTlq3M=;
 b=U2kPrpsH2ESgUnzGFuMREJcWfJj2KDPyU21gFFD5p9AvAk2alpO2dqgQtEoAoSqDRK+8oGBv3QXGBO8NKZi0vtovdpXqSQNdnRNzahq5IeKzmD9T054JEhX7gYZs2knkkMjPypqnelsR47DjMd4vQO/m/k7n9f5jAeqLAl71mYmxCoP71rhb+NAbZWzdFD60D2zbamkfMhZSxLPgtpn5w/V+jMeLpVujep9UDg2dogWXBhu7zpyHd3Wl+lZFvX6huSrFo59UDzr7eeoJPZR3bwlrHIqBQYw0NllvyP5RrW35XwuIiAKgrM2p+KIhf/kyg6/Scjl5oB6+rvbzPzUkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKUTBDLCuNTuargqyRPiJkahZTYXs7thuPYstnTlq3M=;
 b=xyJRuVQKDfbwWTTjsqlphsNVCtaPdYHw0+oN5XZX3xCQHFuMqBJiNeg4/XN2yU3m/SaiEkepTqtHGO3mCWhWZavTr7rvyD5yEMbDJ77I/B9Am0FgthCdLBnRkcocTDjp6krEnS7hdE6wjQAVjNOwg44K4053c9ABBXTsXAKWI4w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6964.namprd10.prod.outlook.com (2603:10b6:a03:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 13:12:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:12:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] shmemfs stable directory offsets
Thread-Topic: [PATCH v3 0/3] shmemfs stable directory offsets
Thread-Index: AQHZmHhXb7gMT7dz20Gxc4A5coGg8a+VUyaA
Date:   Wed, 21 Jun 2023 13:12:46 +0000
Message-ID: <B3ADB232-DA75-45E9-9F7B-CB7BF524F713@oracle.com>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
In-Reply-To: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6964:EE_
x-ms-office365-filtering-correlation-id: c237abce-3417-4c4f-0af3-08db7259348a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow6z/PAT40XuNQShHA3kQ/fztNDDIGEYncYEPzFycXMn3d1PpmfPS6e/Vx8iD3imD8IxrfvTEcuoKe0U3wCV6vR/0UKX0cjQom9JZ9fA64siaTlu+itQZuxlIyBAxHKUIIaWFr8DwIbUsdRlL1mhvwyMx6AZIVIxWEzG+Z70sYpH2BKGAB6pWVATDbrNv/bh6NhhCUBU98cQZw9zghvWtS05lgGe1joIZCqZ5IDEhRS+xUDERUWoUgsJuPOOmjPJuV7MoxgnnEEhb+/WbCkqr67DzDy8maxMwiqvuMDuVMsO1GS0eVsNdWvdxj6Z4WN/jGPBERhTmshiFD0pMKbf7sWrt1u21Fr6e3YPzeXDHRw1aTq+1JZNA5sy5Nyiqj7wiK+mlUKYKj23ipIWwEeSvODJqi3aqW1xTipDHSgrWXIOG5uQXDrnLil2Q5q/kOCmwCumkr3PeLfpsbVrkEWX92mm0bwcEWm2wWeAFr71OAwJ+OyuJAspxYjX1NO4FvGUc+oG8OUKVk4Z3tJ6D/Wz/Eg4Ao4o+pQTzFVEgnS6PoB4BLVGOfmoIh/OwgMHsSbIh/bfnOrstdcfKOpOGyZkYYQDu+lgNIUUPfZFMRr2a9JY2ytoHGLUETcKaHmM8aZi1yjcAzHTbs7YPqzrDcRAZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(71200400001)(6486002)(478600001)(33656002)(6512007)(186003)(83380400001)(26005)(2616005)(53546011)(38100700002)(36756003)(38070700005)(86362001)(6506007)(122000001)(2906002)(8936002)(8676002)(5660300002)(316002)(4326008)(64756008)(66476007)(66556008)(91956017)(76116006)(66446008)(41300700001)(66946007)(54906003)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35MuM3MUFczXAAkpluhnOd4RFLHpXyRJHUD2/cV+xN/G+OgYPLaLqgAIOJpM?=
 =?us-ascii?Q?pdng/freTQO4WrjqY8TV1y8LZu3+34huXbmzccRtl3EVC6C6x2ZpWErnNHD1?=
 =?us-ascii?Q?+1oIvUl80BAa7MagSMDpgHe/zVzS4ww9ExZTexvAWd0XgDbq/B4tXOaFiSJp?=
 =?us-ascii?Q?4Ui0mXKhZqqJHju1tAffAlSPg0DbyeuSdVZIkBWaXQ8O6SExnBCMKofpuRmg?=
 =?us-ascii?Q?11JNCx8cvrd5OgoglvcM/l9lE7c+up/9XDTzoAb/TXIPaNjSUEmESAqu57x/?=
 =?us-ascii?Q?JUbg8pPQNC3wHZn5TErvB18edJJg1h1M6f5hXk8RjL3EJfq22rNBl8pZz4xw?=
 =?us-ascii?Q?5Sx/uMfZunKSpex6zmyOodJsCQWuoiTH29k1zpeQvBzf4f9f27+NTXU8ti2i?=
 =?us-ascii?Q?enzxWVkKWpfVLY7GeIc1DCfHN+6zjsc/4VsGkP9QMZS2A7xXUXsKxPCvmIj3?=
 =?us-ascii?Q?KNYMq/BqxHV0UTPFEc9CH4eotIaP7mO9uV6Q9e+l3MybL9gSljAg9BylkcRL?=
 =?us-ascii?Q?k7LGcKwUONXQwZzsJJYDV8X2ZY7Wnwb7pN80HuaDcFv/rQ2cd8reqFXgfoeh?=
 =?us-ascii?Q?pcgvSWrgNRkJ+JJi8fqdEVvoRyKJppGm+sCzfe5XWQL1xhZ6MsVYhwnuxs3W?=
 =?us-ascii?Q?pcgQV9hK3ZIQpcJQpzQ6iSpAo+A4bxNynaRN62bLP8PVbqX7s64vbsWVi72J?=
 =?us-ascii?Q?tKZAuVftPuUnau9H6xl6xe1V9n/tbrP8aDk1TAAJ6yF2elxAAr5BxdMNbeHl?=
 =?us-ascii?Q?S9Pv5eoJjGRfQTf/yZ7d9jVZ/W/TYyQZgLkWtP5Ul9CkwEfzHFGSTnkrnF2r?=
 =?us-ascii?Q?KC4uquN53biS4ElgA5zRwHd8QRHl/rXPcur/xzzcpZ09QJI8DgPKkLEIDkcV?=
 =?us-ascii?Q?R1esBbGQpuoQ5wz3NuNNSmUdjvbBu1cOM+vpO2nvu8pdBMhonGbsrE0hSoLA?=
 =?us-ascii?Q?LsaZSENlAWRB3eqNIY3A4u18fUvKuDxbeU+6gUIst38WQX2UfLqojgUW8c2B?=
 =?us-ascii?Q?Jmh9lS1qGEAH6bs3Dv6otDeFiaFTk93886MaHqsdgNuf8VqFDlPwcO7y6W7S?=
 =?us-ascii?Q?Du7q1PU/Lk3d1CXLJt92wuHZjwAas26XuriLaCyshlH9NSwxsjFQnQF8+kj/?=
 =?us-ascii?Q?6aaGbRiIiIPIHxTrcbVKRZm+4+tAqtDis6QRihQ3+V+pJRUz4MDWxB0clEMn?=
 =?us-ascii?Q?2VF4pSzWKQtBCdUgAMa94Fg2ut84TY5bawGAJXcn+og/ehnpeMMYvjh3Z6kl?=
 =?us-ascii?Q?AQWJJ6pbxoutlwFdYzNNtzHg1MX0FfQOVHxkrgS15tRnBlMNiTP0k4CGYxLA?=
 =?us-ascii?Q?75xXfGNaCzwuISflHCcJJHACJbBh3jhdIYH7ofz2OwmlSGNylMhm/pMUiXtN?=
 =?us-ascii?Q?427AZGJJKEhp2L9GV3O797yAwjWEuhalenmEGn2GbV5n/7oynbPwwx+6QwdK?=
 =?us-ascii?Q?YA0WS5XZRXLL6Me1TlwAhcQQFX2drCenIpN7SkJf3NtXMuq5xmBQqNttoVSH?=
 =?us-ascii?Q?pa59WpkFyaWTSvtqjqvKfd+ZhrFje+1kcqyZM4UhrKtmQAoQoJlRQ1cSpeC6?=
 =?us-ascii?Q?+L5U7yDGcpxG7zJGTgORc55T5X8tfEthFtggNiQ/Zt7U3VlYedRo8NNsWYCx?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8861E128E05C0F46A997E78B24CD939A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XVPxFlRp75Li92Fb+k/i43c1zfI8cFhibEpIMumnmJzgtscbwJZmRXE2i6Br?=
 =?us-ascii?Q?QxXKLM5+RdgQL97W23dOSUGJyiok76TWZhyBhBqIOW/B+Lg3H8lXClSScOCQ?=
 =?us-ascii?Q?4UkjN140CwzhHyeVOnCOZfqv8ssOR9VXlgY93R/Wrk6zh8g196w4QoI2HYEY?=
 =?us-ascii?Q?MfwHLRq7dg/GIcu/Nvn8yn2xmITzqgDHB3NDOPnsBg0VLO235vHCQIG+War7?=
 =?us-ascii?Q?dBiYCwkJPS7LBFhNR/PbpLF6Tcpt3K/JlMGLFQW+b4SdwUb+fLP0Ay6mlC8I?=
 =?us-ascii?Q?6THNNW4uNcRNxXrtHNe2RJv8RAry9ZcbpnKQugmhf7goDcYMtVSvUyxfK6CM?=
 =?us-ascii?Q?6XyL6TtiyPTAhT0qZAmwD38zKqBP9Yyum4/l+b1ANbm9GHsq4ipkwFURZ7KW?=
 =?us-ascii?Q?IgCd3Tep7eNJGjnR0tRCOSrdBxhjyvv+zwV3EpbH7dBId+J9eEDL0eu7Sx/I?=
 =?us-ascii?Q?BkOL2U0Hb+Js2AHOUDoXGeikXmVNm2sUOiABAtyAD2o41V/7m50LTkoL4ihU?=
 =?us-ascii?Q?okr+OTGc3JsHSmZ6c5+MLoHOoVT0ZR+fxLQmRY0oOFb870mUMgGpUhwJ98ge?=
 =?us-ascii?Q?8GZZeFflx2udqheTIHmmJcjog3itLMl60twJC2j/UXgLtDWk14G1Z7OwLiOf?=
 =?us-ascii?Q?SkXMAFK+NlKn65dKqJ1QA/YXvlJnB4yVLiLxXgpsItGmJTtUh20LS6gbMLLo?=
 =?us-ascii?Q?EXtkCi1YSJ+axdIdfBuCTQqNYvoIwMbIA+uEbx9L9IKayBOaUTQTk8oFVDmN?=
 =?us-ascii?Q?cm+fnpGEDfjSct7RDiUcC1C7hjAFzUKS+r+THY1kBZINJ99se1KwDxD+l4pv?=
 =?us-ascii?Q?gTK6LfOQL0W9GRHJc72J99mi+2GmQTo4HXHLNrnVONQbHIbB8HzG0YteNmVM?=
 =?us-ascii?Q?UUzM17Ehoe46SZA07Uq1YZLEYr0oWavgVkdI6xIH7h0QgQ6UTi15Xxcop1db?=
 =?us-ascii?Q?Gvr6GmnfIolZURnYfOcXRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c237abce-3417-4c4f-0af3-08db7259348a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 13:12:46.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHxUZVhYTzneS+BsFpXrf9q3v5YXfDSjVMt3u/KP2jDnmW6IaICGGui9vjcVWqVKsV94x+sAhZwVseeDcuZu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=571 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210111
X-Proofpoint-GUID: 1OV9U5cvbDf2FQruGGihLjMlKb938p5y
X-Proofpoint-ORIG-GUID: 1OV9U5cvbDf2FQruGGihLjMlKb938p5y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 6, 2023, at 9:10 AM, Chuck Lever <cel@kernel.org> wrote:
>=20
> The following series is for continued discussion of the need for
> and implementation of stable directory offsets for shmemfs/tmpfs.
>=20
> As discussed in Vancouver, I've re-implemented this change in libfs
> so that other "simple" filesystems can use it. There were a few
> other suggestions made during that event that I haven't tried yet.
>=20
> Changes since v2:
> - Move bulk of stable offset support into fs/libfs.c
> - Replace xa_find_after with xas_find_next for efficiency
>=20
> Changes since v1:
> - Break the single patch up into a series
>=20
> Changes since RFC:
> - Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
> - A few cosmetic updates
>=20
> ---
>=20
> Chuck Lever (3):
>      libfs: Add directory operations for stable offsets
>      shmem: Refactor shmem_symlink()
>      shmem: stable directory offsets
>=20
>=20
> fs/dcache.c            |   1 +
> fs/libfs.c             | 185 +++++++++++++++++++++++++++++++++++++++++
> include/linux/dcache.h |   1 +
> include/linux/fs.h     |   9 ++
> mm/shmem.c             |  58 +++++++++----
> 5 files changed, 240 insertions(+), 14 deletions(-)

The good news is that so far I have received no complaints from bots
on this series.

The bad news is I have received no human comments. Ping?


--
Chuck Lever


