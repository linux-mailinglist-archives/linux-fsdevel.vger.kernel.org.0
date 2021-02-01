Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731A230A31B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhBAINT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBAINR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:13:17 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240FC061574
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 00:12:36 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id i3so5627596uai.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 00:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghOqdm7965Gyfaczx/hxpxYfT0qkQ9gCpoLT7+xG74E=;
        b=fkTdqYP24xqMbBr9zQ4dt63z88f/jqNr/xwUM9kB5BVATXqxBSq8ehXlD7ugepoxVs
         wTWOi66SBEXchDNUcIQKspJbcJqCrqg0/k69uYevD6TBKbnH0T2xA+YEAHc9RuCbCI5L
         YYOE9E7eQefltNUzWL9YZ1wTS+VerycfA017c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghOqdm7965Gyfaczx/hxpxYfT0qkQ9gCpoLT7+xG74E=;
        b=SCe4ExdoY13AnFH082apNNf6725neFRyUD0OUuvRfO1j1Z4wuoZljaA37BSvRSCoX/
         uH2MyZUWJjhpoguNsDJbboytcri6D2GwT/HVswuCg8Fl3ayq8pyTxtw8aXgfpWxVNOSj
         f6mP6xcTfUu/GUoT5yDIm73BX02Sszn1d+IKS5l2v+FS0kPjX18USKt6eAypspGPzfJa
         UA5H7J0urEjR79LFOeHcS9HgBBG2C93XcsR1BCCsZ1uw2ykPqRabhxEj7/t0eqT/r9mZ
         sbg3aXD5Hc7osNKQJKysU6B/P7D3VZHkJjDNgx19EWPJX+Wg+YoLHff+HNWXn3QPuxpL
         64Vg==
X-Gm-Message-State: AOAM531XiySwm/GEiKZEP8ZkLPDWjaZZhD55ziScX/kULnGs1LICENVz
        sVt7NdRka+qolOfBTCbdy44zD4lSC/g9I0+S84eQzA==
X-Google-Smtp-Source: ABdhPJyAIHRtcWwRgGn6OmwSQ8c39e4lJpKCtvim4TD3znSJq4dgdezFFZx0jQQd2cgv4aQySL5Hi7BPEse9b5HE2SQ=
X-Received: by 2002:ab0:702a:: with SMTP id u10mr8228537ual.11.1612167156168;
 Mon, 01 Feb 2021 00:12:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1598331148.git.joe@perches.com> <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
In-Reply-To: <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Feb 2021 09:12:25 +0100
Message-ID: <CAJfpegtp9zC5u+D=YJt3Ec-moALCJxkVswmZEFJWb-VXfLXmaA@mail.gmail.com>
Subject: Re: [PATCH 23/29] fuse: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 6:57 AM Joe Perches <joe@perches.com> wrote:
>
> Use semicolons and braces.

Reference to coding style doc?  Or other important reason?  Or just
personal preference?

Thanks,
Miklos
