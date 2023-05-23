Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171670E19F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjEWQV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEWQV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:21:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBFC2;
        Tue, 23 May 2023 09:21:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso2064253a12.1;
        Tue, 23 May 2023 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684858886; x=1687450886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfNPZTD/p+4V8hQdIpreZULWAY9gpVre83yDlsSvicI=;
        b=NsYE9fByGmrU3JQR+VXrwDIRrFEijF15j6AbdN+V76aaO60pDuHG4yynLj+PYNjvwn
         m0kZj/Lg7h8CeUNwvY8GEUzS76lOofO187YQelRhY4GbPfqEbzlYrVTT1li8PiCHSZbg
         x9mZtePEWwoF4hoIU4zTWKhLGJq+6eF9Ve5ARqvqcXDiLeIIji5jt10aYu1MderrGuhd
         oU41qRrhQRGwwS+fqFk1whdJjc0WIUUz/1MPAanyjSLatcqu2eXDZ+DG5WAcd2ndt/Ps
         5uOIK8K21DcaaeaRUvP/RD/OXuKg96KNlHA80jQnHs3RX5f8fvm1jt1MdCu7s6L98/7o
         4Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858886; x=1687450886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfNPZTD/p+4V8hQdIpreZULWAY9gpVre83yDlsSvicI=;
        b=FDhhXeBc8gsIF0RjVnO1wIOlAA30/wkDY8z9831jRFHIlD+/1gFV4kkofypJI0RsE7
         I64Oe2CTYUTDcTKV6EkEOQ62dHcpfF6WpP1OU6Dj+QTbCDkuz4esaj6iWTU8IXY++6sG
         ZF6hnAOIbatIGYCcwV67j1Q21zDAzQZpGFktcWZPdSIpYSCG8T6Q49RiOO+RUBf8s87J
         Qbp79Y966gYGLD0xrnqiFLpvElJ4jvTwF989ipkrqETN5kth+gy4pd6+xQMYnJikc1mB
         106vuvdlf/oEPrW1oZgF9KPw5Zpmh3ztYkqOLB0mJFfBkx7dGr/BKEwl3fXU9thmJxNF
         +wMA==
X-Gm-Message-State: AC+VfDyI/kxglnJoeDY8NtUEg+sN7VKuBqsgWA4AReOR3sGbl7jk1ame
        PgIxzInP/jtxk2X8LfPEJSS/vjQDsX9nlkaLjIhwodVD9aE=
X-Google-Smtp-Source: ACHHUZ4V74rDmNWdqjXQM2H7VQ2AS/0dzmFJUpdq1WYAxuDS1znGNNM4KKiopcRMTNfc7pU2xFd3pkQ9HXun3aNjazY=
X-Received: by 2002:a05:6402:1d49:b0:50b:2088:3533 with SMTP id
 dz9-20020a0564021d4900b0050b20883533mr21653795edb.1.1684858885759; Tue, 23
 May 2023 09:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230522232917.2454595-1-andrii@kernel.org> <20230522232917.2454595-4-andrii@kernel.org>
 <383289fa-1036-b569-1ebf-5da8ba41c58d@iogearbox.net>
In-Reply-To: <383289fa-1036-b569-1ebf-5da8ba41c58d@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 May 2023 09:21:13 -0700
Message-ID: <CAEf4BzaPugw_1ktiOcmC6aqRrH503VXcvZaaeBpEWxPht9G1Ww@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] libbpf: add opts-based bpf_obj_pin() API
 and add support for path_fd
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, cyphar@cyphar.com,
        brauner@kernel.org, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 7:38=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/23/23 1:29 AM, Andrii Nakryiko wrote:
> [...]
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index a5aa3a383d69..7a4fe80da360 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -389,5 +389,6 @@ LIBBPF_1.2.0 {
> >               bpf_link__update_map;
> >               bpf_link_get_info_by_fd;
> >               bpf_map_get_info_by_fd;
> > +             bpf_obj_pin_opts;
>
> Given 1.2.0 went out [0], shouldn't this go into a new LIBBPF_1.3.0 secti=
on?

yep, you are right, this should have gone into a new 1.3.0 sections.
I'll add "starting v1.3 dev cycle" patch into v4 and resend.

>
> >               bpf_prog_get_info_by_fd;
> >   } LIBBPF_1.1.0;
>
> Thanks,
> Daniel
>
>    [0] https://lore.kernel.org/bpf/CAEf4BzYJhzEDHarRGvidhPd-DRtu4VXxnQ=3D=
HhOG-LZjkbK-MwQ@mail.gmail.com/
>
