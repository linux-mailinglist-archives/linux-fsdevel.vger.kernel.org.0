Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2341B0764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTLZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgDTLZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:25:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C013C061A0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:25:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id s10so7009871edy.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4SypYI7tKk3MOyDrVcIOhbzofpHJxw1kr3NsPWFunY=;
        b=mry5H3UhLVDFuJyXHzkG2xn5Ac0Norh5KK5wehDbdoTllyDQL62OsdYF7piaV0mPPP
         W1sig72TR2lrXc1YYfOUb5QFgN6A/vF7O1VXRKxjKe6RPNLPv1Ise/GsF9Ait6AG+HLz
         1CiP3Zl0DDz2xHRuTok6fZ56/tW0lDQePJ+jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4SypYI7tKk3MOyDrVcIOhbzofpHJxw1kr3NsPWFunY=;
        b=bNRSf7aNqnkfOiA+XCpQV2f8YFB2XWC3q570DH/PyuqX+1IuSVG5lSqXTFQ/qGS1qO
         vjZ260ZpYukiOj0TEsdut91dqL5ZksAXPd4JQAAjzzXSRP0JBJRlYAfyI6yrm5NPgqlf
         XJI2TUxANnHYM6jENZLfCVOTlY/k6hh9lUvG+MK4Etlf2ZHJym1HVxzg2gU5THBD+Oj0
         GB5OXh8fQAZewJfehKNJ3N534tDrxKD3iNZ5fUBssz9vrzjuN5vuTwbIFETq9TyZP1sJ
         bHsk9bgcXMla/vzX5Ee2zrFcpBSBE3EPIbqXUE27q0ezDz8rJUz/1sQdg81lX0Mhd/xS
         qaCg==
X-Gm-Message-State: AGi0PuZGNEQg2wPLuhiStdvtFjqdPGSpGL3nxFQDhlcS5JhZJ0JYK8e4
        MpGyjJG+8ZQNWaJE2PMRtXSxPP486tNWgAmW6cBqJw==
X-Google-Smtp-Source: APiQypJVUo43ECX1ny9uSU72A1WZav7rKM9Lxy1VagL35X9dAgr/GJJF7Ykv8uKOQzZQEnMZonxM7APFfsyv6BgPccQ=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr14432359edq.161.1587381921220;
 Mon, 20 Apr 2020 04:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
In-Reply-To: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Apr 2020 13:25:10 +0200
Message-ID: <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
>
> In current code, for exec we are checking mode bits
> for x bit set even though the fuse_perm_getattr returns
> success. Changes in this patch avoids mode bit explicit
> check, leaves the exec checking to fuse file system
> in uspace.

Why is this needed?

Thanks,
Miklos
