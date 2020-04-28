Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B506B1BB62F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 08:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD1GKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 02:10:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27722 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgD1GKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:10:06 -0400
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800"; 
   d="scan'208";a="90612535"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Apr 2020 14:09:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A9EE050A9991;
        Tue, 28 Apr 2020 14:09:48 +0800 (CST)
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Apr 2020 14:09:47 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::15e2:f6f4:7314:fd88])
 by G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::15e2:f6f4:7314:fd88%14]) with
 mapi id 15.00.1497.000; Tue, 28 Apr 2020 14:09:47 +0800
From:   "Ruan, Shiyang" <ruansy.fnst@cn.fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
Subject: =?utf-8?B?5Zue5aSNOiBSZTogW1JGQyBQQVRDSCAwLzhdIGRheDogQWRkIGEgZGF4LXJt?=
 =?utf-8?Q?ap_tree_to_support_reflink?=
Thread-Topic: Re: [RFC PATCH 0/8] dax: Add a dax-rmap tree to support reflink
Thread-Index: AQHWHHCrvTehP1uFMkqHUwaMK6beO6iMX8EAgAEofYA=
Date:   Tue, 28 Apr 2020 06:09:47 +0000
Message-ID: <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
In-Reply-To: <20200427122836.GD29705@bombadil.infradead.org>
Reply-To: "Ruan, Shiyang" <ruansy.fnst@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.225.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <431D96282EC2FB4DA394D352951FF28C@fujitsu.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: A9EE050A9991.AE63C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQrlnKggMjAyMC80LzI3IDIwOjI4OjM2LCAiTWF0dGhldyBXaWxjb3giIDx3
aWxseUBpbmZyYWRlYWQub3JnPiDlhpnpgZM6DQoNCj5PbiBNb24sIEFwciAy
NywgMjAyMCBhdCAwNDo0Nzo0MlBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3Jv
dGU6DQo+PiAgVGhpcyBwYXRjaHNldCBpcyBhIHRyeSB0byByZXNvbHZlIHRo
ZSBzaGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9yDQo+PiAgZnNkYXgu
DQo+Pg0KPj4gIEluIG9yZGVyIHRvIHRyYWNrIG11bHRpcGxlIG1hcHBpbmdz
IGFuZCBpbmRleGVzIG9uIG9uZSBwYWdlLCBJDQo+PiAgaW50cm9kdWNlZCBh
IGRheC1ybWFwIHJiLXRyZWUgdG8gbWFuYWdlIHRoZSByZWxhdGlvbnNoaXAu
ICBBIGRheCBlbnRyeQ0KPj4gIHdpbGwgYmUgYXNzb2NpYXRlZCBtb3JlIHRo
YW4gb25jZSBpZiBpcyBzaGFyZWQuICBBdCB0aGUgc2Vjb25kIHRpbWUgd2UN
Cj4+ICBhc3NvY2lhdGUgdGhpcyBlbnRyeSwgd2UgY3JlYXRlIHRoaXMgcmIt
dHJlZSBhbmQgc3RvcmUgaXRzIHJvb3QgaW4NCj4+ICBwYWdlLT5wcml2YXRl
KG5vdCB1c2VkIGluIGZzZGF4KS4gIEluc2VydCAoLT5tYXBwaW5nLCAtPmlu
ZGV4KSB3aGVuDQo+PiAgZGF4X2Fzc29jaWF0ZV9lbnRyeSgpIGFuZCBkZWxl
dGUgaXQgd2hlbiBkYXhfZGlzYXNzb2NpYXRlX2VudHJ5KCkuDQo+DQo+RG8g
d2UgcmVhbGx5IHdhbnQgdG8gdHJhY2sgYWxsIG9mIHRoaXMgb24gYSBwZXIt
cGFnZSBiYXNpcz8gIEkgd291bGQNCj5oYXZlIHRob3VnaHQgYSBwZXItZXh0
ZW50IGJhc2lzIHdhcyBtb3JlIHVzZWZ1bC4gIEVzc2VudGlhbGx5LCBjcmVh
dGUNCj5hIG5ldyBhZGRyZXNzX3NwYWNlIGZvciBlYWNoIHNoYXJlZCBleHRl
bnQuICBQZXIgcGFnZSBqdXN0IHNlZW1zIGxpa2UNCj5hIGh1Z2Ugb3Zlcmhl
YWQuDQo+DQpQZXItZXh0ZW50IHRyYWNraW5nIGlzIGEgbmljZSBpZGVhIGZv
ciBtZS4gIEkgaGF2ZW4ndCB0aG91Z2h0IG9mIGl0IA0KeWV0Li4uDQoNCkJ1
dCB0aGUgZXh0ZW50IGluZm8gaXMgbWFpbnRhaW5lZCBieSBmaWxlc3lzdGVt
LiAgSSB0aGluayB3ZSBuZWVkIGEgd2F5IA0KdG8gb2J0YWluIHRoaXMgaW5m
byBmcm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEg
Yml0IA0KY29tcGxpY2F0ZWQuICBMZXQgbWUgdGhpbmsgYWJvdXQgaXQuLi4N
Cg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLgoK
