Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318792251E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 14:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgGSMeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGSMeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:34:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B12CC0619D4
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2020 05:34:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so17406378ljb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2020 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZIrohiMdali1I9FPYzFLXxnzZ6kbPXecqdfnrEblwU=;
        b=xmNhNt4z0L/5c6tMRxdSOr6Q/WX+tYVe1YiAmkVbL9QC0fBJfCfTMUgH48lOCBgzLd
         jivsrFSafQg1JppTXkVDgNlM8FXS+1YK2o0+wB8LA3N9eiSRrJz4eLxfNnlYnk6tO3SC
         tgmTx7PqVpTzbxxmDkQ2+n8aqG6J+Tjo+wXc48LTd4iZQiXn+ADslsY4FcjkCkd5dnlN
         gv0IOS2XUeZMIb2sg7Tdd3vc9SFlzfVFG4relC9hqb12Xa+W4BUl6JWYPoyVdBSkfJGT
         xVHp/GoW7vcqLpGhDcB74OgI/azIrRvGOg6dT9CeXMcSVqmZACxw6BrTX4v+XvcTEODF
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZIrohiMdali1I9FPYzFLXxnzZ6kbPXecqdfnrEblwU=;
        b=VyXZSLRM0t6qMVPRSm8fS0aLJFqXeiqJofv2yHQV0LBomAuUJaUZ+ZmQ04XwPFdkD+
         rrnNHrHxzrz0DK5sxG0keHQijnt9hIelkCfycsD+6nPd8zkga7lSxt29SzutGrFRDTGp
         HLZQ9tEOhbwTiJZQQITc0w2WDX/Kfdhb3y0WxkzUlQaYlj1USmSAZlFm2tvRQ73ngdHV
         /Wl3XvZuhB7+j6HKrHchk0q7bp9pKjncSZfjQDQ5CrcSyYyqB+VC8g7sSdqa3MR4brD5
         Zs8dPEwoZtFd/uxyEHy0/D3SnDuFVNl4LRqAh7SwpF/GbcrvEnPyJtKUD5yiN1W/+x2r
         RY0g==
X-Gm-Message-State: AOAM531QbUa0IOnrvKnHGMKhGm/IUeTvqEDtiJpOsiX8WNKgaEa+G1sP
        6dSx6TP3AZDR0H0E3HhOg50a/uBgtUJpKJ2+oePnnA==
X-Google-Smtp-Source: ABdhPJzRynBTVB1RJzflXo15K9PzSSQ7Win2K87BjL3Kkg3KSM5ahbR1uH7ZPLe4uA7BKjcNcNfJxXiJkvll++c7e/I=
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr8445754ljj.293.1595162058467;
 Sun, 19 Jul 2020 05:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
 <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com> <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
In-Reply-To: <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Jul 2020 14:34:07 +0200
Message-ID: <CACRpkdbOiL7=KUNa0==P+H-3SynhMt1=JweCY8ihbEZLK=b78w@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> Ted, can you merge this patch?
>
> It seems QEMU is happy and AFICT it uses the approach you want :)

Gentle ping!

Yours,
Linus Walleij
