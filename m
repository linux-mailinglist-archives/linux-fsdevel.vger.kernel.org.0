Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5A3CAFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhGPAHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:07:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52313 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhGPAHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:07:03 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210716000407epoutp012aa84fa763186db5e661d87b96156b3e~SHJZoLZhi2050320503epoutp01x
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:04:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210716000407epoutp012aa84fa763186db5e661d87b96156b3e~SHJZoLZhi2050320503epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393847;
        bh=CRJRQe3m2+3RRcMgVVGpE5MfBuHe9Flf/VO5Hi9RlAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnSK90ALngp2O//2vS1PUbwmqdLIPw9X5ct6Sk2EAIRjddz8iUtIq5cIjn6YC6oS8
         biYzEPfB3h2u2lyVT/5J9hdlkAmoiIPbujuFkmun1hanZeYEX1zuOqRY9CyveopN5D
         +gNzt4p1dSz/DfG+rmw/Ky4Cs9JtkR/ZK52HJbkw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210716000401epcas1p38c7686900985a80bc48ccfb74ade607f~SHJT617xd2760827608epcas1p3a;
        Fri, 16 Jul 2021 00:04:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GQs0b2N7Sz4x9QB; Fri, 16 Jul
        2021 00:03:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.0E.13454.FECC0F06; Fri, 16 Jul 2021 09:03:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210716000357epcas1p33ac820775b679f429872e936195a7fb1~SHJQNVV9F1532815328epcas1p3R;
        Fri, 16 Jul 2021 00:03:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210716000357epsmtrp29960d5c33c728224287236faac681f3d~SHJQMXQHZ1353413534epsmtrp2v;
        Fri, 16 Jul 2021 00:03:57 +0000 (GMT)
X-AuditID: b6c32a39-16fff7000002348e-df-60f0ccefe7a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.0B.08394.DECC0F06; Fri, 16 Jul 2021 09:03:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000357epsmtip246e0e7460953f5ade0496f8cfac5f212~SHJP6Lw0d1854418544epsmtip2l;
        Fri, 16 Jul 2021 00:03:57 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, willy@infradead.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v6 13/13] MAINTAINERS: add ksmbd kernel server
Date:   Fri, 16 Jul 2021 08:53:56 +0900
Message-Id: <20210715235356.3191-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjOd87p6QHXcSzKvsCGpQYzcRRaaP1EcBJwO9kwYtzVoPSEngCh
        t/SUMQlsLFNmgIE6DYJyiUygmAWG1ZUCk4CGkRErzE00cWQIEeV+EZxQWEtx27/ne97nfd7L
        91K4uIn0p9L1Zs6kZ7VS0pu43rVdFjrVO60Ovz3tg7rHnEL01eRWNLZSSqBfT13CkOXKLQz9
        MTglRKOrdhz9vboIUFt7D4F+s18k0fPSL9G3xbMCdOJuCGr98RKJxke7SPTgdBWJHM5uAVp6
        fpHcK2acFTM4cyGvj2Bayh8Kmav1IUxr9RzGtN7PI5kTNqeQmRl5QDDF1gbAWGv+wpi55kCm
        eXgCS3zlsDY6jWM1nEnC6VMMmnR9aoz0/UPJcclKVbg8VL4L7ZRK9KyOi5HGJySGvpOudQ0n
        lXzGajNdVCLL89KwPdEmQ6aZk6QZeHOMlDNqtEZ5uFHGszo+U58qSzHoouTh4QqlS6nWpi0/
        7RAYH1OfW8qOgzzgEBYALwrSkbDy5IqgAFCUmLYB2LalAHi74CyAj0pspOexAOC1wXriZcLl
        s5VrWEy3A1jet/vfjLmuhjUnkt4Bl62b3ZpN9BE4YBvD3RqcLsDhyGAv5g740nvg+NUzwI0J
        Ohj2Dt9Z40V0NLzx5BrmKbYFXmnqwN3Yy8U/6lkAbiNI91Jw4Pg93COKh0N1haQH+8Kn3db1
        0fzh3GT7Op8Ff+l5sW6aA5sqfxa6G4V0BCwaNbshTm+HjfYwjyIItixVrLWG06/CyWdFAo9a
        BE/miz2SYFjc37VuGAALvpleL8rAjqIFwrOSEgDHlweIUyCw/L8K1QA0AD/OyOtSOV5uVP7/
        u5rB2umG7LKB0olpWSfAKNAJIIVLN4kuKybUYpGGPZbNmQzJpkwtx3cCpWt3p3H/zSkG1+3r
        zclypSIiIgJFqnaqlBHS10QtZKdaTKeyZi6D44yc6WUeRnn552HVhe+pk8a3vZmj8tn/0dvN
        8+8O8ZjqLkpQ6L4OSDX4NUmO6TbUnrPk+tycIufmay39PW3z1FDod4dgQE3FG0fDhiXK85ao
        npGHusIf1IT/66KmJ4tejTkOZonKCM3yibZ7y/Z+D1/k59JMjTD/qGLRWX7wp6oaS50hiqoS
        lClX/kxq/X3fhS/S486znxgff3zGL0iHns3sm6p2+N788OxbdwrJCrneujs2u+y+5tPII0Wi
        W7GtWTGq7JzaVeNhipwUxAYn2CUbtlqzqxpL7t2u7w+i42ZbbtQON39QlxFdcW4wqTt+x/7h
        7kVJlCOz3rBx44H43G19RoUlUHW9wzQiJfg0Vh6Cm3j2H2r8jcZDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO7bMx8SDE4cVLA4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        GX9eHWAteM5RsXJmC2MD43n2LkZODgkBE4mlU+axdDFycQgJ7GaU+LdgFTNEQlri2IkzQDYH
        kC0scfhwMUTNB0aJLTd3MoLE2QS0Jf5sEQUpFxGIl7jZcBtsDrPAHGaJnRuPMIIkhAXsJN5s
        ngRmswioSpx5coEJxOYVsJHY/3IrE8QueYnVGw6A7eUEij8++Q2sXkjAWmL9mg0sExj5FjAy
        rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4QLc0djNtXfdA7xMjEwXiIUYKDWUmE
        d6nR2wQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFof
        f8qKFL7/wu3i1uMPVq/6d2B/wHV/Sa95/ew/muc/OeitxJYj3Whnpa/9c0or24Xs2N1PLqfI
        lfbEqaY/LVRfPP9leMXOVfc0Js/6ceezXeL+h2L1bXEfne9+zX0pbBFjvpx9Zem3dJnOh7He
        E969MAidcuv0r9SrLst2loj9X3v2zkaTQ6fkFdOK9ToVterO6Tw9Hb2/Okr60pLjB3esX2lV
        UnHMUkxI2XBySo1oZPEd55tB61KONd6tX2Zy8qNe7uy2jav8fAo2WcT/dHzu/OnPwfZ134Rc
        OdO9182YsOWlQXFM+MwrgS5eJ+cvUrC48SF051uBX3MELZ9kTRKav0TU2uaLyfXGjUx5WVeU
        WIozEg21mIuKEwGY/21X/wIAAA==
X-CMS-MailID: 20210716000357epcas1p33ac820775b679f429872e936195a7fb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000357epcas1p33ac820775b679f429872e936195a7fb1
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000357epcas1p33ac820775b679f429872e936195a7fb1@epcas1p3.samsung.com>
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
index 5779f6cacff7..e01a01c3e37c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10102,6 +10102,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
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

