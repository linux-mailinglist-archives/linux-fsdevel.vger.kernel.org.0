Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BD5BA2BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIOWhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOWhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:37:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D14DB0A
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 15:37:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FLNwar017320;
        Thu, 15 Sep 2022 22:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4hNFyfl9QLtx9I8sLcWsKy8xE61RO71yma3I1jDv1cQ=;
 b=OuMOGfLtxuHFP57L4wwuqkvLTeOwC3P8N2XZWCZ7arUFuTYlK/ksy/PfKHBbnpEBBNqx
 jkkTn70kb8aB1eoP99WQbyK4il//8cA8TfHyjjAj7TNtBGTHsn0yTcNOKNYGGrUCKni8
 2SrFGaPBC7Zicj2poUA8ToD0oA/TvEHzb99Gm2uvmsUbhT2CVPUrADAcCGcurdXunY93
 dzgpxVhWoAeZ2GObv3Y80Jo/0Ka2VufdLEWqOYr3iPUPvrDkonwVGDil4Qp+5EjzLoRO
 8X/rSI6PBWRwUOly2+6RiXir1ptO+KbwTqO7n+0BBUDnIH2YBXHjdWttk5ZQS6nCI2aq Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xbrsfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 22:36:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FL4THl004175;
        Thu, 15 Sep 2022 22:36:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xeh6rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 22:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IssX3z9XRhakmbLfPJ2Y0kKUrwxy8BKkjY9lmyj0ku5Um1wzXlTxTcTgsUpNRaNp4hXXs95sjjDeYXRmeWJ6YsN7eXD4pUCYqBrAjZ4dnVvN/MUy+u3QuxG6onBpULRWshm0vdxGiNUF62jbnmrq9pLAJF70mT3eB/EDbftiaU+YMupdxEpc8NhEfGks8a2ziws3dbbSP/Lc6lfhliXtgsu5nMf3xt44qZxva8UXn/i1X9myf2ZJQI3LrUO/VS4qpMeXhfQkoty7WL98YIv51gEg/EgC4LdLDlxQpfp/Mdv1f62IaMOJy6J36AuxuRLlfH0WNjq86ALB00DacAhU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hNFyfl9QLtx9I8sLcWsKy8xE61RO71yma3I1jDv1cQ=;
 b=Z4uIDf/ddTPPy4UJoKig7Okjt2xXfr6ycK6RK/6AJ6dJdhKwaf7yJ9A5Un0hO5sAD/HnaE6VBjR4eYWtBwB+MQhid9oD/1vq4urAcott4Ti2rzfRuU1pAlGs8vrfS1UxkqAasRRsSG09fDgHWxRnLKcH1jjSgM9vO0yxE9Z1jkX673H87dL1eRJ07OSqgvAn7cGUr2AmZiD9DlGM5NpuU81vQAwlxvMFPoJhroYx8uc+q7rrWg7aUX2laxvK8iQ+3OUbooMNge9uJHuqBUZl4FvGGd88wrQFVLxn8auqulmwZLXvTit1Vrv1rQWCJcmRzG+Gh9C/sZAyiPkQ6oEKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hNFyfl9QLtx9I8sLcWsKy8xE61RO71yma3I1jDv1cQ=;
 b=ToJ3GuYCWyaC4PHIA3vZ9m+xlN+ksqc1xI0ex6pZPXc3qlhqS7fOAdZYnnt+qiXCLdeqI7ayWi4dGqfjTtzY0q8pt/4KNOtLjV/jRY0oH3pYYbF+odxtQ5IJ35bFNTKyjjkcvQXm/d3Yp3vRMDEHSol+BVb5lJyMbm5R9VOLkfw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 22:36:30 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 22:36:30 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Is it possible to corrupt disk when writeback page with undetected
 UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uCw==
Date:   Thu, 15 Sep 2022 22:36:30 +0000
Message-ID: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|DM4PR10MB6696:EE_
x-ms-office365-filtering-correlation-id: e29c5ead-43a5-445d-9c5b-08da976abbef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEsAgMAzk/PLRBLmhDfeXLguSkU7t0v9DN3RuHwkoTnIrq/sLSW8YUEAouspTi3v6fu8DwGmNmH5ZMRSy3mDV/ASjfx/lIjmz4kXU1Q648CdrUAXMGfw6KXckVRT36vX366Nj/9V93nrWBPavB2ue9qRkJBNSxWGRbBW2WFSSXsDYOqWz5mbanNSzQdEk0JkwH7TaNF4ZSmd/r3IEdYvlqh+UY6J+H7AzZarjAYGYbnSxZ2xOqn+wC8T6ZhwI1cDNhAEo7FlA8TUtRF7S2K0xagqS4xnjStL2j9Z4f1ewom7i7EW3PhrBg//13XXPr8inAsmX2ToH/YffJGZm+C/Q1lh1rBOv2Ws6i1NKp0n6DB0ATAxwMmGxhZzsdsEWBHkSO0L/e+2MMMk75zhxCX8mY6iA7f2f7TlamdzmmHD6C67UEDjE/C3WCf1N8JKXhbTubQZ+JjVcG3u1TGy7wc1wSS+1VJeIpWZ4FGKFNiQEvFfEnzSpRIs/HWrbBeq0W65nYrQPNz/jpDhkvn8EyiYX9g9zmaw96XOFOi1tudLUgAu4JBvaSh1eODUJWdWi+Q66QuUO/xGbVrXHpKdP5YMvQLpNS0VBgzm2zAt7APBU8ZGBpnfkWfgb/qF0z4TkQn1GjcskrSWJ3bzhIc8355x5R7mQBbl77Yap6qqNGtpuamLw9RmpTuPb/IYG6UDWzzrLXeRHjvSJtsr3zKaNBX5K+0xiuK/S//kp3nnxX0YX4R2kT1y0gCMJ/Nc8f5pGZ58b5AGfBkfLzQ/M6oIWwAXZf2Y9un/IK2V3CJ8+aWyPP0T67naos7bVRIxfaaZOkewC2TCvx1csnvjxnvHJla5fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(5660300002)(54906003)(316002)(6512007)(38070700005)(36756003)(110136005)(2616005)(71200400001)(186003)(86362001)(26005)(8676002)(122000001)(8936002)(2906002)(41300700001)(83380400001)(38100700002)(31686004)(4744005)(66446008)(44832011)(66946007)(66476007)(64756008)(478600001)(4326008)(6506007)(31696002)(6486002)(76116006)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHZrNyt4R2JVQkNFcHZlNGxtZVRkNzBVSC9qc2tJRzN2KzVrWWVVMkdxWjFn?=
 =?utf-8?B?RlZRQlljOXR6VGlMSHluSi9kRUNxWXpiNnA2R1NzbE5rNlVSK3EyOU9ZZWR3?=
 =?utf-8?B?L2JySVlCemVqMnlud2RYS0RKZUw5SGJpRTVhQXJQTmcvTGRmTmVLS3ZROHZN?=
 =?utf-8?B?RWVHZTViWWtVU3h0LzdzZUFBT2VzRTRmcStLSFRPaEJNWjFFSW9pQW1rNStP?=
 =?utf-8?B?UkxGN09ZQVVNSzVtcUVJTXFFMytmbHVNeFNCZmFSbGFCY0VJOGVMVk9ZNFAx?=
 =?utf-8?B?K3NPY2N1dDlyTWpZVFZMSWdWMnV6M29Pa0VUKzM0d1FWVmFPZDdjN29Cb2ph?=
 =?utf-8?B?R1ZyRHhma1B6SWFiWDJvVXZWSDFieWEwT2JUTGFWWHJvK2NmTDZ5UmJzUkJx?=
 =?utf-8?B?ekRTcnU1UFJWdi9DQUJSU1E1Y2FRcmJ4RTlpSXFJYndDVUtaY1ZMSFlhTmFy?=
 =?utf-8?B?NUNqZW5rTWxwWVV3RFlnbUVjdVZsNE1kYWVwYjBEZFVKNmJrd1c5bm03dE84?=
 =?utf-8?B?bGFXZXFTYkpmWlZKSkFmaVFreERqS3FHN2RvMjAyYWo1eER6RzhWbXh3cXIy?=
 =?utf-8?B?cGRTK0RSYnRXSCtSODhldWFLdWpDSjRBNDRwczVrQXBUeWN0SnlQZStIQjI4?=
 =?utf-8?B?ek95MGdMTWpUbHhIWHJrcHAzbklMT2xiWWREYUkvdkJ0QlZtOU5LdjhObDBy?=
 =?utf-8?B?VnVzb2FoeDdaNUpybkZxNzFmeW84UGprRGlHRVZ5ZTVNQnhZVzhoL0t4aU0y?=
 =?utf-8?B?SEY1WnR0V0NBa0Njc1d0T0RKUjVvNmd1Yk9HRHVHUWdsN05Qd2xISDl0aW1D?=
 =?utf-8?B?eitFanliUk4yM0o1MGp6VGxGQ1g4bDRYcTFQOUtVSDAzYkJsMVgwaFR5R0N6?=
 =?utf-8?B?b3dEWjM0UzNjU1p5N3VaaGk1VEdvVi9QNEpRaVhHbWJmQVplWEpGVUpPZ1F2?=
 =?utf-8?B?N1FVODFTcnpCZUk5N1pvbW9qODh2WTlrSGgvRHMwalloRGJkYXVpMnBMdnNw?=
 =?utf-8?B?cHBtY0N5L2pjL3BNOVM3dUlINTVab0s3NVp1VEduaXVFNlI1R1lHckQ4SmVX?=
 =?utf-8?B?bmJhYUl5MDRIN1JFemh0M0MrM09WTmQwSmJyUkp6ZVUrQmhRRW9nQTcxcHFR?=
 =?utf-8?B?NE5HbE5oT2M3NlZiMHRjeEIyVE9QQVlNK2NrcWVyU1plekM0NThUMWxEd2RS?=
 =?utf-8?B?Tzg2V1BKR3RkTW43K3p2QXgwYXVGV2pVUFdxUEw2V0N3TzNiM0t0R2V3ODhu?=
 =?utf-8?B?TDVldzBBNG5haTdtN1htckVaUFc1SktvVlZkalB3MTZ2VEVrUGdXV1VOSjJE?=
 =?utf-8?B?a1lIMUxuYXc3QkRINms3bEl0ZW9uWEozT1k2TE90L3pQV1dHY1JmbDVvU0Ni?=
 =?utf-8?B?MjZtN05mbFJFV2piZmJDcE81cEFGYlRYdFNXdUxldFlnVW55K1dVODhyM0o0?=
 =?utf-8?B?b2hoVVhFMkZGRGtIaStESDN1L2pyb0twUTNjVWhhMHR4cFBORC8zTU5TZlR4?=
 =?utf-8?B?N284bFI3M0thVmhQWjhERmV5Yy9lclNQcUNIaG42OXdIeVc1d0R6dlV1OGdD?=
 =?utf-8?B?UURnR3NEdlpRbG8wNEJvdTFDdUczbTNzaWdSenpLNzBMZ1hYV2p5RzIyUkJa?=
 =?utf-8?B?ZW1JSHd6TjJpUXd2L0xMSUJNV1J0U0I2enRkZkJLOURUWDFBdSt0cEcwZVBO?=
 =?utf-8?B?aG9OLzNGckFZbHozUngyV0Y1aUZBakk0OFhOVUYwakQ2R1BkY2RuZEhtekpG?=
 =?utf-8?B?NSt5N3ZTWEFwd0xMMFFIajk2aG9KOTl3K285cmI0aWVJakNwcUJ2Q3lYWGxv?=
 =?utf-8?B?bGVEMlVmWUZ2b3N2TzJ5cUgvNHlxa0JiK3Izb2lEWXhYQ05rb1FodlNWZmgy?=
 =?utf-8?B?b0hQcU03MFhzaU5uK0NwV1dtNjlkQ2RlZ3ViTVV2Nk1iTjRBMlBabzZZcTND?=
 =?utf-8?B?S2REdlhEME5rcmRxTk5uRERvUGViUjNaMHVNQUhTVFhOQmt3WkV2d1BrNWtG?=
 =?utf-8?B?aWptMWVPekYxR3ZZaVhlaU9xWW9OWTg5RHE5d0ZtUHFUbUV5dVJPQ0dxMTJO?=
 =?utf-8?B?NzUzdUlFdzY0VXlCSnh4aU0wdGxnNUZsNUhrU2ZzVkhZQmg2eks1WEJUeDV0?=
 =?utf-8?Q?bt3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C1CD456B16D56429C367CF7964AC5AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c5ead-43a5-445d-9c5b-08da976abbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 22:36:30.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2Gh+J8RQQtT0fDFuG6udOrnqNV3ca9ccDbHTpkkzAFmmLSOj0Tj9qhhQD0AuVD7ZlvFYY7uCpLIcIGJzAbRdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=941 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209150142
X-Proofpoint-GUID: 4dvnpTQeQXdrWplsPJc_C-cTo5BOhBQL
X-Proofpoint-ORIG-GUID: 4dvnpTQeQXdrWplsPJc_C-cTo5BOhBQL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNClN1cHBvc2UgdGhlcmUgaXMgYSBVRSBpbiBhIERSQU0gcGFnZSB0aGF0IGlzIGJhY2tl
ZCBieSBhIGRpc2sgZmlsZS4NClRoZSBVRSBoYXNuJ3QgYmVlbiByZXBvcnRlZCB0byB0aGUga2Vy
bmVsLCBidXQgbG93IGxldmVsIGZpcm13YXJlIA0KaW5pdGlhdGVkIHNjcnViYmluZyBoYXMgYWxy
ZWFkeSBsb2dnZWQgdGhlIFVFLg0KDQpUaGUgcGFnZSBpcyB0aGVuIGRpcnRpZWQgYnkgYSB3cml0
ZSwgYWx0aG91Z2ggdGhlIHdyaXRlIGNsZWFybHkgZmFpbGVkLA0KaXQgZGlkbid0IHRyaWdnZXIg
YW4gTUNFLg0KDQpBbmQgd2l0aG91dCBhIHN1YnNlcXVlbnQgcmVhZCBmcm9tIHRoZSBwYWdlLCBh
dCBzb21lIHBvaW50LCB0aGUgcGFnZSBpcyANCndyaXR0ZW4gYmFjayB0byB0aGUgZGlzaywgbGVh
dmluZyBhIFBBR0VfU0laRSBvZiB6ZXJvcyBpbiB0aGUgdGFyZ2V0ZWQgDQpkaXNrIGJsb2Nrcy4N
Cg0KSXMgdGhpcyBtb2RlIG9mIGRpc2sgY29ycnVwdGlvbiBwb3NzaWJsZT8NCg0KVGhhbmtzIGEg
bG90IQ0KLWphbmUNCg==
