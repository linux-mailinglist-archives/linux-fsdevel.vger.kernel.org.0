Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5693EFE3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhHRHwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 03:52:50 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:31957 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237962AbhHRHws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629273135; x=1660809135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PGR6CB6ZNYnGacwIWhKZ73aFX1wKUb9dMDervZ1ElcM=;
  b=wPjwr/tOYd7mwvUc76BegkzLI7+LsU1RlppGeDELQ6id5AWyswwlx9Rt
   vTsQyIU0KNpaCpoRjzcO/YTdka3XC+I6VBJNqmTA/aLOpTXcr6szZkOSj
   p88y03VwJ9AsD4IhvQZoGgt2iLcAm8BiTGd8B1K+dECCrF3HrXVA3mJ9W
   /ObrfaDBv13YavYL5OsrgAU2UAPDhW8f/XOJJiit5uuGxpWI6as9JTZto
   i9d5RtmjUgdtirSVhn56herbydLrdPnP+X0UbNWp4C6wOVYqgqfqWcKmC
   hY4uybwp2oMpED2uzpr+iBMuR82AESAiO8FQ3n0P+fbRDE/8j5LNBhx6A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="36840440"
X-IronPort-AV: E=Sophos;i="5.84,330,1620658800"; 
   d="scan'208";a="36840440"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 16:52:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCeWowJdBC5sPu5dz76p7ammzfiYY/2HMv/xNVB8AmoyMk1KreiYzVaEg5lMbgPpihpj8cc41Fsxk0nPVGN2XDoceRLdNpAyr4futZibmaGhf3fInzI2hReaSNdUfJTWTXzchzRdPVt3ZRyRLWeTfvIlcPvv7tC4tqYcd2STynR+g8sAQsqvHH7gb41NDUcsCC3B2OXkToUh3mntVeVv1U9K8nKJFQWZzk715etFrmvWvQcI+NPm6l419kPsuMdPnKn4cnfy6oGDNHKxR4qtyRaLso9VXc499qwOvDKNz6fQm/b3Uq0zI7858MSx+2MrT+bpQz+DJUw/F6SaqilrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGR6CB6ZNYnGacwIWhKZ73aFX1wKUb9dMDervZ1ElcM=;
 b=UNVeeW7tpNvBIm/BVinSLsxHZGesXJX/7WnPbKsLzorlgIvNZusLhHyKXDAefL6t3sz8nN1BubiO8/K0gvXmMH2xHfBJXM9UZT7E4/CZV9+ZB8E1EFYX0Utm+gQpHKd7llmzEzCcowU3OlnoEolQxIl2gWc2IdKJChDwdn/MeKzkS7wXFYFZdIBekbWLsqs2tY9/ZjThlniwGXIwI3CyWL7YJxRcK9YvVJatIY8LRP82suCpcT23JH4LxcTN5JlrqZOsgI+XYF12l9cbHBimkyavMPqDE3VKOIwOSLQ4oLsZSWCQi1dI50LMn0ZNEUIehhoAsdms4B8lA4UmNdp0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGR6CB6ZNYnGacwIWhKZ73aFX1wKUb9dMDervZ1ElcM=;
 b=HBDieYFTg8G6sCPDLKxITZQyybFnuH0TIr20D+i3dp9mZPe9EJHg16Tu11uuVHyOt4OnJENcha49eh/aBGapJe8UAxNEB8t3VSY3JTToNLbPd/tBo4bFUzLrDdY469he4DeTJzMobgjRZuItDpQzkHxBIFE5WOx39TKTo+eP8Zs=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB2440.jpnprd01.prod.outlook.com (2603:1096:604:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 07:52:01 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb%6]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:52:01 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: RE: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Index: AQHXhSoSnS/qStIblEyff+FzJU/rBqtlt1aAgBDEPoCAAmInAIAABusAgAAV9MA=
Date:   Wed, 18 Aug 2021 07:52:01 +0000
Message-ID: <OSBPR01MB2920AD0C7FD02E238D0C387AF4FF9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
In-Reply-To: <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2d6932f-759b-402a-27a1-08d9621d1012
x-ms-traffictypediagnostic: OSBPR01MB2440:
x-microsoft-antispam-prvs: <OSBPR01MB24408F37010CA07023F9080BF4FF9@OSBPR01MB2440.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jeu27v+L1+azmocnchPNcGK75Qm52Xx2HtpoIOau6mI3iAhe8ox8S4z/af9Mg1CxMrDj+97xyDKzRSVBWdCZD18DU38Gr5vQ119ATUI4CHDcQWLrJdzN54WFQEP4IfHh75xsakCcppNKoyfrY7/RL1vPVsO0nnJ1m6CNAo5dPtpGcR+vtA2EJBUnG/Q75AGin5SgTje1YxfS4LXAeDAO17Bhavg4wG7rgDrfMZu7FpaE+fj69u/poAum1oKkLpKeEfZ6SPVLUH16UmYr4brO8Ag2xhSWQuQH+hNMapZ/7mcQFLWq7tEGIp32JTweOBIVIHnTISjgXE2zytCwFVpesCt+uALX2XVmR1nyTJBR61DOnadbgQjccD1vGeZlpCHaD6Y0gKb8NcVgccaPR66BHJg3HWYiERw9axFPkHX5CyaTkCEmhobIPa6c6yeregBU0AqAGrWLVmU64gjkRSC3HBBymdRWTmPpRrC7yaoV0bpZLhwvt874yVfAZJkfJw74MkARADPBgfEhl485bJwWS+9e2WzpTLJmoNUm6QTKq3EnQquA7ttPItK3eP9GLIvl0U/HncjQV08ulQioVcFPIEu8eNYQsYiEw2VBKe+PY6dCjs9aQCXpU4b1Bm7dIvapvC/dCyJdJ9Ac+Hj/HhYwXyQEIcdDV71f8A+FI5GwQrRbzHku8Ma/7vaYbj1DVlk00sKDauugRmTCOeek1JOkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(55016002)(83380400001)(85182001)(86362001)(76116006)(66946007)(122000001)(9686003)(66556008)(4326008)(2906002)(186003)(7416002)(52536014)(64756008)(66476007)(66446008)(54906003)(7696005)(508600001)(26005)(8936002)(8676002)(33656002)(6506007)(53546011)(71200400001)(5660300002)(316002)(110136005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3dNbkxvUXpweHJoRXFsclUvazFER1hDdFFoRks3MjlBY2lDSXF3U3JJZjV6?=
 =?utf-8?B?TzI4ejdoaFhMOUxwNlE2eThib2tYcWNwZUlNUXFMTHRIbVlxT05oVnhoTFRY?=
 =?utf-8?B?dFJPaitFU3JsOTdYaW9pRkhDdFdTcW9FMWNhUVo2K0xodXRTWE8zWEt4a1Bw?=
 =?utf-8?B?NXRIWE5CQjRXaGNZRHFvVU1YUzhMcjc4Z25rK0JSTUF2UjJNb0Q2b3JYSmxI?=
 =?utf-8?B?SXVIMjRCTk1MSkpKQllUVS9mUjNtMlQ1bmd2N1FLWlphdmt1U0h4RklabUpE?=
 =?utf-8?B?UVZCMnlyR2czMzI4a2Yya0JyZ1YrYk1IWDFBZTZLY3MyT2xUMXNCWlFvOFJj?=
 =?utf-8?B?eWdLV0k4ZkZIdkl5dDBuR3pnSVg5NDg2cStEd0tmV3c4WVR0eGc0MUoyRjBk?=
 =?utf-8?B?U3FTdkdtbTVJekczYmNLbnU0enNFd3QvZEtqSkVJS1lZQkV1UXF2TlNXdlpG?=
 =?utf-8?B?MFFEQTkycVVHMTMySDQyYS9EWCt0T0VIRXYzNmdSemJKRnhTL3lDZm1HRDBT?=
 =?utf-8?B?ZEF4TjlwL01jajE1QXU5UWJrMW9hZXBuK3RmVmZtOFdXQ0JvK3JmYzlDZisz?=
 =?utf-8?B?WnNWVCs0RnJCZkZDMGhHQUpvVnAzSXVUSkhHL1NOVG51OUV2cHUzR2gzOUxD?=
 =?utf-8?B?dkJtamUrQkJSN0plWEFGTnRxbDRhTU8ybzdEYklFNWxhUGZRS0RjMkFpclQv?=
 =?utf-8?B?MVdrR0F1cVVjWUFTTHRnVm16RlM0eVlOVmZVNzFuVnlEZTdtL1Bqb1UrNmxW?=
 =?utf-8?B?MFlTVGRGcW01ZVFHWWZyR1VKdFhYSEIwaGZrUEFxYkw5Q1lZY2NUZTNXRU51?=
 =?utf-8?B?QVptZUIweU5kaDZXL1ltbzJwNDVUNUI3TUZDbjFSRXRORjZ4N2VDZVZuWnBF?=
 =?utf-8?B?UGFyd1BrUGVrR2hzcXZoMjFZcWlUTDhIWHVyMEJYQUthcENKUU8reEdBRDFj?=
 =?utf-8?B?MGhvSThDMURhWGh4Z0ZXdWxtYkZUYzBKc0RGNlRJR0YwbnJVMDRwcFpYQXpE?=
 =?utf-8?B?SVF2V1owY050d0ZVWGR5eHJzR3FTbVgwU1liZzI4WjdvcFgzSzB5MmxvdTJz?=
 =?utf-8?B?NmZwS0tWVWZySzVvNW0vYjBYSmN1QnpqTE1oZWJXaDhoaHhZc3dSMU1pL1A4?=
 =?utf-8?B?QU41dUNaNytZaDBLYm9HRGtSUHkyazlVNlhPUW4zbE5oM0VUMEhGN0hmd2ZW?=
 =?utf-8?B?ZGJTcVE1ajRNV2VXNCszZTJ3cVFZSVJMNTVuQVpwZmphQkhJd0ZlRmFTS3dk?=
 =?utf-8?B?elJYd1hqMXBvVnJHNVdsN2xUQ0U2OEZFazc0RytCM2htNmFNb2JxdWRXUllP?=
 =?utf-8?B?bzNPRWZPTHdKcVV4TWZmeXBEKzVtRTJoRlJtL0FRdDNGMFhzZ1h1UnhJbW5z?=
 =?utf-8?B?My9oUEVBNUlsS3pjYkE5RnZsbDZ0cVBONjVDZW9ZUkF6WGMrSm1CQ3NKUnY4?=
 =?utf-8?B?QXN0SlVLSFFaM204L1lQYUdLRUxQeGxCYW4zWGMxZ0hlMlJvL1NzNnJpNHlw?=
 =?utf-8?B?aTkxYTA0S3QrTG5USitiSmRydUxnSmZZcUpPckxlZHUxSVpLYXQxTmc0STc4?=
 =?utf-8?B?R2hwWlRqNVVUc0JaYkhyTTNEeGJ5ZlFTRUFiVDZBZUo4NFRQaXpWVG1LbUxK?=
 =?utf-8?B?SFkra2hyQ0VXVWx4MVlmM1NoYjRHNmJHWnlwd0pGZFRwNHJZZ3M2ZS94Y0dO?=
 =?utf-8?B?bk1wdDJmL284RmlQc1h1eU9za1BDazFPZHVhbkE2R2sxd01UQXhQcDhxdk9M?=
 =?utf-8?Q?Gle6mgo2hgKD/8sjdPWVM8rzE3Q1EH3CW7/qFfd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6932f-759b-402a-27a1-08d9621d1012
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:52:01.2105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seWqVN6YtlIgfrCNeO5V1QrPyhM6HKt0tiPVVsybjf10CKdLfgG7ba5qWfKV5eyj1/L3PHogW8EY4EzOEWrCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2440
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuZSBDaHUgPGphbmUu
Y2h1QG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIHY2IDEvOV0gcGFn
ZW1hcDogSW50cm9kdWNlIC0+bWVtb3J5X2ZhaWx1cmUoKQ0KPiANCj4gDQo+IE9uIDgvMTcvMjAy
MSAxMDo0MyBQTSwgSmFuZSBDaHUgd3JvdGU6DQo+ID4gTW9yZSBpbmZvcm1hdGlvbiAtDQo+ID4N
Cj4gPiBPbiA4LzE2LzIwMjEgMTA6MjAgQU0sIEphbmUgQ2h1IHdyb3RlOg0KPiA+PiBIaSwgU2hp
WWFuZywNCj4gPj4NCj4gPj4gU28gSSBhcHBsaWVkIHRoZSB2NiBwYXRjaCBzZXJpZXMgdG8gbXkg
NS4xNC1yYzMgYXMgaXQncyB3aGF0IHlvdQ0KPiA+PiBpbmRpY2F0ZWQgaXMgd2hhdCB2NiB3YXMg
YmFzZWQgYXQsIGFuZCBpbmplY3RlZCBhIGhhcmR3YXJlIHBvaXNvbi4NCj4gPj4NCj4gPj4gSSdt
IHNlZWluZyB0aGUgc2FtZSBwcm9ibGVtIHRoYXQgd2FzIHJlcG9ydGVkIGEgd2hpbGUgYWdvIGFm
dGVyIHRoZQ0KPiA+PiBwb2lzb24gd2FzIGNvbnN1bWVkIC0gaW4gdGhlIFNJR0JVUyBwYXlsb2Fk
LCB0aGUgc2lfYWRkciBpcyBtaXNzaW5nOg0KPiA+Pg0KPiA+PiAqKiBTSUdCVVMoNyk6IGNhbmpt
cD0xLCB3aGljaHN0ZXA9MCwgKioNCj4gPj4gKiogc2lfYWRkcigweChuaWwpKSwgc2lfbHNiKDB4
QyksIHNpX2NvZGUoMHg0LCBCVVNfTUNFRVJSX0FSKSAqKg0KPiA+Pg0KPiA+PiBUaGUgc2lfYWRk
ciBvdWdodCB0byBiZSAweDdmNjU2ODAwMDAwMCAtIHRoZSB2YWRkciBvZiB0aGUgZmlyc3QgcGFn
ZQ0KPiA+PiBpbiB0aGlzIGNhc2UuDQo+ID4NCj4gPiBUaGUgZmFpbHVyZSBjYW1lIGZyb20gaGVy
ZSA6DQo+ID4NCj4gPiBbUEFUQ0ggUkVTRU5EIHY2IDYvOV0geGZzOiBJbXBsZW1lbnQgLT5ub3Rp
ZnlfZmFpbHVyZSgpIGZvciBYRlMNCj4gPg0KPiA+ICtzdGF0aWMgaW50DQo+ID4gK3hmc19kYXhf
bm90aWZ5X2ZhaWx1cmUoDQo+ID4gLi4uDQo+ID4gK8KgwqDCoCBpZiAoIXhmc19zYl92ZXJzaW9u
X2hhc3JtYXBidCgmbXAtPm1fc2IpKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHhmc193YXJuKG1w
LCAibm90aWZ5X2ZhaWx1cmUoKSBuZWVkcyBybWFwYnQgZW5hYmxlZCEiKTsNCj4gPiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICvCoMKgwqAgfQ0KPiA+DQo+ID4gSSBh
bSBub3QgZmFtaWxpYXIgd2l0aCBYRlMsIGJ1dCBJIGhhdmUgYSBmZXcgcXVlc3Rpb25zIEkgaG9w
ZSB0byBnZXQNCj4gPiBhbnN3ZXJzIC0NCj4gPg0KPiA+IDEpIFdoYXQgZG9lcyBpdCB0YWtlIGFu
ZCBjb3N0IHRvIG1ha2UNCj4gPiAgwqDCoCB4ZnNfc2JfdmVyc2lvbl9oYXNybWFwYnQoJm1wLT5t
X3NiKSB0byByZXR1cm4gdHJ1ZT8NCg0KRW5hYmxlIHJtcGFidCBmZWF0dXJlIHdoZW4gbWFraW5n
IHhmcyBmaWxlc3lzdGVtDQogICBgbWtmcy54ZnMgLW0gcm1hcGJ0PTEgL3BhdGgvdG8vZGV2aWNl
YA0KQlRXLCByZWZsaW5rIGlzIGVuYWJsZWQgYnkgZGVmYXVsdC4NCg0KPiA+DQo+ID4gMikgRm9y
IGEgcnVubmluZyBlbnZpcm9ubWVudCB0aGF0IGZhaWxzIHRoZSBhYm92ZSBjaGVjaywgaXMgaXQN
Cj4gPiAgwqDCoCBva2F5IHRvIGxlYXZlIHRoZSBwb2lzb24gaGFuZGxlIGluIGxpbWJvIGFuZCB3
aHk/DQpJdCB3aWxsIGZhbGwgYmFjayB0byB0aGUgb2xkIGhhbmRsZXIuICBJIHRoaW5rIHlvdSBo
YXZlIGFscmVhZHkga25vd24gaXQuDQoNCj4gPg0KPiA+IDMpIElmIHRoZSBhYm92ZSByZWdyZXNz
aW9uIGlzIG5vdCBhY2NlcHRhYmxlLCBhbnkgcG90ZW50aWFsIHJlbWVkeT8NCj4gDQo+IEhvdyBh
Ym91dCBtb3ZpbmcgdGhlIGNoZWNrIHRvIHByaW9yIHRvIHRoZSBub3RpZmllciByZWdpc3RyYXRp
b24/DQo+IEFuZCByZWdpc3RlciBvbmx5IGlmIHRoZSBjaGVjayBpcyBwYXNzZWQ/ICBUaGlzIHNl
ZW1zIGJldHRlciB0aGFuIGFuDQo+IGFsdGVybmF0aXZlIHdoaWNoIGlzIHRvIGZhbGwgYmFjayB0
byB0aGUgbGVnYWN5IG1lbW9yeV9mYWlsdXJlIGhhbmRsaW5nIGluIGNhc2UNCj4gdGhlIGZpbGVz
eXN0ZW0gcmV0dXJucyAtRU9QTk9UU1VQUC4NCg0KU291bmRzIGxpa2UgYSBuaWNlIHNvbHV0aW9u
LiAgSSB0aGluayBJIGNhbiBhZGQgYW4gaXNfbm90aWZ5X3N1cHBvcnRlZCgpIGludGVyZmFjZSBp
biBkYXhfaG9sZGVyX29wcyBhbmQgY2hlY2sgaXQgd2hlbiByZWdpc3RlciBkYXhfaG9sZGVyLg0K
DQotLQ0KVGhhbmtzLA0KUnVhbi4NCj4gDQo+IHRoYW5rcywNCj4gLWphbmUNCj4gDQo+ID4NCj4g
PiB0aGFua3MhDQo+ID4gLWphbmUNCj4gPg0KPiA+DQo+ID4+DQo+ID4+IFNvbWV0aGluZyBpcyBu
b3QgcmlnaHQuLi4NCj4gPj4NCj4gPj4gdGhhbmtzLA0KPiA+PiAtamFuZQ0KPiA+Pg0KPiA+Pg0K
PiA+PiBPbiA4LzUvMjAyMSA2OjE3IFBNLCBKYW5lIENodSB3cm90ZToNCj4gPj4+IFRoZSBmaWxl
c3lzdGVtIHBhcnQgb2YgdGhlIHBtZW0gZmFpbHVyZSBoYW5kbGluZyBpcyBhdCBtaW5pbXVtIGJ1
aWx0DQo+ID4+PiBvbiBQQUdFX1NJWkUgZ3JhbnVsYXJpdHkgLSBhbiBpbmhlcml0YW5jZSBmcm9t
IGdlbmVyYWwNCj4gPj4+IG1lbW9yeV9mYWlsdXJlIGhhbmRsaW5nLsKgIEhvd2V2ZXIsIHdpdGgg
SW50ZWwncyBEQ1BNRU0gdGVjaG5vbG9neSwNCj4gPj4+IHRoZSBlcnJvciBibGFzdCByYWRpdXMg
aXMgbm8gbW9yZSB0aGFuIDI1NmJ5dGVzLCBhbmQgbWlnaHQgZ2V0DQo+ID4+PiBzbWFsbGVyIHdp
dGggZnV0dXJlIGhhcmR3YXJlIGdlbmVyYXRpb24sIGFsc28gYWR2YW5jZWQgYXRvbWljIDY0QiB3
cml0ZQ0KPiB0byBjbGVhciB0aGUgcG9pc29uLg0KPiA+Pj4gQnV0IEkgZG9uJ3Qgc2VlIGFueSBv
ZiB0aGF0IGNvdWxkIGJlIGluY29ycG9yYXRlZCBpbiwgZ2l2ZW4gdGhhdCB0aGUNCj4gPj4+IGZp
bGVzeXN0ZW0gaXMgbm90aWZpZWQgYSBjb3JydXB0aW9uIHdpdGggcGZuLCByYXRoZXIgdGhhbiBh
biBleGFjdA0KPiA+Pj4gYWRkcmVzcy4NCj4gPj4+DQo+ID4+PiBTbyBJIGd1ZXNzIHRoaXMgcXVl
c3Rpb24gaXMgYWxzbyBmb3IgRGFuOiBob3cgdG8gYXZvaWQgdW5uZWNlc3NhcmlseQ0KPiA+Pj4g
cmVwYWlyaW5nIGEgUE1EIHJhbmdlIGZvciBhIDI1NkIgY29ycnVwdCByYW5nZSBnb2luZyBmb3J3
YXJkPw0KPiA+Pj4NCj4gPj4+IHRoYW5rcywNCj4gPj4+IC1qYW5lDQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4+IE9uIDcvMzAvMjAyMSAzOjAxIEFNLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4+Pj4gV2hl
biBtZW1vcnktZmFpbHVyZSBvY2N1cnMsIHdlIGNhbGwgdGhpcyBmdW5jdGlvbiB3aGljaCBpcw0K
PiA+Pj4+IGltcGxlbWVudGVkIGJ5IGVhY2gga2luZCBvZiBkZXZpY2VzLsKgIEZvciB0aGUgZnNk
YXggY2FzZSwgcG1lbQ0KPiA+Pj4+IGRldmljZSBkcml2ZXIgaW1wbGVtZW50cyBpdC7CoCBQbWVt
IGRldmljZSBkcml2ZXIgd2lsbCBmaW5kIG91dCB0aGUNCj4gPj4+PiBmaWxlc3lzdGVtIGluIHdo
aWNoIHRoZSBjb3JydXB0ZWQgcGFnZSBsb2NhdGVkIGluLsKgIEFuZCBmaW5hbGx5DQo+ID4+Pj4g
Y2FsbCBmaWxlc3lzdGVtIGhhbmRsZXIgdG8gZGVhbCB3aXRoIHRoaXMgZXJyb3IuDQo+ID4+Pj4N
Cj4gPj4+PiBUaGUgZmlsZXN5c3RlbSB3aWxsIHRyeSB0byByZWNvdmVyIHRoZSBjb3JydXB0ZWQg
ZGF0YSBpZiBuZWNlc3NhcnkuDQo+ID4+Pg0KPiA+Pg0KPiA+DQo=
