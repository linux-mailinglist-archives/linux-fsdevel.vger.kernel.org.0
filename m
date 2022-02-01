Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE14A64E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiBATWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbiBATWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:22:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF2C06173E
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 11:22:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ah7so57101457ejc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tE/R9yvWA3Atyfb/JucqCUJU8G/DgubFOZDhk5Lo/ew=;
        b=XId/LPiTasBZmFrfoW21pxoJPIg+5+IY4ExAd2xTeXcpnBZedpcqKEDIvB/hHwHc0I
         WbSayqRMIlMgSbTwqIHUwMDXFCHiDwOZDP6ZtanGpRE63HQcOiOU53CK8pWHwGUOOk6g
         rAbF/CKE/TzqH+hhEUF0iZR61axOWuOj/9EvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tE/R9yvWA3Atyfb/JucqCUJU8G/DgubFOZDhk5Lo/ew=;
        b=GyuYkTEG0ALYo8mnGEoh/aH3GghZ9QKxNTywHafMl5bsMGxPyKj7i/WGULapMNE+XT
         fCdlBpPOgnZw8Aw5V2U1HLZqSgqHN7GJHCubZhH9V9Dx/h1usdenSu7W5ugE2ReOhUgW
         4mb9NK/iN1SyBQdGaDe7FSP8xxEnRSN3zj4sKGtfsG5ZZ+oBU12k1MjAyYIyMuXwNcBb
         65Z+O4q079vZ0hc14LQKwEu22G+VNGQbRwAaK/spHOBCQ1Heob6qdZ9nq4SyIYaUbsxa
         zEbI0mVgV5JUYCDXPeU4N6ZDt/jiKn6FmspOVchyINvEdRKNvh52QpV8BpnqE/MzMxix
         tEgg==
X-Gm-Message-State: AOAM532jpKRdw++QfZZNGqSNDrZXPSVOln1q9iJSA3IRGW+lFJ0icJWq
        y0dLuH10be7Jo83gO13gkN/XSBzwLywkHZG0
X-Google-Smtp-Source: ABdhPJz1X9LPBvTsavIVgN8PgDkCN+CZoCkBCRDOSDKIHGZieYqgOyg7AOF3mKXm3Gj3YPWoIM+QuQ==
X-Received: by 2002:a17:906:dc50:: with SMTP id yz16mr67903ejb.633.1643743332238;
        Tue, 01 Feb 2022 11:22:12 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id c8sm19790529edr.70.2022.02.01.11.22.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:22:11 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id h21so33980479wrb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 11:22:11 -0800 (PST)
X-Received: by 2002:adf:d1c8:: with SMTP id b8mr472549wrd.442.1643743329676;
 Tue, 01 Feb 2022 11:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20220131144854.2771101-1-brauner@kernel.org>
In-Reply-To: <20220131144854.2771101-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Feb 2022 11:21:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpA4T2-Z8Dg2HYP=3LSbT99kLjhJ1g1nPMObihrHpnjg@mail.gmail.com>
Message-ID: <CAHk-=wjpA4T2-Z8Dg2HYP=3LSbT99kLjhJ1g1nPMObihrHpnjg@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update Christian Brauner's email address
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 6:49 AM Christian Brauner <brauner@kernel.org> wrote:
>
> I need to update my mail addresses. A pull-request doesn't seem
> warranted for this. Would you please apply this directly? It doesn't
> contain any functional changes.

Applied,

                Linus
