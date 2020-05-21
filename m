Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143221DDB3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgEUXlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 19:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEUXlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 19:41:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CFC061A0E
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 16:41:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so5449863lff.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rv+8dH0+h1qIgzONLiMgmbsnvlKVpQ/a5eVu0/0RsXM=;
        b=SUoy772rygPiyim9PFx6selqBY2GKZ7srh+XBdkJ5wUscHmEPW0UH9A6DuNDOOLH1U
         undzMTxv1/nE9988qpMGfhHMesPnrEDErZDU9ekEe9eQIcNu/3tEJ2ToU/M1Np94/fif
         /vwcjo8KCEY8GEaT2zkJdoPZsMCMmof3VsZUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rv+8dH0+h1qIgzONLiMgmbsnvlKVpQ/a5eVu0/0RsXM=;
        b=KWAc7RoIxlE+G4bNjJnkFwlZUETEnG/tdWAE10xAOQtgPt61bfl+3tmW39KT4Z0wqG
         0lAgBxtMUE0oCgdzGbAHn4pO5virsWaLdBpYB/umHTCDxXxXzsETkoBtFMv797skwp2L
         o/E+pt96bYGN/C8lVN9mbp28/UouxcWqDQckveUibN4TOfAl4ewe0Geqt+hepEZH1XG6
         hSa+88Xw7mstxutNw4tVE/h/ozd5EABS7o1uGXa34wpkX+6Qne+oJ0sgISmhDhNpFGPy
         OJqO4FBQ5jo6N+OHZLSAFEN+p+AKk9ZQrykuocA5spVu0uSQcD/3A2fgeOzVf9jLXHNc
         yDHA==
X-Gm-Message-State: AOAM532ogreX9W2YDkCEWHU3hnmeOFZj2hxwALE2oY28jZ/gXki13dgz
        uDQDoyzIVxquMIArstGxrxINc38cwJA=
X-Google-Smtp-Source: ABdhPJxCo4KOgj/EbxClxRSu9CbVI7mTiTCVzeRMBUJ/MuNL1lGqSnsH2djSPIY+Q6owb5R67PGnjg==
X-Received: by 2002:ac2:5f69:: with SMTP id c9mr6113600lfc.2.1590104479390;
        Thu, 21 May 2020 16:41:19 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u15sm2053692lfg.92.2020.05.21.16.41.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 16:41:18 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m12so8047633ljc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 16:41:17 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr3919937ljo.371.1590104477569;
 Thu, 21 May 2020 16:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200521122034.2254-1-namjae.jeon@samsung.com>
 <CGME20200521173209epcas1p29a26d78a46e473308553c6b3a6d0ce83@epcas1p2.samsung.com>
 <20200521173201.GG23230@ZenIV.linux.org.uk> <004101d62fc7$7b2e5640$718b02c0$@samsung.com>
In-Reply-To: <004101d62fc7$7b2e5640$718b02c0$@samsung.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 16:41:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3ZkjV4h0qkVASJNLmv8GSB8WWPW_E-OgMYr5f1fNjSw@mail.gmail.com>
Message-ID: <CAHk-=wh3ZkjV4h0qkVASJNLmv8GSB8WWPW_E-OgMYr5f1fNjSw@mail.gmail.com>
Subject: Re: [PATCH] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 4:28 PM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> I would really appreciate if Linus apply it directly to mainline.

v3 applied. Thanks,

               Linus
