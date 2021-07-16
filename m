Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD73CB6F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhGPLw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 07:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhGPLwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:52:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2475C061762;
        Fri, 16 Jul 2021 04:49:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id go30so14712002ejc.8;
        Fri, 16 Jul 2021 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtDoDFMaQlXUnkyWhZs2qGQGHMHOzDLb9YuVOuYuZEs=;
        b=DVzrB6KgeBkfuRRt0CwVodOGYNLy+VguYEyM4TEizkoGAY14clsIu/PHBKeRDJAFqU
         68le6G5K/5MvhOHlz+FZ9oNDSGB+YhWwsrs6eme5TSx4COQTbGyPDs3k3V/nCHSQOgyL
         Yi5mcx/qcs1eRFU1g+yivig7A5BljxFsZHX0VYAfFCqKFMZz8rJC6XRZD3HfHliZHtSz
         ASBCRLKLL4zo/s9pca5exrOrSU1WLmUvD3X7uulalTHG8UlCByIy/pg17i3Zo47IkgZ8
         gCTtdu5ooB/cY3wEXjAKmtj/0gzjFdvSj24LJtZ3gvosPiUdzeQULPuyZj60XNjDgVVY
         2OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtDoDFMaQlXUnkyWhZs2qGQGHMHOzDLb9YuVOuYuZEs=;
        b=h8MtpkbeIZPv6iHC5jvmzgGso7OVI0HcuGZnMO2nWxVvSEWhGauNN2zi60PWjhccVc
         6JZYtM3o5x8l9T7dJR1/mEMLuADXfvdBXrAov9rZZ1p+ulrhW9e9mLV8POvcXyOCSqro
         ojyBKL6U+lGBrMGG1LQYsV/N4ACu/92M7HOFUID6Ve4qLWipXQ2ykWVKOOLYTpnYwMS6
         uih9Rrd28KoUyy9UEI8+U5oPuolfz/UbCucVpRvCrrbIfiuhFHyLAB2hPZ3K8UAzCScQ
         u6QnSaBbLaIVTwz3x8LRBMsNDHEEIDjumS8q6KyqLCKVXVgZmRn18aLMtSNrt9teCWpI
         TSig==
X-Gm-Message-State: AOAM533pjtuaFPnvuB/JnuS+djj+MLvuOI6UW1G5p8gWuqT3c//GfMWe
        7Uafkh4XqtuYpaYOjcYcRQc=
X-Google-Smtp-Source: ABdhPJwkQAOs7i1BtT+HlQ5gKECel0UQ27xDJ6WwZWxjuEqUyt5iJQK766/ia4xuuZVq0TN1uAu/DQ==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr11427871ejb.283.1626436161394;
        Fri, 16 Jul 2021 04:49:21 -0700 (PDT)
Received: from L340.local ([2a02:587:7e0f:8439:950c:3d11:5241:56e4])
        by smtp.gmail.com with ESMTPSA id cr9sm3572588edb.17.2021.07.16.04.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 04:49:20 -0700 (PDT)
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
To:     zajec5@gmail.com
Cc:     almaz.alexandrovich@paragon-software.com, djwong@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Date:   Fri, 16 Jul 2021 14:46:35 +0300
Message-Id: <20210716114635.14797-1-papadakospan@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On the subject of this merge, I have to stress that this ntfs driver (fs/ntfs3, which would probably replace fs/ntfs, right?) is an important feature, from a user perspective. It would mean having good support for a cross-platform filesystem suitable for hard drives. exFAT is welcome, but it's a simple filesystem for flash storage.

Relevant xkcd: https://xkcd.com/619/

I think Paragon has been very good about supporting this driver with 26 patchsets and in my mind it would be suitable for staging. I've seen the discussion slow down since May, and I've been excited to see this merged. This driver is already in a much better feature state than the old ntfs driver from 2001.
