Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7018F8A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgCWPcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:32:17 -0400
Received: from mail-eopbgr1300107.outbound.protection.outlook.com ([40.107.130.107]:34880
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbgCWPcQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1/lEPOiWEWlvuudy8k841pezrbGXtK8QxkAQTIYC4Z5QUqDSeUS9mYTHsUSe28cJzhjDm2QlGriGjrtJ/vWeJPiVd/s30uLxgEpHmMuA5xmVKCI2e2ooJcoVvTHCgmGTYhSs0I3j8Zcx12SJrxZE8wW4tq4ATj0MBvkuNHQ1XZFVhn9dNZGemIUnVzgNOzvtF/7ST+nZwiTo5ubstiaMEasyJCGqb4wu4DlosfJfqSefJHNw7QuSFMP88nM8fXaV7nFqYVl7BdQPiQdLIfMW20eHmE+Sl3CFf0lPJweky++3d9QDiqL2pqrwHK2LNuQcnu0kwaohUnFzRbi24Xs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIXOW8ptahRh0IcwLcgZX0WlNN3bPv3hDzoD2XkHhrY=;
 b=iq23H/oY+tGaj9l6wxWrJiSZuLFMRVbEuWDjXZ9V838W1YsPADCNoSSwh3lY3+ba8NunaQJc4DFNFDF7OPdDKwh+J6jddZTwwWB0kHwnKTbJ8aB9PyWu+AKuS8YMGM092VdIvrEVQG5NBCbLPVkb2jPzKqPOiodZ3C8z7IVxkZt6Y83RXVApiubRAlSQqrWlzXJ8K3NjJVv/uA9SVy2Sy97AyJxIUKthmacHz5a+jZAvqtUTzlhqjwtN9kv/zKLyulITp2xGbfuY6DnFqWh+VC85rbSzMhIgqIKhFCuElsgDPTCiBM4UDKULVhZbeOA3mtXPWBqcbnsGAe1aFgDSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIXOW8ptahRh0IcwLcgZX0WlNN3bPv3hDzoD2XkHhrY=;
 b=MhySxUK+G2FKK195rMpAXOsVcNG4JOZlbuH79AzTrKsVHChz2z/pwS0o19NBrsgTU5adc/PNhx0yigOKOlxIfwURJk2eUGvFS1bPpVtNcUZSwvvtiJpMD9ZHnEzIN7qbicZDcb87F3N9GmSILbgroLQL7DSyGEAqPMp4lvbzVPE=
Received: from TY2P153MB0224.APCP153.PROD.OUTLOOK.COM (20.178.144.138) by
 TY2P153MB0238.APCP153.PROD.OUTLOOK.COM (20.178.144.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.2; Mon, 23 Mar 2020 15:32:11 +0000
Received: from TY2P153MB0224.APCP153.PROD.OUTLOOK.COM
 ([fe80::5cc4:e2ba:5714:ad5b]) by TY2P153MB0224.APCP153.PROD.OUTLOOK.COM
 ([fe80::5cc4:e2ba:5714:ad5b%6]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 15:32:11 +0000
From:   Nilesh Awate <Nilesh.Awate@microsoft.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Fanotify Ignore mask
Thread-Topic: [EXTERNAL] Re: Fanotify Ignore mask
Thread-Index: AdYAcWA85bxd3AqDTsC7u6B9RogQewAmOn0AAAJRqQAAAQOicAAD9yqAAAAr/vA=
Date:   Mon, 23 Mar 2020 15:32:11 +0000
Message-ID: <TY2P153MB02240BE8D5B6FBD0506EA4449CF00@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
References: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
 <20200323115756.GA28951@quack2.suse.cz>
 <CAOQ4uxixHS6p44DObK=raGjmRUjLVoCozhpv_H85gUcdftOeRg@mail.gmail.com>
 <TY2P153MB022430EDF9F91E7F457667739CF00@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiZE2xipfmSH45Y6LgAy-Uz6uLH+rsp3OMAJrsDqby9uQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiZE2xipfmSH45Y6LgAy-Uz6uLH+rsp3OMAJrsDqby9uQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nawate@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T15:32:10.2839612Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d01371d-4635-4c30-89a3-600e9f08bd35;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nilesh.Awate@microsoft.com; 
x-originating-ip: [2404:f801:8028:1:34e0:aea6:e1f2:809f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97a31245-43f2-44a7-ce12-08d7cf3f5b56
x-ms-traffictypediagnostic: TY2P153MB0238:
x-microsoft-antispam-prvs: <TY2P153MB0238BA2C197A22262B24217C9CF00@TY2P153MB0238.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(4744005)(6916009)(86362001)(6506007)(4326008)(478600001)(2906002)(33656002)(52536014)(8936002)(5660300002)(53546011)(10290500003)(186003)(8990500004)(66946007)(76116006)(71200400001)(66476007)(8676002)(81166006)(81156014)(66556008)(64756008)(66446008)(55016002)(7696005)(9686003)(316002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2P153MB0238;H:TY2P153MB0224.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ppk1tyAUwERQqESK8CzvvohbAsSOViEByreRZfu0migNDKxdduAlp1KJoioZkcYpb2EkZKjQ7EsYmw6mkfsz/aF2cKVdlDNsOoNvVQ3tVPosGarS00K1jL68JUpbldWo9IAQ1+/m/yn1lOkCvKOLza0+zxFYdrdxhYa2nkr4awA9XInXAum0mV9WLQi9LxVG/qNhbPCy1AFeRtgoA2zrY8jXrXo1VTT6lFhJa2Jd2kieoJDrCL4QBbXvxxq7JiZQ8Qfh2ZDG2lcLwVDEj0QLOcars0yEmdhcJlq6XO+LzboDDm9+2AduwMZVh3Q0UTNSJjkMQmm2yVo4ONx7rEWctpz/8/GEwpCXysV2j8+RaTILxVXKmSMl+X8Z9a5wnML0Dz7RI6fsZaUpwd34rm4Aqb+JwnQm2iXp9THbwaHdQkFsy5ZRvlaUV8kDlZHaeFAU
x-ms-exchange-antispam-messagedata: xD2p2Ba1JO4OdBWSCobokK/VDwqLJMN+he3MK6u0G44YTh2Spu/mjrA+oOABhZgu1x9mX5E6S9trSQYCHihaTfbZ5vNWA/gIJS6Kf7QAa0LNR3C+BC5jvW6zv3HEuRZq31ZYGGqM8zC1k+hxF8IyCNjmV1ogJcioM87mz3jLU1hWZoQ7TGgNM0WNc2z1f1VRnqPFuJIAJTIKZ1Q+SHPsPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a31245-43f2-44a7-ce12-08d7cf3f5b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 15:32:11.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAS4M2oZ+GC95ChQmEAMqWlnVd9DQ9azkxNfpUOyrXjMT8Jsox8UyqxHH4FqIoPJHdNbjIngwgHUrToEMcqolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2P153MB0238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WWVzIG1ha2VzIHNlbnNlLg0KDQpUaGFuayBZb3UhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPiANClNlbnQ6IE1v
bmRheSwgTWFyY2ggMjMsIDIwMjAgODo1NyBQTQ0KVG86IE5pbGVzaCBBd2F0ZSA8TmlsZXNoLkF3
YXRlQG1pY3Jvc29mdC5jb20+DQpDYzogSmFuIEthcmEgPGphY2tAc3VzZS5jej47IGxpbnV4LWZz
ZGV2ZWwgPGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtFWFRF
Uk5BTF0gUmU6IEZhbm90aWZ5IElnbm9yZSBtYXNrDQoNCk9uIE1vbiwgTWFyIDIzLCAyMDIwIGF0
IDM6MzQgUE0gTmlsZXNoIEF3YXRlIDxOaWxlc2guQXdhdGVAbWljcm9zb2Z0LmNvbT4gd3JvdGU6
DQo+DQo+IEhpIEphbiwgQW1pciAtDQo+DQo+IFRoYW5rIHlvdSBmb3IgcXVpY2sgcmVzcG9uZCEN
Cj4NCj4gWWVzIHdpdGggbW91bnQgLS1iaW5kIC9vcHQgL29wdCBhbmQgdGhlbiBhZGRpbmcgaWdu
b3JlIG1hc2sgaXQgd29ya3MgYXMgZXhwZWN0ZWQuDQo+DQoNCllvdSBzaG91bGRuJ3QgbmVlZCBh
biBpZ25vcmUgbWFzayBpZiB5b3UgZGlkIG5vdCBzZXQgYSBtYXJrIG9uIHRoZSAvb3B0IG1vdW50
Lg0KVGhlIG1hcmsgb24gLyBkb2VzIG5vdCAncmVjdXJzaXZlbHknIGFwcGx5IHRvIHN1YiBtb3Vu
dHMuDQoNClRoYW5rcywNCkFtaXIuDQo=
