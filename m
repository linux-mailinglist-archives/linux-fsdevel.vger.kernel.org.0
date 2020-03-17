Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06442188466
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQMi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 08:38:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43228 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgCQMi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:38:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so13679117lfl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=hnj4sEry8e72e+4XxcViMh2kR/clVi9rs+0bXE1Bk+1jnM9tAaTyTvgL4uYk9HGokQ
         CS6JmX/z0c6hGZP4+/nsjdwrRToHL2MnmrEP2s5tbTN6meK7gab1DE86o95g8btZIabJ
         X0Nb39RB/DJ0JWjBmqOkl9uU6GNs9+S6/0dZvKl3+nAxc/hPOac2EFucKTzFdRe8iZbM
         pd2Cz/K1I/XtSdYirkd2zkc5FVQnbLpfFYWuWeR4JcwrggK69xvkfXK7qVwpyd+zrveT
         XkUuyowMJlxJdZtfXDBqIGaPNwQ4N/hPoHdbjT/raGV9/FQs/kLHLi9N8GnTZjdSG/jt
         rWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=mfvve2j+HsYyBfMOs3N+uOu/ZK8k1GEB/zDs3K7zo9m2t8P7BWYI150Q7+5GBG8pm1
         wXCKXDwPu3BWoRcxOgNxDSTiQS7WUMi8AoNvcaUkJX+l1bXEP++ErE+DJlqFoR3RKeJB
         7U0/X9FnXNP24NeXWf/z24Z3gTIEyOILkIbx1P3CjjlydXUL1QvgAXBJPBH274rGUXnT
         v+d09830gcS1Ldsthgvek0JRIOBF46ebWSi5kDBEHJhxtwzO+b7MtHDgBms0I6bwEUWI
         pU1y+GlbwHouoo2HwzSkNT7NdeWouzuVTrdZbc+k1JcrnTppPwUcCo3qxgdkT7k9+XJy
         Xasg==
X-Gm-Message-State: ANhLgQ0beMmJ8xxLjIH+xlHvaaIOS5/moaeEiowmpRGPHbdG2WU04Xf6
        qOtb3ke17FlaBq8ZQNSRm7VMPyPmVSAIurvTko05TQ==
X-Google-Smtp-Source: ADFU+vtpPO/SB7g4ehk7qTFyPKse2g7Gmfi77CZPwCuVUbJVQI6d70Lf5FyUoeDifSP8iaSTW1v77WW+rDocRRRH0SY=
X-Received: by 2002:a19:6502:: with SMTP id z2mr2694078lfb.47.1584448702419;
 Tue, 17 Mar 2020 05:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org> <87lfnzdwrf.fsf@mid.deneb.enyo.de>
In-Reply-To: <87lfnzdwrf.fsf@mid.deneb.enyo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Mar 2020 13:38:11 +0100
Message-ID: <CACRpkdY8uLVrT5=NMpNmKhgmqu=yT_Bgc-Q9-BR6NgRFjnzjFQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:53 PM Florian Weimer <fw@deneb.enyo.de> wrote:

> Just be sure: Is it possible to move the PER_LINUX32 setting into QEMU?
> (I see why not.)

I set it in the program explicitly, but what actually happens when
I run it is that the binfmt handler invokes qemu-user so certainly
that program can set the flag, any process can.

Yours,
Linus Walleij
