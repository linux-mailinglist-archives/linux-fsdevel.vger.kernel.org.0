Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDC1E5E40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgE1LaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 07:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbgE1LaO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 07:30:14 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D9520DD4;
        Thu, 28 May 2020 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590665411;
        bh=pOr9+uyZ7rCTYmJJOe4pwixPDEwNeASb3U/bhlhUThM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kGHhyfjM2bEnDdN/ZJFTrRs34AN2BwR3ocVI0f/YJfjzBFs0kFI5Nr2zZb23STLoX
         NsYeCUvgsVRSUwmBKP/RuVYjnXZFPH0xXng7LtW8EzdM5AzUdQqVNlu8Rah3TllquC
         mFhsumIvaJHDK2W/GNXEA7DrP78qOw+Yzfj/AvVY=
Received: by mail-oo1-f53.google.com with SMTP id i9so5660127ool.5;
        Thu, 28 May 2020 04:30:11 -0700 (PDT)
X-Gm-Message-State: AOAM533570BXzlfkZ5bdzUVyzTwfepCwwDZyEE2iNHrNP2AqXHBuLRAJ
        pd8guTvEXC+OUHQjJbk5mB+/gv5GLaoS6yIQqCc=
X-Google-Smtp-Source: ABdhPJzzHRygAQlE1i8jgKNfBfmWbvtbWJHnT336hdl3ZtNahx4ZRgHK5fpBQscEpljweHDkB3RicD2NqtFR65I1WJI=
X-Received: by 2002:a4a:49ce:: with SMTP id z197mr2114178ooa.74.1590665410500;
 Thu, 28 May 2020 04:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Thu, 28 May 2020 04:30:09 -0700 (PDT)
In-Reply-To: <780793fc-029a-28a6-5970-c21ffc91268b@gmail.com>
References: <20200525115052.19243-1-kohada.t2@gmail.com> <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
 <20200525115052.19243-4-kohada.t2@gmail.com> <00d301d6332f$d4a52300$7def6900$@samsung.com>
 <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com> <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
 <ccb66f50-b275-4717-f165-98390520077b@gmail.com> <015401d634ad$4628e4c0$d27aae40$@samsung.com>
 <780793fc-029a-28a6-5970-c21ffc91268b@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 28 May 2020 20:30:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8jLRKaQL_KW1R3r_fK8O2A49FJUm0HRgU9Dc81-sz6Ew@mail.gmail.com>
Message-ID: <CAKYAXd8jLRKaQL_KW1R3r_fK8O2A49FJUm0HRgU9Dc81-sz6Ew@mail.gmail.com>
Subject: Re: [PATCH 4/4] exfat: standardize checksum calculation
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-05-28 19:09 GMT+09:00, Tetsuhiro Kohada <kohada.t2@gmail.com>:
>>> I'll repost the patch, based on the dir-cache patched dev-tree.
>>> If dir-cache patch will merge into dev-tree, should I wait until then?
>> I will apply them after testing at once if you send updated 5 patches
>> again.
>
> I resend patches for boot_sector.
> However, the dir-cache patch hasn't changed, so I haven't reposted it.
Well, I leave a comment for this patch.
>
> BR
>
