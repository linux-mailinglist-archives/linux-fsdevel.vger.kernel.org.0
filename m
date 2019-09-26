Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E817BBEE9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfIZJlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 05:41:16 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:16002
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfIZJlQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:41:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff6VpGhaCTqPY/IV4GPyK4/OASe+VZuVYWVpeQowvB79/Bu6AgJsJKENIyy8OrMkypINlwSm4lwomENLufSkpBZ6LhzQhqaIHVqV6wvo7FeqvIbsa73ggtb5iO8urObLIzsZs36Sg8vtQvLqph8qUtxgCxXGyp3rbDJdNHbYG9ayhmSwCD4mby+HoOrZ69jRE6d4KZPMyE7+P+cBPbH3/zRxGL/EMDshnDNtD3GmM/aZvMNHZajru4kzeTHiJDwGGpibphdoovdDM7NfMMaYy/17MtD0EqjIRjrwlpPDeTSeztCYOOQfNEEXYRXe0Cn3HtvnxD13O1HAYb0kkjiTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m42GZltnXBetVI2eUqsLuF8WIeBfcxnGIpwJXYyczAk=;
 b=LUXtui8lGTi3PH0ysLXTPBl32bM/zHD340DZCPI3Zf2GvTxAGtgkePXYTbdAS6Gf8y/njQRL0DtpeY8/RL++3HLL85ODOvYi6NOv2jDTYGw51EoeOenRocl6H3etQF2oE5zgK+6Kyr9Eqk8q6KpVHdSTDbbxdPIGENJyfFqTIrwMzf+KMaBTLLbj0o9Icdu81b+6x5+1UuFTVPeeqSS3lzijYoyHbjwPcaaxcrG0sDHm+48V13fT5osOrv0s1JeG6jOydqWOUIoUko/Z4/wrmPjIKeXbsm9nr/4mYQYc37tjOFix7+yLIHf5YaLrZJPuLQYHIYIc9pm2r6ISkFUjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m42GZltnXBetVI2eUqsLuF8WIeBfcxnGIpwJXYyczAk=;
 b=otOXm1L+hn3z/ThAMalUAViAieIgjR9YCYqYQAwC9yR8JfkpU9JMeqdIBxG+js9NhFCZKE+uCeI7TINcNWVjKZ4Asa6DmfQLq6Qlv0IDta1g48G8WwEWU5OF4rQM1aCBrXCiCAhtB9STPV3vaiEnlRxBXh4jpEWkvzVCuJVMJ50=
Received: from DM6PR19MB2331.namprd19.prod.outlook.com (20.176.103.15) by
 DM6PR19MB4137.namprd19.prod.outlook.com (52.132.250.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Thu, 26 Sep 2019 09:41:13 +0000
Received: from DM6PR19MB2331.namprd19.prod.outlook.com
 ([fe80::5c33:1cff:b3f3:64bb]) by DM6PR19MB2331.namprd19.prod.outlook.com
 ([fe80::5c33:1cff:b3f3:64bb%6]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 09:41:13 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
Thread-Topic: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
Thread-Index: AQHVdE6FU90k3N+71kWMXE30scDLBw==
Date:   Thu, 26 Sep 2019 09:41:12 +0000
Message-ID: <85b8ae15-774a-35d2-dacf-b569578cc561@ddn.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
In-Reply-To: <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.189.68.189]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-clientproxiedby: PR0P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::19) To DM6PR19MB2331.namprd19.prod.outlook.com
 (2603:10b6:5:ce::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bschubert@ddn.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0806743f-25a4-40a3-41cb-08d74265ab07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR19MB4137;
x-ms-traffictypediagnostic: DM6PR19MB4137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB413738C8ABA418B08243A29FB5860@DM6PR19MB4137.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39850400004)(346002)(189003)(199004)(52116002)(7416002)(316002)(99286004)(58126008)(229853002)(4744005)(6436002)(66946007)(6486002)(81166006)(81156014)(486006)(71190400001)(66446008)(8936002)(66476007)(446003)(6116002)(2616005)(66556008)(478600001)(3846002)(86362001)(11346002)(31696002)(71200400001)(54906003)(14454004)(2906002)(7736002)(476003)(8676002)(6512007)(31686004)(64756008)(6246003)(5660300002)(65806001)(65956001)(76176011)(66066001)(26005)(110136005)(256004)(6506007)(102836004)(186003)(14444005)(386003)(305945005)(4326008)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR19MB4137;H:DM6PR19MB2331.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zG28Q9C7wE5mo0LQfMq6TujlIzId/P5d+HRf1QXmwldj1oQxI+DZsSt2SUv7yRKqyURiKSHy9LME2OjisIL5So548/no2iKpZk+2qlTy/fFOkxtRP0sMnB3hs7Sd0k8c4uPBI5/X0lbcE8Tr8uYL+dAZPdMiq7+bi02QzfwsVIgceDKro471v+xwk+a1Um9fgiEG5pREcMISnn2jMJJKPQD5FuHXD24W3uTty/14JLIThphzG11CYu4ottxc8o7CSYQRgVWzisVMbfiWqg2LXIVCLYM9tZQNHesgIDF/kbLtUnFIOxornF3XqN/Xb1rtBwAO5wbgNzBNZIjyh/JrRaS0ip8KH8JBdfPhshDC0zfCBk4uWuopVyDGFW09Zp0Y+kCICjayC1fGgl0oj+GK8AzL37SvQfrSbNcbtZj/UlI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2041753B1751428336DB4A7634E7C5@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0806743f-25a4-40a3-41cb-08d74265ab07
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 09:41:12.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDwErV+msiaJKokq+Ehk0Dt28krT4aZYGyrA5dn1vW2mpikwSA/oe1qLdFokuJoPRqZLyZhIbamCmOFeSk9ARg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTWlrbG9zLA0KDQo+IEp1c3QgYSBoZWFkcyB1cCwgdGhhdCBJIGhhdmUgYWNoaWV2ZWQgc2lt
aWxhciByZXN1bHRzIHdpdGggYSBwcm90b3R5cGUNCj4gdXNpbmcgdGhlIHVubW9kaWZpZWQgZnVz
ZSBwcm90b2NvbC4gIFRoaXMgcHJvdG90eXBlIHdhcyBidWlsdCB3aXRoDQo+IGlkZWFzIHRha2Vu
IGZyb20genVmcyAocGVyY3B1L2xvY2tsZXNzLCBtbWFwZWQgZGV2LCBzaW5nbGUgc3lzY2FsbCBw
ZXINCj4gb3ApLiAgSSBmb3VuZCBhIGJpZyBzY2hlZHVsZXIgc2NhbGFiaWxpdHkgYm90dGxlbmVj
ayB0aGF0IGlzIGNhdXNlZCBieQ0KPiB1cGRhdGUgb2YgbW0tPmNwdV9iaXRtYXAgYXQgY29udGV4
dCBzd2l0Y2guICAgVGhpcyBjYW4gYmUgd29ya2VkDQo+IGFyb3VuZCBieSB1c2luZyBzaGFyZWQg
bWVtb3J5IGluc3RlYWQgb2Ygc2hhcmVkIHBhZ2UgdGFibGVzLCB3aGljaCBpcw0KPiBhIGJpdCBv
ZiBhIHBhaW4sIGJ1dCBpdCBkb2VzIHByb3ZlIHRoZSBwb2ludC4gIFRob3VnaHQgYWJvdXQgZml4
aW5nDQo+IHRoZSBjcHVfYml0bWFwIGNhY2hlbGluZSBwaW5ncG9uZywgYnV0IGRpZG4ndCByZWFs
bHkgZ2V0IGFueXdoZXJlLg0KPiANCj4gQXJlIHlvdSBpbnRlcmVzdGVkIGluIGNvbXBhcmluZyB6
dWZzIHdpdGggdGhlIHNjYWxhYmxlIGZ1c2UgcHJvdG90eXBlPw0KPiAgSWYgc28sIEknbGwgcHVz
aCB0aGUgY29kZSBpbnRvIGEgcHVibGljIHJlcG8gd2l0aCBzb21lIGluc3RydWN0aW9ucywNCg0K
SSB3b3VsZCBiZSBoYXBweSB0byBoZWxwIGhlcmUgKHJldmlldywgbGlnaHRseSB0ZXN0IGFuZCBk
ZWJ1ZykuIEkgd2FudGVkDQp0byBnaXZlIHRoZSBpb2N0bCB0aHJlYWRzIG1ldGhvZCBhIHRyeSBm
b3Igc29tZSB0aW1lIGFscmVhZHkganVzdCBuZXZlcg0KY2FtZSB0byBpdCB5ZXQuDQoNCg0KVGhh
bmtzLA0KQmVybmQNCg==
