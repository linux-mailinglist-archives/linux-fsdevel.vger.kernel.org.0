Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492BC17D237
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 08:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgCHH3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 03:29:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38441 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgCHH3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:29:21 -0400
Received: by mail-io1-f67.google.com with SMTP id s24so6157139iog.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2020 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkIpXYlnT5fOjXRq68KBlQBwP4ZTiV+/iYxASxv0e8U=;
        b=sl8Iym7IX4alz2u0OdMItA1N/qIGy67QAihqFEn4DKxt2etBv9FKZkqMe4YfrVPPAM
         z27GyZYxel6Mu5M8/VQdqv7AIBHvjB52ZSRNqhax4W2IFB01LzmpFs1uTgnOG2oTfl5F
         P7odYBysktD5LLArmGSDY/Bequ3GkgQAz2MezGFp3BSZgYQlJc7qbYRgt0rG7GNLFrgs
         hscdwZ7Sm3VsDMDtg4aQcicIKeZD1Mg3Pg65+OhwPyhKatAb0x93JlajV7n+aJqqlZRq
         G5y5Vidv4Oyl8asGCn8Hz4Bz0yw2lZ/5siwBoNmzYbe2hffUkv6bGjr7dh7RmCNOssnU
         NdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkIpXYlnT5fOjXRq68KBlQBwP4ZTiV+/iYxASxv0e8U=;
        b=lATN2g/9zKw2GdcMgrwuRTHun22kFhCsYfoZ89/nAd1TFMHQeOfgaHX2XnZKwHSxjz
         MSeJBKmL7sKZYNaxfexUw4fWaXZXSeHUmRcT/EUx4Qgdac0AxFqnnFWVH5n8/HVwHxkT
         58rEpVEIoHTs7R2hypXOwNy72iXKJQ1CcpoDfgRKHcf6Bz8zkDSA9VFpKkXJZxVHqVqC
         Mig2HBNeuxw1U5+zkfVHfLBtWxic1u5s5hsiGqMjrgSPX4+guMsNm57xU75JkIusm4nD
         sgnmbu9Y2nPplkeeN/K74oMK8uHvWF/R0Jc2WzIYrdbwJixR4667AHs+4qYttN4L0wWo
         5ipQ==
X-Gm-Message-State: ANhLgQ1/h7PuUS7bUwR+h93vhhGl7H/gLRGIbliWGoKgdsIIChcw1h2i
        p24R+UPeTZIpP26vWEdmmIcpVosS6qDurTgOXTld3H0e
X-Google-Smtp-Source: ADFU+vsRB4t6Qw1kTSOOENLqek9Oh6HscJDmjTvuiKJwCAS2rlwHE/0EAyLDW7JFLWrz/wuy3t0AH+YCe8srX7buXU0=
X-Received: by 2002:a02:700a:: with SMTP id f10mr5697531jac.120.1583652559083;
 Sat, 07 Mar 2020 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz> <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 8 Mar 2020 09:29:08 +0200
Message-ID: <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> To see what the benefit of inherit fanotify_fid_event is, I did a test patch
> to get rid of it and pushed the result to fanotify_name-wip:
>
> * b7eb8314c61b - fanotify: do not inherit fanotify_name_event from
> fanotify_fid_event
>
> IMO, the removal of inheritance in this struct is artificial and
> brings no benefit.
> There is not a single line of code that improved IMO vs. several added
> helpers which abstract something that is pretty obvious.
>
> That said, I don't mind going with this variant.
> Let me you what your final call is.
>

Eventually, it was easier to work the non-inherited variant into the series
as the helpers aid with abstracting things as the series progresses and
because object_fh is added to fanotify_name_event late in the series.
So I went with your preference.

Pushed the work to fanotify_name branch.
Let me know if you want me to post v3.

Thanks,
Amir.
