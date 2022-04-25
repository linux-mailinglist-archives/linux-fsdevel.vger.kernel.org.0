Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AE50E268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiDYN4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiDYN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:56:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477F6472B
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:52:55 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z19so11270558iof.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qelDa8vHGzUXR/z/LXOyg/fUpae4yTXkY4tJDrA/hXE=;
        b=76/Cqj2bL97JJrVz/LFe2xu4mIreDAgh+6lrOtd0LvmA+X0Tpul7jQ1Vh/EBPcEYkw
         QV5i60hujKAaXiSsT+crrIy0VmTEp/Efp9ifFj0OJndkRXgZW8n6+mtMu3JRet0yGiln
         QKNVQxFDDpJGY3FHwZJWOwTjUck6bMjOSh0T0rJ1mrALx8x7wObgm3g5f9v7ShEgmrhO
         c++pjOzjbdggHSwqPnFc2oCWptWcLuhukGAWV8Eb+/NiZx4Cvji0NLvSpkvUwdPuDhyR
         GgszofIP7lO/YygwmNS7nXvN9jMe1HoH1gslhGdOBjfQVvpUIBglpU7SpJiKWACfZPYQ
         /QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qelDa8vHGzUXR/z/LXOyg/fUpae4yTXkY4tJDrA/hXE=;
        b=unDLkYZBsLAP2rm9oIY7mr94SaY93YFiEn+v8wPOm0gDnwNKqaaia7yeDBTi5BPLDN
         t1+xwe1NcYjeCEoJUCiE0cBNjpwzVQsYJe3tkNcSajsaX4ktS6vhQWROjkKrpQo8W6cf
         QgzCu+3UxYbQgIbUj9LjZ7RzZkhtRKQZ5wWPJ5+h6JpvGzWmsTrtERDhr/JKQ8qNObeR
         O/BoAszbwVqDGWK8LnZZKf/r/jpXpQX78Za8IbK3bMnT0hWPC/dUDnx1VtgdY490NKup
         f2Q0bH2BCJi+lgQPluVeoxpTyIPbFj6A+lZwj+lXtvFhBohFiFxMlsJIWwc5G2mxtl3Q
         KDOA==
X-Gm-Message-State: AOAM5335jb+0u1OnVlRUfW0jYzgX6qs4HCRIUZHXkxoHfQByATKxRjfH
        bsfkb8fZGK5L21y4vdoo6kEXgTgLp0ctDl9dosLTzA==
X-Google-Smtp-Source: ABdhPJxzc1v0Z/He5ukiS1OuqhumsEkKEUAUkOj/D09LTyLPzsEHhIEe4srXorEszGfwGSE5ZqGrdJMQDIyz+M2soNg=
X-Received: by 2002:a05:6638:a48:b0:32a:d97f:659b with SMTP id
 8-20020a0566380a4800b0032ad97f659bmr3943645jap.320.1650894774977; Mon, 25 Apr
 2022 06:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
 <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com> <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
In-Reply-To: <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Mon, 25 Apr 2022 21:52:44 +0800
Message-ID: <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com>
Subject: Re: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:42 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 25 Apr 2022 at 15:33, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
> >
> > On Mon, Apr 25, 2022 at 8:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Fri, 25 Mar 2022 at 14:23, Jiachen Zhang
> > > <zhangjiachen.jaycee@bytedance.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This RFC patch implements attr cache and data cache revalidation for
> > > > fuse writeback_cache mode in kernel. Looking forward to any suggestions
> > > > or comments on this feature.
> > >
> > > Quick question before going into the details:  could the cache
> > > revalidation be done in the userspace filesystem instead, which would
> > > set/clear FOPEN_KEEP_CACHE based on the result of the revalidation?
> > >
> > > Thanks,
> > > Miklos
> >
> > Hi, Miklos,
> >
> > Thanks for replying. Yes, I believe we can also perform the
> > revalidation in userspace, and we can invalidate the data cache with
> > FOPEN_KEEP_CACHE cleared. But for now, there is no way we can
> > invalidate attr cache (c/mtime and size)  in writeback mode.
>
> Can you please describe the use case for invalidating the attr cache?
>

Some users may want both the high performance of writeback mode and a
little bit more consistency among FUSE mounts. In the current
writeback mode implementation, users of one FUSE mount can never see
the file expansion done by other FUSE mounts.

Thanks,
Jiachen
