Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEACB5F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfIRIvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 04:51:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43535 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfIRIvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:51:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so3913458pfo.10;
        Wed, 18 Sep 2019 01:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPbP7/QnEjDWJMoF8RBYmDoQXXTihg9TkENrxs8Hikg=;
        b=cbiYakMoAIvXUJQ9wm1mOP6JHGlOkOz/Au/pG2FWgchoLAVMxnaK6cQOnKzbluMSHA
         xB9lDEMjhhNQf5lshkFO9x/Ql/FTNiZ7PF4ZC4c1ZqtsOZzT/Nq0NEhHBywh0TnxF2Kg
         h374gLtf6y5fjRbwIQj3ZWhJaZSjcW9vV528xiUUFYCrTqMkK4mTaLZ9mfgciOPEQho2
         y8QQf3O1sgZ2DOzWX5AE7iwc1vxSqE93VivDHYRZNmfgbNe/6JlO6PYmrFvuU4YTOCk3
         Omz26nhfUD32qDNRxkt/i0mER6pMEmH9kKPxyttZQEBtuNp3K/eU/krw4NyPPxpfXGya
         GXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPbP7/QnEjDWJMoF8RBYmDoQXXTihg9TkENrxs8Hikg=;
        b=XxjTGbUsN5ytfDvwUTy0Kp9kFMSNsJ+VGOMYVHoDsnAYBPwvRXV/BIVRzxJ57Lln5h
         l4bIexFlve6GLERISm3UJ4n4/PTFORmqgaSuXP5dUcBY4J+wp+WccQg3niEdZuqSMBy+
         GcHUlLk3tfO1JWApoK+BrydrCNFWSJ9KFzGcZiBXubQ0bM3D94FREHY7aqxkmXXc0zr7
         Iq3W0ceq9FqCpTtDH1alnn8ByQWUpLZUCzh3VHXAtsoOMIPj8tAD0noCbevkRsAmRgYL
         6khnB+DK1KUXAEFcuFumV5oq/PnXpexPNcxO4jmMIbNUT039XsuSgNscyLqupeZxyb4l
         We7Q==
X-Gm-Message-State: APjAAAWzwvmp4GKGdwo8YHuVCFnGkmCFEbLLiNwEw/T0pjPAW7O2P0UK
        xU89/QiSMNPiDp5gtcD/XXw=
X-Google-Smtp-Source: APXvYqz96Nlr+KoorvghPjVXzRmmCC/Nc9td0WVT/TjOqMmV15Ec75Jh+yuH13hDUmySR9WbC3d/YQ==
X-Received: by 2002:a65:6254:: with SMTP id q20mr2975759pgv.423.1568796698439;
        Wed, 18 Sep 2019 01:51:38 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id o42sm1997810pjo.32.2019.09.18.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:51:37 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:51:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        'Ju Hyung Park' <qkrwngud825@gmail.com>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918085134.GA47301@jagdpanzerIV>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
 <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV>
 <20190918082658.GA1861850@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918082658.GA1861850@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (09/18/19 10:26), 'Greg KH' wrote:
> On Wed, Sep 18, 2019 at 03:33:04PM +0900, Sergey Senozhatsky wrote:
> > On (09/18/19 08:16), 'Greg KH' wrote:
> > [..]
> > > > Note, that Samsung is still improving sdfat driver. For instance,
> > > > what will be realeased soon is sdfat v2.3.0, which will include support
> > > > for "UtcOffset" of "File Directory Entry", in order to satisfy
> > > > exFAT specification 7.4.
> > >
> > [..]
> > > If Samsung wishes to use their sdfat codebase as the "seed" to work from
> > > for this, please submit a patch adding the latest version to the kernel
> > > tree and we can compare and work from there.
> > 
> > Isn't it what Ju Hyung did? He took sdfat codebase (the most recent
> > among publicly available) as the seed, cleaned it up a bit and submitted
> > as a patch.
> 
> He did?  I do not see a patch anywhere, what is the message-id of it?

Sorry. No, he did not. I somehow thought that he did, but it seems that
I just looked at his github and emails.

> > Well, technically, Valdis did the same, it's just he forked a slightly
> > more outdated (and not anymore used by Samsung) codebase.
> 
> He took the "best known at the time" codebase, as we had nothing else to
> work with.

Well, then Valdis probably took it a long long time ago. Current
"best known" is v2.2, publicly available under GPLv2 at opensource.samsung.com

	-ss
