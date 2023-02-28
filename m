Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC746A52D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 07:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB1GH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 01:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1GHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:07:55 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782CA10DE
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 22:07:51 -0800 (PST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5nE90023203;
        Tue, 28 Feb 2023 06:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=ynUN1zb79v0/N5HHc++2qYWCOw1XZFH+0Ow8bd/VPRI=;
 b=G+iXoeKQSGdFzSmWmmBJiDmSVw1fc/kyeDRAYK1e47/oalcyLPQvk7ARcyqLjYQkFrkN
 rS58aDwo+LRQ+/VqBVYNz0oRUGEadAYVRAl5i0ad4uhFUIfueKE8hZ5D3xpAN58nRKgV
 n7nf7uTx4OXCGBibmIsBPnGh9GrseCVv98hSG7bL7BN7OGZB6drByxgZz9PgA5/zq1jv
 SpiTOTFIaj74TNxjzab7DECovQ09pMKlgoIq6VKKCXfkpVjZwdwxSpgqOVeO8TYSo9ee
 qV/izhlGpxoeFPY9nR17RjOeBDSKs8Qs7hLFmnCMiPHGXJUVsikQPi1C9j1cV6BwlMVJ jQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2107.outbound.protection.outlook.com [104.47.26.107])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nyb2gab0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 06:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqh2nm4LHIXzCoCLv9Ceo5OhzYdVdGxOsmoBNyHwVzab/N1KnSdJYPzfb9P0I8xu2jjSx6cusXWhEOOVpfZUTMlU2G1zXd0mSWR/OkC5RntC91BwU39fBCJzyFaedf+cBYFl2FGL6P2dg3YpCGXKvdNdVEoGbRTqvbU3eaMMTbIBitAHLkj6d+tjVJwGFXKs5yLIXjzEOznE2TWv8sTGkkECFvizhOm/YnGqKGDtNaIf3htX49dtPr6vC2O4LjYEitC8saB1FhRUboU6xIzIG/vKt8mB1qxjTFYdqcRsmozMefPTK4knXB2sTJsEInureq4QXpsA8QYX+Pj/3snGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynUN1zb79v0/N5HHc++2qYWCOw1XZFH+0Ow8bd/VPRI=;
 b=kHdv5uB5h+U0Dcl7HwYGrt53ZEK4RzZqpAGRmiR/8LwpwIiolVGBGBcNsT1+DGbZ4UYRM2ohuZfa1Qsg54sAC7Reab56lfki4O7r/A6Kh9RPRCrgwnO2Dv8acRIdOHX9ZX8xhvAMIoBlGDTPhHMv4V+Pqvu2SkP6jUVYptvmicsoToWTVSQfh85AP//SzmwgJQiXP8o1/161HDHaRKXv+hV73NIa8zfbHM1f43Xb9f8hns6dZlCaghLsCzLzbGvbLbgeeZ2nYLB7RzM+gzQh+s5k4KaJZt+OiljmUJQLs6pjulQUeDdgKjUBgUoG4Mc6mMYgsbGsmFNfsZDyByv+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4227.apcprd04.prod.outlook.com (2603:1096:820:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:07:34 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:07:34 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Subject: [PATCH v2 3/3] exfat: fix the newly allocated clusters are not freed
 in error handling
Thread-Topic: [PATCH v2 3/3] exfat: fix the newly allocated clusters are not
 freed in error handling
Thread-Index: AdlLOtELsgz4S+exRGWgndVxY+MD7A==
Date:   Tue, 28 Feb 2023 06:07:34 +0000
Message-ID: <PUZPR04MB63166C26AD83C7573323DE2481AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4227:EE_
x-ms-office365-filtering-correlation-id: 40fdee2e-acc7-4cfe-bb7b-08db19521581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1Twxk0j+exicYgheyhnvh/Lc90OuFdVsndxzuSmF3NJbrb6qBdkNTepE9/CDLYhjD7fVHJnexVIojuBznwyRqXTGvFW2bGzboaRUXSnvjfhxfbrjwCvXYUgLqbDmDRthg1whs6x6Bu3t6d1b6yj7i/kvatV4LyYjV+6WeLyNemE/VD6I2WGBo2S3M+dG3kxsrMmZMD76ke0m8/nj/YmYNbu8K3G61JT5YPn0nY5m+K8ktV4aCY4K8Uk5BpXtUYB5nmdOOnlcKTh9yZ46YgBAHB3a9TZueUs6HInFZ6whaaUO/ZiYjZM00rleOSdgjAHfJupOemzEXXTzdvUx9CwTv5TdZjUvNGb65vc+8O83sww6TtB5j4wIvvEmtPsF6tDF/4hq1ljgQ3EXUBvbgG/CUaq6gWm9/QE6GtM+r4p4txgqEsfnRhmJ9dIx9Lz3431JV1xgpSpYF5Gyy6lxzBChQ8Q9MHs0MgLq4/K+A3274E3Amq18jD6X3JgBLQ76sb79nRs0ELsOcToqtyfjLEn5KJTnecu5/eA/jPat8UTRB+qzyy783241SYcqAA2ntdYdgyE1v26g8ZkSPy4zWuSS0xjBfwT7Nr1MSlYs1xLeV1+LGQWDRcT91z0mNETeqRMpbS8HPTRlDreGtLhWNALDaLiPVh88fSNvdZ4SHcX5giFzxeq9heZzbl65Tay59C8C7hocnl2uJiBh9KImM5CWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(110136005)(83380400001)(33656002)(54906003)(316002)(478600001)(82960400001)(38070700005)(122000001)(7696005)(26005)(41300700001)(9686003)(186003)(71200400001)(6506007)(107886003)(5660300002)(38100700002)(76116006)(52536014)(86362001)(8936002)(2906002)(66946007)(8676002)(66476007)(66446008)(66556008)(4326008)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNLd3R6WjU0enZ6VmJSdWp4Lzl0aFR3d3RmcUdwTDQ4YmdJajR1Z0ZrSkxO?=
 =?utf-8?B?SDdMeGVScmNiNDZFOXdFR2dlNjMzaFRTRURvcnZNMkdKYmNLMHhLbGc4bHI0?=
 =?utf-8?B?ejBGZXhWai9OVFZGRm9DU1hzQzF6S0hGb0FlaFliaGpGTDVpUW1CVUJuK0Fa?=
 =?utf-8?B?bTllalFwUlVHRmxwYSs1c2Zyc3FYM2hCZzUyekI0ZU9LQ1UzR01FaUsxNkty?=
 =?utf-8?B?U0dwTElUanJrTFd6WDR2Q3BLbG94a3VYTkQ0S3JlQWtnQXlUUkMyZzc0UG5U?=
 =?utf-8?B?N0twM21VSDhKS3JTaXZzMHFKVm8rQ09abUcwTm5OV2g1bUtDU1doSklObkVN?=
 =?utf-8?B?aUhkd28xaVVESEVZMnhFRnUxSVBVWXhiV1BiODVBaVh1dVN6dmZmWEFwa2Fp?=
 =?utf-8?B?QWc4RGpBTHE4aHl1Ym1sU1VXcENJWEZUWmFMbkh0UlZJOHFtbS96VzN0Y04x?=
 =?utf-8?B?c1h5YXlVUXVmZkVOVVEwejROU0p5MTNwMmJKMW1qb3dRcVJtVnhMeXF6UXZi?=
 =?utf-8?B?eUcybGhwNWprUmRURWtQQ2RVWnJXRUJsbnhKWnh2Tm5UQ1N1S1dhN2tweUd2?=
 =?utf-8?B?SXJqM0pKOGxxdWhDWmhvUy9RRko1TXJzTnZYQVlQSlI5bjdTclBOWVNYQjhL?=
 =?utf-8?B?b2dqMmw3VU9RLzJteTIzcXdyZ3dhd3RHUjhjK2N2Sm51SUhMS0NCcS9ZNlBL?=
 =?utf-8?B?ZzRPUEV2ODNWRFRuOG8ybnBpb0VielVpWHVnRVJqOWgzTTgyQ0ZKTXhjUVVC?=
 =?utf-8?B?R1JXcmM2RFRsMFA4YnZ1WjVKT1F1VlRPU0x4NlI3U2N5RktPTFUxbktqWE01?=
 =?utf-8?B?WVpoUitPTThaY054dVFKelJjUGhiZGVQZ3F3N05mZ2tvRUl6a2NPbTUwbG9o?=
 =?utf-8?B?YlB6ZG9yeGJuV09UcHRTT3J3YW1KYlVJUlhKRk5UdzFQNHhXcUVGZXQ1VWR0?=
 =?utf-8?B?L3Z0cmVvQkpZN1VyOUdBTTRlLzluZkc1RWJEQTVwLzNiNGx3RHh5OUFQaG5U?=
 =?utf-8?B?SFo1YlJlaWJVQUpnR0ZkZFVCTU9teEtZc0FHYUY1dSsvYTFjRWlwRDBWalNw?=
 =?utf-8?B?bnZyTUVabFc5UkprQ2lIV0YzaS9mb2NFeGF1aHg4NVQrc1JmTGhScEladjNx?=
 =?utf-8?B?UjFCOGdISUhscDRHWlRVVysyYmVWNlBIYURpVm9xcmpmOWxrV3Q0aVhzRTFO?=
 =?utf-8?B?L2hiVU54a3RvdWpvZUZKZVgwU2pvMVZJUUkyL3lGWXV0T1NIeWtoZURCYU5T?=
 =?utf-8?B?aWhjT1dGbFNjR2xzcVFXeGFTbU9sd3VCQ004b0NPYnlKempJUTRXaWhJY3dv?=
 =?utf-8?B?dEd4MEl0Y1RzenVPek04d0xLQm1MZmJRQkxXb0luamo4WEw0ZGEvbGFBZnZI?=
 =?utf-8?B?M0l3YmYvUUZmK1B4bWsxN1paZEhlbVlra0g4RXI4a2JMeUhvUUhPcGFScHVO?=
 =?utf-8?B?MWxheERPZDdKMzFBT0M4UjlubDF2S1lOZ25yNTlTR2hIN3g1ME8zM1QzckNG?=
 =?utf-8?B?Ny9nZGpZWnl5K2pPUXFtblB1YzlGUk9aWTUycVRFTVFlSE5zZEJrOEN2cGJV?=
 =?utf-8?B?a1d6UXdRbVR3Vi9NU2FNaitWa20yVnR4M1lVUTFCQ1ZJWWhZbHJVaENuRzUw?=
 =?utf-8?B?UnBkSktUdXpYcGs5a2NkSXJUZXlxdXpYc1hRYlhzdWRWenZ6TW9kTlZ0MVlu?=
 =?utf-8?B?SGZpeUtaR3VnSUk5bVl3NVI2a0pnQ3ZHS3pETXN4ZDJVQ1FkRGRIQy9oeVl5?=
 =?utf-8?B?SGFUWXpCbE9wcVk4eUZ5N1hEVmlqcjhaOVZmQnZnaG14WFkzR3p3aUxKQUZI?=
 =?utf-8?B?bDNNRjFIWXhZK00reWhtb3c5ejJtM1Z3M1VXWm5yMUdKYitMNWdDa0FnelR6?=
 =?utf-8?B?ZTBDM0d5TDlpNU5NWHA2UGhzNWFIL3hIRm5FK3JnbFdqbGFlblVpWmRZeW9K?=
 =?utf-8?B?aGg4R2RqNHNOTUFiZ3Fvb0pjd1c2OFkzcVVxNnk3TDlZSDlraHJlQ1VWbGkx?=
 =?utf-8?B?RzBmMVB6Tk9UblBRMDNITkpIak1GVFU5RjUvc2gwb0tsZXZFRmxaNjg5bzd5?=
 =?utf-8?B?SHh3czJsbFpSZlJGSkN5bHdYOGNaelJPdlhZYm5ncFVPMUtmbW1RZy9IMURK?=
 =?utf-8?Q?qe18wDRCfmSmNAKKKFFCww2vi?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uckHVXbSJjmiClnp74k4eMG+fpBQ9LxGlz7NAIqmJ9dl9P533x1VEpvyqVv+O58oV2r3Pp8L9WDHq6znmn3EeWTHg/QLrVObsACiZ/LFwVWMWwN+Cygg611H3PJ4Q8QMzWSxCXg3q/vmHhHHvatkd5a+eLPgA1NQd4QKD6r14w7XG5JlmKtB7d6B9lcwfdKvEQ8X+fpHYvkgSZnuwrPhAKBhjYInyKTH6vb0FE+j15eFXcY2AQkcG04/zFHc6tDJWh8TdSZtJUQyLgro8A6IZSp1I8zep1nUP/25d/Z72rIa0kX6tRwsbf7tRhsM6otR8YcqoCE3iWgiCD8+1gKchQpTJJTJoStvnOCIUs7IebBHTvGd/Z9L0qk0Iw/wDGA3dqCM/HR4/i9UJEM1CHharGUS2j4ZU/UD0JtdOktGjnRpSLN1JukmY//BSNglI8QvanxXtU45qx0fJM6geHMpeTROSuvamGQX+OztpdwJ9OWCTJJgWYSqrXYlqRy4XXieE8YGQ62knr9AjHjl6pAyB+/5WbAG4L7n6/Z3z4Uy6ybKL42AtNQbJsM9T74p52A8sTMg/iUl8HvD7o3fTVhGKqAhxHh87y+mbGdZx5QWcWAxqCGmmNs+z27zVswnHZk4xTslG9erqfIkkYwTV8CuJ9wygiW1pso/bJUU9YnzgAHeFJOTWQTgQiiVd+/RAhIEazs3VX+3UwafD1Q3Q+BDL1ioLXPJQSl17YCXRVDmP40mGu3/oAVQmJbvRZme1GPGAHCqfgXWQZ9AhzhBulUHIs+tCEm90vNiOjlFmyuH4vpqgGnKOeixGqcWDFrKPAIKzqn5QG/iYWyil+wNt8sZuA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fdee2e-acc7-4cfe-bb7b-08db19521581
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:07:34.1424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdyGuAtg7YTAou1Lo4ub2jGH2zKM6ueuFJxMquqG3Q/TKKzEMAJQhW45Xvfp5JRzuhnheeeA00k4NDRcIh78cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4227
X-Proofpoint-ORIG-GUID: MVdcFcORXkaKIGPxjrSi3KTVCDU7AIMZ
X-Proofpoint-GUID: MVdcFcORXkaKIGPxjrSi3KTVCDU7AIMZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: MVdcFcORXkaKIGPxjrSi3KTVCDU7AIMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_02,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gZXJyb3IgaGFuZGxpbmcgJ2ZyZWVfY2x1c3RlcicsIGJlZm9yZSBudW1fYWxsb2MgY2x1c3Rl
cnMgYWxsb2NhdGVkLA0KcF9jaGFpbi0+c2l6ZSB3aWxsIG5vdCB1cGRhdGVkIGFuZCBhbHdheXMg
MCwgdGh1cyB0aGUgbmV3bHkgYWxsb2NhdGVkDQpjbHVzdGVycyBhcmUgbm90IGZyZWVkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZhdGVudC5j
IHwgMTggKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9mYXRlbnQuYyBiL2Zz
L2V4ZmF0L2ZhdGVudC5jDQppbmRleCBjNzVjNWEyY2FkNDIuLjU2Yjg3MGQ5Y2MwZCAxMDA2NDQN
Ci0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jDQorKysgYi9mcy9leGZhdC9mYXRlbnQuYw0KQEAgLTMw
Nyw3ICszMDcsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWlu
LCBib29sIHN5bmNfYm1hcCkNCiB7DQogCWludCByZXQgPSAtRU5PU1BDOw0KLQl1bnNpZ25lZCBp
bnQgbnVtX2NsdXN0ZXJzID0gMCwgdG90YWxfY250Ow0KKwl1bnNpZ25lZCBpbnQgdG90YWxfY250
Ow0KIAl1bnNpZ25lZCBpbnQgaGludF9jbHUsIG5ld19jbHUsIGxhc3RfY2x1ID0gRVhGQVRfRU9G
X0NMVVNURVI7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCiAJc3Ry
dWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCkBAIC0zNTgsNyArMzU4LDcg
QEAgaW50IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQg
aW50IG51bV9hbGxvYywNCiAJCWlmIChuZXdfY2x1ICE9IGhpbnRfY2x1ICYmDQogCQkgICAgcF9j
aGFpbi0+ZmxhZ3MgPT0gQUxMT0NfTk9fRkFUX0NIQUlOKSB7DQogCQkJaWYgKGV4ZmF0X2NoYWlu
X2NvbnRfY2x1c3RlcihzYiwgcF9jaGFpbi0+ZGlyLA0KLQkJCQkJbnVtX2NsdXN0ZXJzKSkgew0K
KwkJCQkJcF9jaGFpbi0+c2l6ZSkpIHsNCiAJCQkJcmV0ID0gLUVJTzsNCiAJCQkJZ290byBmcmVl
X2NsdXN0ZXI7DQogCQkJfQ0KQEAgLTM3MSw4ICszNzEsNiBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1
c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJCWdv
dG8gZnJlZV9jbHVzdGVyOw0KIAkJfQ0KIA0KLQkJbnVtX2NsdXN0ZXJzKys7DQotDQogCQkvKiB1
cGRhdGUgRkFUIHRhYmxlICovDQogCQlpZiAocF9jaGFpbi0+ZmxhZ3MgPT0gQUxMT0NfRkFUX0NI
QUlOKSB7DQogCQkJaWYgKGV4ZmF0X2VudF9zZXQoc2IsIG5ld19jbHUsIEVYRkFUX0VPRl9DTFVT
VEVSKSkgew0KQEAgLTM4OSwxMyArMzg3LDE0IEBAIGludCBleGZhdF9hbGxvY19jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2MsDQogCQkJCWdvdG8gZnJl
ZV9jbHVzdGVyOw0KIAkJCX0NCiAJCX0NCisJCXBfY2hhaW4tPnNpemUrKzsNCisNCiAJCWxhc3Rf
Y2x1ID0gbmV3X2NsdTsNCiANCi0JCWlmICgtLW51bV9hbGxvYyA9PSAwKSB7DQorCQlpZiAocF9j
aGFpbi0+c2l6ZSA9PSBudW1fYWxsb2MpIHsNCiAJCQlzYmktPmNsdV9zcmNoX3B0ciA9IGhpbnRf
Y2x1Ow0KLQkJCXNiaS0+dXNlZF9jbHVzdGVycyArPSBudW1fY2x1c3RlcnM7DQorCQkJc2JpLT51
c2VkX2NsdXN0ZXJzICs9IG51bV9hbGxvYzsNCiANCi0JCQlwX2NoYWluLT5zaXplICs9IG51bV9j
bHVzdGVyczsNCiAJCQltdXRleF91bmxvY2soJnNiaS0+Yml0bWFwX2xvY2spOw0KIAkJCXJldHVy
biAwOw0KIAkJfQ0KQEAgLTQwNiw3ICs0MDUsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3Rlcihz
dHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIA0KIAkJCWlmIChw
X2NoYWluLT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pIHsNCiAJCQkJaWYgKGV4ZmF0X2No
YWluX2NvbnRfY2x1c3RlcihzYiwgcF9jaGFpbi0+ZGlyLA0KLQkJCQkJCW51bV9jbHVzdGVycykp
IHsNCisJCQkJCQlwX2NoYWluLT5zaXplKSkgew0KIAkJCQkJcmV0ID0gLUVJTzsNCiAJCQkJCWdv
dG8gZnJlZV9jbHVzdGVyOw0KIAkJCQl9DQpAQCAtNDE1LDggKzQxNCw3IEBAIGludCBleGZhdF9h
bGxvY19jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2Ms
DQogCQl9DQogCX0NCiBmcmVlX2NsdXN0ZXI6DQotCWlmIChudW1fY2x1c3RlcnMpDQotCQlfX2V4
ZmF0X2ZyZWVfY2x1c3Rlcihpbm9kZSwgcF9jaGFpbik7DQorCV9fZXhmYXRfZnJlZV9jbHVzdGVy
KGlub2RlLCBwX2NoYWluKTsNCiB1bmxvY2s6DQogCW11dGV4X3VubG9jaygmc2JpLT5iaXRtYXBf
bG9jayk7DQogCXJldHVybiByZXQ7DQotLSANCjIuMjUuMQ0KDQo=
