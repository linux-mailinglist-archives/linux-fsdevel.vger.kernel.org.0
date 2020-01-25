Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4563A1493DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 08:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgAYHG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 02:06:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38394 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgAYHG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 02:06:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so4753330wrh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2pAdz/2no+OOg9fKoS5FkAo0J1e424VM8oJW+tiob0=;
        b=iUx7nPSxTTagp7Ag7cP6ZLkQksAJzUfDwlOlpn93fDgcU/CWH5BN6v3XU4rKI7YrLv
         vjr1uWgrDmh9+dN3c5kjP9G1B9uj0Uqj1oSypuajuo7A96HOXwXuh4VbKqKTtwNgU4PW
         OOdmwUmaGXcXnhE/pHieJckCqK7vCixFms+uFW7vd9CcNESZuJ0qNJzlIsKPnFh4WZ96
         nHI/YoeUr0t/uLjSMOI+2uWrWzP1+JWXs3Ay1+Me3zXF6jJeCfAuMduhOlphCFybBUw4
         1dyWj8VNHeJgqGkNc91+L2BnSyFXhmKP0YPHHYIcsWIhLptuxK26jx+mhAv0gXVjEK2d
         yDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2pAdz/2no+OOg9fKoS5FkAo0J1e424VM8oJW+tiob0=;
        b=paK4TzpD+dd1Br7j56xy9GklC09wv10/72xiF/89w6kG82F8Qk6Zk5AGls1vXSKILY
         94E8nDrUv2Zc52NHIZDyW28sJ4I490OkxJYoLD55Mua4FYhZt1rX5PmZwXN7GbVAb5s4
         2jaWHiHSt52aSHC4udxCx1EC52UsrkHyw2nKN/GRd0Q99YWakpJfejVJjXbCWrKyubpG
         AyGlyaJ9Gzm4WAY6FufX+mSZCNrRS0hUX5e2PWjnVsebIElkIX2pfwSN4cez34lIo1bI
         af5bXhjlZ7xr4/9bUf0zbxI6gkDe9T7tkDwXjXImEdVjF6TyOxeq0bjFCp8ae2MfocaR
         kgyw==
X-Gm-Message-State: APjAAAXth/og8zlKoVsCZDfH+4j5tymjuOTBhN5lbORZvNO3/+Y6eMdw
        3WBnWNeaBSEpvfQD/0BUThWTHjX2hHGGjV7Up0JLUA==
X-Google-Smtp-Source: APXvYqz3cWy/GqT/vNNk3kJQESif/EIu2KbH+K7HS8QiTyZS5IvujaaqLJaXWZ+XalPPx69ooJAoQ0ErXha/5McJ8Rg=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr8635872wrw.126.1579936013232;
 Fri, 24 Jan 2020 23:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20200124051332.DoQFo8kO9%akpm@linux-foundation.org> <1ccf26d9-9420-fc33-ad96-c3daedb1c487@infradead.org>
In-Reply-To: <1ccf26d9-9420-fc33-ad96-c3daedb1c487@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 25 Jan 2020 08:06:42 +0100
Message-ID: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 25 Jan 2020 at 01:09, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/23/20 9:13 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-01-23-21-12 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
>
> on x86_64:
> CONFIG_X86_UV is not set/enabled.
>
> from linux-next.patch (in mmotm):
>
> ld: arch/x86/platform/efi/efi_64.o: in function `efi_set_virtual_address_map':
> efi_64.c:(.init.text+0x11aa): undefined reference to `efi_uv1_memmap_phys_prolog'
> ld: efi_64.c:(.init.text+0x123c): undefined reference to `efi_uv1_memmap_phys_epilog'
>
>
> Full randconfig file is attached.
>

Should be fixed by

https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/
