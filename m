Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8217E29B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCIOg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:36:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45014 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCIOg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:36:58 -0400
Received: by mail-io1-f66.google.com with SMTP id t26so1577375ios.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=51InxWWK77yS5DHpUHA7Fenj4mp1m4T9V+UnkAOMMZ0=;
        b=TLR3iyeVnSbM6bO3JpXDa5vsrJxMy0mMRwc8CL4J+V2F7yF4jQCDNGLDId5PhvQ0Zg
         Y3zKHJP58aR7NNkaAq59H9FJMS/60a3KttxsLMwWi5tGLWqSJ58K2v+5sJ6NpsV30KrV
         o7LF7+zwxo3xmDbkiVK2Cw4HtCz+/ceuWqVv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=51InxWWK77yS5DHpUHA7Fenj4mp1m4T9V+UnkAOMMZ0=;
        b=lE9kaq6gMABibvXQng0LUql32gY70NgbSEAwRN0rYiAyRFe3ymvnkC0T9M7FO3b2iz
         FqJuKyrUYyFDEpA80hYVwpyoe0TGdHLiIqm0b/hMwPW46WVPKGdcRegiWBIHP3Udlv1A
         /CRSdEG4ibrBQ1eiY+GtJFe1Wiv+2mt7WtNJ7a9EdOjkgrIMxF7eczEolR7iOa6mYTcy
         zlqVcUxNRqo4A5WR2ar1uVMZnVFW8YacZ1Zrt25n3ppGUoN68ONXAi10BttSgqx9SmxF
         UKPkHygBk8eOiVwt4flO9L8XqBLattoLuwOJAMb2CmSvDvtK+7hVLkfrdn1UYibIe2n1
         Hv4w==
X-Gm-Message-State: ANhLgQ3kwxca1ShGPCiA2r4sdDwwEi5X+4JsqDnF29KUexVLu7v7V58l
        D7EBAzw36fS9Vjo0sL4zAwUNVeYrcp0/sUnKjJ/zlQ==
X-Google-Smtp-Source: ADFU+vuUwyKjXTL/6WA5OX+bDXb1PydHUkWzDUGosTSn49xcylKL0bn5XvkQ1bMsSoOk2LCMLrMqVd4gBdKs0VRb3jk=
X-Received: by 2002:a6b:5905:: with SMTP id n5mr2907560iob.59.1583764618197;
 Mon, 09 Mar 2020 07:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
 <20200303130421.GA5186@mtj.thefacebook.com> <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
 <20200303141311.GA189690@mtj.thefacebook.com> <CANnVG6=9mYACk5tR2xD08r_sGWEeZ0rHZAmJ90U-8h3+iSMvbA@mail.gmail.com>
 <20200303142512.GC189690@mtj.thefacebook.com> <CANnVG6=yf82CcwmdmawmjTP2CskD-WhcvkLnkZs7hs0OG7KcTg@mail.gmail.com>
 <CANnVG6n=_PhhpgLo2ByGeJrrAaNOLond3GQJhobge7Ob2hfJrQ@mail.gmail.com>
In-Reply-To: <CANnVG6n=_PhhpgLo2ByGeJrrAaNOLond3GQJhobge7Ob2hfJrQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Mar 2020 15:36:47 +0100
Message-ID: <CAJfpegsWwsmzWb6C61NXKh=TEGsc=TaSSEAsixbBvw_qF4R6YQ@mail.gmail.com>
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     Tejun Heo <tj@kernel.org>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:32 PM Michael Stapelberg
<michael+lkml@stapelberg.ch> wrote:
>
> Here=E2=80=99s one more thing I noticed: when polling
> /sys/kernel/debug/bdi/0:93/stats, I see that BdiDirtied and BdiWritten
> remain at their original values while the kernel sends FUSE read
> requests, and only goes up when the kernel transitions into sending
> FUSE write requests. Notably, the page dirtying throttling happens in
> the read phase, which is most likely why the write bandwidth is
> (correctly) measured as 0.
>
> Do we have any ideas on why the kernel sends FUSE reads at all?

Memory writes (stores) need the memory page to be up-to-date wrt. the
backing file before proceeding.   This means that if the page hasn't
yet been cached by the kernel, it needs to be read first.

Thanks,
Miklos
