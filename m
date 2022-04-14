Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BAC50032E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 02:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiDNAu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 20:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiDNAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:50:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A033EBE;
        Wed, 13 Apr 2022 17:48:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DJswvo008887;
        Thu, 14 Apr 2022 00:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XSEOkrzjPmyOiIpidfvVn5gV/Q1FZemBGzD3DJ5rujM=;
 b=ev8bUFaHOTW8KschsU9oYGEi242dxWXnAVSvHnZjsGVvqatGb30Mu232FvaY0lbYNw8Q
 PrJJPm/AFKY/YaaZ5ZMbrB8CCr/KaeJ2fxiEwOoTe9g6cIHAGVU+xtPufVVrnAX+uqbP
 cBmkh1TBU1BNTp6cTyW2hR870Fy3Yr9WGGux+wJVZPiLHJ6MaTtJUL+5zCeeGluX+yx4
 4G+q0f2MwJcId9jlbBOtN5Mt3Jv76gcbyv9+asbJtLJi3K0OTvMFA8aKEq7g0yXD0mQ0
 b2PiLWR85C9Dw1IDxTVIAh0Gp7jS/4WRYV+B5xZpGij8G0lkANqaClXX5lCJ7jHx87/v HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2kg1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:48:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0jjAi029530;
        Thu, 14 Apr 2022 00:48:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4j843-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw2ABw7EHQGVRdGAdGtswbLh8J2JaOzOSrQGYyO6I8/mIfTTyVtOerN2sZkLdzwiHMUYsLUivDXJa8jBlPM/hgjBU1Pib64+95obcwPCzSVWIAW2gEZiuhxATOr42yZShs27dOQroa+475M+TU/tloF0aVA7FoIBHQ4IISmbEGYwm8bwPzVmB5xShbr8lKDKQetlfpDLhKVKzFEgsVtaBx3Bx8je9N18aF0dX72kavgqOo0nvesTCptbUS5ZtWqOl1ox8NcuAmV32x37Nw/bA2qW27twgTlTjiDLo6xkBmHSg8NjNU+fqHeX3t/GdbgfxeEyqhRd6Ta5LY7j0KYpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSEOkrzjPmyOiIpidfvVn5gV/Q1FZemBGzD3DJ5rujM=;
 b=h/Vu+kjQXDs9J068m/JtCeJx2zxLyMcYOKb5MtmSShGml1woYTGjUxEUk9No84+f+uBMTgyOMZLmfsjF+SZGSYTegm5G/Cm72Z5DYiiAtpasPfBXxeB0iqvMovXB2vzUM5Tu0i8w6Gk4nr0HlbeKWmISs/EHveNZlka8TDWOS4mIiSo9KbvBWD2D4NgRT4Y4q00+g1IFWt8wOOSImor6P3FwPqXyzWhnLLti8DLjtH3rByEiBvZlLxSLd/NV3OO31s/s7rVffZ38xa2Pv7Jml69PmLS0nCHnum741Rr3+nBqgylVvtQHNcnp2kYfx46u8S8BKCa/agYaG/fiz0EIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSEOkrzjPmyOiIpidfvVn5gV/Q1FZemBGzD3DJ5rujM=;
 b=i59Yb/3XaIrtCavi2IM7Ftb8pbBBtRzwo+bJftMO03X/rEv3HazA/iFsLoXmfcLiRDiwUI1kOYM46Qih/2rV9k/+g1uCtyqZSKOptFBYVKWwlgbI+mKnsHyqBbECxF0ERPo+ngEIgQmOXowQbGdOmVpqk/PZ1ccfCPGifJxr9d4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 00:48:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 00:48:16 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Topic: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Index: AQHYSSYdGKTdETDbkEmdZR/SZY7Ic6ziWZ4AgADMqgCAAMiFgIAHfkcAgAMzRYA=
Date:   Thu, 14 Apr 2022 00:48:16 +0000
Message-ID: <847e8c8c-f1b0-66f5-f3e6-e2f6c618a80f@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <Yk0i/pODntZ7lbDo@infradead.org>
 <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
 <Yk52415cnFa39qil@infradead.org>
 <CAPcyv4gfF4AhxD_vqCS9CTRraj8GAMDYQ7Zb411+FvxhF4ccOw@mail.gmail.com>
In-Reply-To: <CAPcyv4gfF4AhxD_vqCS9CTRraj8GAMDYQ7Zb411+FvxhF4ccOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b24623-b346-44f1-0d2e-08da1db07646
x-ms-traffictypediagnostic: PH0PR10MB4405:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4405F19EDC15B9B9768E395DF3EF9@PH0PR10MB4405.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xq7wqbKyEHG4q8Hwcd1ym+f3nnettoT1nW88LObICDIbKmQMmvyiVtPDpiO0sSfHMZp7o5TIh9SNLkV60Feq9GN0LPpnsLWJP6DlZl3dKcRlKG+o018qYgjo57ZzZjUlEwCQ/i0mDtNS+BgOSN4sfyMIJNcCgb5sdFHk/I2Hp22W7i08/ExSUAt9GBgSfnKy9IDhPlhCHvro/ppBl23GQ+107Glbz1ZvNgf/v4A/LJnVGzGPifqMkR1tI7F3sa4QJ/a4XMTUR+Vf5YzRsKOKV3r66fMuamxDsIRaxjk0vtgOSKrunjor19PwLvqxw4l5B0sBdpLC0zDJIbBtwF8WS0MmDoAOpuMTVDpPC5/KEZcMa+qgFj/6ldBtGXhmOLxqGcd1gSVuhxn1FFFidYIH6+EdKqtf0ZKaYgaxyPGTqxc2rzQaqlfjsF12+VsGpnuRGq2Vo/7KbG+/y5CWFJ4JNcoR6+5U0MhOF3ef+CMxMN9w1A9Uj+RNNhC3eOX2KblSQsWWT6GO3QdWmO1ank15A53D00+4l/hK45a2J7Yp9qPKiqAlopuuyPMclK2sShjXpk86KXLhYHm0fdfxJdker3cDs4T1ii5xmNX9/z5sex4Jx4XvPpvcnz+g0tcKYoeKuYxVb1fa2TCMP+NW688EBiqtN71+/raXcVrcUY9bNldGfDAn19lodSt5/hSNjZYp8Z/NqgpxgKdb5nd+sf9vUZZmd2kQ6uowPztIuEMY3DT3hqDBpnbXprNEF/UtyRjMIcYmlMC51eZwmrk7D9j+2aIAIkm4dTAVEpdbOV37H+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(316002)(110136005)(54906003)(508600001)(53546011)(8676002)(4326008)(44832011)(38070700005)(66946007)(122000001)(91956017)(76116006)(36756003)(31686004)(7416002)(38100700002)(64756008)(66556008)(6486002)(66446008)(83380400001)(71200400001)(5660300002)(26005)(6512007)(2616005)(186003)(86362001)(6506007)(31696002)(8936002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dllCVGVMS05VdXM2UEhmZFJ2RVR6WUFTSDl0T0RnRXJlNUpOVCtLRkhqWlhM?=
 =?utf-8?B?Vmh4UmtmVE1hOTRJWFZiVUszNXRmc3lHM1E0d1N5Y2RvdDZsVXlnbVE5YjE2?=
 =?utf-8?B?VHhvR0FwWThMUys4QnVmVmdBaXJTSWQ0TUYwUTY4eVkxc1NXNVRoKzRDTUhw?=
 =?utf-8?B?UUxXbTRlOTVZeGpMUFJZMktnWmZ4aE9qZnpCek9BclZ1aUhPM1BpOU83cjVp?=
 =?utf-8?B?KzNzRktnQWgxTGh5ZWswdC9BSFJTS1VQSGVTZFIyc01kMTNqbkVtcHVEWk1l?=
 =?utf-8?B?cHV2bjBldHhjcTRxSlF1ajBaWERlUDFEQlBRbDlnT28wS2t4dkxlazhwWDJW?=
 =?utf-8?B?YnJVQXh3SFVxcHpIUC94V0o2cGVZNUo5MUZwcnhxbmw2TlpnQ2hEVEhvK1Nw?=
 =?utf-8?B?MjA3ckVDa09lKzF6MU9TN3BYSE9EZXpiKzRYNEhKTFhtbjZJaVhrWG52d3d2?=
 =?utf-8?B?YS9YTndMSERqVlEyVG95blRLQmMxM2ROdDdoS1ozY2xFa243MCswY2JjSVpW?=
 =?utf-8?B?K3ZhN3pXblhQUzRVRmdreG1sdnNHemllRlRKamZjWlE1TXBPQXc3VTFybjR1?=
 =?utf-8?B?MENsM2RrR1JoWm9EWk9wUjMxZTFnRklhb2crRW1KcjdadDl1Z2poWFRJY242?=
 =?utf-8?B?b0tRYk1mQVU2MVNkSzF2ZXhNcGNTVStMU3o2TmhlQVlXUUNlWVhXMXNXWmk4?=
 =?utf-8?B?MjdNd2pub0M0WHh4NzA3SitXWEppUUloK01XeUZOR09LV1hyYWwvb3huVk1Q?=
 =?utf-8?B?VW1nK0k1aEVKbWgzd204QisvM3BJOUVXVFVSZy9vV0UycGhLVzRYNjZlMjlP?=
 =?utf-8?B?MnFaWUNISEtkWjBsaUwyMzN0UVlKeHVmMEJkeGFjeVZrTHdZSTN6c1d3RlBI?=
 =?utf-8?B?MEU4OS9MRks5anhLY0FzNDhSdktzUk9sd3hDbXFISVQ2NEFQR3ZVVkpEK3hY?=
 =?utf-8?B?UUhUUjNvRitrVzFvWmJ0dWNEb296WFJ3UVpybEVYWXh5ZnlBckIycnZxMDdZ?=
 =?utf-8?B?cFpXeDhpWnA2bUU3Wm8wbVpkTWJLa1pXdk5pRFVyT1QyMm9scldqOUMrZWl1?=
 =?utf-8?B?WXpybzN0V3JZYXh5MlRTcVBIWWc2MzlCMVVoazd2QXFEUUxIbk00TENxVjBk?=
 =?utf-8?B?MXIvdHZZRnExMlkzWDJhdUs2MlRIS2R3OE9EYldBdXFzTnlSb3hjMDdNcEh5?=
 =?utf-8?B?WGtVUkc5YzVOMnFCeDdKb3FheG0rQnFLSGNMRWl6bmZLSGk1U21URU5UdlFx?=
 =?utf-8?B?MXY0UVFSdjdENE02RFdYdDR1VVZhZlJoTXZVeEt3VVV4VVZIcmhJaXIrclJp?=
 =?utf-8?B?Z1JneFpFV2pCdjFqZjltU2cyT01pQUthd3dqdUJ6SDlwak5tN0RSU3lLTDls?=
 =?utf-8?B?Q254amMwQ1NUam1iNmNJZ0pXQnNXdW5mYmV6N1ZPOVVVT2w1eFVsVGY1OC9B?=
 =?utf-8?B?UmdyMExhd3JCMWdmVTE1SGZwelpyRGRnR3MvZjRlSk1wNHcrdEVrKzJmU1JS?=
 =?utf-8?B?ZXFoV1N2NkszSVlvYmVRQThndUYza3pxUUFGRHQ4YkdTd1pGK0pBU1hjWVFG?=
 =?utf-8?B?Q1J2VEZDemVHWW1UbG16dTllOS9xY21WVmpQK2UwdFJDVjJxUzlMeTYySEE5?=
 =?utf-8?B?Q1Q5eU9LSkpMWXBaWUlGZ3VIZG9LaWg2Y0MvODFUT2Z6N2ZheWpSUDV6TUNJ?=
 =?utf-8?B?SjdWeWhaNlA0TW51WHJNQWY2enBXK2haaHpzd1VJcEhpNWxORTl0L3VYcnVR?=
 =?utf-8?B?cUtMNERNdjRQUEJvTzZ0SkRLUTNoUzFsTXl3WDNoV2dGaXYyMk1tSzhXbVNo?=
 =?utf-8?B?b1VEeC9FckZ3T1ljSzFhNnJTZzNYSmRkK0UzbW1oQ2E5TkQrVG1zemtobXhj?=
 =?utf-8?B?Z0E4OUFrcy9mblo5cU50U2VsT3NvbStmWVRGN29seXpGSi9VaG9veUc0ZEQr?=
 =?utf-8?B?RFRzck1JUVRIQzMrTkJibVZWRWJJSEdlU2Vkdkt4R3REWmo5UC8xQXdraThC?=
 =?utf-8?B?aE8vOWZNN1R4eFhhUWR5VUZFMmZ5RlhiNTlVN2JCVGJIZlY3RkZjR1F0U0Jo?=
 =?utf-8?B?aDFseUlhQWtCeU1oMTh1WnArVUVWWk1BZjFMdlc1TDlWWWl5akZWOEZxOGd2?=
 =?utf-8?B?OXVITDVZVGYrcWJMdGltTU40U3YzL0xKWSttY25LV3E5YmRjQStkaGFIZ0I1?=
 =?utf-8?B?bHFDYlBzUGRIb3FCajNlZzVZMWxDSHVzaDYzeFBCRmtuSy92VVBkdmRTeVBR?=
 =?utf-8?B?TzE4T0JrU1BvYTljd2dQOEtQVXhTdnJzZnZMRVdFZ3Jjb2ZWUTJhMWFwQUl6?=
 =?utf-8?B?Z1ZDSU40QVJwVkNoRWpxVFNMNEE0d05Uam5oODY4S2FSRVB4aGxmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46FB7D45E8232547ACBE1CBBA1D922A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b24623-b346-44f1-0d2e-08da1db07646
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:48:16.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBaOIX5f9JskLikHE361+BGpqS/6pXMwrSiyqFtSopS9cf+vSOpGJg6gLAMonrtlrr7N5lTHGaZID6QAEaTo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140002
X-Proofpoint-ORIG-GUID: qKzhcPOl-uemzjO5tDvx3i60cLJkwczR
X-Proofpoint-GUID: qKzhcPOl-uemzjO5tDvx3i60cLJkwczR
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMS8yMDIyIDQ6NTUgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gV2VkLCBBcHIg
NiwgMjAyMiBhdCAxMDozMSBQTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+
IHdyb3RlOg0KPj4NCj4+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0IDA1OjMyOjMxUE0gKzAwMDAs
IEphbmUgQ2h1IHdyb3RlOg0KPj4+IFllcywgSSBiZWxpZXZlIERhbiB3YXMgbW90aXZhdGVkIGJ5
IGF2b2lkaW5nIHRoZSBkbSBkYW5jZSBhcyBhIHJlc3VsdCBvZg0KPj4+IGFkZGluZyAucmVjb3Zl
cnlfd3JpdGUgdG8gZGF4X29wZXJhdGlvbnMuDQo+Pj4NCj4+PiBJIHVuZGVyc3RhbmQgeW91ciBw
b2ludCBhYm91dCAucmVjb3Zlcnlfd3JpdGUgaXMgZGV2aWNlIHNwZWNpZmljIGFuZA0KPj4+IHRo
dXMgbm90IHNvbWV0aGluZyBhcHByb3ByaWF0ZSBmb3IgZGV2aWNlIGFnbm9zdGljIG9wcy4NCj4+
Pg0KPj4+IEkgY2FuIHNlZSAyIG9wdGlvbnMgc28gZmFyIC0NCj4+Pg0KPj4+IDEpICBhZGQgLnJl
Y292ZXJ5X3dyaXRlIHRvIGRheF9vcGVyYXRpb25zIGFuZCBkbyB0aGUgZG0gZGFuY2UgdG8gaHVu
dA0KPj4+IGRvd24gdG8gdGhlIGJhc2UgZGV2aWNlIHRoYXQgYWN0dWFsbHkgcHJvdmlkZXMgdGhl
IHJlY292ZXJ5IGFjdGlvbg0KPj4NCj4+IFRoYXQgd291bGQgYmUgbXkgcHJlZmVyZW5jZS4gIEJ1
dCBJJ2xsIHdhaXQgZm9yIERhbiB0byBjaGltZSBpbi4NCj4gDQo+IFllYWgsIHNvIHRoZSBtb3Rp
dmF0aW9uIHdhcyBhdm9pZGluZyBwbHVtYmluZyByZWNvdmVyeSB0aHJvdWdoIHN0YWNrZWQNCj4g
bG9va3VwcyB3aGVuIHRoZSByZWNvdmVyeSBpcyBzcGVjaWZpYyB0byBhIHBmbiBhbmQgdGhlIHBy
b3ZpZGVyIG9mDQo+IHRoYXQgcGZuLCBidXQgSSBhbHNvIHNlZSBpdCBmcm9tIENocmlzdG9waCdz
IHBlcnNwZWN0aXZlIHRoYXQgdGhlIG9ubHkNCj4gYWdlbnQgdGhhdCBjYXJlcyBhYm91dCByZWNv
dmVyeSBpcyB0aGUgZnNkYXggSS9PIHBhdGguIENlcnRhaW5seQ0KPiBoYXZpbmcgLT5kYXhfZGly
ZWN0X2FjY2VzcygpIHRha2UgYSBEQVhfUkVDT1ZFUlkgZmxhZyBhbmQgdGhlIG9wDQo+IGl0c2Vs
ZiBnbyB0aHJvdWdoIHRoZSBwZ21hcCBpcyBhIGNvbmZ1c2luZyBzcGxpdCB0aGF0IEkgZGlkIG5v
dA0KPiBhbnRpY2lwYXRlIHdoZW4gSSBtYWRlIHRoZSBzdWdnZXN0aW9uLiBTaW5jZSB0aGF0IGZs
YWcgbXVzdCBiZSB0aGVyZSwNCj4gdGhlbiB0aGUgLT5yZWNvdmVyeV93cml0ZSgpIHNob3VsZCBh
bHNvIHN0YXkgcmVsYXRpdmUgdG8gYSBkYXggZGV2aWNlLg0KPiANCj4gQXBvbG9naWVzIGZvciB0
aGUgdGhyYXNoIEphbmUuDQo+IA0KPiBPbmUgYXNrIHRob3VnaCwgcGxlYXNlIHNlcGFyYXRlIHBs
dW1iaW5nIHRoZSBuZXcgZmxhZyBhcmd1bWVudCB0bw0KPiAtPmRheF9kaXJlY3RfYWNjZXNzKCkg
YW5kIHBsdW1iaW5nIHRoZSBuZXcgb3BlcmF0aW9uIGludG8gcHJlcGFyYXRpb24NCj4gcGF0Y2hl
cyBiZWZvcmUgZmlsbGluZyB0aGVtIGluIHdpdGggdGhlIG5ldyBnb29kbmVzcy4NCg0KT2theSwg
d2lsbCBkbyBpbiBuZXh0IHJldmlzaW9uLg0KDQp0aGFua3MhDQotamFuZQ0K
