Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF54400E6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 08:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhIEGcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 02:32:23 -0400
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net ([138.197.184.20]:57389
        "HELO zg8tmtm4lje5ny4xodqumjaa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234206AbhIEGcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 02:32:22 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2021 02:32:22 EDT
Received: by ajax-webmail-sr0414.icoremail.net (Coremail) ; Sun, 5 Sep 2021
 14:31:06 +0800 (GMT+08:00)
X-Originating-IP: [20.89.104.164]
Date:   Sun, 5 Sep 2021 14:31:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Report Bug to Linux File System about fs/devpts
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210401(fdb522e2)
 Copyright (c) 2002-2021 www.mailtech.cn icmhosting
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2f73b89f.266.17bb4a7478b.Coremail.nzyang@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBXHnIrZDRht5sFAA--.323W
X-CM-SenderInfo: pq21t0vj6v33wo0lvxldqovvfxof0/1tbiAQMBClwR-kYyYgAAss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIG91ciB0ZWFtIGhhcyBmb3VuZCBhIHByb2JsZW0gaW4gZnMgc3lzdGVtIG9uIExpbnV4IGtl
cm5lbCB2NS4xMCwgbGVhZGluZyB0byBEb1MgYXR0YWNrcy4KClRoZSBwc2V1ZG8tdGVybWluYWxz
IGNhbiBiZSBvcGVuZWQgYnkgbm9ybWFsIHVzZXIgY2FuIGJlIGV4aGF1c3RlZCBieSBvbmUgc2lu
Z2FsIG5vcm1hbCB1c2VyIGJ5IGNhbGxpbmcgc3lzY2FsbCBzdWNoIGFzIG9wZW4uIEEgbm9ybWFs
IHVzZXIga2VlcHMgb3BlbmluZy9kZXYvcHRteCB0byB0cmlnZ2VyIHB0bXhfb3Blbiwgd2hpY2gg
Y2FsbHMgZGV2cHRzX25ld19pbmRleCBhbmQgaW5jcmVhc2VzIHB0eV9jb3VudC4gSW4gYSBjb3Vw
bGUgb2Ygc2Vjb25kcywgdGhlIHB0eV9jb3VudCBsaW1pdCBpcyByZWFjaGVkLCBhbmQgb3RoZXIg
bm9ybWFsIHVzZXLigJlzIHB0bXhfb3BlbiBvcGVyYXRpb25zIGZhaWwuCgpJbiBmYWN0LCB3ZSB0
cnkgdGhpcyBhdHRhY2sgaW5zaWRlIGEgZGVwcml2aWxlZ2VkIGRvY2tlciBjb250YWluZXIgd2l0
aG91dCBhbnkgY2FwYWJpbGl0aWVzLiBUaGUgcHJvY2Vzc2VzIGluIHRoZSBkb2NrZXIgY2FuIGV4
aGF1c3QgYWxsIG5vcm1hbCB1c2Vy4oCZcyBwc2V1ZG8tdGVybWluYWxzIG9uIHRoZSBob3N0IGtl
cm5lbC4gV2UgdXNlIGEgbWFjaGluZSB3aXRoIDE2RyBtZW1vcnkuIFdlIHN0YXJ0IDQgcHJvY2Vz
c2VzIHRvIG9wZW4gL2Rldi9wdG14IHJlcGVhdGVkbHkuIEluIHRvdGFsLCBhcm91bmQgMzA3MiBu
dW1iZXIgb2YgcHNldWRvLXRlcm1pbmFscyBhcmUgY29uc3VtZWQgYW5kIG90aGVyIG5vcm1hbCB1
c2VyIGNhbiBub3QgdXNlIHBzZXVkby10ZXJtaW5hbHMuIAoKVGhlIGNvbnNlcXVlbmNlcyBhcmUg
c2V2ZXJlIGFzIHB0eSBkZXZpY2VzIGFyZSB3aWRlbHkgdXNlZCBieSB2YXJpb3VzIGFwcGxpY2F0
aW9ucyBzdWNoIGFzIFNTSCBjb25uZWN0aW9uLiBBcyBhIHJlc3VsdCwgYWxsIFNTSCBjb25uZWN0
aW9uIGF0dGVtcHRzIHRvIGFueSBvdGhlciBjb250YWluZXIgd2lsbCBmYWlsIGR1ZSB0byB0aGUg
ZmFpbGVkIHBzZXVkby10ZXJtaW5hbC1vcGVuLiBFdmVuIHdvcnNlLCB0aGUgaG9zdC1tYWNoaW5l
IGNhbm5vdCBzdGFydCBhbnkgbmV3IGNvbnRhaW5lcnMsIGFzIHRoZSBjb25uZWN0aW9ucyB0byBh
IG5ldyBjb250YWluZXIgYXJlIGRlbmllZCBkdWUgdG8gdGhlIHNhbWUgZXJyb3IuCgpUaGUgZm9s
bG93aW5nIGNvZGUgc2hvd3MgYSBQb0MgdGhhdCB0YWtlcyAzMDcyIG51bWJlciBvZiBwc2V1ZG8t
dGVybWluYWxzLCB3aGlsZSBvdGhlciBub3JtYWwgdXNlciBjYW4gbm90IHVzZSBwc2V1ZG8tdGVy
bWluYWxzLiBXZSBldmFsdWF0ZSB0aGUgUG9DIG9uIGludGVsIGk1IENQVSBwaHlzaWNhbCBtYWNo
aW5lICsgTGludXgga2VybmVsIHY1LjEwLjAgKyBVYnVudHUgMTguMDQgTFRTICsgRG9ja2VyIDE4
LjA2LjAtY2UuCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiNpbmNsdWRlPHN0ZGlvLmg+CiNkZWZpbmUgX1hPUEVOX1NPVVJDRQojaW5jbHVkZTxzdGRsaWIu
aD4KI2luY2x1ZGU8dW5pc3RkLmg+CiNpbmNsdWRlPHN5cy90eXBlcy5oPgojaW5jbHVkZTxzeXMv
c3RhdC5oPgojaW5jbHVkZTxmY250bC5oPgojaW5jbHVkZTxzeXMvaW9jdGwuaD4KCmludCBtYWlu
KCl7CiAgICBmb3IoaW50IGo9MDtqPD00O2orKyl7CiAgICAgICAgaW50IHBpZCA9IGZvcmsoKTsK
ICAgICAgICBpZihwaWQgPT0gMCl7CiAgICAgICAgICAgIGZvcihpbnQgaT0wOztpKyspewogICAg
ICAgICAgICAgICAgaW50IG1mZCA9IG9wZW4oIi9kZXYvcHRteCIsT19SRFdSKTsKICAgICAgICAg
ICAgfQogICAgICAgICAgICBzbGVlcCgxMDAwKTsKICAgICAgICB9CiAgICB9CgogICAgc2xlZXAo
MTAwMDApOwogICAgcmV0dXJuIDA7Cn0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5IQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE5hbnppIFlhbmcK
