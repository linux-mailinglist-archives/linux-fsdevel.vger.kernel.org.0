Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8A1E1A32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 06:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgEZEXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgEZEXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 00:23:34 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE866C061A0E;
        Mon, 25 May 2020 21:23:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so16467748edr.8;
        Mon, 25 May 2020 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkzgNeUNEbnNJvODhfdpaGDgefYg9bmlm6y6oms7G+c=;
        b=jmMpwOkn+zb0iuktLXODw0ITTnfQgUYYIUn8kj0+0VE4HnMJ2oS0v/rtjhq+58ObQR
         HcKQse3EBQoSWCXYdkHzQULOhoqQHiJg10YmK4zULLvuoMw0eK5eolwLwtRhJ4jiIQOT
         XqZUBHNhDGqVJ5zWoyDp+c5gDow3hxrjnAfXZzDH4LtAeyM9IlyUPUlg9jIwGOnSDzs8
         KKqTTObkJXjEYrMbDoXI33Cbte5NexMBR1KTJzRatBoppLO7Ya0oXsaED9FbTHan4nJg
         9IbL+t7n8tdA1mkZIaY0N8SiQiKF1oPtmtPkxiZ6jb+ROO+0EQ2WukKCXg42rRl7VOPZ
         yaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkzgNeUNEbnNJvODhfdpaGDgefYg9bmlm6y6oms7G+c=;
        b=lmU+SmmcPxfk+fN3of5FFnu663CyB9r5i4PsaTxT5N2D74kTwQhqp4N9pfHqNOax34
         cbKuqrgjxsO0CFsJCPsq7x8x+Bmc0xPqFgSdZjFbSSn3UQFnrnQXxfkHoooAa+6mqvaB
         kGBv6FOCKxCAwGtx2aGMcszk/zbjBXQiM8ugxrfVyiZeg5VdQVSGikHzO7GBT1i0yinr
         G3373exb5kG2KtV/+i+o+uVaahBlMOOZ+BC++esERiXWsX/+DIyqYyRVu032H+MprY2f
         foelanhosZGs8wrNEYY7QNFVVo01uiXmMgI0e8KEIeIeQtcWrmb03MX3Wk5pBi+Utx4Y
         C2GQ==
X-Gm-Message-State: AOAM531ONpfOKxPQz8A5IOEBZTdtqCpJmuWRRYR3ZDoeRaYcPzewqKFn
        nbeN2UIykNQu+MGp/dac6jaqoYstIlBDJfLcPxk=
X-Google-Smtp-Source: ABdhPJz2Vn5CDQom18MJ+e1T3aah4Ow5CTNZ/6hbKDPvn1FphzxzUH9yeJd2lttpcr/cKAgnWBjUbZrluAWcO66UHwc=
X-Received: by 2002:a05:6402:948:: with SMTP id h8mr17504187edz.127.1590467011223;
 Mon, 25 May 2020 21:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200525235712.VqEFGWfKu%akpm@linux-foundation.org> <21b52c28-3ace-cd13-d8ce-f38f2c6b2a96@infradead.org>
In-Reply-To: <21b52c28-3ace-cd13-d8ce-f38f2c6b2a96@infradead.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 26 May 2020 14:23:20 +1000
Message-ID: <CAPM=9twdkW83Wd4G1pS7cP2nf3wOmYvKxUfKA9EUkOEf7BuvKg@mail.gmail.com>
Subject: Re: mmotm 2020-05-25-16-56 uploaded (drm/nouveau)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 May 2020 at 13:50, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/25/20 4:57 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-05-25-16-56 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> >
>
> on x86_64:
>
> when CONFIG_DRM_NOUVEAU=y and CONFIG_FB=m:
>
> ld: drivers/gpu/drm/nouveau/nouveau_drm.o: in function `nouveau_drm_probe':
> nouveau_drm.c:(.text+0x1d67): undefined reference to `remove_conflicting_pci_framebuffers'

I've pushed the fix for this to drm-next.

Ben just used the wrong API.

Dave.
