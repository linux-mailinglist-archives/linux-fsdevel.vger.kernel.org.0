Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A683CB21F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGPGBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 02:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhGPGBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:01:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C9C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 22:58:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dt7so13356337ejc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNIcsNcApjis1NTktSvCbyBOryqsRvjiOQV2BWDb6+s=;
        b=TQK6m8gh6eyv4XcwUSnojbI5yha7V2HVDNN/U9sVHqD+EC3Dq+C+1TUL+URviz+Cl1
         YmvUoGJMfZy4IyYdzAM0CyEPWMmNn4XPzKZiO7TwpHMU3jwrPaD7HiWSOx2g4a587/jD
         QiA0+yy51X1Flg/tVhRxwlrQpFX5lh1S0Rx2YxCgz2EIeSXy37yZ3W3GEhaQRVXl8evQ
         WJxNkP5I+19UdslLT1+jyuD1e1vMZ/8Ywp3Xn1l0YJqV8josqefmVRSPA8+3bft1rVCc
         mAB4j1cvys/AsWcrL2PcJfvCTO+XNg+zh4uOtVcVdJ81unLz2qRgmRHaPrO939kOPgWv
         pTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNIcsNcApjis1NTktSvCbyBOryqsRvjiOQV2BWDb6+s=;
        b=b9+MY5liZM8+t4gKH1ZHX0Zes5JZE+McDelPB0/eL2h9M7QQs8BIVV7yL3QdhwcDsO
         d5B3b6qGEOQLhMNSDZrLSlSZkVl08HVlSLgXNDiks0Jr81k6ZO5WQAwN9DUq491MU8PJ
         DCD9HRHJzpsz/RiWAzglaHCefzBDtt8H9NLHJjXL/NfmODolySrBXIuhm2EIaP9PygUK
         sW1pBzOEi/5EwiayVrVcKAr8ZkolRPYIN55Q8AoPN+k7NTAt3TOik7Q1wKtRHexl6NOq
         6I61EG0ke3xFoN40EBX9gwpZDk6vHv7S3xA9z2z6M8KVubo/SJcmyf2m2qDTcEJlJw6o
         XBRg==
X-Gm-Message-State: AOAM533faeLV2Wgyw6Myy4H8bf7KDYMyngTOTUAzZAUEJr9pg3H1BaiX
        e6WnuFIjUjs/iQQ0iSKtKLnkFztBfEgZ+K3BC84=
X-Google-Smtp-Source: ABdhPJx9RyRmynPnAevrG0jIgHpc02Z/2HATtBbLS1hEWhAQ6BQWzQyP0U2JuhgYypWz0KTIcuiTSLPvbOoRFUP6HYY=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr10004083eju.371.1626415087288;
 Thu, 15 Jul 2021 22:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
In-Reply-To: <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Fri, 16 Jul 2021 13:57:55 +0800
Message-ID: <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > Hi,
> >
> > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > mount option:  -o dax=always
> > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > can hit this panic now.
> >
> > #It's not reproducible on ext4.
> > #It's not reproducible without dax=always.
>
> Hi Murphy!
>
> Thank you for the report!
>
> Can you, please, check if the following patch fixes the problem?

No. Still the same panic.

>
> Thank you!
>
> --
>
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 271f2ca862c8..f5561ea7d90a 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -398,12 +398,12 @@ static void cgwb_release_workfn(struct work_struct *work)
>         blkcg_unpin_online(blkcg);
>
>         fprop_local_destroy_percpu(&wb->memcg_completions);
> -       percpu_ref_exit(&wb->refcnt);
>
>         spin_lock_irq(&cgwb_lock);
>         list_del(&wb->offline_node);
>         spin_unlock_irq(&cgwb_lock);
>
> +       percpu_ref_exit(&wb->refcnt);
>         wb_exit(wb);
>         WARN_ON_ONCE(!list_empty(&wb->b_attached));
>         kfree_rcu(wb, rcu);
