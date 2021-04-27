Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3736CC44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhD0UaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhD0UaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:30:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891EC061574;
        Tue, 27 Apr 2021 13:29:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k127so5771334qkc.6;
        Tue, 27 Apr 2021 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4JAGxs8XMH4cgbEY2coprv1buFuT3aNXaxuK/OKjg/I=;
        b=Dr4IHQ7R5yATBaw/jvIFtTEK4ZDaKFp5maPIhqMD4UYxqyzLvB51veD/xZ4q0ufzzo
         6OIIi3Bs6GsparVPVIbDbYvCf0YhdM2RijzhU0hgBf9fy1qoRAzQzc+ayOsDGXdAOAIT
         MYT8tW3Sohym+v1aNecQj2QStzS0gWUn4aBHLvXW3dQ27t94QuOcpfMEjaVetQnP78pV
         dqbhZFqHZPSFerNbrR/NznDHtikrMDjnMBQqn8K4gp+UcFipMDS9dQR7cnu2yC5/JsF0
         8AfoUqBTpFAq7ToHn49ckQ5EeUrRBxHjTlFSWGhUkpfmWzV8Co97X/6RTOjizB+aYIXY
         pTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4JAGxs8XMH4cgbEY2coprv1buFuT3aNXaxuK/OKjg/I=;
        b=aTyXeBgQcjKOMJg6tNGlqT/HW9WmPGfbdK9msjiHWP7RXoy3l18GBZTHtgZz21/7+p
         58yfDMQW2O4nxOK3PaX1nsy+5yFD5WavWZ+tBeDgUpzuaQW+rQT58SX2qCftbw7hHNTV
         oZxxZ96L0Irb3Dl29ircrZ4qvzfat0xG4Eu3t1HUcmIHcdK20tHNE4w23UFMHm1U2/cI
         L6/en4qIaMENPMsjO+fma1ZaWAF6LUAVkA8aBUda6i/dEsU523Ea4BnJY4jA4wJZVfCg
         SZLJDwFx+6K0wOw/xpirdxLvadGNwiAcy9pjz+LLCWsJT5F0lqbgkK8RXvRfnGwGif7D
         cz+Q==
X-Gm-Message-State: AOAM533hsLyF4XlA/yyXEro8mzsUiWoIAnwiwTJRNYS1b1/j3No7Bj46
        YzsHPgxPxf9YZxn8FlTDPz9Z5k5Vyb5a
X-Google-Smtp-Source: ABdhPJxaja4PEd3AxTIwUcbEeFLoiPRA87hLno1AEvaYsXemKhUkLpZGAOYY79/Fpm0mo4rEJzVrrQ==
X-Received: by 2002:a37:8c9:: with SMTP id 192mr4977022qki.130.1619555368109;
        Tue, 27 Apr 2021 13:29:28 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d207sm3491087qke.59.2021.04.27.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 13:29:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:29:23 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/3] Use --yes option to lvcreate
Message-ID: <YIh0Iy+BiY4zzhB1@moria.home.lan>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-4-kent.overstreet@gmail.com>
 <20210427170339.GA9611@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427170339.GA9611@e18g06458.et15sqa>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 01:03:39AM +0800, Eryu Guan wrote:
> On Tue, Apr 27, 2021 at 12:44:19PM -0400, Kent Overstreet wrote:
> > This fixes spurious test failures caused by broken pipe messages.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > ---
> >  tests/generic/081 | 2 +-
> >  tests/generic/108 | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/081 b/tests/generic/081
> > index 5dff079852..26702007ab 100755
> > --- a/tests/generic/081
> > +++ b/tests/generic/081
> > @@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> >  # (like 2.02.95 in RHEL6) don't support --yes option
> > -yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> 
> Please see above comments, we use yes pipe intentionally. I don't see
> how this would result in broken pipe. Would you please provide more
> details? And let's see if we could fix the broken pipe issue.

If lvcreate never ask y/n - never reads from standard input, then echo sees a
broken pipe when it tries to write. That's what I get without this patch.
