Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE664233FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgGaHQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 03:16:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64568 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgGaHQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:16:11 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200731071606epoutp022ed7026072f574efc9bf954790a3ffba~mxQp2MZuM0681106811epoutp02G
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 07:16:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200731071606epoutp022ed7026072f574efc9bf954790a3ffba~mxQp2MZuM0681106811epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596179766;
        bh=4SMhoMDZ+g/ZxupeHB0cPQCfoqh9ufC2P1BT67WkeBQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IT36sDG/yjeYdw3BIzlix3yKusmfL/6hjkc/Y01ONtxRddmmAtI4oOaW6hXhekCbM
         UBjnJc6YI7kihhP+UvO8ksJ07b4OwvlwCKZIYanJfAdkKJH2NaiU7MhxeESRb1/Y+C
         pwoiHednqDZ8grlkPIeclKvVU/LsOPXH+oYAzXBY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200731071606epcas1p35bb68c26a8cfcb12b1d0bc0fd06aba5c~mxQpcI3pF1463614636epcas1p3Q;
        Fri, 31 Jul 2020 07:16:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BHz8j1vWczMqYkf; Fri, 31 Jul
        2020 07:16:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.EF.28581.535C32F5; Fri, 31 Jul 2020 16:16:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d~mxQoRpr3z1463614636epcas1p3H;
        Fri, 31 Jul 2020 07:16:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200731071604epsmtrp2da4d3e21a9aef2da88bce72632205d35~mxQoQxJWF1033210332epsmtrp2O;
        Fri, 31 Jul 2020 07:16:04 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-86-5f23c5359ac1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.51.08303.435C32F5; Fri, 31 Jul 2020 16:16:04 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200731071604epsmtip2260e51e90659e0df3cdd76b0f780fd9e~mxQoEZI660325003250epsmtip2d;
        Fri, 31 Jul 2020 07:16:04 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.com>,
        "'Nicolas Boos'" <nicolas.boos@wanadoo.fr>,
        <sedat.dilek@gmail.com>, "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Luca Stefani'" <luca.stefani.ge1@gmail.com>,
        "'Matthieu CASTET'" <castet.matthieu@free.fr>,
        "'Sven Hoexter'" <sven@stormbind.net>,
        "'Ethan Sommer'" <e5ten.arch@gmail.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        =?UTF-8?Q?'Sven_H=C3=B6xter'?= <sven@stormbind.net>
Subject: exfatprogs-1.0.4 version released
Date:   Fri, 31 Jul 2020 16:16:04 +0900
Message-ID: <002901d6670a$742e8cf0$5c8ba6d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZnAYiNJ63jpeDNQxqEFU9jjd0R3Q==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmrq7pUeV4g1n9vBafb/ayW3Qeecpm
        ce3+e3aLvxM/MVns2XuSxeLyrjlsFv/WN7NbNBw7wmLR9ncXq0XrFS2LdVNPsFi83vCM1YHH
        o3/dZ1aPnbPusntsWfyQyWPij2lsHuu3XGXx+LxJzuPz3fWsAexROTYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMq5cbmIt+MFTsbGxlbmB
        8QFnFyMnh4SAiUT3pGssXYxcHEICOxglDkx6ygThfGKU+DK/mRnC+cwo8fXcF3aYluVL+6Cq
        djFKtDU3MUI4LxklVly5wAJSxSagK/Hvz342EFtEIFli3+v9YEXMAreYJT7uXcMEkhAW0JLY
        dOwLM4jNIqAqsaF9D1gzr4ClRNP1DmYIW1Di5MwnYHFmAXmJ7W/nMEOcoSDx8+kyVogFehLr
        3h9lhqgRkZjd2QZVs4VD4sVkKQjbReLP03tMELawxKvjW6DekZL4/G4v0KEcQHa1xMf9UK0d
        jBIvvttC2MYSN9dvYAUpYRbQlFi/Sx8irCix8/dcRoitfBLvvvawQkzhlehoE4IoUZXou3QY
        aqm0RFf7B6ilHhKPDkxhncCoOAvJj7OQ/DgLyS+zEBYvYGRZxSiWWlCcm55abFhgghzZmxjB
        iVjLYgfj3Lcf9A4xMnEwHmKU4GBWEuFt51KIF+JNSaysSi3Kjy8qzUktPsRoCgz1icxSosn5
        wFyQVxJvaGpkbGxsYWJmbmZqrCTO+/AWUJNAemJJanZqakFqEUwfEwenVAPT/O2LlW7tmD1h
        XvBJkY3P3ecFfy9W7G5c8zD5v672LlObGZzh08pOr5I8FSG98aT4vveuRZcv9XmsyxP3DK5a
        al14tXttoe+iUj0bSaW/9+VvJ30qYbKVXFVVcJFhI3Ol+pr8ndczvF32C8nKu7WtdXNPmnPk
        +KxtG1SUt6n0LmFTO5jT7GV8d+nUQ6v25n2YpTdRdqbCXfmcWUEqD1RF1s/f+W77fU/mf5fu
        fH40adb57boGb/pvRq+Z+DB18tQlyVk73Tn7D3JWnP9Q1WJ8c+stM8cup7c9p0vr7tlsN1rV
        y2zVEFGj+kvJoidsqYzuR+0DUjL1GooJ3oHTxNf77Vn2LqltRopZgPzj6g+sSizFGYmGWsxF
        xYkA5qkRRE0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXtfkqHK8wdcNZhafb/ayW3Qeecpm
        ce3+e3aLvxM/MVns2XuSxeLyrjlsFv/WN7NbNBw7wmLR9ncXq0XrFS2LdVNPsFi83vCM1YHH
        o3/dZ1aPnbPusntsWfyQyWPij2lsHuu3XGXx+LxJzuPz3fWsAexRXDYpqTmZZalF+nYJXBlX
        LjexFvzgqdjY2MrcwPiAs4uRk0NCwERi+dI+pi5GLg4hgR2MEi1PzjFCJKQljp04w9zFyAFk
        C0scPlwMUfOcUaLv2BUWkBo2AV2Jf3/2s4HYIgLJEvte72cEKWIWeMQssfL+anaQhLCAlsSm
        Y1+YQWwWAVWJDe17wJp5BSwlmq53MEPYghInZz4BizMLaEv0PmxlhLDlJba/ncMMcZCCxM+n
        y1ghlulJrHt/lBmiRkRidmcb8wRGwVlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHGNaWjsY96z6oHeIkYmD8RCjBAezkghvO5dCvBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHer7MWxgkJpCeWpGanphakFsFkmTg4pRqYGg1beb/831s+ZWZ3u/abP6b6
        p0T9n3zvl05JXZ/HsXTx3S8+XzQXf1vqab3vVlD/gcPbVpy/4NdSVG7ps8l1GeO62mfxjQYM
        c3aEsv16l3jLdne+9CW9tev7Jx5U0txq2bBpMtcWuz+cgZJlaoum+G/MsNM0eXt+c06C2cSp
        t7OK+3fX1j3LPuxRIHki6H7h3Xf7Oq5+STiWukbtGh/fh7+bN3mYq876s13+y/LNlVkiCQ7h
        irzx52L7Zf3D+Fwyrv8NUJpRcVfy6FYuW4mmv+vXCcyduNn4cqfqNfPVTxMvX3y0gzVlct62
        evnXDxecL6jc+jO8SclpgULwhF8G86etZjy7reudkIcG+46vM5VYijMSDbWYi4oTAZlToMMg
        AwAA
X-CMS-MailID: 20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d
References: <CGME20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folk,

In this release, The performance of fsck have been much improved and
the new option in mkfs have been added to adjust boundary alignment.

As the result below, The fsck performance is improved close to windows's fsck
and much faster than the one in exfat-utils package.

We measured the performance on Samsung 64GB Pro microSDXC UHS-I Class 10 which
was filled up to 35GB with 9948 directories and 16506 files.

| Implementation       | version           | execution time (seconds) |
|--------------------- |-------------------|--------------------------|
| **exfatprogs fsck**  | 1.0.4             | 11.561                   |
| Windows fsck         | Windows 10 1809   | 11.449                   |
| [exfat-fuse fsck]    | 1.3.0             | 68.977                   |

And we have been preparing to add fsck repair feature in the next version.
Any feedback is welcome!:)

CHANGES :
 * fsck.exfat: display sector, cluster, and volume sizes in the human
   readable format.
 * fsck.exfat: reduce the elapsed time using read-ahead.

NEW FEATURES :
 * mkfs.exfat: generate pseudo unique serials while creating filesystems.
 * mkfs.exfat: add the "-b" option to align the start offset of FAT and
   data clusters.
 * fsck.exfat: repair zero-byte files which have the NoFatChain attribute.

BUG FIXES :
 * Fix memory leaks on error handling paths.
 * fsck.exfat: fix the bug that cannot access space beyond 2TB.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/download/1.0.4/exfatprogs-1.0.4.tar.gz

