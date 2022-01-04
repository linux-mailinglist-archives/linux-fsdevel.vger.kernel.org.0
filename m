Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2333C484806
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiADSqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 13:46:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:8097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235760AbiADSqE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641321963; x=1672857963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g0ZcKJFZgmRMr233dJxlXK1q6yi4YxrDIR4D4biNHjA=;
  b=k6atAjlMPDbFh/TfX7UAxe6jtcuRAKvU0Vm1XxjY3Wgvf5GHOz43Pf/S
   3TBL62E+dTacSt2I1PWBYmRuKbKdp7pE9r+vmWBzbF7dXPArDQ8nLDSGe
   oZ4ZB3wavU0NdnGauKAxKU512liQgoCUxY7Eg6fy3df2EtK7is628aRzy
   B9rGODPaNZRyjTsPZFSxmpoBLDiCFCHfpBly0NhylWgiBoP6q1/yeU2e1
   UKJXCGuAgfC3wlChTvbzmOfDWEIuaGIDrytJlDEAvQFTcpDV1MyKPgleE
   fWOwQDi6uvJmimCobzO5fnx9y+Q5zmqO3V64Q/KoNgs13mHEUI316Wzzx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239817975"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="239817975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 10:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="470252713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 10:46:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 10:46:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 10:46:01 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Tue, 4 Jan 2022 10:46:01 -0800
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
Thread-Index: AQHX/MKP8AekIclEL0GvU4ZDFIVyq6xR+V6AgAFdcoD//8ds4IAAmToA//+EJJA=
Date:   Tue, 4 Jan 2022 18:46:01 +0000
Message-ID: <8675f69c1643451b91f797b114dfc311@intel.com>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
 <2d1e9afa38474de6a8b1efc14925d095@intel.com>
 <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
 <a361c64213e7474ea39c97f7f7bd26ec@intel.com>
 <c5a04638-90c2-8ec0-4573-a0e5d2e24b6b@igalia.com>
In-Reply-To: <c5a04638-90c2-8ec0-4573-a0e5d2e24b6b@igalia.com>
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

PiBUaGVyZSBsaWVzIHRoZSBpc3N1ZTogaWYgSSBzZXQgcGFuaWNfcHJpbnQgdG8gZHVtcCBhbGwg
YmFja3RyYWNlcywgdGFzaw0KPiBpbmZvIGFuZCBtZW1vcnkgc3RhdGUgaW4gYSBwYW5pYyBldmVu
dCwgdGhhdCBpbmZvcm1hdGlvbiArIHRoZQ0KPiBwYW5pYy9vb3BzIGFuZCBzb21lIHByZXZpb3Vz
IHJlbGV2YW50IHN0dWZmLCBkb2VzIGl0IGFsbCBmaXQgaW4gdGhlIDJNDQo+IGNodW5rPyBMaWtl
bHkgc28sIGJ1dCAqaWYgaXQgZG9lc24ndCBmaXQqLCB3ZSBtYXkgbG9zZSBfZXhhY3RseV8gdGhl
DQo+IG1vc3QgaW1wb3J0YW50IHBpZWNlLCB3aGljaCBpcyB0aGUgcGFuaWMgY2F1c2UuDQoNClRo
YXQgZG9lcyBjaGFuZ2UgdGhpbmdzIC4uLiBJIHdvbmRlciBob3cgbWFueSBtZWdhYnl0ZXMgeW91
IG5lZWQNCmZvciBhIGJpZyBzeXN0ZW0gKGh1bmRyZWRzIG9mIGNvcmVzLCB0aG91c2FuZHMgb2Yg
dGFza3MpIQ0KDQpUaGlzIHVzZSBjYXNlIGRvZXMgbG9vayBsaWtlIGl0IGNvdWxkIHVzZSBtdWx0
aXBsZSBjaHVua3MgaW4gcmFtb29wcy4NCg0KLVRvbnkNCg==
