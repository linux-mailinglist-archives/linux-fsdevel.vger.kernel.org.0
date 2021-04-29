Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6536E353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 04:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhD2Ch2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 22:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhD2Ch1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:37:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEECC06138B;
        Wed, 28 Apr 2021 19:36:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u17so97672685ejk.2;
        Wed, 28 Apr 2021 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/vop45HHXD7xdWpJ3LqRkscEPKwG+bV95vmdn+ZXRQ=;
        b=i9Mdnar7Joz9zzIF+3zVrEX8TnA0bOMhfP20/XDOX7h1QzUlUFFJEbYBw0YV0NUb9Y
         RKKzADx1vNokvehQsmrVtCF2rzcUU0FjeaEv5nBgR3yhMJLBmqhBbGH0LjGFm3TzU8Wl
         On1sD4rmam2ZrXYCu1huAsYhr7ggHBkfKdVtzaTZfrEaP37cRlbCMN2/Fi3PefqRQDEA
         CQMrussJzSTFPozJa6vAY4h/5wbIOnWfItR4KN8vMwhM3gs8K5Z93265aBA4y7OSWC6m
         UaM2osFrT4x+L1RGNKU5eZTsaLWFcvGYTtR7X+l0GIWqEObXT1Lop4/60kgpq17YeKQv
         rqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/vop45HHXD7xdWpJ3LqRkscEPKwG+bV95vmdn+ZXRQ=;
        b=lh5uhxzBOsBFqOt366TpAXFaKkHwrslLHY72E0c+yVOTfGao0LBD6pHWzOJ1bxyqkZ
         J+X0dv5m2Bk6OYL4DfwH0Smm8583hG2EQMrw1DWl8lv6e/KgP6ExG4TYc+2VDsT3YjW0
         9u6L5U8wmj/jZzVxca2VjL86s59Zs6HMabPKxsRgTFhYF4/R2FLk/U0a88h40lfccNPk
         cYym6JQQd0HjkHCewPwKQ9DSIaEGwuIkMfpRBxCq/meD/tW6dy0IxkuIn31vAEOoL2eF
         yMqCMoAiKIVPRIHqoaQOhbboMATRzWxoW74hHonG82WX1byyZr05HQKWglXThSgGfWGu
         UkUQ==
X-Gm-Message-State: AOAM532oP/eawW7WhKoR0dLkmhzBexAeli+Mif59rlgReD39KPeT7SrM
        R3J7ERoJcHK44laQNKW4qRGPKnposSONKfp0fs8=
X-Google-Smtp-Source: ABdhPJzo1sZapVxbBmhcf28OPaKfJB1HEKMZz3n9P0QBcSLXxZ0ZdS9NveO6RNNNtHkJnqN7ig4uJOlshMU4EEVFTPQ=
X-Received: by 2002:a17:906:4d11:: with SMTP id r17mr11168971eju.217.1619663798868;
 Wed, 28 Apr 2021 19:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210420175631.46923-1-david@redhat.com>
In-Reply-To: <20210420175631.46923-1-david@redhat.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 28 Apr 2021 22:36:27 -0400
Message-ID: <CAEdQ38FOJdZxB7OGd569Lkn+RGPyjoukriwDfBEf2QKHvYguXQ@mail.gmail.com>
Subject: Re: [PATCH v1] binfmt: remove support for em86 (alpha only)
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This seems very reasonable, and I'll merge it through my tree unless
someone beats me to it.
