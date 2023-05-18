Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4752A708599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjERQH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjERQHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 12:07:24 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649110D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 09:07:20 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230518160715euoutp01638462ba0c5b881feeef6af786c8d8d9~gSI4a1Q1m2943729437euoutp01N
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 16:07:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230518160715euoutp01638462ba0c5b881feeef6af786c8d8d9~gSI4a1Q1m2943729437euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684426035;
        bh=lfsfWIak2/lXdx5NVY8wEEwwI/za6yUH6qUoycYnH8c=;
        h=From:To:CC:Subject:Date:References:From;
        b=LE1+lz7KGhpMlCbCGCMlHXZlMw99jhOhknwndJ5QnXHrEc6WDXVnPLvyxO8zJbmpM
         pyWc1wrqigScV3K0UpVrpCUfsF0pu/VaV5ec2gGfVnMLtvrie7sHHRjKpxgUwfbWyh
         xxlx9cTFwSnODKN19mqLeYAd3qLyyg/97UsTeOBw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230518160715eucas1p12a72e83fa20d53473d671348f9a951fe~gSI4JnmWd1042510425eucas1p1i;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 82.23.42423.33D46646; Thu, 18
        May 2023 17:07:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc~gSI36fghD2473624736eucas1p10;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230518160715eusmtrp103ae2fec1598b71fb51984e3dbba512b~gSI358MhO1024710247eusmtrp1s;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-af-64664d33e95e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.5C.14344.33D46646; Thu, 18
        May 2023 17:07:15 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230518160714eusmtip2904b3de5e2977fe0df8cccde8f6eeb40~gSI2x1tQH1937119371eusmtip2j;
        Thu, 18 May 2023 16:07:14 +0000 (GMT)
Received: from localhost (106.210.248.97) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 18 May 2023 17:07:09 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 0/2] sysctl: Remove register_sysctl_table from sources
Date:   Thu, 18 May 2023 18:07:03 +0200
Message-ID: <20230518160705.3888592-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.97]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rGvmkpBgeOS1u8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALYrLJiU1J7MstUjfLoEr4+77O4wFdzgqvk6SbmD8z9bFyMkhIWAise7JGvYu
        Ri4OIYEVjBIz5u5ng3C+MEo0d95iBKkSEvjMKNGzwwam48fyWewQ8eWMEguumcDVtB/mg2je
        wihxe8lrJpAEm4COxPk3d5hBbBEBcYkTpzczghQxC+xkkjh94hYLSEJYwE1i/5UOMJtFQFWi
        sWM9K4jNK2Ar0dj+jRVis7xE2/XpjBBxQYmTM5+A1TMDxZu3zmaGsCUkDr54wQxRrySx/fZM
        qN5aiVNbbjGBLJYQuMEh8fjWAmgAuEg8fTQFqkhY4tXxLewQtozE6ck9LBANkxkl9v/7wA7h
        rGaUWNb4lQmiylqi5coToAQHkO0osXueD4TJJ3HjrSDEQXwSk7ZNZ4YI80p0tAlBNKpJrL73
        hmUCo/IsJO/MQvLOLCTvLGBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYek7/O/5p
        B+PcVx/1DjEycTAeYpTgYFYS4Q3sS04R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9
        sSQ1OzW1ILUIJsvEwSnVwFT1Xir6zC2F4r29dvLOTOE6UWc/npsx2Tr0ycc3u93fms0XntLo
        03Tun2Qcf63yvFdt2n5vS2I051w2yGLQijrsPYetIDV2x9IN8yv0im6cCL/3JFsonyHrnpLE
        /D2dedGXm5j6lFx7WnVe/Dru8KqJKyhVgGddzF7xQ8UXn3JsX7HE9VfxetltS+LD2BaF11st
        702cxhqx3Hpb1NfJiZ/XRnEGB7Q+kXiTdiwh0cDwycyqo6td/2fN9JY2lg+1Fs045ihz41LP
        EqGDr622tRvZc3+4ee+WTf6DmWZXDSTuC376/VtBvHThX7GW9i/zDuQatrjav1R8d+Vl1e/J
        8Rd5FSt+hl2eelFaR8T+pxJLcUaioRZzUXEiAJgOCBqsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7rGvmkpBtd6OSxeH/7EaHGmO9di
        z96TLBaXd81hs7gx4SmjxYHTU5gtzv89zmqxbKefA4fH7IaLLB47Z91l91iwqdRj06pONo/P
        m+Q8Nj15yxTAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXcff9HcaCOxwVXydJNzD+Z+ti5OSQEDCR+LF8FnsXIxeHkMBSRolXiw+xQyRkJDZ+
        ucoKYQtL/LnWBdYgJPCRUaLzgzpEwxZGiX1/L4M1sAnoSJx/c4cZxBYREJc4cXozI0gRs8BO
        JokV9yaDTRIWcJPYf6WDBcRmEVCVaOxYDxbnFbCVaGz/BrVNXqLt+nRGiLigxMmZT8DqmYHi
        zVtnM0PYEhIHX7xghqhXkth+eyZUb63E57/PGCcwCs1C0j4LSfssJO0LGJlXMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBMbatmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8gX3JKUK8KYmVValF
        +fFFpTmpxYcYTYH+mcgsJZqcD4z2vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC
        1CKYPiYOTqkGJt2AFOHGuxnb5+uvTLtxaE345eeP53Gt8NgkHOfKdsKx+rzY5mIhK1/Lj/p/
        Flg9eCxasdvzHvOcmVLHWVatmKbUIa3kqdzx7vWNzgOKzUsunDbrKbKOLeQ9wDjpS4CXsZ72
        XiHVyAfnpY7NFeD0uPTz16OJKWu/SNW4n8/a1TbhoQrnBE8zvhsp4YIzlzhnpvVF2VoxlEsI
        /vG491zMxpGVl/GjZOnOdIaFXPFCWg9u9yupie9kuPRqPdO9R/fL//+X2PusnTUyV82eSWrJ
        sg/5Fkev32uwjP282fTTNsW6n3VzmjqaGX0lrh96GNuYsNjoW/+cUyz7HS/OMBaNnVSxepsW
        b3J6kse7305qSizFGYmGWsxFxYkAlaQyVT4DAAA=
X-CMS-MailID: 20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc
X-Msg-Generator: CA
X-RootMTR: 20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc
References: <CGME20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. This patchset completely removes register_sysctl_table
and replaces it with register_sysctl effectively transitioning 5 base paths
("kernel", "vm", "fs", "dev" and "debug") to the new call. Besides removing the
actuall function, I also removed it from the checks done in check-sysctl-docs.

Testing for this change was done in the same way as with previous sysctl
replacement patches: I made sure that the result of `find /proc/sys/ | sha1sum`
was the same before and after the patchset.

Have pushed this through 0-day. Waiting on results..

Feedback greatly appreciated.

Best
Joel

Joel Granados (2):
  sysctl: Refactor base paths registrations
  sysctl: Remove register_sysctl_table

 fs/proc/proc_sysctl.c     | 70 ---------------------------------------
 fs/sysctls.c              |  9 +++--
 include/linux/sysctl.h    | 23 -------------
 kernel/sysctl.c           | 13 +++-----
 scripts/check-sysctl-docs | 10 ------
 5 files changed, 10 insertions(+), 115 deletions(-)

-- 
2.30.2

