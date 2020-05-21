Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1761DDAD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgEUXPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 19:15:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59038 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgEUXPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 19:15:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200521231506epoutp031ffb48096e57858f9d8677ab21e7b990~RLitBpoBZ2233322333epoutp03b
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 23:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200521231506epoutp031ffb48096e57858f9d8677ab21e7b990~RLitBpoBZ2233322333epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590102906;
        bh=rJZqCQOnSFMJc+1/SWJ3uMKcjR5d2Ru5UKpf6u7uQGs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g8Kzqe/nfK8IK8YSAGUuXo37RNc9edPuUI+oh+2ntexjiHK/OJbwmIMkAjkogKobR
         94R1PrFviuaZ+s93kLMojB1ZGS1aO0tMpHdBCmRPY5Hx1jID0JGAMYrxAbf6Wzdv07
         HSWh7qNhOvTeb6HHX+TGhhb2fOHyVXAifIG502MQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200521231506epcas1p16b7b6728aa98d1bd42ceb0d611f43ee5~RLisnxGrw1786117861epcas1p1U;
        Thu, 21 May 2020 23:15:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49Slp12cr3zMqYkV; Thu, 21 May
        2020 23:15:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.6A.04744.97B07CE5; Fri, 22 May 2020 08:15:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200521231505epcas1p28521830bf5732f71adc0510502930d41~RLirelFTG1191311913epcas1p2V;
        Thu, 21 May 2020 23:15:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200521231505epsmtrp14049c6fd943227b0a6bed37ff102d90c~RLirdwkyd1048410484epsmtrp1B;
        Thu, 21 May 2020 23:15:05 +0000 (GMT)
X-AuditID: b6c32a38-253ff70000001288-fa-5ec70b79039a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.17.18461.87B07CE5; Fri, 22 May 2020 08:15:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200521231504epsmtip2b1e0acd1b2274109409e94e0baddfe50~RLirQvtiq0371603716epsmtip2M;
        Thu, 21 May 2020 23:15:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        sandeen@sandeen.net, viro@zeniv.linux.org.uk, willy@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
Date:   Fri, 22 May 2020 08:10:10 +0900
Message-Id: <20200521231010.4181-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmgW4l9/E4g2PzRC327D3JYnF51xw2
        ix/T6y1ar2hZPOp7y25x/u9xVovfP+awObB7bF6h5XFixm8Wj74tqxg9tix+yOTxeZOcx6Yn
        b5kC2KJybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgY
        mQJVJuRkHN45lbHgnGDFmVPrWRoYN/F1MXJySAiYSBw81MraxcjFISSwg1Hi3v/pzBDOJ0aJ
        TVOWs0A43xgl5vfMYoRpWbF8L1RiL6NE09FDLHAtN28cBari4GAT0Jb4s0UUxBQRUJS4/N4J
        pIRZYC2jxMHrr1hABgkLpEqs2z2HHcRmEVCV2He8lQ3E5hWwlph28hgTxDJ5idUbDoCdJCGw
        jV3i7sFFUAkXiddH7kBdJCzx6vgWdghbSuJlfxs7yGIJgWqJj/uZIcIdjBIvvttC2MYSN9dv
        YAUpYRbQlFi/Sx8irCix8/dcsInMAnwS7772sEJM4ZXoaBOCKFGV6Lt0GOoAaYmu9g9QSz0k
        Vqx/CXa9kECsxIaHN5kmMMrOQliwgJFxFaNYakFxbnpqsWGBCXIcbWIEpy0tix2Me875HGIU
        4GBU4uG1SDsWJ8SaWFZcmXuIUYKDWUmEdyH/0Tgh3pTEyqrUovz4otKc1OJDjKbAsJvILCWa
        nA9MqXkl8YamRsbGxhYmZuZmpsZK4rxTr+fECQmkJ5akZqemFqQWwfQxcXBKNTDuXP4opHPJ
        /fpfrZxvf3FNcLHbZfMz7srJ1I6NvLt+asu9NK9Y9rH6yir/BxN4VV3kzwmvqP79TfOt7I7q
        u/sUS2Kf7A7vqdrqFiCjrPvmZEqbMkecptVj17rwTJGm29uOxW4KY7bwnT7HV+kz2+Qf07Vv
        6K26LfzbZobk792Bm38W8LZWJBYrsRRnJBpqMRcVJwIAD5ZOIXEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSvG4F9/E4g2PfrCz27D3JYnF51xw2
        ix/T6y1ar2hZPOp7y25x/u9xVovfP+awObB7bF6h5XFixm8Wj74tqxg9tix+yOTxeZOcx6Yn
        b5kC2KK4bFJSczLLUov07RK4Mg7vnMpYcE6w4syp9SwNjJv4uhg5OSQETCRWLN/L0sXIxSEk
        sJtRom/XNjaIhLTEsRNnmLsYOYBsYYnDh4shaj4wSjQvecgGEmcT0Jb4s0UUxBQRUJS4/N4J
        pIRZYDOjxLKjU8HGCAskS7w+vokRxGYRUJXYd7wVLM4rYC0x7eQxJohV8hKrNxxgnsDIs4CR
        YRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAYaWnuYNy+6oPeIUYmDsZDjBIczEoi
        vAv5j8YJ8aYkVlalFuXHF5XmpBYfYpTmYFES571RuDBOSCA9sSQ1OzW1ILUIJsvEwSnVwLRY
        9OvH93sMZ35qkuhWzpJ4uvIA07yz5kmpn+qmf9ulJr7t+1SW08vTvpo8Con5YeeQ+8Ev6mdn
        q+D7WXXLOI2s1yslbc43uexctEdVmO+dwUaH64r3ZfmY2De8ZRFn3n8wbtvPt9WzL5vLBt6U
        CLhx3uLjTaVbWRPjtf/HZb0ItchrVTEy8MkOXLnvWodxwtuVYaVHAjvDv0+T+nnuiq3kvsnT
        37tfbNq5z3xFXPoR+9iiTWFW6Td+nnghzVt+TPWuRNr+zsvxlvuCf57nvn2ely20WutJklJY
        +uxl27qdbRtd96etXrtOeOemTVYfvxZdlWuKffg09ZBZ03Td1vAzejOU9Hd78ghcfXXkr68S
        S3FGoqEWc1FxIgDUCSiTkgIAAA==
X-CMS-MailID: 20200521231505epcas1p28521830bf5732f71adc0510502930d41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200521231505epcas1p28521830bf5732f71adc0510502930d41
References: <CGME20200521231505epcas1p28521830bf5732f71adc0510502930d41@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Ubuntu and Fedora release new version used kernel version equal to or
higher than v5.4, They started to support kernel exfat filesystem.

Linus Torvalds reported mount error with new version of exfat on Fedora.

        exfat: Unknown parameter 'namecase'

This is because there is a difference in mount option between old
staging/exfat and new exfat.
And utf8, debug, and codepage options as well as namecase have been
removed from new exfat.

This patch add the dummy mount options as deprecated option to be backward
compatible with old one.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 v2:
  - fix checkpatch.pl warning(Missing Signed-off-by).
 v3:
  - use fs_param_deprecated instead of printing deprecated warning(Matthew Wilcox).

 fs/exfat/super.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 0565d5539d57..a846ff555656 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -203,6 +203,12 @@ enum {
 	Opt_errors,
 	Opt_discard,
 	Opt_time_offset,
+
+	/* Deprecated options */
+	Opt_utf8,
+	Opt_debug,
+	Opt_namecase,
+	Opt_codepage,
 };
 
 static const struct constant_table exfat_param_enums[] = {
@@ -223,6 +229,14 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
+	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
+		  NULL),
+	__fsparam(NULL, "debug",		Opt_debug, fs_param_deprecated,
+		  NULL),
+	__fsparam(fs_param_is_u32, "namecase",	Opt_namecase,
+		  fs_param_deprecated, NULL),
+	__fsparam(fs_param_is_u32, "codepage",	Opt_codepage,
+		  fs_param_deprecated, NULL),
 	{}
 };
 
@@ -278,6 +292,11 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		opts->time_offset = result.int_32;
 		break;
+	case Opt_utf8:
+	case Opt_debug:
+	case Opt_namecase:
+	case Opt_codepage:
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

