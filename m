Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772AD4F8D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiDHDl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 23:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiDHDl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:41:27 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 20:39:23 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3796B1CB;
        Thu,  7 Apr 2022 20:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649389164; x=1680925164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ESmcGWCHSqyFixxwmt0qoWEg4v0mtD444mrK7m1OY/4=;
  b=LXQ5T7U6vcDKZNaeJGhYWQxLT+/JO5OT9gzVvfKWpgn4zv6d4pfucNCS
   /pKBhX/k3Op/12k4iOeOk46ZbydJMm6KxV9Zkx8m14Weiav4IrOCEomkO
   cd/Eo7iQk5xDmWC0P5fsraOBmPt3/4Mg9AVkvJY0LWIE09YWH4+NPY7MK
   aD0LsHmxF/o3epIXurqE3IpChD/bCIA02iHxXzaKFV+J8SGrHkDwN11QH
   Mnov7+b0Ao473P4XabSRe4jbTZHEbbYkYJAHonw0prfDtA7klTv4KO8Qn
   gqc28UtOyYkAYA/ZlvJeH2MArmgWfqsqhAoN31pkBD/D9kNuvgyRlvbxT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="61589945"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="61589945"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:38:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIOUQ0DegRy03BO1FgGaOTbW80vgKGQ8tkn0oZobkOViL+DLhaQyPyfMMcDhycqIzyolRTFimVCIW3Cr4So6m9NGTNfYAhOvRDKBcLpmHXCW+B+phv+dHXJAeLdcwsOOiSIze0Lxj5Q14e7F9p3VVtqNqwme+0d8DcTaU94Ev77T8eSHPxJP5BOQ07GzzrH2xpreEqEGaMXdsS4kr/NkAkb20M83+Ua2fKu/fk43vOOWmidrg60n9VocCROanWKfnkiklpTaWuPYgi/mql2yGx71u1OrypYr7xCf6oZ1uCWuFvb4OYR8B56D9LXaGJ3zFLVRLM/t3ICBIHn8SB6QQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESmcGWCHSqyFixxwmt0qoWEg4v0mtD444mrK7m1OY/4=;
 b=HT28PO2sAJZ5DP3sdi/zewzGRPbuUPEdMhfU8veBNJK6ydDiQFXXvx7u09HiD58zAchfB21XyHPXmFlqYWbUEve+v2dR/aT4yQUGVwSyRdvm0i0mRTFhgPVq596LZcoVd2vAns2Bn9NotFmb3qloBt5LUNigwJbh/Z4UsYzZgqA/+NyQzhNmv78cZZiAnJ6inUaNS8OlC+Rw4bRC7swuJksVMWIK/cl5URHiWJY8WW+AyP8l8Y4NXkzwAm+XJ/OEjDp1B4fU+8n2Vh4g9H5LfwAcAlxngKPTvL+iCHq686OMnB+cx/uKe4yY4393PIojMLyIBax6FE7xGC/hDaeI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESmcGWCHSqyFixxwmt0qoWEg4v0mtD444mrK7m1OY/4=;
 b=ci2uksok+BBAOshqkFJPf7uvNF/5AwbPlrn1FYmBMZVCaUOSQB8oei3uhmXUrkVW4hNkj/dxmDYQhyzcR+uor4zvXQRC7KxFMxk2hGM+75u5k94uvSuOxaUFFhaabB0HvIDf4dE238v/gzqoNZe1oagQRX2uJqvzuJBdeKglZgM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB10102.jpnprd01.prod.outlook.com (2603:1096:400:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:38:13 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 03:38:13 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] idmapped-mounts: Add umask(S_IXGRP) wrapper for
 setgid_create* cases
Thread-Topic: [PATCH v2 4/6] idmapped-mounts: Add umask(S_IXGRP) wrapper for
 setgid_create* cases
Thread-Index: AQHYSm/+bj+qYFxDf0av14RWQ8TJHKzkjweAgADhOgA=
Date:   Fri, 8 Apr 2022 03:38:13 +0000
Message-ID: <624FBC64.202@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407151253.fdzwsiyigmamwfjh@wittgenstein>
In-Reply-To: <20220407151253.fdzwsiyigmamwfjh@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 862ceb0f-f85e-4bbe-3bb2-08da191135b5
x-ms-traffictypediagnostic: TYCPR01MB10102:EE_
x-microsoft-antispam-prvs: <TYCPR01MB10102EB854139EB130C94C8F2FDE99@TYCPR01MB10102.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n25isEnYd3CozZLwgSLIjkthNx6UnGUzTyUXWUbkX3gcThFoYqOaN6ck9KzwUqFv2wmf6I0CL5bVAm9qsws5qKy4WA1BqIc4SHB06pAEPjJzAQJk+AhuUR7TuzEHh5qoc2pjAWlNH2EFC0MhHDyq/pnXazRLSaOyWPmniXDd7w1ExE6dMA8gklS4ZRTEqTfttbVMfaioy1vE0xvFJSp9wpFi+5Tq5WqYKyNIn1w3eYctCI/DWFJ7tM5JMD5YNIRSdk7M/iArasQgckKvhHLkv9QlTBicpSPF8xlkjwCC0qm3BoV9eFOo6nXbsVGcJ0Mnlmnl7vBqgtcq9AH8mIbDvFpBAh3GJZjUTqPmbxiEZGtmnP7BnMAmQ/0gpH866yqW1AZSWPFiNHHh29s2qgp48hwgjTkk3Nvj1xtdT3mIWwWr1QkFX8Fh4TESd7u8QoHP08RBRJaSMtzrcAFDmBZCmdH9BWgo0ZN2CPMAdxTjQIyhhr/P8Uq8qCSRCJVFhIK+QCezYSQOLHmIlL829KjIqfD8TMBEro2k5rZEIn3NlZ9QaSxsrvFOlEkQcHQezIBmqqRDcPNPDaCooJ+57JTKzzrsSzIyDZSXwwsppNjujGoK9biwu46TLlxdow3i/vQy26MJVVkSoe+Zjr4btXswWcsfgmjdvNCkQQvBrRDJpOHycXd8O98KTEZkgy0IBqstB5hXqqcZi8uC14a/l2YD8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(76116006)(316002)(91956017)(71200400001)(33656002)(122000001)(85182001)(508600001)(86362001)(4326008)(2616005)(8676002)(6486002)(2906002)(64756008)(66446008)(6512007)(38070700005)(5660300002)(8936002)(83380400001)(82960400001)(38100700002)(6506007)(54906003)(6916009)(26005)(36756003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlveDRhMkk4YW9iMEdBL2JSM2YzVTBuVTBnZW9Cc1BrVnJ6QWloSUcvMWdZ?=
 =?utf-8?B?bXIrWTlUOGQ0TXRScUdmSG9vNVBvdzc3WURNaWJXa0FCT1dPSVVHb3VQcXRt?=
 =?utf-8?B?VVhPaklQbnNzQk5wWWZnYm9RUzI3TVJReUdlWnBSdEd6WWhxWEVRNWdPM0lT?=
 =?utf-8?B?eVVpWE9VQU1BbVNIRy9NdlJISnlDYVVWcDJDTW1IZWdkY0xrZlQ3ZlN3Y2hj?=
 =?utf-8?B?YVQ4RVU1d01mOUtsVHVLUGJ5a1VvVERtWEhSbmpMcU4wRExRWTd6aU1DNHNB?=
 =?utf-8?B?UjJaaHhLbWtGVUFlZXFtTDBDV1lTcmpuR1AzeUROOVM1WFFoOGlhU3pLL2tY?=
 =?utf-8?B?S0U3b0dLblRVV3A3WitjSm16YTZqT3FoajliMmgvd203bXpVY0Z1L2x2Zm9n?=
 =?utf-8?B?U2xER3FxWEJISFBnYStYenVJcnVWTnp6a3dFeWdrbzQ2c3c5ekd1NFdocS9n?=
 =?utf-8?B?MjErbDZoQXhZZnRwNGdKcmRPS1VBWDU5NEpWVm9TMWxvSFNKOVkyd2FpbE52?=
 =?utf-8?B?UEl4OHBxNDRaRm1Oc0N4YTR3bzJaaVdPM2piNGV3ZXp4Z1JzQXl0Q051Y1g5?=
 =?utf-8?B?TFFScVlPUTNyWlJSdjdwd3A3aTQvZmNteUw3aEp2NTdCSU9HK0JoY2dnTWRB?=
 =?utf-8?B?bXE4NVI4U2xrNlBlaGJ0RXhtamQraEJUREVKRG1uSXNvcTFLaEVKZHBlQW9B?=
 =?utf-8?B?NnlabW5ERnJLdDhMRXVmTG43aXNCQ016aXN3cGNOdkxtVmY3NlVodTIxVG5m?=
 =?utf-8?B?bnBYV0xHNlhZampjR1IwdHhxQUhxelZxWUw4TXEwU3lPL3dyT09hSDFMbFJG?=
 =?utf-8?B?bXM2VlFQOEMxR0hEWWFNbkp6amlRVWFaeCtleEc2RXJCVVF0MHhvTTNoNldz?=
 =?utf-8?B?WHF1TEQwWkgzRXovUG9RZEltNWVjWmwvdFViWDlibE41NFc4QllKQkFDeHF6?=
 =?utf-8?B?VnI0WDd1OUgxVkFDTkpGejV1RTJvOGE4ZkUxVkFrN1pWRXpEb1ZtMzYzZEtM?=
 =?utf-8?B?RjdOV1A0TFE1M25sUTRvWEh1ZVZQVmNnUUZLSXpBSys2c0w2dVh5SnZmR21W?=
 =?utf-8?B?SEU4d1VyTW1DLzR0elJPa1dRL1puSUE5M2RnNUpNOUY1SHZaeTcwY0xiYi85?=
 =?utf-8?B?TjZmMkpiR2hQWEVhNjNQYlpCVkh0aW8rUFN4VnkvU3BSb1JJcHhFV0F5NzIr?=
 =?utf-8?B?KzFVZFhWWlhJSmVUZGx0cmtlYUdGZnRpUkk4cW1ObVFyQjBFUFRGNE8rWFcr?=
 =?utf-8?B?emFucUNra3N1azgrNnZWU1pJVkRoZFE0YktteFRpaSs0a3NnWlRLWmYyMUV6?=
 =?utf-8?B?cks2Mnl2U0JDM3ZhT1JrTUk5dlg4Vzd1cnErS0JhbENyVmd4a1RsZVZDcXU3?=
 =?utf-8?B?ZnMwcjAyTkc5VXRUQnU4ZWxWSHNPRjR1WDFyN1ZhbFlHS0V2QWdGc0pxZlBw?=
 =?utf-8?B?UFZWeFZhc2VyV1RWRkI0N1V4WStONkxXTURKZ1pFcHQ3UTZ6dFNuNk1Ybit3?=
 =?utf-8?B?eE5SYmlUREd0cTVQKzFTd0NSUkpqZTQzVnFXcExDV3ZpN2cvTWNqZHNKOHcx?=
 =?utf-8?B?Qk9jbUxsd3BxSVJNMmRNWjU5U2UrNERFRTFhOEV1KzR5Z2t0RWRUVHNwSDRo?=
 =?utf-8?B?bkdIVTFFOGhvbGdtWHE2WWpTZVJ1VEw0TGJLZTBIUlFJYXRlSk45UU83SkVB?=
 =?utf-8?B?c2VCUDI4R21RYktKYnVSMGNlZDN1UnoyMTBVRFhYTEpBemNMWHFlSU5mcXp4?=
 =?utf-8?B?bTdHUzBEMnlFN0lZVzRQNlh1bUJPZk5TT2JOQ2JMWTFpR2RJY1dFanp2YXF0?=
 =?utf-8?B?VUJZOVQ4Nk0wczVVMXoweVBFL2I3RjFBQjNzdTd6NkhPV1dNSVNDM2paVmFN?=
 =?utf-8?B?ZUwwS0RGZVZwV0FYWExqUXlsR3dLcTZycmhzV2p4QlgwZ1E1c2t0WGxRUith?=
 =?utf-8?B?emhoM2ZnWW1Vd0wzMlFXRkUrL0xRNUJhS3VVS1lvZ05RTGRQeTFKakpybDJR?=
 =?utf-8?B?TWhPck5qR1FoUjV6Mnl1MlpJVEhPOTJvNFQvVnZteWNEbjQzUnBKOTdmbktz?=
 =?utf-8?B?a3FiSm1PbnhsUk14RU1lSU4rQ240aEZ3cXR1bWtGQkJzaElTSzBZd0FsZjFo?=
 =?utf-8?B?WmpqWFFvb2xENHYxOU96N2RocURYVHhZYTBrMlhKMGFSK2dFUXRWK2l4RXZ1?=
 =?utf-8?B?YVVFODBTZ25adm1uRnRGbVQxcXhpS1AvMFFYVHZwZDJpVWNZOUlEV0ozL1hL?=
 =?utf-8?B?a25TZThyYlV2dE5rS1A1NjkydWZiQ0kraTg1UmRmWVdVRTZlSHpTc2ZrWm9w?=
 =?utf-8?B?SEdORUMzZ3hYWVg5L1h6YVlzQ3VFZDhYQkhieHlVazRudis1eENrbHc2d2xi?=
 =?utf-8?Q?HeRoIFW0Z4c/ejtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C317496B47AE334296A512BEFBB3FD69@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862ceb0f-f85e-4bbe-3bb2-08da191135b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:38:13.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKiAfW6SVaiOsmqs+Pj3vJ4jeVeFuX78aT/TePop7EX4RL+/MpLwN3NFPYu7O8ucLCy/tVLC6550h+gBxDhBbQ93YfHaG0bxRYQSVcf3n6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10102
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzcgMjM6MTIsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUaHUsIEFw
ciAwNywgMjAyMiBhdCAwODowOTozM1BNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2Ug
c3RpcHBpbmcgU19TSUdJRCBzaG91bGQgY2hlY2sgU19JWEdSUCwgc28gdW1hc2sgaXQgdG8gY2hl
Y2sgd2hldGhlcg0KPj4gd29ya3Mgd2VsbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1
PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgc3JjL2lkbWFwcGVkLW1v
dW50cy9pZG1hcHBlZC1tb3VudHMuYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jIGIvc3JjL2lkbWFwcGVkLW1v
dW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4gaW5kZXggZDI2MzhjNjQuLmQ2NzY5ZjA4IDEwMDY0
NA0KPj4gLS0tIGEvc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4gKysr
IGIvc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4gQEAgLTgwMzEsNiAr
ODAzMSwyNyBAQCBvdXQ6DQo+PiAgIAlyZXR1cm4gZnJldDsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0
aWMgaW50IHNldGdpZF9jcmVhdGVfdW1hc2sodm9pZCkNCj4+ICt7DQo+PiArCXBpZF90IHBpZDsN
Cj4+ICsNCj4+ICsJdW1hc2soU19JWEdSUCk7DQo+DQo+IE9rLCB0aGlzIGlzIG1pZ3JhaW5lIHRl
cnJpdG9yeSAobm90IHlvdXIgZmF1bHQgb2ZjKS4gU28gSSB0aGluayB3ZSB3YW50DQo+IHRvIG5v
dCBqdXN0IHdyYXAgdGhlIHVtYXNrKCkgYW5kIHNldGZhY2woKSBjb2RlIGFyb3VuZCB0aGUgZXhp
c3RpbmcNCj4gc2V0Z2lkKCkgdGVzdHMuIFRoYXQncyBqdXN0IHNvIGNvbXBsZXggdG8gcmVhc29u
IGFib3V0IHRoYXQgdGhlIHRlc3QNCj4ganVzdCBhZGRzIGNvbmZ1c2lvbiBpZiB3ZSBqdXN0IGhh
Y2sgaXQgaW50byBleGlzdGluZyBmdW5jdGlvbnMuDQo+DQo+IENhbiB5b3UgcGxlYXNlIGFkZCBz
ZXBhcmF0ZSB0ZXN0cyB0aGF0IGRvbid0IGp1c3Qgd3JhcCBleGlzdGluZyB0ZXN0cw0KPiB2aWEg
dW1hc2soKStmb3JrKCkgYW5kIGluc3RlYWQgYWRkIGRlZGljYXRlZCB1bWFzaygpLWJhc2VkIGFu
ZA0KPiBhY2woKS1iYXNlZCBmdW5jdGlvbnMuDQpPaywgSSB1bmRlcnN0YW5kLg0KPg0KPiBEbyB5
b3UgaGF2ZSB0aW1lIHRvIGRvIHRoYXQ/DQpZZXMsIEkgaGF2ZSB0aW1lIHRvIGRvIHRoaXMuIFll
c3RlcmRheSBJIGh1cnJpZWRseSBzZW50IG91dCB0aGlzIA0KcGF0Y2hzZXQgaW4gb3JkZXIgdG8g
Z2V0IG1vcmUgY29tbWVudHMgaW4gdGhpcyB3ZWVrLg0KPg0KPiBSaWdodCBub3cgaXQncyBjb25m
dXNpbmcgYmVjYXVzZSB0aGVyZSdzIGFuIGludHJpY2F0ZSByZWxhdGlvbnNoaXANCj4gYmV0d2Vl
biBhY2xzIGFuZCBjdXJyZW50X3VtYXNrKCkgYW5kIHRoYXQgbmVlZHMgdG8gYmUgbWVudGlvbmVk
IGluIHRoZQ0KPiByZXNwZWN0aXZlIHRlc3RzLg0KPg0KPiBUaGUgY3VycmVudF91bWFzaygpIGlz
IHN0cmlwcGVkIGZyb20gdGhlIG1vZGUgZGlyZWN0bHkgaW4gdGhlIHZmcyBpZiB0aGUNCj4gZmls
ZXN5c3RlbSBlaXRoZXIgZG9lc24ndCBzdXBwb3J0IGFjbHMgb3IgdGhlIGZpbGVzeXN0ZW0gaGFz
IGJlZW4NCj4gbW91bnRlZCB3aXRob3V0IHBvc2ljIGFjbCBzdXBwb3J0Lg0KPg0KPiBJZiB0aGUg
ZmlsZXN5c3RlbSBkb2VzIHN1cHBvcnQgYWNscyB0aGVuIGN1cnJlbnRfdW1hc2soKSBzdHJpcHBp
bmcgaXMNCj4gZGVmZXJyZWQgdG8gcG9zaXhfYWNsX2NyZWF0ZSgpLiBTbyB3aGVuIHRoZSBmaWxl
c3lzdGVtIGNhbGxzDQo+IHBvc2l4X2FjbF9jcmVhdGUoKSBhbmQgdGhlcmUgYXJlIG5vIGFjbHMg
c2V0IG9yIG5vdCBzdXBwb3J0ZWQgdGhlbg0KPiBjdXJyZW50X3VtYXNrKCkgd2lsbCBiZSBzdHJp
cHBlZC4NCj4NCj4gSWYgdGhlIHBhcmVudCBkaXJlY3RvcnkgaGFzIGEgZGVmYXVsdCBhY2wgdGhl
biBwZXJtaXNzaW9ucyBhcmUgYmFzZWQgb2ZmDQo+IG9mIHRoYXQgYW5kIGN1cnJlbnRfdW1hc2so
KSBpcyBpZ25vcmVkLiBTcGVjaWZpY2FsbHksIGlmIHRoZSBBQ0wgaGFzIGFuDQo+IEFDTF9NQVNL
IGVudHJ5LCB0aGUgZ3JvdXAgcGVybWlzc2lvbnMgY29ycmVzcG9uZCB0byB0aGUgcGVybWlzc2lv
bnMgb2YNCj4gdGhlIEFDTF9NQVNLIGVudHJ5LiBPdGhlcndpc2UsIGlmIHRoZSBBQ0wgaGFzIG5v
IEFDTF9NQVNLIGVudHJ5LCB0aGUNCj4gZ3JvdXAgcGVybWlzc2lvbnMgY29ycmVzcG9uZCB0byB0
aGUgcGVybWlzc2lvbnMgb2YgdGhlIEFDTF9HUk9VUF9PQkoNCj4gZW50cnkuDQo+DQo+IFllcywg
aXQncyBjb25mdXNpbmcgd2hpY2ggaXMgd2h5IHdlIG5lZWQgdG8gY2xlYXJseSBnaXZlIGJvdGgg
YWNscyBhbmQNCj4gdGhlIHVtYXNrKCkgdGVzdHMgdGhlaXIgc2VwYXJhdGUgZnVuY3Rpb25zIGFu
ZCBub3QganVzdCBoYWNrIHRoZW0gaW50bw0KPiB0aGUgZXhpc3RpbmcgZnVuY3Rpb25zLg0KDQpH
b3QgaXQuDQo+DQo+IEFzIGl0IHN0YW5kcyB0aGUgdW1hc2soKSBhbmQgcG9zaXggYWNsKCkgdGVz
dHMgb25seSBwYXNzIGJ5IGFjY2lkZW50DQo+IGJlY2F1c2UgdGhlIGZpbGVzeXN0ZW0geW91J3Jl
IHRlc3Rpbmcgb24gc3VwcG9ydHMgYWNscyBidXQgZG9lc24ndCBzdHJpcA0KPiB0aGUgU19JWEdS
UCBiaXQuIFNvIHRoZSBjdXJyZW50X3VtYXNrKCkgaXMgaWdub3JlZCBhbmQgdGhhdCdzIHdoeSB0
aGUNCj4gdGVzdHMgcGFzcywgSSB0aGluay4gT3RoZXJ3aXNlIHRoZXknZCBmYWlsIGJlY2F1c2Ug
dGhleSB0ZXN0IHRoZSB3cm9uZw0KPiB0aGluZy4NCk9oLCB5ZXMuDQo+DQo+IFlvdSBjYW4gdmVy
aWZ5IHRoaXMgYnkgc2V0dGluZw0KPiBleHBvcnQgTU9VTlRfT1BUSU9OUz0nLW8gbm9hY2wnDQo+
IGluIHlvdXIgeGZzdGVzdHMgY29uZmlnLg0KPg0KPiBZb3UnbGwgc2VlIHRoZSB0ZXN0IGZhaWwg
anVzdCBsaWtlIGl0IHNob3VsZDoNCj4NCj4gdWJ1bnR1QGltcDEtdm06fi9zcmMvZ2l0L3hmc3Rl
c3RzJCBzdWRvIC4vY2hlY2sgZ2VuZXJpYy85OTkNCj4gRlNUWVAgICAgICAgICAtLSBleHQ0DQo+
IFBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGltcDEtdm0gNS4xOC4wLXJjMS1vdmwtN2Qz
NTRiY2QzN2QxICMyNzMgU01QIFBSRUVNUFRfRFlOQU1JQyBUaHUgQXByIDcgMTE6MDc6MDggVVRD
IDIwMjINCj4gTUtGU19PUFRJT05TICAtLSAvZGV2L3NkYTQNCj4gTU9VTlRfT1BUSU9OUyAtLSAt
byBub2FjbCAvZGV2L3NkYTQgL21udC9zY3JhdGNoDQo+DQo+IGdlbmVyaWMvOTk5IDJzIC4uLiBb
ZmFpbGVkLCBleGl0IHN0YXR1cyAxXS0gb3V0cHV0IG1pc21hdGNoIChzZWUgL2hvbWUvdWJ1bnR1
L3NyYy9naXQveGZzdGVzdHMvcmVzdWx0cy8vZ2VuZXJpYy85OTkub3V0LmJhZCkNCj4gICAgICAt
LS0gdGVzdHMvZ2VuZXJpYy85OTkub3V0ICAgMjAyMi0wNC0wNyAxMjo0ODoxOC45NDgwMDAwMDAg
KzAwMDANCj4gICAgICArKysgL2hvbWUvdWJ1bnR1L3NyYy9naXQveGZzdGVzdHMvcmVzdWx0cy8v
Z2VuZXJpYy85OTkub3V0LmJhZCAgICAgIDIwMjItMDQtMDcgMTQ6MTk6MjguNTE3ODExMDU0ICsw
MDAwDQo+ICAgICAgQEAgLTEsMiArMSw1IEBADQo+ICAgICAgIFFBIG91dHB1dCBjcmVhdGVkIGJ5
IDk5OQ0KPiAgICAgICBTaWxlbmNlIGlzIGdvbGRlbg0KPiAgICAgICtpZG1hcHBlZC1tb3VudHMu
YzogODAwMjogc2V0Z2lkX2NyZWF0ZSAtIFN1Y2Nlc3MgLSBmYWlsdXJlOiBpc19zZXRnaWQNCj4g
ICAgICAraWRtYXBwZWQtbW91bnRzLmM6IDgxMTA6IHNldGdpZF9jcmVhdGVfdW1hc2sgLSBTdWNj
ZXNzIC0gZmFpbHVyZTogc2V0Z2lkDQo+ICAgICAgK2lkbWFwcGVkLW1vdW50cy5jOiAxNDQyODog
cnVuX3Rlc3QgLSBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5IC0gZmFpbHVyZTogY3JlYXRlIG9w
ZXJhdGlvbnMgaW4gZGlyZWN0b3JpZXMgd2l0aCBzZXRnaWQgYml0IHNldCBieSB1bWFzayhTX0lY
R1JQKQ0KPiAgICAgIC4uLg0KPiAgICAgIChSdW4gJ2RpZmYgLXUgL2hvbWUvdWJ1bnR1L3NyYy9n
aXQveGZzdGVzdHMvdGVzdHMvZ2VuZXJpYy85OTkub3V0IC9ob21lL3VidW50dS9zcmMvZ2l0L3hm
c3Rlc3RzL3Jlc3VsdHMvL2dlbmVyaWMvOTk5Lm91dC5iYWQnICB0byBzZWUgdGhlIGVudGlyZSBk
aWZmKQ0KPiBSYW46IGdlbmVyaWMvOTk5DQo+IEZhaWx1cmVzOiBnZW5lcmljLzk5OQ0KPiBGYWls
ZWQgMSBvZiAxIHRlc3RzDQpJIHdpbGwgZGVzaWduIHNlcGFyYXRlIGZ1bmN0aW9uIGZvciB1bWFz
ayBhbmQgYWNsLCBidXQgSSBkb3VidXQgd2hldGhlciANCndlIGFsc28gbmVlZCB0byB0ZXN0IHRo
ZW0gaW4gaW5fdXNlcm5zIGFuZCBpZG1hcGVkX2luX3VzZXIgc2l0dWF0aW9uLg0KDQpwczogSSB3
aWxsIHB1dCB1bWFzayBhbmQgYWNsIHBhdGNoIGFzIHRoZSA1dGgvNnRoIHRoZSBwYXRjaHNldCBi
ZWNhdXNlIA0Kb3RoZXIgcGF0Y2ggb25seSBoYXMgc21hbGwgbml0cyBhbmQgZWFzeSB0byBtb2Rp
ZnkuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0K
