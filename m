Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4C1FFEF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 01:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgFRXw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 19:52:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:25986 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgFRXw5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:52:57 -0400
IronPort-SDR: uDOPNHYfi4qTqIXjXZjw7Cu86/A23iRzosn9seIqujPcbL5aYI/ZFa7xKGhd2OZ/tPq7vLU2xm
 6fjt5QFcJHIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="144277058"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="144277058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 16:52:56 -0700
IronPort-SDR: psbdkD+6G/wejZSYFjX2b12pA6Cvb92ATM+V8uo5Sy3j3bL+kmDD4janj2vXNpCtz6JP3LlhGQ
 tWPdFZZ31U9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="477430092"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 16:52:55 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 16:52:55 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.209]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.235]) with mapi id 14.03.0439.000;
 Thu, 18 Jun 2020 16:52:55 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Parallel compilation performance regression
Thread-Topic: Parallel compilation performance regression
Thread-Index: AQHWRcuWKh0BKGrzv0a8mEFl49sTbQ==
Date:   Thu, 18 Jun 2020 23:52:55 +0000
Message-ID: <a1bafab884bb60250840a8721b78f4b5d3a6c2ed.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.71.254]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BE1FE02EA899048B1B7FFDBD939B4A4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRGF2aWQsDQoNCkkndmUgYmVlbiBleHBlcmllbmNpbmcgYSBwZXJmb3JtYW5jZSByZWdyZXNz
aW9uIHdoZW4gcnVubmluZyBhIHBhcmFsbGVsDQpjb21waWxhdGlvbiAoZWcsIG1ha2UgLWo3Mikg
b24gcmVjZW50IGtlcm5lbHMuDQoNCkkgYmlzZWN0ZWQgaXQgdG8gdGhpcyBjb21taXQ6DQoNCmNv
bW1pdCBiNjY3Yjg2NzM0NDMwMWUyNGYyMWQ0YTRjODQ0Njc1ZmY2MWQ4OWUxDQpBdXRob3I6IERh
dmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+DQpEYXRlOiAgIFR1ZSBTZXAgMjQgMTY6
MDk6MDQgMjAxOSArMDEwMA0KDQogICAgcGlwZTogQWR2YW5jZSB0YWlsIHBvaW50ZXIgaW5zaWRl
IG9mIHdhaXQgc3BpbmxvY2sgaW4gcGlwZV9yZWFkKCkNCiAgICANCiAgICBBZHZhbmNlIHRoZSBw
aXBlIHJpbmcgdGFpbCBwb2ludGVyIGluc2lkZSBvZiB3YWl0IHNwaW5sb2NrIGluIHBpcGVfcmVh
ZCgpDQogICAgc28gdGhhdCB0aGUgcGlwZSBjYW4gYmUgd3JpdHRlbiBpbnRvIHdpdGgga2VybmVs
IG5vdGlmaWNhdGlvbnMgZnJvbQ0KICAgIGNvbnRleHRzIHdoZXJlIHBpcGUtPm11dGV4IGNhbm5v
dCBiZSB0YWtlbi4NCiAgICANCg0KUHJpb3IgdG8gdGhpcyBjb21taXQgSSBnb3QgNzAlIG9yIHNv
IHRocmVhZCBzYXR1cmF0aW9uIG9mIGNjMSBhbmQgYWZ0ZXINCml0IHJhcmVseSBnZXRzIGFib3Zl
IDE1JSBhbmQgd291bGQgb2Z0ZW4gZHJvcCBkb3duIHRvIDEtMiB0aHJlYWRzLiBJdA0KZG9lc24n
dCBsb29rIGxpa2UgYSBjbGVhbiByZXZlcnQgZWl0aGVyLiBMb29raW5nIGF0IHVwc3RyZWFtLCBp
dCBzZWVtcw0KdGhhdCBzb21lIGxhdGVyIGNvZGUgY2hhbmdlZCB0aGUgd2FrZXVwLiBJJ20gbm90
IHJlYWxseSBzdXJlIGhvdyB0aGlzDQphbGwgZml0cyBpbnRvIHBhcmFsbGVsaXplZCBtYWtlLg0K
DQpCZXN0DQpKb24NCg==
