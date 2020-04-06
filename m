Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5B19F91E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgDFPqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 11:46:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33768 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgDFPqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:46:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so7742845lfc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM6NO7u4VQbW1lu00t+WWOxSqJndpnDnuJ4jQghzPUE=;
        b=ATtWeB7TwKV6tUS3q6yFJi1J5lOkwm97vHKEGbXjnLuGfMid4PPhCTZgQ2vsCOmNGU
         RiYbV8tKrIQdoH02NJrHKlPaJ1z+Gg/umexn+w7pNGlqbGfueHwbmEnhwW50uiV+P6Xe
         tzqpk2+YAxnZ96b7z/etLmw36EArLqaTVor5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM6NO7u4VQbW1lu00t+WWOxSqJndpnDnuJ4jQghzPUE=;
        b=Ezq9W3Eyg4BI9Q7xDasxkEgIwr59X0G74/XyEG3AQD/gGny4w44JmfvGUQ1DZ4oTzH
         84jY3SfLk6ifYita1OV5g1LAotYBvhz7Hu9/W4YATe4mt0zymJ6P8tcgn7X+F/fu/JRQ
         su4HB2eYH3uF41C3Kw0EB3n5X4DxsQO9mfTGpAQriRaOtFxGJS+crX8Ho0jWshqfoXIb
         8WpalTvxYHLEF9591pGiRMDExNcXodMt+iemRfOZUqJkipglQ2xgT/+VMayMG50cZTx6
         aoVgaSFyUR72qAinB8WToKrbRT7AqLv3PImMrSM0VZohorQ618CoUCKe6PtPbqBjUHxz
         w+dw==
X-Gm-Message-State: AGi0PuagNOrlzCiMlA0H9rz3D9TNLYUkE0KHoy+TxzP16A13yC938yzu
        xSVpjpJXFQKSjac64kOSxKjSyak5TFY=
X-Google-Smtp-Source: APiQypIqd5+RUKTqDHGadlaI8FKZtq9gCfaSHsrBuYXlgTvIY1Bft8NEf0vYVnT5bYRaSg5ySZeS3g==
X-Received: by 2002:a19:5f45:: with SMTP id a5mr13397217lfj.18.1586187958932;
        Mon, 06 Apr 2020 08:45:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c2sm12254885lfb.43.2020.04.06.08.45.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:45:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i20so169035ljn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 08:45:58 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr12856259lji.16.1586187957613;
 Mon, 06 Apr 2020 08:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200406144032.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200406144032.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 08:45:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2UALsz8=R54WLGzhz8mGqzMnKqV1E=SaFOETYhrjYYg@mail.gmail.com>
Message-ID: <CAHk-=wj2UALsz8=R54WLGzhz8mGqzMnKqV1E=SaFOETYhrjYYg@mail.gmail.com>
Subject: Re: [git pull] regression fix in namei
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Dumb braino in legitimize_path()...

Well, the type system can't help us because the types are the same,
but I do wonder if at least the naming couldn't have been slightly
more explicit. "mseq" vs "seq" is a bit subtle.

I guess this is mostly a one-time conversion issue, so not worth
trying to worry about any more, but that internal interface does look
like it's ripe for mistakes.

              Linus
