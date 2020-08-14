Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32D2446C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHNJIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 05:08:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgHNJIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:08:13 -0400
X-UUID: 78cb32c72773403db31525536ab039cb-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Uz5ripoV/+pUZcgYYnjGHaVEtX3lTJMQY1UuM8dECro=;
        b=Q8Iy3+0igqsaru66x1pWQmfZx9rUW7611iexjivvXFooJMbrTk3BQMjSjxdaCp9sa3iuGruzoE+EpKygf0EZKk57lUvp/J9bSEBrA44AGiy7SPlOqfYCQP5OH1UEVLmdCSfC1TwgIYU1JJd5uxRC0rASv4HquAIJrsuXkPUi5x8=;
X-UUID: 78cb32c72773403db31525536ab039cb-20200814
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1062976827; Fri, 14 Aug 2020 17:08:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 17:08:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 17:08:00 +0800
Message-ID: <1597396082.32469.58.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] mm: proc: smaps_rollup: do not stall write
 attempts on mmap_lock
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Michel Lespinasse <walken@google.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 14 Aug 2020 17:08:02 +0800
In-Reply-To: <CANN689FtCsC71cjAjs0GPspOhgo_HRj+diWsoU1wr98YPktgWg@mail.gmail.com>
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
         <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
         <CANN689FtCsC71cjAjs0GPspOhgo_HRj+diWsoU1wr98YPktgWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIwLTA4LTE0IGF0IDAxOjM1IC0wNzAwLCBNaWNoZWwgTGVzcGluYXNzZSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMTIsIDIwMjAgYXQgNzoxMyBQTSBDaGlud2VuIENoYW5nDQo+IDxj
aGlud2VuLmNoYW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gc21hcHNfcm9sbHVwIHdpbGwg
dHJ5IHRvIGdyYWIgbW1hcF9sb2NrIGFuZCBnbyB0aHJvdWdoIHRoZSB3aG9sZSB2bWENCj4gPiBs
aXN0IHVudGlsIGl0IGZpbmlzaGVzIHRoZSBpdGVyYXRpbmcuIFdoZW4gZW5jb3VudGVyaW5nIGxh
cmdlIHByb2Nlc3NlcywNCj4gPiB0aGUgbW1hcF9sb2NrIHdpbGwgYmUgaGVsZCBmb3IgYSBsb25n
ZXIgdGltZSwgd2hpY2ggbWF5IGJsb2NrIG90aGVyDQo+ID4gd3JpdGUgcmVxdWVzdHMgbGlrZSBt
bWFwIGFuZCBtdW5tYXAgZnJvbSBwcm9ncmVzc2luZyBzbW9vdGhseS4NCj4gPg0KPiA+IFRoZXJl
IGFyZSB1cGNvbWluZyBtbWFwX2xvY2sgb3B0aW1pemF0aW9ucyBsaWtlIHJhbmdlLWJhc2VkIGxv
Y2tzLCBidXQNCj4gPiB0aGUgbG9jayBhcHBsaWVkIHRvIHNtYXBzX3JvbGx1cCB3b3VsZCBiZSB0
aGUgY29hcnNlIHR5cGUsIHdoaWNoIGRvZXNuJ3QNCj4gPiBhdm9pZCB0aGUgb2NjdXJyZW5jZSBv
ZiB1bnBsZWFzYW50IGNvbnRlbnRpb24uDQo+ID4NCj4gPiBUbyBzb2x2ZSBhZm9yZW1lbnRpb25l
ZCBpc3N1ZSwgd2UgYWRkIGEgY2hlY2sgd2hpY2ggZGV0ZWN0cyB3aGV0aGVyDQo+ID4gYW55b25l
IHdhbnRzIHRvIGdyYWIgbW1hcF9sb2NrIGZvciB3cml0ZSBhdHRlbXB0cy4NCj4gDQo+IEkgdGhp
bmsgeW91ciByZXRyeSBtZWNoYW5pc20gc3RpbGwgZG9lc24ndCBoYW5kbGUgYWxsIGNhc2VzLiBX
aGVuIHlvdQ0KPiBnZXQgYmFjayB0aGUgbW1hcCBsb2NrLCB0aGUgYWRkcmVzcyB3aGVyZSB5b3Ug
c3RvcHBlZCBsYXN0IHRpbWUgY291bGQNCj4gbm93IGJlIGluIHRoZSBtaWRkbGUgb2YgYSB2bWEu
IEkgdGhpbmsgdGhlIGNvbnNpc3RlbnQgdGhpbmcgdG8gZG8gaW4NCj4gdGhhdCBjYXNlIHdvdWxk
IGJlIHRvIHJldHJ5IHNjYW5uaW5nIGZyb20gdGhlIGFkZHJlc3MgeW91IHN0b3BwZWQgYXQsDQo+
IGV2ZW4gaWYgaXQncyBub3Qgb24gYSB2bWEgYm91bmRhcnkgYW55bW9yZS4gWW91IG1heSBoYXZl
IHRvIGNoYW5nZQ0KPiBzbWFwX2dhdGhlcl9zdGF0cyB0byBzdXBwb3J0IHRoYXQsIHRob3VnaC4N
Cg0KSGkgTWljaGVsLA0KDQpJIHRoaW5rIEkgZ290IHlvdXIgcG9pbnQuIExldCBtZSB0cnkgdG8g
cHJlcGFyZSBuZXcgcGF0Y2ggc2VyaWVzIGZvcg0KZnVydGhlciByZXZpZXdzLg0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbiA6KQ0KDQpDaGlud2VuDQo=

