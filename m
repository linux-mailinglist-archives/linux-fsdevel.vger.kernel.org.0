Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A55350FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDAHED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:04:03 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:47096 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233465AbhDAHDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:03:38 -0400
IronPort-SDR: 0iArf7O9FF/f/rhrQDc+KVcgfD8wC0og3W8iAnlbDfwPMzQT2Ym7IG8LBFlTi3mH007bhKqKbQ
 JKkX1OvzM/Y7uVORCfCdMFVOcuh/IaSJtMQJri0AhbextHHwDHMYHXNCtiJdSZJrgSjzSBdA5X
 /AuKUEYYLewpXLKPx5gyX2600jMaENXsQYqcLo+CJbEQrASyII4Ko1rL54zU9+eFJ9CgZOoXEC
 4NnQd/iEJohugdLro/Sz6Dy/5ISe51PthKrlCGnxSidqMq0Un3vvpE5rGFs/XFBwCF78N36pYU
 CCg=
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="28961230"
X-IronPort-AV: E=Sophos;i="5.81,296,1610377200"; 
   d="scan'208";a="28961230"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:03:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdFfO7bSivGG0bLPgePK5pGiocpX+UwpJq9mFcPdAfN6HquqFqQGlCLRFxv5STMdEltFqEMF0M1zeZdbeyeEZf9uSn9bWSfLqMJuuQQe4FC+bCcDW0x6KfYZxfMFfF0K+BnUOvWN8OuXCAgQU+2aS0njuKvwRME1n5XACHLPDDXeJG3MR5bW+mqcr5pBXlC+T87XEeT6Gf/dpZncOwEO4iG+/3k4kLaffrFfyWIfZPcXwHJQdSTT0EV2kU2RBaRnZ2yAXkV82WdaSoCwQxiKpP5P+/oSCdHjHZieO9JbG//oxQ80HhpUd8A6t27j4nmHuRmaZ2HCsquP7xCPjbrm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ2D0oqL9SKmgpgxMcLnJRE/FwWCwQz2+5/rPbLiu60=;
 b=NyWSHrcUVrOdLfK45rHUUfQ5YKIePWc6xM3TlCjgVQWfpH/CjRTRe9kclfsch/JHCPOCmLD6v9VBeLq2nk90ZvRJxjvq4LemqhekylUOYYHjUBlto+hiyuwDb/d11V/Duy/Wgm46jGpwNojKOwrWvo1RQu6xbpLAl2NJ3DJdYXk20JglvQ9scVODTaspEfIB3fRFxU0BwLf3MGMireDjERpeNhRGU0KHIBKGJc12qqyratHwYzSd0EfRBsWWX2QgvxwL/h5mnaM3T8z7YAGMAWxAA3O1cQI6c1NpzTauhxDSBrIeZ7G7Bj0hZS6260kiMtvgVrqwbp73Eg88sS60hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ2D0oqL9SKmgpgxMcLnJRE/FwWCwQz2+5/rPbLiu60=;
 b=VnSwR6WpTqcFGqZIpkbA64aMiAnxk84oPHACAyT/xLFwISsYEU/PtPteyUKSCS9E20GMZXUyI8CKiCYSWQ/0clKVBCL6+NbWQf8joWaTbSHZciAvxSTOiVrkZ7LEI0nwG1ivcih4xn+AX0hMoKQvQE1TUJh0MJOwlti+NQs2qLk=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB4962.jpnprd01.prod.outlook.com (2603:1096:604:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 07:03:19 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 07:03:19 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: RE: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Thread-Topic: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Thread-Index: AQHXHGKvSyKT++zpt0u/LvAsYeN2+KqfSsYAgAAGOVA=
Date:   Thu, 1 Apr 2021 07:03:19 +0000
Message-ID: <OSBPR01MB2920C6CE58C98BF5A42E1700F47B9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
 <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
In-Reply-To: <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a62cb54-1161-407e-c72d-08d8f4dc3b66
x-ms-traffictypediagnostic: OSAPR01MB4962:
x-microsoft-antispam-prvs: <OSAPR01MB49623987245E19AC70367C39F47B9@OSAPR01MB4962.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E7zvv22CR1XJeT8t/47pJkHPs3VN2+YauT6S0vikC56zMp8y7bMIc95wxWAzIKZ/0ODwEMBe5QoHaIVwoLsqStn4RraUVt7GxmrZDTV3iX0wJnzoERYP3bPEVyt1UOFgp2w6zC5HrdTJPG3Prf24G5wRVgXWZ3TRG4orAwSf7G7+I7T6XnbJw7L1jKWOsivnF3exG+7WsjnxcviMl4SNHK3vfEmk8RMBX75ZAVXntKiS6Py7cbyY6FHCeIx5l9IPyz+9KCuLDaKAMP94/ayvb6BqHrAW9sWxoy0sQP3SU04SbX1h7FTHgvrpZKA9F954tjHwU7hTKXbORB0s6xYV+RVc3pc7Mua1m9LGnnCoDCRCL4N4EpDv4hnC4mdjl+VZzWrOMzMV/ubBIHo+shS1yNArBN5bKDaCTFvqBgdAsGjP8GrKHxOPMRn4bo0p75it2UsZMSqNKbitrX/ksSJ3rrQwqFsqUnIOB3GosBl4AzMt4/sMchqIxphcd6j6UCNl2oIUBOOpP/8LekqoRamyY1tYwXpPnY6xZ8OoJWhbfEHe5NWCylW2KeYrocHAs6bdDkgfmAMs/1bHuaODCcoeVkivesOe8rpTj/lA41wRq44Idoo1FAyONJdhhNSNIewd3ONbVPvYoAX499I1Dzo9WwSzR7tNJ7MQgRwV4YE9qfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(26005)(66476007)(186003)(66946007)(2906002)(9686003)(85182001)(4326008)(71200400001)(55016002)(76116006)(8936002)(7416002)(66446008)(8676002)(64756008)(66556008)(6506007)(316002)(6916009)(54906003)(7696005)(478600001)(33656002)(5660300002)(52536014)(53546011)(83380400001)(38100700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aUlyM014UDFnRlg5YitZU3FYWkRPbFNrOU9aV2NXaHViOWJ2Tll5eVA2aGZQ?=
 =?gb2312?B?bGxScXVWMmZ0SnN6djVndzlCamQvOXpNOHU2OFREa0tjbDZvTkRqeFEydzRz?=
 =?gb2312?B?b0ZtUEp6SHZ5aGwrbWl3Nk1jZXN6Um0waHdGWlJiNUczakhaV09ldy9XOXI3?=
 =?gb2312?B?V2tPWmtqUFVuaHdpMlAxWTZjUjRnRWkvbG9PckFKc3VTWmxSbHArSlBOemE5?=
 =?gb2312?B?SERPTjdMYkVOQ0d6NWNDaGpNUEo2d3BIcVlWNmhnbVlhQkFLcGFuZkc4cGJJ?=
 =?gb2312?B?WVF4NjJaR1ZFckVCOS83UlR6S1hHZC9ieHZqVVVvdHRPSy82ODQrK2tzdWk2?=
 =?gb2312?B?MlhOSEJaY1hORk9hYXpmTUxQcXBtVHpmaHlCSC9jRjJadE5HNmJ3V2pVZnJE?=
 =?gb2312?B?SDdVejZ2YTdNMWhpYjg1QmozcWJtZDhad0JGZDh3eDNlT0tXVVRlVmxPYmdR?=
 =?gb2312?B?dzNVOW1veDQ2bmNxVHAyMDRmSkRnRGJYTUoydm5XNE9OUTlaMXFFaGpqdXJm?=
 =?gb2312?B?bkJPRFB0cUlXdERrcmRnd1VEdnFaaXkyU0ZoNUdwenlZdDlxSTNyYVhBTE9q?=
 =?gb2312?B?N2NBbFZvNjFsKzB0Vk55bXhHSlVuU2E0RnhlT0dFVjNMRzZ6eUQ2UHFmdGpE?=
 =?gb2312?B?UG1hMEVqRWliTzZtUzVtTXVFb05CVUNWeXhNbzFnVlJTRlZrRDl0TzhaOW5j?=
 =?gb2312?B?SVkxeGdIWldocXcrMDdhNlMzTEs4TlFHL3NZK290d2JlcmpiMkdKTFZGREh5?=
 =?gb2312?B?dEhWZHFZR3lwZEtyS0ZJWGdDTkl4WDlwUkUxcGJDWFhHeVJOVDRqLzhoVjll?=
 =?gb2312?B?V2tZQ3l3a1A3dk5BS21saWhuY3owaXdZckRqRHJnRVhQSkszdkRsNU5EVFJH?=
 =?gb2312?B?ZkNKdGxKVnRxTWF5dDlmY1VZM2ZJS3hDUS9wOVpVOWFXcDgvdlpLWFVBTmVz?=
 =?gb2312?B?YUo0L1J1T0VXRkdEdEg0SzdjZndHREdOdndHeGk5N0haQUJvdEZaWHo5dWYz?=
 =?gb2312?B?aHZBRkJlSEhiWSs4c2NONlNLSllxdjBVOHAwemhydWVZZDlVeFRwajNKdlA5?=
 =?gb2312?B?dk83K2dsakZBRGVlNFZ1RStGRGE0VmVkLzFVYUpMNjBDR0JEa2hBYnQrSG5C?=
 =?gb2312?B?dDB0bDIrd09oN2N3SDE0UlU5eGlCUzVZSXdjQnRTbXBIZXdndERxVERGN2VE?=
 =?gb2312?B?eHdVVWEyVTY0T0VSTFFORU1La1ZXY0szUjh0N3RPbmNZUmo1RS9HL2dwd1da?=
 =?gb2312?B?WE1aK3NZV3ZKTktBd1AyOVlhUnlYUjZnK0hXdFpkMS9IZHE1V0JsQVlIM0xB?=
 =?gb2312?B?TTZMMFF6WUlWNm16dnZNVVFnYVJMb29ZNHp5bEczOEw2KzFRUy8xRGhIUXBk?=
 =?gb2312?B?eDFHdEFlbXN6S2NMWEFSL2U2dmp4VjMvVHFwL3FtTXd3Ykp2V2JLQnJPM3ZH?=
 =?gb2312?B?a2x3Y3A3dWdsOFQzUG1PZnRRZ3Vua011dEVlQlpabjFTNGNoM0VJMCtXQTFm?=
 =?gb2312?B?bm9IamhPN1Z5dGFXaFhSUGI2QzRqZGY5eVVaN2xyR0lJd0MxdXVIM1JzbWpM?=
 =?gb2312?B?b282UG1UY0d5T1MvMUVtOVNjb0YweW5Ibm9BOC9mY2l1REM4Ym1pNloyTGtj?=
 =?gb2312?B?emllQTBsNDJ3WlV3Sm4zNDd6U0ZHK253NU82ZGYxZ054bDQxMjQrNXNQdnNh?=
 =?gb2312?B?REUwZVNJSU1YdjFVMXR1cVlXYzZqWmhFQ3dPVlpnQ3VyV0RQS1p6ckE4M1VR?=
 =?gb2312?Q?4ouHRV+gGQxfs4pHVtKVTJZXb08JXlgB3P5jejM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62cb54-1161-407e-c72d-08d8f4dc3b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 07:03:19.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3hKtf83gSOC7jYxIJvR/hC6do7QdI0+D+7hw8TwK1xWqAtzUF0DqCTrHSZAoynrqd4MUeGu4EOUjgbjfM3KUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4962
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUml0ZXNoIEhhcmphbmkg
PHJpdGVzaC5saXN0QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDEsIDIwMjEg
Mjo0MCBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA1LzEwXSBmc2RheDogUmVwbGFjZSBt
bWFwIGVudHJ5IGluIGNhc2Ugb2YgQ29XDQo+IA0KPiBPbiAyMS8wMy8xOSAwOTo1MkFNLCBTaGl5
YW5nIFJ1YW4gd3JvdGU6DQo+ID4gV2UgcmVwbGFjZSB0aGUgZXhpc3RpbmcgZW50cnkgdG8gdGhl
IG5ld2x5IGFsbG9jYXRlZCBvbmUgaW4gY2FzZSBvZiBDb1cuDQo+ID4gQWxzbywgd2UgbWFyayB0
aGUgZW50cnkgYXMgUEFHRUNBQ0hFX1RBR19UT1dSSVRFIHNvIHdyaXRlYmFjayBtYXJrcw0KPiA+
IHRoaXMgZW50cnkgYXMgd3JpdGVwcm90ZWN0ZWQuICBUaGlzIGhlbHBzIHVzIHNuYXBzaG90cyBz
byBuZXcgd3JpdGUNCj4gPiBwYWdlZmF1bHRzIGFmdGVyIHNuYXBzaG90cyB0cmlnZ2VyIGEgQ29X
Lg0KPiA+DQo+IA0KPiBQbGVhc2UgY29ycmVjdCBtZSBoZXJlLiBTbyB0aGUgZmxvdyBpcyBsaWtl
IHRoaXMuDQo+IDEuIEluIGNhc2Ugb2YgQ29XIG9yIGEgcmVmbGlua2VkIGZpbGUsIG9uIGFuIG1t
YXBlZCBmaWxlIGlmIHdyaXRlIGlzIGF0dGVtcHRlZCwNCj4gICAgVGhlbiBpbiBEQVggZmF1bHQg
aGFuZGxlciBjb2RlLCAtPmlvbWFwX2JlZ2luKCkgb24gYSBnaXZlbiBmaWxlc3lzdGVtIHdpbGwN
Cj4gICAgcG9wdWxhdGUgaW9tYXAgYW5kIHNyY21hcC4gc3JjbWFwIGJlaW5nIGZyb20gd2hlcmUg
dGhlIHJlYWQgbmVlZHMgdG8gYmUNCj4gICAgYXR0ZW1wdGVkIGZyb20gYW5kIGlvbWFwIG9uIHdo
ZXJlIHRoZSBuZXcgd3JpdGUgc2hvdWxkIGdvIHRvLg0KPiAyLiBTbyB0aGUgZGF4X2luc2VydF9l
bnRyeSgpIGNvZGUgYXMgcGFydCBvZiB0aGUgZmF1bHQgaGFuZGxpbmcgd2lsbCB0YWtlIGNhcmUN
Cj4gICAgb2YgcmVtb3ZpbmcgdGhlIG9sZCBlbnRyeSBhbmQgaW5zZXJ0aW5nIHRoZSBuZXcgcGZu
IGVudHJ5IHRvIHhhcyBhbmQgbWFyaw0KPiAgICBpdCB3aXRoIFBBR0VDQUNIRV9UQUdfVE9XUklU
RSBzbyB0aGF0IGRheCB3cml0ZWJhY2sgY2FuIG1hcmsgdGhlDQo+IGVudHJ5IGFzDQo+ICAgIHdy
aXRlIHByb3RlY3RlZC4NCj4gSXMgbXkgYWJvdmUgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KDQpZ
ZXMsIHlvdSBhcmUgcmlnaHQuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogR29sZHd5biBSb2Ry
aWd1ZXMgPHJnb2xkd3luQHN1c2UuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVh
biA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+IC0tLQ0KPiA+ICBmcy9kYXguYyB8IDM3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2Rh
eC5jIGIvZnMvZGF4LmMNCj4gPiBpbmRleCAxODFhYWQ5NzEzNmEuLmNmZTUxM2ViMTExZSAxMDA2
NDQNCj4gPiAtLS0gYS9mcy9kYXguYw0KPiA+ICsrKyBiL2ZzL2RheC5jDQo+ID4gQEAgLTcyMiw2
ICs3MjIsOSBAQCBzdGF0aWMgaW50IGNvcHlfY293X3BhZ2VfZGF4KHN0cnVjdCBibG9ja19kZXZp
Y2UNCj4gKmJkZXYsIHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZA0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4gIH0NCj4gPg0KPiA+ICsjZGVmaW5lIERBWF9JRl9ESVJUWQkJKDEgPDwgMCkNCj4gPiArI2Rl
ZmluZSBEQVhfSUZfQ09XCQkoMSA8PCAxKQ0KPiA+ICsNCj4gPg0KPiBzbWFsbCBjb21tZW50IGV4
cGFsaW5pbmcgdGhpcyBtZWFucyBEQVggaW5zZXJ0IGZsYWdzIHVzZWQgaW4gZGF4X2luc2VydF9l
bnRyeSgpDQoNCk9LLiAgSSdsbCBhZGQgaXQuDQo+IA0KPiA+DQo+ID4gIC8qDQo+ID4gICAqIEJ5
IHRoaXMgcG9pbnQgZ3JhYl9tYXBwaW5nX2VudHJ5KCkgaGFzIGVuc3VyZWQgdGhhdCB3ZSBoYXZl
IGEgbG9ja2VkDQo+IGVudHJ5DQo+ID4gICAqIG9mIHRoZSBhcHByb3ByaWF0ZSBzaXplIHNvIHdl
IGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQNCj4gPiBkb3duZ3JhZGluZyBQTURzIHRvIEBAIC03
MjksMTYgKzczMiwxOSBAQCBzdGF0aWMgaW50DQo+IGNvcHlfY293X3BhZ2VfZGF4KHN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkZXYsIHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZA0KPiA+ICAgKiBhbHJl
YWR5IGluIHRoZSB0cmVlLCB3ZSB3aWxsIHNraXAgdGhlIGluc2VydGlvbiBhbmQganVzdCBkaXJ0
eSB0aGUgUE1EIGFzDQo+ID4gICAqIGFwcHJvcHJpYXRlLg0KPiA+ICAgKi8NCj4gPiAtc3RhdGlj
IHZvaWQgKmRheF9pbnNlcnRfZW50cnkoc3RydWN0IHhhX3N0YXRlICp4YXMsDQo+ID4gLQkJc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIHN0cnVjdCB2bV9mYXVsdCAqdm1mLA0KPiA+IC0J
CXZvaWQgKmVudHJ5LCBwZm5fdCBwZm4sIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIGJvb2wgZGlydHkp
DQo+ID4gK3N0YXRpYyB2b2lkICpkYXhfaW5zZXJ0X2VudHJ5KHN0cnVjdCB4YV9zdGF0ZSAqeGFz
LCBzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwNCj4gPiArCQl2b2lkICplbnRyeSwgcGZuX3QgcGZuLCB1
bnNpZ25lZCBsb25nIGZsYWdzLA0KPiA+ICsJCXVuc2lnbmVkIGludCBpbnNlcnRfZmxhZ3MpDQo+
ID4gIHsNCj4gPiArCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gdm1mLT52bWEtPnZt
X2ZpbGUtPmZfbWFwcGluZzsNCj4gPiAgCXZvaWQgKm5ld19lbnRyeSA9IGRheF9tYWtlX2VudHJ5
KHBmbiwgZmxhZ3MpOw0KPiA+ICsJYm9vbCBkaXJ0eSA9IGluc2VydF9mbGFncyAmIERBWF9JRl9E
SVJUWTsNCj4gPiArCWJvb2wgY293ID0gaW5zZXJ0X2ZsYWdzICYgREFYX0lGX0NPVzsNCj4gPg0K
PiA+ICAJaWYgKGRpcnR5KQ0KPiA+ICAJCV9fbWFya19pbm9kZV9kaXJ0eShtYXBwaW5nLT5ob3N0
LCBJX0RJUlRZX1BBR0VTKTsNCj4gPg0KPiA+IC0JaWYgKGRheF9pc196ZXJvX2VudHJ5KGVudHJ5
KSAmJiAhKGZsYWdzICYgREFYX1pFUk9fUEFHRSkpIHsNCj4gPiArCWlmIChjb3cgfHwgKGRheF9p
c196ZXJvX2VudHJ5KGVudHJ5KSAmJiAhKGZsYWdzICYgREFYX1pFUk9fUEFHRSkpKSB7DQo+ID4g
IAkJdW5zaWduZWQgbG9uZyBpbmRleCA9IHhhcy0+eGFfaW5kZXg7DQo+ID4gIAkJLyogd2UgYXJl
IHJlcGxhY2luZyBhIHplcm8gcGFnZSB3aXRoIGJsb2NrIG1hcHBpbmcgKi8NCj4gPiAgCQlpZiAo
ZGF4X2lzX3BtZF9lbnRyeShlbnRyeSkpDQo+ID4gQEAgLTc1MCw3ICs3NTYsNyBAQCBzdGF0aWMg
dm9pZCAqZGF4X2luc2VydF9lbnRyeShzdHJ1Y3QgeGFfc3RhdGUNCj4gPiAqeGFzLA0KPiA+DQo+
ID4gIAl4YXNfcmVzZXQoeGFzKTsNCj4gPiAgCXhhc19sb2NrX2lycSh4YXMpOw0KPiA+IC0JaWYg
KGRheF9pc196ZXJvX2VudHJ5KGVudHJ5KSB8fCBkYXhfaXNfZW1wdHlfZW50cnkoZW50cnkpKSB7
DQo+ID4gKwlpZiAoY293IHx8IGRheF9pc196ZXJvX2VudHJ5KGVudHJ5KSB8fCBkYXhfaXNfZW1w
dHlfZW50cnkoZW50cnkpKSB7DQo+ID4gIAkJdm9pZCAqb2xkOw0KPiA+DQo+ID4gIAkJZGF4X2Rp
c2Fzc29jaWF0ZV9lbnRyeShlbnRyeSwgbWFwcGluZywgZmFsc2UpOyBAQCAtNzc0LDYgKzc4MCw5
DQo+IEBADQo+ID4gc3RhdGljIHZvaWQgKmRheF9pbnNlcnRfZW50cnkoc3RydWN0IHhhX3N0YXRl
ICp4YXMsDQo+ID4gIAlpZiAoZGlydHkpDQo+ID4gIAkJeGFzX3NldF9tYXJrKHhhcywgUEFHRUNB
Q0hFX1RBR19ESVJUWSk7DQo+ID4NCj4gPiArCWlmIChjb3cpDQo+ID4gKwkJeGFzX3NldF9tYXJr
KHhhcywgUEFHRUNBQ0hFX1RBR19UT1dSSVRFKTsNCj4gPiArDQo+ID4gIAl4YXNfdW5sb2NrX2ly
cSh4YXMpOw0KPiA+ICAJcmV0dXJuIGVudHJ5Ow0KPiA+ICB9DQo+ID4gQEAgLTEwOTgsOCArMTEw
Nyw3IEBAIHN0YXRpYyB2bV9mYXVsdF90IGRheF9sb2FkX2hvbGUoc3RydWN0IHhhX3N0YXRlDQo+
ICp4YXMsDQo+ID4gIAlwZm5fdCBwZm4gPSBwZm5fdG9fcGZuX3QobXlfemVyb19wZm4odmFkZHIp
KTsNCj4gPiAgCXZtX2ZhdWx0X3QgcmV0Ow0KPiA+DQo+ID4gLQkqZW50cnkgPSBkYXhfaW5zZXJ0
X2VudHJ5KHhhcywgbWFwcGluZywgdm1mLCAqZW50cnksIHBmbiwNCj4gPiAtCQkJREFYX1pFUk9f
UEFHRSwgZmFsc2UpOw0KPiA+ICsJKmVudHJ5ID0gZGF4X2luc2VydF9lbnRyeSh4YXMsIHZtZiwg
KmVudHJ5LCBwZm4sIERBWF9aRVJPX1BBR0UsIDApOw0KPiA+DQo+ID4gIAlyZXQgPSB2bWZfaW5z
ZXJ0X21peGVkKHZtZi0+dm1hLCB2YWRkciwgcGZuKTsNCj4gPiAgCXRyYWNlX2RheF9sb2FkX2hv
bGUoaW5vZGUsIHZtZiwgcmV0KTsgQEAgLTExMjYsOCArMTEzNCw4IEBAIHN0YXRpYw0KPiA+IHZt
X2ZhdWx0X3QgZGF4X3BtZF9sb2FkX2hvbGUoc3RydWN0IHhhX3N0YXRlICp4YXMsIHN0cnVjdCB2
bV9mYXVsdCAqdm1mLA0KPiA+ICAJCWdvdG8gZmFsbGJhY2s7DQo+ID4NCj4gPiAgCXBmbiA9IHBh
Z2VfdG9fcGZuX3QoemVyb19wYWdlKTsNCj4gPiAtCSplbnRyeSA9IGRheF9pbnNlcnRfZW50cnko
eGFzLCBtYXBwaW5nLCB2bWYsICplbnRyeSwgcGZuLA0KPiA+IC0JCQlEQVhfUE1EIHwgREFYX1pF
Uk9fUEFHRSwgZmFsc2UpOw0KPiA+ICsJKmVudHJ5ID0gZGF4X2luc2VydF9lbnRyeSh4YXMsIHZt
ZiwgKmVudHJ5LCBwZm4sDQo+ID4gKwkJCQkgIERBWF9QTUQgfCBEQVhfWkVST19QQUdFLCAwKTsN
Cj4gPg0KPiA+ICAJaWYgKGFyY2hfbmVlZHNfcGd0YWJsZV9kZXBvc2l0KCkpIHsNCj4gPiAgCQlw
Z3RhYmxlID0gcHRlX2FsbG9jX29uZSh2bWEtPnZtX21tKTsgQEAgLTE0MzEsNiArMTQzOSw3IEBA
DQo+IHN0YXRpYw0KPiA+IHZtX2ZhdWx0X3QgZGF4X2ZhdWx0X2FjdG9yKHN0cnVjdCB2bV9mYXVs
dCAqdm1mLCBwZm5fdCAqcGZucCwNCj4gPiAgCWxvZmZfdCBwb3MgPSAobG9mZl90KXhhcy0+eGFf
b2Zmc2V0IDw8IFBBR0VfU0hJRlQ7DQo+ID4gIAlib29sIHdyaXRlID0gdm1mLT5mbGFncyAmIEZB
VUxUX0ZMQUdfV1JJVEU7DQo+ID4gIAlib29sIHN5bmMgPSBkYXhfZmF1bHRfaXNfc3luY2hyb25v
dXMoZmxhZ3MsIHZtZi0+dm1hLCBpb21hcCk7DQo+ID4gKwl1bnNpZ25lZCBpbnQgaW5zZXJ0X2Zs
YWdzID0gMDsNCj4gPiAgCWludCBlcnIgPSAwOw0KPiA+ICAJcGZuX3QgcGZuOw0KPiA+ICAJdm9p
ZCAqa2FkZHI7DQo+ID4gQEAgLTE0NTMsOCArMTQ2MiwxNCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBk
YXhfZmF1bHRfYWN0b3Ioc3RydWN0IHZtX2ZhdWx0DQo+ICp2bWYsIHBmbl90ICpwZm5wLA0KPiA+
ICAJaWYgKGVycikNCj4gPiAgCQlyZXR1cm4gZGF4X2ZhdWx0X3JldHVybihlcnIpOw0KPiA+DQo+
ID4gLQllbnRyeSA9IGRheF9pbnNlcnRfZW50cnkoeGFzLCBtYXBwaW5nLCB2bWYsIGVudHJ5LCBw
Zm4sIDAsDQo+ID4gLQkJCQkgd3JpdGUgJiYgIXN5bmMpOw0KPiA+ICsJaWYgKHdyaXRlKSB7DQo+
ID4gKwkJaWYgKCFzeW5jKQ0KPiA+ICsJCQlpbnNlcnRfZmxhZ3MgfD0gREFYX0lGX0RJUlRZOw0K
PiA+ICsJCWlmIChpb21hcC0+ZmxhZ3MgJiBJT01BUF9GX1NIQVJFRCkNCj4gPiArCQkJaW5zZXJ0
X2ZsYWdzIHw9IERBWF9JRl9DT1c7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZW50cnkgPSBkYXhf
aW5zZXJ0X2VudHJ5KHhhcywgdm1mLCBlbnRyeSwgcGZuLCAwLCBpbnNlcnRfZmxhZ3MpOw0KPiA+
DQo+ID4gIAlpZiAod3JpdGUgJiYgc3JjbWFwLT5hZGRyICE9IGlvbWFwLT5hZGRyKSB7DQo+ID4g
IAkJZXJyID0gZGF4X2lvbWFwX2Nvd19jb3B5KHBvcywgc2l6ZSwgc2l6ZSwgc3JjbWFwLCBrYWRk
ciwgZmFsc2UpOw0KPiA+DQo+IA0KPiBSZXN0IGxvb2tzIGdvb2QgdG8gbWUuIFBsZWFzZSBmZWVs
IGZyZWUgdG8gYWRkDQo+IFJldmlld2VkLWJ5OiBSaXRlc2ggSGFyamFuaSA8cml0ZXNoaEBnbWFp
bC5jb20+DQo+IA0KPiBzb3JyeSBhYm91dCBjaGFuZ2luZyBteSBlbWFpbCBpbiBiZXR3ZWVuIG9m
IHRoaXMgY29kZSByZXZpZXcuDQo+IEkgYW0gcGxhbm5pbmcgdG8gdXNlIGFib3ZlIGdtYWlsIGlk
IGFzIHByaW1hcnkgYWNjb3VudCBmb3IgYWxsIHVwc3RyZWFtIHdvcmsNCj4gZnJvbSBub3cuDQo+
IA0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0KDQo+ID4gLS0NCj4gPiAyLjMwLjENCj4g
Pg0KPiA+DQo+ID4NCg==
