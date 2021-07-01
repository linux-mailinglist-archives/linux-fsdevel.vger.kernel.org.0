Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0E3B925D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 15:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhGANhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 09:37:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25133 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhGANhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:37:34 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210701133501epoutp0352feb09f97cae9d692aaaa8492dc2bab~NriHptMHy3211532115epoutp03T
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jul 2021 13:35:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210701133501epoutp0352feb09f97cae9d692aaaa8492dc2bab~NriHptMHy3211532115epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625146501;
        bh=j5pSR9NRrG55LJkPNFHVjSlXYUUtKLZf6jsJlinp1pc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=DvNQXvcX/yFaFMafS2bQaSS43yTuLCIIjSymKn/fwJfGlfOQX+94uz+bfYMD6AM5c
         XHpuarh5O20c3uY+NjE83ChuZgAxbuOJXZ2iihj012OKZWWDOlxdvA97RGIN7y0KKc
         8edSyeFLR5YjyIY6p82RhMKmbndXkU4Hd1vO9Ek0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210701133500epcas1p11545a4a38ce7bdfbb61070da3b51a960~NriG2QgqL1218312183epcas1p1z;
        Thu,  1 Jul 2021 13:35:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GFzjH35dpz4x9Pw; Thu,  1 Jul
        2021 13:34:59 +0000 (GMT)
X-AuditID: b6c32a37-0b1ff700000024fc-39-60ddc483c367
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.63.09468.384CDD06; Thu,  1 Jul 2021 22:34:59 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] connector: send event on write to /proc/[pid]/comm
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
CC:     =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
Date:   Thu, 01 Jul 2021 22:34:58 +0900
X-CMS-MailID: 20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmgW7zkbsJBtNv81vMWb+GzWLrt0SL
        OedbWCz+b2tht9iz9ySLxeVdc9gsVv87xWixd7+vxa6fK5gdOD22rLzJ5LFz1l12j02rOtk8
        Tsz4zeLRt2UVo8eDSW8YPT5vkvOYcqidJYAjKscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbFU4tYCx5wVBxr2M3SwDiXvYuRk0NCwERi
        /YdrTF2MXBxCAjsYJY62PWPuYuTg4BUQlPi7QxjEFBZwlrg1UxLEFBJQlNh22g2kU1jASmJa
        3z8mEJtNwELi+dqfrCBTRARamSSufHjBDuIwC7xmlJjZuYEZYhevxIz2pywQtrTE9uVbGSFs
        UYmbq9+yw9jvj82HiotItN47C9UrKPHg526ouKTEzba7LCALJAT6GSXur2uBciYwSix5MokN
        ospc4tmGFrCpvAK+Em8ONoHFWQRUJQ7e3gc11UXi4coNYD8wC8hLbH87B+x5ZgFNifW79CFK
        FCV2/p7LCFHCJ/Huaw8rzDM75j1hAimXABq57LcHzF990y+zQYQ9JNa8EwUJCwkESnxc080y
        gVF+FiJwZyFZOwth7QJG5lWMYqkFxbnpqcWGBcbI8bmJEZw4tcx3ME57+0HvECMTB+MhRgkO
        ZiUR3gnT7yYI8aYkVlalFuXHF5XmpBYfYjQFengis5Rocj4wdeeVxBuaGhkbG1uYmJmbmRor
        ifPuZDuUICSQnliSmp2aWpBaBNPHxMEp1cC0JqAvv7dWwkmwa1sQ/9vdJ1KiLm5jWKSxVOZC
        i/GLBfnyLVXfdhwt09A/OGm9mpbnrQX77s25tPNGXyhjob7RPt7LR45PqDxRtVHmJ69xo2Cx
        Wf19rQVLDGek9TbsrbXWNZvdILBCVqO68/8SY6UpzXnHtOrNGO8eDz5ivI7lKfPJRfp1Dll/
        7V799dL7up/7pLvsxbeZ51/8O1I1tfRUWffWYyybY2bdDhW/ukZ4QYin0E+31KmT15r08Bf9
        iZJe7DOPjU//eSbn2av/Hrv0rLbuFbeQu7VUUue+3ryOL/VScqKzj6w69H2qieB800CGM6ax
        XN+efGCQSDGU9lxSldO+rSsonWX5BM+oy7lKLMUZiYZazEXFiQB5NDYlJQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960
References: <CGME20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While comm change event via prctl has been reported to proc connector by
'commit f786ecba4158 ("connector: add comm change event report to proc
connector")', connector listeners were missing comm changes by explicit
writes on /proc/[pid]/comm.

Let explicit writes on /proc/[pid]/comm report to proc connector.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9cbd915025ad..3e1e6b56aa96 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,6 +95,7 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
+#include <linux/cn_proc.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1674,8 +1675,10 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 	if (!p)
 		return -ESRCH;
 
-	if (same_thread_group(current, p))
+	if (same_thread_group(current, p)) {
 		set_task_comm(p, buffer);
+		proc_comm_connector(p);
+	}
 	else
 		count = -EINVAL;
 
-- 
2.17.1
