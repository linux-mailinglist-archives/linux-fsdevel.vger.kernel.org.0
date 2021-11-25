Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC07745DCA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355938AbhKYOvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 09:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbhKYOtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:49:06 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35525C06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 06:45:55 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id w23so12786401uao.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtbCZM95cRfzM9aIhXBEhEk5A8jIBT2rwACHIginNKY=;
        b=EVvcs3MITFAwnudiT6UELc0/nNTrSpSghYDRSz7bPTNkJmfVvEysWN205k1mT8ZATV
         9dfqTYPGwVoq+jPXUK8p7lrMjKDNJrB7EPGceWnReRmTugzp1NrbZ04bQMyCSoCxOJzL
         9wMSDoX8Vu2OVgDTERvxtxz1/5jQJEJYX5cLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtbCZM95cRfzM9aIhXBEhEk5A8jIBT2rwACHIginNKY=;
        b=UjUCuO32hDyuKjjL2KxsF8vA3XgQZ/8Vr6lxJ7oNW2jm37l3gC5Bi6RD6V9CR43yRe
         s/XQZ31B46t3RUVU2Z1tsk+9ncbsctcEQRBzrQakkZ13cegJqsjwiyEUc2+dfFtn8ufJ
         SEBVi7QZ6CrpFZSAwT4Nor/Qksql7/uf4Dhi8/99m0bVq1G8hcgNbgl0JkTeptjNmZPx
         uvEdlGo3YNKKLAOnAZR196vwSyjTgod4Fzp5yqwCii2y6m1bKLoI8BMm2LyXYWfPloEq
         RlYHbAZJO4rgbEUx7finMyGUIahJ0RJdN6bxh2IUGuS4FTkwLHFi/C7rMHbRf38onDfo
         xaYg==
X-Gm-Message-State: AOAM531QBNdooEhNbd4BqvRZaF6nJ2veqFh8eUslUZAPHbk7Rvsleb9s
        1SAI8kgv6t842e9hc0PY7Ui4bWA8FLzlqTGc3RG4Jg==
X-Google-Smtp-Source: ABdhPJzsKp26qJGleQ9bj5NtBPIH4TdxPWgzVihb78G4ztFNLkCa0S2G/7avPfnXaOOnRjdaLws3v0hcEtwm4dSsT1Q=
X-Received: by 2002:a05:6102:945:: with SMTP id a5mr9771107vsi.87.1637851554336;
 Thu, 25 Nov 2021 06:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20211123181010.1607630-1-shr@fb.com> <20211123181010.1607630-2-shr@fb.com>
In-Reply-To: <20211123181010.1607630-2-shr@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 25 Nov 2021 15:45:43 +0100
Message-ID: <CAJfpegsusDTYwRm5ig-EnvG0c5vqCRozuj34YcbTAD1kqi02Cg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fs: add parameter use_fpos to iterate_dir function
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Nov 2021 at 19:10, Stefan Roesch <shr@fb.com> wrote:
>
> This adds the use_fpos parameter to the iterate_dir function.
> If use_fpos is true it uses the file position in the file
> structure (existing behavior). If use_fpos is false, it uses
> the pos in the context structure.

Is there a reason not to introduce a iterate_dir_no_fpos() variant and
call this from iterate_dir() with the necessary fpos update?

Thanks,
Miklos
