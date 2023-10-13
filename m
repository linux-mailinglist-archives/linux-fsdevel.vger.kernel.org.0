Return-Path: <linux-fsdevel+bounces-242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6287C7E89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994351C210E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4178101D4;
	Fri, 13 Oct 2023 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3366FB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 07:27:45 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5FFB7;
	Fri, 13 Oct 2023 00:27:44 -0700 (PDT)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S6J4W34X6z8XrRB;
	Fri, 13 Oct 2023 15:27:39 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4S6J4S4B8vz4xVbp;
	Fri, 13 Oct 2023 15:27:36 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
	by mse-fl1.zte.com.cn with SMTP id 39D7RRt7087556;
	Fri, 13 Oct 2023 15:27:27 +0800 (+08)
	(envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 13 Oct 2023 15:27:30 +0800 (CST)
Date: Fri, 13 Oct 2023 15:27:30 +0800 (CST)
X-Zmail-TransId: 2b096528f1620ef-2add6
X-Mailer: Zmail v1.0
Message-ID: <202310131527303451636@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <cheng.lin130@zte.com.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <djwong@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@fromorbit.com>, <hch@infradead.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBQQVRDSF0gZnM6IGludHJvZHVjZSBjaGVjayBmb3IgZHJvcC9pbmNfbmxpbms=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 39D7RRt7087556
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6528F16B.000/4S6J4W34X6z8XrRB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HTML_MESSAGE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogQ2hlbmcgTGluIDxjaGVuZy5saW4xMzBAenRlLmNvbS5jbj4NCg0KQXZvaWQgaW5vZGUg
bmxpbmsgb3ZlcmZsb3cgb3IgdW5kZXJmbG93Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGVuZyBMaW4g
PGNoZW5nLmxpbjEzMEB6dGUuY29tLmNuPg0KLS0tDQogZnMvaW5vZGUuYyB8IDYgKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvaW5vZGUu
YyBiL2ZzL2lub2RlLmMNCmluZGV4IDY3NjExYTM2MC4uOGU2ZDYyZGM0IDEwMDY0NA0KLS0tIGEv
ZnMvaW5vZGUuYw0KKysrIGIvZnMvaW5vZGUuYw0KQEAgLTMyOCw2ICszMjgsOSBAQCBzdGF0aWMg
dm9pZCBkZXN0cm95X2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogdm9pZCBkcm9wX25saW5r
KHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogew0KIAlXQVJOX09OKGlub2RlLT5pX25saW5rID09IDAp
Ow0KKwlpZiAodW5saWtlbHkoaW5vZGUtPmlfbmxpbmsgPT0gMCkpDQorCQlyZXR1cm47DQorDQog
CWlub2RlLT5fX2lfbmxpbmstLTsNCiAJaWYgKCFpbm9kZS0+aV9ubGluaykNCiAJCWF0b21pY19s
b25nX2luYygmaW5vZGUtPmlfc2ItPnNfcmVtb3ZlX2NvdW50KTsNCkBAIC0zODgsNiArMzkxLDkg
QEAgdm9pZCBpbmNfbmxpbmsoc3RydWN0IGlub2RlICppbm9kZSkNCiAJCWF0b21pY19sb25nX2Rl
YygmaW5vZGUtPmlfc2ItPnNfcmVtb3ZlX2NvdW50KTsNCiAJfQ0KIA0KKwlpZiAodW5saWtlbHko
aW5vZGUtPmlfbmxpbmsgPT0gfjBVKSkNCisJCXJldHVybjsNCisNCiAJaW5vZGUtPl9faV9ubGlu
aysrOw0KIH0NCiBFWFBPUlRfU1lNQk9MKGluY19ubGluayk7DQotLSANCjIuMTguMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IENoZW5nIExpbiAmbHQ7Y2hlbmcubGlu
MTMwQHp0ZS5jb20uY24mZ3Q7PGJyPjwvcD48cD48YnI+PC9wPjxwPkF2b2lkIGlub2RlIG5saW5r
IG92ZXJmbG93IG9yIHVuZGVyZmxvdy48L3A+PHA+PGJyPjwvcD48cD5TaWduZWQtb2ZmLWJ5OiBD
aGVuZyBMaW4gJmx0O2NoZW5nLmxpbjEzMEB6dGUuY29tLmNuJmd0OzwvcD48cD4tLS08L3A+PHA+
Jm5ic3A7ZnMvaW5vZGUuYyB8IDYgKysrKysrPC9wPjxwPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyk8L3A+PHA+PGJyPjwvcD48cD5kaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBi
L2ZzL2lub2RlLmM8L3A+PHA+aW5kZXggNjc2MTFhMzYwLi44ZTZkNjJkYzQgMTAwNjQ0PC9wPjxw
Pi0tLSBhL2ZzL2lub2RlLmM8L3A+PHA+KysrIGIvZnMvaW5vZGUuYzwvcD48cD5AQCAtMzI4LDYg
KzMyOCw5IEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSk8
L3A+PHA+Jm5ic3A7dm9pZCBkcm9wX25saW5rKHN0cnVjdCBpbm9kZSAqaW5vZGUpPC9wPjxwPiZu
YnNwO3s8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5X
QVJOX09OKGlub2RlLSZndDtpX25saW5rID09IDApOzwvcD48cD4rPHNwYW4gc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAodW5saWtlbHkoaW5vZGUtJmd0O2lfbmxpbmsgPT0gMCkp
PC9wPjxwPis8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5yZXR1cm47PC9w
PjxwPis8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5p
bm9kZS0mZ3Q7X19pX25saW5rLS07PC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+aWYgKCFpbm9kZS0mZ3Q7aV9ubGluayk8L3A+PHA+Jm5ic3A7PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+YXRvbWljX2xvbmdfaW5jKCZhbXA7aW5v
ZGUtJmd0O2lfc2ItJmd0O3NfcmVtb3ZlX2NvdW50KTs8L3A+PHA+QEAgLTM4OCw2ICszOTEsOSBA
QCB2b2lkIGluY19ubGluayhzdHJ1Y3QgaW5vZGUgKmlub2RlKTwvcD48cD4mbmJzcDs8c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5hdG9taWNfbG9uZ19kZWMoJmFtcDtpbm9k
ZS0mZ3Q7aV9zYi0mZ3Q7c19yZW1vdmVfY291bnQpOzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08L3A+PHA+Jm5ic3A7PC9wPjxwPis8c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmICh1bmxpa2VseShpbm9kZS0mZ3Q7aV9ubGlu
ayA9PSB+MFUpKTwvcD48cD4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+
cmV0dXJuOzwvcD48cD4rPC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+aW5vZGUtJmd0O19faV9ubGluaysrOzwvcD48cD4mbmJzcDt9PC9wPjxwPiZuYnNw
O0VYUE9SVF9TWU1CT0woaW5jX25saW5rKTs8L3A+PHA+LS0mbmJzcDs8L3A+PHA+Mi4xOC4xPC9w
PjxwIHN0eWxlPSJmb250LXNpemU6MTZweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9z
b2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE2cHg7Zm9udC1mYW1pbHk6
5b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6
ZToxNnB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9w
PjxwIHN0eWxlPSJmb250LXNpemU6MTZweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9z
b2Z0IFlhSGVpOyI+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


