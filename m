Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF484872
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfHGJMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 05:12:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36717 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfHGJMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:12:38 -0400
Received: by mail-ed1-f52.google.com with SMTP id k21so85510540edq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nm/CVpS0exds9S1t4nWNC1vnmbGqdR6hZB4ZrhJrLSo=;
        b=cC8MgZv0NS3TrVVFDYZZQTTFor28vZGq0vVngR6ZxacVoNmwXtSZjnO5OGS5b/Svp3
         Ji/E7VuoSjETjqVuE2h5szAHs5cYcFDmhL6vsAyVM0BajGduIhpA6phyZTGPJtsC9Yhg
         VYhMsLhU1/V1W0aUOSqQ9wLnp+emFioZ2ngArllSzMGDNuBP/N/ZNIjQllZqEuAxbPIm
         FzZFcnYYHzVaXgyWwoBFTZNsol1/uEnKUAolUUlR2L2t1SAMoUMbm49Nny7KF/ZREXVq
         izBf3Ix7MoVproMxcqWqk69ToUaxBD3CgD1YsS33yKEYIg1WqHVpLV5O31RritW4txqx
         MJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nm/CVpS0exds9S1t4nWNC1vnmbGqdR6hZB4ZrhJrLSo=;
        b=bHJuaQNTNscOnGRAsWQeqcEJttakfpg4FgFgYUxEJ8GjUA38YHWqn8tWFtbSedHtFb
         FWRMve6WBofrmyzv/mKJ5PEk68Zg8tNmp3PkchAyDIzcJmzu2dHVh38ilfGKm2BMt0Hg
         gCrxl/4UcdrSCtDrI1yF7eb1VnNW7rEnoMPSOh6Pa6rKooGSElMLkRYHzeAGdwq1Jwpd
         LgoG6ZQq0oZiWbZ7HTQgpjItJ1GJqFqZG/GQGDZKpc+6qJeI5Yj1r99jtVOCaa3LI41x
         OEhBTjywJCbcYks4aBU55+4h+DgUMHAp8kmLI/xqzlc58VDqon6oHvi8tY8RsVHUOIqN
         xX/g==
X-Gm-Message-State: APjAAAVxxA4LYmSHpghrZ3wbzNmlj9ZqPEbIajWKRRBBM+8GaFNuIyWr
        c49XdPiun9B6It730M80Rus=
X-Google-Smtp-Source: APXvYqyM2zRX8PL/kFcM6MXS7vsInVEhpCP6DZAmJIaPJDSyxqd4Wr739fwV6r6VOycbMnxdI+Iwcw==
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr8294553edq.124.1565169157178;
        Wed, 07 Aug 2019 02:12:37 -0700 (PDT)
Received: from GEERT-PC (82-217-81-70.cable.dynamic.v4.ziggo.nl. [82.217.81.70])
        by smtp.gmail.com with ESMTPSA id k11sm20199041edq.54.2019.08.07.02.12.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 02:12:36 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:12:34 +0200
From:   Geert Custers <geert.aj.custers@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [fuse-devel] fuse zero copy
Message-ID: <20190807091234.GA4907@GEERT-PC>
References: <20190805101351.GB21755@GEERT-PC>
 <CAJfpegvAtnTLNfmKCR_5a7sesP3DRy_1yp4o1S=8W=9iKr5teQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvAtnTLNfmKCR_5a7sesP3DRy_1yp4o1S=8W=9iKr5teQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Actually it is being worked on.   Attaching the current
> proof-of-concept kernel patch for this.
> 
> I don't have a patch for libfuse yet, as I'm testing new ideas with a
> dummy filesystem that does raw /dev/fuse access.  Also attached, needs
> to be run with "-m" to enable the file mapping mode.

I looked at the patch and proof of concept filesystem. I imagine the
libfuse bindings would be relatively simple for this, something like a
fuse_map_fd(), fuse_unmap_fd() and then a map() in the fuse_ops struct.

> To make this more useful, the kernel would need to cache the mapping,
> so it doesn't need to issue a MAP request on each read.  That would
> also optimize the case of long extents, or files mirrored completely
> from an underlying filesystem (as done by the test program).

I have some spare time so I could write some patches for libfuse and try
add caching of the mapping on the kernel side. Maybe you can let me know
your thoughts on what this would look like, so we are on the same page.

Thanks,
Geert
