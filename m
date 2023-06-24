Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF173C770
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFXHmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 03:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFXHmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:42:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD361B4;
        Sat, 24 Jun 2023 00:42:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98934f000a5so159606366b.2;
        Sat, 24 Jun 2023 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687592519; x=1690184519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hshr1nAbTK3u2Rf8SnF1Xsc6OdY+iTwTZxi1c7mA5Ag=;
        b=aFK1oIFgZVaztki+GBCvsMYTA0dg1NTjF8ZuP918yn1Dkp1CuYF1bCJrPykQ2XN/5b
         SgJAJvaHig9mIGiAY7sOdjw5OKBEjWB26ioWtgkcf45z/gYMDReHgFKRhlyQWNvHFLhl
         sqi00tyjMjMA85trXDBmDv0J2+BA79Ao939GVftKhPDO1Ef1WDHjFxVbHU22haeO8eHn
         Kf14dtfrwyQN3xizOeGOEGtJQwvFwDbe+1OEUgyIsP/1l5yuYFeXB9Xe35Ece9M+RzSv
         7gkWrYu8oV0IuYYdsT/rwn9P2QPNr8sY2GfSNBZ+UCWiSRT5PaFPUNH6cfEqQBBeM7d5
         np9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687592519; x=1690184519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hshr1nAbTK3u2Rf8SnF1Xsc6OdY+iTwTZxi1c7mA5Ag=;
        b=g0O3fyxg8WgQvG9TnYFspRihuDIO2i9YtFL6JUE4LYAHrdHZQwYnvbQl8Vydtvcrv8
         llxuGC6Qb/QW+srMX4Lb0+m3YtTn/FVlWCSTi20ut9RFj6B3BOXZvqphyGu46iv4LRmU
         oChuw3kGf1JEAqP9ChNRv4O38bI0rUX258ba2cHuKoxQL/zvaG/+ACuP8Y2ciKlsjdzy
         LYxNJFBwLiUJC6j/TSPnlzZd3g3sAVIuBGGfiHl26TYVSNzPvU2fzYBpAM0o6bYopF1k
         Lpik2WEfT2o7PZiCDBMN171RTGzd3XUoADHJmwVKzB4m6M6/Z8RQdasXRvA1hBog8g+t
         adAw==
X-Gm-Message-State: AC+VfDz+PAt3Tv4INN1fXPqDCTk+q9TjlVr3k8LmphVDs7wsN6e61MTm
        Ar6jUitpI/hK3i1VDIbgwW5ANEwKmcDBD+Ew4iB9Ms9Xcg4=
X-Google-Smtp-Source: ACHHUZ53asmphlHElWWImvWV36dCalE0St4hHOiGtkrrUXmXBAUlfp+OK8mrhnvz2q9B4VxnSdSL9p8Rnv4svaw5+Y8=
X-Received: by 2002:a17:906:9b88:b0:988:8fed:8ae9 with SMTP id
 dd8-20020a1709069b8800b009888fed8ae9mr15358304ejc.37.1687592519314; Sat, 24
 Jun 2023 00:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230605165418.2909336-1-willy@infradead.org> <4ca56a21-c5aa-6407-0cc1-db68762630ce@redhat.com>
 <ZH94oBBFct9b9g3z@casper.infradead.org> <7d5d87ac-bd4d-60c2-ca26-70a52c7fbdc8@redhat.com>
 <ZJEgN2J5zLqsuehk@casper.infradead.org>
In-Reply-To: <ZJEgN2J5zLqsuehk@casper.infradead.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 24 Jun 2023 09:41:47 +0200
Message-ID: <CAOi1vP8sLbtM2R07Hu-G-+uQxN5pCZEEwF-qa2foeMb6exwAYQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: Convert ceph_writepages_start() to use folios a
 little more
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 5:42=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jun 07, 2023 at 08:31:46AM +0800, Xiubo Li wrote:
> >
> > On 6/7/23 02:19, Matthew Wilcox wrote:
> > > On Tue, Jun 06, 2023 at 01:37:46PM +0800, Xiubo Li wrote:
> > > > This Looks good to me.
> > > >
> > > > BTW, could you rebase this to the 'testing' branch ? This will intr=
oduce a
> > > Umm, which testing branch is that?  It applies cleanly to next-202306=
06
> > > which is generally where I work, since it's a bit unreasonable for me
> > > to keep track of every filesystem development tree.
> >
> > Here https://github.com/ceph/ceph-client/commits/testing.
>
> Are the fscrypt patches planned for 6.5?  Because they really should
> have been in -next a few weeks ago if they are.

Hi Matthew,

No, they are currently targeted for 6.6.

Thanks,

                Ilya
