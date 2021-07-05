Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB533BB57D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGEDUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:20:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26114 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGEDUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:20:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210705031737epoutp02de2e55e1f2f9f43ba4fdd30daa9f1eb9~OxsNDye7r0869208692epoutp022
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 03:17:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210705031737epoutp02de2e55e1f2f9f43ba4fdd30daa9f1eb9~OxsNDye7r0869208692epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455057;
        bh=//z18A8yEe6HZaQDVeR7zO5jUtfPzAs2XyKlKaZ7lDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiVCRILLDvFm2mqOCR+x8BPGAYZeamyUiGjxJ8BMhkW4fdZD0jQf9khK4K2CaBVf7
         JVmc+YYDTwoNg0K/yyab8uOu8OqN+v7Kn2/iydaV5DIW8LgBHpLqDMwpSg9D4QkERo
         C8RhThSegRGgt8Op2NIRGfYZbm0I353dlTIztgIo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210705031736epcas1p4fb3b739056ef2f94447d893d19f08c25~OxsMTx0ZC0813108131epcas1p4R;
        Mon,  5 Jul 2021 03:17:36 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GJ9q34VdHz4x9Q1; Mon,  5 Jul
        2021 03:17:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.9F.09551.FC972E06; Mon,  5 Jul 2021 12:17:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031734epcas1p232641a646669d8c52307471903ad7904~OxsKpPYxD1374013740epcas1p2k;
        Mon,  5 Jul 2021 03:17:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705031734epsmtrp287a06064ab64cb7af81a76549c58b7d6~OxsKoeakV1726817268epsmtrp2G;
        Mon,  5 Jul 2021 03:17:34 +0000 (GMT)
X-AuditID: b6c32a36-2b3ff7000000254f-9c-60e279cf2bcf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.BB.08394.EC972E06; Mon,  5 Jul 2021 12:17:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031734epsmtip2eea6e64fbeeab95856abd1fd4952b740~OxsKWMF-X2672126721epsmtip2U;
        Mon,  5 Jul 2021 03:17:34 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v5 13/13] MAINTAINERS: add ksmbd kernel server
Date:   Mon,  5 Jul 2021 12:07:29 +0900
Message-Id: <20210705030729.10292-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmge75ykcJBnMaxS0a355msTj++i+7
        ReM7ZYvX/6azWJyesIjJYuXqo0wW1+6/Z7d48X8Xs8XP/98ZLfbsPclicXnXHDaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FotH35ZVjB5bFj9k8li/5SqLx+dNch6bnrxlCuCNyrHJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAXpTSaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFCgV5yYW1yal66XnJ9rZWhgYGQKVJmQk9E+
        8SRrwVOOiuurVzM2MJ5l72Lk5JAQMJGY+rmHtYuRi0NIYAejxKKl55khnE+MEh9Pv2WHcL4x
        Sny/fIwFpqXn7zcWiMReRonVTb8QWu49nwbkcHCwCWhL/NkiCtIgIhArcWPHa7AaZoHZzBK3
        dm5hBUkIC9hJnJ8xhwnEZhFQlZjV/BrM5hWwlZjy5yfUgfISqzccYAaxOYHie7uuskLEb3BI
        bD1vB2G7SHw/uReqXlji1fEtULaUxOd3e9kg7HKJEyd/MUHYNRIb5u1jB7lTQsBYoudFCYjJ
        LKApsX6XPkSFosTO33MZQWxmAT6Jd19BQQRSzSvR0SYEUaIq0XfpMNRAaYmu9g9QSz0kJmze
        Bw23CaBAnMY0gVFuFsKGBYyMqxjFUguKc9NTiw0LjJAjbBMjOBlrme1gnPT2g94hRiYOxkOM
        EhzMSiK8ofPuJQjxpiRWVqUW5ccXleakFh9iNAUG3URmKdHkfGA+yCuJNzQ1MjY2tjAxMzcz
        NVYS593JdihBSCA9sSQ1OzW1ILUIpo+Jg1OqgWlFxIfN27ymHH/jt/3FJ9ONvMEsRhxT737l
        6l779mFabvHuO5s7dONmBO88s1bdj3dnEq/s4nMP/EKO3j6iOU3GYve+58sTz2lW7NXhvvC9
        43tL+gTlHs+n+z4crb4kdeGiuaBTxiSlQ5Hrpk72usawRSOuXTnk6Nu9BoInru4VTXN+t+Vr
        IsM2i9TE225Cj/fFHlqSfu38kaO6Xx98NmlZxzLv/HVWXcvlUkuKZFOfTcpc1/z+yL+m1Qo6
        k/4Lf7V8ZLFkFUtep8KBm8/e3pgfoFYicrTw5K9rOx+d21qqZfZk7TKh3XcN2bhVXlevC/Fy
        sLHf3B96a1fZwf8tZVkG1yct41dqF/yV6sw/ketIphJLcUaioRZzUXEiAIH2nChPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO65ykcJBp92aVs0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAbxWWT
        kpqTWZZapG+XwJXRPvEka8FTjorrq1czNjCeZe9i5OSQEDCR6Pn7jaWLkYtDSGA3o8Skts+s
        EAlpiWMnzjB3MXIA2cIShw8XQ9R8YJR4NWMeWJxNQFvizxZRkHIRgXiJmw23weYwC6xnlngz
        9RcLSEJYwE7i/Iw5TCA2i4CqxKzm12A2r4CtxJQ/P6GOkJdYveEAM4jNCRTf23UV7AYhARuJ
        7p8/WCcw8i1gZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcNVqaOxi3r/qgd4iR
        iYPxEKMEB7OSCG/ovHsJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTAZn5/ppSqzT/fE7NSaC+IH+G6erTnH+2FD0TIhjrh/xy4Zln1xc+PY17n4nUfb
        uvt5N8wz2mZ2tPGYzUtK8ePIO8fU8/z3x3t2k0M1Ez2dLM7ujO0/9mZLq24+D8ss9xldz462
        Pph4JbWxYEHConm+k+55TF2uo84iYCI85ZuYwWtfAy2zoGkHGz91FnloTZ+Tvzbbtjp0ofr1
        i0s7XrZ69fK5Vu3pfNGmrGnaYehy4sHuP3/jFOVk3/7pZFkttVnmyc67CmFfF6/9N2/RgX+f
        9nx/EMDIpRFrns5R8G6Cm93a4NYrb3cJTT16wW7CD6lpB/2X502ZpJ540PnXhc2zE/5p8XCu
        0Yv4t/rQqV2WSizFGYmGWsxFxYkAPhy3+QkDAAA=
X-CMS-MailID: 20210705031734epcas1p232641a646669d8c52307471903ad7904
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031734epcas1p232641a646669d8c52307471903ad7904
References: <20210705030729.10292-1-namjae.jeon@samsung.com>
        <CGME20210705031734epcas1p232641a646669d8c52307471903ad7904@epcas1p2.samsung.com>
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
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..73b2f896a2ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9938,6 +9938,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL SMB3 SERVER (KSMBD)
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
+M:	Steve French <sfrench@samba.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-cifs@vger.kernel.org
+S:	Maintained
+F:	fs/ksmbd/
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendanhiggins@google.com>
 L:	linux-kselftest@vger.kernel.org
-- 
2.17.1

