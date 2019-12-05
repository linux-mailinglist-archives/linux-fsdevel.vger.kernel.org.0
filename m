Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7869611469F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfLESK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 13:10:56 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46342 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:10:55 -0500
Received: by mail-ed1-f47.google.com with SMTP id m8so3456715edi.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 10:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=E/hruxVdGbsExchN8dO0WLuhkAdQtMChLPCx/agcCwM=;
        b=155shFmk5glR7fejUuCAIAU/Q3tTfraSleassn882RET9iz4sruLkNqgLUbFkBoDqQ
         qDjrYwa6mLwtJA0jNCSQmfDGwrMM2A9l2yG7MQlozWmJl4DWl/qImjCCPTbYjxAcy3GQ
         jP1/F/6qiT0jokjJje/FXoiCnhTvJMvGxjAZaYVjrxwkG9Uvc2JAPbP+MkVGd90pwWqH
         oEtGksd928MPHSPkTiMsgTXPhMJbJg9dZIVgLSii+gltvEAwE6OUQPQENQTBphqRh/je
         fBLqrrQ/FfXCxXjibG4wobavL0qaimJuGF3FVMu08cStKCu7c9KrXJw5D+RRoSMIOsn6
         orlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=E/hruxVdGbsExchN8dO0WLuhkAdQtMChLPCx/agcCwM=;
        b=lhMYuMovKPWaNhrJLtrEf0jv+D+4wWPJF4y0+cznQgSSx0fIHlgaIWUbGqc9IzoVnL
         uGutuVw+tsDkaWfI6yHwPwg1qnvSVakOnVRQsc44Lf1vB9bDz1hE7CGCHVlVRlnZ5OGb
         Ftv0TThNln6VC7yIqCe47AAcH/Mpz4TsGETAZDCGMY1oWvgkPGUDsQKdNo+vKbiNskLU
         V+X6h6mZ1FdmI0px9JEKKv6NcBH3vJTyFGpkpqFMAkaikwZO2K/acxQo+ay1R+zZJkDu
         D92z94p34PZ+xO1PH1u/VKEiQV4uyvuVmF1k2dvrFfvQ4qGETIl1E/uwI7iqMOC06rS+
         4Zow==
X-Gm-Message-State: APjAAAVeNcPVhpJ+o365bDVvkmTwGApjT1PZcgbEBSuKjFhIlNbvUUfI
        xXc9PnXdxQiPDAf7nQC6HJ/7KsJuzVc=
X-Google-Smtp-Source: APXvYqwistRd2p/87Y+IWJkKePpKEb/ZLOxAt1UFTHcDpaiK/hXzB3yb3hB5FFkLPWpnW3vOAiI8Nw==
X-Received: by 2002:a17:906:9603:: with SMTP id s3mr10728046ejx.116.1575569453667;
        Thu, 05 Dec 2019 10:10:53 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id ba29sm372683edb.47.2019.12.05.10.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:10:52 -0800 (PST)
From:   Boaz Harrosh <boaz@plexistor.com>
Subject: [ZUFS news] pmfs: Announcing PMFS2, PMFS derived ZUFS file system
To:     Shachar Sharon <Shachar.Sharon@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <6ba585a3-5f1d-69b1-eba6-8faa7e2b527e@plexistor.com>
Date:   Thu, 5 Dec 2019 20:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi FS Folks

I'm glad to point you to a new open-source (GPLv2) ZUFS based filesystem named pmfs2.
It currently demonstrates 90% of the IO performance possible under ZUFS.
(Meta Data is still sloooow)

PMFS2 takes its core code from the open-source Kernel filesystem on Github *pmfs*
(https://github.com/linux-pmfs/pmfs) fills in some glue code from toyfs and demonstrates
a very good IO performance.
(Reads better then writes because block-allocator does not yet scale)

Fine it all on Github:
	https://github.com/sagimnl/pmfs2

Please start with the README file (url above). This code is part of the *zus* user-mode server
build system. And also read the documentation in the netapp/zufs-zus project.

Currently the main code taken from *pmfs* is in btree.c which gives a very good structure
of an inode's blocks allocation. It is very similar to a radix-tree with natural sizes similar
to the Intel mmu (4K, 2M, 1G ...) so the max needed tree hight is 5. The original support of
2M blocks and 1G blocks is also supported in the original code. The support is still there but
is not wired into higher layers yet.

Data files, Directories, Inode-Table, xattrs, are all inode-btree structures. So the IT
is extensible just as a normal file.

The Directory structure within the inode-btree linear space is a flat link-list taken from toyfs
and therefor does not scale well on big Directories. Its on a TODO. Perhaps port the ext4
directory btree+ structure. (Original pmfs had the linear ext2 directories so it was just the
same)

otherwise this code is pretty small and simple. But can be a good place to start your next
ZUFS project

[license]
The code as *pmfs* is GPLv2. Therefor it is its own git tree that needs to be cloned within
the zufs-zus project directory structure. Then the user may compile and load it on her own
machine.
ANY changes please send via the Github system and it will be reviewed and pulled into the next
release.

Cheers
Boaz, Shachar & Sagi
