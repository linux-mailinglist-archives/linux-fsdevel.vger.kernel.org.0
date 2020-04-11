Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6F1A53E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDKWJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 18:09:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45587 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKWJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:09:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so5253938ljc.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TETsvPIW3zFK7a+s4Xy+/EsP/ZIyd7MDAnh8kXDUPDY=;
        b=LWKhzNO/fmkN9AXIbh6BdMPSoUwuuc1JIQbspBQF8oSJHNi+9xPH2NDbM8dVz5Mzia
         O5Bv8VqXhUpaAfmywLN4z2mbstp/udAPbBebWk/RVBwyz93e9k0XSh0EtntzOz886wT6
         HCLCmJBbcNFSByCMNpooPlQvhUTqF3YMn4tsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TETsvPIW3zFK7a+s4Xy+/EsP/ZIyd7MDAnh8kXDUPDY=;
        b=TuTZnOAPsojglhvDArB2eVKjdxEb/2hrNM4ud06rjQtIJlKLerBu0uf9P7CWS9HpWZ
         XiBmuEAu1aXuBUB18F1+x1A2YFek4TmiCTHf8d5HpSw7uLEfGhvfC9hZOu+MR29OeFRy
         XxSBFsMxgkaNpMOyhJzvf/deNda6tEPgCel0P4IBu66Nf80pkAHunM0gMpSuecpM7az6
         2dlYAP2nNM8bYlBOXmD33C7Pk4DZ/IoP00p1c1cEENduM8bsoSlgxLF2sNcqCd/PoKTB
         zKnGmeuGz/YNskf3ktYJD7SYLAyL9hvtLw4BuLofTg8tkhvyzdpEgySxae4oo2tw/uvE
         vvTw==
X-Gm-Message-State: AGi0PuYTlwyw7/X7cn2W2jW6JLmaGCfI4TJBpTy9HOR1GH0A6SZoZMUu
        R1YEOlNll3C1jI3+RkW1DcKBukiy7Wk=
X-Google-Smtp-Source: APiQypJFBqOFT/qLRcTg6I4xL1WSVDRBW5RrJ63/xXYXXihu166EzOWGoRtFlPWHs64JnQLKcwHqWA==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr178125ljj.89.1586642992873;
        Sat, 11 Apr 2020 15:09:52 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id a26sm4187776ljn.22.2020.04.11.15.09.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 15:09:51 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r17so3831344lff.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 15:09:51 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr6353420lfd.10.1586642991463;
 Sat, 11 Apr 2020 15:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
 <20200411214818.GH21484@bombadil.infradead.org> <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
 <20200411220603.GI21484@bombadil.infradead.org>
In-Reply-To: <20200411220603.GI21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 15:09:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
Message-ID: <CAHk-=whFfcUEMq5C9Xy=c=sJrT-+3uOE2bAwEQo9MUdbhP2X3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 3:06 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> But we _have_ an offset_in_page() and it doesn't take a struct page
> argument.

.. it doesn't take a struct page argument because a struct page always
has one compile-time fixed size.

The only reason you seem to want to get the new interface is because
you want to change that fact.

So yes, you'd have to change the _existing_ offset_in_page() to take
that extra "which page" argument.

That's not confusing.

             Linus
