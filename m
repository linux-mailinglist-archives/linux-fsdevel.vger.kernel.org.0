Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB014A3CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 13:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgA0M0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 07:26:24 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40271 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgA0M0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:26:24 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so4347295qvb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dxtnBJy7TtO0FNdFepHqKbYItxPWi4rmxJBvGTynpb4=;
        b=R/Z2JAzOMlgEEe5LRPotTkZCgaKhVqLH5vuYs7i236aqhbRA8JogpS0hx8OfRD7TSV
         rHpzPOJYIhFVVN5xSbaezZ56PMNZ6tyPauoi3YAmWrcNysQLkte2p6PDP3W1QQh1ygyX
         6G/GhNh9VpH0cgd/u8iPUswlQnA0TlkWDFKG0mH+DqkiTReloJ27oKg4HAU3q+aQ5UWT
         qTdjVhdnlpUGRduwxQeQO8/5EUeorqbl3SGpIIBwWiB75PrdvF3e5jR9wqLXTrBdZjkq
         fq/vH6Va7HxfYv6qSx5Z6/IHy9/g7kQttsjEUhFlUn7Tr06DjN7/mdBXRsDVpJPIS5HX
         xMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dxtnBJy7TtO0FNdFepHqKbYItxPWi4rmxJBvGTynpb4=;
        b=X/YSZnTlx/07mAL4bp9uqmRUzOOW2PL3Dm8KO8lCJlb02Mf8b2blgkfaaEWxYxn54r
         +qJ9Dc1K6YdnBIzdRzab1Ggftw0DZQx2IbvzAGQBT0gRjW4Q98rnyAN1jMyr5/R/ht5x
         2AqmviTiiuYzkMUXtNAmTo7fT5WvRKJcCdh/ZBtmr0XNhsbssjhV55lDOW3TbMag/Ouh
         PfrnVSlI3xVbeSoHAZliRWnnTz0qXMSPcTOHng4MOY77AcKCuUXneLlDtgXRPGd5Jj1w
         sel44T3zxyIiYDoXnSNzhOfLXklZs29Y9XphFVsSvi4+tp6OzUoNtoa2DceJBw5+z1Nb
         pIOQ==
X-Gm-Message-State: APjAAAUBAPtmvOYQUwiwhJbbOgfOsiPuXiC5PeBTyl0TrCtg3pZse2zh
        1KbQ4PEKfTeE9dOI0z0P73huSA==
X-Google-Smtp-Source: APXvYqz/dWEk/aq3G1gMzh/LBHy2U0Gfx5zkulfbrjNAfHknxwhydqbp8IYmYKr8NyTj9BDw1851cQ==
X-Received: by 2002:a0c:aacb:: with SMTP id g11mr16585575qvb.108.1580127983134;
        Mon, 27 Jan 2020 04:26:23 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u13sm8615806qta.30.2020.01.27.04.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 04:26:22 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
Date:   Mon, 27 Jan 2020 07:26:21 -0500
Message-Id: <F352EA1C-7E7C-4C0C-8F23-EC33080EBB9E@lca.pw>
References: <20200127101100.92588-1-ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        ssaner@redhat.com, atomlin@redhat.com, oleksandr@redhat.com,
        vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20200127101100.92588-1-ghalat@redhat.com>
To:     Grzegorz Halat <ghalat@redhat.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 27, 2020, at 5:11 AM, Grzegorz Halat <ghalat@redhat.com> wrote:
>=20
> Memory management subsystem performs various checks at runtime,
> if an inconsistency is detected then such event is being logged and kernel=

> continues to run. While debugging such problems it is helpful to collect
> memory dump as early as possible. Currently, there is no easy way to panic=

> kernel when such error is detected.
>=20
> It was proposed[1] to panic the kernel if panic_on_oops is set but this
> approach was not accepted. One of alternative proposals was introduction o=
f
> a new sysctl.
>=20
> The patch adds panic_on_mm_error sysctl. If the sysctl is set then the
> kernel will be crashed when an inconsistency is detected by memory
> management. This currently means panic when bad page or bad PTE
> is detected(this may be extended to other places in MM).
>=20
> Another use case of this sysctl may be in security-wise environments,
> it may be more desired to crash machine than continue to run with
> potentially damaged data structures.

Well, on the other hand, this will allow a normal user to more easily crash t=
he system due to a recoverable bug which could result in local DoS.=
