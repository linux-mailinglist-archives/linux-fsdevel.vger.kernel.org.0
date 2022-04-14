Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6307F50034A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiDNA7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 20:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiDNA7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:59:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717C41624;
        Wed, 13 Apr 2022 17:57:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DLZbwu012645;
        Thu, 14 Apr 2022 00:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r2B6eHY2pSk9+al5pMNP2bdQiBwAdgLJ6IpjBqxPLD4=;
 b=bIfiLnP43dAppL0ao7ac3F0sYwOUpVUWbaLFbJfeYwnl1dsjV/0zDE2aMwHLR2axfS1o
 LnAsSk5+tQ+GyNK8dt8GYU8OTR+0F8X+jir7opqr3M2ZOhiOI8Rg3QDWUrFjWynCMGBm
 2OESThYdBxzIqmm3v9U00QQcI7DTyhGyz6do4/z/xLYvZsao2KZTEBBsEGPKsgruE1TJ
 hManjCAuX7GeJaE+9DUCt95z1GEJu1XCdVuUayOVV3ByUa5WA+LDNTHFbxsI2Gp2TIJ7
 SFkbQ4ahhQlkh4K9PCLf3tQLnfp9ooi9ISLyi2R+cTZnNrX+7NBRrGxPkCFpEksI0pQv MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu3pue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:56:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0jkmO029572;
        Thu, 14 Apr 2022 00:56:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4jd5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krRo9UU/LWB+Ehs6/Cs++bdgDnQtFybhr91tqLQq8hpJSPO34B0tQS+lbmiprxo7W5XM2PAQ1TnBRPbyADIWgEayu5kpZRn0EegoBk21Xu81eeFRKWZtwvmz8yDeeeZV7+Eqlq5l0mfSPawAKtm4FKxgWBD4rS6lCm8/0CYuslFuVflZ+GnphO2rftNzdU3lQgaOCMbgS5Gzu/NotyhRWzfl+vRP5AcG3seJExrUnyd83Djok7bmuE+b4xkogDVi72KZQpFirCdBUBfcYvqbplOhm/Spf4NA6aWaAlcA2NUQLsEEEajDEP29APKdI8t8nfp9mXRbQwlwqzA39wdlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2B6eHY2pSk9+al5pMNP2bdQiBwAdgLJ6IpjBqxPLD4=;
 b=Q4C5k+/iTRsK1QfHK75TTKe+DQ/PKJbmLCawZz88F9aLDxPAeaevLn3vrTC1G/DevH++AOfkFmX0upJtpsf5K2lYIoAYlYoa3uW/sBOW1tBz3wMkdS1b7RfX28sOEtbLdbO4KxWcawoOHyhu07tAWyhjI97C0yZVM2Tyw0mEZLlDy8ICOLsYl2kOtx9HEOZ3/b7MtzrjQ6SMNPuNPcgSVTN+AXjIGzPoir4TrqQm7AdQ+OqSZog3V2H6iZ7g5qQHshGIJnB7tIQ/l68g+Nzs+767CTQ7iVRbsuUPcd1GLSTUtMdyi5bfz8jWhJCiNoXnMVaxkah+L7RZz8WBHtmDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2B6eHY2pSk9+al5pMNP2bdQiBwAdgLJ6IpjBqxPLD4=;
 b=fbsv46SuD73VVIKkIKdVhVceCI+xlMm+Dw3G5+mW26uhpDAMNOI3CDzM4pga6MQSUnQB25WbvuZYbRgy3nURuZKBrlqNLXmPBRF5kuebNz4gucqRxTIYj2HqV3nlYgZs6YMOnunjyYAbzY+yTlcTMBNTLzehuurYy60cRrAxJYc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 00:56:54 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 00:56:54 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v7 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Topic: [PATCH v7 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Index: AQHYSSYah9+z/rTaSUWMOtmXmhhWK6zrUlAAgANQc4A=
Date:   Thu, 14 Apr 2022 00:56:53 +0000
Message-ID: <d248d95b-0b9a-cf33-9fd5-47e74870bc0f@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-3-jane.chu@oracle.com>
 <CAPcyv4iUWLsZRV4StCzHuVUhEsOB5WURD2r_w3L+LEjoQEheog@mail.gmail.com>
In-Reply-To: <CAPcyv4iUWLsZRV4StCzHuVUhEsOB5WURD2r_w3L+LEjoQEheog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bf510d6-536f-4c6d-0b73-08da1db1aaeb
x-ms-traffictypediagnostic: SA2PR10MB4745:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4745FB2D4004C84BC9519E01F3EF9@SA2PR10MB4745.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYlkYZKIVgx+u5Pl7Bdqa2u301hKLBJQaCzw8TDhFOzc72yvx8pQFSbB44fOEtnvilbEVozdxvz4CN65RU/kBv2kAgdDDwE893tMZ1Hi7VHaTI2iq0y+dC3LXiS1wawtG+ioujeM8evC9CkeN/gkBdrP19SdxbOq1WYSMUd8TfcVxFR6QSkcBOp51GSV67pt/m6MgucuJ2bpxRpfcoKnM13krogFDw9ZvCYXSR53yZL7MERDYP6vy9z8Vme9cdNbbjPgg60yCqrvP0AnvN3vf8J9Pb1/0fN9nIzBwPVHaLSuOW7gzfRN5OGofuX51plPx6bdAkYwvvMInL8T+kaOX2EOAuEipUC+7yivBItZlYZKD1XucZ4fvoZ50o/vr4esRWrRd0eBs3X9A0dTrZZtlQbYvP4usjlNZgNs85Iil8Tgqo3m9EmYfmAVvlECdbYf21Ow5i1Mzqu3sVD6Tnk7jRio6g1pQYAvjCiY8EoOdxDa1rWoY2TEa6nHTir64y9gIYO+f7C1wQocJCy6N5gNmm4kGirJS5f4RactUqKFK8c9J8ixSQHssj4GNHRDyp+pLITeBKgXayWyXCIktvhI9Kk2exshppgsFsxN4OltIypJ8w0hwcqTipGBZU6Be2N3DuE8I21MwByuOG0WV8LxBN6yL8djmoS5/u9KcC2JpXXZSdGP1TjneSs5aSnBvG2SxMjyUkOonZgOGVR5jGFWuD6QKDj6wx+3oWRLABs6NFloFx3PY7NVf8jscdrjxKnzx4PrToURhqUcUNqq5clI1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(71200400001)(6506007)(8676002)(66556008)(64756008)(66446008)(66476007)(4326008)(38100700002)(122000001)(6512007)(31686004)(83380400001)(186003)(26005)(2616005)(36756003)(54906003)(316002)(6916009)(2906002)(76116006)(66946007)(53546011)(31696002)(44832011)(6486002)(38070700005)(508600001)(7416002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHN6Ym42dmVpa284cVJwOTRGMDYvbUI4ZU9mMGJaR0tCSCtMbDlNb0R2SCtI?=
 =?utf-8?B?clA0dHBxK05rYXoxenRhNTAxVG9lcy9nZWYxbDlvU3lMSExCd3dQR2V5dVE5?=
 =?utf-8?B?MjhmOE5id2lNVkZCRFd2VFhRRUs0Q0ZMdXM2ZStGTVdZNDlmbW53T3owYWdF?=
 =?utf-8?B?empSdVNVRnNpbElKQWl3Mjh3Tk1LZ2Nib1cwbWdKNmp3cTcra0dJY01ndkFM?=
 =?utf-8?B?bFBodVhHTklIc1RsT3hQb3l1YU9QY2llWTgyaDJTV1ZBTU9peDc1ZmxwV2Vy?=
 =?utf-8?B?RlhKTnQ0bWs4VVljbThyTkFwQjBZeGFFZGJmU0toN3ovaDJOeGFybHU0MU9o?=
 =?utf-8?B?djNHdnVxcGMxTEtackZsbXRIZ05mUFN5YzZuazRXR091bU1NckJ5NXpSNXgw?=
 =?utf-8?B?TlVlWk1xVGJpTVgweFhGYWhRMCsxSTJkc2lXdWMxUkV4MU5MTnpEa1lPVVdi?=
 =?utf-8?B?cmtwUlFtNVJxc3NvVnRiZG1xYTA2MzJndHljenBoNXhUYmZIM0laVy9LTnFw?=
 =?utf-8?B?ano1NXp2R0JtZmZNTEpnQ1puOGlxRVVvME8rblVkVEEvSFRQc2ppU2lNdVVl?=
 =?utf-8?B?aEFMVTZ1cjMvUERBZEg5TnpLbVc0cUZZQithK0owL0lqSWlPN1l4U1BsUjdY?=
 =?utf-8?B?T3ByeG50UnJFY0lhZ0J0QWw3elBRQ2V1NzVXQ1RENFJZMnNFYzV5VHQrRU5T?=
 =?utf-8?B?azhlc2FucmFURUhPUnVEQ3dVcnUwK3E3NDVvODBMUkd0NFdPVzZkT0NXczhs?=
 =?utf-8?B?dCsvMFROeEx1ZlBZakhqMGpVOU5rMjNPNVF2WnF4R3Y2UXU1eTNwNm5HRWN0?=
 =?utf-8?B?dy9DcktVOWNiUmhvVG9PQWcxcXdTSUJwcDVMSU9JS2FvQVN4RlA1aXQrcW42?=
 =?utf-8?B?WFZ0NFhLNkFBVVc2alBJclAzOE5FM09JUnVGYkxWcXJacHdQb21hVGVIVHNu?=
 =?utf-8?B?M1hOMWZZY0ZwL2hCZkRaNjJPS2pJQ1pkYlJ0Q2YrRndRd0lrZnpyMDlRMUpU?=
 =?utf-8?B?NDVEeDBZbkZyM3puMm03ZmtNOGYyVkc0WXNWTHpFTGZmS2d1cmF3MERJZ0k1?=
 =?utf-8?B?UTlmRGtWdFlsenhwTkVndUR5alREbDdIcDJXV1U0Qm9ybGkxd3NhekgzYTc3?=
 =?utf-8?B?bU9nTkFibENUaEFTeUFQVXdpdXFqS000aFkxYWNBU3RGWUFWQXBSc0pHMFh6?=
 =?utf-8?B?d1lJcHkwZEFPZjRsRDF6SVNHY203TjBMTnJUYVVTQ3Q1ZTVObVlWZFNrYytG?=
 =?utf-8?B?ZkpyS2VVR1lnWnA5dkhlWktURW5vY3NXRWdWa04vT0dWVzgwUi9vbVM5dUY1?=
 =?utf-8?B?Zk1vYlJWV1VFblhqKzJ5UTM2VXd4c2t3ZDdIcndpWU9PTjhEVGVjNjM3Qnc2?=
 =?utf-8?B?RHpqZTl4SXAwNEhYcUJWbTFUS2pTanJmbW1hdzJxUmxjY0FLWFhVZ0E1TktO?=
 =?utf-8?B?Um80eVZDakxJbUJ4Y2hXMTdwZWY2ZVVkK3d2QVU0WlgwYTltTU9KR0ZXSzB5?=
 =?utf-8?B?VWkzSW5CY0Z4NlA5UUpsdmpMQTZCcEdqaWU3UGt6ZmxISzgramhEOGhFUmpL?=
 =?utf-8?B?WTdrbmp4WXgwSFF2eEp0KzFsQVJISGFxRlR1L2RiRk5wRm9jSVN3ZkFYZHlR?=
 =?utf-8?B?QjRMVEJWRUQ5bDQ4bW42UFBpaTNNQUJWTXdscllyZmlhZ2VOQVFDSUpCbVMv?=
 =?utf-8?B?djlYK2w5Mm9hU0hIT2hLYys3RnNNSGVJbEloRk5WTXJzbWtaVnZPSmc0cElV?=
 =?utf-8?B?Z2FKRTJBd20wS0NnWTZYa1BoWkNTUzYzRXJaSTJUOTlXTEd1QkM3WGJYYk1H?=
 =?utf-8?B?YlJETkpMUTlXOXR5OHR5SHVCL0FXQzR5Z2Jpc1N3VVVHRUVZM1EwU2M4ZHBx?=
 =?utf-8?B?c3RKcEtyYjdHVkVkUUJhTHRaVVhoZEpmRW84cUV2dHN2dmR2aW5WZEd6ajFI?=
 =?utf-8?B?RVdqaDQyNndDMytUdDJEbFFnSzZZN1NkNUN2TTdvajZaMUw4WlYyM3dkaDZh?=
 =?utf-8?B?cEtwNFlyZFQ0dTlKNDdBUCt5eUxZMHUvUHFGMWhYT2hRMEdOb1JIZDNOK1Iv?=
 =?utf-8?B?U1ZFSTZpY3BUVGpmZWxYV3Z5UzZtbWlQazd2ZUlRR1hPRUhOaU43U3R0SFNr?=
 =?utf-8?B?OXNlOXFRUGp4ZXlFN1hGMlhiMHkwZEhyRlBkSjl2SzFRL25jWFFpczBMRktB?=
 =?utf-8?B?WlIrZTlRVm5hK2ZyZGp4dHhnNU1pTG5CMThTVE5MZ3RLMmxabUlkVWNVOTZt?=
 =?utf-8?B?ZCs2bCtUcW9LWVJzVVZZYXBwbW9vOHJBaGlDc1h6QkNyNEprdHhUSlNWdmFG?=
 =?utf-8?B?LzlXaTRWS3F4bHh0elJKcmlDZnJSMnhQd0FmaHBUc3RPQklFMy9kdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21622D29443C994EBD5A169B20013E1A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf510d6-536f-4c6d-0b73-08da1db1aaeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:56:53.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G/bXpT4AH+Wa5iM78Wgb9oYSKXltZPgViAzUJmoUnHFwqLojHjpQWGbmjMNgy00IMkVuTPK6BGtamHm470XKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140002
X-Proofpoint-ORIG-GUID: K8KM3rh-TzQuhALGsqDE69mO2WOYFktd
X-Proofpoint-GUID: K8KM3rh-TzQuhALGsqDE69mO2WOYFktd
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMS8yMDIyIDM6MjAgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gSSBub3RpY2UgdGhh
dCBub25lIG9mIHRoZSBmb2xrcyBmcm9tICJYODYgTU0iIGFyZSBvbiB0aGUgY2MsIGFkZGVkLg0K
PiANCg0KTm90ZWQsIHRoYW5rcyENCg0KPiBPbiBUdWUsIEFwciA1LCAyMDIyIGF0IDEyOjQ5IFBN
IEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToNCj4+DQo+PiBSZWxvY2F0ZSB0
aGUgdHdpbiBtY2UgZnVuY3Rpb25zIHRvIGFyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4+
IGZpbGUgd2hlcmUgdGhleSBiZWxvbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUg
PGphbmUuY2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20v
c2V0X21lbW9yeS5oIHwgNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBh
cmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jICAgICAgfCA0NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+PiAgIGluY2x1ZGUvbGludXgvc2V0X21lbW9yeS5oICAgICAgICB8ICA5ICsr
Ky0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDU2IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXRfbWVtb3J5
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXRfbWVtb3J5LmgNCj4+IGluZGV4IDc4Y2E1MzUx
MjQ4Ni4uYjQ1YzRkMjdmZDQ2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
c2V0X21lbW9yeS5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXRfbWVtb3J5LmgN
Cj4+IEBAIC04Niw1NiArODYsNCBAQCBib29sIGtlcm5lbF9wYWdlX3ByZXNlbnQoc3RydWN0IHBh
Z2UgKnBhZ2UpOw0KPj4NCj4+ICAgZXh0ZXJuIGludCBrZXJuZWxfc2V0X3RvX3JlYWRvbmx5Ow0K
Pj4NCj4+IC0jaWZkZWYgQ09ORklHX1g4Nl82NA0KPj4gLS8qDQo+PiAtICogUHJldmVudCBzcGVj
dWxhdGl2ZSBhY2Nlc3MgdG8gdGhlIHBhZ2UgYnkgZWl0aGVyIHVubWFwcGluZw0KPj4gLSAqIGl0
IChpZiB3ZSBkbyBub3QgcmVxdWlyZSBhY2Nlc3MgdG8gYW55IHBhcnQgb2YgdGhlIHBhZ2UpIG9y
DQo+PiAtICogbWFya2luZyBpdCB1bmNhY2hlYWJsZSAoaWYgd2Ugd2FudCB0byB0cnkgdG8gcmV0
cmlldmUgZGF0YQ0KPj4gLSAqIGZyb20gbm9uLXBvaXNvbmVkIGxpbmVzIGluIHRoZSBwYWdlKS4N
Cj4+IC0gKi8NCj4+IC1zdGF0aWMgaW5saW5lIGludCBzZXRfbWNlX25vc3BlYyh1bnNpZ25lZCBs
b25nIHBmbiwgYm9vbCB1bm1hcCkNCj4+IC17DQo+PiAtICAgICAgIHVuc2lnbmVkIGxvbmcgZGVj
b3lfYWRkcjsNCj4+IC0gICAgICAgaW50IHJjOw0KPj4gLQ0KPj4gLSAgICAgICAvKiBTR1ggcGFn
ZXMgYXJlIG5vdCBpbiB0aGUgMToxIG1hcCAqLw0KPj4gLSAgICAgICBpZiAoYXJjaF9pc19wbGF0
Zm9ybV9wYWdlKHBmbiA8PCBQQUdFX1NISUZUKSkNCj4+IC0gICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4+IC0gICAgICAgLyoNCj4+IC0gICAgICAgICogV2Ugd291bGQgbGlrZSB0byBqdXN0IGNh
bGw6DQo+PiAtICAgICAgICAqICAgICAgc2V0X21lbW9yeV9YWCgodW5zaWduZWQgbG9uZylwZm5f
dG9fa2FkZHIocGZuKSwgMSk7DQo+PiAtICAgICAgICAqIGJ1dCBkb2luZyB0aGF0IHdvdWxkIHJh
ZGljYWxseSBpbmNyZWFzZSB0aGUgb2RkcyBvZiBhDQo+PiAtICAgICAgICAqIHNwZWN1bGF0aXZl
IGFjY2VzcyB0byB0aGUgcG9pc29uIHBhZ2UgYmVjYXVzZSB3ZSdkIGhhdmUNCj4+IC0gICAgICAg
ICogdGhlIHZpcnR1YWwgYWRkcmVzcyBvZiB0aGUga2VybmVsIDE6MSBtYXBwaW5nIHNpdHRpbmcN
Cj4+IC0gICAgICAgICogYXJvdW5kIGluIHJlZ2lzdGVycy4NCj4+IC0gICAgICAgICogSW5zdGVh
ZCB3ZSBnZXQgdHJpY2t5LiAgV2UgY3JlYXRlIGEgbm9uLWNhbm9uaWNhbCBhZGRyZXNzDQo+PiAt
ICAgICAgICAqIHRoYXQgbG9va3MganVzdCBsaWtlIHRoZSBvbmUgd2Ugd2FudCwgYnV0IGhhcyBi
aXQgNjMgZmxpcHBlZC4NCj4+IC0gICAgICAgICogVGhpcyByZWxpZXMgb24gc2V0X21lbW9yeV9Y
WCgpIHByb3Blcmx5IHNhbml0aXppbmcgYW55IF9fcGEoKQ0KPj4gLSAgICAgICAgKiByZXN1bHRz
IHdpdGggX19QSFlTSUNBTF9NQVNLIG9yIFBURV9QRk5fTUFTSy4NCj4+IC0gICAgICAgICovDQo+
PiAtICAgICAgIGRlY295X2FkZHIgPSAocGZuIDw8IFBBR0VfU0hJRlQpICsgKFBBR0VfT0ZGU0VU
IF4gQklUKDYzKSk7DQo+PiAtDQo+PiAtICAgICAgIGlmICh1bm1hcCkNCj4+IC0gICAgICAgICAg
ICAgICByYyA9IHNldF9tZW1vcnlfbnAoZGVjb3lfYWRkciwgMSk7DQo+PiAtICAgICAgIGVsc2UN
Cj4+IC0gICAgICAgICAgICAgICByYyA9IHNldF9tZW1vcnlfdWMoZGVjb3lfYWRkciwgMSk7DQo+
PiAtICAgICAgIGlmIChyYykNCj4+IC0gICAgICAgICAgICAgICBwcl93YXJuKCJDb3VsZCBub3Qg
aW52YWxpZGF0ZSBwZm49MHglbHggZnJvbSAxOjEgbWFwXG4iLCBwZm4pOw0KPj4gLSAgICAgICBy
ZXR1cm4gcmM7DQo+PiAtfQ0KPj4gLSNkZWZpbmUgc2V0X21jZV9ub3NwZWMgc2V0X21jZV9ub3Nw
ZWMNCj4+IC0NCj4+IC0vKiBSZXN0b3JlIGZ1bGwgc3BlY3VsYXRpdmUgb3BlcmF0aW9uIHRvIHRo
ZSBwZm4uICovDQo+PiAtc3RhdGljIGlubGluZSBpbnQgY2xlYXJfbWNlX25vc3BlYyh1bnNpZ25l
ZCBsb25nIHBmbikNCj4+IC17DQo+PiAtICAgICAgIHJldHVybiBzZXRfbWVtb3J5X3diKCh1bnNp
Z25lZCBsb25nKSBwZm5fdG9fa2FkZHIocGZuKSwgMSk7DQo+PiAtfQ0KPj4gLSNkZWZpbmUgY2xl
YXJfbWNlX25vc3BlYyBjbGVhcl9tY2Vfbm9zcGVjDQo+PiAtI2Vsc2UNCj4+IC0vKg0KPj4gLSAq
IEZldyBwZW9wbGUgd291bGQgcnVuIGEgMzItYml0IGtlcm5lbCBvbiBhIG1hY2hpbmUgdGhhdCBz
dXBwb3J0cw0KPj4gLSAqIHJlY292ZXJhYmxlIGVycm9ycyBiZWNhdXNlIHRoZXkgaGF2ZSB0b28g
bXVjaCBtZW1vcnkgdG8gYm9vdCAzMi1iaXQuDQo+PiAtICovDQo+PiAtI2VuZGlmDQo+PiAtDQo+
PiAgICNlbmRpZiAvKiBfQVNNX1g4Nl9TRVRfTUVNT1JZX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jIGIvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnku
Yw0KPj4gaW5kZXggMzhhZjE1NWFhYmE5Li45M2RkZTk0OWYyMjQgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jDQo+PiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0
X21lbW9yeS5jDQo+PiBAQCAtMTkyNSw2ICsxOTI1LDUzIEBAIGludCBzZXRfbWVtb3J5X3diKHVu
c2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBhZ2VzKQ0KPj4gICB9DQo+PiAgIEVYUE9SVF9TWU1C
T0woc2V0X21lbW9yeV93Yik7DQo+Pg0KPj4gKyNpZmRlZiBDT05GSUdfWDg2XzY0DQo+IA0KPiBJ
dCBzZWVtcyBsaWtlIHRoZSBvbmx5IFg4Nl82NCBkZXBlbmRlbmN5IGluIHRoaXMgcm91dGluZSBp
cyB0aGUNCj4gYWRkcmVzcyBiaXQgNjMgdXNhZ2UsIHNvIGhvdyBhYm91dDoNCj4gDQo+IGlmICgh
SVNfRU5BQkxFRChDT05GSUdfNjRCSVQpKQ0KPiAgICAgIHJldHVybiAwOw0KPiANCj4gLi4uYW5k
IGRyb3AgdGhlIGlmZGVmPw0KDQpTdXJlLg0KDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQgeW91IGNh
biBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+DQoNClRoYW5rcyENCi1qYW5lDQo=
