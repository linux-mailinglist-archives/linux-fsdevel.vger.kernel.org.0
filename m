Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4120B3F1736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhHSKYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:24:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06532C061575;
        Thu, 19 Aug 2021 03:23:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so10706451ljn.1;
        Thu, 19 Aug 2021 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s7gzHcAvUGRal7zGjfCj1tvyGgqr2i8nXDn4Q3sKzQk=;
        b=Mfyx9RZf49s53j40JmyfZM1lJWT/tSB5dUUVPbPQyL1z9vJPwL8wxRbIWIw1ek9N3P
         FCdsucQWgjUO4i8U/uWO19zPjJzxYSv3B0ps89+KpLOFQzlQyZ6Q7gYJ2o5hH9x7boZK
         0hHxub5elRpkprNhLwVf8Z35OTkvNjcpWTknPnUzIBddpJWPGpp3zCNq/CF6jdEH4/1D
         csNUXhEd/S70aZEY370wZybpR4RAhznZFB5p5DHOjaZ2WPdH7bCuyDoZ+Tfjryp/J9k9
         jYZ0Z5Ysn3Bx4t7gZi58GygFNtApzoSEW/Ha01maSBtlbczhdiMyi5YMIFmIRLeiyk2A
         QqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s7gzHcAvUGRal7zGjfCj1tvyGgqr2i8nXDn4Q3sKzQk=;
        b=rq44BOmXdILfAJyNIXRVziPFsFyEf6MyOAiWUrtctZxBarDUYDiFMlCs6AFtWoaFZM
         XurCopVlNQ9Ctra5OD60OugOSRmiw9M0y7M9Wxx1iF24FZaAM7CrOxh/pg46huBncVe/
         NK4I45+x4FBYy0cirFUSPh5GgtMYkLJGUb2Hs+ByIi/eSqcf6iJJTE3qutZxkxAhCIFY
         eeia/Xz4EaGL7x0xtg8b2JicI/5S/AjoX3v/ubtqv2iQKYSWIr4rgYnfiluXF48EK1r/
         wM+E5HDQ/JhwlcjKmudv7QS550nLl9KPLQo5RJG16bGbzOwg1E1cgs+IxXnglYzIIuvY
         oyGQ==
X-Gm-Message-State: AOAM532/UDrVrTakUDyD4YuUYLUq18nC4VSfHSLHxicVTZ6rZD01okNE
        F7uKYCMiOQSaeYLgsSRUIMQ=
X-Google-Smtp-Source: ABdhPJwBC3AtCQaaRJLeMqncG4o7h0yRkRo3Vd0w10HmGYffhLah81Cfn2ICXXTq/oY9pVnTwY2K2Q==
X-Received: by 2002:a2e:2f1c:: with SMTP id v28mr11179313ljv.476.1629368625379;
        Thu, 19 Aug 2021 03:23:45 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i21sm262452lfc.92.2021.08.19.03.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:23:44 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:23:42 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 05/20] ntfs: Undeprecate iocharset= mount option
Message-ID: <20210819102342.6ps7lowpuomyqcdk@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
 <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
 <20210819081222.vnvxfrtqctfev6xu@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819081222.vnvxfrtqctfev6xu@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 10:12:22AM +0200, Pali Rohár wrote:
> On Thursday 19 August 2021 04:21:08 Kari Argillander wrote:
> > On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > So mark iocharset= mount option as preferred and deprecate nls= mount
> > > option.
> >  
> > One idea is also make this change to fs/fc_parser.c and then when we
> > want we can drop support from all filesystem same time. This way we
> > can get more deprecated code off the fs drivers. Draw back is that
> > then every filesstem has this deprecated nls= option if it support
> > iocharsets option. But that should imo be ok.
> 
> Beware that iocharset= is required only for fs which store filenames in
> some specific encoding (in this case extension to UTF-16). For fs which
> store filenames in raw bytes this option should not be parsed at all.

Yeah of course. I was thinking that what we do is that if key is nls=
we change key to iocharset, print deprecated and then send it to driver
parser as usual. This way driver parser will never know that user
specifie nls= because it just get iocharset. But this is probebly too
fancy way to think simple problem. Just idea. 

> Therefore I'm not sure if this parsing should be in global
> fs/fc_parser.c file...

