Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34C610AA13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 06:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0FZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 00:25:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39574 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfK0FZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:25:10 -0500
Received: by mail-io1-f69.google.com with SMTP id u13so12662691iol.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 21:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=sCpnitGcLr+rzXdjfijH3mSKiHousAn0LnZ2pRdnHDw=;
        b=deZfDTEnpNxY2cq7ntpi03RAGvgdXN4TF/OYnMjBd1bubUKhsDyPnst5VgjEj3INc1
         VyZKVjpx/+nPsKxrilPSn1Hs3jeHVIjKh74Yqx2c+m5PU7uJoYxYWqwHH6aO03IHrdYQ
         UqNKJ3+l8+9Rr1mp1YYERrCwQKamMl26eMczulP9crp55KNTr1aZMBtRRyplhGTlCskS
         8mfsMcmrf2g08vws4LrewL4PM5HdwK3MKlasQlONoAX6vsSQUyG8x8w7OrHHO6C1IZVU
         yVDxZ8B4EwiCVZHo+OY0eDx8PV9vAOEZ3IAiU/CQjTYMHMyFBdSSb652wThlHVypc7Jm
         gJOQ==
X-Gm-Message-State: APjAAAX0n51IBsOF6eY34qyScExH71R6D6Gtk5Mec2AVTrSEye1NrPeW
        WVdDLsoM32r49ggwjnfCJpKbSoRlw6UADyjjdPK8VCXw2Pxp
X-Google-Smtp-Source: APXvYqwEotJl6Q1E87MnwoVAtFUuh8qtS15hyJWYJK4OzMu3bRJaxgEHYvk9sy01xY8RNAtP1x+dCnjFSalYmuCUR2Y9oEZ+WDRx
MIME-Version: 1.0
X-Received: by 2002:a6b:c0c7:: with SMTP id q190mr17925448iof.256.1574832308317;
 Tue, 26 Nov 2019 21:25:08 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051770905984d38d3@google.com>
Subject: WARNING in exfat_bdev_read
From:   syzbot <syzbot+1930da7118e99b06e4ab@syzkaller.appspotmail.com>
To:     alexander.levin@microsoft.com, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, syzkaller-bugs@googlegroups.com,
        valdis.kletnieks@vt.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgYjlkM2QwMTQgQWRkIGxpbnV4LW5leHQgc3BlY2lmaWMgZmlsZXMgZm9yIDIwMTkx
MTIyDQpnaXQgdHJlZTogICAgICAgbGludXgtbmV4dA0KY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEyMzQ4ZGNlZTAwMDAwDQprZXJuZWwg
Y29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9NmMyNGM0
NWNlMjliMTc1Yw0KZGFzaGJvYXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD0xOTMwZGE3MTE4ZTk5YjA2ZTRhYg0KY29tcGlsZXI6ICAgICAgIGdjYyAoR0ND
KSA5LjAuMCAyMDE4MTIzMSAoZXhwZXJpbWVudGFsKQ0Kc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTU0MWE3MTZlMDAwMDANCkMgcmVw
cm9kdWNlcjogICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLmM/eD0xMjhm
ZjM4Y2UwMDAwMA0KDQpUaGUgYnVnIHdhcyBiaXNlY3RlZCB0bzoNCg0KY29tbWl0IGM0OGM5Zjdm
ZjMyYjhiMzk2NWEwOGU0MGViNjc2MzY4MmQ5MDViNWQNCkF1dGhvcjogVmFsZGlzIEtsxJN0bmll
a3MgPHZhbGRpcy5rbGV0bmlla3NAdnQuZWR1Pg0KRGF0ZTogICBXZWQgQXVnIDI4IDE2OjA4OjE3
IDIwMTkgKzAwMDANCg0KICAgICBzdGFnaW5nOiBleGZhdDogYWRkIGV4ZmF0IGZpbGVzeXN0ZW0g
Y29kZSB0byBzdGFnaW5nDQoNCmJpc2VjdGlvbiBsb2c6ICBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS94L2Jpc2VjdC50eHQ/eD0xNTQ3NmI1YWUwMDAwMA0KZmluYWwgY3Jhc2g6ICAgIGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwb3J0LnR4dD94PTE3NDc2YjVhZTAwMDAw
DQpjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0
P3g9MTM0NzZiNWFlMDAwMDANCg0KSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBidWcsIHBsZWFz
ZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoNClJlcG9ydGVkLWJ5OiBzeXpi
b3QrMTkzMGRhNzExOGU5OWIwNmU0YWJAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KRml4ZXM6
IGM0OGM5ZjdmZjMyYiAoInN0YWdpbmc6IGV4ZmF0OiBhZGQgZXhmYXQgZmlsZXN5c3RlbSBjb2Rl
IHRvIHN0YWdpbmciKQ0KDQpbRVhGQVRdIHRyeWluZyB0byBtb3VudC4uLg0KLS0tLS0tLS0tLS0t
WyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQpbRVhGQVRdIE5vIGJoLCBkZXZpY2Ugc2VlbXMgd3Jv
bmcgb3IgdG8gYmUgZWplY3RlZC4NCldBUk5JTkc6IENQVTogMSBQSUQ6IDg4NDQgYXQgZHJpdmVy
cy9zdGFnaW5nL2V4ZmF0L2V4ZmF0X2Jsa2Rldi5jOjYyICANCmV4ZmF0X2JkZXZfcmVhZCsweDI0
Zi8weDJiMCBkcml2ZXJzL3N0YWdpbmcvZXhmYXQvZXhmYXRfYmxrZGV2LmM6NjINCktlcm5lbCBw
YW5pYyAtIG5vdCBzeW5jaW5nOiBwYW5pY19vbl93YXJuIHNldCAuLi4NCkNQVTogMSBQSUQ6IDg4
NDQgQ29tbTogc3l6LWV4ZWN1dG9yNzM1IE5vdCB0YWludGVkICANCjUuNC4wLXJjOC1uZXh0LTIw
MTkxMTIyLXN5emthbGxlciAjMA0KSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRl
IEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgIA0KR29vZ2xlIDAxLzAxLzIwMTEN
CkNhbGwgVHJhY2U6DQogIF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc3IFtpbmxpbmVd
DQogIGR1bXBfc3RhY2srMHgxOTcvMHgyMTAgbGliL2R1bXBfc3RhY2suYzoxMTgNCiAgcGFuaWMr
MHgyZTMvMHg3NWMga2VybmVsL3BhbmljLmM6MjIxDQogIF9fd2Fybi5jb2xkKzB4MmYvMHgzNSBr
ZXJuZWwvcGFuaWMuYzo1ODINCiAgcmVwb3J0X2J1ZysweDI4OS8weDMwMCBsaWIvYnVnLmM6MTk1
DQogIGZpeHVwX2J1ZyBhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYzoxNzQgW2lubGluZV0NCiAgZml4
dXBfYnVnIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjE2OSBbaW5saW5lXQ0KICBkb19lcnJvcl90
cmFwKzB4MTFiLzB4MjAwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjI2Nw0KICBkb19pbnZhbGlk
X29wKzB4MzcvMHg1MCBhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYzoyODYNCiAgaW52YWxpZF9vcCsw
eDIzLzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoxMDI3DQpSSVA6IDAwMTA6ZXhmYXRf
YmRldl9yZWFkKzB4MjRmLzB4MmIwICANCmRyaXZlcnMvc3RhZ2luZy9leGZhdC9leGZhdF9ibGtk
ZXYuYzo2Mg0KQ29kZTogMDAgMDAgMzEgZmYgNDEgYmMgZmIgZmYgZmYgZmYgODkgZGUgZTggYWEg
M2UgZjcgZmIgODUgZGIgMGYgODUgNWQgZmYgIA0KZmYgZmYgZTggMWQgM2QgZjcgZmIgNDggYzcg
YzcgYTAgYTYgM2UgODggZTggODkgMzEgYzggZmIgPDBmPiAwYiBlOSA0NSBmZiAgDQpmZiBmZiBl
OCAyNSBjOSAzMyBmYyBlOSBhZCBmZSBmZiBmZiBlOCBkYiBjOCAzMyBmYw0KUlNQOiAwMDE4OmZm
ZmY4ODgwYTczZGZhYTAgRUZMQUdTOiAwMDAxMDI4Mg0KUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJC
WDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClJEWDogMDAwMDAwMDAw
MDAwMDAwMCBSU0k6IGZmZmZmZmZmODE1ZDg4YzYgUkRJOiBmZmZmZWQxMDE0ZTdiZjQ2DQpSQlA6
IGZmZmY4ODgwYTczZGZhZDggUjA4OiBmZmZmODg4MDk1MTgyMWMwIFIwOTogZmZmZmVkMTAxNWQy
NjYyMQ0KUjEwOiBmZmZmZWQxMDE1ZDI2NjIwIFIxMTogZmZmZjg4ODBhZTkzMzEwNyBSMTI6IDAw
MDAwMDAwZmZmZmZmZmINClIxMzogZmZmZjg4ODA4YWVhMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAw
MDEgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQogIHNlY3Rvcl9yZWFkKzB4MTQwLzB4MWYwIGRyaXZl
cnMvc3RhZ2luZy9leGZhdC9leGZhdF9jb3JlLmM6MjUzNw0KICBmZnNNb3VudFZvbCBkcml2ZXJz
L3N0YWdpbmcvZXhmYXQvZXhmYXRfc3VwZXIuYzozNzYgW2lubGluZV0NCiAgZXhmYXRfZmlsbF9z
dXBlci5jb2xkKzB4MmU0LzB4ODk1IGRyaXZlcnMvc3RhZ2luZy9leGZhdC9leGZhdF9zdXBlci5j
OjM3MTYNCiAgbW91bnRfYmRldisweDMwNC8weDNjMCBmcy9zdXBlci5jOjE0MTUNCiAgZXhmYXRf
ZnNfbW91bnQrMHgzNS8weDQwIGRyaXZlcnMvc3RhZ2luZy9leGZhdC9leGZhdF9zdXBlci5jOjM3
NzINCiAgbGVnYWN5X2dldF90cmVlKzB4MTA4LzB4MjIwIGZzL2ZzX2NvbnRleHQuYzo2NDcNCiAg
dmZzX2dldF90cmVlKzB4OGUvMHgzMDAgZnMvc3VwZXIuYzoxNTQ1DQogIGRvX25ld19tb3VudCBm
cy9uYW1lc3BhY2UuYzoyODIyIFtpbmxpbmVdDQogIGRvX21vdW50KzB4MTM1YS8weDFiNTAgZnMv
bmFtZXNwYWNlLmM6MzE0Mg0KICBrc3lzX21vdW50KzB4ZGIvMHgxNTAgZnMvbmFtZXNwYWNlLmM6
MzM1MQ0KICBfX2RvX3N5c19tb3VudCBmcy9uYW1lc3BhY2UuYzozMzY1IFtpbmxpbmVdDQogIF9f
c2Vfc3lzX21vdW50IGZzL25hbWVzcGFjZS5jOjMzNjIgW2lubGluZV0NCiAgX194NjRfc3lzX21v
dW50KzB4YmUvMHgxNTAgZnMvbmFtZXNwYWNlLmM6MzM2Mg0KICBkb19zeXNjYWxsXzY0KzB4ZmEv
MHg3OTAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6Mjk0DQogIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDQ5LzB4YmUNClJJUDogMDAzMzoweDQ0MDE3OQ0KQ29kZTogMTggODkgZDAg
YzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgMGYgMWYgMDAgNDggODkgZjggNDggODkg
ZjcgIA0KNDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQgODkgYzggNGMgOGIgNGMgMjQgMDgg
MGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiAgDQpmZiAwZiA4MyBmYiAxMyBmYyBmZiBjMyA2NiAyZSAw
ZiAxZiA4NCAwMCAwMCAwMCAwMA0KUlNQOiAwMDJiOjAwMDA3ZmZlOGY3N2ZmYzggRUZMQUdTOiAw
MDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBhNQ0KUkFYOiBmZmZmZmZmZmZmZmZmZmRh
IFJCWDogMDAzMDY1NmM2OTY2MmYyZSBSQ1g6IDAwMDAwMDAwMDA0NDAxNzkNClJEWDogMDAwMDAw
MDAyMDAwMDA4MCBSU0k6IDAwMDAwMDAwMjAwMDAxODAgUkRJOiAwMDAwMDAwMDIwMDAwMDAwDQpS
QlA6IDAwMDAwMDAwMDA2Y2EwMTggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAw
MDAwMDAwMA0KUjEwOiAwMDAwMDAwMDAwMDA0MDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6
IDAwMDAwMDAwMDA0MDFhMDANClIxMzogMDAwMDAwMDAwMDQwMWE5MCBSMTQ6IDAwMDAwMDAwMDAw
MDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQpLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZA0KUmVi
b290aW5nIGluIDg2NDAwIHNlY29uZHMuLg0KDQoNCi0tLQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVk
IGJ5IGEgYm90LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuDQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBz
bUVKIGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4NCnN5emJvdCBlbmdpbmVlcnMg
Y2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3
aWxsIGtlZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVwb3J0LiBTZWU6DQpodHRwczovL2dvby5nbC90
cHNtRUojc3RhdHVzIGZvciBob3cgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXpib3QuDQpGb3IgaW5m
b3JtYXRpb24gYWJvdXQgYmlzZWN0aW9uIHByb2Nlc3Mgc2VlOiBodHRwczovL2dvby5nbC90cHNt
RUojYmlzZWN0aW9uDQpzeXpib3QgY2FuIHRlc3QgcGF0Y2hlcyBmb3IgdGhpcyBidWcsIGZvciBk
ZXRhaWxzIHNlZToNCmh0dHBzOi8vZ29vLmdsL3Rwc21FSiN0ZXN0aW5nLXBhdGNoZXMNCg==
