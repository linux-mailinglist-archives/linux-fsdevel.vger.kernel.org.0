Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01612015B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLPJmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:42:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726959AbfLPJmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576489369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLOJSgxmsG/vwmr/XKvFZuadZb/u0y1IL2k3SEvyKMo=;
        b=c0k+W7s9FTrCZ8/Jz9N3eowIzLjIil/th6Dk2iwGW/2iEQ5nO1U1NBss8VRM1BjHbtKS1m
        nlEBvFrd66Bzu3BTG2XiLftAueFBE7K7GdZ9DsahH429n/TWaJQWUE8EOumLq0fVfjKWtD
        YSxvQVddG0WuJ6FyCbw8DTaEYAK9aRA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Cn-N3nQTMg2CjnuJpeMn8Q-1; Mon, 16 Dec 2019 04:42:45 -0500
X-MC-Unique: Cn-N3nQTMg2CjnuJpeMn8Q-1
Received: by mail-wm1-f71.google.com with SMTP id p2so845168wma.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 01:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=PLOJSgxmsG/vwmr/XKvFZuadZb/u0y1IL2k3SEvyKMo=;
        b=EZshB2PV7Xcm+rWgl1N+hyZkoUwKRAKMsqNU/Pk2UWlFrBbgacisNWu6as0Ca9qQo5
         CssKlvqyWO/y2tsxDaLoVET4A7zvr1ogU6ZtPRUUI5cP++HEMJ6W7QT4QR8VjC92mx7U
         aYKMJ3DTaafBMMmVb5BGGMYbPV16Qfi+CHm6tPpXXu5O4lvgppOoUyi2KEUxbW6Sp4lq
         oo417UJpAun4W9h3HUFhyzTkK3SXcT90SyFEkZaHJ/k0lGfZK5FykAZ/5c09FXUZ84iP
         2iARBkGtseBYexsDNT38XZ4E1oMSH7hxJhcirV9uKhpFmPHVewjxH3NBURxilKaXLYp9
         LwGw==
X-Gm-Message-State: APjAAAVQ9f/ho9+lr3hPBewezqXYv7VTK5ZK6GI+SQIL89ZQetXwQQDl
        SGqwYksjL6tAPHRYzaJd87f8M3CpxORxxf2r3wR1JOxZ5iyf6eqqAtTCGJyXinXMMWOr+aTkvAQ
        jkoJ0yb6mOk05SG9psvlLs1z3cw==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr28111578wrm.290.1576489364740;
        Mon, 16 Dec 2019 01:42:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBxzsNATZPWJc3uk0zp7X8ophdeSod0wFuhF1JWy4sxQpftv9ASjpAJ53OCFpT5DdEjlUB1Q==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr28111561wrm.290.1576489364558;
        Mon, 16 Dec 2019 01:42:44 -0800 (PST)
Received: from orion.redhat.com (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id t190sm12026503wmt.44.2019.12.16.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:42:43 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:42:41 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/2] New zonefs file system
Message-ID: <20191216094241.til4qae4ihzi7ors@orion.redhat.com>
Mail-Followup-To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216093557.2vackj7qakk2jngd@orion>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:36:00AM +0100, Carlos Maiolino wrote:
> On Mon, Dec 16, 2019 at 09:18:23AM +0100, Enrico Weigelt, metux IT consult wrote:
> > On 12.12.19 19:38, Damien Le Moal wrote:
> > 
> > Hi,
> > 
> > > zonefs is a very simple file system exposing each zone of a zoned block
> > > device as a file. Unlike a regular file system with zoned block device
> > > support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide
> > > the sequential write constraint of zoned block devices to the user.
> > 
> > Just curious: what's the exact definition of "zoned" here ?
> > Something like partitions ?
> 
> Zones inside a SMR HDD.
> 

Btw, Zoned devices concept are not limited on HDDs only. I'm not sure now if the
patchset itself also targets SMR devices or is more focused on Zoned SDDs, but
well, the limitation where each zone can only be written sequentially still
applies.


-- 
Carlos

