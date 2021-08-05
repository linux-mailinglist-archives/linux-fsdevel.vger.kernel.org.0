Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1453E0E24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 08:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhHEGRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 02:17:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21534 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbhHEGQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:16:21 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210805061606epoutp04f474ef597c0c0e2a837a803825954ff3~YVH5bGXPL0503205032epoutp04H
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 06:16:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210805061606epoutp04f474ef597c0c0e2a837a803825954ff3~YVH5bGXPL0503205032epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628144167;
        bh=+aefw9YmR8ixzOeT3MC6RG5++GYXr7OPXg+3k54Z0dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu1rlmy4lkQynolqNKlShWqSe6OIflR4rOCBn8QDw/xLEe41D0MBZ2VGErqLkeAV6
         kOPAXckOpSREIH1kOL/dZksEioZf0mRaddpuWVmb971FalvvTgHtJ3Z0s+pQuqxT57
         jCpXgmvJ+Vam8564fjwVpBg66Q8orvSUJqE/6oYw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210805061606epcas1p1d6c9b724bf8607d8cd3add7724376939~YVH44UpCU2234222342epcas1p1Q;
        Thu,  5 Aug 2021 06:16:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GgJJj2nP6z4x9QF; Thu,  5 Aug
        2021 06:16:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.F7.10119.5228B016; Thu,  5 Aug 2021 15:16:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210805061604epcas1p2ed43153ae466204980ab8200699e0925~YVH3akPGW3126831268epcas1p2b;
        Thu,  5 Aug 2021 06:16:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210805061604epsmtrp19c115cdb6b42785e0ecbc5f2ca1f0820~YVH3Zq-Qu1607716077epsmtrp1I;
        Thu,  5 Aug 2021 06:16:04 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-44-610b82252839
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.EA.08289.4228B016; Thu,  5 Aug 2021 15:16:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061604epsmtip1268623f17bc960f455216a191c0de1b3~YVH3KAvFv3046330463epsmtip1h;
        Thu,  5 Aug 2021 06:16:04 +0000 (GMT)
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
Subject: [PATCH v7 13/13] MAINTAINERS: add ksmbd kernel server
Date:   Thu,  5 Aug 2021 15:05:46 +0900
Message-Id: <20210805060546.3268-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805060546.3268-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRifs3f37l1q4wZSJ5xBvEYFyrrLAh5tIZkYuzPhzDY5QyMCXuEO
        EHcf7QOtaQqcNAYUsGQQcBEhCiQN2ZWWBYxAwNVhGIghxJikMFZ5CBImj832gdV/v/Od3+N8
        3zmHwPza8EAiS21gdWqGo3Affkt3aHh4yNFnGGnpF/6ob9opRHlzW9D032V8dLOkhocaGnt4
        aOTXB0LkeGLD0PKTvwBq77Dz0U+2szga/HqZjx6XfYpOFj0UoGPDYajtcg2OZhzdOBo7dQ5H
        A84+AVp9fBbf7U87TQsYXZk7yKdbK8aFtLk+jG6rXuTRbbdycfqY1SmkF+6O8WmTrQjQRZYL
        gLbUTvDoxeYgunlylqcU7+cUmSyTzuqCWXWaJj1LnRFDvf1u6pupUdFSWbhsJ9pBBasZFRtD
        xScow/dkca42qeAchjO6SkpGr6e2xyp0GqOBDc7U6A0xFKtN57QyqVaiZ1R6ozpDkqZR7ZJJ
        pRFRLuZBLnPUbBFop4gjA2t2fi4YEBYAEQHJSDj2TQVwYz/SCuDM90kFwMeFHwJoni3neReL
        AH416OQ/VdyuWcG8GzYAV6oKsX8lqxNrLhZB4ORWuGYJcAs2kMlw1Drt4WBkJQanOm54nPzJ
        WDjQm+/J5pMhsGDa4cFiUgFLewtxb9om2NjUibmxyFW/32gWuI0gOUrAny/VAHcYJOPh+fwD
        Xr4/vN9nWe8tEN4rPr6OD8Pr9hWeF38Mm6quCr1SOTzhMLghRobC72zbvYzNsHXV5DkNRj4H
        55ZOCLxsMcw/7uelhMCioe51w42w4PP59SAaLraYce9EigE0zQ1jJSCo4r+EagAugBdYrV6V
        wepl2sj/31cz8LziMGQFptl5SRfgEaALQAKjNojTan0YP3E68+FHrE6TqjNyrL4LRLlGdwoL
        DEjTuL6B2pAqi4qQy+UoMnpHdJScelH8KHnpoB+ZwRjYbJbVsrqnOh4hCszlaYwpr1ItAw2d
        Jfvr93AipSDZWSN4lHBx4zvzk0f6Uwps7182dk0deKkM+9ZyxkjO5cR3OkPloU3brs32q1Dc
        n1+K9rX13DmXeOn2JoVh2vT8ruv2kfHJoJTeka1OZdEPndgNsts6/EZj0q0HTI9IsZDovwWv
        ELzcNWTOS979u27cnqCMOxTw+hXJ6hDXU6sy+gSFiO/EfuA7u3kxDAxL4irfqjaEjp/J6W2I
        qyslWrP3+jiOJm1rL2ej3zt9Mk4kKX3tx5m8jnZp8s0rEReXOeuz++oOnT7c6HtVEfBZcfpv
        n2TnVv5R9UtLbP0r93Zyafby1brawtGKkMR+36VrjrGJuxRfn8nIwjCdnvkHylXWvE4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnK5KE3eiwcOV2hbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGcdmk
        pOZklqUW6dslcGXc2LyFteA5R8X5PydZGhjPs3cxcnJICJhI3F70i7mLkYtDSGAHo8TbCztY
        IRLSEsdOnAFKcADZwhKHDxdD1HxglHjxfzUrSJxNQFvizxZRkHIRgXiJmw23WUBqmAXWM0uc
        fd3EApIQFrCTOH+sgxHEZhFQleh6/QLM5hWwkZh6rJsNYpe8xOoNB5hBbE6g+KvVm8FuEBKw
        lnj/9hrzBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNGS2sH455VH/QO
        MTJxMB5ilOBgVhLhTV7MlSjEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDk4Lt8p70t8bijovZs+LOzOpRmaRq+WaV9Vaesq64zZ4zXhrqif04v74603V5
        RlPW3Ugjy+sqkktZgx+xXIwqnrxowvQ3j7ZmF9mvn36U5fctvi+BP7R0WS/ebJgk7PAyQe7p
        sY/vVr9WrmvlSm3YtjIgwWm3UKXbywPnTXmdVrtMFDjAVsj6LTssevWHO/9Z2d6cPhKylG33
        3w/qemY2V08rqmafvHdfTKZNS9U82UeheLkEw+73Do2nrthLnfsentCld8nzqtdWi6DCGYH/
        l6afXPauQcSZW/qzU4K/LPfME0zTN6VcZF3/ooi18axUhLbRvS6mfUIPpnRd51ziN2vKTb41
        j1g+vfjOm1HzRYmlOCPRUIu5qDgRANqp3soJAwAA
X-CMS-MailID: 20210805061604epcas1p2ed43153ae466204980ab8200699e0925
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805061604epcas1p2ed43153ae466204980ab8200699e0925
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
        <CGME20210805061604epcas1p2ed43153ae466204980ab8200699e0925@epcas1p2.samsung.com>
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
index c9467d2839f5..ff1c31cce114 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10103,6 +10103,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
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

