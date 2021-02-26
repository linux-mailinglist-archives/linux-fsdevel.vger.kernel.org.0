Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F13260B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBZJ6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:58:23 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:57830 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhBZJ4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:56:25 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 04:56:09 EST
IronPort-SDR: 30NIOz+v1U7CTutXgsRs+B3u20+2uEer2a+NbxzbQbCgp3zOsF28JaDmfwab+riwsUCo3Cmy2t
 BmdEWl6zv+D28QlyiUHAASFe9UVQa8xOZ5DXlcn+zxdSue3o8Og2Lca4ur/AELapZRBx7HZa97
 hNlDeei+QrQuiHCSnBdKXq2MwcZE34FX/0sfMKMa5oXr3xGeoWXyEXr7GrulQCvXeXe3W4dohn
 21BB81KHTJhiTKIkZRisyhpthSeW3fzCIKNb9TQJYnJ4j0mqtr3wQsmCkXpddXP2GyS9zFcI5r
 Q9c=
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="26805831"
X-IronPort-AV: E=Sophos;i="5.81,208,1610377200"; 
   d="scan'208";a="26805831"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 18:45:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1B7fr7M3/ILV0fyZLflcpt77M15UxdzvUFwAjHta8+BlGE9qrdyjctmG2J8CdoPvvY1EQtS+OmIfgy+6KrsnT9ylo6oobaZsl7vbAB0Gz5x+8G5u3YigbmwJplRhkTO2WT74OBg/ejS1nESeGuSv0UJcHFSR5pIeDFshettEunYtG9Ded2X53Yh9WUFhWB1J9jgcDE+rV+lNDGb+J/GW5Yo7DLjf8hV0GAQA70fD1LAgEMZmRXEnmtnFgdwLy8liBSLkeWoRxbIVdSyc+RB2si1W5JUvYmrxZ4m/7AM/8QWXS+ILsNEOekCeeH59ljkdA9otJQ4ma2KLoV1KFl4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJtXw0i4KVuKh0cTDpJQX59bhuFx0Wf4wSWTrGM2Asc=;
 b=k4DYLD59EW4hLWo+37rtm4Ixhw4fDUq+UsisaYoL7GO7rtoSJVpwm8HM30lGlSA+9h4+/ke4AmnLjhAvV5GRyD5Fjpb+L8zyWHiRkY/LuRgi2GGH4LLx0volao+LW7zLLfhp7RXiOMD1v0KNXccle0ODEsWdG5dMh6MXXTSruwk8M+Sg1jEZGP7WXwFf76aVifyioxVLIgWZIvNN9CQ4nx2ynDEJ8XR3/08iCkuaWlnxRN198y0340fV697IYQDjm3LELtI4XHPUmfJq027YEKRtOCqLcBgHEB+IigsHvaBra6GCD3AHj0r2D33iOEF+H5DFPnHS7v1z1iN1zzFBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJtXw0i4KVuKh0cTDpJQX59bhuFx0Wf4wSWTrGM2Asc=;
 b=MFGrpZWey4OOwR89I8YAzKfjm06LGX0gbK4JGWkyhffYzZIa9Ronj62yAB7zlQGmZUOXIrROPbs+CKNAooUFLqQl2WHTQwBVDCOlN/lwoOcu84+TlBLN+OoWbgmgV2inCZ5TbOGtXMkRHnCT12Nf2RD2APWVbbBUjsI6kSTlyms=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB5816.jpnprd01.prod.outlook.com (2603:1096:604:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 09:45:46 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 09:45:46 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Subject: Question about the "EXPERIMENTAL" tag for dax in XFS
Thread-Topic: Question about the "EXPERIMENTAL" tag for dax in XFS
Thread-Index: AQHXDCQnpTImuSbsuEuKD1BHo1YY+g==
Date:   Fri, 26 Feb 2021 09:45:45 +0000
Message-ID: <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f91ecbdd-db6b-4d96-5caf-08d8da3b4ab8
x-ms-traffictypediagnostic: OS3PR01MB5816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB5816BC74D5D1DDD232082EEDF49D9@OS3PR01MB5816.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Q8rtszZWkgDFHOR4Q7xcuYxtpqq19TxUr/I2JQRudOKHQCslSZQYyEqexZtGEqdDdTrFmCgSmbgVpIxQcS3YieDDlGiWSUHQlycHW0SrBSBr89RRugwihofN7nCsuE4AbBf5npxqkrP+sUR6jUDlOuU4N/w8v/Mky7puaAxFoK04Wa/yONDJFgJsa+uToZPOQWCnAmzjP8oX5uj495rEB4uOX6FwzAmW4fk9G/6uPthe5cH8D6aH2d/bjszkmqRfZQnbCbibKqb8LbCBHUdyZ6TJGoAi9ihiQwkCw6aqR65sbMbdNW0jEuBdiPF2w4sPIM3u8zJyzbqR8GfqahMSJ9yP17o2CzQu8BUXHueVdWz9jaquaAAU4IVY8HL2NTHgp5kwkmFUh1DgQqT6mrxjBuizwmNesdETU3j7Ynvf80PbEzfnlWrhKYe88xqmNdxeJBIU/xV9dOwnI43+4FlfzAcT3A8ChMkvYyVMTk/UPx/qY8zW0bJR8kbR2NdoHFxIMcyfC+XbAa1ZZRbKJMCfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(66556008)(52536014)(9686003)(7416002)(66476007)(55016002)(86362001)(64756008)(66946007)(66446008)(110136005)(83380400001)(71200400001)(316002)(107886003)(85182001)(7696005)(4326008)(186003)(8936002)(8676002)(26005)(6506007)(33656002)(4744005)(5660300002)(54906003)(2906002)(76116006)(91956017)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SHUrakJTcU5DS0pvVUw3MjByNXlVc3QzZG9pdGhsQUdaRTZKRDlZbDN0MGNG?=
 =?gb2312?B?TDFKaWZVNlk4ZTVMb1lNa01GN0NiR0xuaDVkWGkvVWZnYktuakR4V0hwQlhT?=
 =?gb2312?B?dWlya3d5cEI3bXIzQ2RzYVFld01qTVRUaEJpRnd5UC83LysyQVF3SnBBbzdy?=
 =?gb2312?B?RXI3dEdOYUE4MzB3SzQ2VXB1bWdMbFJuUm4wd0lQVURVbHViL2gwN1RycTEv?=
 =?gb2312?B?VEc0UVc0NitoSXlRQVNwRm5sODgvcUhFVFRHSkFHL0VHUnA1TERzN3c3Tm0y?=
 =?gb2312?B?SWF0d0xGZ0V1Zm1lYXdIZmgyVldnY2hHdUd0NVFYT2cxdUhzVmRvTjBVNU9u?=
 =?gb2312?B?QTBKTXhLZmZNR3FkVUxwQ1BieEEvQWpXcU80dUtoWmpPRDdOZ0JjRVJ3R05j?=
 =?gb2312?B?MnRTVFZqYUpIMXM5UlFtQUFtVEgvbEVOUnROUVRnc0J4WnVDdHFPVUpvTnU0?=
 =?gb2312?B?bGwyUDZyWWlPVGlwdEI3czk4cTNvRHhwdFlROCtFWURyNWI5Q0x3UkdsR3M5?=
 =?gb2312?B?OXhvZnJSeThCZmFuY3lOQyt2WjduZmRSVjBQay9VRjJaL1NtYVBidjF1QXlI?=
 =?gb2312?B?R21taWM2d1VqcGthUExkemU0MjVOeFhwb2VaU01UZzFuTHJySDVzV2JheFVH?=
 =?gb2312?B?eHJ2MFNkdktCUm8yU1p2UUx3Y3licE9UdW1WNEwvSDRZb2h0MElxNE8vdk9V?=
 =?gb2312?B?c1g2Yzc2ZHhRcHpINm01c29xVk9SZk8zZ1psdTY5UEdLdUdrTFlBMmdvTHFq?=
 =?gb2312?B?a2VBc24yQjlhZmg1ekZCL25RQWkrUksxMnVHMWJYaFpIRlV3dDYxeHlmbW9X?=
 =?gb2312?B?ekpJT2FuY3NnaDNDNDhuTUkvQ0pQQjduVkExWGh2N1VQMXpxZHIyeFdlcytE?=
 =?gb2312?B?OVVNOUo0WkpKR0RHQkNYRDU0Ulg5MDFMSkJlZm9EbTcxOWNSUll2MEgrM2tC?=
 =?gb2312?B?ZzdNV3AwT2diUHVrMWlra0FoZU03MHFkVkJ2S2VnY3RoL1BWSTJabXRRVWRq?=
 =?gb2312?B?ZWNJb3VzbFZmZ0pVRE9RQTYyNFN0VmNTWEszMWJBS3pGenFSay9EaTZtb3Nz?=
 =?gb2312?B?T2NRbVRNcHNtejNJLytZeEF2eitSS3FEcVMyYWdBcVIvcEl2TysrdFJreTZW?=
 =?gb2312?B?dzJpRGc2SVY2cHJEWmpid01XM2pQOWtDa09NdkdEMzlJQlVrQVV1Vlpxakxy?=
 =?gb2312?B?VzBITytEM0VoZEhsSWd0MEt1OE9XSzdXeWxtc2FtVzhmWDlGVlpQcFZ5bVBW?=
 =?gb2312?B?cTdUQ0VBKzltek9LcC81YlJFWnV3Q3VyRkFnaXZrYWFNcmU0ZlNlMkxvRWNi?=
 =?gb2312?B?WFZJQjlPS0FORldkRTRVcFpUbHhkSWNXekFjeXlqclRqRFBub3MwWjM1Z2dn?=
 =?gb2312?B?WXVxOEFjc0ZkL1dqYzd5MVhmb2xSajFNWEl0QTJadG50eHhPblo4NHFqRjh2?=
 =?gb2312?B?THdvZXNDNytCQ3I2aVhzdXlheXdJUE1iZUNvaGxTYmRkZnVHSEFlS3JuQ2NT?=
 =?gb2312?B?OTk4MGcrclc5VDF2Wm9TS09OYk9vUnhHc002a3Vlbk8wVXRIWUE4dWxRaEFF?=
 =?gb2312?B?VzRTSWd4SjNUUndrTG5tY2tXckUvWWNxS1QrL1oySmRrMDE0NkQ0NzBFd0Jw?=
 =?gb2312?B?bitudUdsZGs2WmxLbFY5YkwvTFRCTU1lc05Bc2tWdjBSV3lLbkErRFppTGlS?=
 =?gb2312?B?cUNFRDlnWFJEK053eGFwRm1SLzlCbVdPWk1GZ0ZaZEQ3UVRmbmNGMzIzSXlW?=
 =?gb2312?Q?8k/mqON7zWkH4Xlfcg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ecbdd-db6b-4d96-5caf-08d8da3b4ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 09:45:45.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otIJH1RssPktwNRpAw+JDESOzIwYfxsevw0arpYCB3GzBsQoYWknNqOGh9az5QcVQTA5Aaz1oU9DD2tOSyBUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5816
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIGd1eXMKCkJlc2lkZSB0aGlzIHBhdGNoc2V0LCBJJ2QgbGlrZSB0byBjb25maXJtIHNvbWV0
aGluZyBhYm91dCB0aGUgIkVYUEVSSU1FTlRBTCIgdGFnIGZvciBkYXggaW4gWEZTLgoKSW4gWEZT
LCB0aGUgIkVYUEVSSU1FTlRBTCIgdGFnLCB3aGljaCBpcyByZXBvcnRlZCBpbiB3YXJpbmcgbWVz
c2FnZSB3aGVuIHdlIG1vdW50IGEgcG1lbSBkZXZpY2Ugd2l0aCBkYXggb3B0aW9uLCBoYXMgYmVl
biBleGlzdGVkIGZvciBhIHdoaWxlLiAgSXQncyBhIGJpdCBhbm5veWluZyB3aGVuIHVzaW5nIGZz
ZGF4IGZlYXR1cmUuICBTbywgbXkgaW5pdGlhbCBpbnRlbnRpb24gd2FzIHRvIHJlbW92ZSB0aGlz
IHRhZy4gIEFuZCBJIHN0YXJ0ZWQgdG8gZmluZCBvdXQgYW5kIHNvbHZlIHRoZSBwcm9ibGVtcyB3
aGljaCBwcmV2ZW50IGl0IGZyb20gYmVpbmcgcmVtb3ZlZC4KCkFzIGlzIHRhbGtlZCBiZWZvcmUs
IHRoZXJlIGFyZSAzIG1haW4gcHJvYmxlbXMuICBUaGUgZmlyc3Qgb25lIGlzICJkYXggc2VtYW50
aWNzIiwgd2hpY2ggaGFzIGJlZW4gcmVzb2x2ZWQuICBUaGUgcmVzdCB0d28gYXJlICJSTUFQIGZv
ciBmc2RheCIgYW5kICJzdXBwb3J0IGRheCByZWZsaW5rIGZvciBmaWxlc3lzdGVtIiwgd2hpY2gg
SSBoYXZlIGJlZW4gd29ya2luZyBvbi4gIAoKU28sIHdoYXQgSSB3YW50IHRvIGNvbmZpcm0gaXM6
IGRvZXMgaXQgbWVhbnMgdGhhdCB3ZSBjYW4gcmVtb3ZlIHRoZSAiRVhQRVJJTUVOVEFMIiB0YWcg
d2hlbiB0aGUgcmVzdCB0d28gcHJvYmxlbSBhcmUgc29sdmVkPyAgT3IgbWF5YmUgdGhlcmUgYXJl
IG90aGVyIGltcG9ydGFudCBwcm9ibGVtcyBuZWVkIHRvIGJlIGZpeGVkIGJlZm9yZSByZW1vdmlu
ZyBpdD8gIElmIHRoZXJlIGFyZSwgY291bGQgeW91IHBsZWFzZSBzaG93IG1lIHRoYXQ/CgpUaGFu
ayB5b3UuCgoKLS0KUnVhbiBTaGl5YW5nLg==
