Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A1397FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFBEAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:47203 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhFBEAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210602035824epoutp0110020413c11bd70e02a4b3da31b47415~Ep9ZB1z9E2000520005epoutp01E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:58:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210602035824epoutp0110020413c11bd70e02a4b3da31b47415~Ep9ZB1z9E2000520005epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622606304;
        bh=NfjgntiD4sGCoAPG4JlvSSWt9gvjIna27xSVO3rg/y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vE7DdzqHjdGmgMQQ9FZbJona+j6V+kp4t5uH49g4ci2kdeJRgCdZwURcx9JOvkl/D
         adc4WzEe8qjnSdPJIvXjTQwHyrc98wbnxJHdV/TseK3W0AsiQIjv+4sAv2WDaQjUqg
         ZedBANVAopsqAjtafT/IyFDu8GZv1g1YEK3pxc5E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210602035823epcas1p146438700afc722e3dbfeefc60892c8be~Ep9YaMGnI0553805538epcas1p1v;
        Wed,  2 Jun 2021 03:58:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FvwHL5rRyz4x9Pv; Wed,  2 Jun
        2021 03:58:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.77.09824.ED107B06; Wed,  2 Jun 2021 12:58:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210602035822epcas1p4013fc24d42e1ea13ef5d4f4b50751168~Ep9W91xMb2804328043epcas1p4e;
        Wed,  2 Jun 2021 03:58:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210602035822epsmtrp2e9ce81a41842e44de0355a008111af7b~Ep9W8wTNO1341613416epsmtrp2K;
        Wed,  2 Jun 2021 03:58:22 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-ce-60b701dec5c1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.B3.08163.ED107B06; Wed,  2 Jun 2021 12:58:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035821epsmtip25068a8cdca3582994c5310c39ac83601~Ep9Wurq6N0079200792epsmtip2e;
        Wed,  2 Jun 2021 03:58:21 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v4 10/10] MAINTAINERS: add cifsd kernel server
Date:   Wed,  2 Jun 2021 12:48:47 +0900
Message-Id: <20210602034847.5371-11-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602034847.5371-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmge49xu0JBpd/6Vg0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InKsclITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelFJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTsauji61g
        A3fFiTnT2RoYH3N2MXJySAiYSJzf+4+pi5GLQ0hgB6PE/g8rWCCcT4wSdz49ZQWpEhL4zCix
        rV8apuPN5X9QRbsYJRZ9fssI13Hh6T+2LkYODjYBbYk/W0RBGkQEYiVu7HjNDFLDLLCLWWLr
        /U1sIAlhATuJs0+PgW1gEVCVaF5yGizOK2AjMffofFaIbfISqzccYAaxOYHiq69NYYOIX+GQ
        WPVBAMJ2kdizbgtUvbDEq+Nb2CFsKYnP7/ZC1ZdLnDj5iwnCrpHYMG8fO8idEgLGEj0vSkBM
        ZgFNifW79CEqFCV2/p7LCGIzC/BJvPvawwpRzSvR0SYEUaIq0XfpMNRAaYmu9g9QSz0kXj2e
        zw4JkX5Gifft59gnMMrNQtiwgJFxFaNYakFxbnpqsWGBMXJ8bWIEp2At8x2M095+0DvEyMTB
        eIhRgoNZSYTXPW9rghBvSmJlVWpRfnxRaU5q8SFGU2DQTWSWEk3OB2aBvJJ4Q1MjY2NjCxMz
        czNTYyVx3nTn6gQhgfTEktTs1NSC1CKYPiYOTqkGppMW2ToucsIT5t6wbL6/UL3QdcnxFLvv
        E/h//vlpc/PGxkyn5smrn/ZmXjZaU3nusfjNZbLuM53ehVm22EoJx/AbL3s6821dRvHsDLEH
        h/rPcX0wEVfpUhOVXhncqOLWkr++MFJVsvmH5vmIzDki0pLsRRs/S2ra7D7YnbnlSqrlHmNu
        z9VHBPdZMxswrvPluP9LhiNLk0/mo7TZh+Ip1/JPzX0qpez+7OTDabw5CVWLQ2bbX3//9s7S
        JzE1Ugz8fQd5Yx7V/ZlcMPNEk0Qqz6aFB/WOimzoUImetf1N5tacAzufHytmPi5QV7TRiUkw
        6fY5vlT5bRr1GW3l/TtPMn7u3mD/yuL/+wP304wLlViKMxINtZiLihMB2QGMM0oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO49xu0JBhMmsVk0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgytjV0cVWsIG74sSc6WwNjI85uxg5OSQETCTeXP7H0sXIxSEksINRYm7rfVaIhLTE
        sRNnmLsYOYBsYYnDh4shaj4wSmyY+IcNJM4moC3xZ4soSLmIQLzEzYbbYHOYBc4wSzx9cpUd
        JCEsYCdx9ukxsJksAqoSzUtOs4HYvAI2EnOPzofaJS+xesMBZhCbEyi++toUsBohAWuJpfP3
        sU9g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4WrS0djDuWfVB7xAjEwfj
        IUYJDmYlEV73vK0JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgsky
        cXBKNTAdde115bFSC595op9H/kj/mbJ3d0qffFpot2pX9PIHO/8zTVj1RW5zNJ9dbH0ip9uZ
        pxeeV7Mt5PMyjlymH3LMteSn2GQRt19huezTF2/omTrhSGxjxqEqt8LD619/umgyM13owa1c
        ByWh5x3aBn+urd4d5jllodGi4OymiS1tq4p998s0vnhya6GUQ2Kw4NO3R3x59T+fUOgriQ79
        XCnh8/uwavHCpukC6+9edWGT6W0KfPjnT2rRyrrOwNWOy7ebiiVsKLu01fXibM3fzgnmt5r9
        avsU8lLTTLY+upi+UzFI/fHMp7fM4oK4vG/kvvCa5D3pboSuUkmdwPLWH0V2N1YK/pJYKZMv
        vJq/gFGJpTgj0VCLuag4EQDbtM/CBQMAAA==
X-CMS-MailID: 20210602035822epcas1p4013fc24d42e1ea13ef5d4f4b50751168
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035822epcas1p4013fc24d42e1ea13ef5d4f4b50751168
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
        <CGME20210602035822epcas1p4013fc24d42e1ea13ef5d4f4b50751168@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself, Steve French, Sergey Senozhatsky and Hyunchul Lee
as cifsd maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..f23bb5cbfd70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4530,7 +4530,7 @@ F:	include/linux/clk/
 F:	include/linux/of_clk.h
 X:	drivers/clk/clkdev.c
 
-COMMON INTERNET FILE SYSTEM (CIFS)
+COMMON INTERNET FILE SYSTEM CLIENT (CIFS)
 M:	Steve French <sfrench@samba.org>
 L:	linux-cifs@vger.kernel.org
 L:	samba-technical@lists.samba.org (moderated for non-subscribers)
@@ -4540,6 +4540,16 @@ T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
 
+COMMON INTERNET FILE SYSTEM SERVER (CIFSD)
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+M:	Steve French <sfrench@samba.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-cifs@vger.kernel.org
+L:	linux-cifsd-devel@lists.sourceforge.net
+S:	Maintained
+F:	fs/cifsd/
+
 COMPACTPCI HOTPLUG CORE
 M:	Scott Murray <scott@spiteful.org>
 L:	linux-pci@vger.kernel.org
-- 
2.17.1

