Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABC3F43B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhHWDKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 23:10:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14082 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhHWDJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:09:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210823030854epoutp01d9eae9ad3d90acf0d36bc7997568a732~d0LldqNt62661126611epoutp01u
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 03:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210823030854epoutp01d9eae9ad3d90acf0d36bc7997568a732~d0LldqNt62661126611epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629688134;
        bh=NAJ82Y910/EFQyY4mIkd8n66ETnPAnqW0FlDz8FeWi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTrC7sac36HPPHfKmIJam8qry3IIr0YcB+LyZAs3S5sGAb5LySceP/htZlabwR49a
         C1N8TdhsO9CjCWRXso3Rx2Oc9/KivPfwsdYVWtnNRvIZxy3gWTM7RkX82Pp4FuvBu+
         WuLb3cjr8EvFhD91nyCpIP9bYHMOJym11uZ3abxk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210823030854epcas1p1e1e3d00e27a3c945e8da8d0bed48fc9c~d0Lk58igj3140731407epcas1p1_;
        Mon, 23 Aug 2021 03:08:54 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.248]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GtHJN39TRz4x9Pw; Mon, 23 Aug
        2021 03:08:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.2E.09827.44113216; Mon, 23 Aug 2021 12:08:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210823030851epcas1p3df6319948e331e2e0225adba4e81e660~d0Li59vR60807808078epcas1p31;
        Mon, 23 Aug 2021 03:08:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210823030851epsmtrp1b7c1b99e8ab4719848e334347f15e0c7~d0Li33Tze2901829018epsmtrp1M;
        Mon, 23 Aug 2021 03:08:51 +0000 (GMT)
X-AuditID: b6c32a36-c65ff70000002663-57-61231144ebab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.45.08750.34113216; Mon, 23 Aug 2021 12:08:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030851epsmtip27975fcf2747e3be09ed6b736569b0e61~d0Lioe6q60582705827epsmtip2-;
        Mon, 23 Aug 2021 03:08:51 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com, metze@samba.org, smfrench@gmail.com,
        hyc.lee@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v8 13/13] MAINTAINERS: add ksmbd kernel server
Date:   Mon, 23 Aug 2021 11:58:16 +0900
Message-Id: <20210823025816.7496-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823025816.7496-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnq6LoHKiwZnrohbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmH1/
        H0vBRM6Kfxc/sDUwfmXvYuTkkBAwkbg+9R1jFyMXh5DADkaJOcsuskI4nxgl9t9pZoJwPjNK
        bFo8F65l/8zlLBCJXYwSh34sQWhpOgYyjIODTUBb4s8WUZAGEYFYiRs7XjOD1DALzGaWeL73
        FAtIQljATmLPchCbg4NFQFXi02ZhkDCvgI3EiRUrWSGWyUus3nCAGcTmBIp/nPQK7FYJgRsc
        Ek8froC6yEXi8utlLBC2sMSr41ug4lISL/vboOxyiRMnfzFB2DUSG+btYwfZKyFgLNHzogTE
        ZBbQlFi/Sx+iQlFi5++5jCA2swCfxLuvPawQ1bwSHW1CECWqEn2XDkMNlJboav8AtchDYsvv
        38yQEOlnlFj79zzTBEa5WQgbFjAyrmIUSy0ozk1PLTYsMIJHWHJ+7iZGcCrWMtvBOOntB71D
        jEwcjIcYJTiYlUR4/zIpJwrxpiRWVqUW5ccXleakFh9iNAUG3URmKdHkfGA2yCuJNzSxNDAx
        MzKxMLY0NlMS52V8JZMoJJCeWJKanZpakFoE08fEwSnVwFSziSfc4WpwnwL7wZJtu5Ra+jWX
        XrFm9s4IzFXSW9hdccc8T9ljb5jjpG2Bq6qM0xyajtx/L/bt7e6IRPHrohGc7gdM/7/Z9H3h
        RfmqeXbZnQ3u/r8S5aPv/39vYP5+Xs6TwwG7+IsM4g7OMawx8BMoWiHws/Hi8rRfHf++565d
        3siYkTLPayMf7/eGY1G3mmLW2wVYPo1qzmfoXsgzuS2cKWuu/46gbcFFixu4ZK2+HfsgW7y6
        Inu9fcrclkdhjC89mZ6+bZJTcd5xpOfQge+3NQrkXwQd+ZDlo/m8XnPL5UfmjGtyeH8GiHSx
        uy7W2xdcZWz4Xd8mMi2hZ6LvWvMF86wkd7Fm8fJGRk9TYinOSDTUYi4qTgQAvrHn7U4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvK6zoHKiwd7HJhbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGcdmk
        pOZklqUW6dslcGXMvr+PpWAiZ8W/ix/YGhi/sncxcnJICJhI7J+5nKWLkYtDSGAHo0Tb65ss
        EAlpiWMnzjB3MXIA2cIShw8XQ9R8YJR4OeE0O0icTUBb4s8WUZByEYF4iZsNt8HmMAusZ5Y4
        +7oJbI6wgJ3EnuWnWEDqWQRUJT5tFgYJ8wrYSJxYsZIVYpW8xOoNB5hBbE6g+MdJrxhBbCEB
        a4k/e9YyTWDkW8DIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhmtLR2MO5Z9UHv
        ECMTB+MhRgkOZiUR3r9MyolCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MPVKK6lNKHezWyWnnLdq6d9izQ91aW0Pqhsurlh5951oyrZ7/ya/WP9M5Xm4
        y3oHy+uSyhkdy1N4+9uO/VsoonHlx5SY345maZItZVpFp3Ke32uzLxfnuffm9fsJl9UK3LUk
        3NhuT7l4huF63Mo1f4Ujz6l93sv2nz8k6NLqkhu2huGVAskc8Xlrln2+kd1fYZwbx7s2Z63i
        f/05c2TVk6INhOta9li9+s38VaR/T0/QMZV7WzWdzn+8Ll9ayxPre5g7qaXqTf+/7ounlzFW
        r5jY9qwwfHrEOZ4KkaQ5wkxF8btWp81YvmhPV7O1hg1jjvuW41xznjyXzaiXalvR9VSXbXvv
        sWMFZ2Okbk2RV2Ipzkg01GIuKk4EAF3QS6QIAwAA
X-CMS-MailID: 20210823030851epcas1p3df6319948e331e2e0225adba4e81e660
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210823030851epcas1p3df6319948e331e2e0225adba4e81e660
References: <20210823025816.7496-1-namjae.jeon@samsung.com>
        <CGME20210823030851epcas1p3df6319948e331e2e0225adba4e81e660@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself, Steve French, Sergey Senozhatsky and Hyunchul Lee
as ksmbd maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd25e4ecf0b9..bb717e6065c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10103,6 +10103,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL SMB3 SERVER (KSMBD)
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
+M:	Steve French <sfrench@samba.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-cifs@vger.kernel.org
+S:	Maintained
+T:	git git://git.samba.org/ksmbd.git
+F:	fs/ksmbd/
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendanhiggins@google.com>
 L:	linux-kselftest@vger.kernel.org
-- 
2.17.1

