Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3E325ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 09:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZIV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 03:21:27 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:9357 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhBZIVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:21:14 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 03:21:09 EST
IronPort-SDR: XdyspZ0K3AQ1hivyUf5vavZpHyeFYzuAKSBraN8RWBGdBGOlUK6bgTLMmwmaUWBeCbyIZ6gXST
 EW0AmuXfd7zwLrVqmMtUd+7NII0BP3XReh8jd3ACh6S2T53p+8lP7lQhY98FUGMJaTyn02uhi9
 07VmxzTzJF/TCBiFAJ9zKE+P1tanAd1SPCGkM9EJWvA783JUT4ZamDhYqYEJrZgV01thXyOJXP
 PramsgEA+rNDazhNCvf3C2gPy1qSe1nGuOfAl1i8StZBadrz5iRHqSn/XxcMt6mx0ZFsxxxixu
 eUY=
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="27000737"
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="27000737"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 17:11:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3MhxQoPho/U1lPviKSvvjbDdTJP9DxkgqSW0S1HkFTCJAp+TwPM8blmh+18lX8dafb372rKfWkmFSUwGUqNQHTn0GrP93vPq1MkrJGArtoiEf+PxUnsbMZGD9ADcolj3e+Iz8e7qjbzl84XpMLM17yeLN0wkaduYcV0m1wdiv2wJ3eyLm0afLgNFlIRmxpulTVMJOQsA2srLiyYDD12YMyH8BBe619q7vSYroD/CMlrY1No/uY1EfryguNS7i3KYQW7yqYoTrd95gh6NgTPpAxKQd9KqpHQkKozHNXI52UrSffcuKAYDt3We6daC/LZEMK/U7sDwVvZFmeV/MZ1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak/meoZ1EyG8mMt+rOT6jIYSj0VqRGrv2s4mcMfbPyY=;
 b=nEcTW9xGFCLJkjom14NN/ukWnrdd92pgb27H9a+3rBZxLDUmqx0xeZVD8w3397Pooe3RqYwx/dKY8+++80vIZwjxiDdmgkq58ySnWu+ORWp2al7cs4qUDD8oUnoJFZIHkwEOzfxlq5t+wGMlYw7/HS3J7exKHy3Fdd9d3LPmyGdvwxp4Z/mR4BRtG4mVPLYtcMfg8PTZdFwfMZ9MbUsHvS9sXs/MD0kCxSAdS9ijrn+IpdhjnEpJpVHJ3gEABiZhKqqgUfgpFcRFcV5W2+eFyGP87pfVNzbgzIjDRA4b9S7xG8hhdt72HuuwTRnKh5WqZwTiz2Jp06flZ59+bI3j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak/meoZ1EyG8mMt+rOT6jIYSj0VqRGrv2s4mcMfbPyY=;
 b=YicOCFxqX0+Ow+cnEmtBU/mjqLnP2Kfsa2QZmEpN7VAESGeBBpF3bWUC5wqOoFIEXWnxCEyvdG9wTeO4aIbjqsffiGq4PjRg1YrDYtz1pShir8XOLm/+qJ6xMVOi/+f2L99jcAPHD7ZPV+HwizdaGM/77KmUWre+0nqQjt7m2Io=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB5206.jpnprd01.prod.outlook.com (2603:1096:604:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 08:11:08 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 08:11:08 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 07/10] iomap: Introduce iomap_apply2() for operations
 on two files
Thread-Topic: [PATCH v2 07/10] iomap: Introduce iomap_apply2() for operations
 on two files
Thread-Index: AQHXC9VfucWA/H9ic0KAPVDA087Khqpp1CoAgAA7HZg=
Date:   Fri, 26 Feb 2021 08:11:08 +0000
Message-ID: <OSBPR01MB2920FA6E33A264133D7908FDF49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <20210226002030.653855-8-ruansy.fnst@fujitsu.com>,<20210226041446.GV7272@magnolia>
In-Reply-To: <20210226041446.GV7272@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53e551b0-aa10-4f49-8d2b-08d8da2e129f
x-ms-traffictypediagnostic: OSBPR01MB5206:
x-microsoft-antispam-prvs: <OSBPR01MB520628761B6D8816BF0340F4F49D9@OSBPR01MB5206.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtxO5QWcSBPdTNvxLBYJjskcYhfLOL6c1WO2hyFQmo2rvJqlazNXFbMAEn8sMb6N6rZ6p34xVtHHSXds3+xrAa0IficHEu8mFa+QRyBkZS55V387YfUCBX3msJGT0Yx8MVUTnEXWvEpVt6S3DDtZibH0PCwP81MynNWQWJ1VuU7nLeQiIX0EaXW77893h9TZLwz+q4JfUgURVOaC1sLU/0Wqxxb+VUiM8nNAedV7Rx5vwZuq9xiHhPtwc9/hLsZpFgtY5wzi33yGq2pbUkDcT7Ch9LFVIkmdRXYwP2od0WZGMH3aSid8eIG2k+dH799Qu18x4Ch599VBKwQL9e44IFY0yS1fdjZ8u+N3OFL54qTXet7utgVxD9CkaMnz6JbpsnK8UQ3US8DwZikX4Z03v6MK+G2hmdxqnW3RFytX1i9ZTf40tPUIJoVB2GZMv+4tMzaW6ws7rWAYha3V7EnyVu6zmNRr9TA8tD+o/Gm8feceqe7gn0btFl9DjpvASLE4ZUpa3j1dimhmNFZDBiE1pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(83380400001)(86362001)(55016002)(71200400001)(91956017)(2906002)(26005)(66476007)(52536014)(4326008)(478600001)(9686003)(66556008)(54906003)(85182001)(5660300002)(76116006)(8936002)(8676002)(186003)(6916009)(66446008)(316002)(6506007)(66946007)(7416002)(7696005)(33656002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YU9aWnFXR0l5bk8wbTlFVWNMRFkrbzVSY1JYazZBUXlGMVhZRmVPbzg1VS9z?=
 =?gb2312?B?WFl0VGtFdnpvWVR1ZHBhSDljbWFZYXAvbUQ2TndBY1pPcnBaK1NUbVdLaGlB?=
 =?gb2312?B?dHlPTE9yMVZCQWdoSTBtQ3Z5aTJFdE4ydU1NRGhmeXpBRXBMWnA0dy92Uk95?=
 =?gb2312?B?OFBDWDA3SVY2RDRFQXpqSkZSRUJPTWxwdzhSMGNLRDVtWVc3TDNuOTRXU0pH?=
 =?gb2312?B?U3pzdHV0Z1h6cWZSZVNHSkVzSjhPRFdUeU1DbThkaGlTdU5zQlB5OGsvanNh?=
 =?gb2312?B?dVJvOGZGWlMwNnU3aVpub0dKTDkrMHlVNnZYejBjaU9BYVJaN2FLVStDeENW?=
 =?gb2312?B?a0YvSktSRkR3UmdQcXZmQVdCQ1U1aWVkOHhRNDFQTlpZcVRZdkNDT0lkSUZI?=
 =?gb2312?B?ZUt3OU54MFYza0FGcmhZQVM1RlZhUlBBMXYyTW9nbHBEUVIwa2E0TERXUSt2?=
 =?gb2312?B?YWxkdUZESlE4eGtucStaZzNhY1NBT2ZFUWhZVENoMnVMMWQwZkRzWElJWHNI?=
 =?gb2312?B?ZkZqMkluNndhWGlGdnVDdHdTVDhQc3pMOGYvendmdWRpRDIvR1ZmdENrNlIv?=
 =?gb2312?B?VFpPcXgzTUdwTFJYa0toaEdIMmU1RE40RVppV294WisyeWxvNUtyRnFRRzZK?=
 =?gb2312?B?Wk0zU3M0bTRQSU9RNUlkVEdPT3dxTEtHTzZmRHRTREY3MktPZ2liMkR5OVN2?=
 =?gb2312?B?MlF5SmFIRWpJU2tKZmkzWTRxVHRJWGNsV1BrSXM3TzZoeWsvbDk4WnFnemVR?=
 =?gb2312?B?Mk1LbFUzbkg1M1N5L1ZQazJJbW9SZHhOR2h3QWp5cWZsRUs0NnpENXdMdEFj?=
 =?gb2312?B?cHdDbEMzcDhtbUwrNEttd3N2ZGVuL0RVSTVVQk9Lalg2d1hFbXRGcDhLeTdK?=
 =?gb2312?B?OHlDWThKdHhGTE1IVzdERHRPZkQrSURpN3ppdnJIVWV6TWdaSlk1QmZrWWJR?=
 =?gb2312?B?V0lsS0lPWmFNYm1QdStnRUVpencxZEtFc0xWWHJYczdFUG9mR1JXb0RmZjRB?=
 =?gb2312?B?NDk3NFNhcmxwQ29UMWpnLzJpZGV0UWowOGdSdS9jb1hIMlpyenJYQTMwQm0r?=
 =?gb2312?B?SXc4bm5ZcjlsaHNZUkdjZUNiVHRLMTVMK3NZanQraVRrZ1FnRFZZTDRLSTB5?=
 =?gb2312?B?TXVxNnVwNWpvUERPYjVKVExtS1Azd2lLa0Eya3B4TkNUaHM2aFVZbE9wWlht?=
 =?gb2312?B?S3pPZjFuY3piZUpvNDJKVFUxYUllVm9Hc1Q0UXRRYmJVZXdkOEtrNmprQkto?=
 =?gb2312?B?MnVRZ3R5Nk9TeVRiQm1kSkFlZ2tjbTdvdFdPT1JJeHlzOTJpZlRDNW42VGkr?=
 =?gb2312?B?Q1FsZzJ3Q2VHS0ZCdi9WSkI2eFB1ZnlGM2ZqOVU2NGoyWGJ5cEEwQ0VxOEo3?=
 =?gb2312?B?M0N5QS81L0YxRHdDNnc0RHh4cHFsQ0ZyTTArNDhDbXpyMDZkOUZJTUI1dWZy?=
 =?gb2312?B?UDFpYmVXZExVcHlHNUhkdUQ5Qi85R0srVEc4aGppamczYWFNTkcvOEJwWW5o?=
 =?gb2312?B?T2lORkZobE9rSmx1Y0N1alNlaVpVQnJyVlBGeTMyQU9veGNwenNqTWdKTFNW?=
 =?gb2312?B?MXNNVU5uWmk4WWFDSlBYUkNXbUZlK3lGMXFtOWJBWnhiSEFJTUozRmo2NytG?=
 =?gb2312?B?K3ptSkx4NUpwaWx4cmxGYk43TjRnSkJPTU9LWXVKbDFZU1RzR2pDalUyZ3VJ?=
 =?gb2312?B?ckR2Z0M1Ukc5d0VLUnVGY3BmN0R6V0l3M2MzQTdBWEFMaU56VGw3U1BWZDQz?=
 =?gb2312?Q?qDYcgqXbVieYrMemKc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e551b0-aa10-4f49-8d2b-08d8da2e129f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 08:11:08.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZNSXOreGeQUtbY7EWsTdTCz+g9SWOv59SsCpWKha7TMfwM1aXA9P+3pribqcF6HouIIusVp2AAdyRhc1aGWXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5206
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBGcmksIEZlYiAyNiwgMjAyMSBhdCAwODoyMDoyN0FNICswODAwLCBTaGl5YW5nIFJ1YW4g
d3JvdGU6Cj4gPiBTb21lIG9wZXJhdGlvbnMsIHN1Y2ggYXMgY29tcGFyaW5nIGEgcmFuZ2Ugb2Yg
ZGF0YSBpbiB0d28gZmlsZXMgdW5kZXIKPiA+IGZzZGF4IG1vZGUsIHJlcXVpcmVzIG5lc3RlZCBp
b21hcF9vcGVuKCkvaW9tYXBfZW5kKCkgb24gdHdvIGZpbGUuICBUaHVzLAo+ID4gd2UgaW50cm9k
dWNlIGlvbWFwX2FwcGx5MigpIHRvIGFjY2VwdCBhcmd1bWVudHMgZnJvbSB0d28gZmlsZXMgYW5k
Cj4gPiBpb21hcF9hY3RvcjJfdCBmb3IgYWN0aW9ucyBvbiB0d28gZmlsZXMuCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4KPiA+IC0t
LQo+ID4gIGZzL2lvbWFwL2FwcGx5LmMgICAgICB8IDUxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPiA+ICBpbmNsdWRlL2xpbnV4L2lvbWFwLmggfCAgNyArKysr
Ky0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
PiA+Ci4uLgo+ID4gKyAgICAgcmV0ID0gb3BzLT5pb21hcF9iZWdpbihpbm8yLCBwb3MyLCBsZW5n
dGgsIDAsICZkbWFwLCBOVUxMKTsKPiA+ICsgICAgIGlmIChyZXQpCj4gPiArICAgICAgICAgICAg
IGdvdG8gb3V0X2Rlc3Q7Cj4gPiArICAgICBpZiAoV0FSTl9PTihkbWFwLm9mZnNldCA+IHBvczIp
KSB7Cj4gPiArICAgICAgICAgICAgIHdyaXR0ZW4gPSAtRUlPOwo+ID4gKyAgICAgICAgICAgICBn
b3RvIG91dF9kZXN0Owo+ID4gKyAgICAgfQo+ID4gKyAgICAgaWYgKFdBUk5fT04oZG1hcC5sZW5n
dGggPT0gMCkpIHsKPiA+ICsgICAgICAgICAgICAgd3JpdHRlbiA9IC1FSU87Cj4gPiArICAgICAg
ICAgICAgIGdvdG8gb3V0X2Rlc3Q7Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICAvKiBtYWtl
IHN1cmUgZXh0ZW50IGxlbmd0aCBvZiB0d28gZmlsZSBpcyBlcXVhbCAqLwo+ID4gKyAgICAgaWYg
KFdBUk5fT04oc21hcC5sZW5ndGggIT0gZG1hcC5sZW5ndGgpKSB7Cj4gCj4gV2h5IG5vdCBzZXQg
c21hcC5sZW5ndGggYW5kIGRtYXAubGVuZ3RoIHRvIG1pbihzbWFwLmxlbmd0aCwgZG1hcC5sZW5n
dGgpID8KPiAKCllvdSBhcmUgcmlnaHQuICBJIGZvdW5kIHRoYXQgSSB1bmRlcnN0b29kIGl0IHdy
b25nLiAgTXkgYmFkLgoKSSdsbCBmaXggdGhpcyBwYXRjaCBhbmQgdGhlIG5leHQgb25lIHdoaWNo
IGNhbGwgdGhpcyBmdW5jdGlvbi4KCgotLQpUaGFua3MsClJ1YW4gU2hpeWFuZy4KCj4gLS1ECj4g
