Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472A92B76E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 08:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKRHYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRHYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:24:16 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60073C0613D4;
        Tue, 17 Nov 2020 23:24:16 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id j12so973827iow.0;
        Tue, 17 Nov 2020 23:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9L6NN4Y88cdqXYnogJOUHohTB0oLak5C96PuBchfjBE=;
        b=Z5cWs7TUpJZcd66OLuH3u25tDZog1jP/Zkd/uzM7gWW3YZL92jmy8h0JcTfg4HazoA
         nB56lCjmqd4xBrwhEaf1eRMGL/wf9oAj21i75I3MhYVoOIUpW77CTpHMUKaVwAOccoT7
         H9zue40QYn12fuVn4WajW3roYSFaIpipXa5vccbhdK/9hP5m22OXa8EafSIz+TenAoLa
         TUrklrm7WIxzv5th6sivMz7cJAKMzCkId/jHcmYsr8RkbKM+pyTX6v4JukGD67QF53ad
         BeKWAXCSv6AvgJIoEiZMaF94MRRr/Eyc5yH9s4zgOTkhA1PkFp9cGtSTNphUGKfT0y/c
         Hctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9L6NN4Y88cdqXYnogJOUHohTB0oLak5C96PuBchfjBE=;
        b=SfaH7QyhWhPyWS3Hk/IkgELn+y6u4+H8j368Gb2cWqxikroiqr3Q5L3wTb4SNUkpCP
         nibshK1FbvhhgDvlsWA5uZ+tvOdRx4al5ZpMBGTM2HAOdajAx9kKfLacnpa1ofLVlyPI
         3TTbnsfZsN6gU+eJ+LGwT0uLi89JP+BjptazeCIh0wbm6m2nVGTPRTL+H7F1PEnQRtV5
         DRPGenNJkDieDicFavoFZRdFVQMbfinRD45lObbdpwNSQ1aFMIVJqxcQPT8bxv1heOC4
         6bg3aeF8nE0wtwZN8aLmmszbUu49uiKJuhd+mwUtt/jgHYAPf6+kzdt/vti9HLDT1fA8
         BTGA==
X-Gm-Message-State: AOAM5313pf3KmSEJLKxZCpbHgoFEL+OVroOq0Lop2C8DBmlRQKXRFaBN
        qD+PRaZIIb8L16kiTfdy32Va6kTaDGTCsp9jkdI=
X-Google-Smtp-Source: ABdhPJzypJIQ9MnzCzDOgBwua+AHSoF1gfsiCpUMhGWshSXEO3e3+1myN5ycrZ+Kc3RqDoEUGmRDZb80mGJX0cYUD/E=
X-Received: by 2002:a5d:964a:: with SMTP id d10mr10422657ios.5.1605684255769;
 Tue, 17 Nov 2020 23:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com> <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com> <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
 <20201117164600.GC78221@redhat.com> <CAOQ4uxgi-8sn4S3pRr0NQC5sjp9fLmVsfno1nSa2ugfM2KQLLQ@mail.gmail.com>
 <20201117182940.GA91497@redhat.com>
In-Reply-To: <20201117182940.GA91497@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Nov 2020 09:24:04 +0200
Message-ID: <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 8:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Nov 17, 2020 at 08:03:16PM +0200, Amir Goldstein wrote:
> > > > C. "shutdown" the filesystem if writeback errors happened and return
> > > >      EIO from any read, like some blockdev filesystems will do in face
> > > >      of metadata write errors
> > > >
> > > > I happen to have a branch ready for that ;-)
> > > > https://github.com/amir73il/linux/commits/ovl-shutdown
> > >
> > >
> > > This branch seems to implement shutdown ioctl. So it will still need
> > > glue code to detect writeback failure in upper/ and trigger shutdown
> > > internally?
> > >
> >
> > Yes.
> > ovl_get_acess() can check both the administrative ofs->goingdown
> > command and the upper writeback error condition for volatile ovl
> > or something like that.
>
> This approach will not help mmaped() pages though, if I do.
>
> - Store to addr
> - msync
> - Load from addr
>
> There is a chance that I can still read back old data.
>

msync does not go through overlay. It goes directly to upper fs,
so it will sync pages and return error on volatile overlay as well.

Maybe there will still be weird corner cases, but the shutdown approach
should cover most or all of the interesting cases.

Thanks,
Amir.
