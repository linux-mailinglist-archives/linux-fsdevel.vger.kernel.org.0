Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA49B6A3A02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 05:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjB0EHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 23:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjB0EHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:07:39 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A510ABA
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 20:07:31 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R3iq5x029558;
        Mon, 27 Feb 2023 04:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=SxhwtM8dFgzBYkrzvLB4zTg9TlTwV0JuiKy3bPN6moQ=;
 b=nkbyzAMjz1qnv8Vq440MiXapLXGbx5EZ2OKfD1Ykryxjq3buKQZAAE93Sgi4ztbjLjsQ
 BLLfYO1bbeAj6CXxCqFoskO6YUJ0IKIryP1CqEIkAgxT7hlhGIqCpr66k5cHdNfqZWwy
 jvMww4EejLSzhGK6hegUXC4EQvbBtNIElwCMg1xaVG3JG4kKBRSg54Lbo4AW1CUBtZaL
 zk0uMn+FTcmb2lA2u+ShnIpt4GuviijoRj9tI+Ng0cffgDca2czsdlXBYvcjK5IGxhPv
 afv20kLUsizjH6iZNJMftNha2e7GzxIuLuTSwpxQsr1XgbmWOn80dpe5DlAFbhhlt3Cf oA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2048.outbound.protection.outlook.com [104.47.26.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nyb56h4se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 04:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSAobkr1fYKqcCPPgI4E5kkT5K6f+Gg/JYiBhvR6VI9EHhGQdJoNQ6Z2+JkuZMkjYknVw+ZtGa8VmfoDKc6v+Jc3RQgZa5y1hGsRo1P9Z0a6o/y26ACrSiSpsrx3/v0NT2PkO/5pmRGZttLySD4PIMqY5Pz7liESRluguapCHcbhTg51Nqdob7nimtOIbUYegQQ4ucO24iW4qM5i6GWhkNVVKGaFi+VcqrZnegEOcglDCCH37Q86Jujn+jUoH7qLippey0V9VNzaLCwpLE+jL7UTNAL10/oQqCtTtw862CmrUOwqPWJ1ve+pA0yUP9OQ1BuQSppe45nX31uNhvv3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxhwtM8dFgzBYkrzvLB4zTg9TlTwV0JuiKy3bPN6moQ=;
 b=E5bkINlNPSDfOEmQuNtUgwK3MfNbNqJyQI18t8Mlybk7xshyo+gw+1qs6ZdWhdbtxactVnIrk5HJiBVmJQZFUpTjPfcFaZhdksBjuZTVMrqC3U4EtiQIxg4IMDcoztAJvssTtj/kFF8LNnW5FijExorZI06h5iRdQl4+ptvQ0VGCk+ii/sz2LBybxHUWSXAQdIbRurBJpiOzm/AQ1wTzm7zEagfcv5U6XLQQHnqfYE/tUECZgbRLPBlJpSvzALQ5BFakQwM0Xd3RMTDW5mEYviiyIq7sQVe/nxXOslFECs3xvejvp6cutn52xCQoa5AYBcQSZ8sGbsIc7YTJzHU18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4298.apcprd04.prod.outlook.com (2603:1096:4:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 04:07:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6134.026; Mon, 27 Feb 2023
 04:07:05 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Topic: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Index: AdlFxiFlnzIOBZgURkO2gsQA24A40QCktYOAAH3lA4AAASiAAAAAd1+g
Date:   Mon, 27 Feb 2023 04:07:05 +0000
Message-ID: <PUZPR04MB63165E432B3DC7B119AB91D181AF9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
 <TYAPR04MB2272FCA531495222A6BAFAF980AF9@TYAPR04MB2272.apcprd04.prod.outlook.com>
 <CAKYAXd-PSRQZB8vcqB1CB-EOGE6fjgU96=rXas04bKUHC0WBbA@mail.gmail.com>
In-Reply-To: <CAKYAXd-PSRQZB8vcqB1CB-EOGE6fjgU96=rXas04bKUHC0WBbA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4298:EE_
x-ms-office365-filtering-correlation-id: f9392bfb-d380-4a9d-1c43-08db187816b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2nXSlf2IAWMOSV9RKfrJQOTI7kBc5KooF+fCns8NZgVvAu9Kau1NWPRMtmQP6BKRUJi2GpNoXRIKBtpLDyDPvoqmkfPQ9Sss3SR3MxeDdcono8OEas4DdqUND+5N1LQoEKP6NYOoNFnOCZQ5Otg10YNapJPPwOUGniB/YGEqIT6sbPjw2NhartgQXPW3TDJeMRrX3cw6kEtqWfScDsJfFsebU+oNzY8t83QYLcwx0awOYujwA0kyNUxv/1WocHbW4eAM/s4RKa3SJw6In60qODz1z3gD+Z1G6/N3eGk2GiAzgztcw8FkFGaJgWYaGIDQOHxfM0Sv1HWg5EBqM+bw/Xn6y3vy6WuW8QOn+d+tTHcxJFeFX6Qhr9FGGc2tQKx+YO9hNJSlgdOeW8cC6Xvp+JtcqaS1urXTNXhm6/GutZ77/uKFpfz2jK0eo537h9mrbohmxRBQwb+Oe86G8O0BtSRb9CzuTccKxCMAeeo19az4BdkEdDVo+QAvIQGVo+DkjsxtaJ4zKNbXJ34RTANr/WUP7pAMXHvXZTS4teADMzp74pZuSkojJKAA9JP7wfKAy6dvJM4qBitVnJpc71s0kBkPy0NLhja8W1ANOE4IaFSAgkwCp7IOn4VTmksfk29M/r9hW82muf74RXt2jsm0DoVcGqQ3hxS8c9aa6C43+DUei8BDkptN+Hr/9CIeS8KxtS6xjlidGljJ6hQbhudaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(122000001)(41300700001)(55016003)(38070700005)(82960400001)(6506007)(26005)(186003)(9686003)(71200400001)(7696005)(86362001)(316002)(6636002)(33656002)(110136005)(54906003)(478600001)(66476007)(66556008)(76116006)(66446008)(64756008)(107886003)(66946007)(8676002)(4326008)(38100700002)(52536014)(2906002)(8936002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhvN1hEcHFGS1U3MEZET2NCbzArZlZaZ0NndG14SEUyOHZKakZXY2RuVENR?=
 =?utf-8?B?cXQ3aTZad3FnNFNzMklEODM0ekJDdG90aXhJZzRVdkRJdHhxRFVOZzYzNXVq?=
 =?utf-8?B?czQrQ1RYQWExT3VGaGVIZThnM2xMVllzQ1dVVGMvUUdPbkZqQTNVOTdoMGFt?=
 =?utf-8?B?VlRadWoySllPS1MzWE1OVXNIQ1RyeEpLWVBQUEZCclV1WDk2QnF1K0NaZlg0?=
 =?utf-8?B?eFVPR2xDaENWckVMNE91eDJTa2tNQUdQaDdtMmNNTXAvd1hWSHhnL1YxUXcy?=
 =?utf-8?B?bTFnSXcrQnRWZ1pweENyNTlvNjN1M1hjcS91d2loU0tSVjNieXJ4SmJaRXBm?=
 =?utf-8?B?cXorTHUyYmlraDRnU0IvdnBrUHVyRGc3MTR1bjMycXZ2dXNkeVdVS3g0UEY2?=
 =?utf-8?B?NWJRUmhIOExQRTBMWlpSNjRVTVVJdmNsZlN0NEtiaXU5a2d0YUZ1UEZKSElR?=
 =?utf-8?B?NUlmRG1ZQndTWWY4Z2ttd1hnalZRRVBnQTQwR1QyV2F3d2N1eTdxWnRkRnpW?=
 =?utf-8?B?OTE2dnNOcFg3ejJtOG1sdDNlU3lVSWNieHE2MTM0K1BrZk9pV3VJK25HWjZy?=
 =?utf-8?B?QU1XdkxrS2dtY1cwNms3VnBobVdJd0xlUXRiZG1iK296cXc1ei9FVUhPcFNW?=
 =?utf-8?B?NU1Cdnp3cGt5ZXlXZytFTlVXVnh5S3FUa0tBcS9DZjN2TEkwYmZDay85b2Q2?=
 =?utf-8?B?cDYrUCtiZ2gvbkY2eWJRQldyOW9rcUZZS2dHd2sybW9JM0dwYnIvVFl6YUJL?=
 =?utf-8?B?ZjdGL2JqWWdha1oxbmk2K3V2WUc4Z0N4NnpQbkdYb0YzVEhsVEx2cXdyd1M1?=
 =?utf-8?B?YmlSaGU1ZGFPRjBRT2ZiWWJaWmMraXhPSUp1TERhN1A5UEd2T1dIbHN4K09N?=
 =?utf-8?B?aEwwRWZDV3E2MFZFZ2FscmhLZ0lMejNVODNvNGlaaWcxV1ZqY2Z1Tml1VDNB?=
 =?utf-8?B?U0Izc0IvZVRhQVNoQ05VOElaaEtJVU5oV3pYb1E0MnQwOHpxc2d6cXpYMXNO?=
 =?utf-8?B?S2hkVHBYTWc4aWMrUDl3d0Q1WE03aml3Y1dvUWdGcU02UXhxN2xDaEphVTYw?=
 =?utf-8?B?VDdNL2xlWkNEQjlWb0ZzcVVyckNrV09STG9FcDdRVGw3ZGo3TkJjUEFRQlpp?=
 =?utf-8?B?WE9NTjFsYklwYVYzcUFScjN6WXFyOGt4YW1JRWhnUmZsSzQ2QmI3b0h0Q0pC?=
 =?utf-8?B?Zi9XS0R2SDk1b0w0bEhJY1N2MlVoYXJUMyt4S0xGSXhMa2FoRWluaGgvdEFj?=
 =?utf-8?B?dmF2Q0IzRzBwTWExVUF0TlI4RU1uTzVBQzNaM0NtdEZzYXB4anJyR2QwTlJJ?=
 =?utf-8?B?Uk44WWZ3a0pnb2VPUTM2TFFHd0hOdElSVHhXNUZZc2thczRwZGJzeEZQa3lo?=
 =?utf-8?B?ajlCbFVxNldGYWduVGRSdk1UMFowcUtZVUxML085cEUrS0RJeFBOZkxoRGJh?=
 =?utf-8?B?YTZBWFI2R2h1Vy9kMHlPVWwyeFFCSE9ha3d6a1ZTc0tzYUQ1NTJQZ3hRYTFp?=
 =?utf-8?B?UFhjQzZkd3VRZmR5Z0tMcHpWdGpjeWoyanJ0SVMvV05ZZytLRkZ0OVJ5NEh4?=
 =?utf-8?B?b3pHMnJsYUtmQ3ZzdDk4TllVL3FBSGdXRVBZTG9SbmFBMXM1b05ueXEzYmdX?=
 =?utf-8?B?eG9TMXI5SmxXckJBeUJjUFFBN2RzTDhZemR1Z3hDbkFLMUMrYjRIZnkzUnVI?=
 =?utf-8?B?QytHSkNkMHZoOEJOQUVHMlh4WmdrMjliL3lELzdlelZBMXp4NGlGQjZUQUhs?=
 =?utf-8?B?RWExRlgwV2Rhd1VReFBFd2RwNVlWTGU5WkVPTGRubVdMQlhZd3JqU0ZGaVgv?=
 =?utf-8?B?SWplcGxOUEpvVGlxa00vMVhrUjNEaENHZWZ4djUveWg4SVhlKzJST29WRmlj?=
 =?utf-8?B?M3FGMkwvbUN1T2I1dTFOOHZ5N2xuRjF4c1pSTHl5RThwdjc3eVBwWTRWY3RN?=
 =?utf-8?B?WkttWDd4NzFYdVZEU3NRTjhWK2pjdWZUZHFxYytVQVJSeHJSWndpbFRsbEsx?=
 =?utf-8?B?ZU9LbzFLK3RHRzFaNTExSTkxTUNmemcxMVB6bjVtK2JpQVEzTmNyVkx5bUpI?=
 =?utf-8?B?Z1dFOW1WUjI0M1NGMExzclJubmx6blMrcXZBU09oa09VS1VCRHFlbU1GN0tw?=
 =?utf-8?Q?WJQtmnuaxzP68rxCIDlQqfOFO?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BnNKbcxUv5WOoSbK6Ewox9VJWHJjDvJvT/u6qqJu8OmkcJrB/xCmqx/ZZCqDf+8N+++e0wacTkExrc71irhXCMNHBHvwGRgVEEiZQgTF6U5Sp+xrsWtyIVowRAh/J27bKwgDGZbX86EyNmIl5Ti21QuOc0enHqBIEuWQCu4AzXeiAYB7QeD3OynwQ+LmmiHgXKQdvG39BXoGMXVYm2ni+FhHedC+xwyLLFAO9g20oBcGg3kY6Zat7lzlu3vFQW3QcW9G8iEuN5DvFEbNGNl48sytNheia00TVv5srv6eP0urGmzgU2qekIjvym0a3/6HL3bEHipsxqDm9KwbbwbV/dLnZwZOjUVKqvpwtgXvIHfISxIBhYYbq9JIo4zgYsGvFS8QLtS0HVrEJrkAXaJk2emnsouOp9E7Kg2VX+1TRDcVVRs9douWr4ENT4zvzWyC+AthqqmOD+7bB16qlt07+1B42GN5D+SOR8lJA++u1EIT77TRdWC/yXIiw4wYkR91DOEVI/eH/rH2prY5gwn2agrZ3lE4RMecr9/8Jp4yFGvGz5RDQyJmHUZsLt9BWbmxkUJRVR1z76FUOStGhIoJv0hBg8P/Dk+9FEGxu4ztO4PbhxBXRkXdEcXFG27q1mzNpIW4j3WhH6SqfjmYShjQ9TNfp+Vq0FCn0pTUUmfozKRsAINzcmoVm8mRnxs+VLI+lg1BEvaihqAsefslr1DPv0JykvmcpI+RY9hZMPAdoBeeJi111lMf77ydrpaNuDZZ8d4DbRvsGRQEIoLOSee/pv4wk5h5TidKlhPtNMlJ9t0P+pDuQwlBDSXRFQjmiS8u12I7tO5kZtEwij4yS6trbA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9392bfb-d380-4a9d-1c43-08db187816b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 04:07:05.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hz6dafTuJ6LZhrkuOPHppUc9VWMwjs0hzk7N+6pkTDJJy/n4fFvZMGk0dSXKkuIZOOetk62u6dsKgYAohItyQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4298
X-Proofpoint-ORIG-GUID: H12O4TagPbhahWOPMLzXMTllrbFJRLVB
X-Proofpoint-GUID: H12O4TagPbhahWOPMLzXMTllrbFJRLVB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: H12O4TagPbhahWOPMLzXMTllrbFJRLVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlLA0KDQo+ID4NCj4gPj4gPiArCWlmIChoaW50X2NsdSA9PSBzYmktPm51bV9jbHVz
dGVycykgew0KPiA+PiA+ICAJCWhpbnRfY2x1ID0gRVhGQVRfRklSU1RfQ0xVU1RFUjsNCj4gPj4g
PiAgCQlwX2NoYWluLT5mbGFncyA9IEFMTE9DX0ZBVF9DSEFJTjsNCj4gPj4gPiAgCX0NCj4gPiBU
aGlzIGlzIG5vcm1hbCBjYXNlLCBzbyBsZXQgZXhmYXQgcmV3aW5kIHRvIHRoZSBmaXJzdCBjbHVz
dGVyLg0KPiA+DQo+ID4+ID4gKwkvKiBjaGVjayBjbHVzdGVyIHZhbGlkYXRpb24gKi8NCj4gPj4g
PiArCWlmICghaXNfdmFsaWRfY2x1c3RlcihzYmksIGhpbnRfY2x1KSkgew0KPiA+PiA+ICsJCWV4
ZmF0X2VycihzYiwgImhpbnRfY2x1c3RlciBpcyBpbnZhbGlkICgldSkiLCBoaW50X2NsdSk7DQo+
ID4+ID4gKwkJcmV0ID0gLUVJTzsNCj4gPj4gVGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIGFsbG9j
YXRpb24gd2hlbiBpbnZhbGlkIGhpbnQgY2x1Lg0KPiA+PiBJdCBpcyByaWdodCB0byBoYW5kbGUg
aXQgYXMgYmVmb3JlIGluc3RlYWQgcmV0dXJuaW5nIC1FSU8uDQo+ID4gV2UgdGhpbmsgYWxsIG90
aGVyIGNhc2UgYXJlIHJlYWwgZXJyb3IgY2FzZSwgc28sIGVycm9yIHByaW50IGFuZA0KPiA+IHJl
dHVybiBFSU8uDQo+IFdoeSA/DQo+IA0KPiA+IE1heSBJIGNvbmZpcm0gaXMgdGhlcmUgYW55IG5v
cm1hbCBjYXNlIGluIGhlcmU/DQo+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBtb3JlID8gSSBj
YW4ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBzYXlpbmcuDQo+ID4NCg0KYGhpbnRfY2x1YCBo
YXMgdGhlIGZvbGxvd2luZyBjYXNlcy4gDQoNCjEuIENyZWF0ZSBhIG5ldyBjbHVzdGVyIGNoYWlu
OiBgaGludF9jbHUgPT0gRVhGQVRfRU9GX0NMVVNURVJgDQoyLiBBcHBlbmQgYSBuZXcgY2x1c3Rl
ciB0byBhIGNsdXN0ZXIgY2hhaW46IGBoaW50X2NsdSA9IGxhc3RfY2x1ICsgMWANCiAgMi4xIGAg
aGludF9jbHUgPT0gc2JpLT4gbnVtX2NsdXN0ZXJzYA0KICAyLjIgYEVYRkFUX0ZJUlNUX0NMVVRF
UiA8PSBoaW50X2NsdSA8IHNiaS0+IG51bV9jbHVzdGVyc2ANCg0KVGhpcyBjb21taXQgc3BsaXRz
IGNhc2UgMiB0byAyLjEgYW5kIDIuMiwgYW5kIGhhbmRsZXMgY2FzZSAyLjEgYmVmb3JlIGNhbGxp
bmcgaXNfdmFsaWRfY2x1c3RlcigpLg0KU28gaXNfdmFsaWRfY2x1c3RlcigpIGlzIGFsd2F5cyB0
cnVlLCBldmVuIHJlbW92aW5nIHRoZSBjaGVjayBvZiBpc192YWxpZF9jbHVzdGVyKCkgaXMgZmlu
ZS4NCg0KQnV0IGNvbnNpZGVyaW5nIHRoYXQgdGhpcyBjaGVjayBjYW4gZmluZCBidWdzIGluIGZ1
dHVyZSBjb2RlIHVwZGF0ZXMsIHdlIGtlZXAgdGhpcyBjaGVjayBhbmQgcmV0dXJuIC1FSU8uDQpJ
ZiBub3QgcmV0dXJuZWQgRUlPIGFuZCBjb250aW51ZSwgYnVnIG1heSBub3QgYmUgcmV2ZWFsZWQu
DQo=
