Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E68523A29C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHCKPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHCKPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:15:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2417C061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 03:15:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l4so37947822ejd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jkw2/EmVNCjRVxtadc/w9Al3qslsL1S9Hi4Qs74qTxI=;
        b=LOEy3o4VZahFXFtZNHaUDERDe9gXJFDuIURw84jtpCz2oCjzqatjdxi85ruUk216Rv
         v1hJrrxqx8zLrfY9r1ihrTmN4sgTnxd05WcEdMfRaOyKXOp4b1gmudzZ/v+M3UkTRYbw
         aBOfrlcwOIbQ//4dguLte5uNTppdI99KZ26kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jkw2/EmVNCjRVxtadc/w9Al3qslsL1S9Hi4Qs74qTxI=;
        b=m6fY8Lq63yjd5lY0AIb7R+3jTxb4qsOmKG+pvEyb5a+MbvZyWYq1WpsM0oDEITbsl4
         EZhRCiHqNpJrwa38j6gb+N38yGJZ27IS4bBoJ6KoD76h3fOUyMv9rdMDFuY7rLWxQMXt
         QhH4RJEdRuN9UnCLnnHFG5eYiKeHsUGDl0adArF5czwJXJbMNzJInOAOtIAR7aKOFHez
         x2A6ImecYT8yL5YvoVefBU6iWuhwY1ESf5ShFjWQH/ykFYw9rjTb/wZBXsUycds4DkTI
         uhMlLFE7rliTpvGuW5XA3mleh5PhRSS/rGYZshVjXv/WjuHfztRPVh1aZHfVV4b4tj91
         29+A==
X-Gm-Message-State: AOAM530HSvxnae5FRzU/c9Q/4cAbHnKRN8mj6gHVoeecTlIuW1GvntPt
        dYA4xZPL7Fr34k0oKz/LKDkQdqjgbq0BKmKeOjlZqMdt
X-Google-Smtp-Source: ABdhPJxldC6i2ZnyBDDSZP0XTrPLNJsfOi7DQqJ4v7/Qk9xwwbpA48xl/6f5v/lX2ThB5om64KLM7AUyrmnk4DKrzxU=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr15537030ejg.202.1596449716662;
 Mon, 03 Aug 2020 03:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200723164311.29169-1-andrealmeid@collabora.com>
In-Reply-To: <20200723164311.29169-1-andrealmeid@collabora.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 12:15:05 +0200
Message-ID: <CAJfpegtXfEQFhwV4MEOf6zQa3KCPmFzffDgDDMJ5=1n+irV7qA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Update project homepage
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        Nikolaus Rath <nikolaus@rath.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 6:43 PM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> As stated in https://sourceforge.net/projects/fuse/, "the FUSE project ha=
s
> moved to https://github.com/libfuse/" in 22-Dec-2015. Update URLs to
> reflect this.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>

Thanks, applied.

Miklos
