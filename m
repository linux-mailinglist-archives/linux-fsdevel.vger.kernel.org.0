Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3242243BC8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhJZVk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJZVk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:40:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA6C061570;
        Tue, 26 Oct 2021 14:38:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so1713738lfu.5;
        Tue, 26 Oct 2021 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TIHrps6JiOzeLQIEPEeB6Myv5l+xHPIBmw2UFFzGFO4=;
        b=N6EBwUks7cf6mmhJfql0FYYO7bBkJygq2VsYxdIXyyEPnFN9UKc7a5irXSeCBhG+2F
         rAbQOqlwlK0qx89nlJJ9UoLLK4GYS4n7Akwn+7W9c2aMdcC4m3CjDp+R7itTffIVb5Js
         9A9mlCvEtgLvZimhvgyUgOfVcDRlDdKxKArVLKHy7Ps1rT1mZiuc3vTI5YkCeQtzS5QD
         uWlTc/8aW6jwH0E6PVWQjZq6mbMvRZrQUQYhurVxK2SmPq7CSkjzjtve+gF742ECG6OI
         snhIEABgjA3JCmXN3U62Ry/H0ZoQRCk6JSargL3XbsP30KDABziMxT06V7w72qA7hCJE
         a/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIHrps6JiOzeLQIEPEeB6Myv5l+xHPIBmw2UFFzGFO4=;
        b=m1Nc0+C4UukkgT3dMZIReYqLESso9s/9NsUeBvkXXxvlyV9fDwUKFqbzhBKrYOncrB
         mUrsWHFo7tyqNgkLjRmpg0S6P8nXApnbgbZrE7UFd9DobqsNTM9tiliS5cERTefw3csP
         56nvqGPiR3WndpH/PXYO/Y7L5W8VZNunNxrHKVDgwzjlIy/jhx8+AIiStFrouWOHOjNg
         qS+y+6CrYXagvZm1LeeMwEkbhTcw/kNSdTlPx0HVHVmucHx1hLWpLakYFdolV7uVnMN2
         K5LkXxPrx2Hko8lIFKsPfL2WUwZfFOV6yBaF9/PGcNfexoSk2lL1iplXd2W8rQNEvJKS
         wHCw==
X-Gm-Message-State: AOAM530fiAd9donQV6Rob4tfvNs17hqxJj92nFeqKWN94BalX7OdFCVu
        1Mn5ZeBzbEzaDKrWwY8pkWiiArkYDi0=
X-Google-Smtp-Source: ABdhPJygEa663LGGoKEsOzBLTneQzfW9FEIe8ke8PqQ2pN4pjYP46/zwSwGxpeJn7W1eNR0MM8hEBw==
X-Received: by 2002:ac2:538d:: with SMTP id g13mr18073540lfh.644.1635284281150;
        Tue, 26 Oct 2021 14:38:01 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id j15sm2035119lfe.252.2021.10.26.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:38:00 -0700 (PDT)
Date:   Wed, 27 Oct 2021 00:37:58 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] fs/ntfs3: Various fixes for xfstests problems
Message-ID: <20211026213758.z5f6yuzgrdtedxqr@kari-VirtualBox>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:57:30PM +0300, Konstantin Komarov wrote:
> This series fixes generic/444 generic/092 generic/228 generic/240

Now that 5.15 is just behind corner we need to start think about stable
also. Please read [1]. So basically this kind of fixes needs also 

Cc: stable@vger.kernel.org

to sign-off-area. I know that stable team will try to pick also fixes
automatically, but this is "right" way. You can add this Cc lable also
when you make git am, but it is good the be there right away people can
discuss if it should be stable or not.

Please also add cc tag to other patch series 1-3 patches.

[1]: https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

> Konstantin Komarov (4):
>   fs/ntfs3: In function ntfs_set_acl_ex do not change inode->i_mode if
>     called from function ntfs_init_acl
>   fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated
>     space)
>   fs/ntfs3: Check new size for limits
>   fs/ntfs3: Update valid size if -EIOCBQUEUED
> 
>  fs/ntfs3/file.c    | 10 ++++++++--
>  fs/ntfs3/frecord.c | 10 +++++++---
>  fs/ntfs3/inode.c   |  9 +++++++--
>  fs/ntfs3/xattr.c   | 13 +++++++------
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> -- 
> 2.33.0
> 
