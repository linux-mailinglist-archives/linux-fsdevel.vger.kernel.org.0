Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90A310461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBEFNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:13:06 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD16C0613D6;
        Thu,  4 Feb 2021 21:12:25 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w8so6337800oie.2;
        Thu, 04 Feb 2021 21:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRSiskrBf8JBQe+dpQo/Fj356lQt7La0h1yY+DNyfyQ=;
        b=Rw9qUfBfKJeotJlreMDZJ/OVV6xYnLXnqqJXYYcPT7JcTPCgD77gkt2tTE/XGff6wW
         X394EaWKTljlCWJXDNtEkYHh2vJtrMHJt+uIt4mtYnVJICiDPLlpIJgJwtZjrbWjQVOA
         yE+8IWRfpZ4FNXgpOzuQbV5rnfAeV1cbN9j5+VKqJVLzF7ZfZh22jlAHWJ0LCwWXeAyV
         wlsXU1UE0jw7ZRETpeM7Bmj+hYFNDG0eRQsVuE30EBEIzSL2o2Kj0HYLyIEllpSXjSmo
         TsJ/W15B8ZJfKm1xejp0FqmgEyrtCM1iNBBuXhyUw6zf5uSNjziXwhI4aitoZaLpV/Xw
         B3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRSiskrBf8JBQe+dpQo/Fj356lQt7La0h1yY+DNyfyQ=;
        b=fyg3+tjv0Hj93XAGOnsd40JopUUhwgyEaHYkgNYWvDUh7/Ic5Evz54JkWYzZ/Ih4NV
         +85ATM619pl00im8Ad+IJht/d6LRBomLtuzD6l7cK4P7Cn9nDJnlxc1kTFGqCDPln2Uq
         4GawG0BDY+Hqw3GGQ+hGbR1niSTy3QnWvXPOaG7QycZFzx1p3vl31XA2MR4xx6EaTicO
         HMbb9YCo6Nh8sUW6i57RdxLDJtyNcf9vPvtyeK+e+SP982t101OhcYhyB6n0Z/4Z25Pw
         xvFgJQrfyTrWoePhbw5cMQKzfHzU6vUYWyB8UDqbM4ZdBFJI8H5vjPrBhMEL4xAZn+jb
         hHXQ==
X-Gm-Message-State: AOAM531OS5gvosyj8HWXN/ZbCd1pY2cwMUbypUyyxK3w3/D8Zst9kpd3
        ZNBaTJnQ3EABu/8wbu/oM8v1eWDIN3axo5y0oL82MjpuvW0=
X-Google-Smtp-Source: ABdhPJzmVNpj19PNZz3IXzqGVmtIE/aQTHZ+lE5MChZ5fNEHzxIs2bpWJz0zzgbNggHkAd5vzP336dQMKngRu+aUe90=
X-Received: by 2002:a54:458f:: with SMTP id z15mr2072410oib.139.1612501945238;
 Thu, 04 Feb 2021 21:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20210205045217.552927-1-enbyamy@gmail.com> <20210205045217.552927-2-enbyamy@gmail.com>
 <DM6PR04MB4972E287DED6DA5D4435986286B29@DM6PR04MB4972.namprd04.prod.outlook.com>
 <CAE1WUT7BHwyL600Zx_3JrG4CGUgCTdufr8Hyy0ObYALqHO_OoQ@mail.gmail.com> <DM6PR04MB49723F2FCDD6E7D11489CD0186B29@DM6PR04MB4972.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB49723F2FCDD6E7D11489CD0186B29@DM6PR04MB4972.namprd04.prod.outlook.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Thu, 4 Feb 2021 21:12:14 -0800
Message-ID: <CAE1WUT4cFXq3VMPKVt7LZ+fPeZDKQCdCN5EFG+cwNm0WhweVRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs/efs: Use correct brace styling for statements
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 9:09 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 2/4/21 21:01, Amy Parker wrote:
> >> Commit message is too long. Follow the style present in the tree.
> > Are you referring to the per-line length? That was supposed to have
> > been broken up, my apologies. Or is it the overall length that is the
> > issue?
> >
> >    -Amy IP
> >
> Per line length. I think it should be < 73.

Alright. Working on it, expect the v2 patchset soon - sorry about that!

   -Amy IP
