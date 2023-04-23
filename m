Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92146EBD0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 06:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDWEmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 00:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWEmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 00:42:20 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Apr 2023 21:42:19 PDT
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D85A1FCC;
        Sat, 22 Apr 2023 21:42:16 -0700 (PDT)
From:   "Xu,Rongbo" <xurongbo@baidu.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] fuse: no interrupt for lookup request
Thread-Topic: [PATCH] [PATCH] fuse: no interrupt for lookup request
Thread-Index: AQHZdGBbSPcvGdSwlU+gwdW0scg84a84TvGA
Date:   Sun, 23 Apr 2023 04:27:04 +0000
Message-ID: <425B0C38-15A7-45A3-B3C6-55F7844E90B4@baidu.com>
References: <20230417075545.58817-1-xurongbo@baidu.com>
 <CAJfpegswN_CJJ6C3RZiaK6rpFmNyWmXfaEpnQUJ42KCwNF5tWw@mail.gmail.com>
In-Reply-To: <CAJfpegswN_CJJ6C3RZiaK6rpFmNyWmXfaEpnQUJ42KCwNF5tWw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.202.19]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDEE3D7FE289EE438AF1595B36C4C47A@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.57
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSB2ZXJpZmllZCwgaXQncyBPS+OAgg0KDQrvu7/lnKggMjAyMy80LzIxIDIyOjQ477yM4oCcTWlr
bG9zIFN6ZXJlZGnigJ08bWlrbG9zQHN6ZXJlZGkuaHUgPG1haWx0bzptaWtsb3NAc3plcmVkaS5o
dT4+IOWGmeWFpToNCg0KDQpPbiBNb24sIDE3IEFwciAyMDIzIGF0IDA5OjU5LCBYdSBSb25nYm8g
PHh1cm9uZ2JvQGJhaWR1LmNvbSA8bWFpbHRvOnh1cm9uZ2JvQGJhaWR1LmNvbT4+IHdyb3RlOg0K
Pg0KPiBGcm9tOiB4dXJvbmdibyA8eHVyb25nYm9AYmFpZHUuY29tIDxtYWlsdG86eHVyb25nYm9A
YmFpZHUuY29tPj4NCj4NCj4gaWYgbG9va3VwIHJlcXVlc3QgaW50ZXJydXB0ZWQsIHRoZW4gZGVu
dHJ5IHJldmFsaWRhdGUgcmV0dXJuIC1FSU5UUg0KPiB3aWxsIHVtb3VudCBiaW5kLW1vdW50ZWQg
ZGlyZWN0b3J5Lg0KPg0KDQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KDQpDb3VsZCB5b3Ug
cGxlYXNlIHZlcmlmeSB0aGF0IHRoZSBhdHRhY2hlZCBmaXggYWxzbyB3b3Jrcz8NCg0KDQpUaGFu
a3MsDQpNaWtsb3MNCg0KDQoNCg==
