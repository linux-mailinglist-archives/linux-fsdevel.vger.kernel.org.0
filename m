Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86F4822A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 08:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbhLaH54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 02:57:56 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:32680 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhLaH54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 02:57:56 -0500
X-Greylist: delayed 2053 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 02:57:56 EST
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BV7uVju018320
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=date : from : to :
 subject : message-id : mime-version : content-type; s=pps01;
 bh=XYJ96+jqHJDJOlXU1I6iTgc3VZ9+RdBj4DlG4CFm2jA=;
 b=B6K9L9zPJYE1jRXAjGUsVTFBVTvAYdZWIc6IhdoDxBWdUGxeg0wb7I5l0/5HuhEpFw8J
 ZC8ED9dZv3rFvJvqhJFfmKZ2BPTzYLNZ76aQvp4hnuH4la4KeztnoIrjzOG9YBoiQcqw
 IoCAZiFNrUaqPn/JuSbHIQMnQAnA/kkvN2LJ6F/2XozOGP+N8UDWcIT4u1aQktxGGBGO
 loolmK/woMl81MRx/uut7CNmh9/xOOZXs0x6phvsebkA1FKbubaTgVgvbE5xwyNpPAz2
 izv9yg/7daZAD8X0fzhfOY9vphVcU8SSX8oTfCsQo+jWyScuNtP45+1uAGjJ4mXWILoY 3g== 
Received: from sendprdmail21.cc.columbia.edu (sendprdmail21.cc.columbia.edu [128.59.72.23])
        by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3d9vr50686-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:57:55 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by sendprdmail21.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 1BV7vreA009524
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:57:54 -0500
Received: by mail-qv1-f72.google.com with SMTP id 13-20020a0562140d0d00b00411590233e8so21275061qvh.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 23:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XYJ96+jqHJDJOlXU1I6iTgc3VZ9+RdBj4DlG4CFm2jA=;
        b=EZTJAeodU9WZGVwabBeITS1/Xai5jmuM3iCVQrzSAmoSSpqjRQtWuv5UetU4xluon8
         IXAgd3i/3Fegzipu2v7W6BL35hRr4Knw1utnFy5g5HZvbhfMptzOwAae3wXgiJq2EBOr
         bn2v4kw19IWbDO3DlO2I/g+WMnkufdxLYUpO87rRiHwl67mrTwDUOYkzfLiWk1TV5LHC
         sPGCaeg2eP5RyedkGKeNfFlSsMWvpgC3LnNUyTFTBlZEnMGjaQLxMcB/vkiiG54ihAlF
         whgT5Hhj7UGAGEP717sATPYf+acSeqS780Qd0YjnfF3lwWY0+uQCXGJXDvxSk3Q2e2hH
         kXpA==
X-Gm-Message-State: AOAM533KC0kAHGVdd0bCK+D/0Gg+pRwgzXaKQ0I1FTqMA1nLTbgx5tZ1
        dKPMm1DNL5bIYIxNvMOTDrNzGFuRl88S15Oqf6Yxd5raAlY7uETZ8k0m1zzTUg9LR3P5FF8SxzH
        PmfMRShOhWHHONKbPfTwAmuSvF7HrZSgJPw==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr29708358qtw.242.1640937473527;
        Thu, 30 Dec 2021 23:57:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGdl2gbez4UWF0TJuoVotAJ+KZJOCLrGFHOxIPa3TONNaK1seQ6MTD8gGkRoTplx57UoHvsg==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr29708347qtw.242.1640937473222;
        Thu, 30 Dec 2021 23:57:53 -0800 (PST)
Received: from charmander (dyn-160-39-33-233.dyn.columbia.edu. [160.39.33.233])
        by smtp.gmail.com with ESMTPSA id h1sm20488766qta.54.2021.12.30.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 23:57:52 -0800 (PST)
Date:   Fri, 31 Dec 2021 02:57:50 -0500
From:   Tal Zussman <tz2294@columbia.edu>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, tz2294@columbia.edu,
        Xijiao Li <xl2950@columbia.edu>,
        Hans Montero <hjm2133@columbia.edu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Subject: [PATCH] fs: Remove FIXME comment in generic_write_checks()
Message-ID: <20211231075750.GA1376@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: aWig5trRa52jldbVcD6yGcToTh8eFe6F
X-Proofpoint-GUID: aWig5trRa52jldbVcD6yGcToTh8eFe6F
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-31_02,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=10 phishscore=0
 clxscore=1015 bulkscore=10 lowpriorityscore=10 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112310032
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch removes an unnecessary comment that had to do with block special
files from `generic_write_checks()`.

The comment, originally added in Linux v2.4.14.9, was to clarify that we only
set `pos` to the file size when the file was opened with `O_APPEND` if the file
wasn't a block special file. Prior to Linux v2.4, block special files had a
different `write()` function which was unified into a generic `write()` function
in Linux v2.4. This generic `write()` function called `generic_write_checks()`.
For more details, see this earlier conversation:
https://lore.kernel.org/linux-fsdevel/Yc4Czk5A+p5p2Y4W@mit.edu/

Currently, block special devices have their own `write_iter()` function and no
longer share the same `generic_write_checks()`, therefore rendering the comment
irrelevant.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Co-authored-by: Xijiao Li <xl2950@columbia.edu>
Co-authored-by: Hans Montero <hjm2133@columbia.edu>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..0173dc7183c9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1637,7 +1637,6 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (!iov_iter_count(from))
 		return 0;
 
-	/* FIXME: this is for backwards compatibility with 2.4 */
 	if (iocb->ki_flags & IOCB_APPEND)
 		iocb->ki_pos = i_size_read(inode);
 
-- 
2.20.1

