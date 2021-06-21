Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA63AE52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUIrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFUIrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:47:14 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF7C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:45:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c1so8778343vsh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqc6mYCTnX3G1/+4gTg7lVP1C5NTClRqE5ZPFXvX0Yk=;
        b=J/fWvETLjOn/GtW/JjG96pY0hPt5QYXsnDa0KiwR5TJCXGsPAwAMehPL7kiKh0DPnF
         tbgKMBg8jmeF8sQ+Zf58nuwxe0/srnBFYgk7uS1N7hoOHPM1Fbpx5fnU3H24k25+MRA3
         XvxdYcKbW4aPpsA5WpqL6sg+IxjV4vlzo2XYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqc6mYCTnX3G1/+4gTg7lVP1C5NTClRqE5ZPFXvX0Yk=;
        b=PWTUc34117IcrRn1hQqAZFJQxaBN+TmxGn2ISjDr5ayA4welavnSKPQCcKXHDpJeT3
         MnZ+f+HkP8ezXwevClbSEeLCio4nYDKDA9AIRU/Dnqr9OLMoHdrJzTh2yrflVGGvQ/6O
         VYjmyCZneYyZykQQyFEpeNMs9GOUC/6RcHNkQP/v9372fPiu6KFhm4jrt1H6nvXi96kF
         +iV1ybOpWqxyWfc/9E7WXSgpVr7kpSFuoelYExj6Lyyc4NtqW+M3181Knyh8Gr8TFMvM
         GWRgd3952xH0iB1uDH6kaI5QNh51FKIUFuSdzITZVztnQ2z04LJdwJiByvdNYcKoxrlZ
         jIgQ==
X-Gm-Message-State: AOAM530Zbh4LxNbI2+sOhgS3wM6vbt5KpV1V0leMWxZiAn7RrgDpmJzl
        znXuyLAC5g7CFPQV8vJc29gAXkFiv2QvCMk3jx6jCg==
X-Google-Smtp-Source: ABdhPJzfGZZGHK81cg2PLydWMfpNPAVEBG3yip9ZIDbO+5m7X0px+1Z98X3E6igGMUtXdRda/P8PpoLujgaPZcJ5/H4=
X-Received: by 2002:a67:e252:: with SMTP id w18mr3592727vse.9.1624265099317;
 Mon, 21 Jun 2021 01:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210604014617.2086760-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210604014617.2086760-1-zhengyongjun3@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:44:48 +0200
Message-ID: <CAJfpegv3XMq_mBtcMaPP8c66nrtuQs4b1Por3btJDPVz4jH88w@mail.gmail.com>
Subject: Re: [PATCH -next] virtiofs: Fix spelling mistakes
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Jun 2021 at 03:32, Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Fix some spelling mistakes in comments:
> refernce  ==> reference
> happnes  ==> happens
> threhold  ==> threshold
> splitted  ==> split
> mached  ==> matched
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Thanks, applied.

Miklos
