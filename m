Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10F2A1A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfH2Mql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:46:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50739 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2Mql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:46:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so3601696wml.0;
        Thu, 29 Aug 2019 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QlVIC8TNhGJq1NB5dIfzGpZGGFQCIpdVZDF44V62VcQ=;
        b=JV7b89eNFuS5WTpaC3U9r4/BkSvp1wlY4PXYTx3w4hEIfEm9P+CgbJu5H1VoJVWQKq
         68PDD+FSCBps8rPl+joi/bUj2C42piXodE/gVgdqWh3svPwjrXJxRKxzw7Q4oKjmBkt+
         zGiWqTGguB7RYgarPllP8n0o2MhkEOyxpN/aii3w/RS9DrO90+Qm+oB4VEdI1Gj0Qqz0
         r+dKd/MMucszeGo4UlII4Qo/PhfiZve0FlS2G5VUlkSJYxgqTfZYnmFy7+4t+7u+o+tO
         iAxEb4SrOcT+oKbKFDUD9lIGC7JhIUaJB18vI20gw1ZCsQeC/VeiekIrWA7ACbmdSV6K
         5J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QlVIC8TNhGJq1NB5dIfzGpZGGFQCIpdVZDF44V62VcQ=;
        b=I0/zp8Gi5zf35HTCc6gdLlnAnGBzy7pPyNKyN0xkFV+SzYvraojAuffklVKzlKCq/L
         aKcEbWZsaDlAduPpP9XlOG+F20yCbhXGV/6lw6KwT9vNfWpHvpPbR4qAq3Z/LJ3AbKde
         lQKTzVowyYp4dtPrAOheBxcQITKpQ9VXO6ebsuTKEPs+HA8e8UQMHzJZ/mdaam2mG8dn
         OcoLVPnUl0pP8fIitIoftmIyvlUioEpLijyv1HuYpvXYmRoBo1ASVWnvDt6S+EdwLaqX
         802lE3ptjZX9n2XJ7OT+v5vtVyQrt91yhriJquKsXRF+Ho7N+L2vzb1A8cDWxKyD8jKv
         8jNA==
X-Gm-Message-State: APjAAAX50mBkaAJqUs1wyuBdq4CMZhUV0PZyeYdM684HogFvfsPg3ZPg
        f2DwKQ/Ne1lKlxGoCk3Fgeo=
X-Google-Smtp-Source: APXvYqwrshnUNKamixaL2Mpydl0AFKu7KVc1CrEhTFhBwIf2wyr5clc4/DhX7uakfObPGE2AS4L4uw==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr12036367wml.51.1567082798038;
        Thu, 29 Aug 2019 05:46:38 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 25sm2552046wmi.40.2019.08.29.05.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 05:46:37 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:46:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829124636.475c7znb4pxuq2hi@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829121435.bsl5cnx7yqgakpgb@pali>
 <81682.1567082044@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81682.1567082044@turing-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 29 August 2019 08:34:04 Valdis Klētnieks wrote:
> On Thu, 29 Aug 2019 14:14:35 +0200, Pali Roh?r said:
> > On Wednesday 28 August 2019 18:08:17 Greg Kroah-Hartman wrote:
> > > The full specification of the filesystem can be found at:
> > >   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification
> >
> > This is not truth. This specification is not "full". There are missing
> > important details, like how is TexFAT implemented. 
> 
> Well..given that the spec says it's an extension used by Windows CE...

It is extension which provides more error-prone write operations to
minimize damage on filesystem.

> > 1.5 Windows CE and TexFAT
> 
> > TexFAT is an extension to exFAT that adds transaction-safe operational
> > semantics on top of the base file system. TexFAT is used by Windows CE. TexFAT
> > requires the use of the two FATs and allocation bitmaps for use in
> > transactions. It also defines several additional structures including padding
> > descriptors and security descriptors.
> 
> And these two pieces of info:
> 
> > 3.1.13.1 ActiveFat Field
> 
> > The ActiveFat field shall describe which FAT and Allocation Bitmap are active
> > (and implementations shall use), as follows:
> 
> > 0, which means the First FAT and First Allocation Bitmap are active
> 
> > 1, which means the Second FAT and Second Allocation Bitmap are active and is
> > possible only when the NumberOfFats field contains the value 2
> 
> > Implementations shall consider the inactive FAT and Allocation Bitmap as stale.
> > Only TexFAT-aware implementations shall switch the active FAT and Allocation
> > Bitmaps (see Section 7.1).
> 
> > 3.1.16 NumberOfFats Field
> > The NumberOfFats field shall describe the number of FATs and Allocation Bitmaps
> > the volume contains.
> 
> > The valid range of values for this field shall be:
> 
> > 1, which indicates the volume only contains the First FAT and First Allocation Bitmap
> 
> > 2, which indicates the volume contains the First FAT, Second FAT, First
> > Allocation Bitmap, and Second Allocation Bitmap; this value is only valid for
> > TexFAT volumes
> 
> I think we're OK if we just set ActiveFat to 0 and NumberOfFats to 1.

But this degrades whole FS. Even FAT32 uses two FAT tables due to big
factor of brokenness and fsck takes care of it when repairing.

There is not too much sense to use exFAT with just one FAT if we have
already working FAT32 with redundancy of FAT table.

> Unless somebody has actual evidence of a non-WindowsCE extfat that has
> NumberOfFats == 2....

-- 
Pali Rohár
pali.rohar@gmail.com
