Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39A3ECCC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhHPCsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhHPCst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:48:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D87C061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 19:48:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa17so24244698pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqX8t8R7uV654M2MohW7fyhuw+klIF6wKRXKe6QTsrE=;
        b=NGaE+qgyaA3sWVwUWNdViTbu8XrVjnP/eTxOK72dY4Am61iX7CQzwgTlqLke5/RLiD
         Hd+eBURADhKE0ECEplIFQQA3OdEsVB7BL9JzSrWxHlxrq+C+jdwv1B7VlG8b6HZfSpyW
         /QA+IiSb2e1JeIq417bKetNyb1SuNE7loERSbun6JU6WQeV+LuIROqpox3+f9ZMTGcSp
         BaWBYFcd344ju5bgbbVusls32Me0KvQByzb/baHOBblf/oswZq9Wc8PiA7YmA8jA7BmU
         z0mM+VlZVHE1NfOVkU7kqHsGoiJ+GRZQ0YpxRVB5N6K8KrJbGKxz0/VjVo5yFFQKxRkP
         sGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqX8t8R7uV654M2MohW7fyhuw+klIF6wKRXKe6QTsrE=;
        b=q8rWr6rPJje9JAvt+55KhEDZmwUtc9LfqPmzsyOME90RVlDYVIwmOxj+5t1fhWvfGi
         gbS0GRY+AhGEd/hBOPVue/gyQrmqFDEpdWiHeqOwZ42IamC2QoQItBrCzFbMo4lF0v45
         TgTX2TglyzbFxwMtoP2r9LotZ/uTmVS/rm9b3YsZ2bCmvQgnoI9WCY0soLwbcMO2sVnj
         zaFKsuent933DiHMg3oDFcau7gRJWFTmyBd2jvb1mjTETA5+0V/tnw+ZiuG0u3LQKSkE
         bGY9UA5M8/BLENPQ8/EnEcp00IR3bpfSRUAxuaFFL2f+WwGClyIyqlJeiEEYqR3nRFlk
         +AnA==
X-Gm-Message-State: AOAM530ZgPRYPqpmx+RaH/QhMo17TZWaZx3MMdfEPm/ajoNX4l5HoX8J
        cEptIL+JkcrmhFD2zA21AsNwh8tsiUrMzhOKtWE=
X-Google-Smtp-Source: ABdhPJzZs2vccRBcmYHbTDIrLQeVtwkX7M0SmbbgBnxkbjLAr3V9YPFMgPrTQOOaFAacPNQm3lXWeY3aCaQO6yBL7lQ=
X-Received: by 2002:a63:4005:: with SMTP id n5mr13741881pga.140.1629082097726;
 Sun, 15 Aug 2021 19:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210130085003.1392-1-changfengnan@vivo.com> <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
 <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com> <CAJfpegtes4CGM68Vj2GxmvK2S8D5sn4Pv_RKyXb33ye=pC+=cg@mail.gmail.com>
 <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com> <CAJfpeguErrcKc7CKjnp-uM9VMyUjrtjipv7KGSu5xeY9joOQxQ@mail.gmail.com>
 <c5982115-e62c-908c-8aac-011ca682f193@vivo.com>
In-Reply-To: <c5982115-e62c-908c-8aac-011ca682f193@vivo.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Mon, 16 Aug 2021 10:48:06 +0800
Message-ID: <CA+a=Yy5UzTUvS+JvtRtD=tUw0-UG4k=THdHMaXYEqOymo8g6UQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 3:12 PM Fengnan Chang <changfengnan@vivo.com> wrote:
>
> Remove cache=always still have this problem, this problem is related
> about FUSE_CAP_WRITEBACK_CACHE.

FUSE_CAP_WRITEBACK_CACHE by definition asks the kernel to trust its
own inode attributes. So I don't think we should fix its semantics.
Instead, in your case, it seems that the two mnts (PATHA and PATHB)
are not sharing the same superblock. I would suggest fixing it at a
higher level:
1. use bind-mount to mount PATHA and PATHB,
2. or add a `tag=xxx` argument to fuse mount option to uniquely
identify a fuse file system (just like we do in the virtiofs case)

Cheers,
Tao
-- 
Into Sth. Rich & Strange
