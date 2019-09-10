Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09B9AEE3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392109AbfIJPMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:12:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfIJPML (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:11 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8FE0C04B940
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:10 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id d10so16510wmb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ok77DmKuwYWR/+jMK4WhAD9NHGM7EdwE9jFD8NQZ75U=;
        b=R/ljod05F3HTvCbLu2x/oSQ9UbF9xx1NmNqnFM7byEO11bmKOFreuvigM3soMwolot
         aRY3FmIjpccG8yRWliQks2JcDNS/clhMki0WEMShZy6DkO3wj16dTqygSiE9vLoP6MVw
         stkEq4+ISocd2m4isyofbv7/SxjCco05AqWTrd7Qo8FNljsf4TSv11TRW9SjdlkkZ7P7
         CBtv9x7CNTXw3zIDSGh5q0bndKm+mqPZeRWPRVAzg+VU1lj6EkBk37gQnHQ+4KBzOgia
         ANvQ/S2qNr/F81Y6h6z8Ql7UIIdf6NJNBksbU+9aOdAjTN7x0GMwwq/HjsvlqdgOwMCf
         UJGA==
X-Gm-Message-State: APjAAAUXL4TftKnVslp4AB58GPy1ZKQz0yw//29+qLXaVxExN/hZ5rdd
        Gy6Rr5wY/DQyxE4Bae/s/cRTJssHCqIe0z5GrqeZ+7A6d4C2tPrrUlJPBK/3k/p5hKYWDJytVtt
        zYWM5sJRi3E1ntDe4YRotVrBeIw==
X-Received: by 2002:a05:600c:2486:: with SMTP id 6mr6188wms.82.1568128329750;
        Tue, 10 Sep 2019 08:12:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK83YfDzuT86HuZ3H/O3I8zo0LHSV3sHVESFxazSBMilYCRv10NdhmlMdluFQ8LY8sP7dS5g==
X-Received: by 2002:a05:600c:2486:: with SMTP id 6mr6171wms.82.1568128329429;
        Tue, 10 Sep 2019 08:12:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
Date:   Tue, 10 Sep 2019 17:12:02 +0200
Message-Id: <20190910151206.4671-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Git tree for this version is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v5

Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-v5).

I've folded the series from Vivek and fixed a couple of TODO comments
myself.  AFAICS two issues remain that need to be resolved in the short
term, one way or the other: freeze/restore and full virtqueue.

Thanks,
Miklos
---

Dr. David Alan Gilbert (1):
  fuse: reserve values for mapping protocol

Michael S. Tsirkin (1):
  fuse: reserve byteswapped init opcodes

Stefan Hajnoczi (2):
  virtio-fs: add Documentation/filesystems/virtiofs.rst
  virtio-fs: add virtiofs filesystem

 Documentation/filesystems/index.rst    |   10 +
 Documentation/filesystems/virtiofs.rst |   60 ++
 MAINTAINERS                            |   11 +
 fs/fuse/Kconfig                        |   11 +
 fs/fuse/Makefile                       |    1 +
 fs/fuse/fuse_i.h                       |    9 +
 fs/fuse/inode.c                        |    4 +
 fs/fuse/virtio_fs.c                    | 1191 ++++++++++++++++++++++++
 include/uapi/linux/fuse.h              |   12 +-
 include/uapi/linux/virtio_fs.h         |   19 +
 include/uapi/linux/virtio_ids.h        |    1 +
 11 files changed, 1328 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/virtiofs.rst
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.21.0

