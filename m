Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA194F6AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiDFUAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDFUAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:00:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DAC1FA4A;
        Wed,  6 Apr 2022 10:45:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236HJq0U024458;
        Wed, 6 Apr 2022 17:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KnF5pTDvCSC1UdO8pi+Jxcgt4EDhirJkhSZATh4JPQs=;
 b=L60wVanSzFKDJIpHD4iViCy9tzu7ygHi8lI9dHV3qT1o0HGoHJahMbfYhx/M6BGeTxuL
 pptdkuAAuF2oJY6k1dVJqbFJuR42IHMyJvxFGh8vcFBYPRoz3+abfTnWt7CginD0Fx3O
 OatJl/32aWIIHyVkNXdF+p1v/V9k3bug4MHD/hKnqCFhnFKL3aSCRK5g9b/5lFToV5b8
 JoQBEij6nDMHY1dfhYW383QXQytgRg+CeJw3HkHHnm2gAExH0uT6vp11uDHWj50T1rvo
 7HeXAZPgLVnB6L/rCG7UNSTUoPsTNziimIa6A12w5uBQptXTp/vbOr/kyZn3hP9/kBmH 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t9tkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:45:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236HaOXJ033182;
        Wed, 6 Apr 2022 17:45:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqbb5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvUiiQmGZMoCYuFyvAtLC7/MoL6bQL4RhffsAJZ4byMOm4HpmYPnQ+m7i8KPXeG4yuYtRAzadBsTZLH3+5KWotoa2ALrP5W6NcxC45131WIAiRC1N3PdmJ8Yuu1p39U9Km5qFYjcJHVxqasQrYSFaui2pwFKDUAoQeMMmlrS1zMZ//mP58edMaIYM0g6noFj0PJn1yyB5cJXdgOccP0JPBrb6DimxcDcDib+eo+4uzJ5DDiOqrNkKv3VdT/1LzCVgO0Ie7oX/9PM2fjxbN6tj9AIYmvKFwNHYlgmElT8jb38tJ8ZDn64a9P1C52qKnSLiI7iDDAegl9cjmxMxLst5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnF5pTDvCSC1UdO8pi+Jxcgt4EDhirJkhSZATh4JPQs=;
 b=Xn+/JwmjXNwGE/7lLKJizsgK/Ld85uJfDGUzZsAcf0ZPtXm/2jXIECjCWBaV+ezbaDq+51AjxPQcKDGbmcA2xT/z+qZO+6/dKOkjqsfHg6VPeRPBNrYClfhXWJRFafCFCs5hoGFACTCm8283DxHS9YI26vUcUA4TTMEOjTvNOIV9eyVq649Bmj+vVStTIrNmSArYGYbIbxnDScztwKNgFNpE6zGQz/T7C04ee1CwhTBKYVm403WZTnmgf9ynn/cKbcWvYod36PuwqFcr+mpeAOV3UG9xWCoOTMQy7E9Clkk9CKmOIBVhJ/Snzri3DcOfPnuFbyrowcXmCkw5yKWOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnF5pTDvCSC1UdO8pi+Jxcgt4EDhirJkhSZATh4JPQs=;
 b=rfDOkzDVftePZUfuSFwiHM2cGOI+nMPfYXEv7PNCILwjmaMI+AUXarcJxldRO2bTj+m5QBxhpZwAu9JWo79b9+RfaMeboDgOPJku0aLecnw9LYsbtM4f1ZxefSuYQtRHwdKQbylPtgJV4Y92iGcYRJMpCWw8kKw1CIclFEeZRkU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN7PR10MB2563.namprd10.prod.outlook.com (2603:10b6:406:c3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 17:45:26 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 17:45:26 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Thread-Index: AQHYSSYdGKTdETDbkEmdZR/SZY7Ic6ziWZ4AgADMqgCAAAOcgA==
Date:   Wed, 6 Apr 2022 17:45:26 +0000
Message-ID: <24ebe6fb-e7ef-e578-9196-dbf52afeb432@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <Yk0i/pODntZ7lbDo@infradead.org>
 <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
In-Reply-To: <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f5d94b-bffc-4b9d-80f4-08da17f53bc1
x-ms-traffictypediagnostic: BN7PR10MB2563:EE_
x-microsoft-antispam-prvs: <BN7PR10MB2563DB6E8C77E379D15D0716F3E79@BN7PR10MB2563.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQKmZSE9Uw+a3kV7qkufcoEOUHthyUU5HxZlGXv/fhCw62k4OKoVRKEL8x9AMuW/WA0JXBkmbvn1tOLattd5QvnCyI1c4iXQQF6QxNZDYgYxH/1ioDTd2Wbm2Vl6kS7axB1kUsjnIOotVy9uSJYp7FaeXKQjHu5SiN2xm3C6uUskiRvGM/qqn18ffYj+VE75ZI2hRxNLBnj1frv157u/yyDIjqjMcoME9wVS30ihdXZ/5NLK44y9HO4Xlxy95S1//e6j6VLw2qwUMO/nxFGcvG4lkSe1TiubAI5VTiNxkFMYO7FIy4VcDVtI2usKuJt9+No2qaJAdjZrajShFhXdnm/0LyuU12efXP5A7Von/fMdD3a4MjrqOID7ms29AbnmKCceNWQtT21m8CknzMXWVP1RCPjMi+El3SVipTsp5WTI6sWfDVwvvTxp7wiI9rz1D+OYYFXS8hWpRBaSWLrrv4qFEBbRyORPy72mySO9PGS71xUE91RED88tqWQ1aFa0ilUo2f2sfVxOxlXzjoPSdOBRcFH34pADT0oXRapf+l3R3kY9kMxc3J47fE8icsX3PrXCcYAZHvXdjCOxRFZCgPM2cUXEOGaRpoHdW0Rem7DqyUn3q27T22r2spTHvwDiahTSu2YaarELTNAdx/DiqeLPnP/0hsLKyFyyx0pDTOzRSJDqjrxenKlEOlSI/HbY2PywHEx6xSK3+uVg8Nytk4R4UZ2CoJPU3fByWf7QaSEzZ2p4Kb7smaNdKiWql3UhOQrA68s98YEEo430jicKpULwOG5mvuF2s5gYQ0/UbefvnnlSoTr2xu6BArURgmYoE18xim1Ecn9PEtwQbW9zPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2616005)(6486002)(4326008)(508600001)(38070700005)(54906003)(8676002)(316002)(64756008)(66556008)(31686004)(91956017)(66446008)(36756003)(66476007)(66946007)(110136005)(76116006)(83380400001)(31696002)(2906002)(86362001)(8936002)(44832011)(5660300002)(7416002)(71200400001)(122000001)(38100700002)(6506007)(53546011)(6512007)(142923001)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWZsbUZCZ3ZwR21OMUNCRjU1N1p6ejdUeXFCMCtZTWFDNjNSM1lMY3NQb2pp?=
 =?utf-8?B?QW1zNk41ZWxDK1BWZHFXRzFwelhRdGpFbCtTK3BTL1FjdlZ1ZUdsb0txOWV3?=
 =?utf-8?B?OVBtazNaYk9WMDRKSm45Rm1CdGNSMy9CdTlyNTRzdFRyc3FScytLNmFxUkpV?=
 =?utf-8?B?dU15cTRBZWlvb3NnNUZBV2V6cVBURnBtVytaWnVCQmFJM3ZzWGt0cWw3NDND?=
 =?utf-8?B?cTVhdDhiQm54U1JFbDZMVHVKM2I1S2VjZjBsejJ1V1hnR2ljak4weXFvb0w1?=
 =?utf-8?B?K2ovVTFTeEt0U3plUmQ2cERtRlIvR1ZJUW9kdldUN1lyNktkSHUxUXpBSTJ0?=
 =?utf-8?B?aGdSbGRMeDZROVpjdGNOOEJxUFRrbWM5R3QvY0VwbTkrQy82MDdOM0lZZmNs?=
 =?utf-8?B?VldOYkVWemIvWlRrSnd4M3ZKSEFqb1BVUXdwTUpjU0hMNzVoYjJBL3RUU3I0?=
 =?utf-8?B?OUVlSzRhWFI3RFZaMjFUcjI3U2s5QUhnRXdia3ZIMi9YTTVacjdiTmYrTVVO?=
 =?utf-8?B?NzZwYWEvZjZGNFQ3ZEU4Qlo4UTNRMVd0TS9yc3NhNmFWYklTWEpNUjZGU2lR?=
 =?utf-8?B?RUVZd0pFVlhmQVhoV3NPV2Voam5JUjlJdlJPSVNocmRvOGdqaE9EN3EySmgz?=
 =?utf-8?B?UTRrTUJUN3V0Z0ZFQStVU1orM0wxK25VbXNDRUZQb1FSOWFCa0JJR3Y3aitj?=
 =?utf-8?B?MEtXYWdBODY0WjFBWWppRUxWMVV0dTFmajdPUGJnTnZYdGNWV1lQRXFQTmFw?=
 =?utf-8?B?eEV2aW1VN0pVRGZFR0VyZXRvK1hvRkViM1Y5ZHpFSE1ZOStYTG91U01tNXpp?=
 =?utf-8?B?dW1FVzY2T1JldHBGSXE3OEVsNFJIZzZtNTVVallrY0s2RUxORVBPd0wvdGtO?=
 =?utf-8?B?b1BWQno5Qk9hMmlQc29CU0QwTUV5RHlmWCszOFdFNEtabnk5c0EvNTRYdkpF?=
 =?utf-8?B?ODhva2FTQmVYYkU3MmlLTjRJZDVQWjFHRHdXcjM3OGlzWXpGYWVwWnEwandC?=
 =?utf-8?B?bjZ0cG13dnkzcWZ4K1FKSFpra0MvYlgySVdISTVTeGhKdWZHN2NROEhyQVVR?=
 =?utf-8?B?UnFsLzZEOWdreVV2QjBLY3RXKzRXKzRGSDdGMGRGVHJrWlNmbU1xTG5ycTFI?=
 =?utf-8?B?N09FNCtrdWFSVXF3QStoR0xaMjMvaVhkN3VrU1Z0TUk3Zm95c25nY0NidTlw?=
 =?utf-8?B?cmIxTVYvOExGejZvTUVrWmVkZTF5OFowKy9UZTNuUlliN1hDYmE3ZmovNERC?=
 =?utf-8?B?dTMzUlptVjBPRkNrcU9ZV3ZSNE0wVFNMdVBad3M1dllKUDlkZDJwWFVhUTJ4?=
 =?utf-8?B?OS9xekNXd2VYL3lyRjQ0UDNwcCtFU3l4Q3VySElOT0g1eHphWWxHRjZxb3JP?=
 =?utf-8?B?Y3BQSk9HamQ2SGdsM3hXNGJJNE5sN3JIVEMzUE9sYk5WRVp2YkJXTzFFVTVU?=
 =?utf-8?B?bkxLbTU5RkhBOXJWa0lJcmJWSHY4QndXMGpqTmQ1M0tnS3ZOdVJselVheW9w?=
 =?utf-8?B?MGhoajV2WFFQRDA1MWp3YnJidEtjNU1meFdxcERLa1V4eHB2RUdTMGRsdXUx?=
 =?utf-8?B?cGFOeldNdmpGb0tPTXlmMUFINHhLdGM1UXZyejRPY04rMmFmRi84ejBTTDVD?=
 =?utf-8?B?SzJhK3R1ZDEyWE9pRW5BL1lDN2t2Ym9HcHdaTHZXblJKT3NVQTdIdk5GOGh3?=
 =?utf-8?B?d01sQXNkT2l0d3hPQlpQTWk1ajM1M3dVRXFpTm9mNzl6UjRZdFRsRjJRUC9W?=
 =?utf-8?B?NjZhVG9lMUlFS3A2VElQSGFOZ1IyMkRiQm1Pbk5kUUtYMUxkcGtlanFOcjlB?=
 =?utf-8?B?VGF2eEZteWhFdTN3T2JxQlBrTVJXTXBOd3NiSVlQd2xkZTVsZ2RFZnEvKzZh?=
 =?utf-8?B?b0ZxS05XWUFOTEt6dDdWLzZNZHRpZHRhTjAvalF2OTdVVWxkTUZ2ZVlRdXBQ?=
 =?utf-8?B?aEhTRU1sdnRCYkQvdkVqRTVzSVRhWHhNZGRoZUk5NzEvV3paenRRSDBhRFVo?=
 =?utf-8?B?UGpKSmdLbXRXY0srTi9aWHJJdU5BUktzM3pOb1ZaS1J1YzZFNzlweDdSN0lS?=
 =?utf-8?B?SFhRWmhMbnlDSU1XYnpmSENFTjFoRm4yWUluR2wrZFBhTVNHTkpmbVp2M0N4?=
 =?utf-8?B?a3FPdVRydHZKeXJnOHZjN1RmOEVsNVlXRUQvQW41S0t3ejE3V3NQdXFTNC84?=
 =?utf-8?B?ZUoza3hHcDBzckp4dUJPOEN0QnZpb1IwQVNXeXV4Y2VzREdxNThsWW9GalV5?=
 =?utf-8?B?aS83ZW1wejAvQUQyV25iRUQ3SVl3R2QzNVpJeThGdkI1K3d5M0VUS0xtTk8y?=
 =?utf-8?B?dGRuTUlaalRKOXhNN2F5bW93c3h1N2NnZ0xRYnlBM0NyVDA3TXVNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DD6E0D0761695438C6F6DF8AC6ED909@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f5d94b-bffc-4b9d-80f4-08da17f53bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:45:26.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUVgoeJKh5QNRoJ+XMxkFK+lt/MfTXt0PM1NL2yeV/8Urs0yexfUuytiRZdWm6eEYyf8dhZB02rpB9Z01SmQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2563
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060087
X-Proofpoint-ORIG-GUID: i1Ksh8SFx8eSJVoa5KAmpf7iEvb24u7d
X-Proofpoint-GUID: i1Ksh8SFx8eSJVoa5KAmpf7iEvb24u7d
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UmVzZW5kLCBub3Qgc3VyZSBpdCBkaWRuJ3QgZ28gdGhyb3VnaC4NCg0KT24gNC82LzIwMjIgMTA6
MzIgQU0sIEphbmUgQ2h1IHdyb3RlOg0KPiBPbiA0LzUvMjAyMiAxMDoxOSBQTSwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBUdWUsIEFwciAwNSwgMjAyMiBhdCAwMTo0Nzo0NVBNIC0w
NjAwLCBKYW5lIENodSB3cm90ZToNCj4+PiBJbnRyb2R1Y2UgREFYX1JFQ09WRVJZIGZsYWcgdG8g
ZGF4X2RpcmVjdF9hY2Nlc3MoKS4gVGhlIGZsYWcgaXMNCj4+PiBub3Qgc2V0IGJ5IGRlZmF1bHQg
aW4gZGF4X2RpcmVjdF9hY2Nlc3MoKSBzdWNoIHRoYXQgdGhlIGhlbHBlcg0KPj4+IGRvZXMgbm90
IHRyYW5zbGF0ZSBhIHBtZW0gcmFuZ2UgdG8ga2VybmVsIHZpcnR1YWwgYWRkcmVzcyBpZiB0aGUN
Cj4+PiByYW5nZSBjb250YWlucyB1bmNvcnJlY3RhYmxlIGVycm9ycy7CoCBXaGVuIHRoZSBmbGFn
IGlzIHNldCwNCj4+PiB0aGUgaGVscGVyIGlnbm9yZXMgdGhlIFVFcyBhbmQgcmV0dXJuIGtlcm5l
bCB2aXJ0dWFsIGFkZGVyc3Mgc28NCj4+PiB0aGF0IHRoZSBjYWxsZXIgbWF5IGdldCBvbiB3aXRo
IGRhdGEgcmVjb3ZlcnkgdmlhIHdyaXRlLg0KPj4+DQo+Pj4gQWxzbyBpbnRyb2R1Y2UgYSBuZXcg
ZGV2X3BhZ2VtYXBfb3BzIC5yZWNvdmVyeV93cml0ZSBmdW5jdGlvbi4NCj4+PiBUaGUgZnVuY3Rp
b24gaXMgYXBwbGljYWJsZSB0byBGU0RBWCBkZXZpY2Ugb25seS4gVGhlIGRldmljZQ0KPj4+IHBh
Z2UgYmFja2VuZCBkcml2ZXIgcHJvdmlkZXMgLnJlY292ZXJ5X3dyaXRlIGZ1bmN0aW9uIGlmIHRo
ZQ0KPj4+IGRldmljZSBoYXMgdW5kZXJseWluZyBtZWNoYW5pc20gdG8gY2xlYXIgdGhlIHVuY29y
cmVjdGFibGUNCj4+PiBlcnJvcnMgb24gdGhlIGZseS4NCj4+DQo+PiBJIGtub3cgRGFuIHN1Z2dl
c3RlZCBpdCwgYnV0IEkgc3RpbGwgdGhpbmsgZGV2X3BhZ2VtYXBfb3BzIGlzIHRoZSB2ZXJ5DQo+
PiB3cm9uZyBjaG9pY2UgaGVyZS7CoCBJdCBpcyBhYm91dCBWTSBjYWxsYmFja3MgdG8gWk9ORV9E
RVZJQ0Ugb3duZXJzDQo+PiBpbmRlcGVuZGVudCBvZiB3aGF0IHBhZ2VtYXAgdHlwZSB0aGV5IGFy
ZS7CoCAucmVjb3Zlcnlfd3JpdGUgb24gdGhlDQo+PiBvdGhlciBoYW5kIGlzIGNvbXBsZXRlbHkg
c3BlY2lmaWMgdG8gdGhlIERBWCB3cml0ZSBwYXRoIGFuZCBoYXMgbm8NCj4+IE1NIGludGVyYWN0
aW9ucyBhdCBhbGwuDQo+IA0KPiBZZXMsIEkgYmVsaWV2ZSBEYW4gd2FzIG1vdGl2YXRlZCBieSBh
dm9pZGluZyB0aGUgZG0gZGFuY2UgYXMgYSByZXN1bHQgb2YNCj4gYWRkaW5nIC5yZWNvdmVyeV93
cml0ZSB0byBkYXhfb3BlcmF0aW9ucy4NCj4gDQo+IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGFi
b3V0IC5yZWNvdmVyeV93cml0ZSBpcyBkZXZpY2Ugc3BlY2lmaWMgYW5kDQo+IHRodXMgbm90IHNv
bWV0aGluZyBhcHByb3ByaWF0ZSBmb3IgZGV2aWNlIGFnbm9zdGljIG9wcy4NCj4gDQo+IEkgY2Fu
IHNlZSAyIG9wdGlvbnMgc28gZmFyIC0NCj4gDQo+IDEpwqAgYWRkIC5yZWNvdmVyeV93cml0ZSB0
byBkYXhfb3BlcmF0aW9ucyBhbmQgZG8gdGhlIGRtIGRhbmNlIHRvIGh1bnQgDQo+IGRvd24gdG8g
dGhlIGJhc2UgZGV2aWNlIHRoYXQgYWN0dWFsbHkgcHJvdmlkZXMgdGhlIHJlY292ZXJ5IGFjdGlv
bg0KPiANCj4gMinCoCBhbiB1Z2x5IGJ1dCBleHBlZGllbnQgYXBwcm9hY2ggYmFzZWQgb24gdGhl
IG9ic2VydmF0aW9uIHRoYXQgDQo+IGRheF9kaXJlY3RfYWNjZXNzKCkgaGFzIGFscmVhZHkgZ29u
ZSB0aHJvdWdoIHRoZSBkbSBkYW5jZSBhbmQgdGh1cyBjb3VsZCANCj4gc2Nvb3AgdXAgdGhlIC5y
ZWNvdmVyeV93cml0ZSBmdW5jdGlvbiBwb2ludGVyIGlmIERBWF9SRUNPVkVSWSBmbGFnIGlzIA0K
PiBzZXQuwqAgTGlrZSBidW5kbGUgYWN0aW9uLWZsYWcgd2l0aCBhY3Rpb24sIGFuZCBpZiBzaG91
bGQgdGhlcmUgbmVlZCBtb3JlDQo+IGRldmljZSBzcGVjaWZpYyBhY3Rpb25zLCBqdXN0IGFkZCBh
bm90aGVyIGFjdGlvbiB3aXRoIGFzc29jaWF0ZWQgZmxhZy4NCj4gDQo+IEknbSB0aGlua2luZyBh
Ym91dCBzb21ldGhpbmcgbGlrZSB0aGlzDQo+IA0KPiAgwqDCoCBsb25nIGRheF9kaXJlY3RfYWNj
ZXNzKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LCBwZ29mZl90IHBnb2ZmLA0KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9uZyBucl9wYWdl
cywgc3RydWN0IGRheGRldl9zcGVjaWZpYyAqYWN0aW9uLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGZsYWdzLCB2b2lkICoqa2FkZHIs
IHBmbl90ICpwZm4pDQo+IA0KPiAgwqDCoCB3aGVyZQ0KPiAgwqDCoCBzdHJ1Y3QgZGF4ZGV2X3Nw
ZWNpZmljIHsNCj4gIMKgwqDCoMKgaW50IGZsYWdzO8KgwqDCoCAvKiBEQVhfUkVDT1ZFUlksIGV0
YyAqLw0KPiAgwqDCoMKgwqBzaXplX3QgKCpyZWNvdmVyeV93cml0ZSkgKHBmbl90IHBmbiwgcGdv
ZmZfdCBwZ29mZiwgdm9pZCAqYWRkciwNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVfdCBieXRlcywgdm9pZCAqaXRlcik7DQo+ICDCoMKgIH0NCj4gDQo+ICDCoMKgIF9f
cG1lbV9kaXJlY3RfYWNjZXNzKCkgcHJvdmlkZXMgdGhlIC5yZWNvdmVyeV93cml0ZSBmdW5jdGlv
biBwb2ludGVyOw0KPiAgwqDCoCBkYXhfaW9tYXBfaXRlcigpIGVuZHMgdXAgZGlyZWN0bHkgaW52
b2tlIHRoZSBmdW5jdGlvbiBpbiBwbWVtLmMNCj4gIMKgwqDCoMKgIHdoaWNoIGZpbmRzIHBnbWFw
IGZyb20gcGZuX3QsIGFuZCAoc3RydWN0IHBtZW0gKikgZnJvbQ0KPiAgwqDCoMKgwqAgcGdtYXAt
Pm93bmVyOw0KPiANCj4gSW4gdGhpcyB3YXksIHdlIGdldCByaWQgb2YgZGF4X3JlY292ZXJ5X3dy
aXRlKCkgaW50ZXJmYWNlIGFzIHdlbGwgYXMgdGhlDQo+IGRtIGRhbmNlLg0KPiANCj4gV2hhdCBk
byB5b3UgdGhpbms/DQo+IA0KPiBEYW4sIGNvdWxkIHlvdSBhbHNvIGNoaW1lIGluID8NCj4gDQo+
Pg0KPj4+IMKgIC8qIHNlZSAic3Ryb25nIiBkZWNsYXJhdGlvbiBpbiB0b29scy90ZXN0aW5nL252
ZGltbS9wbWVtLWRheC5jICovDQo+Pj4gwqAgX193ZWFrIGxvbmcgX19wbWVtX2RpcmVjdF9hY2Nl
c3Moc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBwZ29mZl90IA0KPj4+IHBnb2ZmLA0KPj4+IC3C
oMKgwqDCoMKgwqDCoCBsb25nIG5yX3BhZ2VzLCB2b2lkICoqa2FkZHIsIHBmbl90ICpwZm4pDQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGxvbmcgbnJfcGFnZXMsIGludCBmbGFncywgdm9pZCAqKmthZGRy
LCBwZm5fdCAqcGZuKQ0KPj4+IMKgIHsNCj4+PiDCoMKgwqDCoMKgIHJlc291cmNlX3NpemVfdCBv
ZmZzZXQgPSBQRk5fUEhZUyhwZ29mZikgKyBwbWVtLT5kYXRhX29mZnNldDsNCj4+PiArwqDCoMKg
IHNlY3Rvcl90IHNlY3RvciA9IFBGTl9QSFlTKHBnb2ZmKSA+PiBTRUNUT1JfU0hJRlQ7DQo+Pj4g
K8KgwqDCoCB1bnNpZ25lZCBpbnQgbnVtID0gUEZOX1BIWVMobnJfcGFnZXMpID4+IFNFQ1RPUl9T
SElGVDsNCj4+PiArwqDCoMKgIHN0cnVjdCBiYWRibG9ja3MgKmJiID0gJnBtZW0tPmJiOw0KPj4+
ICvCoMKgwqAgc2VjdG9yX3QgZmlyc3RfYmFkOw0KPj4+ICvCoMKgwqAgaW50IG51bV9iYWQ7DQo+
Pj4gK8KgwqDCoCBib29sIGJhZF9pbl9yYW5nZTsNCj4+PiArwqDCoMKgIGxvbmcgYWN0dWFsX25y
Ow0KPj4+ICsNCj4+PiArwqDCoMKgIGlmICghYmItPmNvdW50KQ0KPj4+ICvCoMKgwqDCoMKgwqDC
oCBiYWRfaW5fcmFuZ2UgPSBmYWxzZTsNCj4+PiArwqDCoMKgIGVsc2UNCj4+PiArwqDCoMKgwqDC
oMKgwqAgYmFkX2luX3JhbmdlID0gISFiYWRibG9ja3NfY2hlY2soYmIsIHNlY3RvciwgbnVtLCAN
Cj4+PiAmZmlyc3RfYmFkLCAmbnVtX2JhZCk7DQo+Pj4gLcKgwqDCoCBpZiAodW5saWtlbHkoaXNf
YmFkX3BtZW0oJnBtZW0tPmJiLCBQRk5fUEhZUyhwZ29mZikgLyA1MTIsDQo+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0KPj4+
ICvCoMKgwqAgaWYgKGJhZF9pbl9yYW5nZSAmJiAhKGZsYWdzICYgREFYX1JFQ09WRVJZKSkNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU87DQo+Pg0KPj4gVGhlIHVzZSBvZiBiYWRf
aW5fcmFuZ2UgaGVyZSBzZWVtcyBhIGxpdGxlIGNvbnZvbHV0ZWQuwqAgU2VlIHRoZSBhdHRhY2hl
ZA0KPj4gcGF0Y2ggb24gaG93IEkgd291bGQgc3RydWN0dXJlIHRoZSBmdW5jdGlvbiB0byBhdm9p
ZCB0aGUgdmFyaWFibGUgYW5kDQo+PiBoYXZlIHRoZSByZW9jdmVyeSBjb2RlIGluIGEgc2VsZi1j
b250YWluZWQgY2h1bmsuDQo+IA0KPiBNdWNoIGJldHRlciwgd2lsbCB1c2UgeW91ciB2ZXJzaW9u
LCB0aGFua3MhDQo+IA0KPj4NCj4+PiAtwqDCoMKgwqDCoMKgwqAgbWFwX2xlbiA9IGRheF9kaXJl
Y3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBQSFlTX1BGTihzaXplKSwNCj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZrYWRkciwgTlVMTCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IG5ycGcgPSBQSFlTX1BGTihzaXplKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgbWFwX2xlbiA9IGRh
eF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBucnBnLCAwLCAma2FkZHIsIA0KPj4+IE5V
TEwpOw0KPj4NCj4+IE92ZXJseSBsb25nIGxpbmUgaGVyZS4NCj4gDQo+IE9rYXksIHdpbGwgcnVu
IHRoZSBjaGVja3BhdGNoLnBsIHRlc3QgYWdhaW4uDQo+IA0KPiB0aGFua3MhDQo+IC1qYW5lDQoN
Cg==
