Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAE38BF8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhEUGi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 02:38:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63152 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhEUGiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 02:38:50 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210521063602epoutp042d74b8681f2fbc243ca228d9fcf8a56d~BAXmTp4020917809178epoutp04S
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 06:36:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210521063602epoutp042d74b8681f2fbc243ca228d9fcf8a56d~BAXmTp4020917809178epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621578962;
        bh=NfjgntiD4sGCoAPG4JlvSSWt9gvjIna27xSVO3rg/y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSC6MOqw7/FeFYV82K3XqdzXfGcvliYG/GjyggUwurwJ8kTdRMYopeGbO16e51Rgy
         Kz3OM6jitGTX4uOVxs4fOFAPL2bb/90/hCSrH6m8q1eYnZs1S3xyxeElqj9eH7hvNR
         CVmBWIslSY6lm79jMrA+GSHd+sZi7hxsE26eVsAA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210521063601epcas1p3d1c383830c2e29997983cd5b3485432c~BAXlsraDs1213512135epcas1p36;
        Fri, 21 May 2021 06:36:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FmcLm61tkz4x9Q1; Fri, 21 May
        2021 06:36:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.14.09736.0D457A06; Fri, 21 May 2021 15:36:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210521063600epcas1p4d00e632c185ce7e4896a23f5a4590ad0~BAXkYcZkn1898818988epcas1p4G;
        Fri, 21 May 2021 06:36:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210521063600epsmtrp199de019712df86a9961cac56b7c261f7~BAXkXcMKD3157231572epsmtrp1Z;
        Fri, 21 May 2021 06:36:00 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-43-60a754d0994b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.10.08637.0D457A06; Fri, 21 May 2021 15:36:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210521063600epsmtip1cce78444cd010b29f512a1a720999ba8~BAXkKY6yI1883518835epsmtip1f;
        Fri, 21 May 2021 06:36:00 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v3 10/10] MAINTAINERS: add cifsd kernel server
Date:   Fri, 21 May 2021 15:26:37 +0900
Message-Id: <20210521062637.31347-11-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521062637.31347-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmnu6FkOUJBk0LDSwa355msTj++i+7
        xet/01ksTk9YxGSxcvVRJotr99+zW7z4v4vZ4uf/74wWe/aeZLG4vGsOm8WP6fUWvX2fWC1a
        r2hZ7N64iM1i7efH7BZvXhxms7g1cT6bxfm/x1ktfv+Yw+Yg7DG74SKLx85Zd9k9Nq/Q8ti9
        4DOTx+6bDWwerTv+snt8fHqLxaNvyypGjy2LHzJ5rN9ylcXj8yY5j01P3jIF8ETl2GSkJqak
        Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAvaikUJaYUwoUCkgs
        LlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWqTMjJ2NXRxVaw
        gbvixJzpbA2Mjzm7GDk5JARMJBral7N3MXJxCAnsYJSYevU8lPOJUWLf2XksEM43Rokf788y
        wbTM+LWEGSKxl1Hi1O4VTHAtp5s+sHYxcnCwCWhL/NkiCtIgIhArcWPHa7AGZoFdzBJnF71g
        BEkIC9hJXFz4ngXEZhFQlbj8qY8VxOYVsJU4M+svO8Q2eYnVGw4wg9icQPGn3xewggySELjA
        ITHz3y2oIheJv08vs0HYwhKvjm+BiktJvOxvg7LLJU6c/AX1Qo3Ehnn72EEOlRAwluh5UQJi
        MgtoSqzfpQ9RoSix8/dcsDOZBfgk3n3tYYWo5pXoaBOCKFGV6Lt0GGqgtERX+weogR4Sk375
        QUJkAqPEwitL2Scwys1CWLCAkXEVo1hqQXFuemqxYYEpcoRtYgQnYS3LHYzT337QO8TIxMF4
        iFGCg1lJhJfbcXmCEG9KYmVValF+fFFpTmrxIUZTYNBNZJYSTc4H5oG8knhDUyNjY2MLEzNz
        M1NjJXHedOfqBCGB9MSS1OzU1ILUIpg+Jg5OqQampeffba641++nyiq7dz7X+UCu8uizUUpv
        uTsrmZ/rKkztMXh+aGdy/73AvzLLb0dcevy/Ry7dJCNa6YBSkMiaLyuX2uhPkVeIbeI1fBvb
        UDvtzMOjno1RwQ9nfuo1uPY1d+KcrWtafzOs0y565WKZ0dzycmPKhH9e9VmqGunKLD3Mk9/E
        NDzaWsGo+9PzULGmtQDTsYtugdxeNiuOHubn/XcvS9RXO3O/JQfbahWtdbHKIYcnhJsfNN/1
        kqN+qf6cFSkRhqktK05kva0yk1s9u1zA/2Kc79p+Pp6I0Ntsvq9ztlxtl+K2vP6+svrlio+3
        ct02y344MiX6YvKzdrGlP9xWL9/00E6/v3j1ZHYlluKMREMt5qLiRAB+xvknSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO6FkOUJBs96RS0a355msTj++i+7
        xet/01ksTk9YxGSxcvVRJotr99+zW7z4v4vZ4uf/74wWe/aeZLG4vGsOm8WP6fUWvX2fWC1a
        r2hZ7N64iM1i7efH7BZvXhxms7g1cT6bxfm/x1ktfv+Yw+Yg7DG74SKLx85Zd9k9Nq/Q8ti9
        4DOTx+6bDWwerTv+snt8fHqLxaNvyypGjy2LHzJ5rN9ylcXj8yY5j01P3jIF8ERx2aSk5mSW
        pRbp2yVwZezq6GIr2MBdcWLOdLYGxsecXYycHBICJhIzfi1h7mLk4hAS2M0ocfjNNXaIhLTE
        sRNngBIcQLawxOHDxRA1H4Bq2q+xgsTZBLQl/mwRBSkXEYiXuNlwmwWkhlngDLNEQ8seFpCE
        sICdxMWF78FsFgFVicuf+lhBbF4BW4kzs/5C7ZKXWL3hADOIzQkUf/p9AViNkICNRM/NlewT
        GPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjhYtzR2M21d90DvEyMTBeIhR
        goNZSYSX23F5ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTByc
        Ug1MBisnie35uuS7YmpHVX2MYtDSSoZnLxh7+e/u2dYkZqi75IPQlPrAVaHL5nz1TQ4VyXu1
        9prLhek3RSdLBiTvLHjyaHba2akHz33lFp20tvXeTOWiE913+2Y9vX0/R/VW1GXToNU3g+us
        Mx8l1l3y1lpz5VrZKfMj0QGff3XJHOrQmxga8VwqsG4i5zfbuwcPlCW85HuU+vnInt1JMzpl
        WC+UK/3vE3B5nVrPcUlN6HhSy/Vphh7HIi3Wu67b8luBXWXmbbuzTVYHnj+uXOy0QkX9AKNz
        x8FWgZNq6q2W+e33i682LMj55BA14+nBI9ZZCm13M6Z7s5ywfmeYdjtfsc7wM/uiufqmewW3
        BxjJKLEUZyQaajEXFScCAED8cqUFAwAA
X-CMS-MailID: 20210521063600epcas1p4d00e632c185ce7e4896a23f5a4590ad0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210521063600epcas1p4d00e632c185ce7e4896a23f5a4590ad0
References: <20210521062637.31347-1-namjae.jeon@samsung.com>
        <CGME20210521063600epcas1p4d00e632c185ce7e4896a23f5a4590ad0@epcas1p4.samsung.com>
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

