Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27EF13BAFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgAOI2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37589 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAOI2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:30 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200115082827epoutp01e7a19142dcec1f899a3768dd42f66c3b~qAhTP8ZCj1572315723epoutp01T
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200115082827epoutp01e7a19142dcec1f899a3768dd42f66c3b~qAhTP8ZCj1572315723epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076907;
        bh=JZEc86fTB/07smsHnE1HOMGPjtHq56E4VH0Jhm+AcBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwB3aD//KJo7DuOS91St68SETiY/IuTxer8fYSKLU5RWc6w7gy06sXpsecpigNY53
         bYyqkhxSli+vcRUQCmlts9346U+GiyLpzMGPXvrnf90PBhlUgBKnj1jdPmNqY5Vv10
         NcLK0cYYdjJ+SGScgpb8T3Ig5VJ9lPO5IIka8Bmo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200115082827epcas1p3b42bb6468b6acde0e318d407121be486~qAhS3KIZp1480114801epcas1p3D;
        Wed, 15 Jan 2020 08:28:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47yL7Z1MqczMqYkk; Wed, 15 Jan
        2020 08:28:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.96.48019.A2DCE1E5; Wed, 15 Jan 2020 17:28:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200115082825epcas1p4a0d63d53d8737a84fe8867bc1e63811e~qAhRZUwTD3122931229epcas1p4C;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115082825epsmtrp28e3e5f45a3757a902bf60807bd6cc8fe~qAhRYY73H1143311433epsmtrp2X;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-90-5e1ecd2aa8ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.3C.06569.92DCE1E5; Wed, 15 Jan 2020 17:28:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082825epsmtip1979d1a3186a6123bf6135be3447a9813~qAhRJtUoc0089400894epsmtip1k;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 12/14] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Wed, 15 Jan 2020 17:24:45 +0900
Message-Id: <20200115082447.19520-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOObMWh6n5YbjWISGN5S5uHaNVkNm6gdi/fkwP7uissws7
        025G0rrYEl0XLE3BCqKmoc5hOh1b0zSpZBhlV/xTICFmRRlp1uZm9e95n/d53vf93u/FEfEp
        NBUvM9sZm5lmSTSB3z2QIZdlPpXo5Z5xIfXr0hBGOW61o9Td1oc8avzda4Tq94/wqWe+JpT6
        cfUkdfHxHI/yLgwKqLFPM/xtCbq5n5eArrfxHaYLNLdhur5XVaiu1usGuq8eiS50fwrNxw6w
        m40MbWBsUsZcbDGUmUu15J79hdsL1Rq5QqbIoTaSUjNtYrRk7t58WV4ZGxmPlFbQbHmEyqc5
        jszastlmKbczUqOFs2tJxmpgrQq5dQNHm7hyc+mGYotpk0IuV6ojyiLWOPXzA2a9ix+pWXAJ
        qsAX1AmEOCSy4csZN+IECbiY6AGw5X0NLxZ8AfDKgzvx4DuAFyb6kCXLfIMDjSX8AHqCT8Bf
        y+hNR8SC4yixHs57k6OGJGIr7Loe5Ec1CPEAwKlwMxZNJBK7YN3l8GJVPpEOP9x+w4tiEaGF
        w5d/82LdVsPWjuCiRhjhB73PsGghSARR2Oasx2KiXDj84lYcJ8KPw944ToVfp/1odCBIHIef
        A/EXVAM4OauNYRV81d4hiEoQIgO2+7Ji9BrYO9cMohghVsDpbzWCWBURrD4rjknSYe3YQHzK
        VdB5bibeVAcXwufii3MBePr6GOoCksZ/HVoAcIOVjJUzlTKcwpr9/495wOL9ZVI9oH90bwgQ
        OCCXi6Rv0/RiAV3BHTWFAMQRMkk0ci1CiQz00WOMzVJoK2cZLgTUkUVeRFKTiy2RazbbCxVq
        pUqlorI1GzVqFZki2tEi0YuJUtrOHGIYK2Nb8vFwYWoVOJ83zxY00bVIg/19YuXh2aTndmXl
        vhNH/P51aMaFivqSgyWdnZvcx7PCnbOJimXTwDg3OdQVuvFYLNypXNma8sM3WLBvbVLA3uIQ
        eIXj4bqUnKCvaCINaW0cEFNyv75atuxM/WTRxPSoEGu4x+YFNCe7O5wu5vejnbsnmlJIPmek
        FZmIjaP/AFnnPzyVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnK7mWbk4g3s31Cz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujDe/nrIXrOSo6Pk3
        gbWB8RNbFyMnh4SAicSfmc1ANheHkMBuRokdk/sZIRLSEsdOnGHuYuQAsoUlDh8uhqj5wCjx
        eE0vO0icTUBb4s8WUZByEQFHid5dh1lAapgFTjNKdG98yASSEBbwlOiffIEZxGYRUJV4uuw2
        WJxXwFbi+OT/TBC75CVWbzgAVsMJFD+y5TI7iC0kYCMx7clJpgmMfAsYGVYxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgQHqZbWDsYTJ+IPMQpwMCrx8CrckY0TYk0sK67MPcQowcGs
        JMJ7cgZQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA2Nn
        mUvgEWPXF8G3Q24ynLdoYrXYe+jWpHesWSkl7VH/FzIviBfWPPLwhdPu47dzd3YG5snUKm8L
        ztHscheec18pJMKff/sexWvdXN9j7qjyXZTRmPUi5ilvXLbIiYZEds7i5W1Ce359v3Wutb3t
        hrjhviNBb+o/vNqxeGfOLuX+WK36tZrrspRYijMSDbWYi4oTATD/9XhOAgAA
X-CMS-MailID: 20200115082825epcas1p4a0d63d53d8737a84fe8867bc1e63811e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082825epcas1p4a0d63d53d8737a84fe8867bc1e63811e
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082825epcas1p4a0d63d53d8737a84fe8867bc1e63811e@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add exfat in fs/Kconfig and fs/Makefile.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/Kconfig  | 3 ++-
 fs/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..5edd87eb5c13 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -139,9 +139,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 98be354fdb61..336b70f03bf2 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
-- 
2.17.1

