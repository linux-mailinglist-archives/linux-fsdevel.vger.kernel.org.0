Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F41FF69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfD3SIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:08:39 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42407 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:08:39 -0400
Received: by mail-yw1-f67.google.com with SMTP id y131so6593974ywa.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xil5v019vbM3B6LNJ5oLx5ybK/sELLOgqiNDryj/WS4=;
        b=J6jpwCXSoU7Eq7a4v/BuGEqdgrF69IaBpqOL12T9GDVAPMr4fSnfDWEJUjRPxcE/aa
         fNigHE4KOEqlZyENgRu+3RjUamg6DPnkPsUqo+KyKPP54eT63vbbvE3+J28zY2d6CAuk
         qfCM428MXxMWIy/qHQJK5PMe+FU2XDaiA2WYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xil5v019vbM3B6LNJ5oLx5ybK/sELLOgqiNDryj/WS4=;
        b=Yy7qejDCyBZBa0zSu3fhkzBs5YYz0K3PvJPtagfzWzVsbnffgQMQCg+XSl5nUNHuQx
         izho+/ubohlOovi4IuUM/147yj212nUBqubTDLwCdS5hCz2Juf36r3n0eL10xz0Uc8r2
         MN1I9Hlqmuomlg8pOqGi5BQY7vi1QvShEZEN0EtgYlNFeZdRrNWdqkQm5raR8ajOs/92
         iM2m6ggV8jFV9GIVho7Ot2MYfzt2K7eA6+PFA18GmEKmRCaj+F1cCxZNOgwaxSuYCzLc
         TDitpEo/X8TNcPImI0bRB938r4jj1jMUyOAAr4AJbaXKESlsv8OYzpN570KV/1rhgVPH
         kVBw==
X-Gm-Message-State: APjAAAVJI45YoCa/N3B5qXd1IFC65/YrBYcacX7W1529c4FcgSRK13Xv
        NPj+Xu30ugLmCWfmiEfjWi36caT8iCA=
X-Google-Smtp-Source: APXvYqyn6MGcaYvhS3wtO/2eoISeFnIi35hOCnjsnFhOll7neMm0DcMcnIq1M9cP5/Vn7TpAhEUIXQ==
X-Received: by 2002:a25:1102:: with SMTP id 2mr55297615ybr.456.1556647717878;
        Tue, 30 Apr 2019 11:08:37 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id a11sm10772898ywh.49.2019.04.30.11.08.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:08:37 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id u14so6608336ywe.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:08:36 -0700 (PDT)
X-Received: by 2002:a25:d488:: with SMTP id m130mr15451236ybf.172.1556647716425;
 Tue, 30 Apr 2019 11:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
 <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com>
 <20190430160813.GI13796@bombadil.infradead.org> <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
In-Reply-To: <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 11:08:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLvwT4qQSP5GH=MdNoW4XtEQRbeyA_=MrEAHhgBSXfJTQ@mail.gmail.com>
Message-ID: <CAGXu5jLvwT4qQSP5GH=MdNoW4XtEQRbeyA_=MrEAHhgBSXfJTQ@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 9:30 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Tue, Apr 30, 2019 at 6:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 30, 2019 at 08:42:42AM -0700, Kees Cook wrote:
> > > On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > > On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > > >
> > > > > Add a const int array containing the most commonly used values,
> > > > > some macros to refer more easily to the correct array member,
> > > > > and use them instead of creating a local one for every object file.
> > > > >
> > > >
> > > > Ok it seems that this simply can't be done, because there are at least
> > > > two points where extra1,2 are set to a non const struct:
> > > > in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> > > > while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> > > > and a struct net.
> > >
> > > Why can't these be converted to const also? I don't see the pointer
> > > changing anywhere. They're created in one place and never changed.
> >
> > That's not true; I thought the same thing, but you need to see how
> > they're used in the functions they're called.
> >
> > proc_do_defense_mode(struct ctl_table *table, int write,
> >         struct netns_ipvs *ipvs = table->extra2;
> >                         update_defense_level(ipvs);
> > static void update_defense_level(struct netns_ipvs *ipvs)
> >         spin_lock(&ipvs->dropentry_lock);
>
> Indeed. I followed the same code path until I found this:
>
>  167                        ipvs->drop_rate = 0;
>  168                        ipvs->sysctl_drop_packet = 1;
>
> so I think that this can't be done like this.

Ah, dang. Yeah, I missed that too.

> Mind if I send a v5 without the const qualifier? At least to know the
> kbuildbot opinion.

Yeah, I think that's likely best.

-- 
Kees Cook
