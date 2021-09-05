Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52951400E67
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhIEGNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 02:13:21 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:51661
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S235327AbhIEGNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 02:13:20 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2021 02:13:19 EDT
Received: by ajax-webmail-sr0414.icoremail.net (Coremail) ; Sun, 5 Sep 2021
 14:12:13 +0800 (GMT+08:00)
X-Originating-IP: [20.89.104.164]
Date:   Sun, 5 Sep 2021 14:12:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Report Bug to Linux File System
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210401(fdb522e2)
 Copyright (c) 2002-2021 www.mailtech.cn icmhosting
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2a299595.245.17bb495fbfa.Coremail.nzyang@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHim69XzRh02oFAA--.227W
X-CM-SenderInfo: pq21t0vj6v33wo0lvxldqovvfxof0/1tbiAQIBClwR-kYxlAACsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIG91ciB0ZWFtIGhhcyBmb3VuZCBhIHByb2JsZW0gaW4gZnMgc3lzdGVtIG9uIExpbnV4IGtl
cm5lbCB2NS4xMCwgbGVhZGluZyB0byBEb1MgYXR0YWNrcy4KClRoZSBzdHJ1Y3QgZmlsZSBjYW4g
YmUgZXhoYXVzdGVkIGJ5IG5vcm1hbCB1c2VycyBieSBjYWxsaW5nIG11bHRpcGxlIHN5c2NhbGxz
IHN1Y2ggYXMgdGltZXJmZF9jcmVhdGUvcGlwZS9vcGVuIGV0Yy4gQWx0aG91Z2ggdGhlIHJsaW1p
dCBsaW1pdHMgdGhlIG1heCBmZHMgY291bGQgYmUgb3BlbmVkIGJ5IGEgc2luZ2xlIHByb2Nlc3Mu
IEEgbm9ybWFsIHVzZXIgY2FuIGZvcmsgbXVsdGlwbGUgcHJvY2Vzc2VzLCByZXBlYXRlZGx5IG1h
a2UgdGhlIHRpbWVyZmRfY3JlYXRlL3BpcGUvb3BlbiBzeXNjYWxscyBhbmQgZXhoYXVzdCBhbGwg
c3RydWN0IGZpbGVzLiBBcyBhIHJlc3VsdCwgYWxsIHN0cnVjdC1maWxlLWFsbG9jYXRpb24gcmVs
YXRlZCBvcGVyYXRpb25zIG9mIGFsbCBvdGhlciB1c2VycyB3aWxsIGZhaWwuCgpJbiBmYWN0LCB3
ZSB0cnkgdGhpcyBhdHRhY2sgaW5zaWRlIGEgZGVwcml2aWxlZ2VkIGRvY2tlciBjb250YWluZXIg
d2l0aG91dCBhbnkgY2FwYWJpbGl0aWVzLiBUaGUgcHJvY2Vzc2VzIGluIHRoZSBkb2NrZXIgY2Fu
IGV4aGF1c3QgYWxsIHN0cnVjdC1maWxlIG9uIHRoZSBob3N0IGtlcm5lbC4gV2UgdXNlIGEgbWFj
aGluZSB3aXRoIDE2RyBtZW1vcnkuIFdlIHN0YXJ0IDIwMDAgcHJvY2Vzc2VzLCBlYWNoIHByb2Nl
c3Mgd2l0aCBhIDEwMjQgbGltaXQuIEluIHRvdGFsLCBhcm91bmQgMTYxMzQwMCBudW1iZXIgc3Ry
dWN0LWZpbGUgYXJlIGNvbnN1bWVkIGFuZCB0aGVyZSBhcmUgbm8gYXZhaWxhYmxlIHN0cnVjdC1m
aWxlIGluIHRoZSBrZXJuZWwuIFRoZSB0b3RhbCBjb25zdW1lZCBtZW1vcnkgaXMgbGVzcyB0aGFu
IDJHICwgd2hpY2ggaXMgc21hbGwsIHNvIG1lbW9yeSBjb250cm9sIGdyb3VwIGNhbiBub3QgaGVs
cC4KClRoZSBmb2xsb3dpbmcgY29kZSBzaG93cyBhIFBvQyB0aGF0IHRha2VzIDE2MTM0MDAgbnVt
YmVyIG9mIHN0cnVjdC1maWxlLCB3aGlsZSB0YWtlIGFsbCBzdHJ1Y3QtZmlsZSBvbiBob3N0LiBX
ZSBldmFsdWF0ZSB0aGUgUG9DIG9uIGludGVsIGk1IENQVSBwaHlzaWNhbCBtYWNoaW5lICsgTGlu
dXgga2VybmVsIHY1LjEwLjAgKyBVYnVudHUgMTguMDQgTFRTICsgRG9ja2VyIDE4LjA2LjAtY2Uu
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiNpbmNsdWRl
PHN0ZGlvLmg+CiNpbmNsdWRlPHN0ZGxpYi5oPgojaW5jbHVkZTx1bmlzdGQuaD4KI2luY2x1ZGU8
ZmNudGwuaD4KCgppbnQgbWFpbigpCnsKICAgIGZvciAoaW50IGkgPSAxOyBpIDwgMjAwMDsgaSsr
KSB7CiAgICAgICAgaW50IHBpZCA9IGZvcmsoKTsgCiAgICAgICAgaWYgKHBpZCA9PSAwKSB7CiAg
ICAgICAgICAgIGludCBmZDsKICAgICAgICAgICAgY2hhciBuYW1lb3V0WzIwXTsKICAgICAgICAg
ICAgZm9yIChpbnQgaiA9IDE7IGogPD0gMTAyMDsgaisrKSB7CiAgICAgICAgICAgICAgICBzcHJp
bnRmKG5hbWVvdXQsICJ0ZXN0JmQmZC50eHQiLCBpLCBqKTsKICAgICAgICAgICAgICAgIGZkID0g
b3BlbihuYW1lb3V0LCBPX0NSRUFUKTsKICAgICAgICAgICAgfQogICAgICAgICAgICBnZXRjaGFy
KCk7CiAgICAgICAgfQogICAgfQogICAgZ2V0Y2hhcigpOwogICAgcmV0dXJuIDA7Cn0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkxvb2tpbmcgZm9yd2Fy
ZCB0byB5b3VyIHJlcGx5IQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5hbnppIFlhbmcK
