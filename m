Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C761B7CF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgDXRgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728850AbgDXRfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:35:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEEC09B04B
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so10781759ljl.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17Kg1dRas/M0sQXVRI4F1cdrQ//6hjmUk/mclI6heeY=;
        b=d+qcaZcbU1H0AzDGp+UTOcPWUOR9HjuA25jpYxyTWS0ttqCFnGFEDZb7W8gtA+8q7Q
         DUnPsJgjbJ8jo2hCYbfGpWCBX4F5xcNqH+cIGSxuDfBaMWgLONIW6hJ8WQHyGftwdtXB
         H8XP2ZEiiiYTC5NDB9zm0db/DQyW0/Ezlxt8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17Kg1dRas/M0sQXVRI4F1cdrQ//6hjmUk/mclI6heeY=;
        b=b4+dMJeS7y6kZ61Bd3rLMrS2jou06ZKfP0EIzQyaoNbWKGmuAzXQj/CBLfumXe9NwY
         qpmwwv3pzpzRsU2cOjeY8hW+SuthDFkwqVuD3QHBrYTpDeLLdAxrsD+3Lxc4cKaGrrB/
         9UxPVPwME3CgJ9hmhd/6az5hiDzjAJmvfDtD3RaooOb5hM0Pfp/AJ/wNmu43gv7ILMrh
         G0CuRCO5+qhzw8jHNZLbErQjKyy6ptf57p/8zeyigQYwAaH/ayISWFpJfy29bnoP3e2X
         Byy9Y/BmYRaqfEZa0YUvPpzehCDFmsNt00wztoU1yMyUxK9WZYHgmGvJw6sD1mY+U+iM
         9aNw==
X-Gm-Message-State: AGi0PublKcAmyTwy9419lKK3x9FEL4xoidEnA6asGj+sf3eJNjHmqYLz
        j5Lwhh3LJxL+eztwXR6CeFYOqWJdVQY=
X-Google-Smtp-Source: APiQypIFlpX5HciQhusw5TwvNjOIV2R4vjSSJa9UYp2i/ms0X+5xj0tgT2Ys0mg5N1sTUG2mHda/Pg==
X-Received: by 2002:a2e:8752:: with SMTP id q18mr6529420ljj.72.1587749744714;
        Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o23sm5166097ljh.63.2020.04.24.10.35.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t11so8356341lfe.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr7152809lfk.30.1587749743463;
 Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <3632016.1587744742@warthog.procyon.org.uk>
In-Reply-To: <3632016.1587744742@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 10:35:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_0Fye2U+AXjScpgd_hh=pFu3GJvgsUqCk-4=ckcHhhw@mail.gmail.com>
Message-ID: <CAHk-=wi_0Fye2U+AXjScpgd_hh=pFu3GJvgsUqCk-4=ckcHhhw@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 9:12 AM David Howells <dhowells@redhat.com> wrote:
>
>  (3) Make a couple of waits uninterruptible if they're done for an
>      operation that isn't supposed to be interruptible.

Should they not even be killable?

Anyway, pulled.

             Linus
