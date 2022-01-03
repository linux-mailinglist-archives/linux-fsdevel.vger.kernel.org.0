Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DB483912
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 00:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiACXbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 18:31:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:5705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbiACXbe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641252694; x=1672788694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1BcBXc3FZdZOvFo+kP02baXwCLAYxG8aNHOmSEVrlOE=;
  b=Kab+6tcKJR4LoHIFVDsMjbosNJtqAvRWWAHi0UcDYENklhAc8ODtoLUa
   yu3s+gVbo+FaON7SRvDUuFmL9Y+dytnpsyGUQXKJn8XH7Ermr+53PS4wU
   XBK0cYXm0299NqeFcyA5NI9yCjeh+OUAGaxZNbqyCZzvYXOVSFDBgCI/u
   8KOUc8YSF3zUN6E70m3Er8pGl1o05NK2ltYwCNsZKhDsB58taLHkVf/uU
   7A5byzhKjqr06zW5U8TEDGl+I7Qrbcli9OHFTfk92oisLw2+YXhal7w6f
   GKfahvfQ6PUSuWoHyfZWSnL2rlDrqsnlINarqBorHy8ziRykjS9DIUJ0t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="266392004"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="266392004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 15:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="512241081"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2022 15:31:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 15:31:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 15:31:32 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Mon, 3 Jan 2022 15:31:32 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: RE: pstore/ramoops - why only collect a partial dmesg?
Thread-Topic: pstore/ramoops - why only collect a partial dmesg?
Thread-Index: AQHX/MKP8AekIclEL0GvU4ZDFIVyq6xR+V6A
Date:   Mon, 3 Jan 2022 23:31:32 +0000
Message-ID: <2d1e9afa38474de6a8b1efc14925d095@intel.com>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
In-Reply-To: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBIaSBBbnRvbiAvIENvbGluIC8gS2VlcyAvIFRvbnksIEknZCBsaWtlIHRvIHVuZGVyc3RhbmQg
dGhlIHJhdGlvbmFsZQ0KPiBiZWhpbmQgYSByYW1vb3BzIGJlaGF2aW9yLCBhcHByZWNpYXRlIGlu
IGFkdmFuY2UgYW55IGluZm9ybWF0aW9uL2FkdmljZSENCj4NCj4gSSd2ZSBub3RpY2VkIHRoYXQg
d2hpbGUgdXNpbmcgcmFtb29wcyBhcyBhIGJhY2tlbmQgZm9yIHBzdG9yZSwgb25seSB0aGUNCj4g
Zmlyc3QgInJlY29yZF9zaXplIiBieXRlcyBvZiBkbWVzZyBpcyBjb2xsZWN0ZWQvc2F2ZWQgaW4g
c3lzZnMgb24gcGFuaWMuDQo+IEl0IGlzIHRoZSAiUGFydCAxIiBvZiBkbWVzZyAtIHNlZW1zIHRo
aXMgaXMgb24gcHVycG9zZSBbMF0sIHNvIEknbQ0KPiBjdXJpb3VzIG9uIHdoeSBjYW4ndCB3ZSBz
YXZlIHRoZSBmdWxsIGRtZXNnIHNwbGl0IGluIG11bHRpLXBhcnQgZmlsZXMsDQo+IGxpa2UgZWZp
LXBzdG9yZSBmb3IgZXhhbXBsZT8NCj4NCj4gSWYgdGhhdCdzIGFuIGludGVyZXN0aW5nIGlkZWEs
IEknbSB3aWxsaW5nIHRvIHRyeSBpbXBsZW1lbnRpbmcgdGhhdCBpbg0KPiBjYXNlIHRoZXJlIGFy
ZSBubyBhdmFpbGFibGUgcGF0Y2hlcyBmb3IgaXQgYWxyZWFkeSAobWF5YmUgc29tZWJvZHkNCj4g
d29ya2VkIG9uIGl0IGZvciB0aGVpciBvd24gdXNhZ2UpLiBNeSBpZGVhIHdvdWxkIGJlIHRvIGhh
dmUgYSB0dW5pbmcgdG8NCj4gZW5hYmxlIG9yIGRpc2FibGUgc3VjaCBuZXcgYmVoYXZpb3IsIGFu
ZCB3ZSBjb3VsZCBoYXZlIGZpbGVzIGxpa2UNCj4gImRtZXNnLXJhbW9vcHMtMC5wYXJ0WCIgYXMg
dGhlIHBhcnRpdGlvbnMgb2YgdGhlIGZ1bGwgImRtZXNnLXJhbW9vcHMtMCIuDQoNCkd1aWxoZXJt
ZSwNCg0KVGhlIGVmaSAoYW5kIGVyc3QpIGJhY2tlbmRzIGZvciBwc3RvcmUgaGF2ZSBzZXZlcmUg
bGltaXRhdGlvbnMgb24gdGhlIHNpemUNCm9mIG9iamVjdHMgdGhhdCBjYW4gc3RvcmUgKGp1c3Qg
YSBmZXcgS2J5dGVzKSBzbyBwc3RvcmUgYnJlYWtzIHRoZSBkbWVzZw0KZGF0YSBpbnRvIHBpZWNl
cy4NCg0KSSdtIG5vdCBzdXBlci1mYW1pbGlhciB3aXRoIGhvdyByYW1vb3BzIGJlaGF2ZXMsIGJ1
dCBtYXliZSBpdCBhbGxvd3Mgc2V0dGluZw0KYSBtdWNoIGxhcmdlciAicmVjb3JkX3NpemUiIC4u
LiBzbyB0aGlzIHNwbGl0IGlzbid0IG5lZWRlZD8NCg0KLVRvbnkNCg0K
