Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC91443B75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 03:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKCCoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 22:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhKCCog (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 22:44:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06D0361051
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635907321;
        bh=Eeca3MeiQZl0jKnzRXKCD3bnsnGwktsrZWB3LSkl1ik=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iJ9gNkHyxnsd3qroAttiI54fMqN7D8sZd35BQWo5HXFTJQnUgz4JY3hoptG3jhcIR
         t67FsIjjB0KGBPnXMDmg9Ywvv83QwAs6EVa2KV2edbEMX/Uv/siqLPIzjF2oVomvIE
         GrGpZrMe5IZox8VkPyXCkAUxR3g53Kte2DyR1SnnivjyPpQtGnFDuU1pVoHSRbkAjL
         BUIY7MeZPjeLv9DGjajIMd5UNZpFUHsHhtf+zaBNIuBkZKEC0Y9CQyzaa7DiYd/yW4
         2dVwbNP0Hinss4+voGR9aWwjHGyGIMzE3o72SipcBsw5Yv5pRN4Mdh1UPjrUQ7RQKI
         KWBD4gqdk+6TA==
Received: by mail-ot1-f53.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so1616793otf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 19:42:00 -0700 (PDT)
X-Gm-Message-State: AOAM5319W5oOkYRzbBO5ZGiY4dv1vFW//CiCQagzprsSI5NVwS86XZ7G
        1AgRBSTMitpIQggQmIIu1AgE9fZ8lq4IBhwX72c=
X-Google-Smtp-Source: ABdhPJzeFvN4Q/1JojJzdlF8O9JWa2j1kRUMjrw9BscLe2u2ul8hEtYW2Ik/CzI0Xu2TGl7KcoozVV5ALW0UHNQc16U=
X-Received: by 2002:a05:6830:923:: with SMTP id v35mr13952479ott.116.1635907320336;
 Tue, 02 Nov 2021 19:42:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:31e7:0:0:0:0:0 with HTTP; Tue, 2 Nov 2021 19:41:59 -0700 (PDT)
In-Reply-To: <20211102212358.3849-1-cvubrugier@fastmail.fm>
References: <20211102212358.3849-1-cvubrugier@fastmail.fm>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 3 Nov 2021 11:41:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_TgdN6_7Poq9pQLHTqNVXx-GjX8U6pna2wxGnwFbK_Sw@mail.gmail.com>
Message-ID: <CAKYAXd_TgdN6_7Poq9pQLHTqNVXx-GjX8U6pna2wxGnwFbK_Sw@mail.gmail.com>
Subject: Re: [PATCH 0/4] exfat: minor cleanup changes
To:     Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Cc:     linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-11-03 6:23 GMT+09:00, Christophe Vu-Brugier <cvubrugier@fastmail.fm>:
> From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
>
> Hi,
Hi Christophe,
>
> These patches contain a few minor changes I wrote while studying the
> exFAT file system driver.
There is a warning from checkpatch.pl. Please run it before sending
patch to list next time.

WARNING: Comparisons should place the constant on the right side of the test
#105: FILE: fs/exfat/fatent.c:87:
+	return EXFAT_FIRST_CLUSTER <= clus && clus < sbi->num_clusters;

I fixed directly this warning and applied to #dev branch.

Thanks for your patch!
>
> With best regards,
>
> Christophe Vu-Brugier (4):
>   exfat: simplify is_valid_cluster()
>   exfat: fix typos in comments
>   exfat: make exfat_find_location() static
>   exfat: reuse exfat_inode_info variable instead of calling EXFAT_I()
>
>  fs/exfat/dir.c      |  6 +++---
>  fs/exfat/exfat_fs.h |  2 --
>  fs/exfat/fatent.c   |  4 +---
>  fs/exfat/file.c     | 14 +++++++-------
>  fs/exfat/inode.c    | 11 +++++------
>  fs/exfat/namei.c    |  6 +++---
>  fs/exfat/super.c    |  6 +++---
>  7 files changed, 22 insertions(+), 27 deletions(-)
>
> --
> 2.20.1
>
>
