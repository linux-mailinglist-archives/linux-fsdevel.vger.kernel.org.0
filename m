Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F744288D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhJKIe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhJKIez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:34:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E6C06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 01:32:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y12so51648497eda.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOXsNrzY60uI0pgR5Z0rE9TCYzMRKq69zTlRtW3ar3Q=;
        b=5Txo6x8f7LWi46N7oevu7OqzhT5gQ6mWAJ0kCcEy7l0G5xbs0/cfrXAFjSgzZW7poC
         xPNpiPAMkDYw0WvSsXVOvtyfVRobeTrXmvFg+uCwQqOajlSd1qQJbdrxrr30tJD8WYNL
         gd5tFDjPHyLI/HMIO/XjNa6hVC7rA3LaTPW7sShkm5p/y9/uYxFEGp6eWDNRnNTKPbXy
         x/Xd7D+s4rmvMvZapMyOK/wVnge1mfOlD5mjse2c/uCU1FsiiL/9+qrjcvLQqdciyqZs
         dk8UVLQRqC8Smgr/o8QSlb9aCgudkRHkkcM6DRh9XLsiCfV2YkpY1ruVRqXnlW2INYt3
         A+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOXsNrzY60uI0pgR5Z0rE9TCYzMRKq69zTlRtW3ar3Q=;
        b=GRxX9CeBZXOyyPoQTb0hi/ehA5nAsjS3XkBe75tYglINyhpnY1JFEZwIkyMCf+s7Vz
         SJmYzA9WTzMHrNsus8af4a7J9N4fOcHvpmvM3MjlkFCEv85Swlq4X7reHBCzclLbQIOC
         okAa0/HCl3YXYHUK2n4VgsgHV7YJCHlpdfPi0S7FwoNFCOWQTnlVnBOKqDr/HfPligI6
         KTlfWqzhQs0PDs6zsw956XDopT7KUM6mS5a9uUIAGHHdc9u3lh8HovPh8seh9xEN6pZg
         ceFdS1Ld9BcuMtv4hDTkG3x7RENGaNxgwT9wyG8ZXZZVvVbhClVuq60k+9ToKcMMXkL8
         VwGg==
X-Gm-Message-State: AOAM530MfyFK5wqHaWLsqhAtU+7XxG15AugDBG472ZztCX2J/aa7zf5L
        t0GVie1Q3KxxHCvtTNlmZRTtrv4bjScz/Sh02Mex
X-Google-Smtp-Source: ABdhPJw0UGeuT5H5fcyL/6kzs+woGkopnu5gM0tI+8BJ6+813tHOWdOiXRVmSnyFXI6wzyWYaRuttbrMNqUffSWsei8=
X-Received: by 2002:a50:d88b:: with SMTP id p11mr39341822edj.287.1633941174303;
 Mon, 11 Oct 2021 01:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210831103634.33-1-xieyongji@bytedance.com> <6163E8A1.8080901@huawei.com>
 <CACycT3tBCdqPfLCTX4-ZDSos_hYPyBQu0xRHRu=ksaFk0k7_hA@mail.gmail.com>
In-Reply-To: <CACycT3tBCdqPfLCTX4-ZDSos_hYPyBQu0xRHRu=ksaFk0k7_hA@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 11 Oct 2021 16:32:43 +0800
Message-ID: <CACycT3tZbWpHg5D4rQqpSd3Yxz6zFCsUj+R=AGH0JRw0gEBNyg@mail.gmail.com>
Subject: Re: [PATCH v13 00/13] Introduce VDUSE - vDPA Device in Userspace
To:     Liuxiangdong <liuxiangdong5@huawei.com>
Cc:     "Fangyi (Eric)" <eric.fangyi@huawei.com>, yebiaoxiang@huawei.com,
        x86@kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 4:31 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> Hi Xiaodong,
>
> On Mon, Oct 11, 2021 at 3:32 PM Liuxiangdong <liuxiangdong5@huawei.com> wrote:
> >
> > Hi, Yongji.
> >
> > I tried vduse with null-blk:
> >
> >    $ qemu-storage-daemon \
> >        --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
> >        --monitor chardev=charmonitor \
> >        --blockdev
> > driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0
> > \
> >        --export
> > type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
> >
> > The qemu-storage-daemon is yours
> > (https://github.com/bytedance/qemu/tree/vduse)
> >
> > And then, how can we use this vduse-null (dev/vduse/vduse-null) in vm(QEMU)?
> >
>
> Then we need to attach this device to vdpa bus via vdpa tool [1]:
>
> # vdpa dev add vduse-null mgmtdev vduse
>

It should be:

# vdpa dev add name vduse-null mgmtdev vduse

Thanks,
Yongji
