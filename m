Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F1211B71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGBFQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 01:16:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59520 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGBFQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:16:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702051638epoutp04f242cf9636bab20d822b49de9013b78f~d17D-gZLQ1719117191epoutp04f
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:16:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702051638epoutp04f242cf9636bab20d822b49de9013b78f~d17D-gZLQ1719117191epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593666998;
        bh=29AhHwJ+dMmDOxIMtvfwnS5s6JZxcmTATgSkpWvx11s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=YcIdAGWwRPMV8zvZeWFJ6RlujktXaX8avh+qhMM0uX1PYjxSHQgVV2RjTRrwBELJG
         9REeOPr0tMeNrIeY6rPCL4/8fZun2PGSLAkSzoDrJZafLr3mncPTvmKtccqy3HgBQq
         O4lxacBdefojc8RpwP1x2NQ6N3FNympjiHn2CFsw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200702051638epcas1p32cc51bf5491c94c6732ab3034da2ce59~d17DuVPp12754027540epcas1p3d;
        Thu,  2 Jul 2020 05:16:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49y5tC0H96zMqYkb; Thu,  2 Jul
        2020 05:16:35 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.1C.28578.2BD6DFE5; Thu,  2 Jul 2020 14:16:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702051634epcas1p234abcaf9a4c2e819dbfb8f1207129777~d17ALxCyi2619726197epcas1p2V;
        Thu,  2 Jul 2020 05:16:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702051634epsmtrp1243d31fe334e04acf49c7b2178117bf5~d17ALIGP50962009620epsmtrp1g;
        Thu,  2 Jul 2020 05:16:34 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-ae-5efd6db2182a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.6E.08382.2BD6DFE5; Thu,  2 Jul 2020 14:16:34 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200702051634epsmtip2b9dc465779cf137d754fa7794385f4ec~d17AA-RVw2075720757epsmtip2j;
        Thu,  2 Jul 2020 05:16:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Park Ju Hyung'" <qkrwngud825@gmail.com>
Cc:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20200627125509.142393-1-qkrwngud825@gmail.com>
Subject: RE: [PATCH] exfat: implement "quiet" option for setattr
Date:   Thu, 2 Jul 2020 14:16:34 +0900
Message-ID: <003801d6502f$f40101c0$dc030540$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFjCjgoG/7FbtfSlJVNByWgm5NQEgFvhuGuqc7MRNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmvu6m3L9xBk+/WFvs2XuSxeLyrjls
        FkcfL2Sz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5KscmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PPjxesBW3MFdvXujcwLmbqYuTkkBAw
        kdg+7x1LFyMXh5DADkaJife+MkI4nxglFs1YCuV8Y5To7r/PBtNy+8lZVojEXkaJ13/vsYIk
        hAReMkrc6jAFsdkEdCX+/dkP1iACZL/dv4oFxGYWqJPY8XMlWJxTwEZi08vPYHFhAQeJmbua
        2UFsFgEViRUPrjCD2LwClhIXd+1ggbAFJU7OfAI1R15i+9s5zBAHKUj8fLqMFWKXlcSU78sZ
        IWpEJGZ3tjGDHCoh8JVdYuH9R0DNHECOi8TWKbwQvcISr45vYYewpSRe9rexQ5RUS3zcDzW+
        g1HixXdbCNtY4ub6DawgJcwCmhLrd+lDhBUldv6eC7WVT+Ld1x5WiCm8Eh1tQhAlqhJ9lw5D
        A11aoqv9A/sERqVZSP6aheSvWUjun4WwbAEjyypGsdSC4tz01GLDAlPkmN7ECE6GWpY7GKe/
        /aB3iJGJg/EQowQHs5II72mDX3FCvCmJlVWpRfnxRaU5qcWHGE2BIT2RWUo0OR+YjvNK4g1N
        jYyNjS1MzMzNTI2VxHmdrC/ECQmkJ5akZqemFqQWwfQxcXBKNTDp+C37vS034Wf+6bxDaaUb
        0vTvmd3X6RDcm7IgbBtbUbdglGL5tVh3gbYTM/ewH22fcYr5f+uOd0GF4U/eL5XcKdHzNnqy
        qAKz9B0Rr39eCRx6S/cd/Lk7LmVbyT3x8hLzB1u3Ff4sO7Q2er2v+emW6a0HPjzOktgdNSUv
        biavls41xSONE2/7GBw8wjPNyO36wdKinx+uGFvJza5Y941jrSnvnbnbli/cW7N13mIDpptW
        Wr/n+wg17v+qpPTgXZKW5htb94NrHpiIrT+T8v/jynkf98+fx5U76cCtaWsNZxxhDvss9liw
        5E9Kljb3/4pQFfvJ/4ttzvEfSWfcNaX2SsWbVyvXZmw5duBk3s45ckosxRmJhlrMRcWJAPTu
        hdYPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO6m3L9xBv23eC327D3JYnF51xw2
        i6OPF7JZbPl3hNWBxWPnrLvsHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXx58cL1oI25ort
        a90bGBczdTFyckgImEjcfnKWtYuRi0NIYDejxO8fh6ES0hLHTpxh7mLkALKFJQ4fLoaoec4o
        8fH0UkaQGjYBXYl/f/azgdgiQPbb/atYQIqYBRoYJXaee8EG0dHLKHF+/j6wKk4BG4lNLz+z
        gNjCAg4SM3c1s4PYLAIqEiseXGEGsXkFLCUu7trBAmELSpyc+YQF5ApmAT2Jto1gi5kF5CW2
        v53DDHGogsTPp8tYIY6wkpjyfTlUjYjE7M425gmMwrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCc
        m55bbFhgmJdarlecmFtcmpeul5yfu4kRHBlamjsYt6/6oHeIkYmD8RCjBAezkgjvaYNfcUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwRZ4p/B7XEBAc
        8tqV9Xejc8nOd6VaG4W2sHKxS6dfnDklcbrT+X4HpcMeXZbX695vkT9uuq1A0lm8errt13MR
        D4vffbx4acF2XYatDSZ7tiSaGe3h9L/KMFFo1aGLd3wvcKV6/Pm/OfnfrE3SrI8047d48Gxp
        SZu3N/pdjIvwezdGlx+cWgbz6iWDle4uSZi2Ifu/nIbsC6fyp9eU85MNOrm1hHtePF85Y/aB
        qNW9u3WY3yzo4p+SqPYhsN/ezjGy+qv0pvLm4vli8d/OCmwV9+xyDPf2NVK4/DDGmsN8H9u7
        aQ/M+CLPPGxkubtwbXdPlWJugv+c4hm7zvTYTZFac4XRPN835flmN8U/zguUWIozEg21mIuK
        EwGGHzId+wIAAA==
X-CMS-MailID: 20200702051634epcas1p234abcaf9a4c2e819dbfb8f1207129777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200627125605epcas1p175ba4ecfbdea3426cc7b0a8fc1750cd0
References: <CGME20200627125605epcas1p175ba4ecfbdea3426cc7b0a8fc1750cd0@epcas1p1.samsung.com>
        <20200627125509.142393-1-qkrwngud825@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
>  	if (((attr->ia_valid & ATTR_UID) &&
>  	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) || @@ -322,6 +325,12 @@ int
> exfat_setattr(struct dentry *dentry, struct iattr *attr)
>  		goto out;
You should remove goto statement and curly braces here to reach if error condition.
>  	}
> 
> +	if (error) {
> +		if (sbi->options.quiet)
> +			error = 0;
> +		goto out;
> +	}

