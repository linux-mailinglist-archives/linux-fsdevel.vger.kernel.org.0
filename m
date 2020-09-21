Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE1271A87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 07:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUFvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 01:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUFvE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:51:04 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E2720BED;
        Mon, 21 Sep 2020 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600667464;
        bh=fclHvYa4RgGnbMPpcyC+ZgH/EaNxF3N4Y2dz1niw6y8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0MHJLEDXMgY+umChaeHtB0v21lx23ExbcKVVmhB9A8Yp5cw3kxUUZ+b/By35bmlI/
         Bb+RiOgsOkuuC1A911jc4cBfkU39FB7NaaDxXLsGtXe7fWWe8W+7c1zAXXEEiHbzBF
         Iou267PVuAq1NAP/aowZpqoTXX2nWmKPIWA0tUp8=
Received: by mail-ot1-f47.google.com with SMTP id e23so11288447otk.7;
        Sun, 20 Sep 2020 22:51:04 -0700 (PDT)
X-Gm-Message-State: AOAM532BMQZUAWNX9YCRzYEiM2hmxEE6YLF6fUnansNMnp0ycqyDIR4i
        CvSPnapidI+wQVUpl8qMIxovN9hCH1VfwV+dg7s=
X-Google-Smtp-Source: ABdhPJzRJhb/S0DLv+X/uQ8vahV4ZMtWqng9Yb9PMfXDd1tt6udcIsD7C8Ayy8Wo/zqUHofVbkjiPeivanWsXaQ/NJU=
X-Received: by 2002:a05:6830:1083:: with SMTP id y3mr19593085oto.282.1600667463566;
 Sun, 20 Sep 2020 22:51:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:30cf:0:0:0:0:0 with HTTP; Sun, 20 Sep 2020 22:51:03
 -0700 (PDT)
In-Reply-To: <015e01d68bd0$5324fe00$f96efa00$@samsung.com>
References: <CGME20200911044525epcas1p4a050411f3049c625b81c7d6516982537@epcas1p4.samsung.com>
 <20200911044519.13981-1-kohada.t2@gmail.com> <015e01d68bd0$5324fe00$f96efa00$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 20 Sep 2020 22:51:03 -0700
X-Gmail-Original-Message-ID: <CAKYAXd_umX=_nCjVStts7Gv4siHRv_sENGYChUqm6J20hUDhvg@mail.gmail.com>
Message-ID: <CAKYAXd_umX=_nCjVStts7Gv4siHRv_sENGYChUqm6J20hUDhvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] exfat: replace memcpy with structure assignment
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

2020-09-15 19:23 GMT-07:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> Use structure assignment instead of memcpy.
>>
>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks for your patch!
