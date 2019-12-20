Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE81275AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTG1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:27:46 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38344 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLTG1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:45 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220062741epoutp03f6bbd30cc8b0c71cb2fc7608ba9b610d~iAGb-1vVO1112411124epoutp03T
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220062741epoutp03f6bbd30cc8b0c71cb2fc7608ba9b610d~iAGb-1vVO1112411124epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823261;
        bh=xnc0TrCf90JwQmTS3a9/1d7tqmcU/m3oeYgrC21DygI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0Q8x1JJdcM23mSc9ltiIsrEY2y/0HT7Szl6QMAHdwxlJWa36cdXB3skbFa9+kaSP
         VELQP4ToLBaVGIgDyu7imJoTGQrbl6kU/Bu+cyK/zkGqbC1VTEbWOOspL2wBicortn
         ZtM7rE+J7boWNbLTv7st5H0yPmgXzbdcSoAybr54=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220062741epcas1p4d5b814b6ff717b2edb1b32f576435297~iAGbmKj9Y0501805018epcas1p4a;
        Fri, 20 Dec 2019 06:27:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47fJhD6TgCzMqYkw; Fri, 20 Dec
        2019 06:27:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.67.48019.CD96CFD5; Fri, 20 Dec 2019 15:27:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191220062739epcas1p42f6096d78247630cfd02fc069ca072d3~iAGaMgzD30236902369epcas1p4V;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062739epsmtrp1476f3a2eb2151b7e400131786f624562~iAGaLznu_2112421124epsmtrp1h;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-88-5dfc69dceb60
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.BA.06569.BD96CFD5; Fri, 20 Dec 2019 15:27:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062739epsmtip17d6c182b3ebed23b7b8248db02ebacb5~iAGaDLv7q3102231022epsmtip1O;
        Fri, 20 Dec 2019 06:27:39 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 13/13] MAINTAINERS: add exfat filesystem
Date:   Fri, 20 Dec 2019 01:24:19 -0500
Message-Id: <20191220062419.23516-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnu6dzD+xBvs28Fg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORnzDvQzF3xjrfj0sZ+pgbGBtYuRk0NCwERi7o+nTF2MXBxCAjsYJS7t
        XMAK4XxilJj75gkzhPONUWLD05NsMC1v/1yASuxllPi06yo7XMuDa/uBqjg42AS0Jf5sEQVp
        EBGwl9g8+wALSA2zwBxGiR29sxhBEsIC1hKT1s4Fs1kEVCVu9h0D28ArYCvxvOUi1DZ5idUb
        DjCD2JxA8d9fn4MdKyGwgU2idfk1qCIXiaPXe5ghbGGJV8e3sEPYUhIv+9vYQQ6SEKiW+Lgf
        qqSDUeLFd1sI21ji5voNrCAlzAKaEut36UOEFSV2/oY4jVmAT+Ld1x5WiCm8Eh1tQhAlqhJ9
        lw4zQdjSEl3tH6CWekg0nrgBDZIJjBJL3/WxT2CUm4WwYQEj4ypGsdSC4tz01GLDAhPkGNvE
        CE5wWhY7GPec8znEKMDBqMTD65D2O1aINbGsuDL3EKMEB7OSCO/tjp+xQrwpiZVVqUX58UWl
        OanFhxhNgQE5kVlKNDkfmHzzSuINTY2MjY0tTMzMzUyNlcR5OX5cjBUSSE8sSc1OTS1ILYLp
        Y+LglGpgXC71cb5umHfd17dH0754p9/gWMX5SyDtN1tf6Oe92ztv8OgXuH92DX3Gnt77+pjs
        /KcfXQTW266ufBlj5Vx4V+18jeDXjOX/8+YeetPk22h95eS8TSucy5h7JI1jD0wOSZTJto85
        OvmBhNsCRSmDOcVxO221uI7/m/5S8Idt+eOjC2Y9CeTMU2Ipzkg01GIuKk4EAJsb25aGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnO7tzD+xBj/PWVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MeQf6mQu+sVZ8+tjP1MDYwNrFyMkhIWAi8fbP
        BeYuRi4OIYHdjBKL759hgkhISxw7cQYowQFkC0scPlwMUfOBUWLnldssIHE2AW2JP1tEQcpF
        BBwlencdZgGpYRZYxCjx7uNksAXCAtYSk9bOZQSxWQRUJW72HWMDsXkFbCWet1xkg9glL7F6
        wwFmEJsTKP7763OwG4QEbCQat61hnMDIt4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5y
        fu4mRnAYamntYDxxIv4QowAHoxIPr0Pa71gh1sSy4srcQ4wSHMxKIry3O37GCvGmJFZWpRbl
        xxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamB0E6169EFCec7jl7YCcTVa
        cnv6T58tmrPXl/2ZRIANT8bGo4vixP9IKjqVzchZxND1+GrFvoz/Vuy6XSICn0QZN/S8C6r7
        a5t8VG+ThVS0V5Wc/lGlVS4RR62n9Vy7+/6/mrP89RlLZ4UyJcdV9qZ8YM2+tDvKTqnlxCbp
        qDRn60/zavcu4FZiKc5INNRiLipOBAA/lZvnPwIAAA==
X-CMS-MailID: 20191220062739epcas1p42f6096d78247630cfd02fc069ca072d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062739epcas1p42f6096d78247630cfd02fc069ca072d3
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062739epcas1p42f6096d78247630cfd02fc069ca072d3@epcas1p4.samsung.com>
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
index f83239abd3a6..b7b6e2ac3a42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6237,6 +6237,13 @@ F:	include/trace/events/mdio.h
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

