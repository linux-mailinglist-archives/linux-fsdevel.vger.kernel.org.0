Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01C73A703
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFVRMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVRMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:12:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC69171C;
        Thu, 22 Jun 2023 10:12:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGY9bO025384;
        Thu, 22 Jun 2023 17:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OBU5cQp77APLc2TabM34qUKxR+DhXbUm8ZI2lXtGIQ0=;
 b=dccTmCYbDMwWMLVULNsBGnUS6Yn/h2V3JO92o/kVFSFcDcJ3r+stIjG/vvSCiTMgkUCV
 LJYOj0Ac20yESkg9WA+jkIsY14WqXfWFofGtR9l/4lq6aL9a9zzZai9312U3R8SujLOh
 retG5QWfY08g0EQSIGrX2uo9zxlSu17WlYDfL6mG7iWu022uu00TzVa/teIS+flbxU9r
 a1Pi66VyFR1vQc0GBRQ8pcOI15y9r0lVvtosIa59nKkcz012HtPfn15LEZ8NPLT5tduv
 HnTRcvjAACPGVP+eYDrQkiQf2obnjplXO7ZHTAFZHcBkQKz1/y9/9Sfnygajcs/hfSrb ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu292r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 17:12:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MFjY9w028861;
        Thu, 22 Jun 2023 17:12:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939dvknq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 17:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfioH1IMHufXJ3WU+deQ3pVFZQtO/OuJ+frC9+d2VGGEuHdywhHc9F++UPQaNIGdJRCdSWsvXdGfqAhshtW1QEThp9KBQ1VYeKQXWJX5RPF+bhG8D/ffcINuyhK0ZYYfNg04+O+PE5YMlwxTvZjcQuChr8g6nnuPUTCaIzmHEBjik/DBSrWIvN29T1h5PDtX60ZS6siVefo6b+uyPRZ1+K+n+WOuGKkd8W1RiVGC+2CeaQmtfiBG925+3pFmXDoj35PPrqomQT6w7VSkMN+4fCEBKTFxUGddfxF8vkwINfhKxH5B66X8SytQajUmCV3Ff/Dr+YFpIT87DEpksB2fdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBU5cQp77APLc2TabM34qUKxR+DhXbUm8ZI2lXtGIQ0=;
 b=HMYzbBqwAcry8ATbg6Pg2JJunZAXDsECl22NX0V4UPHhEDEELgwSSBxDaRixtwaxIUnA8OmUqcXUiw27RLs9E+q0CYX0tC61uRdvkVuJq5bh32r7XPyMRalCTanYJLnv+nFgdg++06Af899deymeuKY+NwFoC0GsK07JsAXKXZqYYP+pKy5z/Dz9AdXapbqGIdIHa1ksbMMIStIp3APMsD3v6yHS9f7p29GqtC4fIN3SDHR9X5pHAsDZJPhRnyBO4XO5LPqlY5lOLaCgR1SEjdPY+N9oHioTTctGM4gO1VzpUMbLpE3msYaPjG3EouLVTscIN8OgnIiySDQI+pX/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBU5cQp77APLc2TabM34qUKxR+DhXbUm8ZI2lXtGIQ0=;
 b=tztjSPkS8q6Z0dkwUqcJhtH1jdhVAnakVBgZuuqEllnOdkK8qSYiWVXpoFQ3NDDBCXncbhlNanzoKunhTofhcgoVWhZXDy6jcsE/iENLuwTwxfhEFF0IFdVP/SgLpuw6VBKhUcipM4k5lQDqcvcep/G/iWQd0xjrc3vtGGRKTLg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 17:12:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:12:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     stsp <stsp2@yandex.ru>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Thread-Topic: [PATCH 2/2] selftests: add OFD lock tests
Thread-Index: AQHZpFRBuWHdWK3VTEWhHJpZRPu6tq+WtkkAgABRqwCAAATGgIAAAjkAgAAB1IA=
Date:   Thu, 22 Jun 2023 17:12:37 +0000
Message-ID: <187C3E49-A977-492E-99CB-97F032B24E5F@oracle.com>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
 <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
 <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com>
 <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru>
In-Reply-To: <26a798ae-b93b-2f68-71ed-35950240927d@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4140:EE_
x-ms-office365-filtering-correlation-id: 4158d5f4-86d3-4b3d-2a78-08db7343e0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bq2WeJH6xTulQDKqZ8lbCxoOXppFt+J2vBBlZXhN9j0sZKolQkeRsQBaIDvTmdrXVqjuHMAlhT7NZ4ASGNjY1dRB4I+tg9bOwgq3fV3ZBRejzDVy5/Te0+CsAX5ikJa8fXC77xSaUEibYQN4sXs7/a1AW5nhTeWOx/6QXq7S4fcILb1NzbPfvbOy5DTgfnC+0PaKcv81/VEW+pVqbPTot0uIrErn+aJOfrAn177mF+boWxvWzhRwaNHhLjFms1yMw/U8ycbIqjzwpml57ax6Uw57KYAbzqA+RkynHtgY9Z10P3VIdBu3M2/F1SgodTx2tkpBBHej0VehhNamhghKA3nkTQWga6Ah1kGQyIveJuO24/MPe4WdSk18V1NZshVftZ+R8bDZq9p3OqIiJPJbKvCzLTDVKmVSK0WnjFZxwafpN6Jq4gGmTY1LIG1wUDyBUOIuaOpXD36+uCn+LoFyIk6GlZcncsu3XiRpzKLlW34OxAcIQLGJAyxOQlpHKk/f/1ir70LESllJ5IdS2WAbyEWdbrYynsG9tT2MTI5xba3O+TlLvaE3Ls9C/Dt+Mq62UrFORNaEnEgs7ntgr4ZYnosaIWlduJo3gual/h7mrFl9FSmHN9W2Jw0ArSSsI+6SKrUKmQU2slVxYRv6XXZzaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(53546011)(186003)(71200400001)(26005)(6512007)(6506007)(478600001)(33656002)(4744005)(2906002)(86362001)(41300700001)(8936002)(8676002)(2616005)(36756003)(122000001)(38100700002)(54906003)(38070700005)(4326008)(316002)(6916009)(6486002)(5660300002)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eklkN3JuaFJudm9FSXl6am1mOVh4UzREc2tyOTROMXBqNVlGeXFEVjlHREFE?=
 =?utf-8?B?dXo5cnB3TmZjM21YejI3cm9vMDRhdnFaWnpqM3Q5QmN1OW1WVlQrTE5wbFFh?=
 =?utf-8?B?R3pYZWsvblBJb1FMZXRPQU9LRE80bTI3S25ISkhMMEhsVTdzY09zalU1R1Rv?=
 =?utf-8?B?cG5MNXY3S2ZCWlNLbmdoNkdicGtKSUdpejUxVjRyV0l6UytWZDZWeExGazlu?=
 =?utf-8?B?NG9VNUJ5bEJ6NHl1SEUvRlFEVGkvbnp5WWc4ODFXbnYxSFMrdEJQS3lUL1p4?=
 =?utf-8?B?QU40UzBnUGRUN3hmakFEbzFFazNteFFIRVlpTFp5NUxIakVDbWRDdEVUSzBR?=
 =?utf-8?B?NkVqVDUyMG0xUW9GNzd1cTlObDlBV3JYRHRDWHcweCtSbHJoRWE3TWNhYWly?=
 =?utf-8?B?SW5rb1g0UDBEalFDd3dMUHRSN2RNRXRCYUd0c3YwbTdBVXBZUjk4eGdpdnU1?=
 =?utf-8?B?N25VcDBCS1NXQW54bmtoQmx1eGlPT0xHRStoVWtkT29Idi9WaHBvaHExNDk3?=
 =?utf-8?B?aUZqdkNUU2JObUtkbU9iVWdhYVExTVhrREVKNEkvMVNMUDNhcEo2K3lXZlNn?=
 =?utf-8?B?eGFqYmpDa25JQmx0NVBhdTNUaS9wdnN2MjhzRHpBMnI1NHI4aThQSlZBbHJF?=
 =?utf-8?B?WGRXTU5LY0xjOHBXL0FkRWczRHVwMCtpWGNqRXBTOWZtQTFRZVN4eno1RmNR?=
 =?utf-8?B?Tjh3L0wyNmVuTzJYdmRvYk1ja2NEUTJDR3VPcENxMm1SVnZ4S0RRWlRqQnRF?=
 =?utf-8?B?ZC92aDVUS2dIMnpQb2UrSGtJUlAxQUV2NDNoalV5SHZlditlS1JJSmRKU3JF?=
 =?utf-8?B?b2lmSktiTjdDRi9nemVUdS9yU1cyL3FiM0FydVNlbDNYLzVmQWVvdHhlNGRn?=
 =?utf-8?B?MWlUUXpycnovNi82WldSTkRZb0RPdDRob1dmdCs0VStMYnltUTZ6MHRqRjhT?=
 =?utf-8?B?NFJ4THAvYlRFK1V1dTZST1NaQUpyTWtSZGhQYW0xY2ZYVEIwV3A3akI3bit3?=
 =?utf-8?B?TFdBazVCaDczbVNlNlF3S0Z6QlNueTdpV3c3cDBiNFVzVWtwcGZGNm9DaENM?=
 =?utf-8?B?UmJISGdVbHVCSnJHTnVyUzMrNlNCZTdLUUFwT0JHaUZobTBSZ1ZiZThsNmVB?=
 =?utf-8?B?UjJjRjNVQ01mOVZJQVpjeXhvekVTQmxFTjBKQ2JHbmFOeGZnT0QxQXpNa0hY?=
 =?utf-8?B?cW4wdGVrTVdjaXl5a1RZUERPM3lEdGVXUXhEblQyQW9nMXVYbllxL1hDczgz?=
 =?utf-8?B?dWhRekFRcjZwajZuS2x2WVJUTHZKMEJqamhtbG1WTVdPNGNlMlgycWJ4K05G?=
 =?utf-8?B?WEN6Y3RWQnBDaXNxUHorUGJicm9MMlBPMy9ra1pidkxsMlVHSG84Nlpmbnpw?=
 =?utf-8?B?ZUxVVmZqK3V5cjNvNmF5RTF5MTlzS2Y3bmw5dmppM0trdWw0cW94NkphQVpR?=
 =?utf-8?B?NTV0VnZuT1ljTUxaVDBFa3hieXRIMm11cmx3QzZQN016UFVrOGkrelB5K3VN?=
 =?utf-8?B?SDdocXRCa25xSndsSTFGbHdjSHVsczdsZTVzNVdxamJyejM5VEg5cm9nbjE2?=
 =?utf-8?B?YVI2V2pyWlNQbG40Z3pJMzVTdStRY0dKRGhuTC9XWUFCTXFEZ0tFRmpHcXhD?=
 =?utf-8?B?Y1VxU0pGUG9NV3V0ZXZLZFpVN2U0Ym54eDlLVjBOSGhqT2tZNkc4bkczempD?=
 =?utf-8?B?Nm5ZNUFrRENjUC9BbXpPWTlvYWloWTlicG1CSVhwVk8zU3Z6aEtlalpselVW?=
 =?utf-8?B?UFI2U2JMVGFXNlVBT2xWb0k5eVJ6TjFuNGpDMmRJMFFXNFVJaVhUZmlPMU9Q?=
 =?utf-8?B?YktjVjRDNWZaMFk1aVlyeHFXNEVCQUJDb1IrR3ZGOUFtRW1qV3RnMHNGNnpt?=
 =?utf-8?B?RlFaRmN5QnlOWEc0a2NQdlAyblZ1M0VlZWxJL0VzVnJGR3hMWk9KVFptL0FP?=
 =?utf-8?B?T3FnYkhBQnczVEpWUGY4M3ZEUkNWRW9xSkY5cDhjSnRlVEtPU0ZSWEhha0Nw?=
 =?utf-8?B?QS92NEQvRGZJUXdLRDd5dEZKeEd3U0ZhcTh0MVZjODZ2RnE2SUE0elkxSXBX?=
 =?utf-8?B?bjF0UG4weHQ5aStOT0w0SXYwZTRBTlRSOUZ2MFEvV3ZENHBOMWE3QXB0RjVj?=
 =?utf-8?B?V21LL3hNY3dkbytmRFdDMXFlSUlNc0JYcm5sellhSWNQV0ZxdFBtaXRidUtF?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5880F83812B92345B2894F5CB6E25013@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: otqD5OrglpAscXOKcvoz2+IZvSnHjWFiSeP9jr5ZeuKnxmDh2KIAJ9TG7JYHBRPSEU6OOs8TvRTmxq/HtRA3SyqnPXIuXKHpXDXI8pUnQ9e6PrHrYhnEUptZEFr06LVU5ezcVBT6J5CSwifI2zfTluhRldBnEff+z+qJOm6GpRvD0rLOO+v/r8C5lu3OWvJk1LqwRhWdgoH2pZpt0IINluuVdTtvKuRpOru4mnIRHn+6OhiMEAHfvTRYuibd4TripN5CUArOjw2W33s8ZbLAhm+BY5Vbo16rxaF6zqo0KR2S4wBY+0wKWYzmJ2kvsHCgZycajqdbjCcusHmCfJi7gUpl4DXKuS8t4tU84x3tWGYKjL/Lbyf6/3XzBRFGjNJdo+CLAOPTEqscqaRmxSPcLaFzlnNV7/6r6vfuAlxZpYr0qi0RcF2NauhN0h3eqJsIvAcFmc1GRp3r1ClxPMyLlGftqBXnjXY+Ej4w9iRdjH1cLtt7S5d03w6gElvC3go9mXtoPqNGvkvJ/1FCQnSFWAq5WeSnVCItLBesTT7PGxPDC6obci4ae2t2Kk2pm5Sg1LfApy4/aHKpXpo+j9FfpC5ftR0F6sbStZUD1IS8sF23DD4k0BCCCwyjygDY6cxlpzx5GW3sAfqHSP/BxTA5/6i5kDhlE9ER4Rq21T1AF1QIykp7jU5+vAxGq896MRw/mKFuwtaQUgqusvMFhFDkjVcgbohqb61EDOYnuNDVQKa6G2iIwGMeuAQyCAnK95bnekH3WxIPCOVC1fKInjrlMbOXhc6YNOUtg+eVmvOS/nQE9y/CSAaWOjHu8l1grFyQCjRhwZ7dtR/Sbaz+q4HZAx2TJyxZ1hSJrBIWC6beEkb1BTgB6Rt2+mwOb4XZbyhz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4158d5f4-86d3-4b3d-2a78-08db7343e0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:12:37.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrsJLgaLeyTaYi52OEmPwNe87Km+K8ep2XOn4ZExGLMcfTEn3/+npAgkQFExwp3mXty5OZvLQ60jeTo272wvZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=805 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220146
X-Proofpoint-GUID: 11vGWGr63nTKdUorY0fKI_t_nFSb7_pB
X-Proofpoint-ORIG-GUID: 11vGWGr63nTKdUorY0fKI_t_nFSb7_pB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gSnVuIDIyLCAyMDIzLCBhdCAxOjA1IFBNLCBzdHNwIDxzdHNwMkB5YW5kZXgucnU+
IHdyb3RlOg0KPiANCj4gDQo+IDIyLjA2LjIwMjMgMjE6NTgsIENodWNrIExldmVyIElJSSDQv9C4
0YjQtdGCOg0KPj4gSU1PIHRoYXQncyBub3QgYSByZWFzb24gbm90IHRvIGRvIHRoaXMgcHJvcGVy
bHkuDQo+PiANCj4+IFlvdSBzaG91bGQgd29yayB3aXRoIEplZmYgYW5kIHRoZSBtYWludGFpbmVy
IG9mDQo+PiB4ZnN0ZXN0cyB0byBtYWtlIGl0IGhhcHBlbi4NCj4gQnV0IGl0cyBub3QgZ29pbmcg
dG8gYmUgaW4gdGhpcyBwYXRjaC1zZXQNCj4gYW55d2F5LCBhcyBpdHMgYSBkaWZmZXJlbnQgc291
cmNlIHRyZWUuLi4NCg0KSWYgb3RoZXJzIGFncmVlIHdpdGggbWUsIHRoZW4gcGxlYXNlIGRyb3Ag
dGhlIHNlbGZ0ZXN0cw0KcGF0Y2ggZnJvbSB0aGlzIHNlcmllcy4gVGhlcmUgaXMgYSBjb25zaWRl
cmFibHkgaGlnaGVyDQpwcm9iYWJpbGl0eSB0aGF0IHRoZSBuZXcgdGVzdCB3aWxsIGJlIHJ1biBm
cmVxdWVudGx5DQpieSBDSSBpZiBpdCdzIGluIHhmc3Rlc3RzLg0KDQoNCj4gU28gSSBzaG91bGQg
cHJlcGFyZSBpdCB3aGVuIHRoaXMgaXMgbWVyZ2VkLA0KPiBvcj8NCg0KSSBkb24ndCBoYXZlIGEg
c3Ryb25nIHByZWZlcmVuY2UuIEEgZ29vZCBjaG9pY2UgaXMgdG8NCnB1c2ggdGhlIHRlc3QgYmVm
b3JlIHRoZSBrZXJuZWwgY2hhbmdlcyBhcmUgbWVyZ2VkLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==
