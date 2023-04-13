Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4D6E0FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDMOPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDMOPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:15:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6893FE;
        Thu, 13 Apr 2023 07:15:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DCxUYt005257;
        Thu, 13 Apr 2023 14:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jQcmfHZ6/XryrLA2jCUa/OFqVUpCyXzmvrTAwRb0QsE=;
 b=HpFXQsSao6lV7qiB/7vr2nEbdV1JSyQtn2S1GElbVtholFIqhRJ/vfG01RV7hkYpA0Xo
 CjSuVPkBnN67PZDo64jmOZScNIBqvCiT/Op3LsYVHHxu75SJoKSLYjz6ku7kJETdDv25
 EnXhdC+PoNbYTka8Rx5l+Sr/E3ax5JEusFgpvrqBt6nebHqDpWU7ol9EggSUBrPAgyV6
 +1f4BLgZ4jLtjm+0Cw6u3hdoGX7z5kRZzpkWGT5ZkT0XtvQ8wvevPL5Zwioyog80LdSb
 vGAWCfIhW3ndYp6lJ/jtR3U3ThIhdcWLfnkxGMIsoYYM2mT+UMhAqj7dvAXLKgkUB/TR 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bw31wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 14:15:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DCg9Un039814;
        Thu, 13 Apr 2023 14:15:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbrsrx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 14:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR5XM05pUsue72sVPfUJ/oMitAEHG8gfjem01payN/F2hXmW/tDbcJeSC4HQymN4fWSvMxHasYVF/SSOXMuMXyXa7gDueFhVDjw85m3fp9UDI+4IPOn7b6pxm+VlzWQkPM/eJ9/hq/uLYF62b1UK1AQxdE9i2sJ3oSPJ9lGLKbaEN8lh4Vay5zzYGXw6V+wC3figphDfoMp7hXTd+hRkRvNW8Hkxg+4YaA+O3arpldf/sIwNk7ySECyssYr+YEyk7puA9IJn7D0uvdr2S1PJDrAWpMBHCN9cbs9Yk2NP41UqemnMZuHZwoHP2Z995FPlhvsxnP6nb1Ua+SsJoR+Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQcmfHZ6/XryrLA2jCUa/OFqVUpCyXzmvrTAwRb0QsE=;
 b=RhOQ1v7joHZ2SI1br2HuespiifbT5uKKvbP2VTp4JGi1fPqXcKW+LyF294QIR5MQlYdgqMwN/JeTUU9RbnM1k6HY7uSGRbTv3WJpAPVzLCC31L9bVD0lD9krIWPbzuKyQBFWawLauJDaeni52wLI6mK0Ho1OV485MOamko06kT3wdnnbAPRkhsO4Doer34IDzY7I5B24zOUZfixTXaTKOwtrn1pP60ayhEa7G77YO2tD/vp/CDEHQsv4NPAi13S4QIh5oduv6vcCvQdVFsgiTi4iOQzkkVv2qhCCpEDyTYPs3BQTzRBOrx7pvFTM9USzH6TyonTol+r0tjAgFfwjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQcmfHZ6/XryrLA2jCUa/OFqVUpCyXzmvrTAwRb0QsE=;
 b=IpQ/g2cxg1UgfO1jUlRB4sJvItmFFmuS6KRO3KqaKIboBmv3GaVPjsgkezgIe+hcEA7RBia6lAMaM53xugfiXFC5/pVVrdp33zCXGyVMFBXn/b+IwnzLf5T9m1Id9mKfwtlkbTTGO0Evv/VLtaLRvKQKXGI1aikiJlK4zPYMIbQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 14:15:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 14:15:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjHsN6sWZ220WWP7UeL6JICq8pRyAAgAACpwA=
Date:   Thu, 13 Apr 2023 14:15:03 +0000
Message-ID: <347DDFFD-39E3-4DC4-8A46-993D8C1971BE@oracle.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
 <ZDgMIlpCwfCKcwkx@casper.infradead.org>
In-Reply-To: <ZDgMIlpCwfCKcwkx@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4606:EE_
x-ms-office365-filtering-correlation-id: 04f385e9-6211-4d10-d0e8-08db3c29798f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Tijwx1yQzcqWLAk2CpyvQCsQ3FhKMTLYlRI5JqHjSaIUT5s6Pf+IPMqsyOrLCL3nqG9NaPH6vgg+Gv41rmVnohbKbS76UFxqpwPL+TEp5X5Hhe9sBXX+aVW/piSaH6SiGBc6fhEaiAwkY5fLmKK8o/fmzw/rhiPl+TjTld9aaAs7IO++hbM5JAvftv7rLfruVN4ktxZJ55yiNiy0b0vXqWO5NqbqLAamHpDoTAzr3cDJGhxrgo/57ufGTEKMzgHPR+Xo2q7tU6+gVr4J9bLjGOwmHqkmr/Rb/YfdS6HmbNZ6JQvr2oQJ+4MciRSHRkbOZaFYFHWvbbPbX4U2DLZi4g3i2e2Ii0DyzIICcMVgoEg2ax0tKs/6rUq5UoX0ad383OL+C6k3se+D+hSUkRCBHhZcomCgv9R6pWU1obKEvHb0eQ1HtLarDfrjr2/e9RLn0IIZtwcRbNUS/DAihsvfsZvKFvIN9HRM65Q7F9l4jLo+4+MpRbQyyNokE7hRfs7ZqaJWbai7LjgzzeYCBhqJmaxiZ23ItFyX3UtasSw70JzMo2YibewCwBe0pv8guwO8AGAOfyP6MjYrl4UKBTPyQy0RnOeqhOmHNh90DBjIAV7FS8uDWz404d5bT8vcRAjH4aCDQe9xqR8LbpyLwIw+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(38070700005)(76116006)(91956017)(66446008)(4326008)(66946007)(64756008)(66476007)(66556008)(53546011)(6506007)(6512007)(36756003)(26005)(2906002)(71200400001)(6486002)(2616005)(83380400001)(186003)(6916009)(54906003)(86362001)(5660300002)(122000001)(8936002)(8676002)(38100700002)(33656002)(478600001)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0xFMDA0aWNOeFNpNVQra3JxQlBlYkNVWnVJd0txMEFzclNjMHIyNGRSZkh2?=
 =?utf-8?B?RGdJSCt4NStqcmhVWngxRUdsM09OcGd3ZHNyZnhiQlFsZHliV0VHOTYvL2xt?=
 =?utf-8?B?SVRicWtvSFNtZ3pRemJUVWo1VkJ4anNINzJ3dXR5TVhZL2lDN0Q0UXBYWDdQ?=
 =?utf-8?B?SzRTWk1YVDZSMFN5SXY5Zm9YcVYrM1hrRTZzc0tzUXdmZndwaHB0Y1k4Vk5k?=
 =?utf-8?B?M29STGdCcjBuTG5odEtTQUIvMGphMWhnTFRMWktTOHJncGNUQXM3SG9yVmlP?=
 =?utf-8?B?VHh0bStwWDBoejF4N3ROTmFORUZUU1RVSzhCc3JWSklKaEEyNDI4UmtleURT?=
 =?utf-8?B?VVZqbXV2WjlqOWFjSWZ4Z2pmNkV1VzE0NXFRZlM0d0lGT3pHc2JaS1lHM1ln?=
 =?utf-8?B?MFhtdy9BcUJpWXNLM1RDZThJZER4dkZIdWZuVzNLdjdUb1FVa1lCRDF1MUV0?=
 =?utf-8?B?YjdQdlA5Y3pwRFhac0FSamVxckZBdThpNmQ4UUtQcFhCc2FRZzQvdG9ON3FS?=
 =?utf-8?B?NkxhaW4rc1Jpd2ZaSjNMWmo0M2RSY3VYMnkrWDZrZ0gwMUdIbUx3bkg0TEwr?=
 =?utf-8?B?dVZCRHI0SXk1d1p4UFJndlNVTVJERW9Bbko4ZGhGekFlNHpPVUJUMWVzYmYz?=
 =?utf-8?B?QjJnWWxURFZ0VzROMkg1VzRMMFlzNk9lNURJK2dHaHUxUFdsYWhkdlUxd3hD?=
 =?utf-8?B?QS8vQ1BJaitKYVd1SG56Ym51VG1qTzNBUmdkUWtNZm1XMWM4WS9rOVhoTXBB?=
 =?utf-8?B?cUsvOWVVMThPNi9lQStzWkpJdE1VMWVpOEI5VTUzK3MxT0JJMFhLNjc4THl0?=
 =?utf-8?B?WCsvMGg2ZXNOVmY5Q2JMY0UwUzl2M0Mzdno3OUhPcUxYeDFuTWIzSFhxbnRo?=
 =?utf-8?B?MlQzNm5lM0w3VVN0UlVzaWpjaFRsb2dmSkl1ZW5UYUROOUFFdFRCZThSYUxa?=
 =?utf-8?B?RE9YNHdKRjFUQXhtNUs0UlNtbVZQNW5WRFBQNGc5d0ZpN2E1UHovV0NZekVx?=
 =?utf-8?B?blJhVGlkdWdJR1hITjhmS0NKMkJlUkNTMjNJUk0vRkZadVpENmUzMEdzQUJs?=
 =?utf-8?B?NzdvdHd4djU5M1gyZVJPUDhjVjdlZHZIcnA0c2h2K2xPK0NZRUg4c0ppbHN6?=
 =?utf-8?B?Y0NiaFM1OHRvRlg2MVdxM3ZvZk5HcWZCK0xtbit4SFhiZ2M4cytsV3pSSDZs?=
 =?utf-8?B?WGtGZllYbEZUNkpMVEJza1VFWE90SHhJakVXVVVCdjl0TEZkcFk0RWhGNjRx?=
 =?utf-8?B?bHd3cDA5RS9ubElxTVFiV1FsOTZNMzBqM1lndHhKV0tteUdiZlZ1eEQvdDNt?=
 =?utf-8?B?Z21YYkF0Njdtb3pxUTIvdXRucS9xWUVvYTJHN2VUWEphaW5RakNtZDFpdkhn?=
 =?utf-8?B?V3FSdTgrcFJhOFVpVis0blZFTkM4ZnFsOWRpZklReTRwQUhsenQ0S0JadGpy?=
 =?utf-8?B?TlRTSi8zeGdkYUhZRlJQNmd3cGpTYzBHWXdFT2E1Vjhoa0o3bGRYNzZodzNm?=
 =?utf-8?B?cCtzTjZYWWg2YTFVeU5YcDhWUm9mU1JTWHg5Um91Ny81R2ltNkpxaTltQkNh?=
 =?utf-8?B?WmV1Yi9XMCtSZm1WczdnZmJKWVRXeDFCdnh3a1pTd2V3UXpNVHYxUVEyQTRR?=
 =?utf-8?B?eENjKzJXb1JvWU1TaEZiOGFaZTlWelJGS3JGVnZyREhUT0h4c1VhaXdXVnlR?=
 =?utf-8?B?M3NYb1UvTm9DWEpNMW9wTDRJVTUraTYxUU02Nmt1d3h3c0ZkbTFtVzEwRHRQ?=
 =?utf-8?B?b0t5TldXVnBjSDYxMEN0aDJ5NDNUcjB5dDhkbjZMcWRtODVJOTl2d2N4VzdQ?=
 =?utf-8?B?M3pjc1Nuekk2c2txMmRjdFcxckFPRmxPd2NWMmdpSHVwRjdqeHRhY3BvNmtK?=
 =?utf-8?B?ZVdCRUowRU1IblNTQ2twRE1pVkpVY25ZbHJZQkdlM3ZmbzgwaTlIaTZnV3ds?=
 =?utf-8?B?em9TUTlHM3FKUXBmL29VWWVOQVRMRFVLRTI0MGd6RVlKTVNCUnZMN0tjNE8x?=
 =?utf-8?B?ZHZwY05xNFZmU2JObzIvUmI1cWgyd3NrVkNuL2dDM0czREN2Z0tTMElyNmQ3?=
 =?utf-8?B?VXdYZDd2YWFKei93NTUzQk9DUjF1QkhKcU9IdEhDc2VYU2g0V0xWV3RZMlhj?=
 =?utf-8?B?T0FBT2ZUMmp5NkFlRGpEOU1xczBwTm9HaWlCejNHMU13M1ZDY3FrWDBTU3Bk?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAB6DA8DEAC67D40BF3D277BE6C4F86C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oJW19BC4gDHVaIuxVagW8o8kYdVw80FQ/th1/LJ6S/OMQkgHevf0130/Gi5mMlEUnqeUICk6pHxXhuxFyyJitam9ZHXoxlRtuYk+7jqCzd3kJJRKjJxeg576ovXTIOcJqEtqxW2SYIRQiqsxTbBJH07O61Oh1ox586y8a87IymoJZsI+7HsruA65u1mZhFyZrPcWK/nN7DkKYdrzLGC+CUVYT+IMFmiox60KkB0KoVxOURwxmesSrzgGY49O2msnEt4k+J0fOGvQsF4ChgyWNFiQqCztonANhXo+8E+ZVGdDRVo3jj2Q65eSugoyLxpW2X59WPma5Dj6hDfSCBIkQb6NuX4yVGY4IqYXBUdwLjb04zxgw6J3W17DWYO80QTZYKHMtW38xBTa07/aVnWOBg1DMhDdJ64EdMkKe9LItxcf/ziNFsKv5BV+WAUJYqFjrWRQ/H15erbjTQotyYRj+9dOLHnZIgTD3Sj8rOJOFL7D/6tujGTTUaRXjk+tEthFyEMtVDd8WUD/BE0DUCKiy4EeK1KVdYn+3L12rTF1lyIPLYrT/pYjupayA8Jb6L+EUr2MNZFLbraQb7GUwlXnyuXrR5LHUKSUuwDhoztei5j9JDNJDOE/k9fJ8gBEZlXrrhL08ZnggJtdUaBetTyHR+EPNpkx33PBzn7NtN2GAQdZz71VE+mlryRGwdtIvApjbvL/sZxlNKXb+Xvx5KePJSlL+lRwQyWu0L+sloki9ntOOAAwKnaX9ntIsaUA/wrXjpxVXu4X4r0f/zTNja/u6aDY9A/GGLCHnFktwINTe93BWXc0RU5zLot4tkmEOgRbaUGhf6CMQ2TRKO22e2RyGhl2I0348D1xG9mGvnpLcj6yQVk71H3RouylamEiMMop
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f385e9-6211-4d10-d0e8-08db3c29798f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 14:15:03.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDHdn0nloyvVkaojcaiSqBEUOcWI14Dbi9ePIEosRimP43uPGb0QXC5zfEZooYR0h8x6FxatFH7wLZGGTkZKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_09,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130127
X-Proofpoint-GUID: kwofbu2jwDQ1k0OaXuM5ZTtY-IFGesnf
X-Proofpoint-ORIG-GUID: kwofbu2jwDQ1k0OaXuM5ZTtY-IFGesnf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEFwciAxMywgMjAyMywgYXQgMTA6MDUgQU0sIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDEyLCAyMDIzIGF0IDA2OjI3
OjA3UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IEknZCBsaWtlIHRvIHJlcXVl
c3Qgc29tZSB0aW1lIGZvciB0aG9zZSBpbnRlcmVzdGVkIHNwZWNpZmljYWxseQ0KPj4gaW4gTkZT
RCB0byBnYXRoZXIgYW5kIGRpc2N1c3Mgc29tZSB0b3BpY3MuIE5vdCBhIG5ldHdvcmsgZmlsZQ0K
Pj4gc3lzdGVtIGZyZWUtZm9yLWFsbCwgYnV0IHNwZWNpZmljYWxseSBmb3IgTkZTRCwgYmVjYXVz
ZSB0aGVyZQ0KPj4gaXMgYSBsb25nIGxpc3Qgb2YgcG90ZW50aWFsIHRvcGljczoNCj4+IA0KPj4g
ICAg4oCiIFByb2dyZXNzIG9uIHVzaW5nIGlvbWFwIGZvciBORlNEIFJFQUQvUkVBRF9QTFVTIChh
bm5hKQ0KPj4gICAg4oCiIFJlcGxhY2luZyBuZnNkX3NwbGljZV9hY3RvciAoYWxsKQ0KPj4gICAg
4oCiIFRyYW5zaXRpb24gZnJvbSBwYWdlIGFycmF5cyB0byBidmVjcyAoZGhvd2VsbHMsIGhjaCkN
Cj4gDQo+IC0gVXNpbmcgbGFyZ2VyIGZvbGlvcyBpbnN0ZWFkIG9mIHNpbmdsZSBwYWdlczsgbWF5
YmUgdGhpcyBpcyB0aGUgc2FtZQ0KPiAgIGRpc2N1c3Npb24uDQoNClRob3VnaCBxdWl0ZSBwZXJ0
aW5lbnQgdG8gTkZTRCwgSSBkb24ndCB0aGluayBpdCBpcyB0aGUgc2FtZQ0KZGlzY3Vzc2lvbi4N
Cg0KVGhlIHBhZ2UgYXJyYXkgaW4gcXVlc3Rpb24gaXMgeGRyX2J1Zjo6cGFnZXMsIHdoaWNoIHRv
ZGF5IGlzDQp1c2VkIHRvIGJ1aWxkIGFuIFJQQyBtZXNzYWdlIGFuZCB0aGVuIHBhc3MgaXQgdG8g
dGhlIG5ldHdvcmsNCmxheWVyLiBidmVjcyB3b3VsZCBiZSB0aGUgc2hpbnkgbmV3IHdheSB0byBw
YXNzIHRob3NlIG1lc3NhZ2VzIHRvDQp0aGUgbmV0d29yayBsYXllci4gVGhpcyBkaXNjdXNzaW9u
IGlzIGNsb3NlbHkgcmVsYXRlZCB0byB0aGUNCml0ZXJhdG9yIHdvcmsgdGhhdCBEYXZpZCBoYXMg
ZW1iYXJrZWQgdXBvbi4NCg0KTGFzdCB0aW1lIEkgYnJvdWdodCB1cCB0aGUgdXNlIG9mIGZvbGlv
cywgeW91IHRvbGQgbWUgdGhhdCBmb2xpb3MNCmRvbid0IGRvIHdlbGwgd2hlbiBhIGxhcmdlIGZv
bGlvIGlzIGJyb2tlbiB1cCBpbnRvIHBhZ2VzIGJlZm9yZQ0KdGhlIHBhZ2VzIGFyZSByZXR1cm5l
ZCB0byB0aGUgYWxsb2NhdG9yLiBXZSBhYnNvbHV0ZWx5IGNhbg0KZGlzY3VzcyB3aGVyZSBmb2xp
b3MgY2FuIHBsYXkgd2l0aCBORlNEIGFuZCBob3cgdGhhdCBjaGFuZ2VzDQpORlNEJ3MgaW50ZXJh
Y3Rpb24gd2l0aCB0aGUgcGFnZSBjYWNoZSBhbmQgZmlsZXN5c3RlbXMuIFRoYXQNCm1pZ2h0IGJl
IG1vcmUgYWtpbiB0byB0aGUgInJlcGxhY2luZyBzcGxpY2VfYWN0b3IiIGRpc2N1c3Npb24/DQoN
Ci0tDQpDaHVjayBMZXZlcg0KDQoNCg==
