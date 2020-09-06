Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1125EE96
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgIFPbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgIFPbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:31:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723CAC061573;
        Sun,  6 Sep 2020 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=+LuTTLR0kikmiTPRNn7HRx+lG0J24aqE2GOmu3Oa2sw=; b=Iv
        56LjyORAFwYrKSoOUcozZlC8D7x28mv1jADrDsw+d5sW6g3aVgTlH/ulJxo5BEfjsQsvAwKpwY5eo
        U9cM9I3Nn2wDS49/Yx1FLMPr0Bu0wOxD06M/tNVhvXLUk0NkfaTJaHZgOPxW2Nd4BrC8/D0kmmeS1
        XCiERjXbTzGwNNPHv9iEwzUS4/T03+IKDl9UNjtmD3AkYZNf1pToaCDFjaastD2tY6r+KfSk4MXNe
        rkzWxfXqvBwRrhx6nEhpEsmZ+JZ4iTRbzUaMl40Wgv9c/0xes2avQbrCRhvofUQ4k5nWoyQ1VluI6
        7w9yDYWxbOCq5u7mO8e5PlWgbvtZZW5g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwd7-0000ez-VR; Sun, 06 Sep 2020 15:30:58 +0000
Received: from mout.gmx.net ([212.227.15.19])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwUS-0008VS-9s
        for willy@infradead.org; Sun, 06 Sep 2020 15:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405707;
        bh=OsxpPblvcfbkLBG7YNry2w3YzWs9opU/5ZYfutycyP4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WdAsesRcMV68cWnh7AHo4lMG5EF3yv/IKp+HXjsNEtzXlYJLCQvPS16iqKGMbYpFc
         GeQ+OUaDxJR2iTy0ddSiIY8H0PJcWllNSempn1M5LhmizOlL2s8MpgJjMYYWY6sxcE
         DGXr+Rq8tBXFCu7HjqmBcGmAKRJjv5PbwQdcU5SY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MplXz-1ktiIY1sC5-00qDKx; Sun, 06 Sep 2020 17:21:47 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 1/9] security/fbfam: Add a Kconfig to enable the fbfam feature
Date:   Sun,  6 Sep 2020 17:21:27 +0200
Message-Id: <20200906152127.7041-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2u2gXcLhUDn9TTnBUfWY9zdvza+bDn2ZuoUGv9LzAMqYlfqshaa
 Z22NwRAHHZvIhSdQXi88KVnQ1rg7nvY7H2FTiiorpFOg2ffSlbtOP18HoALjboSFcC+Ueto
 /pbRLpyIfRM6wZzVwBKM1oL4G8hMozqdPTnwos/CcMGzCGKCPICbfZjVztn8vrzbkfWIZ4v
 xjOFWnELHWYuG+qIJGcUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wuvmYeR2Az0=:0uNCS8Ux1zJup5fojaQl+4
 FLaCs/qiZqatmVYg4glHtMKzy50ZZHloLDIlM4SsP4fo/70xx2O6rx7hn0+BRMUZlIfrfIuHX
 cJGuttkcQcAYStyQVC6r3xi7ImxkM15ClFybN1+TZNwvzVgzQfm17cy23wIa39WtxDydM1YIW
 16d7ZExY7ZbydmJCtuibu5c1dyjkRYI211wgBbCV7QjAqJSqX6EOXDtrOFuHGZm3IrTUBSug2
 6n0f7UwLNsgoCW1o4bcA687gmKVuH50VhOWQNnYln/m9iRoWFukUP8P5g94sqwsA8QqtBpohX
 yZEeHiTd96fK/3TMUSLOgO4Q9wiHe1m9xV5FNgJydekUcHtQB8TGhXeFqts2ycbHrLt0QeYcY
 GwB3BKyjXt+o2wZeZ4cYmAKNhD12FkT0REGVd3XAoeWVAPTVhD4SEDagbJLDmH66o3E3Xeh1Z
 D8Q242o4JYzk3Sapn9yZ65BIWULrdd+Io9VfbIwJkxy2RlwvBwq8Csm/vBZ9DYBuA/XfH54zp
 531y0hUYW1MHoishQqHjtYMSa2bUpKNrm6wNeFIxjVZCN9HDuEv0TUA0OEVAbUXGwP03FNq2x
 3aS5zegAFT9nIfpjrahgfUd0VROfZc3dNpIWEABGlUabGd6IukTpjHHrOoEzjSzzwOMewcrtO
 w6p3sGuNeo+vRXBzvzQiBc8V59wSBgAllOuFbKbZdcYm3Ylx1OPdhRruQ7zlOHYVXGCxb+T3W
 n0cTuwU0GxlFjr+hJGDcVpgyT4xHsamqy0pmV/jMJ5XouVvtKeNCiCIHyXEfoFmQ90mI7zTes
 K4u75/dOuv+fEMlh40wbQQYJM5Uhjk7VzDzgIPx/lIXIBBapMVNb0EgsysTN/eZf/BCZm63XD
 kkPDNNuJiDj3RpsOgDrtt+lGjgELTuBFM4qlDnzvwv4jFloi5t1XvJLiL4sEl8rJO9JGRfbgB
 e+v3RUa8seBXYVdTma+xunnR8SEWM9a+gBLeHYYyaxyQQO2DW3/ee40wZ+HoJL1DzFwYt0wNK
 216DGqQ9lfAvAOdRc34npkrcnTLJcMV4xt7MKi7t3k7UDmfGL4QzvJ2GAn0HgtBHrHb2MenKU
 vJUZNWS8tNBfhOAYdUaYjiKE5G+luvICD3xuI+nlx28un4ETw46NWykmoJ1owkOkjyIye0OXV
 rxcZkSdBpumU6ltNhAlzdHNKzcVSuFOx6+V8DKzWMOMv2X1zLqKlV9v42WE1k1BWP4gA4ZGZN
 knMtrcHxA6p1RsqmropDN6BPqRT9tv50c7MwfOA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_162200_565156_EBED4387 
X-CRM114-Status: GOOD (  11.55  )
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.4.4 on casper.infradead.org summary:
 Content analysis details:   (-2.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.15.19 listed in wl.mailspike.net]
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.15.19 listed in list.dnswl.org]
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
 -0.0 SPF_PASS               SPF: sender matches SPF record
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a menu entry under "Security options" to enable the "Fork brute
force attack mitigation" feature.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/Kconfig       |  1 +
 security/fbfam/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 security/fbfam/Kconfig

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..00a90e25b8d5 100644
=2D-- a/security/Kconfig
+++ b/security/Kconfig
@@ -290,6 +290,7 @@ config LSM
 	  If unsure, leave this as the default.

 source "security/Kconfig.hardening"
+source "security/fbfam/Kconfig"

 endmenu

diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
new file mode 100644
index 000000000000..bbe7f6aad369
=2D-- /dev/null
+++ b/security/fbfam/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+config FBFAM
+	bool "Fork brute force attack mitigation"
+	default n
+	help
+	  This is a user defense that detects any fork brute force attack
+	  based on the application's crashing rate. When this measure is
+	  triggered the fork system call is blocked.
+
+	  If you are unsure how to answer this question, answer N.
=2D-
2.25.1

