Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344FA6E3A13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDPQC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPQC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 12:02:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E819B4;
        Sun, 16 Apr 2023 09:02:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33G5wOFM002853;
        Sun, 16 Apr 2023 16:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dVgwloa9Q7vRAOnro/SZ6L1eXdFgydS4Fpc7rSNtnU8=;
 b=SaUisISB88QVcUfxOC+GlMfN3/duftJQJmInkdDAehgOEvUpgP7M5j5ZchwChN2GUAUg
 6syz4bxTpHiqQqfQRMPXKRUN7GAr6Iy59WxJOfMo5UDtAMBS0P9XaUDAR/Qsp/MT6hqk
 ZY9E0ALg3MiixVWKI9I8Ez9vvWBiwFmPIncQKTZVnODGT8COFnagd7OwZPPz9CEZQ8LQ
 bzSGVZiUk6p8jHF9Ts2SJh6p+eoa7KhCVl7PsZU0P8akh5VrVHG7N58qNo1PZn/5rZGG
 s4eKEgk+WItHgRZW3NLiaQlIjcKHNlRET1eJFOIxTgExkrYe9TJlOGEpHw3l4hFEeHmj eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhtsj8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 16:02:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33GE4nGd023034;
        Sun, 16 Apr 2023 16:02:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc312bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 16:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGJwrLC09hVDypDVITHbh+y7gkKfqDbTQRgtKN2QL6yZNq2JqmqaT3zg002ryxioZu82Wg2XXuE9BqAdCsfm/PsNjZLdNf7qOZ9alaZnDwkofQduDVivIZDJTp6yW1I5n54Pwf6XZheNEW/s0DcRrC720f49z98W//vl0ctaL1RhpbpWlXj2L8jdG5iZI27e0hmFSpwZhnyO3O8r3Ym2abwOteNE7H0Q9GSSlDoaFV71kTrcFF3qiIMR9rNtigsRa3q15axBnCfmh/erVoqid33RntkaQcZQHNo+IQNUJOAmwpOHgqCF+tNW5ZWgn68eu8pmhbYw60PZU+hciSccfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVgwloa9Q7vRAOnro/SZ6L1eXdFgydS4Fpc7rSNtnU8=;
 b=majuR7hAxFe58YcSnHtE/PHAVSNE5C4NmBgsv56Vte/yAFJAf28NyuCRFYMbn/tzTzAHUJTQonrPYXx5aQrQkMNDMNZuQyr7TppfDmxcHDPHiV9/37MS9sC+8HyVOROWHzf6armD61ZOvQjFMyRR+jv+khcCi+lcXD/GcJ11feUPrPRGi9SXakbsOnNyBzkLt5MZl0gp7tI7PP1u4dFF5mz4W15zAd0MWA/vvX+DUOsetE22qqswP+dzYaJafnFiojzhdpKX9fYKxhtt5NVUoRClHE5zqYxYNA/DSIyH84Yl0HXMGcC7VSwn7lRT1RpnkCAd0w9+mt4lFuVelrDC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVgwloa9Q7vRAOnro/SZ6L1eXdFgydS4Fpc7rSNtnU8=;
 b=N5B6tRBmWd1EydeLWzFxu9SNrJ3yFHpqqe1+alg8FqPT62qLbeBQg4J86qPtgleojtwpVBNWpVGMpZ1y6IMKTbkwMi+k1XZwbRQdbp5hNQeadunBy0fSNKQr63s/dRRfmrBkKEY1l+5eRmG+8BHS1BNQiS7W6dht55eReHA56es=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sun, 16 Apr
 2023 16:02:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.045; Sun, 16 Apr 2023
 16:02:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjHsN6sWZ220WWP7UeL6JICq8slYaAgADFM4CAAMQDAA==
Date:   Sun, 16 Apr 2023 16:02:16 +0000
Message-ID: <16485039-DE04-4E66-AE08-C1663B150DBD@oracle.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
 <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
 <CAOQ4uxj8b8gV02ybuBWMu7ppBc9phrd8J_XMK_bwOYb+Z5hxCg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8b8gV02ybuBWMu7ppBc9phrd8J_XMK_bwOYb+Z5hxCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4432:EE_
x-ms-office365-filtering-correlation-id: b8bcd119-90a2-4b61-dcac-08db3e93f382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0sH1fu7FrLr1uz3ZQpK9r+HvtVKR8zSB01+5l4o39b0lmKMZ8SdHYzPy+kWfKomO7q3sfsETH5V9FzXHcBU+lRTTGMXItf5bcNbTAxFZ8ZgbrS6ssCWENQ2coh54jxR+W07II/huQsxqh5Msy0/ri68UCAAj6s6h0pXD3nBdMXgvJlmPEVvyhxgZRPfzMQXRH9RZasvoqgMie07aQGSmY7jlhjEamQ1VPvwKVhTqoA7s3lkGCNpQGNRX1hD+w7apvypoh+csZnHP3quOL1ypZR2N49L+7zUj7/YO6gThdudbv4S+AlHuWFdDO2hMx90YWQaH2f/HLXVkiqwcZicyNOevuVLcQJp+Xtg/QzkRG8SzB9Y5hh1fFjq38fZrayLpGvNmZY6PDyCvxfjgMB8OHcAqqEb/Cqi54D9eA6IRxGgvpJ+yTH8EZ131KvbL40/zGMbd9IewJVljTXsrGdvMspJ5jO3x4Q9sXE17p8DOOvkBRaTuWaLI25Lq0aG4d44iWcqZ0Z/20MQNCH7yePb0HWsL9PLqOBN5e5SZSTKTvE38wP6RWl2+KEH01DKWuUI5ZcQxu3GCTl+Ryk5t+U20s95YTHylzNWd5x67LsMNh3YWHmoo7ZzdVEmx0GVzn4lauMTKfqJPlYB4w9Oq91cpHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(26005)(66446008)(5660300002)(122000001)(36756003)(38100700002)(4744005)(86362001)(8936002)(2906002)(8676002)(64756008)(4326008)(316002)(33656002)(38070700005)(66476007)(66946007)(41300700001)(66556008)(6916009)(2616005)(91956017)(54906003)(71200400001)(76116006)(53546011)(186003)(6486002)(478600001)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtwNTNiVitYTnpXd2VYRm1CblpOTjlGM0VjRXVwMU5HdkoxWkhXb1B1a1Rn?=
 =?utf-8?B?YlptVFdBZ1RMQlJ6ZStDR1dCbnV0RmVzckNGVUxhTGtXSFB1MVZmdy9zaXEv?=
 =?utf-8?B?NXVKV091Zk4xOGdMMkNqY2tBcE1LOTNZaU53UitiQjVhNGpxMkc2b2xRMmFi?=
 =?utf-8?B?QkUxUDRma1JsLy9oNzJjbWxzVzdCWERlVzk4MXJiazdoY2hDTXRTWDRpMkpa?=
 =?utf-8?B?TDc1YURpenUvQ0pmYUNyWTJWTHlRNElESG5mVlBhbEg4NU4xTnhjRE5VYlF0?=
 =?utf-8?B?S0NjZGRKUFNsTXhYc0lFOElncGR6OVBhZ1lqS3VHaFMwVmNVdXJPclFWcUZI?=
 =?utf-8?B?NDRITWNVZnBLcE9ZdnNNaU1LVmorbGQ1K05GdHVEUmdWeCswWDNTMnRiMGZT?=
 =?utf-8?B?d29LQlNhbHNoUmQ0RFk2TDA5SlJPaVpSS0pBWXhJdm4yY2c3cHJoUnlpVmFX?=
 =?utf-8?B?U3RiNmZ3WFdvQ2UxcTN6OXJlWlFTSkk4a0NWYzZtQ29DZ2JGSFBEc0hqbmNz?=
 =?utf-8?B?ZXhCSi9OOE5ra1doQ3h5VFZPVDhsc3Fic2lLbTdVLythZHRlUHI5akJ2OSs3?=
 =?utf-8?B?aU5ibHRlbGJnSVRFVzBscXlGc0RZT1pyY3dTemVEdmp3c1hHSFovbDFQUzE3?=
 =?utf-8?B?NkdWZm1yOFRCa21taW5GeEQ2a0RsT1k5VEpKaDZtdjFhVE9aU1FibVBLTGlh?=
 =?utf-8?B?azYzcjlIVnRxNFJUZlNJQXU2MmRqK0J1L2U2anBodjJKT1RDS1RVT2xOMVhX?=
 =?utf-8?B?QlVURWh5ck9OSVV4cmszSjQ1Y09TdFhxREYrdXdFZWJQZEpwOURqaGNpQ295?=
 =?utf-8?B?NEkwd0ZGcmd3YmN0eisrbC9ERGcxWlIvRG9oNUZrSjZxVzVmcnFnNGFDMWlD?=
 =?utf-8?B?cHhoN0g1MXZPZFB1UnlHVHp4WnAzY2hsWjJQMXZhTWJVZEpGc1Y5UjZXVGN6?=
 =?utf-8?B?SU9NNDA1R2w3bE5kQS94eGdrL052ajkwbENuOHJRdFA1ejV0cnEvcHRPYkxo?=
 =?utf-8?B?QWpPZ09NdlBYOS9nVnVRMk9tR01ucHBrOE9LODcxOVFoUktML05wb0pOcHN0?=
 =?utf-8?B?ZURMYU5hUXBaaFdxa3FuMkVZeFliQi9hREFuQnNrbmNra1lHOHg2NXV1czJz?=
 =?utf-8?B?WmZjRE1YckFPdGRzM3RzVmZCQ1ZCNk1RVGJxeFhXQU0wQnVkcUd1QVU5ZVJV?=
 =?utf-8?B?anAzQmlTQVd2WDBBUmJDYU5Qd2RxRDRCT3k3aDNXTDg5WktsbGJtVWhBUDJ3?=
 =?utf-8?B?V2lnTHhDa29tSTM1bTJrazY5MkVNV2NZRVVTOFozL29ZTGszenhLYmhSODZ6?=
 =?utf-8?B?bU9tQkJRemZBYVZnMUplTlFQb0ZibGpzWWFLMExYMlF2c1E5NEFtdFdCL1lU?=
 =?utf-8?B?TTh6TEc5RGEvVmZyNWlJK2NqaUpzVlZuMG02UG5ka3FPUHJtZTBGbU9mV2xR?=
 =?utf-8?B?dXc1c3hTVEd5anJxYTJ3QXcvemgrUjJLUld2M1YvYUYzckxQWnRvc1E5Y0hK?=
 =?utf-8?B?bnRMN0lIVjZCMFluOHp0TXRaM3lRUVVETUw0TTFDaExseXBBMHFzakVjTU5B?=
 =?utf-8?B?VFpDQ3hxdmw1Rmx6UTBnckwxWGwwUFFseFdIN1ZabjEvemo1ZHB5OVVzOEVt?=
 =?utf-8?B?amlKMDcrSWdoUHhvOWxQMTNsaWZPY2xuUHZodGo2Uk9kbDkrcXVXVktZYmhD?=
 =?utf-8?B?YWE0NjdxUFA5Y3NlNlg2czNsWm1hYXdrZDE4cU9laVNtdVJhV2h0VFpuWHNu?=
 =?utf-8?B?OHM3SFNyU0xYOEpiVDJnU2ZXV1FZUXJrTjJrbDEweWgzNk1PV0drS2V2QStt?=
 =?utf-8?B?aWxybENXc2NTTTdjSHRaQzY3QWJCdXFNWnk2cHRDa3RyR2JDd0RQMlU5d3lQ?=
 =?utf-8?B?eStoT04xenhTTVVZbVY1MFFISDNwYVRwcHZPVGgyNkRCZU1NWHVuQnpKODJD?=
 =?utf-8?B?QWp4L2R2bDhqYkY5cnlGUjNMVzZnQ3VMTmdqcTdhbCs0OEpad2VzUXYrSStH?=
 =?utf-8?B?UTBQclJUejN1TnVKSFA1R1ZvVU5VSmI4R25WanRGUkNDZEV3ZkxUSmxEQUJa?=
 =?utf-8?B?cGRrVG9aU0t4MU5LZVVsT2VISWZLU1R4bmxHTjg5Kyt3WWlVbnFLYjJ4UUlW?=
 =?utf-8?B?RS8rT0ZNNGVPQjRoR1JlamVoR1ZMTVVIclBOVGEzZmpmeGpQdU1zVUJyZTNH?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40BB5B41E9012F4F8F0E24B21D06096F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8YEe8ivRFW+sIaRyIP/oPXBlMu050LH8qYb9PTGQvbXJ2XQJ8DEf6ZjOpmiCKJVZaBs6fs1LN+nU0IGE4/9pcVAegXXf4sQt0XGw/+r7PO0npXKmKsff0FotGWcCSra+w9Z5KyzT+ati3uxynA2yaDg3g7uLqORj/z5DvtH+1SXPOkkPoEXJxfqpB7hY0RRZCu0mAGt8/VgB9SsEkL0L6EBV56oLmo59coaM+/qXjKLOxWrSvvMf7Pez4EZI7/dCmxMFbTvaTeXn9kcFBGEI8ooL5e20BoCd7DgSB0LapsjqN8ykfUM4RB6lTdV/coz1ViEMQEzzWrZ2geIGLo/GR9QTqxbV8gnQ48o63uqGJ7qzuiL8Rzy7wWFQAlKi+XDxCs0ZeTp3CKf7xZCYszOoLopj1Vsg5CNsx3vAQM1+MrCskYgJqCuDW3Ldd+o+h+KLgN8ClD+YRvKQ+QGHcuI0ynaplntA9fdFCTL1cq/Tjl/5T/0yDCwhPchb6zkgEL/J3cfqkE92xc4qxtbupaqlYaVotN0/88gn52wKFcHIoqUY6EKPEgPPrm62a26Xvd9CV5h4E4Fa01CXRfDIfboY6tYM+RYE/sG9EoYCK4gJ3KVfk2MqNh97MrH1fDwNsLnIJaiVQ6mmGLpLgZDc/5/NcANPiTLipFcylBn0wKu3VdET9EsXWa03flEVMxoeJei7t3IfFkUzs2JAvZjTLcW+v+lDoh4aAZGbAAlWqjvbfv7GBFKY0VzfjInNdkqD1bj24fQPUeTz2+HQ6hxZrM7ErF0wSpW867+bmSBLpYGD1cg9BThc4X+/bSo/RRSF0YepH7KjSmglTeLsclYqgqKQlZsC7xwKIxRt2XcasyLK7oQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bcd119-90a2-4b61-dcac-08db3e93f382
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 16:02:16.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsMsoa/NbEZfYPTyVqHamktPb2B8Gl6Yuez0hSAYx5+/D+VzFQbsUZMJwrfgCnQOxrvFKbGtRnZrt9crVGMZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304160150
X-Proofpoint-GUID: IbIzVbXf1awlKvy7uJeoosr_kB_9cdxt
X-Proofpoint-ORIG-GUID: IbIzVbXf1awlKvy7uJeoosr_kB_9cdxt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDE2LCAyMDIzLCBhdCAxMjoyMCBBTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIEFwciAxNSwgMjAyMyBhdCA3OjM1
4oCvUE0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+
IA0KPj4gDQo+Pj4gT24gQXByIDEyLCAyMDIzLCBhdCAyOjI2IFBNLCBDaHVjayBMZXZlciBJSUkg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gICDigKIgTkZTL05GU0Qg
Q0kgKGpsYXl0b24pDQo+PiANCj4+IE5ldHdvcmsgZmlsZXN5c3RlbXMgaGF2ZSBzcGVjaWFsIHJl
cXVpcmVtZW50cyBmb3IgQ0kuDQo+PiBKZWZmIGhhcyBiZWVuIHdvcmtpbmcgb24gc2hhcGluZyBr
ZGV2b3BzIHRvIHdvcmsgZm9yDQo+PiBvdXIgbmVlZHMsIGFuZCB0aGUgd29yayBwcm9iYWJseSBo
YXMgYnJvYWRlciBhcHBlYWwNCj4+IHRoYW4gb25seSB0byBORlMuIFRoaXMgY291bGQgYmUgaXRz
IG93biAzMC1taW51dGUgc2Vzc2lvbiwNCj4+IG9yIG1heWJlIHdlJ3ZlIGdvdCBtb3N0IGV2ZXJ5
dGhpbmcgd29ya2VkIG91dCBhbHJlYWR5Pw0KPiANCj4gUGVyaGFwcyBhIGd1ZXN0IHNwZWFrZXIg
YXQgTHVpcydzIGtkZXZvcHMgc2Vzc2lvbj8NCg0KVGhhdCdzIGZpbmUgd2l0aCBtZS4gSSdsbCBn
aXZlIEplZmYgYW5kIEx1aXMgdGhlIGZpbmFsDQp3b3JkIG9uIHRoYXQuDQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K
