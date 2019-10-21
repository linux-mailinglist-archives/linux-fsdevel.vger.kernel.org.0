Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1C3DEA17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfJUKyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 06:54:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:54:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so13393460wro.7;
        Mon, 21 Oct 2019 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9FLQHlZqrICMBNHhz4Iit7vCKLtonkvMi3q7kFDAN3I=;
        b=UcBj5W9WfX7D7Ks0S2FbRtur+JEk2c3VJzrZFBwSvNHouo+QM5t3LNOcD7yOCUTvfY
         5eSfA676M8FhZBwua3d038z9vfLyqDHyCD+b2anwQ/lzmX1Qev+RPhu9/Wgjj1NcJXaL
         ljBMp4ix3vACqA3X/GnRFP2nIKVWRSOLafYasc9bAGIJl+9+OM6UQgneIMem3+1xhE2F
         tmT4KLdDYnKrq2FmkQ9ZtW4tcTDvbbeOEK4W1/aE+O918xTe0s7RBI/4BTr9o5PTORdt
         sm1CHyL1gpBpT8igLNAjY0LxD4o7Os44pi0wCNKCAlUs3zQaCi35M6qLHQoORNDnM7Yt
         LBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9FLQHlZqrICMBNHhz4Iit7vCKLtonkvMi3q7kFDAN3I=;
        b=g2NypHN7dP0qAsW13anEFPnBTk9bbE9s+GWlq229oQ6v0F1E1H+XTKRVCKS6/LsGFf
         OsdFE8GtxXK7xp9L90h7k0CJtb4arih9D6cNTL3slKSfkI9JxX3dCGzeaZO7PkU4Eooz
         2CIjulfUXSSTZXb7k0bysO/fr7HPHXw+61SymzfWgJyKDIFCencwZTi8Z2RYM+AjoKD6
         WPNEsDSp8qCERDYiTUnqZqjO3SzWBOdEWJSGDCtpwkl3WPDgw58fH/EO4l59KWsMoSAG
         QldXSly3RnP6BbB247s+tmh/lDS+ZbcCl7gpao6N2U1dTX6iffr17OssS9Z/UkEa0llD
         Ahjw==
X-Gm-Message-State: APjAAAWb7/oxAYY21xDQhl/atg35b07gN/ho3/csG5b8iVGfYM3ucwji
        f5OaXaprAW3CrhvFliZMgJU=
X-Google-Smtp-Source: APXvYqzM917VAbFxVYt9i9ZHbAgfsqtFE6PqBJdfuvVnBqd0xCczbbyqVY6BpiEscXK8T5Q6gBdGzA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr19074932wrn.261.1571655251486;
        Mon, 21 Oct 2019 03:54:11 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r27sm25949480wrc.55.2019.10.21.03.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:54:10 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:54:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Message-ID: <20191021105409.32okvzbslxmcjdze@pali>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 20 October 2019 20:08:20 Richard Weinberger wrote:
> On Sat, Oct 19, 2019 at 10:33 AM Konstantin Komarov
> <almaz.alexandrovich@paragon-software.com> wrote:
> >
> > Recently exFAT filesystem specification has been made public by Microsoft (https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification).
> > Having decades of expertise in commercial file systems development, we at Paragon Software GmbH are very excited by Microsoft's decision and now want to make our contribution to the Open Source Community by providing our implementation of exFAT Read-Only (yet!) fs implementation for the Linux Kernel.
> > We are about to prepare the Read-Write support patch as well.
> > 'fs/exfat' is implemented accordingly to standard Linux fs development approach with no use/addition of any custom API's.
> > To divide our contribution from 'drivers/staging' submit of Aug'2019, our Kconfig key is "EXFAT_RO_FS"
> 
> How is this driver different from the driver in drivers/staging?
> With the driver in staging and the upcoming driver from Samsung this
> is driver number
> three for exfat. ;-\

Hi Richard!

There is vfat+msdos driver for FAT12/16/32 in fs/fat/. Then there is
modified Samsung exfat driver which was recently merged into staging
area and supports FAT12/16/32 and exFAT. Plus there is new version of
this out-of-tree Samsung's exfat driver called sdfat which can be found
in some Android phones. Based on sdfat sources there is out-of-tree
exfat-linux [1] driver which seems to have better performance as
currently merged old modified Samsung's exfat driver into staging. This
list of available exfat drivers is not complete. There is also fuse
implementation widely used [2] and some commercial implementations from
Tuxera [3], Paragon [4], Embedded Access [5] or HCC [6]. As Konstantin
in his email wrote, implementation which he sent should be one used in
their commercial Paragon product.

So we have not 3, but at least 6 open source implementations. Plus more
closed source, commercial.

About that one implementation from Samsung, which was recently merged
into staging tree, more people wrote that code is in horrible state and
probably it should not have been merged. That implementation has
all-one-one driver FAT12, FAT16, FAT32 and exFAT which basically
duplicate current kernel fs/fat code.

Quick look at this Konstantin's patch, it looks like that code is not in
such bad state as staging one. It has only exFAT support (no FAT32) but
there is no write support (yet). For me it looks like that this
Konstantin's implementation is more closer then one in staging to be
"primary" exfat implementation for kernel (if write support would be
provided).

[1] - https://github.com/cryptomilk/kernel-sdfat
[2] - https://github.com/relan/exfat
[3] - https://www.tuxera.com/products/tuxera-exfat-embedded/
[4] - https://www.paragon-software.com/technologies/
[5] - http://embedded-access.com/exfat-file-system/
[6] - https://www.hcc-embedded.com/exfat/

-- 
Pali Rohár
pali.rohar@gmail.com
