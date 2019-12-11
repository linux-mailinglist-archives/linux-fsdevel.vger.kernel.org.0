Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC111BF96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 23:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLKWGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 17:06:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLKWGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:06:22 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBM5Rr1013437;
        Wed, 11 Dec 2019 14:06:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M6pslR/+vLwja6+RwmvYPhjJgTwGnGvoPmF0G2EN5A0=;
 b=qJ6Ab9SNA+NXQKZpoYn6+ZZdnC451w8pzYQ+54goWkdoNFtL+HTjmuLgyWTJIJXEpINU
 iD3nUwxgdHmXh1jLD7fK/WRHJx40rUC+vYlOYch5fGSoFzpig3Z/qjuWdRrq5+VZ1LQA
 LhUs9+CyEPUNlyJuMsTJlSiPZgBjIcK4X4w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu4049gbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 14:06:16 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 11 Dec 2019 14:06:15 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:06:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6bhAvFgYLkVUf4WOd5Y3LJinp10wlPyzWjcuMUfHaL4SmbYcau+pybX1c6kseWYEXzQe/OU1mmYWV6lk8oJis/YG+eeuYccVKuUyaeFvRykBILfYC+Jq7mLIoukfbcVUhStO8AQXrGG7acJ5VUAQFTetlRoxUArTJ3ddFNhM9UVD5HPa/yeTRus0+IFAikblYEhLzIgmZv8CQLB/EMaw4GbVGVmNTzuFwz3avhI+GhZ+nFsiBKeBVPQ69pV89hHkJLt1ywiIWRv/5ZHBEHdBb3OtdC9xEmWiNahRKyIu4/MzOP9qMqfM+SX89rX5367OIGaeyZ/KRXsENiQaW7thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6pslR/+vLwja6+RwmvYPhjJgTwGnGvoPmF0G2EN5A0=;
 b=e5ZLTqLSbC79Y9doJNXbgi9MAYA/K3hq9/fIVS4SKCED0Eq5RuISewji8XjJ0ZWq2WIXhbkFTTVobYIUJzGm4iKORS8wUeWHGrb6OeB+gbfydmJn1bbxxDt9cz/C3naO8y5mTNeouXnJfT513CVzvTjlWAhfUwbGEwluOMC/W7tScQFaEo0g9RmlHRYgY7/TUWgG1d9TjZsFIhaWcEPaaMSx83MAI+xo6tlKmaUuM//wx6gZSVj51Gpmfxvuau1xkAgzWOhrTW8cRUb7pyOwk8B3D6AXc7hCmTMQaF1xcwKt+MasgoWxd82ySNZfLfEJdPq0/PIjpvm59cAFdfvZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6pslR/+vLwja6+RwmvYPhjJgTwGnGvoPmF0G2EN5A0=;
 b=DYzGDXUSfBShsUNLl37iCVYabC6qqFfRJ1f5zJqXE+0GbE6WvLH7z+hhNwBsxqvbDj4w6kxlfzUtsAJAyXR4wRZZFelv5RsjtrqJN7XgVuDEqPNlKWEjY+w9uU0/x48XKkio+OnTyX64iNdkhr21sPErm5PV5VgVqNDo89a6RR0=
Received: from MWHPR15MB1247.namprd15.prod.outlook.com (10.175.2.15) by
 MWHPR15MB1789.namprd15.prod.outlook.com (10.174.96.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 22:06:14 +0000
Received: from MWHPR15MB1247.namprd15.prod.outlook.com
 ([fe80::88d6:3ab:13:d5b7]) by MWHPR15MB1247.namprd15.prod.outlook.com
 ([fe80::88d6:3ab:13:d5b7%9]) with mapi id 15.20.2538.016; Wed, 11 Dec 2019
 22:06:14 +0000
From:   Wez Furlong <wez@fb.com>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
CC:     Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: File monitor problem
Thread-Topic: File monitor problem
Thread-Index: AQHVr5tzS2l8Ko6MUE6lKBzUAyLy9ae1fy8A
Date:   Wed, 11 Dec 2019 22:06:13 +0000
Message-ID: <8486261f-9cf2-e14e-c425-d9df7ba7b277@fb.com>
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz>
 <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
 <20191210165538.GK1551@quack2.suse.cz>
 <CAOQ4uximwdf37JdVVfHuM_bxk=X7pz21hnT3thk01oDs_npfhw@mail.gmail.com>
In-Reply-To: <CAOQ4uximwdf37JdVVfHuM_bxk=X7pz21hnT3thk01oDs_npfhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To MWHPR15MB1247.namprd15.prod.outlook.com
 (2603:10b6:320:22::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bfff]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51326ac0-d403-4e97-06e6-08d77e86566a
x-ms-traffictypediagnostic: MWHPR15MB1789:
x-microsoft-antispam-prvs: <MWHPR15MB1789F933B5300FBCC2D73AEFD95A0@MWHPR15MB1789.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39860400002)(174864002)(199004)(189003)(66476007)(81156014)(66446008)(64756008)(66946007)(81166006)(8936002)(66556008)(186003)(31686004)(8676002)(36756003)(4326008)(52116002)(86362001)(7116003)(5660300002)(3480700005)(2616005)(2906002)(6486002)(6506007)(478600001)(6512007)(110136005)(316002)(71200400001)(54906003)(31696002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1789;H:MWHPR15MB1247.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U28CgWcx/vm3UT7CAfKdkW4JJqqUtA4elu5BgxBuNmf2F+0alpPEVyBKvTAd8NbCJZlQJZCfmHGFBUTaoIuIR0RryNayvKj4IgOoLTeq9o6hOxUTGyfZXTBfTGnxlL69RHBQK02Nwe5rOOH7rCkDK8ZESt5WPaFc5R3VPVXZ5wwDBDajG4gu87fX1aaCDJpsmcAyqBIQSdrqxy0kIPaUw8fd4JF9r4aOBfeWfauCj6m8Xcpa72I2QjFBkKgm+5hR5BQ6mT2Hq7Sdrc8xS49Kik1Dy+TZP4r/hxu318RWLB8uZKC7juYjriEyivLJP/ukFi8PHw0wgtjFral6B9x8SlJHU9Jb1iGyDnRjGyyO+6KV1WZvgvMm9JNvQ0q1R/c2M0BggJHU33/TkPrvQLEqM9ctEYcN+wCJTHMJyWHu5CeyecZm1Pi/8a0UB6rryCxZMUdJfeKvS3wlHNIN78L53NuArMF00JjcpudInDAf8ULFpWYt91FLby0R7TIfzW8V
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <663BD14486F1FE4D96789834F9F72BFF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51326ac0-d403-4e97-06e6-08d77e86566a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 22:06:13.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LwpPIet00cvuaXghAqvjgHsZqHZnDNua8sU1smhalI9eYVx+E198qB7t4rgrW0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_07:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912110173
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTIvMTAvMTkgMTI6NDksIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KDQo+IFtjYzogV2F0Y2ht
YW4gbWFpbnRhaW5lcl0NCg0KSGksIEknbSB0aGUgV2F0Y2htYW4gY3JlYXRvciBhbmQgbWFpbnRh
aW5lciwgYW5kIEkgYWxzbyB3b3JrIG9uIGEgRlVTRSANCmJhc2VkIHZpcnR1YWwgZmlsZXN5c3Rl
bSBjYWxsZWQgRWRlbkZTIHRoYXQgd29ya3Mgd2l0aCB0aGUgc291cmNlIA0KY29udHJvbCBzeXN0
ZW1zIHRoYXQgd2UgdXNlIGF0IEZhY2Vib29rLg0KDQpJIGRvbid0IGhhdmUgbXVjaCBjb250ZXh0
IG9uIGZhbm90aWZ5IHlldCwgYnV0IEkgZG8gaGF2ZSBhIGxvdCBvZiANCnByYWN0aWNhbCBleHBl
cmllbmNlIHdpdGggV2F0Y2htYW4gb24gdmFyaW91cyBvcGVyYXRpbmcgc3lzdGVtcyB3aXRoIA0K
dmVyeSBsYXJnZSByZWN1cnNpdmUgZGlyZWN0b3J5IHRyZWVzLg0KDQpBbWlyIGFza2VkIG1lIHRv
IHBhcnRpY2lwYXRlIGluIHRoaXMgZGlzY3Vzc2lvbiwgYW5kIEkgdGhpbmsgaXQncyANCnByb2Jh
Ymx5IGhlbHBmdWwgdG8gZ2l2ZSBhIGxpdHRsZSBiaXQgb2YgY29udGV4dCBvbiBob3cgd2UgZGVh
bCB3aXRoIA0Kc29tZSBvZiB0aGUgZGlmZmVyZW50IHdhdGNoZXIgaW50ZXJmYWNlcywgYW5kIGFs
c28gaG93IHdlIHNlZSB0aGUgDQpjb25zdW1lcnMgb2YgV2F0Y2htYW4gbWFraW5nIHVzZSBvZiB0
aGlzIHNvcnQgb2YgZGF0YS7CoCBUaGVyZSBhcmUgdGVucyANCm9mIHdhdGNobWFuIGNvbnN1bWlu
ZyBhcHBsaWNhdGlvbnMgaW4gY29tbW9uIHVzZSBpbnNpZGUgRkIsIGFuZCBhIGxvbmcgDQp0YWls
IG9mIGFkLWhvYyBjb25zdW1lcnMgdGhhdCBhcmUgbm90IG9uIG15IHJhZGFyLg0KDQpJIGRvbid0
IHdhbnQgdG8gZmxvb2QgeW91IHdpdGggZGF0YSB0aGF0IG1heSBub3QgZmVlbCByZWxldmFudCBz
byBJJ20gDQpnb2luZyB0byB0cnkgdG8gc3VtbWFyaXplIHNvbWUga2V5IHBvaW50czsgSSdkIGJl
IGhhcHB5IHRvIGVsYWJvcmF0ZSBpZiANCnlvdSdkIGxpa2UgbW9yZSBjb250ZXh0IcKgIFRoZXNl
IGFyZSB3cml0dGVuIG91dCBhcyBudW1iZXJlZCBzdGF0ZW1lbnRzIA0KdG8gbWFrZSBpdCBlYXNp
ZXIgdG8gcmVmZXJlbmNlIGluIGZ1cnRoZXIgZGlzY3Vzc2lvbiwgYW5kIGFyZSBub3QgDQppbnRl
bmRlZCB0byBiZSB0YWtlbiBhcyBhbnkga2luZCBvZiBwcmVzY3JpcHRpdmUgbWFuaWZlc3RvIQ0K
DQoxLiBIdW1hbnMgdGhpbmsgaW4gdGVybXMgb2YgZmlsZW5hbWVzLsKgIEFwcGxpY2F0aW9ucyBs
YXJnZWx5IG9ubHkgY2FyZSANCmFib3V0IGZpbGVuYW1lcy7CoCBJdCdzIHJhcmUgKGl0IGNhbWUg
dXAgYXMgYSBoeXBvdGhldGljYWwgZm9yIG9ubHkgb25lIA0KaW50ZWdyYXRpbmcgYXBwbGljYXRp
b24gYXQgRkIgaW4gdGhlIHBhc3Qgc2V2ZXJhbCB5ZWFycykgdGhhdCB0aGV5IGNhcmUgDQphYm91
dCBvcHRpbWl6aW5nIGZvciB0aGUgdmFyaW91cyByZW5hbWUgY2FzZXMgc28gbG9uZyBhcyB0aGV5
IGdldCANCm5vdGlmaWVkIHRoYXQgdGhlIG9sZCBuYW1lIGlzIG5vIGxvbmdlciB2aXNpYmxlIGlu
IHRoZSBmaWxlc3lzdGVtIGFuZCANCnRoYXQgYSBuZXcgbmFtZSBpcyBub3cgdmlzaWJsZSBlbHNl
d2hlcmUgaW4gdGhlIHBvcnRpb24gb2YgdGhlIA0KZmlsZXN5c3RlbSB0aGF0IHRoZXkgYXJlIHdh
dGNoaW5nLg0KDQoyLiBBcHBsaWNhdGlvbiBhdXRob3JzIGRvbid0IHdhbnQgdG8gZGVhbCB3aXRo
IHRoZSBjb21wbGV4aXRpZXMgb2YgZmlsZSANCndhdGNoaW5nLCB0aGV5IGp1c3Qgd2FudCB0byBy
ZWxpYWJseSBrbm93IGlmL3doZW4gYSBuYW1lZCBmaWxlIGhhcyANCmNoYW5nZWQuwqAgUmVuYW1l
IGNvb2tpZXMgYW5kIG92ZXJmbG93IGV2ZW50cyBhcmUgdG9vIGRpZmZpY3VsdCBmb3IgbW9zdCAN
CmFwcGxpY2F0aW9ucyB0byBkZWFsIHdpdGggYXQgYWxsL2NvcnJlY3RseS4NCg0KMy4gT3ZlcmZs
b3cgZXZlbnRzIGFyZSBwYWluZnVsIHRvIGRlYWwgd2l0aC7CoCBJbiBXYXRjaG1hbiB3ZSBkZWFs
IHdpdGggDQppbm90aWZ5IG92ZXJmbG93IGJ5IHJlLWNyYXdsaW5nIGFuZCBleGFtaW5pbmcgdGhl
IGRpcmVjdG9yeSBzdHJ1Y3R1cmUgdG8gDQpyZS1zeW5jaHJvbml6ZSB3aXRoIHRoZSBmaWxlc3lz
dGVtIHN0YXRlLsKgIEZvciB2ZXJ5IGxhcmdlIHRyZWVzIHRoaXMgY2FuIA0KdGFrZSBhIHZlcnkg
bG9uZyB0aW1lLg0KDQo0LiBQYXJ0aWFsbHkgcmVsYXRlZCB0byAzLiwgcmVzdGFydGluZyB0aGUg
d2F0Y2htYW4gc2VydmVyIGlzIGFuIA0KZXhwZW5zaXZlIGV2ZW50IGJlY2F1c2Ugd2UgaGF2ZSB0
byByZS1jcmF3bCBldmVyeXRoaW5nIHRvIHJlLWNyZWF0ZSB0aGUgDQpkaXJlY3Rvcnkgd2F0Y2hl
cyB3aXRoIGlub3RpZnkuwqAgSWYgdGhlIHN5c3RlbSBwcm92aWRlZCBhIHJlY3Vyc2l2ZSANCndh
dGNoIGZ1bmN0aW9uIGFuZCBzb21lIGtpbmQgb2YgYSBjaGFuZ2Ugam91cm5hbCB0aGF0IHRvbGQg
d2F0Y2htYW4gYSANCnNldCBvZiBOIGRpcmVjdG9yaWVzIHRvIGNyYXdsICh3aGVyZSBOIDwgdGhl
IE0gb3ZlcmFsbCBudW1iZXIgb2YgDQpkaXJlY3RvcmllcykgYW5kIHdlIGhhZCBhIHN0YWJsZSBp
ZGVudGlmaWVyIGZvciBmaWxlcywgdGhlbiB3ZSBjb3VsZCANCnBlcnNpc3Qgc3RhdGUgYWNyb3Nz
IHJlc3RhcnRzIGFuZCBjaGVhcGx5IHJlLXN5bmNocm9uaXplLg0KDQo1LiBJcyBhbHNvIHJlbGF0
ZWQgdG8gMy4gYW5kIDQuwqAgV2UgdXNlIGJ0cmZzIHN1YnZvbHVtZXMgaW4gb3VyIENJIHRvIA0K
c25hcHNob3QgbGFyZ2UgcmVwb3MgYW5kIG1ha2UgdGhlbSBhdmFpbGFibGUgdG8gam9icyBydW5u
aW5nIGluIA0KZGlmZmVyZW50IGNvbnRhaW5lcnMgcG90ZW50aWFsbHkgb24gZGlmZmVyZW50IGhv
c3RzLsKgIElmIHRoZSBqb3VybmFsIA0KbWVjaGFuaXNtIGZyb20gNC4gd2VyZSBhdmFpbGFibGUg
aW4gdGhpcyBzaXR1YXRpb24gaXQgd291bGQgbWFrZSBpdCANCnN1cGVyIGNoZWFwIHRvIGJyaW5n
IHVwIHdhdGNobWFuIGluIHRob3NlIGVudmlyb25tZW50cy4NCg0KNi4gQSBkb3duc2lkZSB0byBy
ZWN1cnNpdmUgd2F0Y2hlcyBvbiBtYWNPUyBpcyB0aGF0IGZzZXZlbnRzZCBoYXMgdmVyeSANCmxp
bWl0ZWQgYWJpbGl0eSB0byBhZGQgZXhjZXB0aW9ucy7CoCBBIGNvbW1vbiBwYXR0ZXJuIGF0IEZC
IGlzIHRoYXQgdGhlIA0KYnVjayBidWlsZCBzeXN0ZW0gbWFpbnRhaW5zIGEgYnVpbGQgYXJ0aWZh
Y3RzIGRpcmVjdG9yeSBjYWxsZWQgDQpgYnVjay1vdXRgIGluIHRoZSByZXBvLsKgIE9uIExpbnV4
IHdlIGNhbiBpZ25vcmUgY2hhbmdlIG5vdGlmaWNhdGlvbnMgZm9yIA0KdGhpcyBkaXJlY3Rvcnkg
d2l0aCB6ZXJvIGNvc3QgYnkgc2ltcGx5IG5vdCByZWdpc3RlcmluZyBpdCB3aXRoIA0KaW5vdGlm
eS7CoCBPbiBtYWNPUywgdGhlIGtlcm5lbCBpbnRlcmZhY2UgYWxsb3dzIGZvciBhIG1heGltdW0g
b2YgOCANCmV4Y2x1c2lvbnMuwqAgVGhlIHJlc3Qgb2YgdGhlIGNoYW5nZXMgYXJlIGRlbGl2ZXJl
ZCB0byBmc2V2ZW50c2Qgd2hpY2ggDQpzdGF0cyBhbmQgcmVjb3JkcyBldmVyeXRoaW5nIGluIGEg
c3FsaXRlIGRhdGFiYXNlLsKgIFRoaXMgaXMgYSANCnBlcmZvcm1hbmNlIGhvdHNwb3QgZm9yIHVz
IGJlY2F1c2UgdGhlIG51bWJlciBvZiBleGNsdWRlZCBkaXJlY3RvcmllcyBpbiANCmEgcmVwbyBl
eGNlZWRzIDgsIGFuZCB0aGUgdW5pbnRlcmVzdGluZyBidWxreSBidWlsZCBhcnRpZmFjdCB3cml0
ZXMgdGhlbiANCm5lZWQgdG8gdHJhbnNpdCBmc2V2ZW50c2QgYW5kIGludG8gd2F0Y2htYW4gYmVm
b3JlIHdlIGNhbiBkZWNpZGUgdG8gDQppZ25vcmUgdGhlbS4NCg0KNy4gV2luZG93cyBoYXMgYSBq
b3VybmFsIG1lY2hhbmlzbSB0aGF0IGNvdWxkIHBvdGVudGlhbGx5IGJlIHVzZWQgYXMgDQpzdWdn
ZXN0ZWQgaW4gNC4gYWJvdmUsIGJ1dCBpdCByZXF1aXJlcyBwcml2aWxlZ2VkIGFjY2Vzcy7CoCBJ
IGhhcHBlbiB0byANCmtub3cgZnJvbSBzb21lb25lIGF0IE1TIHRoYXQgd29ya2VkIG9uIGEgc2lt
aWxhciBzeXN0ZW0gdGhhdCB0aGVyZSBpcyANCmFsc28gYSB3YXkgdG8gYWNjZXNzIGEgc3Vic2V0
IG9mIHRoaXMgZGF0YSB0aGF0IGRvZXNuJ3QgcmVxdWlyZSANCnByaXZpbGVnZWQgYWNjZXNzLCBi
dXQgdGhhdCBpc24ndCBkb2N1bWVudGVkLsKgIEkgbWVudGlvbiB0aGlzIGJlY2F1c2UgDQplbHNl
d2hlcmUgaW4gdGhpcyB0aHJlYWQgaXMgYSBkaXNjdXNzaW9uIGFib3V0IHByaXZpbGVnZWQgYWNj
ZXNzIHRvIA0Kc2ltaWxhciBzb3VuZGluZyBpbmZvcm1hdGlvbi4NCg0KOC4gUmVsYXRlZCB0byA2
LiBhbmQgNy4sIGlmIHRoZXJlIGlzIGEgcHJpdmlsZWdlZCBzeXN0ZW0gZGFlbW9uIHRvIGFjdCAN
CmFzIHRoZSBpbnRlcmZhY2UgYmV0d2VlbiB1c2Vyc3BhY2U8LT5rZXJuZWwsIGNhcmUgbmVlZHMg
dG8gYmUgdGFrZW4gdG8gDQphdm9pZCB0aGUgc29ydCBvZiBwZXJmb3JtYW5jZSBob3RzcG90IHdl
IHNlZSBvbiBtYWNPUyB3aXRoIDYuIGFib3ZlLg0KDQoNCk9LLCBob3BlZnVsbHkgdGhhdCBkb2Vz
bid0IGZlZWwgdG9vIG9mZiB0aGUgbWFyayHCoCBJIGRvbid0IHRoaW5rIA0KZXZlcnl0aGluZyBh
Ym92ZSBuZWVkcyB0byBiZSBoYW5kbGVkIGRpcmVjdGx5IGF0IHRoZSBrZXJuZWwgaW50ZXJmYWNl
LsKgIA0KU29tZSBvZiB0aGVzZSBkZXRhaWxzIGNvdWxkIGJlIGhhbmRsZWQgb24gdGhlIHVzZXJz
cGFjZSBzaWRlLCBlaXRoZXIgYnkgDQphIGRhZW1vbiAoZWc6IHdhdGNobWFuKSBvciBhIHN1aXRh
Ymx5IHdlbGwgZGVzaWduZWQgY2xpZW50IGxpYnJhcnkgDQooYWx0aG91Z2ggdGhhdCBjYW4gbWFr
ZSBpdCBkaWZmaWN1bHQgdG8gY29uc3VtZSBpbiBzb21lIHByb2dyYW1taW5nIA0KZW52aXJvbm1l
bnRzKS4NCg0KDQotLVdleg0KDQo=
