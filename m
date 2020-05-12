Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019551CEEEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgELIPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:15:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49460 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgELIPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:15:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200512081528epoutp029263d4b9b3f6a174d9a9bde24ca92b0a~OOdpJ-Hsw1235712357epoutp02e
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 08:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200512081528epoutp029263d4b9b3f6a174d9a9bde24ca92b0a~OOdpJ-Hsw1235712357epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589271328;
        bh=jqs4TDpEL0IlO57aJ40jD4Oits9vgvlarKqKQm2otXc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mQ2QlGEjlPsIkwhBxmbCyw97AEMt0UTmjul85KxpdUXamzYdPDsmvJzTZoSdBrpMG
         fJE4q6KrQ0yhmEk84jzJCVvx8oaAgO9qmx3kSydGuWVRebZNZfDtQvpwb1bFl4EQbj
         tnHsmeJxskzJ1r/0ESUxw1jTmj6ipJMeTGB4gDj8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200512081528epcas1p4f836afdda116959fa63f36a82f687734~OOdpABKX_0091300913epcas1p4f;
        Tue, 12 May 2020 08:15:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49LrG70DQmzMqYlv; Tue, 12 May
        2020 08:15:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.0C.04658.E1B5ABE5; Tue, 12 May 2020 17:15:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff~OOdnmWTZ90981009810epcas1p3f;
        Tue, 12 May 2020 08:15:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512081526epsmtrp28ea5fcbac1db5848fd8fa4378ce32e4e~OOdnlaQkw0720107201epsmtrp2w;
        Tue, 12 May 2020 08:15:26 +0000 (GMT)
X-AuditID: b6c32a39-a99ff70000001232-9b-5eba5b1e5c09
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.41.18461.E1B5ABE5; Tue, 12 May 2020 17:15:26 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200512081526epsmtip2f4c2b54d873af0ab98097cd798ea5c7f~OOdna_rR20899708997epsmtip2d;
        Tue, 12 May 2020 08:15:26 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.com>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Nicolas Boos'" <nicolas.boos@wanadoo.fr>
Subject: exfatprogs-1.0.3 version released 
Date:   Tue, 12 May 2020 17:15:26 +0900
Message-ID: <000201d62835$7ddafe50$7990faf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYoKlFwERpUCPhIS8+ZusGyqDKKeA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXd2tiktjnPWw4JaB/rgarq5ZkfJCroNi7L6kBSph3nYRrux
        M6UbYWRmdrfSXBajwKw+WEtKJR1NU0agUJqkVEoXc+K9cnazbUfJb//3eX//9/88PK8Ik9wS
        yEQmq5NxWGkzKYjmP2mOVymX7m/IUvmHUqk3H0aF1LNGP5963VApoApaW/hU0Z8GnDrVqdgg
        0NW73gl1tXf6ebqa2i6+btKzVDf5rgbPwPeZ1xoZOpdxyBmr3pZrshrSyG17sjdma5NVaqU6
        hVpDyq20hUkjN23PUG4xmUMNkPJ82pwXKmXQLEsmrlvrsOU5GbnRxjrTSMaea7arVfYElraw
        eVZDgt5mSVWrVEnaEJljNs6U+zF7teBQacd7XgEqxEtQlAiI1fDC3cIrQdEiCVGH4Of0LUH4
        QkJMIAj2xnH6B4IPjw/NGU7enME4QyOCps4BnDsMIui/3s0LUwJCCX9/eyMvSQk9NA15URjC
        iAcIAp8CESiWWAm/K77ww5pPrICyE8GIQUykQFWgVMjpGPBXfIowGLEMng5XYlwbcpj+XIVz
        AQlQNv4V4xgp3DhTFGkPiGkhjLm9s4ZNMN49JeR0LATaame1DCZHGkPBopA+CuNzeDGCr1Np
        nNbA25qHeBjBiHioaUjkysuh/tdNxMUuhJHv53DuFTEUF0k4ZAVceNXM4/QSKDk9Nhuqg3M9
        F3mX0HLXvCFd84Z0zRvG9T/Yjfj30SLGzloMDKu2a+fv2oMif1ORUoda27f7ECFC5AJxcVJ9
        lgSn89nDFh8CEUZKxYWmUEmcSx8+wjhs2Y48M8P6kDa0g8uYLE5vC/10qzNbrU3SaDTU6uQ1
        yVoNuVh8rducJSEMtJM5yDB2xjHn44miZAWoDLM09n2RjgUPziybyMxRDXc89/hSffFF6R8L
        3peKM2L27fjW+515lH57PTreHn2m3EeNbs3saTuw6ximCBik5Zvv9fEm3LK6dYGzV3ZrZX3G
        4iWt+gV3H1/1KgausYHqnzvTTd5To82DXSXD9vr+oHfiPFSsKvTf2Js45Qm+JPmskVYrMAdL
        /wN20rP4sQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvK5c9K44g95ZMhbX7r9nt9iz9ySL
        xeVdc9gsGo4dYbFo+7uL1aL1ipYDm8fOWXfZPbYsfsjksX7LVRaPz5vkPD7fXc8awBrFZZOS
        mpNZllqkb5fAlfF/+knmghVsFZPO32NqYGxh7WLk5JAQMJFonvufuYuRi0NIYDejxMwFD6ES
        0hLHTpwBSnAA2cIShw8XQ9Q8Z5S4OP8UWA2bgK7Evz/72UBsEYFkiX2v9zOCFDELrGWUuP/v
        JzNIQlhAW+LPzGcsIDaLgKrEtMYfYA28ApYSy15NYoewBSVOznzCArKMWUBPom0jI0iYWUBe
        YvvbOcwQ9yhI/Hy6jBVil57EtI8vmCFqRCRmd7YxT2AUnIVk0iyESbOQTJqFpGMBI8sqRsnU
        guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgeNDS3MG4fdUHvUOMTByMhxglOJiVRHhbMnfG
        CfGmJFZWpRblxxeV5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cB04XJOoIf/
        rinK27hYvEMiejKnFKxec3HK26//smUN7Is9rvSd/sRx95rdbT7n/bvSTRuaDnxyEA+8K9WS
        ae933eHHvD8ftRy37JwjZR3J5aP19bXolH9MIsGlmXF3+K5VdZX1rHzK2++e1KH1vulijU6t
        9rfa2H15B+c22Eb1vWd+pzrD7a5bB+fb1iLND1nbE31rZN7maSZfaj8kw6u0KOfgq9SG29V5
        9S/X39kgP8n8dIzN4spn0deEo/ukH2ztkq459uCmwdf1fz9rNP+4n6zZqvc8Z92p193h+csc
        je15axb+2bnq7eyAN7uTmCYIrW43uVoXwndpR+X6tTrrg/jyzd8eS2W4Fn2Qo0qJpTgj0VCL
        uag4EQBbWgdF9gIAAA==
X-CMS-MailID: 20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folk,

We have released exfatprogs-1.0.3 version.
Any feedback is welcome!:)

CHANGES :
 * Rename label.exfat to tune.exfat.
 * tune.exfat: change argument style(-l option for print level,
   -L option for setting label)
 * mkfs.exfat: harmonize set volume label option with tune.exfat.

NEW FEATURES :
 * Add man page.

BUG FIXES :
 * Fix the reported build warnings/errors.
 * Add memset to clean garbage in allocation.
 * Fix wrong volume label array size.
 * Open a device using O_EXCL to avoid formatting it while it is mounted.
 * Fix incomplete "make dist" generated tarball.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/download/1.0.3/exfatprogs-1.0.3.tar.gz

