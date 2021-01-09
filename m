Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC22F02FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 20:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAITBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 14:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbhAITBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:01:00 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E298C061786
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Jan 2021 11:00:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u25so10345314lfc.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jan 2021 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6Uz/uNKuxv8kpeBK6zjNMwa2VjYpAJbjFDMrzffj6I=;
        b=B5MuZOKUiCj7xkpKI58UwPgj+2Ygq8bPiwFnSM6GgJ3giVH0HlyrHQVOus3hpeAH+e
         ihkFNtQrr7VFzpBW/oNSs7g/4YiRSUG5HnzO4DWt6vSIVmtECXfeVEUA3WxEVCPzhO83
         q5CbQWf/kWSe6EhP4nvdYTWFSoqBeuXlzrhSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6Uz/uNKuxv8kpeBK6zjNMwa2VjYpAJbjFDMrzffj6I=;
        b=jCrVxMgZqci+DIBKj2ag+OOsYigcvG3fCfPiUc5g1xH2lH3bqsxpCiOwwKb3cgQ2Fn
         KsaHmLd0Pvawj9ba8rUVY8C7WllRYNtNdwS13SgH/3GYL0VdEyZqs1qIqa2kLKln4KCV
         /6fpw7mGVMUC6EBlZJH0nJMnaYJ8SKki2FJGSHsaeQrKGQ95ESLuqsudikuCHKsXAaDC
         9raDncg5V83CU3QSZ/gtgEIT9pX1O8IcY8p4wS4i9ofUkopYQvHTm6Ak3FTBh9wdfDCz
         yZS20vTQwbT87p0namjR+0Cmoo4YoE2/iLVkb6EH9nvZiVGGYLNfUv+fIMt5nLHfvRvG
         KMuw==
X-Gm-Message-State: AOAM530BWwPPdIXFWf0Pi0c2GX0edVaDZ6iv6tn0Vru2nDVY7tJ8AV0N
        rEwPxSLWdqW83feE/DNNkVYu0LyhvdCQ2g==
X-Google-Smtp-Source: ABdhPJzuPptTW54p7mVKWbkuM1NSndy6mvXEYOnbn6ewnetkdQ2v7dUl9Bs7FWrc+i1x2WwZ2sT6bw==
X-Received: by 2002:a2e:50c:: with SMTP id 12mr3956715ljf.226.1610218818319;
        Sat, 09 Jan 2021 11:00:18 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c24sm2697281ljn.116.2021.01.09.11.00.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 11:00:17 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v67so2870296lfa.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jan 2021 11:00:17 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr3759713lfg.40.1610218817016;
 Sat, 09 Jan 2021 11:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20210109064602.GU6918@magnolia>
In-Reply-To: <20210109064602.GU6918@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 11:00:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibYWuriC4m-zjU10J65peMDAFTjY2EGjTV=COgg1saPw@mail.gmail.com>
Message-ID: <CAHk-=wibYWuriC4m-zjU10J65peMDAFTjY2EGjTV=COgg1saPw@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update my email address
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:46 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Change my email contact ahead of a likely painful eleven-month migration
> to a certain cobalt enteprisey groupware cloud product that will totally
> break my workflow.  Some day I may get used to having to email being
> sequestered behind both claret and cerulean oath2+sms 2fa layers, but
> for now I'll stick with keying in one password to receive an email vs.
> the required four.

So I appreciate this email coming from your old email address, but I
also just want to note that as long as you then use the oracle email
address for sending email, commit authorship, and "Signed-off-by:" (or
Acked-by etc) addresses, those tend to be the ones that _primarily_
get used when people then CC you on issues.

Well, at least that's how I work. The MAINTAINERS file tends to be the
secondary one.

But I wish you best of luck with the new email setup ;)

            Linus
