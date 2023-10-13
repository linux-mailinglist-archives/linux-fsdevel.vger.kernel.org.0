Return-Path: <linux-fsdevel+bounces-238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BD7C7C14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 05:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B218F1C21034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3E110C;
	Fri, 13 Oct 2023 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA210FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 03:29:08 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2F0AB7;
	Thu, 12 Oct 2023 20:29:06 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:27:22
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date: Fri, 13 Oct 2023 11:27:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysctl: Clean up errors in sysctl.h
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
Message-ID: <5bd0e3f4.947.18b2713112b.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwDXaD4auShlmdjBAA--.624W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAUsQ
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvc3lzY3RsLmggfCA0
ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zeXNjdGwuaCBiL2luY2x1ZGUvbGludXgvc3lzY3Rs
LmgKaW5kZXggMDlkNzQyOWQ2N2MwLi4zZDZlNWQ2ZTJiZDAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvc3lzY3RsLmgKKysrIGIvaW5jbHVkZS9saW51eC9zeXNjdGwuaApAQCAtMjMyLDcgKzIz
Miw3IEBAIHN0cnVjdCBjdGxfdGFibGVfaGVhZGVyICpfX3JlZ2lzdGVyX3N5c2N0bF90YWJsZSgK
IAljb25zdCBjaGFyICpwYXRoLCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgc2l6ZV90IHRhYmxl
X3NpemUpOwogc3RydWN0IGN0bF90YWJsZV9oZWFkZXIgKnJlZ2lzdGVyX3N5c2N0bF9zeihjb25z
dCBjaGFyICpwYXRoLCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKIAkJCQkJICAgIHNpemVfdCB0
YWJsZV9zaXplKTsKLXZvaWQgdW5yZWdpc3Rlcl9zeXNjdGxfdGFibGUoc3RydWN0IGN0bF90YWJs
ZV9oZWFkZXIgKiB0YWJsZSk7Cit2b2lkIHVucmVnaXN0ZXJfc3lzY3RsX3RhYmxlKHN0cnVjdCBj
dGxfdGFibGVfaGVhZGVyICp0YWJsZSk7CiAKIGV4dGVybiBpbnQgc3lzY3RsX2luaXRfYmFzZXMo
dm9pZCk7CiBleHRlcm4gdm9pZCBfX3JlZ2lzdGVyX3N5c2N0bF9pbml0KGNvbnN0IGNoYXIgKnBh
dGgsIHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLApAQCAtMjc0LDcgKzI3NCw3IEBAIHN0YXRpYyBp
bmxpbmUgc3RydWN0IGN0bF90YWJsZV9oZWFkZXIgKnJlZ2lzdGVyX3N5c2N0bF9zeihjb25zdCBj
aGFyICpwYXRoLAogCXJldHVybiBOVUxMOwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgdW5yZWdp
c3Rlcl9zeXNjdGxfdGFibGUoc3RydWN0IGN0bF90YWJsZV9oZWFkZXIgKiB0YWJsZSkKK3N0YXRp
YyBpbmxpbmUgdm9pZCB1bnJlZ2lzdGVyX3N5c2N0bF90YWJsZShzdHJ1Y3QgY3RsX3RhYmxlX2hl
YWRlciAqdGFibGUpCiB7CiB9CiAKLS0gCjIuMTcuMQo=

