Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2DA7A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 06:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfIDEuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 00:50:23 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:36015 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDEuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:50:22 -0400
Received: by mail-io1-f43.google.com with SMTP id b136so17202539iof.3;
        Tue, 03 Sep 2019 21:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqeeCLoOIocazJotBpO5DRxlEiowj7NIrvCPQiLSXaw=;
        b=drOTaSQEZbU1qHaXGu/LzPQb1XjTStNTAsZenn0BsCKYusHP0I801i/Gbw4kw/BOp2
         kLfZOlFv0f+4WLfQhMAntIeYdkAT9zdn97bPAkNF6NZAuz7yCYg7R8btHVj4b/7qXvAT
         /u6BE4sWpuUWOF8fXujbwVPFRtXQrNCk8OA60tkzV6vWGYq2sb8b8CMHUkN/L7t5oXEK
         qrcxj9602l0wpRQ620vtbERxyr0Lgrg39IKQSBzag2h2io9UWJXIbpxq4NrT6FqSq4JD
         1Z78XrbYD6zv/2oJUVpeyTOmhxuXnJU4tIcP8iBXd60ZoiwY5l4nptT74BsTsT9uUf2m
         VFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqeeCLoOIocazJotBpO5DRxlEiowj7NIrvCPQiLSXaw=;
        b=k8y9z80vESXQZLW5UQJMwgJHX3F0W93p1Ky57jRDpkJZQhiVmMlwY4k1b/KtTTk8d3
         P6M3yxSS9QTg9xJmVAp93w6Aqbl4YB1ZqORX1cpzXoB4mOeoGPpMFmvhJwneKPJfMTrH
         B8q6WaesyOMNoFQ7IQKUU7qTUEHz4wIWufJkmlMXpJdM0bf6jA6ys44MYIZVq+dyTBBw
         BCyIHw3thaKZeUScdlFngj3X7cYOU2xB3eSlTZSB6N6/uZKLkd37yU+NLqvAEH/9b5DP
         PQzSZnFb/xmGAOhSVPfzaBpEkMASnN8CgyUrhX2Y7QZkmA4GgRVtjDP3Qp2wIriBeyAJ
         nAyQ==
X-Gm-Message-State: APjAAAWvc+AkHRwtOEDL7NnvkY6LdLostSHJxwH+uzJ28m//gIMxnMEL
        rIqyQpDjWVXJZtG+QHyEbPzhBObYNbbu5knngXJbjw==
X-Google-Smtp-Source: APXvYqyNitz863/kOuhy32iJr10suOM/+h76mNFkYoEe9iU3nWj+ABxHrmDcJGg4oprM0YdfCSzdKLR9KOKD2aJS4I8=
X-Received: by 2002:a02:948c:: with SMTP id x12mr3507699jah.96.1567572621610;
 Tue, 03 Sep 2019 21:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu> <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
In-Reply-To: <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Sep 2019 21:50:09 -0700
Message-ID: <CABeXuvq0_YsyuFY509XmwFsX6tX5EVHmWGuzHnSyOEX=9X6TFg@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we don't care to warn about the timestamps that are clamped in
memory, maybe we could just warn when they are being written out.
Would something like this be more acceptable? I would also remove the
warning in ext4.h. I think we don't have to check if the inode is 128
bytes here (Please correct me if I am wrong). If this looks ok, I can
post this.

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9e3ae3be3de9..24b14bd3feab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -833,10 +833,8 @@ do {
                                 \
                (raw_inode)->xtime ## _extra =
         \

ext4_encode_extra_time(&(inode)->xtime);        \
                }
         \
-       else    {\
+       else    \
                (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
(inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
-               ext4_warning_inode(inode, "inode does not support
timestamps beyond 2038"); \
-       } \
 } while (0)

 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)
                \
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..cef5b87cc5a6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2791,7 +2791,7 @@ int ext4_expand_extra_isize_ea(struct inode
*inode, int new_extra_isize,

 cleanup:
        if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
-               ext4_warning(inode->i_sb, "Unable to expand inode %lu.
Delete some EAs or run e2fsck.",
+               ext4_warning(inode->i_sb, "Unable to expand inode %lu.
Delete some EAs or run e2fsck. Timestamps on the inode expire beyond
2038",
                             inode->i_ino);
                mnt_count = le16_to_cpu(sbi->s_es->s_mnt_count);
        }
