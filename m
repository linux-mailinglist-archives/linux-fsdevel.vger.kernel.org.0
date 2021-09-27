Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D84419ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 21:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhI0TDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhI0TDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:03:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB40C061575;
        Mon, 27 Sep 2021 12:02:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i4so81570259lfv.4;
        Mon, 27 Sep 2021 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBTq8I3NOShXYZBIuCwUw+73ao/llMiq2AxwPqrbQhY=;
        b=pjpp5vcDsDI298raVY03G6GDYJBncvUCFByP86SuHvrYdg9eH2B63WI1ZX1R/f2Y5C
         NUaMUsL6X6qZk0SP5X/D/JtssWBHOsyDfVmfkDRcI2yBhSSuNcW7qZ1a+2cYS+nvQnlq
         qHeDtjDmoaaScQ/FxkB4bqi3Da/ZB9eXYWNQg8drPHTkN9CMAoXeZ0IL8Bw/aSVPM5M5
         GD25a8RfvMn6+40l6anpjonJrdxpnrm92lR7dG2qolq+GRGO/i+8eQwGbeQHiRPYZTqC
         bSjJXxYnxRNqPTNESGGqd2Vk/+tueRssR0u5BG4RrNlTNxQ0uhELcu6tgO9sPlkPgEsy
         8PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBTq8I3NOShXYZBIuCwUw+73ao/llMiq2AxwPqrbQhY=;
        b=LySSl5vgzlZaPSz0DC4TiZeUH1XjGvhWTJUXnQXwQI93oGJ88A+L+zpjpQPUsk9N+N
         kJSyAYwsX52m8nF/UFD71UbC0cLjO7p5rEFh6YNXFJFhQxfDTx2HJqQnAjPSnrTIsmI5
         5B/UioBNaGYQtPN0kYYt3lY0x33I3njRVGSahXhQibaMDEMkC3RKuvvN9/UrUOgkUoJS
         IxDlfg69bBNX6s+EZt08mEOrvmzWctfHpLHcFGxkz0Hsk0QZpL+agijgs5izX2bx/VsP
         /XEcnOOc9to4x9unnrjFGmJAwaw+1nhN7SK8lH5GXVdHUqnfGNAc+1xe5qP1A2V2WUGt
         cCLA==
X-Gm-Message-State: AOAM533D1RoguNtBuy4E7YOaqg7bN98aO70YUwq2QPjd3i1Uo/EKbJbi
        Au1QJB1x6ZEC5e0wo/BF6TXSFXeT9uU=
X-Google-Smtp-Source: ABdhPJy+08o2NUFQfzYv39MmXVMfw1zN44e4CFgofkaIxMfN94bv0N/Oez8mqNT+cmuFqYnW0DG6aQ==
X-Received: by 2002:a05:6512:3989:: with SMTP id j9mr1307909lfu.213.1632769323684;
        Mon, 27 Sep 2021 12:02:03 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id v8sm1593466lfe.6.2021.09.27.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 12:02:03 -0700 (PDT)
Date:   Mon, 27 Sep 2021 22:02:01 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs/ntfs3: Refactoring of xattr.c
Message-ID: <20210927190201.yhlipxcitremds3e@kari-VirtualBox>
References: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:26:26PM +0300, Konstantin Komarov wrote:
> Removed function, that already have been in kernel.
> Changed locking policy to fix some potential bugs.
> Changed code for readability.
> 
> V2:
>   fixed typo.

In the future please tell more closly. Now reviewr has to check
everything again. It is also good thing to write if someone suggest it.
Then that person can see right away that you change what he/she
suggested.

Also usually when someone comment something to previes series version
then you take all commenters to cc list. Usually reviewer will might
wanna give reviewed-by tag after you change what suggested.

> 
> Konstantin Komarov (3):
>   fs/ntfs3: Use available posix_acl_release instead of
>     ntfs_posix_acl_release
>   fs/ntfs3: Remove locked argument in ntfs_set_ea
>   fs/ntfs3: Refactoring of ntfs_set_ea
> 
>  fs/ntfs3/xattr.c | 69 ++++++++++++++++++++++--------------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
> 
> -- 
> 2.33.0
> 
