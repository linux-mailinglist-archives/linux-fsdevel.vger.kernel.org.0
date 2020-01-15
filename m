Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC213BAF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAOI2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56762 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgAOI23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200115082827epoutp0460152cc0f78f6f04ff69ffa319bbb38c~qAhTOdqx90504105041epoutp047
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200115082827epoutp0460152cc0f78f6f04ff69ffa319bbb38c~qAhTOdqx90504105041epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076907;
        bh=JJvb/PqG7Xp1dNCWJFNg00lj88HyqOAxtMF2YJCE1O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GslbEPNptXaUPuZBa3K+h7nqG9J1roaFnG1KNDnfV5BvB80sIpWr7NvdJSUQRBeh8
         jm6dKG7EhazXbMJ0gKxd3Pp9FPHNiZwkbKYqtNu4lvnZ/WZo/RUm04Ej9e559zdiio
         dj2fVJtHjt1NJRO5CL0U8DoKRPEYaYBiM1SAP2+4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115082827epcas1p284ea7e272bce79cb45f1f7afdcf756f3~qAhSyj4iA1549115491epcas1p2x;
        Wed, 15 Jan 2020 08:28:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47yL7Z4bgSzMqYkk; Wed, 15 Jan
        2020 08:28:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.AE.57028.A2DCE1E5; Wed, 15 Jan 2020 17:28:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082826epcas1p117191a39ecccaef5a9b5cbe77b05c5a5~qAhR3xvA20896008960epcas1p1u;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115082826epsmtrp153db588ff60d7276794657f251b05e42~qAhR2QjGF0486104861epsmtrp1B;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-8d-5e1ecd2ad476
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.3C.06569.A2DCE1E5; Wed, 15 Jan 2020 17:28:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082826epsmtip178e6a7719e7112400161b2bd794f8f06~qAhRqteY00431104311epsmtip1T;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 13/14] MAINTAINERS: add exfat filesystem
Date:   Wed, 15 Jan 2020 17:24:46 +0900
Message-Id: <20200115082447.19520-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURzl7r1tT2vxmmk3JV2P/CNF3XPOXuH6IImVGkLQHxWuh3uptS/3
        pqyiGgQpFpVmWKbkEis1ca1lugx1aiaamIZmGBhRqWhp0de0j21vffx3fud3zj2Hey+GiH/x
        Q7EcnYkx6mgNIQhEmzrXSWOinoRnSHsWI6kfJY+E1KnqRgFVW9/No0ZfvkCo1oe9KDXsrBBQ
        38pOUsV9CzzK8bOLTw19mEO3BCoX3CVA2VL+Uqhsq7wtVD4YswiU5xx1QPnJHq503Z8RpAv3
        apKyGVrNGCWMLlOvztFlKYiU3aptKnmilIwhN1DrCYmO1jIKIjk1PWZ7jsZTj5Dk05o8D5VO
        sywRtynJqM8zMZJsPWtSEIxBrTGQUkMsS2vZPF1WbKZeu5GUSuPlHuUBTXb3+AbDF775erPZ
        Aiz8IhCAQTwBnrFOCotAICbGmwGctzkRbvjoGeqm+dzwBcD+pqe8P5ZTt77zuMVDACvcA+hf
        y+eOClAEMEyAR8NFR7DXsALfDO9ebfdpELwDwJnBSqF3EYQnwTdzQ6gXo3gkbHD2+0qJcAVc
        LC31p0XAels74sUBHr7LMewrC/F2AZy4d0XIiZLh7JTVbwiC0z0OPx8Kp86fFnoLQfwYnG9D
        OLoQwMmvCg7L4Fijje+VIPg62OiM4+g1sGWhEngxgi+D7z+f5XOniGDhaTEniYTnhjr9oWGw
        qGDOH6qEE22DPizGLwD4qsB8AYSX/wuoAqAOhDAGVpvFsKSB/P+57MD3+aLkzaB0INUFcAwQ
        S0WS8dUZYj6dzx7RugDEEGKFqPeyhxKp6SNHGaNeZczTMKwLyD33WIyEBmfqPV9ZZ1KR8niZ
        TEYlJK5PlMuIlaLkqvAMMZ5Fm5jDDGNgjH98PCwg1AKqh+fdKVaHdWt5604zWiOK7tyVe23l
        krSGkP6ZsOdlq2LV32xjj0/ISIt5R0RE2cUR+U13R83Ia9Xumtqwd+hIc8vbwlGDom21bdIR
        t+/K7eG9s5dEd1otl1zBSctPMgXkQfseWcOAY21h16ZD5j5nrn30xqD92fH2/e6+idq0bgJl
        s2kyCjGy9G+MSKc/kgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnK7WWbk4g7uruS3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujKN3LAu+sVYs2lHR
        wNjA2sXIySEhYCLRvOInUxcjF4eQwG5GiZk/F7JDJKQljp04w9zFyAFkC0scPlwMUfOBUeLp
        /DawOJuAtsSfLaIg5SICjhK9uw6zgNQwC5xmlOje+JAJJCEsYCPx9MMlFhCbRUBVYu2uM2CL
        eQVsJf5MmcIEsUteYvWGA8wgNidQ/MiWy2A3CAH1TntykmkCI98CRoZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjBAaqltYPxxIn4Q4wCHIxKPLwKd2TjhFgTy4orcw8xSnAwK4nw
        npwBFOJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cA4l62J
        8xS/19+vhnuyF11hLph/PPVF49NvR83crvossk+PealuzmVy6FBFXurfA2seLJK7OG1Oe9y6
        mcdP1FifYmf98mp74ZKg6heVuU/ddiWEV+/aUPP95dKEPwJfmdxslB3Erxoctz1r7RYY03Ct
        qvRhZs7KVZIXz9V8+Hxqc5fypE0KWsuNlViKMxINtZiLihMBXDT7MkwCAAA=
X-CMS-MailID: 20200115082826epcas1p117191a39ecccaef5a9b5cbe77b05c5a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082826epcas1p117191a39ecccaef5a9b5cbe77b05c5a5
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082826epcas1p117191a39ecccaef5a9b5cbe77b05c5a5@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be09a6aa943..aa2dacd1ecf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6287,6 +6287,13 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXFAT FILE SYSTEM
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sungjong Seo <sj1557.seo@samsung.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/exfat/
+
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.17.1

