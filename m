Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3773B20157C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394737AbgFSQWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 12:22:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:44716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390605AbgFSO77 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:59:59 -0400
IronPort-SDR: s9Ln8jwyzbYMCwryS+Kw6gomDxvowyIMB8rsXXgpD2c7CJDk/BInl/WbCPaKziBiNPPDo8xl8w
 H3OYTBH8QKUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122705944"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="122705944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:59:59 -0700
IronPort-SDR: /T6ngN+opaAFXMejP3TTq62vo8pm+WnfTUYczWbNBvC4xRqN1aZ7ku9HDnlgBbpoo7JBSjH8x7
 S2IChbxjWy/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="352743642"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2020 07:59:59 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.209]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Fri, 19 Jun 2020 07:59:59 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: Parallel compilation performance regression
Thread-Topic: Parallel compilation performance regression
Thread-Index: AQHWRcuWKh0BKGrzv0a8mEFl49sTbajflSCAgADpOYA=
Date:   Fri, 19 Jun 2020 14:59:58 +0000
Message-ID: <bf968a2887536459293eaeb40d354fb365b1438d.camel@intel.com>
References: <a1bafab884bb60250840a8721b78f4b5d3a6c2ed.camel@intel.com>
         <20200619010513.GW8681@bombadil.infradead.org>
In-Reply-To: <20200619010513.GW8681@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.131.127]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A74B23BC1E18E46A84DF283D16CBD32@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDE4OjA1IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVGh1LCBKdW4gMTgsIDIwMjAgYXQgMTE6NTI6NTVQTSArMDAwMCwgRGVycmljaywgSm9u
YXRoYW4gd3JvdGU6DQo+ID4gSGkgRGF2aWQsDQo+ID4gDQo+ID4gSSd2ZSBiZWVuIGV4cGVyaWVu
Y2luZyBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gd2hlbiBydW5uaW5nIGEgcGFyYWxsZWwNCj4g
PiBjb21waWxhdGlvbiAoZWcsIG1ha2UgLWo3Mikgb24gcmVjZW50IGtlcm5lbHMuDQo+IA0KPiBJ
IGJldCB5b3UncmUgdXNpbmcgYSB2ZXJzaW9uIG9mIG1ha2Ugd2hpY2ggcHJlZGF0ZXMgNC4zOg0K
PiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MGRkYWQyMWQzZTk5Yzc0M2EzYWE0NzMxMjFkYzU1
NjE2NzllMjZiYg0KPiANCg0KSSBhbSENCg0KIyBtYWtlIC0tdmVyc2lvbg0KR05VIE1ha2UgNC4y
LjENCg0KDQpUaGFuayB5b3UgTWF0dGhldyENCg==
