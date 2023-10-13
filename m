Return-Path: <linux-fsdevel+bounces-239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBBA7C7C38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 05:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79B41C20F2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C615D0;
	Fri, 13 Oct 2023 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F71108
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 03:38:10 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B44EA9;
	Thu, 12 Oct 2023 20:38:08 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:36:24
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date: Fri, 13 Oct 2023 11:36:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] kallsyms: Clean up errors in module.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4819dee9.948.18b271b53e5.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwC3VUA4uyhl2djBAA--.664W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAZsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
	T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L21vZHVs
ZS5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmggYi9pbmNsdWRlL2xpbnV4
L21vZHVsZS5oCmluZGV4IGE5OGUxODhjZjM3Yi4uNDhhZWJlYTcyZDNhIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L21vZHVsZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKQEAgLTE1
Miw3ICsxNTIsNyBAQCBleHRlcm4gdm9pZCBjbGVhbnVwX21vZHVsZSh2b2lkKTsKICNkZWZpbmUg
X19pbml0Y29uc3Rfb3JfbW9kdWxlCiAjZGVmaW5lIF9fSU5JVF9PUl9NT0RVTEUJLnRleHQKICNk
ZWZpbmUgX19JTklUREFUQV9PUl9NT0RVTEUJLmRhdGEKLSNkZWZpbmUgX19JTklUUk9EQVRBX09S
X01PRFVMRQkuc2VjdGlvbiAiLnJvZGF0YSIsImEiLCVwcm9nYml0cworI2RlZmluZSBfX0lOSVRS
T0RBVEFfT1JfTU9EVUxFCS5zZWN0aW9uICIucm9kYXRhIiwgImEiLCAlcHJvZ2JpdHMKICNlbHNl
CiAjZGVmaW5lIF9faW5pdF9vcl9tb2R1bGUgX19pbml0CiAjZGVmaW5lIF9faW5pdGRhdGFfb3Jf
bW9kdWxlIF9faW5pdGRhdGEKQEAgLTgwMiw3ICs4MDIsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wg
d2l0aGluX21vZHVsZSh1bnNpZ25lZCBsb25nIGFkZHIsIGNvbnN0IHN0cnVjdCBtb2R1bGUgKm1v
ZCkKIH0KIAogLyogR2V0L3B1dCBhIGtlcm5lbCBzeW1ib2wgKGNhbGxzIHNob3VsZCBiZSBzeW1t
ZXRyaWMpICovCi0jZGVmaW5lIHN5bWJvbF9nZXQoeCkgKHsgZXh0ZXJuIHR5cGVvZih4KSB4IF9f
YXR0cmlidXRlX18oKHdlYWssdmlzaWJpbGl0eSgiaGlkZGVuIikpKTsgJih4KTsgfSkKKyNkZWZp
bmUgc3ltYm9sX2dldCh4KSAoeyBleHRlcm4gdHlwZW9mKHgpIHggX19hdHRyaWJ1dGVfXygod2Vh
aywgdmlzaWJpbGl0eSgiaGlkZGVuIikpKTsgJih4KTsgfSkKICNkZWZpbmUgc3ltYm9sX3B1dCh4
KSBkbyB7IH0gd2hpbGUgKDApCiAjZGVmaW5lIHN5bWJvbF9wdXRfYWRkcih4KSBkbyB7IH0gd2hp
bGUgKDApCiAKLS0gCjIuMTcuMQo=

