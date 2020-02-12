Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06A15AB83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLO72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:59:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35868 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLO72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:59:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so2761462edp.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bva3ESNAH7S+gyW4kqBN/xUZPG3M4p2mIMqNbqmBqII=;
        b=YiFaV5I4Kzca6me9EoOWhKL8Hvu9nX959sQQ21XCIshyW9ExWrxy0l4GszmTue/wqs
         loywaMIWQqwUD6Jkqab1riB+ctgfTLX2qWUDQ8G+ChqVqjOyK9dQdPKryCGC6gIrKhWu
         NRYPqptNmLj2CStcv0LnLQGZjvMVOpBYu5jeWRlch3akbFEO69rrt/wBBHrM3/887I9p
         A4Z6/go5BgX7GD9G+3FNy3rwfuZsH/DWPFMLfO2Opnv/C+wD2x/KI4cDZ/d7JxNpM6BG
         uYw6hhKJ7o3dN36dgM3TcROlaYkcrhdurb2uSXnVQxhivHzcf3/y5be3q07mrIHaXPiY
         vl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bva3ESNAH7S+gyW4kqBN/xUZPG3M4p2mIMqNbqmBqII=;
        b=gKl3vH9L+Zydtl2U9GEdy6PP4FabqqCFCiKDuNkiQlrQJu3RYnJYPBsUwUd+/PEbRp
         0zK5Wom6ccZpjVe/994F8+UBpRYAy3vH8gLjXyPi7HFCIoBCnwHybpuAzPl/jYKlWsEz
         6qv2pwlAWOS6lMwmtd+FSe9sB4+rFdhAWYKL3pad+EXIpjg2Sve9Cua5BOSof9iD31uV
         6fttW6TwMTjJj1PJsPw7tdIl3+lQvP2ywNAUFPi38qNCKaFuAYCPsTvc49z1taAuc0Tf
         bR+2/VxnYuh34KleNIYx4TIhTO9fpUi5hgIv49wD46QmORuc7qU+mRPGYk3Kpw1Ys4D5
         mOnw==
X-Gm-Message-State: APjAAAW6cwk/g+/hbwuNsvbJoc4FnaPh7OQ4r4rGsL7r2UQyaqB1VNID
        R8dUMxRuvh9NEd0eeOsrb/atZg==
X-Google-Smtp-Source: APXvYqx9CKM1MbIK+QJx0gysRO/xj4DtcngCqdfmmre3vwfgW8suKHzv+yP0NHZQhQkBVUWDiDFguQ==
X-Received: by 2002:a17:906:2651:: with SMTP id i17mr11251313ejc.246.1581519566500;
        Wed, 12 Feb 2020 06:59:26 -0800 (PST)
Received: from sagi-pc.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id e16sm53878ejt.10.2020.02.12.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 06:59:25 -0800 (PST)
From:   Sagi Manole <sagi@plexistor.com>
X-Google-Original-From: Sagi Manole <sagi.manole@netapp.com>
To:     lsf-pc@lists.linux-foundation.org,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Boaz Harrosh <boazh@netapp.com>, boaz@plexistor.com
Cc:     linux-fsdevel@vger.kernel.org,
        Amit Golander <amit.golander@netapp.com>,
        Miklos Szeredi <miklos@szeredi.hu>, sagi.manole@netapp.com
Subject: [LSF/MM/BPF TOPIC] ZUFS: going side-by-side with FUSE
Date:   Wed, 12 Feb 2020 16:59:20 +0200
Message-Id: <20200212145920.18832-1-sagi.manole@netapp.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: sagi.manole@netapp.com

[Talk by Sagi Manole && Boaz Harrosh]

Hi everyone,

We would like to present the latest updates on the ZUFS project. Particularly,
We would like to talk about how ZUFS provides infrastructures for the user-space
filesystem to execute ultra low-latency IO, enable for smart auto-tiering with
a-synchronous calls to the user space filesystem, take snapshots and other
dedicated ioctls, support for mmap on COWed files and more. We would also like
to present pmfs2, a filesystem for persistent memory in user-space via ZUFS.
The work on user-space pmfs2 is derived from now-discontinued work of in-kernel
pmfs filesystem (namely, using a radix-tree for file's mapping). The github for
pmfs2 is:
https://github.com/sagimnl/pmfs2

We would like discuss the challenges we face in pushing ZUFS upstream. What does
it take for ZUFS to get accepted upstream? We would also like to discuss
the differences between ZUFS and FUSE, in what they resemble and the many ways
they are different.

Thank you all,
Sagi & Boaz
