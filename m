Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67CF481B01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 10:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhL3JLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 04:11:49 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:34700 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237961AbhL3JLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:11:48 -0500
X-Greylist: delayed 3846 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2021 04:11:48 EST
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BU874FN013278
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 03:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : cc : content-type; s=pps01;
 bh=lsekqtqFR2x5TPdkl1gUXM3uMy4gPOn04i1URtw7vyI=;
 b=bc+15HZBmP/EGmoKbu4xfeI3Uda0iyZeSVtIIPnGlp6JzRwluiWQCmr+WrGkiGmiIQiT
 HEwVK2mIK0KJ3ugmpZ/cm41tUOqXcXkO37JNxnlKj21lF25xm4g8dUHQHEmNstSAWrEz
 PcxUDApRWYNoqOm4zJU1wb+HVX6NBAWyM4KONO0mGHbgKP2LM00dL9hpbsKINNftogk4
 ShErc8R2W7OaZG824EaVelC1tULZ8qAatb2EWwXqhIJhTXjDokNK3lukyQQan1HeJhbV
 nnqKXrsX8kgZpSlsru4wl7R/GDWYHqUmrzuYdykaV4bDzl2Pe0K7+y5BbNra36Orw6GF pA== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3d614se0cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 03:07:40 -0500
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 1BU87cYZ056602
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 03:07:38 -0500
Received: by mail-yb1-f198.google.com with SMTP id e2-20020a25d302000000b0060c57942183so22151952ybf.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 00:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lsekqtqFR2x5TPdkl1gUXM3uMy4gPOn04i1URtw7vyI=;
        b=Ha/zfRIioqsdoANotCieFXHbBW0SdzbyX6vtagsymQNa60EHvvPcio8p5YJFvk9RYh
         TP01pDhj/zfSTTYwu5ccAiWRVpeNP40cPdUcSrkW/9EvEhRkGFOvfh9G87pE5ZpT7gAJ
         QcIFT/ZuEvQWoTN02sREhnpsfwP85N4F2F/Wkfv/fz43+ZCcHgcDzxuObYexzC5TWdJR
         +6afvDPUd23KfiFKvOZmS5hpwGAAbn1//WgQE+18fVa2iuc95K7HgJfFy/+26sr4Qq38
         Bl+g5h97Kn+r5I95ywuTOvg5EgtUPQlSAAgNLlSCChKI2ErOGwZDObI4L7/7UVjgl2c9
         3fmQ==
X-Gm-Message-State: AOAM531tXGSWGdhwB99OBkjpWU9glej1Nd0NrvklkEY+9c6GhQ8awThl
        Jrxj7RqgDOK/nmgf3KXBsCAA+T/kiE6VQ4f3kYxzwvGCe5xP9j8snRWSRWFRgAK5YH9MRA+IdSk
        tzSFHKRm2EaNxLLAIIAWE7lCYV1vyW7gn496g86nFtXgw5YB/rw==
X-Received: by 2002:a05:6902:154b:: with SMTP id r11mr4807863ybu.358.1640851657957;
        Thu, 30 Dec 2021 00:07:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzBfC9t9e4n/FjpYq1x6y2bRJGbjzUUlIhc9Aup3Tv0rezD6sOFfLPNVktu6TUKmsHwmUb4zvK1elk0Da2hJM=
X-Received: by 2002:a05:6902:154b:: with SMTP id r11mr4807832ybu.358.1640851657445;
 Thu, 30 Dec 2021 00:07:37 -0800 (PST)
MIME-Version: 1.0
From:   Hans Montero <hjm2133@columbia.edu>
Date:   Thu, 30 Dec 2021 03:07:25 -0500
Message-ID: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
Subject: Question about `generic_write_checks()` FIXME comment
To:     linux-fsdevel@vger.kernel.org
Cc:     Tal Zussman <tz2294@columbia.edu>, Xijiao Li <xl2950@columbia.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 6jw25If39x4UGXU5rkVzsxF462fL3oTN
X-Proofpoint-GUID: 6jw25If39x4UGXU5rkVzsxF462fL3oTN
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_01,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=10
 clxscore=1031 lowpriorityscore=10 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=898 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=10 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112300039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey there,

We're the teaching staff for Columbia University's graduate-level operating
systems course and something came up as we were improving our filesystem
assignment.

For context, we have students develop a very simple filesystem that implements
the `read()`/`write()` `struct file_operations` functions as opposed to
`read_iter()`/`write_iter()`.

We noticed that the following bash redirection didn't work as expected in our
filesystem: `echo test >> foo.txt`. The write would occur at the beginning of
the file because the `ppos` argument to `write()` was set to 0. Through
`strace`, we verified that bash opens the file with `O_APPEND` so we assumed
that VFS would handle setting `ppos` to the file size for us, yet it did not.

We dug through kernel code to see if other filesystems explicitly account for
this case and surely enough, they do! Most of the filesystems we saw
directly/indirectly call `generic_write_checks()` which is implemented for
`write_iter()` usage. We were able to solve our bug by simply porting the
following logic for our version of `write()`:

  /* FIXME: this is for backwards compatibility with 2.4 */
  if (iocb->ki_flags & IOCB_APPEND)
          iocb->ki_pos = i_size_read(inode);

We noticed the FIXME comment and we weren't sure exactly what it meant so we
kept tracing through older versions of `generic_write_checks()`, going as far as
Linux 2.5.75, before it was implemented for `write_iter()` usage:

  if (!isblk) {
          /* FIXME: this is for backwards compatibility with 2.4 */
          if (file->f_flags & O_APPEND)
                  *pos = inode->i_size;
          ...
  }

Can someone explain what this comment is referring to? And why does `!isblk`
matter?

Furthermore, why doesn't VFS do the `O_APPEND` check itself instead of
delegating the task to the filesystems? It seems like a universal check,
especially given the following snippet on `O_APPEND` from the man page for
open(2):

  APPEND
      The file is opened in append mode. Before each write(2), the file offset
      is positioned at the end of the file, as if with lseek(2).

Best,
Hans
