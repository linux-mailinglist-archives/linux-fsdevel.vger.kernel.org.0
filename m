Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B0C3F2399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhHSXTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhHSXTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 19:19:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2395C061575;
        Thu, 19 Aug 2021 16:18:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w20so16352050lfu.7;
        Thu, 19 Aug 2021 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ry+uQ2ze+f23BW9wmso3e2NcNF5MK0mmAGV5/hmmOmo=;
        b=uJ7HeHQontttqIGqQ2NX/14IN/xSl7wiyEI0b6WFZ9B4Dk2KIpd5De3gqj/D4hSwx0
         gRNXb/wxBl6wkYTzjm+KZtVK0roxZgPm8z4Pq1aBHFPH6AjN/buNZ107mIV240blAWzH
         xnfTFqB2fCWp2CG+8vtFP+AeTHM5XXl/CoU91GXHQZ6NWaP7lUV1kIsNh4ck8DBB0o3h
         /FK+6lBKeWsGqNhpFP5rDtQcdaGZbOsPYjsHL9y50TqOaFd9YT6rv0eLFkf0yRt3VKDP
         MBLtq/DxFcyYpau9CLyyDhmfF2txevvNvUwOPdmv5/Ml0CqAmPLH3vycy/XY2IjiQFs0
         MK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ry+uQ2ze+f23BW9wmso3e2NcNF5MK0mmAGV5/hmmOmo=;
        b=O/0vX5e4jUvP+sC3BwkzPtlDSjyT68P8s8n7zzW+OkQrbwqUFWb7VZa7Pt9dmu9DNC
         VaNmSWZa8U/171HOlqPYwAJYMaGsSMg/u+PwmiRtMpzN2WXbjNJfYbUP815gRf0h/mrx
         x5NxemWaGaUHDCTEHJBGefrfXkPh6kv7K2FZW/s4hdrGlvM7jRM/7X4YEo5VhaXLJioB
         FvPjSpfApf0qzvYlYycLmxICli8Qiju8HgiwsANDTci7UXyG1s5FbYTTn6ua4vipMMaC
         rPSZOY9BaIHyW6GpX+pRV9M6s2+3cHATDieD0ZKU3gA0KDCd75LrcuchXPkMcl4WDrvF
         tTSQ==
X-Gm-Message-State: AOAM531YnK3aomrYHkOxAElUMdmf1hzxl3JUvoNFfW0clGh0avUhC19R
        +4sB7U+ReKjD26VFnQVR5WY=
X-Google-Smtp-Source: ABdhPJx87x0dZUPkISoJL4ME1bzX8W9BQeT50/qxq+el9HtXrx76quTuHsUMVVORkAiJcCURiF15WQ==
X-Received: by 2002:a05:6512:22cd:: with SMTP id g13mr12755777lfu.440.1629415116388;
        Thu, 19 Aug 2021 16:18:36 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 3sm381713ljq.136.2021.08.19.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:18:35 -0700 (PDT)
Date:   Fri, 20 Aug 2021 02:18:33 +0300
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
Message-ID: <20210819231833.deyfwq73tbslkizc@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
 <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
 <20210819081222.vnvxfrtqctfev6xu@pali>
 <20210819102342.6ps7lowpuomyqcdk@kari-VirtualBox>
 <20210819220412.jicwnrevzi6s25ee@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819220412.jicwnrevzi6s25ee@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:04:12AM +0200, Pali Rohár wrote:
> On Thursday 19 August 2021 13:23:42 Kari Argillander wrote:
> > On Thu, Aug 19, 2021 at 10:12:22AM +0200, Pali Rohár wrote:
> > > On Thursday 19 August 2021 04:21:08 Kari Argillander wrote:
> > > > On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> > > > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > > > So mark iocharset= mount option as preferred and deprecate nls= mount
> > > > > option.
> > > >  
> > > > One idea is also make this change to fs/fc_parser.c and then when we
> > > > want we can drop support from all filesystem same time. This way we
> > > > can get more deprecated code off the fs drivers. Draw back is that
> > > > then every filesstem has this deprecated nls= option if it support
> > > > iocharsets option. But that should imo be ok.
> > > 
> > > Beware that iocharset= is required only for fs which store filenames in
> > > some specific encoding (in this case extension to UTF-16). For fs which
> > > store filenames in raw bytes this option should not be parsed at all.
> > 
> > Yeah of course. I was thinking that what we do is that if key is nls=
> > we change key to iocharset, print deprecated and then send it to driver
> > parser as usual. This way driver parser will never know that user
> > specifie nls= because it just get iocharset. But this is probebly too
> > fancy way to think simple problem. Just idea. 
> 
> This has an issue that when you use nls= option for e.g. ext4 fs then
> kernel starts reporting that nls= for ext4 is deprecated. But there is
> no nls= option and neither iocharset= option for ext4. So kernel should
> not start reporting such warnings for ext4.

It gets kinda messy. I was also thinking that but if that was
implemented then we could first send iocharset to driver and after that
we print deprecated if it succeeded. If it not succeed then we print
error messages same as always.

I have not look how easily this is can be done in parser.

> 
> > > Therefore I'm not sure if this parsing should be in global
> > > fs/fc_parser.c file...
> > 
