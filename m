Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41F1C9FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgEHArt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 20:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEHArs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 20:47:48 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392C4208DB;
        Fri,  8 May 2020 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588898868;
        bh=o+XMYnph7WnUvtJzgSjnkfel0bcIVqkZCQcAyXf7X8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MRyKEnLCgDOEJAbR2QHtq5uH5cC3ds7OS0vSSpGdIWKUrlY5Up1fCDhounYXrbKZM
         tSbeRvZdsK8RK8bdNji3Tcot8wOcPydqqeK+1Q7BQ9K35Ms/Q6wK9XilKGISQYwXuI
         6nrfNCi2g5rpI2hbjM63pxfYtU39Po7ggeLiUH5Y=
Received: by mail-lj1-f180.google.com with SMTP id u15so8386393ljd.3;
        Thu, 07 May 2020 17:47:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuZXPFNKqvbf4TQQAVzxBuKMTWvVbxxGL9O8I5rPeoFERwBA/IK9
        X5m6mxmNs1ZCTxPqxPjUNgebaq6SMuTehMwcj/w=
X-Google-Smtp-Source: APiQypKWc38MeNE3gf0ZtBnSHyBQT4+vbhnwvgfpeWBVwKm33L2xKJsqjFGnv2W4jRlbv5ZUQNg7CbdahZ2nkror/Fw=
X-Received: by 2002:a2e:a552:: with SMTP id e18mr10194682ljn.113.1588898866412;
 Thu, 07 May 2020 17:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com> <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 May 2020 17:47:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Z9MfS_yFbPaC7Mc8+rMkL3e_m5N_P=6bq28TLXYQpuw@mail.gmail.com>
Message-ID: <CAPhsuW5Z9MfS_yFbPaC7Mc8+rMkL3e_m5N_P=6bq28TLXYQpuw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 02/10] md: remove __clear_page_buffers and use attach/detach_page_private
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, david@fromorbit.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 7, 2020 at 2:44 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> After introduce attach/detach_page_private in pagemap.h, we can remove
> the duplicat code and call the new functions.
>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Acked-by: Song Liu <song@kernel.org>
