Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDC1B5779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDWItO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 04:49:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36145 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWItN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:49:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200423084910epoutp038dcb7905fbc08731b7f34fea1c951830~IZqpAWcpc0338203382epoutp03Q
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 08:49:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200423084910epoutp038dcb7905fbc08731b7f34fea1c951830~IZqpAWcpc0338203382epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587631750;
        bh=KwdIFH/L5SIr+QnGowAwrh8gTyuooEa0C2RIgzHAXto=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CpOMfkYJ3yRxrfeJgUmVrIOhL9B4UIAmHp78jawGm65OEqnuYSlZGx3cyho9LqOFg
         47ybqGPOaLcJ2iC6tTQcg9+U3KdQOlguAVITzNCqWzFom96WamxVY4VDo6Awt/rKor
         UxNXW3kJmJrmYwMdHidIhClRB7ddwYZcqCpJ7olo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200423084909epcas1p4da55aa560d9389b7bc730155969caf2f~IZqo03bo51221312213epcas1p4-;
        Thu, 23 Apr 2020 08:49:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4979vm5mL7zMqYkf; Thu, 23 Apr
        2020 08:49:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.94.04648.48651AE5; Thu, 23 Apr 2020 17:49:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413~IZqnfniHt2361123611epcas1p1G;
        Thu, 23 Apr 2020 08:49:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200423084908epsmtrp18addace45fb4525f4bc94ac0687d24d5~IZqnea3jc1033910339epsmtrp18;
        Thu, 23 Apr 2020 08:49:08 +0000 (GMT)
X-AuditID: b6c32a37-1dbff70000001228-d3-5ea1568410ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.A0.04158.48651AE5; Thu, 23 Apr 2020 17:49:08 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200423084908epsmtip1f4a453c8fa0c376dd19e06b0c5b22915~IZqnQk8zp1130711307epsmtip1H;
        Thu, 23 Apr 2020 08:49:08 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Sedat Dilek'" <sedat.dilek@gmail.com>,
        "'Goldwyn Rodrigues'" <rgoldwyn@suse.de>
Subject: [ANNOUNCE] exfatprogs-1.0.2 version released
Date:   Thu, 23 Apr 2020 17:49:08 +0900
Message-ID: <004701d6194c$0d238990$276a9cb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYZSpFQSutFdpomSvqOYdc5YaaMqA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUcRTH+e3Mzk7SxrRavbZrd0IqaS/X1dXcEIxYSEqQTDrWBndQcfZg
        ZxUPJIVcTcWjiHC7ERSFylQ8OpAMSekQ7LILlZJSMa0w7cDa3THyv897v+9739/7/R6JyeoI
        OZlpd7MuO8PRRBDecX+HSnUy+apF+9ijMb4YmZEY79wdwI1Pb10gjDXT10XGkmdhxutn+/E4
        wtztfScxt9ePicxtDwvM31o3J+KHudgMlrGyLgVrT3NYM+3pJnpfUmp8qiFSq1Ppoo1RtMLO
        2FgTvSchUbU3k/NZ04ochsv2pRIZnqc1u2Ndjmw3q8hw8G4TzTqtnFOndap5xsZn29PVaQ5b
        jE6rDTf4lMe5jOKpcbGzKih3pu+MqAhdIsvRChKoCJhceCMpR0GkjOpC8OhcNSEEXxF0DPUh
        IfiOoLGkWvSv5O3IgNjPMuouguf9JkE0geBO5TzyHxCUChZ/9xB+DqESYPbnsMgvwqhGBHWj
        UwFRMGWAtsmngU44FQrVf9oDLKWioer9PVzg1TBQ9yHAGLUFOqcvYMItFPBjvEEsGKihvrMG
        EzQhcP6UB/ObAdVPQNlIw1LBHng+WkIIHAyTD9olAsthotrjY9LHBfClZ0lehuDTvElgPby6
        0SL2SzBqB9y4pRHSSuj+dREJtqvg81ylWOgihTKPTJCEQtXQ/aV32wDlpbNLpmZoLp6S1CCl
        d9mQ3mVDepcN4/1vfAXhzWgt6+Rt6Syvc+qXf3YrCqxlWFQXanmS0IsoEtErpSnKKxaZmMnh
        82y9CEiMDpG2jF2yyKRWJi+fdTlSXdkcy/cig+8PajH5mjSHb8nt7lSdIVyv1xsjIqMiDXp6
        nfTsS84io9IZN5vFsk7W9a9ORK6QF6EY/cL81ab9Zw7lmCPaR8ur8IYkSXT4aGnTkcUGRntw
        Wl0o8tRneeZmB0l5Fx43c+CN5ck7RfLNMfVMZu22oYjB8V3hx273POgrGNx+7/VE/OJHvlWZ
        8lITaeFOb1qfrLnsVp5c2Pgod2dtPmGpGFZbk04k7ry8tXB3m6T2aEXTNRrnMxhdGObimb+s
        m1oOrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnG5L2MI4g45+YYtr99+zW+zZe5LF
        4vKuOWwWE96uY7JovaJlsW7qCRYHNo+ds+6ye2xZ/JDJY/Ppao/Pm+QCWKK4bFJSczLLUov0
        7RK4MhpfP2Ut6OOqeH90MlMD4zyOLkZODgkBE4k790+ydjFycQgJ7GaU6F21ihUiIS1x7MQZ
        5i5GDiBbWOLw4WKImueMEvvPvGUGqWET0JX492c/G4gtIuAn8WvZGyaQImaBlYwSu7f3gg0S
        FjCV2PzqMpjNIqAq0f9/C5jNK2Ap0ff4IAuELShxcuYTFpBlzAJ6Em0bGUHCzALyEtvfzmGG
        uEdB4ufTZawQu/QkFm+fwAxRIyIxu7ONeQKj4Cwkk2YhTJqFZNIsJB0LGFlWMUqmFhTnpucW
        GxYY5aWW6xUn5haX5qXrJefnbmIEx4CW1g7GEyfiDzEKcDAq8fBGKC6IE2JNLCuuzD3EKMHB
        rCTCu+HhvDgh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFIN
        jDIvdrXd22hj8v+UDNvZ7eeWy2xgub5s9s37236eqNBpMM+SObbqdZjqr3Dz2YbfOyeFGn2P
        UCubvV5c4rT9jNcKs9Wf7qkytbB0Ociw2qBM7fWR8I3yc/9ttTt09Oi9iLlmS/epnehvncf7
        JsT6rmKYwNWSqc2Fy3dOetEj47vyxEeFBapT93grsRRnJBpqMRcVJwIA15nMUX0CAAA=
X-CMS-MailID: 20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413
References: <CGME20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the second release of exfatprogs since the initial version(1.0.1).
We have received various feedbacks and patches since the previous release
and applied them in this release. Thanks for feedback and patches!

According to Goldwyn's comments, We renamed the project name from
exfat-utils to exfatprogs. However, There is an opinion that just renaming
the name is not enough. Because the binary names(mkfs.exfat, fsck.exfat)
still are same with ones in current exfat-utils RPM package.

If that's real problem, We are considering a long jump with 2.0.0 when adding
repair feature.

Any feedback is welcome!:)

The major changes in this release:
 * Rename project name to exfatprogs.
 * label.exfat: Add support for label.exfat to set/get exfat volume label.
 * Replace iconv library by standard C functions mbstowcs() and wcrtomb().
 * Fix the build warnings/errors and add warning options.
 * Fix several bugs(memory leak, wrong endian conversion, zero out beyond end of file) and cleanup codes
 * Fix issues on big endian system and on 32bit system.
 * Add support for Android build system.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/tag/1.0.2

