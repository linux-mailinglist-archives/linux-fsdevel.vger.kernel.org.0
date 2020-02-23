Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D81696B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 09:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgBWIEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 03:04:52 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34488 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725980AbgBWIEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 03:04:52 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01N84oAr021186
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 03:04:50 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01N84jVM011938
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 03:04:50 -0500
Received: by mail-qk1-f197.google.com with SMTP id t186so5927495qkf.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 00:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=1sDjklUSRS6YK2uiHcNctH5JVvBEzpdZpp/YBerFW8Q=;
        b=AStyCzCNgMaZMiDoIadN53kVfPIRa28DoMXU1Q8rHG3Jm0rKgljNA6dxxEDA6B9WFL
         XC6LVgqpL+UjlY4TdbW9Vk5+iigfVhemYKzQkX3kWY8d1S0SNeUhFGv6JY7kjfIn07Gq
         R7ziFYB4ZTdCCcl8JDGcdk3nCbyt31yYzvZAXsLR3xkX/B3pndUYQ+E3tNlhv9h09//Z
         7BhRceOiYs8DQyvN9ERr6i2vKkPHCJsRYZE8Y7P3OJEymP22GU2xR3LiRVFNASp6WYH4
         WfC1jaPULPrWCSMARGnKoizyM/M1ZA7xBN77EmnuD+nVtN/TdiCp/JVHzn5KrQi4YoPQ
         gYdA==
X-Gm-Message-State: APjAAAVQ1RSgjEgIL4Ptz9LGtf5x6tN11uoUw5gPy20f3t1S1RKP2lF/
        whdDd9CTGis/uhnO4wRkBserS4VYnEip7ebvcn7y/6ZrlVMpVhK+tuDTOfryI3RWO97DIOmEroa
        aFFVcmQ65e9/ZRgwebwBtsFlJ6OnMfcT4KXjl
X-Received: by 2002:ac8:4616:: with SMTP id p22mr42368493qtn.368.1582445083516;
        Sun, 23 Feb 2020 00:04:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLhVoWW2qQBKGujy+A80rCyV25rTP6B3Jur8sdum1qXflE5F1qwSnbKA4SgT1R0Q+CM8Rjsw==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr42368472qtn.368.1582445083208;
        Sun, 23 Feb 2020 00:04:43 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w2sm4302117qtd.97.2020.02.23.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:04:41 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: exfat: remove symlink feature.
In-reply-to: <20200219055727.12867-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200219055727.12867-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 23 Feb 2020 03:04:40 -0500
Message-ID: <225183.1582445080@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Feb 2020 14:57:27 +0900, Tetsuhiro Kohada said:
> Remove symlink feature completely.
>
> Becouse
> -Uses reserved areas(defined in the Microsoft exfat specification), causing future incompatibilities.
> -Not described in Microsoft exfat specifications or SD standards.
> -For REMOVABLE media, causes incompatibility with other implementations.
> -Not supported by other major exfat drivers.
> -Not implemented symlink feature in linux FAT/VFAT.
>
> Remove this feature completely because of serious media compatibility issues.
> (Can't enable even with CONFIG)
>
> If you have any questions about this patch, please let me know.
>
> Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

Symlink support would be nice, but Tetsuhiro is right - this driver's
implementation isn't the way to do it. Heaving it over the side and getting a
standard fat/vfat/exfat extension done is the right way.

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
