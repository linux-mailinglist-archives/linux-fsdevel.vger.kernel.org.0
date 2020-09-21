Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0F271A85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 07:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIUFtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 01:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUFtt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:49:49 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1091207DE;
        Mon, 21 Sep 2020 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600667389;
        bh=qBSHYO9pDJszEKBlL6Pv/Rf9R9wIlasteug3iXxVxyg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Kq781Xb15xsKlD4kl+1Xr6h6y6cOE2B4lNbfCeqHF8rTL4Jpx5tbWgaqz0E5iP9Qt
         r4ujCnn1BgI1mJyuq5XM3b7WPSjEBxsZAC9HvkHZFcVRYLMTg5F0dKlDEvMmUHDfUG
         T+6WtbQpS073giVrSRLdBqiSIH3IbhLXSU7ubEgs=
Received: by mail-oi1-f173.google.com with SMTP id i17so15634436oig.10;
        Sun, 20 Sep 2020 22:49:48 -0700 (PDT)
X-Gm-Message-State: AOAM531JZ3QQE+lxjo0ysduXWZd2F5xRiNUFRf/sYiioGSJcj2BJQycy
        drf8hzMJZmoCohPpyCVRZgVBmc3SfoQtWT+YlTc=
X-Google-Smtp-Source: ABdhPJxvweHKFZtKANXKvwJXFk79HdzjJPeNotIAmKK952CYdST2RBMZ4XjBX9FlatvQ/3Uq+8+bCry1CJpgSo8LRA8=
X-Received: by 2002:aca:da8b:: with SMTP id r133mr16599116oig.163.1600667388152;
 Sun, 20 Sep 2020 22:49:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:30cf:0:0:0:0:0 with HTTP; Sun, 20 Sep 2020 22:49:47
 -0700 (PDT)
In-Reply-To: <015d01d68bd0$2fc6bb60$8f543220$@samsung.com>
References: <CGME20200911044449epcas1p42ecc35423eebc3b62428b14529d6a592@epcas1p4.samsung.com>
 <20200911044439.13842-1-kohada.t2@gmail.com> <015d01d68bd0$2fc6bb60$8f543220$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 20 Sep 2020 22:49:47 -0700
X-Gmail-Original-Message-ID: <CAKYAXd-+3wox_1R2kdPQ1sGfC+9nvkdz+64uwgs_x4oEr-BexA@mail.gmail.com>
Message-ID: <CAKYAXd-+3wox_1R2kdPQ1sGfC+9nvkdz+64uwgs_x4oEr-BexA@mail.gmail.com>
Subject: Re: [PATCH 1/3] exfat: remove useless directory scan in exfat_add_entry()
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-09-15 19:22 GMT-07:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> There is nothing in directory just created, so there is no need to scan.
>>
>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks for your patch!
