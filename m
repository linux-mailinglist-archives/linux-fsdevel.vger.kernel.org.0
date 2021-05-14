Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070A380737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhENKb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:31:56 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:7885 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhENKbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:31:55 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2021 06:31:53 EDT
IronPort-SDR: R1fMf8jhqqOpMbY3jqXu1WOYsHfdkL2JYhytFmBr3AoEy+s/vAJGXCwjR6VFCYCQAA/4X9elO0
 hhBM+S0PBCMFTVBDgSc1epbG2ztWqiA0iMWI33AK/tlTqWz0hfw5vREVDRBEEPd9AlvyTCMpfL
 QwiyrYwINMjvXyUrQsGfIdRLpPn6MxC/04hpCiiGbzGFS3kJPf922u6F1HR1piyAGgw2R9A35O
 PQ5eTJHe2kqwgABUmeK6db/F2haX+vJfFSVYz+BRiUcxL1qFaNtesPKIdmKMB0/j4v0jjJQ4xL
 V4A=
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="39519665"
X-IronPort-AV: E=Sophos;i="5.82,299,1613401200"; 
   d="scan'208";a="39519665"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 19:23:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpoaHPhYlfx74q7Hk7nJyfH8CcSJ+auSKgdx+ShEZST6SWjd5o9I5vPuespyJX5vD8uc7/SvU2hnwFyynQFGInXLEQrEBAl00CegEant92CykKY6CasUofdo9v5ni4iOolIHhVq3cpyuA8vgYeGR/ZONmws8+7vB+D8+08do10aeWvS+V5xQkxhuKKMIAxeVXjVP8n7rX2wEov+9GpTfcbBnNtu3Zs8qWbYX4TJf78L5zKe/MobBlTdZPA7Nk1CfiHaeOzizP7O9Y/MKtmnA+n+5suoT6hN3VRshG5JCVFDm5FHym3PJWtf86bvVguDkmFzAO63P6iHhaAx5S2ptvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+ZZa3YZL4xrWfotUpfbN14ll99nihE/Lit5CSAXtw=;
 b=eAg4dX1jSbOL2eY6km+E/yllAf/rxsObIYXQs6r5se312/wA+QixQY7hmDeUkvpdrbVNrOmg/yKzxZaZhXzmne/wocwx8/SWg5D9j2SwDRY2p438pyK+mx60NBuNjNY6UYgvaGhsnvKu+cY9lmBOxP7l1vegAngBM0csIZCXcT9pEz9ugSHTZnwJN7cAJjoPYRopdFKE1RIizUmpVrKEziVHjSyQ4sUt2BxKAVutd5DWw7ysAxucjlZfMUzB64BLSKAfl/Rf8nzUvg2i68ZpKzirgP0OROuPDMuGyU/k7Up/m3xlXYU9QoSq+6NFv84tfWolFao2iET5yp8w8GZUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+ZZa3YZL4xrWfotUpfbN14ll99nihE/Lit5CSAXtw=;
 b=aVYf3PH1Fzrneb0inXg867oHcH2GYlVF+P4FKTPiWPy09UQoCbHxzgm3Ne+3SpdQlTaOByZKawn1ca8f9wHEwp1yVNSTkkp9FaUPK7wF39Quh3HAA3jnQmKfPAEMk4zYZQPWVAM858B+AXrncAK+/Mu0z00PffhK4iVR+S+wzeA=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSZPR01MB6294.jpnprd01.prod.outlook.com (2603:1096:604:f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 10:23:26 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Fri, 14 May 2021
 10:23:26 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Topic: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Index: AQHXN325ZvNg0AwKgEyTZt/tgpBu/qrZJMtAgAnCTLA=
Date:   Fri, 14 May 2021 10:23:25 +0000
Message-ID: <OSBPR01MB29201A0E8100416023E77F80F4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB29205D645B33F4721E890660F4569@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29205D645B33F4721E890660F4569@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bad9181-ad08-4088-c6c6-08d916c24f71
x-ms-traffictypediagnostic: OSZPR01MB6294:
x-microsoft-antispam-prvs: <OSZPR01MB62944BB511F14C5C335D8CB6F4509@OSZPR01MB6294.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9n6yP7FfRIIJ53ssiwZ2vV2SO51hsr/im/6uC422vl34HRtU5aOmP6CAXXL0xEG293bJDIGx6lbne3Qq/QlSXcgRTomrke+7rzrHUmFRh4cmghGZPoxfKdAznOpyHE3PK8AduqAmKM0sJkEmsEIpFTh5qPCzjdcNvUm26ADsDNOMN9eqiVQudZAp0+1GffgmRtraiefzhuk2bvERUo/jRscEnPnopUBL7KQk9J0trvxoohsRVC8hkP7ryOrU1KfgPivq58ZW+GksQZli4AxaT7ca2ls0/BGmylhhZ/M4F0yiiF+UKTk97B4FJTL8uEEJYIXAoXiooOOxc2iSR2Oy2iHVjzSIM8pVBhjxdsQt0GRbk/qt3m7gu+dlRSMF/EfO4CLgQZ7uoESKp/U1k6pT1dkHQGEwXIgjrz7M28cRZr2l+8tO7cJ18+dwgzETK4uWsVs77zfRrMjDbSP3ZbeDuv81oaG5+Zv1ARNTJyFMBiHtgJxDQHkImJzm2K+DMg1ognrYAp5V8AzTLjkEktkUmX2nZLcAsX27e39WxUpoRTh4dUnwoEduSW0M/EjG3XjSqc79UeFYKNbgFFzH4KTcNlebu4xkZAViDOsXnIRPxeqJpBNpsBeG3cLEphy13yVPwt31O5huTfoSG8F8VgdWJPGuDeMWcNB5db+FI3xp6XmBTuBtYwdHturpZEq7ilz5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(33656002)(83380400001)(66946007)(66476007)(66556008)(7416002)(76116006)(55016002)(478600001)(5660300002)(54906003)(9686003)(53546011)(26005)(66446008)(6506007)(64756008)(966005)(71200400001)(7696005)(86362001)(186003)(122000001)(6916009)(2906002)(8936002)(52536014)(85182001)(38100700002)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?V3k3UFhWakZuKzl4WS85SWlCOE5Vb2RXYXVsbDIyZXJlQy9oSzY5TWdjOVRk?=
 =?gb2312?B?MDFWNTMyVGJFMUgyYzNWenBnOGdrN1pCd240K2FmR3BCRXV6aytKYkcwdWZW?=
 =?gb2312?B?dTQ2U2w5STBubEk3M1ZGVEl6cE1WZUdSelg1YnptWngzcG0xQTN0RFdpWnlC?=
 =?gb2312?B?TG96Z2xmNFFXNFZvV3ZRWGxzbzNKRkl1L3JZQ09tLzFjTUtXeXpxKzJFOEZ3?=
 =?gb2312?B?K2QrbGczRWV0V1dpR1ljRkhkTmZQWHhIMGFIKzBqbmNnMTN6WHlpZ3VPMitX?=
 =?gb2312?B?cnpTVXRCaFFkQUVpbXNoT0hpNzdRaWtwQTdQUXlCWTFuUlQ1eDgzOFRYY3JR?=
 =?gb2312?B?THNTVGY2VG1KNnFtSVhFQW51a2JDbEZ4YkNYR1FodC9BOVY5TUxwdndZRWth?=
 =?gb2312?B?MUdrTSs3QVEwQmxURjZscU81SGJyK2YzSTBGQmhkaXAwdHo0NytKczc3VWJB?=
 =?gb2312?B?WkRxQnUzYjFMZEVwaDRFSUtsSzhHZnI4TDA5amdIdVNKWkNjMENZYUZSZXVT?=
 =?gb2312?B?d1MvcmRzYU42N2ZLNWlwdjVnYzJwRERiQWYxUzZRdWJORStVbEt3VUNaclNP?=
 =?gb2312?B?U2xzUGx2dFdLK1Vaak5lM2RUZWNCMmtjUDdqMy9xRkpoZmh2TlEwbHROQXg0?=
 =?gb2312?B?dXlqeTdXOCtVdVkzcU8wRGNaVnh6U0VueEovY3JaRmREbUgxdXdCZWZrQkk0?=
 =?gb2312?B?V25pY0tZSjlVUU5GamJicUR3QUxTTWFFaGVkcktTdnh5cFFMUFEyVW0zbWZY?=
 =?gb2312?B?RHA0dUVWQ0J4azQwUTU1bFZNVTlzWjducXVCbnpNeUhmVW44bmQwUXdXc0xL?=
 =?gb2312?B?dWY4ZzEzTS81T2pmaDk5SUlpUmo3d2JDODJRcnZQN1kxVERnV3Y4blh4WWlk?=
 =?gb2312?B?dFpINEVqSjFJRTRaZ08zWEh5TmxHQ3AyZXg3bWEzaVloL1Z1R3d0bmxoTWJR?=
 =?gb2312?B?bnM1YWtadVJ5U0toSElIaUhraGV1NnVUNUM4alU1Nm40Ynk3RTlSQVI2QktO?=
 =?gb2312?B?SU83MlI0N1RNekoxWXNjZWdCRGp1QTBiU2I3a1VWZWx0TnY3alFXa1VOa1Rs?=
 =?gb2312?B?VnNSM3lyd0lxOU8yMjVWemRxcmJsSFo1L0phNkRJaDdOMXA1UmV5VWtza2F2?=
 =?gb2312?B?aGtXSGhjVXBiTXZTYXMzVXFYS0dFWVV2OWtGM2trcGs2N0hPZkU0ZmJmM25B?=
 =?gb2312?B?Z25ROVBpWHZ2V3EvMDJoM3NTV3NuWGRzL0dTdnNVb2VaSWJVNEc1S2E4TUdi?=
 =?gb2312?B?eE40bTkzZk9ZYUdqeU9iVHBGanhsUlVzM1hQeWtMeDc2VUJrUkd3b3IyNUJa?=
 =?gb2312?B?ejVOZUc0ZzE3TGd6cE84VWE2eG1uR0NYMGwxOW51UGJSaWI4TWpKZzFqWUhH?=
 =?gb2312?B?TndaZXFKQUYrSVl1dVdxUElIeWpMZmhFN0JaNlRmRmR4OU10VXpVWUlQMlZl?=
 =?gb2312?B?SzZjR2EyQ1lJL3BldGZkVnpoYk85cmQrTzhKbGc1TWJtb2VVUGk3eUJvM2RY?=
 =?gb2312?B?eXpYNjhNb2J5VUNyRlU0WnRTQ2E1cTFLdTNZZ1hPeXFtZnQvMHRnaHJKc1Jp?=
 =?gb2312?B?RllCV29RRUsrTGhZbGZKSjRmT0FyRFB6VTF1c2NrMnVJMVB1U3RqRTFFc3dS?=
 =?gb2312?B?M0IrOEkvTW1vZFVWTU5QWnVvNVZqS3h0R0Y5Nmppc1docHJQOTF1a2VnVUky?=
 =?gb2312?B?Y05oMWxUd0Y2RzRJSmpCc0gzU3JnKzFTUldmRkh3ZkNWRkxkWWxKbGkwZlkx?=
 =?gb2312?Q?pvvKncLhC17ho6EyTIdmfZITi87i42c2DsDDhap?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bad9181-ad08-4088-c6c6-08d916c24f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 10:23:26.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGDhqjFzPvhZxyx7tDWWHyRvfiIIw9wwWABreYdFRqAv9IAuK/CETT8T5mWrxssSjIwY1/JVAZrJ8brbDKJTMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6294
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiANCj4gSGksIERhbg0KPiANCj4gRG8geW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoaXM/DQoN
ClBpbmcNCg0KPiANCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gUnVhbiBTaGl5YW5nLg0KPiANCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFNoaXlhbmcgUnVhbiA8cnVh
bnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIyLCAyMDIx
IDk6NDUgUE0NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMC8zXSBmc2RheDogRmFjdG9yIGhlbHBl
ciBmdW5jdGlvbnMgdG8gc2ltcGxpZnkgdGhlDQo+ID4gY29kZQ0KPiA+DQo+ID4gRnJvbTogU2hp
eWFuZyBSdWFuIDxydWFuc3kuZm5zdEBjbi5mdWppdHN1LmNvbT4NCj4gPg0KPiA+IFRoZSBwYWdl
IGZhdWx0IHBhcnQgb2YgZnNkYXggY29kZSBpcyBsaXR0bGUgY29tcGxleC4gSW4gb3JkZXIgdG8g
YWRkDQo+ID4gQ29XIGZlYXR1cmUgYW5kIG1ha2UgaXQgZWFzeSB0byB1bmRlcnN0YW5kLCBJIHdh
cyBzdWdnZXN0ZWQgdG8gZmFjdG9yDQo+ID4gc29tZSBoZWxwZXIgZnVuY3Rpb25zIHRvIHNpbXBs
aWZ5IHRoZSBjdXJyZW50IGRheCBjb2RlLg0KPiA+DQo+ID4gVGhpcyBpcyBzZXBhcmF0ZWQgZnJv
bSB0aGUgcHJldmlvdXMgcGF0Y2hzZXQgY2FsbGVkICJWMyBmc2RheCx4ZnM6IEFkZA0KPiA+IHJl
ZmxpbmsmZGVkdXBlIHN1cHBvcnQgZm9yIGZzZGF4IiwgYW5kIHRoZSBwcmV2aW91cyBjb21tZW50
cyBhcmUgaGVyZVsxXS4NCj4gPg0KPiA+IFsxXToNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbnZkaW1tL3BhdGNoLzIwMjEwMzE5MDE1MjM3DQo+ID4gLjk5
DQo+ID4gMzg4MC0zLXJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tLw0KPiA+DQo+ID4gQ2hhbmdlcyBm
cm9tIFYyOg0KPiA+ICAtIGZpeCB0aGUgdHlwZSBvZiAnbWFqb3InIGluIHBhdGNoIDINCj4gPiAg
LSBSZWJhc2VkIG9uIHY1LjEyLXJjOA0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9tIFYxOg0KPiA+ICAt
IGZpeCBSaXRlc2gncyBlbWFpbCBhZGRyZXNzDQo+ID4gIC0gc2ltcGxpZnkgcmV0dXJuIGxvZ2lj
IGluIGRheF9mYXVsdF9jb3dfcGFnZSgpDQo+ID4NCj4gPiAoUmViYXNlZCBvbiB2NS4xMi1yYzgp
DQo+ID4gPT0NCj4gPg0KPiA+IFNoaXlhbmcgUnVhbiAoMyk6DQo+ID4gICBmc2RheDogRmFjdG9y
IGhlbHBlcnMgdG8gc2ltcGxpZnkgZGF4IGZhdWx0IGNvZGUNCj4gPiAgIGZzZGF4OiBGYWN0b3Ig
aGVscGVyOiBkYXhfZmF1bHRfYWN0b3IoKQ0KPiA+ICAgZnNkYXg6IE91dHB1dCBhZGRyZXNzIGlu
IGRheF9pb21hcF9wZm4oKSBhbmQgcmVuYW1lIGl0DQo+ID4NCj4gPiAgZnMvZGF4LmMgfCA0NDMN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMzQgaW5zZXJ0aW9ucygrKSwgMjA5IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjMxLjENCj4gDQo+IA0KDQo=
