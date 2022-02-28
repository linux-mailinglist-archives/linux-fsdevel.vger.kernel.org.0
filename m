Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A74C61C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 04:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiB1DZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 22:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiB1DZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:25:23 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761749C9C;
        Sun, 27 Feb 2022 19:24:45 -0800 (PST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21S2Ds7Q008538;
        Mon, 28 Feb 2022 03:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=oYLhg5ECiY9cNbQiDjl9a1TT+Y4+VtWc0MOqr05bNIE=;
 b=NsKgqNS/WiGb26BiUv0LTVGec501W+/xPChm/keuhHI5dpQs/GunR9CesTJ9jy7Jo+hJ
 MbkPH6/oMaUA4INRhYd9nzuDlahvMlrmUcgTuFbd+NS6+wJjLmqP2ySlkpCWeORkjlQM
 2R5zbVlRV9NRoNf/M263+WeplIJ75sLxWVtq425jG8MYbEhtYU/mJ+VIjIP72oCKTunn
 6C4NvGCx0nCt2H6Yqby7TBoShFWK69vHKfexS3qTwfNjbAxnt3E0D9cgVybZp+DxCjRp
 I6EeeqFr4HRnIIYwpmYPpaApHghbLfzzEkzcB7eM/hDgwZMq7I4+/OG7ZJda812NnkMQ pQ== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2056.outbound.protection.outlook.com [104.47.124.56])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3efepbs4ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQirJusUYcRz3talaeYUieRmy9+vFY04LMWShlOZBJt6iQgJ1Oq4sro2mOlAwED7qGtq71z6b3v+MsfnXjT1VWat9HLFG/a5aPqsqZ1DDPUz8k0WXBNI+8sSLkeJ+YGxeHJ6Ha4uRTrxeT58gQikmiGjVTbp1hmhYv68zVMzCBuwY1reI9wUa+O47ZcB5Kuv0/9p2JCdKu6rJgqv+f2uTH+SKPQ2n4LmrcoMWbbOFXzkkQw1YZRhy9vIleNaZUbve8vH0I+DSsvOlBkQFn3l54ZY2W1bTUmtJ3Elv1P9sPkGG7J+AkhxJJctKq3n+5E58Zc8T7KWnRhovvyFa8evqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYLhg5ECiY9cNbQiDjl9a1TT+Y4+VtWc0MOqr05bNIE=;
 b=AZbgxzHsJivjOO5ihj4gYY7sECVg+HtAr9xRZpgZ/IURu17K7Nx5xX0ClBJwgOW+fKAr39wd3Zg5Wln2UalRfmA9LbwJAAzf1prT6vW5ZXw3TRnRqRSrZK10Ypn9fbnjGyixKK5y+3ON5kF0iSNl2b+avlHS6b2VE/Vqa7ebJaGX43WpJLNC7C/8ZuZ8SiDH8u3ZSxS4wjRDmu+LolgQ+cHKlhmsniwhRwlYpaw0qKhbUT84XVGqy8J2kCoqOB1XLywODwL0CMMFLSSvYbVA6KmagiFrozFnqz0lkcyydYqeLZo+JElsRpSsISr3kcaFgfcOGUHmcy9wiWY0FrzHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4509.apcprd04.prod.outlook.com (2603:1096:400:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 03:24:21 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:24:21 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayJLtGwgB86qzA=
Date:   Mon, 28 Feb 2022 03:24:21 +0000
Message-ID: <HK2PR04MB3891A18281A56DD2D3492B9181019@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <HK2PR04MB3891BFAB9DD271F5330D37A1812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB3891BFAB9DD271F5330D37A1812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc3768d-1222-4759-8003-08d9fa69cfe7
x-ms-traffictypediagnostic: TYZPR04MB4509:EE_
x-microsoft-antispam-prvs: <TYZPR04MB4509EE2265DDD2E66B6482D681019@TYZPR04MB4509.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpTuBc++wCUL2fcrVx26Fgefvm24UAKr1My+amq04Pso74mY8qToxM/N92N8PdH/IudoeQOaM3DL2K7lugrZO8yjlpCyQ65r5RICbbu+UzzC3RG8O3Tc8maFRq1qQpd4+4S9eaeU8tfaE8r1ZcugH4MzwN69R8Blx+RY3wTmkZQmsrFf7Zu7ZW/+JtiSkrOVEMccaM4RlYRPG1DlafioVeknakU0Wnnm2b2MqZa7hLeLOX/4kYzqWp69wdtxe1nH/D5RR8qJYpHvqZ0NuR6zNvEgpktYMDR2YIBFSa4Teaa5ysPezMG1do3+T1IItqDbd/U33VckVUQzqJ0Cntw74hUCMXvaa7h/0KrGYMnTZUd1P+gFuO/GHhuKcPYsJI/ZF/s4fPN1jjK6IDvL5BHwPYCwCNMux+U1xc96tdXa3C0gAO1/nadio2q2MoScbYS3GCaeuWHe9vRgxGN5LN1au0jjumRaoSI4kSsnUcC+zNzgb89h/Nzhk+OADFwwAsLFZKFTtwc2Lel7Cvr7sHOy6U3CNRSMEO4UH/8C/7pMXOK8ZQ+dZncrN6C2mR2PQpx0/WeZ/c0s7J9V9A/qPz9i1LMk/Uo8Sic4Uczr/o5Of2kuL0WKkjzp9tiREsv19Ye93Vd9T7X6ACfTQejevPLe7tKVrYF0rb8mgUqtGWmft2iw/XiWslzj/Jkr6UUF3plBl1ZWII83D/lIj0Z8VOVXBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(76116006)(66476007)(8676002)(66446008)(66946007)(64756008)(4326008)(71200400001)(558084003)(38070700005)(55016003)(82960400001)(122000001)(6506007)(2906002)(316002)(38100700002)(52536014)(7696005)(8936002)(33656002)(107886003)(26005)(186003)(110136005)(86362001)(5660300002)(54906003)(9686003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0JTVm5vcXNCOFhEZzdOS20wZUw3cWZBeGNnUDlSVE04NWtSOE9Na1Q1b1d1?=
 =?utf-8?B?TFZaejRINkR1amwzOHBibjBiMHlocElhQURWR2wxb2VpR3pnTERHdituZkVP?=
 =?utf-8?B?ZWEvSnRLb040LzBwQW5HSVdjT1lyZU1OVUpIbDU0cHdGVlNuYmJ5RUtZMUl5?=
 =?utf-8?B?UitBL1lNRk1HTDRyVUlCV0c3ZTVEK0h6cDFnbHAvanYveVZDUytGb1NFK3ZM?=
 =?utf-8?B?K05sQ0pJWVh6YVhTOVB5eHlOdXAxMXY1UFp1eDdieVJBRUl0YzlSQnpZcEUx?=
 =?utf-8?B?RG5FNElVeFJTakVrMXJKQnN0ZlB4QVNINDBaWldqdkhTVW5tT1lrSisyZk1w?=
 =?utf-8?B?UnNrL3NRUDR4QWx2TUlNTXJyVFI0K1hpOEIzODczaEYxeGFvbFZIbmJ6Y0JW?=
 =?utf-8?B?aXBndDlWY290ZmhDeHpyQ0sybWphOHRIZXR6dFJWZjUwa3gybU1OL0pPSjFp?=
 =?utf-8?B?ck55eWlNNWVOaXhoZmkzVEpRTHEzL210aUdKTHAyWnFQYlFaOUNMU2RzM0dk?=
 =?utf-8?B?bFZhYnFUK3E4eDdIbjBvVVFWOVBXOXRCM2s2THZQdzM0bEIyK241Kytqek80?=
 =?utf-8?B?RVB4dzM0TURPWXZGVW5uRXVjdjNISUJRRUZKYmFhakUwOEE0QnpMQ3MzVlRM?=
 =?utf-8?B?bUFmZktaMk44UzFYVE1qZ2Vpc1FkTFJLVW9jWldZQm40ek9iWVQ4Z2Z0L0o2?=
 =?utf-8?B?VzMyVWdDV0EydXQ5TFVjalExUi92TFdaN3puYyt3WW10cmFMazV4bVNDS1FB?=
 =?utf-8?B?MXovQWtuYjlrL2ZuSDZuY1pJLzFVTVphYllRRyt3ZndicjVFM1J6QnZXY0lP?=
 =?utf-8?B?NEZoSTF0UkIyUHVYYWZoWU5RWVJCeWNNaGhWRTFJRDNHSUx0bGttOVVMcjRK?=
 =?utf-8?B?VThpZ2g1VlFqV0VEdEpoaEtqelRRc2gvVUZnY1h6QmNQQ2o5bVEwSnZ5c0pQ?=
 =?utf-8?B?bHlHVXA4UGxoRWVIWHNsRnNobGxNdXRDNkU3WHc2NWNhU1hOUFlwOEJSeTg4?=
 =?utf-8?B?dWNvdTJwdWQvRXROMTUrYUMvVnNXZms2bm5pUHN1cngxR0RXUDFrNTBDOUFK?=
 =?utf-8?B?a1pkc2xRaSs2K0FkT211WkxtcWY4R3BTVlhZSy9aR1hnSkdLZG8xVmt1VHhI?=
 =?utf-8?B?NWNlbHlWMEUwTEYzTW53aVN6VWlvcEtlTUYweHBPNzRWQ1pjZ2twbHJNK2h6?=
 =?utf-8?B?MW1oTWFnTWIxZUREWS9nTm5HL210SW54Y0pGMVVqS2dkcUhBRHF6M1dlbWti?=
 =?utf-8?B?dUN1SjNqT29mYjJobkNnTWxUWEs1T0RqNU01WXJTejBabG5CaHdSQSthU2xu?=
 =?utf-8?B?OHhBQVRTYTIzckhJWDlRTkZpT0Zpb25rWWY5VWtCSUEweXZqQnU0RlNueXoz?=
 =?utf-8?B?a2lzT3I5OVN6TFFmMDNEWEVxMVBDRnNPNEdadzVUb2ViRmtwVFBHUDVzR3pt?=
 =?utf-8?B?WU04cVVENnlNNXlueUp2eXFxSXM0YlArZHpydFM1ZEsvNzhDSVNwR29xL1V4?=
 =?utf-8?B?RjJSd01WUlZJT2o5OWJFRkZva0FBKytseWNGWW9aWTNVQm44a1JNbzUrS3pW?=
 =?utf-8?B?N1BPV0NNaEFyMW5KRnQ2aHdqVXVMZ2dkZ2FFVEdSV2NaSEZsZTkyVTBqRUJp?=
 =?utf-8?B?YkJLRiszdURTRHlDT3hiMkxyTmFaYURkdENRb2tPSXNOeFRJWkFJRkk3dlNi?=
 =?utf-8?B?cWFlK1NJc1hnMFlWV1JTYlZLWERuRHF0STFWeHBXT0FTKytPbmFCYUQ0TW01?=
 =?utf-8?B?YmFqZ0FDY3lMczE2MkY1eUxyanl5NXFCUzhyTGdGZFBER2tWNkxLdW45ZVky?=
 =?utf-8?B?ZEVlK0xzRE8rT1NlaWZ2azQ5Sm5QVHZlVGs3aFpkT2hyamhOMFhyMGtUdmo2?=
 =?utf-8?B?djNRRGRUdFNad2Nid0hSM0JEYWkySUJoZm0rbGhZU0JoTExRVmVwbWZMcVp3?=
 =?utf-8?B?amNFUHZjQjhtQVJ4UHhYQTlWQWFXL0JyelBOT0x1WDhDTEZkMi94V1ZobjFJ?=
 =?utf-8?B?UmZjSEswQ0g0czRKL2tMaVl2QmNwVnRBTVNtLzNUa1NOSUVySmhLbmNZRHlV?=
 =?utf-8?B?ZzFBWGxDelBhUFhFNGF3OFdwME4wczBaczZOQkFzT0k4YjF4NnVaRzh3YWV6?=
 =?utf-8?B?aTZ2NW1MVXlhNFVsK2Q5VC8yRFlOblVqc2I5TWZRNFVWV2lkNUw3YzlLbThp?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc3768d-1222-4759-8003-08d9fa69cfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 03:24:21.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLJQCZv2+/6rrKlSO6lQxXJ/Kqr+RDeKf94AHQq0Wd1RWBzhG5ea4F8zXHmwVvIUdX+eND2fb1Lb4dfkmhtrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4509
X-Proofpoint-GUID: OggVN_Qw3Id0PHR1i9IuKtyBKKD2E6Ws
X-Proofpoint-ORIG-GUID: OggVN_Qw3Id0PHR1i9IuKtyBKKD2E6Ws
X-Sony-Outbound-GUID: OggVN_Qw3Id0PHR1i9IuKtyBKKD2E6Ws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=878 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280019
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlIGFuZCBTdW5nam9uZywNCg0KTWF5IEkgaGF2ZSB5b3VyIGNvbW1lbnRzIGZvciB0
aGlzIHBhdGNoPw0KDQpCZXN0IFJlZ2FyZHMsDQpZdWV6aGFuZyxNbw0KDQo=
