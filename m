Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1443B1A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFWM5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 08:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhFWM5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624452907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J+ARJSprpdWf6XucvxKdRp9dZzCJmxljzGlWc6xT4+c=;
        b=hQ/8Ec8/a06dglRKPIk2VsD26+nP4I0qKgXPMhm66N2Xv7ZjKWbRp2GOzU+AjO8zeLgdh7
        H6PKXEidi5l9+k185J4YmVlLnmscVh/m6sK2QGO3TYO4MDjteDiwJJIfcJz5iaTSjmnWuZ
        K1RCmLqRQLgmLOM3v/9xbDZiK79E5O0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-T48xUgLnNfildOb4dqC8HA-1; Wed, 23 Jun 2021 08:55:06 -0400
X-MC-Unique: T48xUgLnNfildOb4dqC8HA-1
Received: by mail-ed1-f69.google.com with SMTP id l9-20020a0564022549b0290394bafbfbcaso1267675edb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 05:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J+ARJSprpdWf6XucvxKdRp9dZzCJmxljzGlWc6xT4+c=;
        b=Z0hit+f/8aGN1e4x4w8SeZEf2FnjJD7QlN7sE/9mqCSeE6FYJjh64aDdB6iSflZ7QY
         Vf7ibTucy6cCzimRMJZBdq+zuDpZBpOsB0KCUSa7ZAiYf19E+AwrbJdDuB6G8X4ocKWu
         jT8t7OF09RYfo8GFe3hxrkKej6viQBH3C/1o2rwRzwBBcWIDk8gW1suQqkpHbxKf0O5w
         AU1erCoSTm2ad4R57GLp37fhmhj76hsfzhKAwps4kDnoPi37q+qIye2pxr/VKS6mt8nN
         m3rT6IaRg2xajhN4RuvUd6GYT0Wca2RxBeSX9gg79O48ywfNFjI40L/syhlrZlCnwcRo
         o2uA==
X-Gm-Message-State: AOAM531kDmP3R7uVxKdd2dUSHsNU+9LDsRPYLHqcderHNc/dWI/hScKJ
        Xgw4o+cv75tQfNpNQaV3yQcL/3Vc2mqbia95OivzT/UdFG2zYxjVjB+5YYcWbvdbxmkKUU5WtSh
        QCZr4uu2m0RLYGzhZ1ZTOIu16/IdLjpb/votOy0KOpo/KCh74ZiVbjqBo9cRSBkRzyZ+PE4+HYL
        QSJA==
X-Received: by 2002:a17:906:4fc6:: with SMTP id i6mr9862416ejw.472.1624452904811;
        Wed, 23 Jun 2021 05:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQpukU8m4YzG84MyCZruKCIKRGHSJGZnoB1G1wQ8CbOQrELkgxJcQOJae/5Jt/+8BUWcQIhQ==
X-Received: by 2002:a17:906:4fc6:: with SMTP id i6mr9862402ejw.472.1624452904612;
        Wed, 23 Jun 2021 05:55:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lu21sm7294158ejb.31.2021.06.23.05.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:55:04 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] vboxsf fixes for 5.14-1
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Message-ID: <dde4bf6b-121e-909c-60e6-583419106892@redhat.com>
Date:   Wed, 23 Jun 2021 14:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Here is a pull-req with a set of patches fixing a vboxsf bug for 5.14.

This patch-set has been posted on the linux-fsdevel several times,
unfortunately no-one seem to have interest in / time for reviewing
vboxsf patches.

So as the vboxsf maintainer I'm now sending this pull-req
(based on a signed tag) directly to you, hoping that you will accept
it directly from me.

Note this fixes a bug which users have been hitting in the wild,
so it would be good to get this merged soon.

Regards,

Hans


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v5.14-1

for you to fetch changes up to 52dfd86aa568e433b24357bb5fc725560f1e22d8:

  vboxsf: Add support for the atomic_open directory-inode op (2021-06-23 14:36:52 +0200)

----------------------------------------------------------------
Signed tag for a set of bugfixes for vboxsf for 5.14

This patch series adds support for the atomic_open
directory-inode op to vboxsf.

Note this is not just an enhancement this also fixes an actual issue
which users are hitting, see the commit message of the
"boxsf: Add support for the atomic_open directory-inode" patch.

----------------------------------------------------------------
Hans de Goede (4):
      vboxsf: Honor excl flag to the dir-inode create op
      vboxsf: Make vboxsf_dir_create() return the handle for the created file
      vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
      vboxsf: Add support for the atomic_open directory-inode op

 fs/vboxsf/dir.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/vboxsf/file.c   | 71 +++++++++++++++++++++++++++++++-------------------
 fs/vboxsf/vfsmod.h |  7 +++++
 3 files changed, 116 insertions(+), 38 deletions(-)

