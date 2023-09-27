Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6410D7AFACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 08:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjI0GN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0GN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:13:58 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D19897;
        Tue, 26 Sep 2023 23:13:56 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:12:35
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:12:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: Clean up errors in xarray.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4f35bcee.861.18ad5449079.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD_VxxNlp+W9AA--.669W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAFEWFEYxtJMwAPs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEd1b0h1YSBD
aGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgveGFycmF5LmggfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3hhcnJheS5oIGIvaW5jbHVkZS9saW51eC94YXJyYXkuaApp
bmRleCBjYjU3MWRmY2Y0YjEuLjQ5MDkzNTdiN2UyYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC94YXJyYXkuaAorKysgYi9pbmNsdWRlL2xpbnV4L3hhcnJheS5oCkBAIC0yOTcsNyArMjk3LDcg
QEAgc3RydWN0IHhhcnJheSB7CiAJc3BpbmxvY2tfdAl4YV9sb2NrOwogLyogcHJpdmF0ZTogVGhl
IHJlc3Qgb2YgdGhlIGRhdGEgc3RydWN0dXJlIGlzIG5vdCB0byBiZSB1c2VkIGRpcmVjdGx5LiAq
LwogCWdmcF90CQl4YV9mbGFnczsKLQl2b2lkIF9fcmN1ICoJeGFfaGVhZDsKKwl2b2lkIF9fcmN1
ICp4YV9oZWFkOwogfTsKIAogI2RlZmluZSBYQVJSQVlfSU5JVChuYW1lLCBmbGFncykgewkJCQlc
Ci0tIAoyLjE3LjEK
