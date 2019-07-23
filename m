Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6DE7233D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfGWX76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 19:59:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:34173 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfGWX76 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:59:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 16:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="369081710"
Received: from pgsmsx104.gar.corp.intel.com ([10.221.44.91])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 16:59:55 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.46]) by
 PGSMSX104.gar.corp.intel.com ([169.254.3.64]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 07:59:54 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>
Subject: Re: [PATCH v9 5/6] mm,thp: add read-only THP support for
 (non-shmem) FS
Thread-Topic: [PATCH v9 5/6] mm,thp: add read-only THP support for
 (non-shmem) FS
Thread-Index: AQHVKurXe0zlPpLJvUiiyeP9CKzbqKbYiXyA
Date:   Tue, 23 Jul 2019 23:59:54 +0000
Message-ID: <1563926391.8456.1.camel@intel.com>
References: <20190625001246.685563-1-songliubraving@fb.com>
         <20190625001246.685563-6-songliubraving@fb.com>
In-Reply-To: <20190625001246.685563-6-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.182.119]
Content-Type: text/plain; charset="utf-8"
Content-ID: <90FB8C841C327D44B3083EA689DE73AE@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDE3OjEyIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBpcyAoaG9wZWZ1bGx5KSB0aGUgZmlyc3Qgc3RlcCB0byBlbmFibGUgVEhQIGZvciBu
b24tc2htZW0NCj4gZmlsZXN5c3RlbXMuDQo+IA0KPiBUaGlzIHBhdGNoIGVuYWJsZXMgYW4gYXBw
bGljYXRpb24gdG8gcHV0IHBhcnQgb2YgaXRzIHRleHQgc2VjdGlvbnMgdG8gVEhQDQo+IHZpYSBt
YWR2aXNlLCBmb3IgZXhhbXBsZToNCj4gDQo+ICAgICBtYWR2aXNlKCh2b2lkICopMHg2MDAwMDAs
IDB4MjAwMDAwLCBNQURWX0hVR0VQQUdFKTsNCj4gDQo+IFdlIHRyaWVkIHRvIHJldXNlIHRoZSBs
b2dpYyBmb3IgVEhQIG9uIHRtcGZzLg0KPiANCj4gQ3VycmVudGx5LCB3cml0ZSBpcyBub3Qgc3Vw
cG9ydGVkIGZvciBub24tc2htZW0gVEhQLiBraHVnZXBhZ2VkIHdpbGwgb25seQ0KPiBwcm9jZXNz
IHZtYSB3aXRoIFZNX0RFTllXUklURS4gc3lzX21tYXAoKSBpZ25vcmVzIFZNX0RFTllXUklURSBy
ZXF1ZXN0cw0KPiAoc2VlIGtzeXNfbW1hcF9wZ29mZikuIFRoZSBvbmx5IHdheSB0byBjcmVhdGUg
dm1hIHdpdGggVk1fREVOWVdSSVRFIGlzDQo+IGV4ZWN2ZSgpLiBUaGlzIHJlcXVpcmVtZW50IGxp
bWl0cyBub24tc2htZW0gVEhQIHRvIHRleHQgc2VjdGlvbnMuDQo+IA0KPiBUaGUgbmV4dCBwYXRj
aCB3aWxsIGhhbmRsZSB3cml0ZXMsIHdoaWNoIHdvdWxkIG9ubHkgaGFwcGVuIHdoZW4gdGhlIGFs
bA0KPiB0aGUgdm1hcyB3aXRoIFZNX0RFTllXUklURSBhcmUgdW5tYXBwZWQuDQo+IA0KPiBBbiBF
WFBFUklNRU5UQUwgY29uZmlnLCBSRUFEX09OTFlfVEhQX0ZPUl9GUywgaXMgYWRkZWQgdG8gZ2F0
ZSB0aGlzDQo+IGZlYXR1cmUuDQo+IA0KPiBBY2tlZC1ieTogUmlrIHZhbiBSaWVsIDxyaWVsQHN1
cnJpZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIu
Y29tPg0KPiAtLS0NCj4gIG1tL0tjb25maWcgICAgICB8IDExICsrKysrKw0KPiAgbW0vZmlsZW1h
cC5jICAgIHwgIDQgKy0tDQo+ICBtbS9raHVnZXBhZ2VkLmMgfCA5NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICBtbS9ybWFwLmMgICAgICAgfCAx
MiArKysrLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCAyMSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9LY29uZmlnIGIvbW0vS2NvbmZpZw0KPiBp
bmRleCBmMGM3NmJhNDc2OTUuLjBhOGZkNTg5NDA2ZCAxMDA2NDQNCj4gLS0tIGEvbW0vS2NvbmZp
Zw0KPiArKysgYi9tbS9LY29uZmlnDQo+IEBAIC03NjIsNiArNzYyLDE3IEBAIGNvbmZpZyBHVVBf
QkVOQ0hNQVJLDQo+ICANCj4gIAkgIFNlZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS9ndXBf
YmVuY2htYXJrLmMNCj4gIA0KPiArY29uZmlnIFJFQURfT05MWV9USFBfRk9SX0ZTDQo+ICsJYm9v
bCAiUmVhZC1vbmx5IFRIUCBmb3IgZmlsZXN5c3RlbXMgKEVYUEVSSU1FTlRBTCkiDQo+ICsJZGVw
ZW5kcyBvbiBUUkFOU1BBUkVOVF9IVUdFX1BBR0VDQUNIRSAmJiBTSE1FTQ0KDQpIaSwNCg0KTWF5
YmUgYSBzdHVwaWQgcXVlc3Rpb24gc2luY2UgSSBhbSBuZXcsIGJ1dCB3aHkgZG9lcyBpdCBkZXBl
bmQgb24gU0hNRU0/DQoNClRoYW5rcywNCi1LYWk=
