Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE847A398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 03:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbhLTCTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Dec 2021 21:19:33 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:60248 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233948AbhLTCTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:19:32 -0500
X-Greylist: delayed 1602 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Dec 2021 21:19:31 EST
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJNBbr3008278;
        Mon, 20 Dec 2021 01:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=ggSg3gyoYYVUgycNDTP693GiZVciaQwaoWZXodHYcUY=;
 b=VJVfQ2HWcrH3nk+gACug4NrnU7sls9ar9uS3xfYII4TpWUCJd433KSjZWCn2vxGXffKe
 /AvPQWR2CrdR1cVNOu37/JzjoLL0OSKCvm95MO49ROaRHFvGwKJtpS/nHxbLos+C24HR
 xVX7YS1QRB63rr7sj9QMAqzQIaAr0FTpgdAEri8wEyxyw6nSYPG/LrDquc5EQkHkdC/s
 ApheIPAzQukS4v+NoscBovkn6oN4x+bQr3jqGA1lSxDLXYIYtbOrBBnmSSVeXrnoMrzj
 AJbjHi3bYchxqmQfxeJLE2cTGHsRawNhTtRi1O+8EbaZlhT386RfhNSUmFFX7e2OXiLh 5A== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2050.outbound.protection.outlook.com [104.47.124.50])
        by mx08-001d1705.pphosted.com with ESMTP id 3d181s1ef8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 01:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI32Cv7zqU5EJk9AIi6KinTKEZ67icvgB4Xe4f/ajLzqavgNwwOLKNw6w8IGsJtiX5qP4f6leyQTSXKTtZbZY5O+N2oDFc5RhebZpRbuXxr8nrB7Kn/QRy5Ft4YGKv2y/O9KXJ/uYTu1uH18SNpkSjB0wYjZvoD8WulD+kekPNP9LUc7UAFdCfsz0Te9d0M7vFXf/msgo3ztntxsusM9FWpCK/8FsTlX0jW7huQhtbQa5BoeZ0IkVpPZqc0k/FdcZaBpyfJcRi+PU3wGKWbMuc11BcFR0V71tAzctnsg3YuLKRz8SHZRbH2EUK7t9MjL3E7PrJXLCwZn9c+X0BStWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggSg3gyoYYVUgycNDTP693GiZVciaQwaoWZXodHYcUY=;
 b=RzfCv6M5bEGIuLwy/MFaZnymerMyrYtFEW/h/gLm+dV+dWQpxrUrh0F1c8ZfXuJHYsNFE8cO8VKQ+4/2fdeGhtetlkUS+IZkn00pezyrr02/58FzEDNPGSFv9IyrUGWV9guTm5oVw/KR57Y6s86bjj7FTFKVw9M9ONI34n3PzBgnRbF/+ghiyltV8q/2kzlgiyJ0F4/BtEHjUTQ/4uOTb2gZFHvyQQJfK4oZDa5fGdvuHOfN/OtmLin5eUu/NffkCak01bZfgebc4GIXbmWlCYZss/KFtv7dKj2SSXwJ1/0iE8JgGh9awdfIRRcw0pjrERQ37s+l9OYz8W6i2x6rSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by HK0PR04MB2786.apcprd04.prod.outlook.com (2603:1096:203:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 01:52:26 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::bc0c:cdfe:4b54:5b9b]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::bc0c:cdfe:4b54:5b9b%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 01:52:26 +0000
From:   <Yuezhang.Mo@sony.com>
To:     <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] exfat: fix missing REQ_SYNC in exfat_update_bhs()
Thread-Topic: [PATCH] exfat: fix missing REQ_SYNC in exfat_update_bhs()
Thread-Index: AQHX9UNv8hzMxe6lo0mPytW04+aTrg==
Date:   Mon, 20 Dec 2021 01:52:26 +0000
Message-ID: <HK2PR04MB3891563FC310AE5E70896932817B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: efe74ad0-b34f-aa49-e0ec-fd6c98340b19
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a5a5f24-f348-4d62-0b9d-08d9c35b5ff0
x-ms-traffictypediagnostic: HK0PR04MB2786:EE_
x-microsoft-antispam-prvs: <HK0PR04MB2786863C25E871A8922270BE817B9@HK0PR04MB2786.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lrl3Afui5hhwc/YyaxwN76pRw6+wxpvcdLFDQlke2/aAf9QrmssZdY0wXw/7E7+uWiKOJSHgbumO9eL4LBLFkNRom86xSz7jITCYOL1dvjunQ/nC/mgqhFnIJCrsckWn8sCN+C8LeAn8ve5Eyg2IqXKvJXVUqAy28yBY8ooGipQvHvlErwYieIPIx0lVwZwLzG0gaFlPfCR+eg39byjY6d5jrRq9VI5ddNu3zLd8Uzqz9SaWVqicPV/RE7h/BYNBarCpKe/d/743mJ0revCe4emQRkNFngMcINnT5UPa1/KWA692vVpS7fy7ykv7RdpimJwQRbGbKFEQsv+B9JHzBUglr5h9xvn6wkSmFl+UFzoCKZaJ05qi67TsctP4/zsKuSEAOdNGATO/uyEJD7oCekrULF+fsjRaesPmJ+fcEI8IOaSg08iTeNmuyExtvucUD7Va6Mf14ib7MZJqGEvmW6DefObCxG7wt1z63B/F4ll6M1sPXoRKhrxsBmZnA5+kXUGHo8jA/4lkplVxmbNYquPnRYzChHI1r4Qwl+Mtc4h9X56FLNuvk+7pKId+UF0wjNav6I05MpPw6DqZ0KxtGle7Rz4nAYHWslFFfinnBI1NTSvWrMbYQ2ba0cLSDga+qxIZBGlIH67FeDpI+9lvT8sv8LO3yz9Zm2F1u0wxkuUVK7PNHFHyYHwoc3vH+nyo9bLgdQeoANU+h24x/djZ0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66446008)(52536014)(71200400001)(66946007)(66556008)(122000001)(4744005)(66476007)(76116006)(38100700002)(4326008)(91956017)(38070700005)(5660300002)(9686003)(33656002)(83380400001)(8676002)(99936003)(8936002)(82960400001)(86362001)(316002)(54906003)(2906002)(55016003)(110136005)(186003)(6506007)(508600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cXJXMzlkTDNRZkR2OXpQTXRkUUJLS2doRDB6SkhobFdFQjByTFNQVHgvcEtR?=
 =?gb2312?B?cjdlN1dBRERnQ1RGV0lPbXo5V09VeWxjZGExSE1COENpa0swSlBXa3B3V1JC?=
 =?gb2312?B?Z2VQSUFZY2RhVHJDcHIwMm00Zkg4cFhUMDJicjhDWmRTdjc1MWltdzVYcTBH?=
 =?gb2312?B?OU1iOVVBR3BvOFZnTzZoNkR2bmVhTm1PMm5tT1V3TVNwS2J1djV6cU9DaXda?=
 =?gb2312?B?V2ZJMXNZaXNJcjNmelhzMk5RL0owaksraHBmTkJyUnhRZjc2alczOU9Vdldh?=
 =?gb2312?B?dGRuUm1RSTBFTXBnRE0zOU03WExTMFAvQlRwaFVUL1U5OC9zZHIrN3ArcHRC?=
 =?gb2312?B?UUlaZHBraVJ3QkxHUm15SVNIbXpITlZuV0h3QzFzWmVYY2UvWlk5YWFNbEJk?=
 =?gb2312?B?Qjc3aWFBamZMcTBCanlNREs5VGRzYlgzQXhQWDk0OUJwQmdwdUk2UDhhZ1E4?=
 =?gb2312?B?bU1CMUk3cXIwZFV2Vm9TVURvSmZ6d0pvV1pMMnlyR1AvRStRRW55ZW5EdVpX?=
 =?gb2312?B?Z1hEVjNqelVQM1BsU3A2eFd2NVNJeDRFSmU1Y0drQVVzbkNLVTIydHlxVUp4?=
 =?gb2312?B?SVRGaFlCVjFibjh3ZGo4MGprYmVpQ3hXQ1c4UTV6RXZwTzBReUhqQ3NJSEdY?=
 =?gb2312?B?b3o0Z08yZ1UrQXFnZ1h1eFFLdEZjNkdMR05PL3cyL1lOb0pwUENxVlBDeDRU?=
 =?gb2312?B?Q0NGUEgyd2VGeXN3V1cxVkRadzBaVzRjalcydHA4VEN5akRmRG5JYlE2SzhT?=
 =?gb2312?B?bnFkaFFDcGU2R2o0eGtBeU01b3BPV2E2NEFUT1JXOXMyUWVDVE1LQmw2K0xY?=
 =?gb2312?B?Z3hrMGtmUWZhNzBjSWdwbFFOYzNDZVJnTTNERUdKOFBOWFRzMW9KemU2VzhJ?=
 =?gb2312?B?TDJ5Mmk0WlJJMURMajU1TjlOVytFK1BvNmFXYzBETHYrakZuakErT0ozcjBR?=
 =?gb2312?B?NU5kc3ZPV1RBY2dEaHlvRXhsVC8rYTlIblM4U0VXNG4vZC9BL2RIQ0xNRk8w?=
 =?gb2312?B?bS9DZEJieW5DczFYcmVNMkVLV3k1SVhqb3c4YjhpcDN0UHhoNFNSWEh4S0Jm?=
 =?gb2312?B?MjBFeGcwamxDOVU5YXU4RlVQMFlnOTg4N0kwNmxRSkJzU2JjZ2ZJSlQrNHRk?=
 =?gb2312?B?WFJlZ1ZpdzBTVlNockJRVVg1ZVVHUldWUmIxUjBFNjhYeWpyMDBIb3pWOVFa?=
 =?gb2312?B?eEV6d3RTUjB2Y1lVMmNuL1hBTFNkWitNRTJIZmZFbnhKMDJaakJ0aTFiY1Jt?=
 =?gb2312?B?T3diY0pWbXVjeUNWYTdDNkF1YkNXZkxoR0ZZUERlcU5EY3B4bWRRRzFmd1dL?=
 =?gb2312?B?U21EREk4c0o4VnRoUW96a21qNFBCUTlHclVpbDMzOUhOd2N6bUxUWm9lTU1H?=
 =?gb2312?B?TmpzbHlmZUVnM3VhNWs1ODh2SUduZjBFRDM0SStuRG9Fbi9SVWNjY2s5aUdH?=
 =?gb2312?B?WGhtaktrRk02NUZDNUYzYUczNjFJa2pja2wxeUhaWEFML2JyYXNtbUFaeDNJ?=
 =?gb2312?B?akxJdnFRVy9jTTZkVGRZWHpvWDVDVHZiTThCSndrbUFjeHQxRm5jYk5JNmtM?=
 =?gb2312?B?RmdtbmRzSnFDTWtMeHgwTFUrckt3aEt2bW01RGt5NG9SMVVWemhVYTVDQ0Zw?=
 =?gb2312?B?Y0VodUg2dFl3TFA5ZjRqVlk5aEsvbmMweGRoRzRLZXppYTFCdHBMYXhwaENY?=
 =?gb2312?B?T0FobnNoU1A1aTRGU2RrVWcza3B4WDZIYkdRV2l0SEwycjZFYlJoZ010TXJ6?=
 =?gb2312?B?c1pKM291NGlCb2FQeXQxbm0vYXJzZXdQQUFmNUJSN3YzY3NqLzdXSXM3amNK?=
 =?gb2312?B?Nm9QcndhaktsTklQckNzblNnNDF0WDdNUCtZdEQ0UnZBYnNJZHI5em0zd2Nv?=
 =?gb2312?B?anNqSGx4aTJWSERVempQYm5tQUxodFRIZ3dvQWpFNmJRalZGeDgzSkxSODhm?=
 =?gb2312?B?NldTcEN6RmRrMloyQmwxRUQybC9pellWeWVub0FRRG5jYnVETmMzSzZDM3U3?=
 =?gb2312?B?OStGbjZIeWZQMnVRYlpHcTV2eUNtY0FHczFlZ1ovRTlJN0J3cjRSM3F4d1M3?=
 =?gb2312?B?alo4TjVpSmwrajJ6a3Q2SU1wandzNzRpSnhQY0pkM3BSZ1Uxbkswdm0xdVU1?=
 =?gb2312?B?cXhQVVFjY1VKM282clF5N0hvTElnSkNnWmpjMjA5S28vZ25BNXIwd0JZUmdM?=
 =?gb2312?Q?iN1iRz3qjHyrD5VdCUQyQBE=3D?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891563FC310AE5E70896932817B9HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5a5f24-f348-4d62-0b9d-08d9c35b5ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 01:52:26.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xieqHBNHllIVYmguq6K0HjI7Ti7ijO8ISYBDCnxaOxQ+Hp6jJx8fuIoVvz/VvZve7dBb8vvdcRWnMmI5Ek3Cew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2786
X-Proofpoint-GUID: uzikrdRXsgS-YfIQsbMtXDXhP1IFL9D1
X-Proofpoint-ORIG-GUID: uzikrdRXsgS-YfIQsbMtXDXhP1IFL9D1
X-Sony-Outbound-GUID: uzikrdRXsgS-YfIQsbMtXDXhP1IFL9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-19_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200009
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891563FC310AE5E70896932817B9HK2PR04MB3891apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SWYgJ2RpcnN5bmMnIGlzIGVuYWJsZWQsIGFsbCBkaXJlY3RvcnkgdXBkYXRlcyB3aXRoaW4gdGhl
CmZpbGVzeXN0ZW0gc2hvdWxkIGJlIGRvbmUgc3luY2hyb25vdXNseS4gZXhmYXRfdXBkYXRlX2Jo
KCkKZG9lcyBhcyB0aGlzLCBidXQgZXhmYXRfdXBkYXRlX2JocygpIGRvZXMgbm90LgoKU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcuTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPgpSZXZpZXdlZC1ieTog
QW5keS5XdSA8QW5keS5XdUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFveWFtYSwgV2F0YXJ1IDx3
YXRhcnUuYW95YW1hQHNvbnkuY29tPgpSZXZpZXdlZC1ieTogS29iYXlhc2hpLCBLZW50byA8S2Vu
dG8uQS5Lb2JheWFzaGlAc29ueS5jb20+Ci0tLQogZnMvZXhmYXQvbWlzYy5jIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9mcy9leGZhdC9taXNjLmMgYi9mcy9leGZhdC9taXNjLmMKaW5kZXggZDM0ZTYxOTMyNThkLi5k
NWJkOGU2ZDk3NDEgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L21pc2MuYworKysgYi9mcy9leGZhdC9t
aXNjLmMKQEAgLTEwLDYgKzEwLDcgQEAKICNpbmNsdWRlIDxsaW51eC9mcy5oPgogI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9idWZmZXJfaGVhZC5oPgorI2luY2x1ZGUg
PGxpbnV4L2Jsa190eXBlcy5oPgogCiAjaW5jbHVkZSAiZXhmYXRfcmF3LmgiCiAjaW5jbHVkZSAi
ZXhmYXRfZnMuaCIKQEAgLTE4MCw3ICsxODEsNyBAQCBpbnQgZXhmYXRfdXBkYXRlX2JocyhzdHJ1
Y3QgYnVmZmVyX2hlYWQgKipiaHMsIGludCBucl9iaHMsIGludCBzeW5jKQogCQlzZXRfYnVmZmVy
X3VwdG9kYXRlKGJoc1tpXSk7CiAJCW1hcmtfYnVmZmVyX2RpcnR5KGJoc1tpXSk7CiAJCWlmIChz
eW5jKQotCQkJd3JpdGVfZGlydHlfYnVmZmVyKGJoc1tpXSwgMCk7CisJCQl3cml0ZV9kaXJ0eV9i
dWZmZXIoYmhzW2ldLCBSRVFfU1lOQyk7CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IG5yX2JocyAm
JiBzeW5jOyBpKyspIHsKLS0gCjIuMjUuMQ==

--_002_HK2PR04MB3891563FC310AE5E70896932817B9HK2PR04MB3891apcp_
Content-Type: text/x-patch;
	name="0001-exfat-fix-missing-REQ_SYNC-in-exfat_update_bhs.patch"
Content-Description: 0001-exfat-fix-missing-REQ_SYNC-in-exfat_update_bhs.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-missing-REQ_SYNC-in-exfat_update_bhs.patch";
	size=1273; creation-date="Mon, 20 Dec 2021 01:49:14 GMT";
	modification-date="Mon, 20 Dec 2021 01:49:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2NzYwMTg3MzE0YWFlNDM4MWZmNTczYmQ3OGEwMTUzYTZiODMxZTBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiWXVlemhhbmcuTW8iIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4K
RGF0ZTogTW9uLCAxNiBBdWcgMjAyMSAxMTozMDo1MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGV4
ZmF0OiBmaXggbWlzc2luZyBSRVFfU1lOQyBpbiBleGZhdF91cGRhdGVfYmhzKCkKCklmICdkaXJz
eW5jJyBpcyBlbmFibGVkLCBhbGwgZGlyZWN0b3J5IHVwZGF0ZXMgd2l0aGluIHRoZQpmaWxlc3lz
dGVtIHNob3VsZCBiZSBkb25lIHN5bmNocm9ub3VzbHkuIGV4ZmF0X3VwZGF0ZV9iaCgpCmRvZXMg
YXMgdGhpcywgYnV0IGV4ZmF0X3VwZGF0ZV9iaHMoKSBkb2VzIG5vdC4KClNpZ25lZC1vZmYtYnk6
IFl1ZXpoYW5nLk1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFuZHkuV3Ug
PEFuZHkuV3VAc29ueS5jb20+ClJldmlld2VkLWJ5OiBBb3lhbWEsIFdhdGFydSA8d2F0YXJ1LmFv
eWFtYUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEtvYmF5YXNoaSwgS2VudG8gPEtlbnRvLkEuS29i
YXlhc2hpQHNvbnkuY29tPgotLS0KIGZzL2V4ZmF0L21pc2MuYyB8IDMgKystCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvbWlzYy5jIGIvZnMvZXhmYXQvbWlzYy5jCmluZGV4IGQzNGU2MTkzMjU4ZC4uZDViZDhlNmQ5
NzQxIDEwMDY0NAotLS0gYS9mcy9leGZhdC9taXNjLmMKKysrIGIvZnMvZXhmYXQvbWlzYy5jCkBA
IC0xMCw2ICsxMCw3IEBACiAjaW5jbHVkZSA8bGludXgvZnMuaD4KICNpbmNsdWRlIDxsaW51eC9z
bGFiLmg+CiAjaW5jbHVkZSA8bGludXgvYnVmZmVyX2hlYWQuaD4KKyNpbmNsdWRlIDxsaW51eC9i
bGtfdHlwZXMuaD4KIAogI2luY2x1ZGUgImV4ZmF0X3Jhdy5oIgogI2luY2x1ZGUgImV4ZmF0X2Zz
LmgiCkBAIC0xODAsNyArMTgxLDcgQEAgaW50IGV4ZmF0X3VwZGF0ZV9iaHMoc3RydWN0IGJ1ZmZl
cl9oZWFkICoqYmhzLCBpbnQgbnJfYmhzLCBpbnQgc3luYykKIAkJc2V0X2J1ZmZlcl91cHRvZGF0
ZShiaHNbaV0pOwogCQltYXJrX2J1ZmZlcl9kaXJ0eShiaHNbaV0pOwogCQlpZiAoc3luYykKLQkJ
CXdyaXRlX2RpcnR5X2J1ZmZlcihiaHNbaV0sIDApOworCQkJd3JpdGVfZGlydHlfYnVmZmVyKGJo
c1tpXSwgUkVRX1NZTkMpOwogCX0KIAogCWZvciAoaSA9IDA7IGkgPCBucl9iaHMgJiYgc3luYzsg
aSsrKSB7Ci0tIAoyLjI1LjEKCg==

--_002_HK2PR04MB3891563FC310AE5E70896932817B9HK2PR04MB3891apcp_--
