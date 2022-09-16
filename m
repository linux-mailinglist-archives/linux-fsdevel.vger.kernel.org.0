Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35D5BB2C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIPT0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPT02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:26:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6CCB287D
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:26:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GJOKJv031586;
        Fri, 16 Sep 2022 19:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s8hhmntGRF/Y81Zt8IQ1n+l6thJnNV3lkpSQ6BqLmcE=;
 b=jNDRhR6cY8yBdv1zaSVmPcnTDA29jjAzLjUjoopdjFkw2of/myIjysPRwwd/zAgNDIAE
 obzAk/6PZn2R+yW5VNNysVV7xU7OiKppw//407u14mrH7T5R/6uhDUbPTUvtrx/CLuH+
 1/k1O0U5ed0RM8gwhvtNpzeK29jHRizD/cUGU+oSqbeWgC0LFYElbB+4Yu/rWjAayS3c
 rEVw/+R3fDneN8AHOCAGCEcKHvrePaCTaNbd74e8NQh09HSHfo+yw2BibIdKQ/Fhd9AW
 tS9BGNZYg9oMyTb8hW2ztvn3I6iI7tVUMREGaKYeVnOXoogj6g8n3ClgOGBQ6tsWLZW8 EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8x8ucdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 19:26:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GJNUjP016351;
        Fri, 16 Sep 2022 19:26:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xesc9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 19:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVJlm27JdCWAAaDCwe+H75l3JcxuV0v9stGbTC9zb8ay4zJI6J8Apuqbj6V/qHDovp6Gl9uiWLsbuSfIIpI3+XH+qM7nx/I3TpPG3DvztEmlg48Lj+Q/Pn7nyByjGG0mW6QUystZOin4s0SXdhaw/y88FciEjIelgO032q7GyAMLP9WsGjfonM3DYe+b2R2tXuGNVJ9yiq5dRi0ruLY9ePSLXffQcwhSWrhvxrrABoTjELPQFLwpREC8RuDeUrQr5uHzhdIqYQu5brSxRwgKBASngE//d38HQWfjGV4M/0bsoMP8PsnK+wTVxOE8CTDF0J+AiEcd/4BRB+saoYT/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8hhmntGRF/Y81Zt8IQ1n+l6thJnNV3lkpSQ6BqLmcE=;
 b=SXjNJqzc36m0Rz5Km3u95tm3OVDjhao3dP953iYM4a9PV+xTfO93+bkocHWiOMVbEyo54hmDV1X+UEmryRX9UTuTv5x074ggeZjgN0V4EQiJ6JTtuVedv7Vy9LLtyPUfua4Th2IfzhmJVbLrA4K6vKIQ8AHL/kZk2ozFh3CuXoMQePUtiHWeR1WYdNn94JIN233puI+olUkMRpquuWBXhxp9VLQqnAYb1R3DgdR3+h4Qyxu510qJ2OBv5E1apkqdKYeU/oBsI3eSji1VZzsW9FKHB/QLl8zdaADJmmsYBFESe++MAbzEviVq40xAVSvApjTeWADmHDN7c3s3+qh71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8hhmntGRF/Y81Zt8IQ1n+l6thJnNV3lkpSQ6BqLmcE=;
 b=rNQWS3aojy6EJ9fXB/GNM0Z3lf7SUyoA4rH+r7mGNJmFAc3tT73fKqCuPAwYXt/Lp1NhNsAVvQXMdFQ5kU7bJ8/ZjhLF0dLSi8YbqTAPyscVERTuJocS7LoNUGAV1bXUvrbMKquASxVH2wHxot0iivgvscsK88d7QQun/SLvi4s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ1PR10MB5905.namprd10.prod.outlook.com (2603:10b6:a03:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Fri, 16 Sep
 2022 19:26:01 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%5]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 19:26:01 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uC63hFndwgAAc0YCAAQeswIAANrOA
Date:   Fri, 16 Sep 2022 19:26:01 +0000
Message-ID: <a9b7fce1-691c-6186-ae29-f22c7e30e93a@oracle.com>
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
 <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
 <SJ1PR11MB6083C1CBA41CB53183600B0FFC489@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083C1CBA41CB53183600B0FFC489@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|SJ1PR10MB5905:EE_
x-ms-office365-filtering-correlation-id: 5120fa73-c3be-47a8-2f67-08da98194a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ie4f3BIMI2GsEqHDQPsiKlJVudsLXY/ik8UAJToM330XCyNty4i1FeGUACsMFMsb3a/soOF4BoL0zkSh9mCpB0m2+1NWV/wnK1BrFzxgPiWbXyhl7eBPCIUFfSb5c1NIHZTqwPKoOHdvhM04v6fBP/QgE1xShonAI7Jq9sVcDIRHbi305QQeu+lly5OMmn2lVExucH0EAtBhxP+WvsjMWLJQ1HKY7Tq1p+MvVg0vFR1twFQ2i/pKkEDnXSRFMPLhcTSnnfoYtSbzpxtZwPY7Ifn1arL4iKv3ach9rhV2rrSKLhrwFoAn/wUTjci1VjK9ZFPm5XuPmcg9DA2UNY9vFtF72pdEDYaxo61/AX4fZ1NDl/M0iM0yFhe/KT5we7bzMIIZiTa5Z+SzH26nFn1qMpa0pt2bEW+GfOX9KC90d7g3cA4pfgIXVGyXhvO12eCxF9EhcvnGrkcSJHH8pYFDB2XNW8SgMH3BhfyALeIYqL8FbQOIcdEN4ZAocGcW4dgISFZ8uNyIUkwvtKW1vn7rQkwFi4jGH/xCU/h+rQZsodOkTfoYKiHvLLxkArECFf71gwhNyhqr5aZREqGrNnsZJD7XUsVBBlQjFw2OWZf6g4IWuOrGeqlmLYMHxL4FtkS6TDcuWQHKJgOUGLn0pk0Hjm0rGv849r7MQXtHG4D4LfyAHmgD9pTF5kYug7UI+pHO5KtmHdVsapS2iKLzFuHE/MAzij7AblqL0GjRWIa2YWgBEEqzYSMcOwI0+G8SgLKTWQIM1p50xkdPETvvD/MaHRfRHHfyjT8xEs2WKDASCE73G+9nk77rZX7663LQ6S2ZhI8KZOOmAUWFwGk9eh+dRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(8936002)(38100700002)(122000001)(110136005)(186003)(53546011)(54906003)(83380400001)(6506007)(38070700005)(2616005)(5660300002)(26005)(6512007)(2906002)(36756003)(478600001)(44832011)(6486002)(316002)(71200400001)(66946007)(76116006)(31696002)(66556008)(64756008)(66446008)(66476007)(4326008)(31686004)(86362001)(41300700001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHVBYXBSeHhWNnFhUnVBcGxjaEVIYUkvK25ZbFV0aFFRLzNRb0F4dlM5Ri91?=
 =?utf-8?B?R3U4czkyc1dTdjZkWkdaTHIxUEoyeDBPM0ZSbXhyQXlqbURiZTZZdkkwNjdB?=
 =?utf-8?B?bXE2V3k4Y0VZSHpmbDNyckhrYWdIcXArU3FOQloyTU90MFVnS3N5dVEydnEz?=
 =?utf-8?B?S2FNMS90b3I5S1dMbU9qa0NwelAxMTNpbUJTb1hPZ0phYnd5c1Byc0hUZ2lj?=
 =?utf-8?B?cURab04ydXBKUkxUR09WdGVKQy9QYlNucitSK2lvNk1aOGk0Q3RDQmZkSEFt?=
 =?utf-8?B?d2RqT0Fsdkc3MW9BNlloUHdMQzdHSDhnZGIzTVVrQkFPN0MvMkdQSFhhWkxY?=
 =?utf-8?B?KzZQWE1DR1Rlc2RGTHJnNW5MQnlNYkdaQ25XSSthV1JTN0tWL0I5Yy9oV05v?=
 =?utf-8?B?M3hQSGx0MlVTaHNUWVYwaEQ3V2hSQ2hDaUFRZEJSS1J1amFxNHRZb2hseXJs?=
 =?utf-8?B?bEpYU05FMGFMVTMzYS9HZUs3c3g5QmVNYk9vODMrcjNWRWZvRDFVdzdnZkZ4?=
 =?utf-8?B?QTB4UGVnbCtObkp4Z2xVOUlIU20vUGIzRy9MN0JxT2NIdW82aVpTNklUYkwx?=
 =?utf-8?B?SU51TzJKVDY5VFVzSlJScXlITGRjSG5XRFU5SGcwVDM5OE9hbDRlcjhnOHV6?=
 =?utf-8?B?SjE2TVh6NEQ1TlFrZXIyRkozdWpHSmJ5b21hNVJNVjRQUHhKaDJKQVQ3LzEy?=
 =?utf-8?B?WlNtYlhOOGhGOXBZNnBTN1BuM0tWbFoyNWZqVkVBazd0aENmNklGNCt1ZnFz?=
 =?utf-8?B?bmVhUW1idm9XZVI1OURYblRXTHNESmpxSTdSL2kxaWxNd3VNa2hCTzhQcHU2?=
 =?utf-8?B?Nit1dGpOSEdqeW5CelMzVEJnUGNUREtFZHpuSlFYZjNzMnNrM09KVmdnYzRV?=
 =?utf-8?B?UURadC9DdkZralFUSkhPQ3hZTlA5Vnlxa05MYU1XRitTQmRvOExlTkRRT0Jt?=
 =?utf-8?B?QkVRajFZOGxaOThkZ0JETFhYR3ZBcldWZjR1T0VLTC94YkFBdkZ4SkFSUy9R?=
 =?utf-8?B?UjM4U3UvWUlYdnY0WTlENHhrbWpZWW1XQkpNTEJGVE5pRDc3THZyTGNoZ3c4?=
 =?utf-8?B?S050YnZ1RGVTVTIvRkZRYVBOTGxlM1dxRFVocDVaNHdLanI2eWRZWFdvSkk2?=
 =?utf-8?B?cm12LzhUZ2k3dHRReGxGek5KbTZvS20ydlVJWW1NOFBaYlZqYUNPdHM1cmtF?=
 =?utf-8?B?Vm1vOUVOOHVNa2pBTW4wSmNqbWhpWUNZRHJBZWlZUUhEK1Z2dUU5SHIwUFlY?=
 =?utf-8?B?RnUwV0dOUW9GdHluTGdMMGNMTkthWnJyTnVDZ3d6YlFUYk95NEJpSUF5Wk05?=
 =?utf-8?B?YmtPeTI1clcwNGZWSnlMVjllbkZHNHBjbE5yanNvUFhpMlQrNjB3VWR3cGZj?=
 =?utf-8?B?eGgrS0dJUDRNVlcyK1hURVJyUHczRWx4SzZNZkJ1VnZsMmRRWlVSK2w1cy9k?=
 =?utf-8?B?SXZ6MDRJbnplSDRzcDQreUNZNlc3ZHRMUnhoQWlVVFV4SzdTWmlOMXc2Qk1y?=
 =?utf-8?B?aTdqVmhWeER4MkFMMHhXTFlyR1BVdXBuRFhWT3VDNEhpcXBvWUNiYU1DUE9S?=
 =?utf-8?B?cEVWQXNFTVFGdEdEKzVRSHVsSFYwMUJPak41N2IzUmxkQnR3NitYaTZub2Q0?=
 =?utf-8?B?amRUYVZhN3JaVUV2dnZsbXZPNzZkMlp1bTkrc3JyZk5kR1ZBby9hM00waVNk?=
 =?utf-8?B?UFloaFByQnVEUExxTHZ3b2ZIMUZuaFI1Y0FIck53NldHQm9Gb1Z2VThKOFVL?=
 =?utf-8?B?dzVZcTFwMzZXTWpyQnQ3NFZSYVI1VU1seGlhYkxvMk1JMjN4Znd5Vno2NnU4?=
 =?utf-8?B?d1dleFF4N0Q5Qy9vaDhSdnRYdFg3UDV0b3dZYjhSTFVKdm5NTUtvN005ejRv?=
 =?utf-8?B?YkIvcysrRVoybkcrdVNYTkdWdVBtMXE4MWF1TVpiY2hMajVhWTljUHdpSjYv?=
 =?utf-8?B?aFRiUkplWVJTUHJ0VWxzSUZnYWMrY3NUR2VrOWRlVUwvelZxM0dnTUtHU0cv?=
 =?utf-8?B?VFZDRnE1Rk1SMWlSTUFURTZvRzBBamsreHhZY0dwTVNHN3lLMkd0Ukl0Wkk4?=
 =?utf-8?B?Z25NRk4zZ2FsNXlxWksvVndDY01qQzI0eGZSOW9UblpnUldTVlc1d1ppV1Y5?=
 =?utf-8?Q?VCB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC472DC0043CC1489BACA4D3C232AB14@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5120fa73-c3be-47a8-2f67-08da98194a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 19:26:01.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1voaLvPCwFHnMAvRocaBiIdFLnsi64UAQaJsZKK6UDktQeWFbaKjG8KNqUrptLp32bmDXmZz69tBkg6we2Tf4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_12,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160139
X-Proofpoint-GUID: 2VMETjaoO2knzZB6xLPLv4Gf1Zov0EHC
X-Proofpoint-ORIG-GUID: 2VMETjaoO2knzZB6xLPLv4Gf1Zov0EHC
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gOS8xNi8yMDIyIDk6MTcgQU0sIEx1Y2ssIFRvbnkgd3JvdGU6DQo+PiBXZXJlIHlvdSB1c2lu
ZyBtYWR2aXNlIHRvIGluamVjdCBhbiBlcnJvciB0byBhIG1tYXAnZWQgYWRkcmVzcz8NCj4+IG9y
IGEgZGlmZmVyZW50IHRvb2w/ICBEbyB5b3Ugc3RpbGwgaGF2ZSB0aGUgdGVzdCBkb2N1bWVudGVk
DQo+PiBzb21ld2hlcmU/DQo+IA0KPiBJIHdhcyBpbmplY3Rpbmcgd2l0aCBBQ1BJL0VJTkogKHNv
IHR3ZWFraW5nIHNvbWUgRUNDIGJpdHMgaW4gbWVtb3J5IHRvIGNyZWF0ZQ0KPiBhIHJlYWwgdW5j
b3JyZWN0YWJsZSBlcnJvcikuIFRoaXMgd2FzIGEgbG9uZyB0aW1lIGJhY2sgd2hlbiBJIHdhcyBq
dXN0IHRyeWluZyB0bw0KPiBnZXQgYmFzaWMgcmVjb3ZlcnkgZnJvbSB1c2VybW9kZSBhY2Nlc3Mg
dG8gcG9pc29uIHdvcmtpbmcgcmVsaWFibHkuIFNvIEkganVzdA0KPiBub3RlZCB0aGUgd29ya2Fy
b3VuZCAoIm1ha2U7IHN5bmM7IHJ1bl90ZXN0IikgdG8ga2VlcCBtYWtpbmcgcHJvZ3Jlc3MuDQo+
IA0KPiBIYW5kbGluZyBwb2lzb24gaW4gdGhlIHBhZ2UgY2FjaGUgaGFzIGJlZW4gb24gbXkgVE9E
TyBsaXN0IGZvciBhIGxvbmcgdGltZS4NCj4gU29tZWRheSBpdCB3aWxsIG1ha2UgaXQgdG8gdGhl
IHRvcC4NCg0KSSBzZWUsIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHBhdGNoZXMuDQoNCj4gDQo+
PiBBbmQsIGFzaWRlIGZyb20gdmVyaWZ5aW5nIGV2ZXJ5IHdyaXRlIHdpdGggYSByZWFkIHByaW9y
IHRvIHN5bmMsDQo+PiBhbnkgc3VnZ2VzdGlvbiB0byBtaW5pbWl6ZSB0aGUgd2luZG93IG9mIHN1
Y2ggY29ycnVwdGlvbj8NCj4gDQo+IFRoZXJlJ3Mgbm8gY2hlYXAgc29sdXRpb24uIEFzIHlvdSBw
b2ludCBvdXQgdGhlIGJlc3QgdGhhdCBjYW4gYmUgZG9uZQ0KPiBpcyB0byByZWR1Y2UgdGhlIHdp
bmRvdyAoc2luY2UgYml0cyBtYXkgZ2V0IGZsaXBwZWQgYWZ0ZXIgeW91IHBlcmZvcm0NCj4geW91
ciBjaGVjayBidXQgYmVmb3JlIERNUyB0byBzdG9yYWdlKS4NCg0KU291bmRzIGxpa2UgdGhlIGRp
c2sgY29udHJvbGxlciBpcyB0aGUgbGFzdCBpbiB0aGUgY2hhaW4gaW4gdGVybXMNCm9mIGRldGVj
dGluZyBhIGxhdGUgVUUsIHNvIGlmIHRoZSBkaXNrIGNvbnRyb2xsZXIgZGV0ZWN0aW9uIGNvdWxk
DQp0cmlja2xlIHVwIHRvIGEgZmlsZXN5c3RlbSBsZXZlbCBhY3Rpb24gbWFya2luZyAnZmlsZTo8
b2Zmc2V0LGxlbj4nDQpiZWluZyBiYWQgYW5kIHJlbGF0ZSB0aGUgaW5mb3JtYXRpb24gdG8gdXNl
ciBmb3IgcmVwYWlyLCB0aGF0IG1pZ2h0IGJlIA0KcmVhc29uYWJsZS4uLg0KDQp0aGFua3MsDQot
amFuZQ0KDQo+IA0KPiAtVG9ueQ0KPiANCg0K
