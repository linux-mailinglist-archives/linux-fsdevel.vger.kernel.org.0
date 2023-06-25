Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CC73CF33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFYIGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjFYIGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:06:40 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A7DEE52
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 01:06:39 -0700 (PDT)
Received: from lizhi16$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app2
 (Coremail) ; Sun, 25 Jun 2023 16:06:25 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Sun, 25 Jun 2023 16:06:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2O5b+X?= <lizhi16@hust.edu.cn>
To:     linux-fsdevel@vger.kernel.org
Cc:     yangzhi.lwj@antgroup.com
Subject: [PATCH -0/1] Enhancing VFS isolation
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5f10d2c3.20893.188f19701f9.Coremail.lizhi16@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GQEQrADHm_SB9Zdk5ZHKBg--.50417W
X-CM-SenderInfo: asqsjiarqqkko6kx23oohg3hdfq/1tbiAQoNA2SX3VoKfAAEsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RGVhciBhbGwsCgpEZWFyIGFsbCwKCkluIHRoZSBwYXN0IDYgeWVhcnMsIGEgdHlwZSBvZiBwYXRo
IG1pc3Jlc29sdXRpb24gcmlza3MgaGF2ZSBwZXJzaXN0ZWQgb24gbmVhcmx5IGFsbCBjb250YWlu
ZXIgdG9vbHMgKGUuZy4sIERvY2tlciwgUG9kbWFuLCBLdWJlcm5ldGVzIGFuZCBldGMuKSBhbmQg
YXJlIHJlc3BvbnNpYmxlIGZvciBuZWFybHkgaGFsZiBvZiB0aGUgMjcgaGlnaC1zZXZlcml0eSB2
dWxuZXJhYmlsaXRpZXMuIFNwZWNpZmljYWxseSwgZHVyaW5nIHRoZSBjb250YWluZXIgdG9vbHMn
IGludGVyYWN0aW9uIHdpdGggdGhlIGNvbnRhaW5lcuKAmXMgZmlsZXN5c3RlbSwgdGhlIGNvbnRh
aW5lciB0b29scyB3aXRoIHRoZSBob3N0J3Mgcm9vdCBwcml2aWxlZ2UgbWlnaHQgYmUgaW5kdWNl
ZCB0byBleGVjdXRlIGFuIGlsbGVnYWwgZmlsZSBpbiB0aGUgbWFsaWNpb3VzIGNvbnRhaW5lciAo
ZS5nLiwgQ1ZFLTIwMTktMTQyNzEpIG9yIGNoZWF0ZWQgdG8gcmVzb2x2ZSBhIG1hbGljaW91cyBz
eW1saW5rIGJlbG9uZ2luZyB0byBhIGNvbnRhaW5lciBpbnRvIHRoZSBvdXRzaWRlIG9mIHRoZSBj
b250YWluZXIgKGUuZy4sIENWRS0yMDE3LTEwMDIxMDEpLiBUaGUgcHJvYmxlbSBjb21lcyBmcm9t
IHRvZGF5J3Mg4oCcb25lLXdheeKAnSBpc29sYXRpb24gb2YgdGhlIGluLWNvbnRhaW5lciBmaWxl
c3lzdGVtOiBhbHRob3VnaCB0aGUgaG9zdCdzIHJlc291cmNlcyBvdXRzaWRlIHRoZSBjb250YWlu
ZXIgZmlsZXN5c3RlbSBpcyBpbnZpc2libGUgdG8gdGhlIGNvbnRhaW5lcml6ZWQgYXBwbGljYXRp
b24sIHRoZSBob3N0IGV4ZWN1dGFibGVzIChpbmNsdWRpbmcgdGhlIGNvbnRhaW5lciB0b29sIGFu
ZCB0aGUgY29tcG9uZW50cyBpdCBkZXBlbmRzIG9uKSBkb2VzIG5vdCBzZWUgYW55IGNvbnN0cmFp
bnRzIGluIHZpc2l0aW5nIHRoZSBpbi1jb250YWluZXIgZmlsZXN5c3RlbS4KCgpXZSBmaW5kIHRo
YXQgdGhpcyBzZWN1cml0eSByaXNrIGNhbm5vdCBiZSBlZmZlY3RpdmVseSBjb250cm9sbGVkIGlu
IHRoZSB1c2VybGFuZCwgYnkgdGhlIGNvbnRhaW5lciB0b29scy4gVGhlIGV4aXN0aW5nIHZ1bG5l
cmFiaWxpdGllcyBzaG93IHRoYXQgdGhlIHRoaXJkLXBhcnR5IGNvbXBvbmVudHMgY2FsbGVkIGJ5
IHRoZSBjb250YWluZXIgdG9vbHMgdXN1YWxseSBicmVhayB0aGlzIGtpbmQgb2YgY29udHJvbCB1
bmludGVudGlvbmFsbHkuIFRodXMsIGtlcm5lbC1iYXNlZCBmaWxlc3lzdGVtIGlzb2xhdGlvbiBi
ZWNvbWVzIHRoZSBvbmx5IHZpYWJsZSBzb2x1dGlvbiB0byBjb21wcmVoZW5zaXZlbHkgbWVkaWF0
aW5nIGZpbGVzeXN0ZW0gYWNjZXNzZXMgZnJvbSBkaWZmZXJlbnQga2luZHMgb2YgdGhpcmQtcGFy
dHkgY29tcG9uZW50cyB0byBlbnN1cmUgaXNvbGF0aW9uIGlzIGFsd2F5cyBpbiBwbGFjZSBkdXJp
bmcgaG9zdC1jb250YWluZXIgaW50ZXJhY3Rpb25zLiAKCgpGb3Igbm93LCB0aGUgbW91bnQgbmFt
ZXNwYWNlIGFuZCB0aGUgcGl2b3Rfcm9vdCB0YWtlIGNoYXJnZSBvZiB0aGUgZmlsZXN5c3RlbSBp
c29sYXRpb24gZm9yIHRoZSBjb250YWluZXIuIFRoZSBtb3VudCBuYW1lc3BhY2Ugb25seSBzZWdy
ZWdhdGVzIHRoZSBtb3VudCBwb2ludHMgYmV0d2VlbiB0aGUgY29udGFpbmVyIGFuZCB0aGUgaG9z
dCBhbmQgY29tYmluZXMgdGhlIHBpdm90X3Jvb3QgdG8gY29uZmluZSB0aGUgY29udGFpbmVyIGFw
cGxpY2F0aW9uJ3MgdmlldyB3aXRoaW4gYSBnaXZlbiBwYXRoLiBBcyBhIHJlc3VsdCwgZnJvbSAg
dGhlIHZpcnR1YWwgZmlsZXN5c3RlbSAoVkZTKSwgdGhlIGtlcm5lbCBjYW5ub3QgdGVsbCB3aGV0
aGVyIGEgZGlyZWN0b3J5IGVudHJ5IChkZW50cnkpIG9iamVjdCBiZWxvbmdzIHRvIGEgY29udGFp
bmVyIG9yIG5vdC4gVGhpcyByZW5kZXJzIGFueSBpbGxlZ2FsIGFjY2VzcyB0byB0aGUgZmlsZXN5
c3RlbSBoYXJkIHRvIGlkZW50aWZ5LCBhcyBsb25nIGFzIHRoZSBwYXRoIG9mIHRoZSBhY2Nlc3Mg
cmVxdWVzdCBjYW4gYmUgdHJhbnNsYXRlZCBpbnRvIHRoZSBkZW50cnkgb2JqZWN0IHRocm91Z2gg
dGhlIFZGUy4gCgoKSW4gdGhpcyBjYXNlLCB3ZSBwcm9wb3NlIHRvIGV4dGVuZCB0aGUgZmlsZXN5
c3RlbSBpc29sYXRpb24gdG8gZGVudHJ5IG9iamVjdHMsIGVuc3VyaW5nIGZ1bGwgbWVkaWF0aW9u
IG9mIGhvc3QtY29udGFpbmVyIGZpbGVzeXN0ZW0tcmVsYXRlZCBpbnRlcmFjdGlvbnMuIEZvciB0
aGlzIHB1cnBvc2UsIHdlIHBhdGNoIHNvbWUgZnVuY3Rpb25zIGluIHRoZSBWRlMgaW1wbGVtZW50
YXRpb24uIEZpcnN0bHksIHdlIGV4dGVuZCBzeXNjYWxsIOKAmHBpdm90X3Jvb3TigJkgKGZzL25h
bWVzcGFjZS5jKSB0byB0YWcgZGVudHJpZXMgYWNjb3JkaW5nIHRvIHRoZWlyIHJlbGF0aW9ucyB3
aXRoIGNvbnRhaW5lcnMuIEFuZCB3ZSByZWxvYWQgdGhlIHBhdGggbG9va3VwIHByb2Nlc3MgaW4g
VkZTIGFuZCBlbmZvcmNlIGEgc2V0IG9mIGNhcmVmdWxseSBkZXNpZ25lZCBwb2xpY2llcyBpbiDi
gJhjb21wbGV0ZV93YWxrKCnigJkgKGZzL25hbWVpLmMpIHRvIHJlZ3VsYXRlIHRoZSBhY2Nlc3Mg
dG8gdGhlc2Ugb2JqZWN0cy4KCgpJcyB0aGlzIGlkZWEgYXBwcm9wcmlhdGUgdG8gZW5oYW5jZSB0
aGUgaXNvbGF0aW9uIG9mIHRoZSBWRlM/IAoKClRoYW5rcyE=
