Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3805C3CAEC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGOVye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhGOVyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:54:33 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447FC06175F;
        Thu, 15 Jul 2021 14:51:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z9so6731153qkg.5;
        Thu, 15 Jul 2021 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1n2ZYwzMuZNMvNqzk665faAainJCiBnpaZMHk7Kax4=;
        b=nUmelEKOHP5f+EQ/v//lf76rXKgIlC6jqwGLHInzNIkYKLgTPwZlOcaXr+2NrBZtyV
         duZ7AsWHRm81s5lurt0XSuXFkvET4YviTLpvwGlXsPObnumavUelk6OIfx3HK8dnwM52
         yU3fmXSsrZbevi9/lgIStipOGQkEo+NPeSEm/wk/reR5tBR/qFrk0+k5ZznAozjGQfly
         9DG/uVL2UpMXg2mtO4JI1b766KcJ9DGDnuP+E9MnOHxQPwcNMoZ6v4GQ4dYw4BWuOVQf
         5BjpzVNaRwvkMZ++EaiAgVoLv1KMW/nARzcJFU/Mat05dkmXiu3LvnQWJUI/l5CO4jvZ
         TujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1n2ZYwzMuZNMvNqzk665faAainJCiBnpaZMHk7Kax4=;
        b=Y+35CIiysoGx2d2h06VAJROQvOqmgVkRyPtMzwk3fCX8n+m7aosgBSgq3uboSkVozK
         QqXXyYMQ6bSm95xXxPgdOgwSzxsPfC7tkDSDF8eVdxcX+kbX8I6wYmkUuTL+CwyyEIOD
         8ko+K/jBP47JWwlhKVqhfD8xKCNfzXsDZnikwpCbmjvSsGdWz+VlX5/fTWZJZOV1Tz9F
         x59lFMTaFnzQr0AMETP8eSPConioo2wMlfFuFmzB2lTJa6+sOB+pZbI5YFGKktSI5RLN
         Yoe3Fbo9aAPV4j4DYqC5oAQvrImHbjv3cvkxBPwQR0iZdTGm+cca+yTC2x2TC9lUA5Ci
         blqg==
X-Gm-Message-State: AOAM533f0wk3PQPVlT2Zjo5MCq3CT8jGarfJNeWfaDC3LiLq9pKyaERu
        7ScmVxp0A2ngaTT88D/NLzE=
X-Google-Smtp-Source: ABdhPJw9jhVO4UZJqEeqx3kDcU/l2VOXRO2oBmNMpANS3M/swvB1fxLSF90WDdDBm7OAY6KmUjdwEg==
X-Received: by 2002:a05:620a:a91:: with SMTP id v17mr6074043qkg.437.1626385893054;
        Thu, 15 Jul 2021 14:51:33 -0700 (PDT)
Received: from Belldandy-Slimbook.datto.net (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id az37sm3044729qkb.91.2021.07.15.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:51:32 -0700 (PDT)
From:   Neal Gompa <ngompa13@gmail.com>
To:     zajec5@gmail.com
Cc:     almaz.alexandrovich@paragon-software.com, djwong@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Neal Gompa <ngompa13@gmail.com>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Date:   Thu, 15 Jul 2021 17:50:30 -0400
Message-Id: <20210715215029.2689112-1-ngompa13@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2021 at 12:18 PM "Rafał Miłecki" <zajec5@gmail.com> wrote:
>
> What I meant (but failed to write clearly) is missing feedback on *the
> latest* patchset.
> 
> I highly appreciate everyone who took time and helped polishing that
> filesystem to its latest form.

As the person who tested the latest ntfs3 patchset, and had tested
many of those iterations in the past, I would really like to see
this *finally* land in Linux 5.14.

However, I get the feeling it's not going to make it for 5.14 *or*
5.15, and it seems like Paragon became discouraged by the lack of
feedback on the latest revision.

I know that compared to all you awesome folks, I'm just a lowly
user, but it's been frustrating to see nothing happen for months
with something that has a seriously high impact for a lot of people.

It's a shame, because the ntfs3 driver is miles better than the
current ntfs one, and is a solid replacement for the unmaintained
ntfs-3g FUSE implementation.


-- 
真実はいつも一つ！/ Always, there's only one truth!
