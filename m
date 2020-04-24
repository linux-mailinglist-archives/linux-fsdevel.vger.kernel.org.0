Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51BC1B7E30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgDXSrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXSrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:47:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52159C09B048
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w145so8569090lff.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xGKLkYDrbkxXaPDoAGMclBp7ffRJ6EszDQ3T54v3nc=;
        b=MwEjKDGJj1MODwKnNzA+vLKGg1thtRHT3e3U4LHSFK+h9wYouw58019uyy6/KEmGky
         24VnGgQr1b7rgt9D8CYnPjqHNk/6kz2e+VairFXVurg4X02ZtnTJl3DNdjL89KBLASEH
         jDDJT1LRGx4BfhkYMobF+P34B+Sx/MgLFiZjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xGKLkYDrbkxXaPDoAGMclBp7ffRJ6EszDQ3T54v3nc=;
        b=qCHf/7+1Feh89FTi6YoRC0TOA73Sj9I21D7G5RFTMvp071CbP9T4ThbKpYQRTjpSjZ
         sBoQY/Q0ETp3KnMN6QnBEi9OwDLoL3V0OvzELWZm39ZOl4vwLwKhjOrpLX/OiM8NlcnO
         A+yS8rIy8G9+4YOYrYB56dN8phuzOPKYQITBIMCCFkk93woOlfA+N0z1sq5tvN7D/OLG
         8Rfb6r9jzIoZHaqNZdptXaKwg2upLP3IfRp2XLDyrGrRZzqeGTpEaO2+nvnrgY5RlRMh
         7G+f0IziwTbUdAIZVUsv4QWrPYnpkXdLiY5s/pRXTRakGD7r4OqkmIvCwH2jtlqmuQvS
         QUJg==
X-Gm-Message-State: AGi0PubLqXLCYcTuwy+dLPCzeAenZ5TwNughUZ7tkDBWiFqOWmT03Y/+
        UPcyLB+w1cXbDN9rUUbWJh60KsvEXzk=
X-Google-Smtp-Source: APiQypIV8KuoUFwhZhQHzq9rJ+d1eUEXcpeiTzg4jQSZm+OatJR4ie3ZymMDlXxvAXoypeauwr2QAQ==
X-Received: by 2002:a19:f206:: with SMTP id q6mr7395002lfh.85.1587754028302;
        Fri, 24 Apr 2020 11:47:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l18sm4735494lje.19.2020.04.24.11.47.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f18so11004967lja.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr4968653ljj.265.1587754027148;
 Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
 <87tv19tv65.fsf@x220.int.ebiederm.org> <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
In-Reply-To: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 11:46:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9RQ4rc-TmiP0-rdGPGje2uAX5aWh+=pFhfVdKq=u+aA@mail.gmail.com>
Message-ID: <CAHk-=wg9RQ4rc-TmiP0-rdGPGje2uAX5aWh+=pFhfVdKq=u+aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 11:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  [..] even a "double cmpxchg" is
> actually just a double-_sized_ one, not a two different locations
> one

Historical accuracy side note: the 68020 actually had a CAS2 that was
"two different locations".

Maybe somebody else did too.

            Linus
