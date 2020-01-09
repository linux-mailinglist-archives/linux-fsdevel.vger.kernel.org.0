Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702091363F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgAIXl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:41:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28955 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:41:56 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200109234152epoutp01bbb650ef62ab5c16219909a616210dea~oXHG6SEra1550215502epoutp01K
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:41:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200109234152epoutp01bbb650ef62ab5c16219909a616210dea~oXHG6SEra1550215502epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578613312;
        bh=KwyYt9GohRntySXnK1nN8DCmHASlL3/7ZQc7K5hba4g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SSOqtpNr99HIA6KIMnl0k16OlC4nU5+z99FQUMDefzRgbAq8HmcQVO785aRQDKUEF
         mFWvGWxZybFtaDteksIAqctWTYCS1ISxkOnd+s8adUnjjqnDLSm/Ij7ttdKq1eByIi
         hjo0CoTG0IYfRrpC7eUAKw1apJG2T1CnHR/1H9jc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109234151epcas1p2177dc9e8d2a0f44d2f4ba639379dcee7~oXHF-vHtE2487224872epcas1p2R;
        Thu,  9 Jan 2020 23:41:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v2hH1QpMzMqYkg; Thu,  9 Jan
        2020 23:41:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.B0.57028.F3AB71E5; Fri, 10 Jan 2020 08:41:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109234150epcas1p2be9eb338c0cdb94ab8c8594cc9e205d6~oXHE3z_uE2487224872epcas1p2Q;
        Thu,  9 Jan 2020 23:41:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109234150epsmtrp10d10937bf24957fee0833d9ce424a66e~oXHE24gqt2767527675epsmtrp1M;
        Thu,  9 Jan 2020 23:41:50 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-5a-5e17ba3f9993
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.07.10238.E3AB71E5; Fri, 10 Jan 2020 08:41:50 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109234150epsmtip259f3d7e226ebc814761b3f66dd66cece~oXHEumi0c2087320873epsmtip2a;
        Thu,  9 Jan 2020 23:41:50 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <hch@lst.de>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>, <tytso@mit.edu>
In-Reply-To: <47625.1578607455@turing-police>
Subject: RE: [PATCH v9 09/13] exfat: add misc operations
Date:   Fri, 10 Jan 2020 08:41:50 +0900
Message-ID: <002101d5c746$5d69a360$183cea20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwHz+Lr1AtmMBwQCEsM+eAKdGL6aAbsqjWgBsAu59qaDEkNw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjtOrMzY7Q1reZ+aNQ2YKGg7bStjqU90GqhInsRKGmTTq60L3ZW
        ySKSyq1M7IGQrVaW9Fq1DVFzfWCZEpYlFplWFkSBGloZPcxeuztG/jvfuef7zj33fhSmqCKC
        qUyTTbCaeANDTMXr7oZFRixvUKaoO3/6c4fKXQR3vaLdj3vW/xzjmpo7cO5JQynB1fxuk3F5
        BWMkV3D1KbGC0rkd/aSu5VwlqWvsyyV0BzvbMV1hjRPpPlfPSSSSDLF6gU8XrCrBlGZOzzRl
        xDFrN6fGp2qj1GwEG8NFMyoTbxTimIR1iRGrMw2eCzGqbN6Q5aESeVFkFi6LtZqzbIJKbxZt
        cYxgSTdYWLUlUuSNYpYpIzLNbFzCqtWLtB7lDoP+5aNXfpZccs/pih94LnLL8pE/BfRiaLYP
        E/loKqWg6xGMlTgnilEEL1pKZFLxFUHbvVo8H1G+liM9GyS+GUFf7YWJjkEExR+6Se9cgo6A
        3z9bCC8OpBOg53g55hVhdB2Ci/VdvgN/j6hspMeHA2gO3rfdJrwOOB0Kfzo5Ly2nY+D17RtI
        wjOh4+xb3Isxei7cGi7FpAwqGHt3ReZtDaSToPI6SJJAKDlm99kCPU5A8TfXhD4BjnfnIQkH
        wNC9GlLCwTB4wk5KIffBp5YJ+VEEA9/iJKyBPtdNnxVGh4GrYaFEzwP3+Dkk2U6HkS8FMmmK
        HI7aFZIkFAof3/WTcAjkH/lInkSMY1Iux6RcjkkBHP/NyhDuREGCRTRmCCJrYSd/dTXyrWq4
        th4VPVrXimgKMdPk+gBlikLGZ4s5xlYEFMYEytt7g1IU8nQ+Z69gNadaswyC2Iq0nlc/hQXP
        SjN7Ft9kS2W1izQaDbc4KjpKq2GUcup793YFncHbhN2CYBGs//r8KP/gXFTUJuYlX3owY4tF
        WBX6oOowD2HRvV/JpUNKmxnbOP/gFSKlWrmra0GnfrTJ0dhR1T8dz97kzEkoe3g+XHF/wzb7
        5YFf5bM1Qc3rQwY5bOdWIj5v5YJrA12bhva/dv1on2KsfTKSpFpz4M/IIcKd1oOcpcNR45fd
        yb3sDkXBmTtvGFzU82w4ZhX5v0JdbcLAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvK7dLvE4gxtdmhbNi9ezWaxcfZTJ
        4vrdW8wWe/aeZLG4vGsOm8WWf0dYLVp7frJb9Cy/yubA4bFz1l12j/1z17B77L7ZwObRdOYo
        s0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl3Dl3j6mggb1i0upfLA2MO1m7GDk4JARMJNqv
        +XcxcnEICexmlLj/7RZzFyMnUFxa4tiJM8wQNcIShw8XQ9Q8Z5RYvG09I0gNm4CuxL8/+9lA
        bBEBF4lr3YuZQYqYBfYxSjy4eIQZouMck8Tl90tYQao4gToWvLsG1iEsYCHx+sgBNpANLAKq
        Ev/PWICEeQUsJe4fWMcIYQtKnJz5hAXEZhbQlnh68ymULS+x/e0cqEMVJH4+XQb2jIhAlMSa
        lRIQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0
        veT83E2M4PjS0tzBeHlJ/CFGAQ5GJR7eDGHxOCHWxLLiytxDjBIczEoivEdviMUJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwKhkeVx18+PWqKYMhYWT
        mUSuWOwzkJ77y+9Y1AQz7fSlth/9M8NmKJkukJJ0zMvz/PDw4HHTveVCpjybz89/7/mTw1/x
        7Q4DP4srNdnPTBNiRZg3eRZLzIriSj3qZvN4ttW5pdvkpHVl8zimPFkZ9CeHY6OYgyizlH38
        xFUfeOQ1FS/ONzzLpsRSnJFoqMVcVJwIAAaOprqrAgAA
X-CMS-MailID: 20200109234150epcas1p2be9eb338c0cdb94ab8c8594cc9e205d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
        <20200102082036.29643-11-namjae.jeon@samsung.com>
        <20200105165115.37dyrcwtgf6zgc6r@pali> <85woa4jrl2.fsf@collabora.com>
        <20200107115202.shjpp6g3gsrhhkuy@pali> <47625.1578607455@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> When compiling on a 32-bit system like Raspian on an RPi4, the compile
> dies:
> 
>   CC [M]  fs/exfat/misc.o
> fs/exfat/misc.c: In function 'exfat_time_unix2fat':
> fs/exfat/misc.c:157:16: error: 'UNIX_SECS_2108' undeclared (first use in
> this function); did you mean 'UNIX_SECS_1980'?
>   if (second >= UNIX_SECS_2108) {
>                 ^~~~~~~~~~~~~~
>                 UNIX_SECS_1980
> fs/exfat/misc.c:157:16: note: each undeclared identifier is reported only
> once for each function it appears in
> make[2]: *** [scripts/Makefile.build:266: fs/exfat/misc.o] Error 1
> 
> The problem is that the definition of UNIX_SECS_2108  is wrapped:
> 
> +#if BITS_PER_LONG == 64
> +#define UNIX_SECS_2108    4354819200L
> +#endif
> 
> but the usage isn't.
My mistake, Thanks for your check. I already fixed it on my git through
the Pali's report.
It will be in v10 patch.

