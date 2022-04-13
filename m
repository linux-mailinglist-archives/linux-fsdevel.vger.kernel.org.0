Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084FD5002BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 01:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiDMXoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDMXoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:44:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C874614F;
        Wed, 13 Apr 2022 16:41:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DL9MQ1014133;
        Wed, 13 Apr 2022 23:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bv0IWhCAia5vLj6tn1EKAkQndm2cEdccBBo/oi2sBXo=;
 b=GcetnCRgWZfMD74rAI2Nibive9cMztvckMrGOOVkUQ6oyGMDlasHKaudVAtv1KlShYV2
 dDZJ21b+t98f+4cdwNpy6yE4GaI4Pecza/lSc1HUvBUYmCgt/xO6oDoVVtatr8GtV/WD
 xPFKzYxsb2cPhItQmarGS70luFPR68rB+SXoVejRWBlJmutzTU+9KF6g12Mu5gQaAkwm
 UBAshLuujOg/+71KXSOvs1kcpQzMyjd6WngA59PLvnNEQ3sHX9zLKpetIMDsc4kqTJ98
 1ZKNwI683Itp1lT2Z9mVZ69BDnd56cBay4IXEyjyFn6SY/ANmstjk0bhmz4zHnVyIlXd OA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu3mfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 23:41:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DNfMbP031007;
        Wed, 13 Apr 2022 23:41:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k48x2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 23:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3iltliLf5CTqQcWfRzs6MNJLPrf3qzHRj45AeoSiYx9aRsclogX3oRbGH5UueN/lNAALOmQk8gU3ghWEYT60u6l8UZVtk8tnYNH0XpAudZY31q8vinXrJ162/OPsV1xOc0eegf/HGB2iMlqBhsHKgiXcu6kWyEILTPzvNEYZ4ikBKGB3OD6ISTzVk7rFQfk9zWCAsmhhDuWunJRd/z5Io9dGsYLi8XQ1nK8HMbwBTqK1/N+GNdxrpB1hn7jDqNxmnz4y+izwnff1/4VSiqSanGIcB08ae8u6dm3pwF8n1bLH0dH8bBqEALcl1lU7EdN0vm2kT9Z4iyXMnbHprqcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv0IWhCAia5vLj6tn1EKAkQndm2cEdccBBo/oi2sBXo=;
 b=XGkMn5nrrIAPmZrq7YALRbJd0KLv2bGkwvrXRVS/AbLEqizH+reIT0hB94woHa/H8GFG4XDaqj5TFSwVr2jP8+jz21M/0iANnAhiNhiK2f0osCjQ2smoh0rXa52l7Bqb2Y9UcHJWtW5Y2Ia0dqpQXqT8k+9sjxCXjNd1ROUu474kVi0WwGq5oLu45p5SA5Jw6fweVhUvgn0aYXLdojROhun/IzqIfCD3VHzDUkrghtkND/V2KAbXMiJmXXEXP7mUcaNJ9BjErhyjmLIvlbPvSoLje66jWsRhwSHF+a6lns2f2K/ABWECMgMZ3weAas23oI7aOn866tZqRpSkww1P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv0IWhCAia5vLj6tn1EKAkQndm2cEdccBBo/oi2sBXo=;
 b=YYvg2ajjSBNzQHoAcNoZyb55o3FCCtaJ1zzK4Z56cvAlLFBsZoCBb41cH8Tfz70Cx9uSaGlFXJJXelRThjazPwuDWs/O9bBTS/1TFgcSQOn8QPTbeZZEUj/ibUFZqil7TLVyC1lADsbTMAfWUupd2BHn2jSgR+IdRdwckqh2xjI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM8PR10MB5414.namprd10.prod.outlook.com (2603:10b6:8:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 23:41:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 23:41:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYSSYcmxaMmXFgxUqypAmHkAJB9qzsGAQAgAJ1oIA=
Date:   Wed, 13 Apr 2022 23:41:18 +0000
Message-ID: <7ef7960a-d505-db5b-06da-96f60c24113a@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-4-jane.chu@oracle.com> <YlVPcrK4SSXyPx+Y@zn.tnic>
In-Reply-To: <YlVPcrK4SSXyPx+Y@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de0b4b5-8f69-4334-d982-08da1da71b9f
x-ms-traffictypediagnostic: DM8PR10MB5414:EE_
x-microsoft-antispam-prvs: <DM8PR10MB54143FFBCF7A1087909978E0F3EC9@DM8PR10MB5414.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XAF7UPikyGZ7mNwSHEK+DkXuHXLAO8edGeCHBr/CF0i08xRDHUzQT925X4BcBxqeWnXo2i3aQgpO4uHB6uCCyFFiduv/m1IB3wrOkeC3XWKxjI+mWxHd2BxW7gpGwydgEM72BJGsTB5PhfXBkBhpYO+GU5PMB/DZByuTN884AGlSlC05bSOyP1xJeiYw0YEgrgTWLYm+fibr9478LA7ZCyV6ph1Yj/ObHIuvpGTeJEN31WODnE3OiS+RRT9OJDzghEUH4SiyAoEeyAhwk/1h/vtdTC2xq50GE5Xz6clKvSxKz4jBlh5RgbWMxtv4vf+u2W4WhABivpNymu8/g8sc1ZITcKTwMlNlPGfjEyoYHd8Q66rrsJPEzamXVjCCzepODhWF++0jxCkAsfIMK+sFZIcwtRqlxXEO4LUMdoxIivoYppkEGzo7Qc/ZhswIVPXHMQ9u8YgJtzxM6+KUHhED3ily/wbcI4m2eFXpehNDn/KZRzA9MQEG+q4gDKoeN3IpOOg/iduIOCcS1JDY27Sj/SZS+iYgS1CJNsZOvNRG4VfmKqcIxYC3z0hZ7sfz8Od68QuVaDx5BS1aQ0MCiGVb4Xh+g3JqGhkaCxZdu3E//vWuHrQdSztCjCAFEekZvbqQbwPimeenZJnm4EL7c7UvPg6Crwzdg84BqmLVKJT8x3akkHF8cPFoaAoBbZD7PlvO/PBMoF9cijT7sNVJH43o6bcmzQh6hazS8vqV3hP7wO0bWpbGseQB8rxx9BtG8QQmdQ9/2W8LeBANqjt5/DIAGuEuU/n9/sKSZFxTKhLS0Jqk7jg+Ceuwme+BH+PQ3Zgl/MnrnKvWyUjYF0N4d7FsQUcDMcwjMVhbG3ap4IJSgU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(31696002)(66946007)(91956017)(26005)(186003)(2616005)(6916009)(122000001)(54906003)(86362001)(8936002)(7416002)(38100700002)(83380400001)(38070700005)(76116006)(31686004)(44832011)(36756003)(508600001)(6512007)(6506007)(71200400001)(8676002)(66476007)(66556008)(66446008)(64756008)(4326008)(966005)(53546011)(5660300002)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THBhTStoVjBoVVg2WlJIM1hDQzRwekNRc24yS3pQeUQ0bzRQNDFnNzM3WmlV?=
 =?utf-8?B?ZG95OXExVDE5aXM2K2hvWVNDckVMcmRZN1B3V3E4WkcraUpCWUlrdnYzMnlP?=
 =?utf-8?B?cWR0S3BwZ2xhaTM5SGx2SHFqQ0JGMUJjb1JuRGhPZndHY0RJMUE0VFVvYkR4?=
 =?utf-8?B?a2I3Wk95WHBCeWtydGp0K3RLRGtSeDJSb2wzZkxvSVJ2Vm5tRlR0NzJjazVt?=
 =?utf-8?B?bkdSODdsazAyNjVWTVVZZndQODlUZVcrTXZucG54bE1MWDJ4cEdZdS9rQ1Jv?=
 =?utf-8?B?ZFVBWXk1S0hPY1FQT3NpLzh0WG5RZmZuRWg5MjFkZXY1V3F6OG1LdU5aMVpn?=
 =?utf-8?B?L2REWnBKdkFMUE1lWlZsRzJuellWN0FlT2FpOXUxNXZZQXZkZ3V6NlBIMEl5?=
 =?utf-8?B?RzlTM003VU40NDdHbXYrcDdXbDd4WkNYSWw2TktmM0hJbHN5UzRFWmNBNlJx?=
 =?utf-8?B?SWxQSENoWjJrbWxIM3BHRzlQazdrZjhnYURqRm1YZFkzcWtwaWNUazI4clVt?=
 =?utf-8?B?WVpKRVBsNHY4MGIxZFJZU0FVemNZWmdibytGL0sxT3YvTFRYdk9UbE55OWRN?=
 =?utf-8?B?ZzVPMjBZRlRiL3NRSE5QcDE4VGR3ejBJVnZiTkFDZUd2bTYyTUd6MGt0UWlI?=
 =?utf-8?B?SEwwc0pvUDNtN3hxclRnbFl6S21SMXVpdkYvYmRNQXBSUzF0Q0xiYlFhSnNz?=
 =?utf-8?B?SU9wd3BzUjZRaWRhb09wV2dEMkFjZlJaalA2YXhOWWNDd010VkpRanN2UjJ1?=
 =?utf-8?B?Ynp6dm5WdnZwSjBMWkhQbGRwRDUyTklFcXYzM0Y3cEFTMzc1TGk0MGJUMkpE?=
 =?utf-8?B?WEd0eGwraXZnNzk2dnZLUmZodzlWSXZ2WTVpOWk4SksxSkdtdlN0WGR0NDBr?=
 =?utf-8?B?ZlVGdTFqRTZyYXFiYnBpMGdLOVFUT2dadFQvSGt1djNsVXU0MHBNNmlmUW9r?=
 =?utf-8?B?czl6VkR5K0ZWUWpMS24raHlyVS90LzhucGRuTXM2Y2x1bENoRlRRQmRvRjBW?=
 =?utf-8?B?c2JCc2gyaFp1Ykl2TlFtQlc0RkJJamJ1aHFXZUUvVWxwQVc4ZXBLSmdvWENB?=
 =?utf-8?B?WUdTRGU0R1RIU1pwVXoyYmhObkc3b1ZtRWxQRjk2NFE0Qzk4NGlqOEZaWEtH?=
 =?utf-8?B?UUxTakVIK29DNnpjaVlLbHZNSFhPOFRVVlo5MGJOcW1CZm9nUUxLSW0xTE1a?=
 =?utf-8?B?MW9zdXpTSmM0WmptNEtBWVVqOStVS0hHdUdSanA1ankrcFFoYVlHSDBXNTc3?=
 =?utf-8?B?dGZOQ3ovYXNFSkVRRWNmRGgySG1YeVhXWk1TcDdXSUd3dFg5aFd5ckEwMTJ0?=
 =?utf-8?B?dUdjUDFTS2ZtRTVweFBGT3BTeTUxKzFLYlBtVUdqdlc5U0JaNjM2WXlpa2xD?=
 =?utf-8?B?TjNPK0xnVVFaVDQxYUJIZkFJeWxXM2o0WXlwd2hsQ3BJckRRbFBKTzBSdTlE?=
 =?utf-8?B?eVIwQkp2NG81TXFmN2taU3pzNHM1Sk1CWkV4UzBpU1gyU0VqU0FoN09PQlpH?=
 =?utf-8?B?YXJITHh1QWlZYWpJYXZueDRENExiTVZoemFJYS85bmtFSU5YcG5CZUFKVlJo?=
 =?utf-8?B?b1d1dUNndWZSbjViT1orZU9SVGZ3UGFSYWR0L0QvYUgvd3VYUlVTdjNScElt?=
 =?utf-8?B?eFkxU3JzK0JLQ09ZbEp0WE9JKzF6b2t0V0loT1M3eGJDeGt6WXpOdXZKcitQ?=
 =?utf-8?B?NXNTRitFazVOdHlLSDlaRS93NlNYdzBudG5GcWlOK1pNTGsyUXYwYWxEeVNz?=
 =?utf-8?B?ZEUzNG40bFRiOVhDVTc0MDRnVU15NEtFTjNkSHl6SnZqZkNKWUVMNkdicW0z?=
 =?utf-8?B?S3pLVmEyODlZTW15RGRWaDVYbTl2UVdCRWhlWjBhSWtyYVRoKzZHR2xIa3E2?=
 =?utf-8?B?b3hOTHljdUNRNW0zbWsvRjdMMDRnR3BPTzcxT3ZnR0t4dkVFQ051dGZZNldL?=
 =?utf-8?B?TGRUQldTSXQ2YmhweUFzRzU0RzBuVnJ3KzNsbGpZaElrYkh6MEJoUVVvcVBn?=
 =?utf-8?B?eHZSenhYNyt3TlR6d0ZFdWJNSHRQd044V3FXK3JWSFBCd0MzODlPMHhiNDh0?=
 =?utf-8?B?clhrSDBmM2lYa0J4QU1PaUwzUHJ2MGd2a3pYeG1wY3VYdGMrNy9pemFsbThD?=
 =?utf-8?B?YW1DOEhEdDhORmphSitKR25rQkhlbE92T082MXQwT1plOWFCa0MzeXdhVkI1?=
 =?utf-8?B?VkcvTDVJUFJQL0l1NzFrYTNlU1BkZXhiYWN2d0RKblFQRW1JeWNPUHgxMVo3?=
 =?utf-8?B?QW9RS3EzaGt5cG8zOU9OK0JiWWd2bm9rcHhua1ozOUVYalBpbTJNWStqcW9E?=
 =?utf-8?B?ZTRDbXRsTVQrV1Y2MmhLa0RoNXhEYXBRODM2eXNoN2RiK0NtL1ZYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2871F7C12A925438730E545B80E9E41@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de0b4b5-8f69-4334-d982-08da1da71b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 23:41:18.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDSW1h6WHDLyRtmI5fviECIbGGZvZXtS1QkFCtV0upouMyBcBo6KK+Wdsr/sVUINfKqG5Zsb/GwYdFFRYd4i7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130112
X-Proofpoint-ORIG-GUID: MFpFY46T1w738wfpAPyoDMX3gak5X7cx
X-Proofpoint-GUID: MFpFY46T1w738wfpAPyoDMX3gak5X7cx
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMi8yMDIyIDM6MDcgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMDUsIDIwMjIgYXQgMDE6NDc6NDRQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBUaGUg
c2V0X21lbW9yeV91YygpIGFwcHJvYWNoIGRvZXNuJ3Qgd29yayB3ZWxsIGluIGFsbCBjYXNlcy4N
Cj4+IEZvciBleGFtcGxlLCB3aGVuICJUaGUgVk1NIHVubWFwcGVkIHRoZSBiYWQgcGFnZSBmcm9t
IGd1ZXN0DQo+PiBwaHlzaWNhbCBzcGFjZSBhbmQgcGFzc2VkIHRoZSBtYWNoaW5lIGNoZWNrIHRv
IHRoZSBndWVzdC4iDQo+PiAiVGhlIGd1ZXN0IGdldHMgdmlydHVhbCAjTUMgb24gYW4gYWNjZXNz
IHRvIHRoYXQgcGFnZS4NCj4+ICAgV2hlbiB0aGUgZ3Vlc3QgdHJpZXMgdG8gZG8gc2V0X21lbW9y
eV91YygpIGFuZCBpbnN0cnVjdHMNCj4+ICAgY3BhX2ZsdXNoKCkgdG8gZG8gY2xlYW4gY2FjaGVz
IHRoYXQgcmVzdWx0cyBpbiB0YWtpbmcgYW5vdGhlcg0KPj4gICBmYXVsdCAvIGV4Y2VwdGlvbiBw
ZXJoYXBzIGJlY2F1c2UgdGhlIFZNTSB1bm1hcHBlZCB0aGUgcGFnZQ0KPj4gICBmcm9tIHRoZSBn
dWVzdC4iDQo+IA0KPiBJIHByZXN1bWUgdGhpcyBpcyBxdW90aW5nIHNvbWVvbmUuLi4NCg0KWWVz
LCB3aWxsIG1lbnRpb24gRGFuJ3MgbmFtZSBuZXh0IHRpbWUuDQoNCj4gDQo+PiBTaW5jZSB0aGUg
ZHJpdmVyIGhhcyBzcGVjaWFsIGtub3dsZWRnZSB0byBoYW5kbGUgTlAgb3IgVUMsDQo+PiBsZXQn
cyBtYXJrIHRoZSBwb2lzb25lZCBwYWdlIHdpdGggTlAgYW5kIGxldCBkcml2ZXIgaGFuZGxlIGl0
DQo+IA0KPiBzL2xldCdzIG1hcmsvbWFyay8NCj4gDQoNCk9rYXkuDQoNCj4+IHdoZW4gaXQgY29t
ZXMgZG93biB0byByZXBhaXIuDQo+Pg0KPj4gUGxlYXNlIHJlZmVyIHRvIGRpc2N1c3Npb25zIGhl
cmUgZm9yIG1vcmUgZGV0YWlscy4NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQVBj
eXY0aHJYUGIxdEFTQlpVZy1HZ2RWczBPT0ZLWE1YTGlIbWt0Z19rRmk3WUJNeVFAbWFpbC5nbWFp
bC5jb20vDQo+Pg0KPj4gTm93IHNpbmNlIHBvaXNvbmVkIHBhZ2UgaXMgbWFya2VkIGFzIG5vdC1w
cmVzZW50LCBpbiBvcmRlciB0bw0KPj4gYXZvaWQgd3JpdGluZyB0byBhICducCcgcGFnZSBhbmQg
dHJpZ2dlciBrZXJuZWwgT29wcywgYWxzbyBmaXgNCj4gDQo+IFlvdSBjYW4gd3JpdGUgaXQgb3V0
OiAibm9uLXByZXNlbnQgcGFnZS4uLiINCg0KT2theS4NCg0KPiANCj4+IHBtZW1fZG9fd3JpdGUo
KS4NCj4+DQo+PiBGaXhlczogMjg0Y2U0MDExYmE2ICgieDg2L21lbW9yeV9mYWlsdXJlOiBJbnRy
b2R1Y2Uge3NldCwgY2xlYXJ9X21jZV9ub3NwZWMoKSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW5l
IENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9jb3JlLmMgfCAgNiArKystLS0NCj4+ICAgYXJjaC94ODYvbW0vcGF0L3NldF9tZW1v
cnkuYyAgIHwgMTggKysrKysrLS0tLS0tLS0tLS0tDQo+PiAgIGRyaXZlcnMvbnZkaW1tL3BtZW0u
YyAgICAgICAgICB8IDMxICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgaW5j
bHVkZS9saW51eC9zZXRfbWVtb3J5LmggICAgIHwgIDQgKystLQ0KPj4gICA0IGZpbGVzIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiANCj4gRm9yIHN1Y2ggbWl4
ZWQgc3Vic3lzdGVtIHBhdGNoZXMgd2UgcHJvYmFibHkgc2hvdWxkIHRhbGsgYWJvdXQgd2hvIHBp
Y2tzDQo+IHRoZW0gdXAsIGV2ZW50dWFsbHkuLi4NCg0KSG1tLCBtYWludGFpbmVycycgYWN0aW9u
IGl0ZW0/DQoNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29y
ZS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiBpbmRleCA5ODE0OTZlNmJj
MGUuLmZhNjdiYjlkMWFmZSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2NvcmUuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiBAQCAt
NTc5LDcgKzU3OSw3IEBAIHN0YXRpYyBpbnQgdWNfZGVjb2RlX25vdGlmaWVyKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsIHVuc2lnbmVkIGxvbmcgdmFsLA0KPj4gICANCj4+ICAgCXBmbiA9IG1j
ZS0+YWRkciA+PiBQQUdFX1NISUZUOw0KPj4gICAJaWYgKCFtZW1vcnlfZmFpbHVyZShwZm4sIDAp
KSB7DQo+PiAtCQlzZXRfbWNlX25vc3BlYyhwZm4sIHdob2xlX3BhZ2UobWNlKSk7DQo+PiArCQlz
ZXRfbWNlX25vc3BlYyhwZm4pOw0KPj4gICAJCW1jZS0+a2ZsYWdzIHw9IE1DRV9IQU5ETEVEX1VD
Ow0KPj4gICAJfQ0KPj4gICANCj4+IEBAIC0xMzE2LDcgKzEzMTYsNyBAQCBzdGF0aWMgdm9pZCBr
aWxsX21lX21heWJlKHN0cnVjdCBjYWxsYmFja19oZWFkICpjYikNCj4+ICAgDQo+PiAgIAlyZXQg
PSBtZW1vcnlfZmFpbHVyZShwLT5tY2VfYWRkciA+PiBQQUdFX1NISUZULCBmbGFncyk7DQo+PiAg
IAlpZiAoIXJldCkgew0KPj4gLQkJc2V0X21jZV9ub3NwZWMocC0+bWNlX2FkZHIgPj4gUEFHRV9T
SElGVCwgcC0+bWNlX3dob2xlX3BhZ2UpOw0KPj4gKwkJc2V0X21jZV9ub3NwZWMocC0+bWNlX2Fk
ZHIgPj4gUEFHRV9TSElGVCk7DQo+PiAgIAkJc3luY19jb3JlKCk7DQo+PiAgIAkJcmV0dXJuOw0K
Pj4gICAJfQ0KPj4gQEAgLTEzNDIsNyArMTM0Miw3IEBAIHN0YXRpYyB2b2lkIGtpbGxfbWVfbmV2
ZXIoc3RydWN0IGNhbGxiYWNrX2hlYWQgKmNiKQ0KPj4gICAJcC0+bWNlX2NvdW50ID0gMDsNCj4+
ICAgCXByX2VycigiS2VybmVsIGFjY2Vzc2VkIHBvaXNvbiBpbiB1c2VyIHNwYWNlIGF0ICVsbHhc
biIsIHAtPm1jZV9hZGRyKTsNCj4+ICAgCWlmICghbWVtb3J5X2ZhaWx1cmUocC0+bWNlX2FkZHIg
Pj4gUEFHRV9TSElGVCwgMCkpDQo+PiAtCQlzZXRfbWNlX25vc3BlYyhwLT5tY2VfYWRkciA+PiBQ
QUdFX1NISUZULCBwLT5tY2Vfd2hvbGVfcGFnZSk7DQo+PiArCQlzZXRfbWNlX25vc3BlYyhwLT5t
Y2VfYWRkciA+PiBQQUdFX1NISUZUKTsNCj4+ICAgfQ0KPiANCj4gQm90aCB0aGF0IC0+bWNlX3do
b2xlX3BhZ2UgYW5kIHdob2xlX3BhZ2UoKSBsb29rIHVudXNlZCBhZnRlciB0aGlzLg0KPiANCg0K
WWVzLCBpbmRlZWQsIERhbiBhbHNvIG5vdGljZWQsIHdpbGwgcmVtb3ZlIHdoaWxlX3BhZ2UoKSBp
biBhIGZvbGxvdy1vbiANCnBhdGNoLg0KDQp0aGFua3MsDQotamFuZQ0K
