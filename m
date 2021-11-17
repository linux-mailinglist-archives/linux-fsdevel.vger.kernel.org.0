Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809A8454BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhKQR04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKQR04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:26:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB804C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:23:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so5794538pjc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
        b=ugoMYNkhm/G9Ix/5oCvQZm0YAcysEe7w+8Ut7tdQ1MFfrFb++jT//Ye1Xif9z6ocKL
         upYEOlPYxRg426dSTkVWYqWTkYaINK0U1vjW0pz5KiVAdk24VzI9knnC+oq6VqBtR51R
         JsxZQwr6hfjAqg3NR5DXPnxzqFiDdVPzmokHwBWYbFcA7C4C1b/5vK2dlQpMEeU3BunN
         ptnIlMbRnCC/lX9LzDScYnrYijxgLzkCxo7ONiPawkK0khOy+cYFezVV1WUfTrdZx19A
         ia0nC0GD3aEx0ZtVWJVu5+3TyvxHmXgSem7quozm86z+iCZ04tmZvCRneUg4q76UfdBV
         iVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
        b=Gbc2snoM/91kypKKnljllcTsGXnuiDcJAi792J+OCdt6kLJgL9gMO3MtutHKdtcD3F
         yrsPre9SCNGcvqh/IE07BhGS1Km4PeIu102J/WY1OcX11ByGR2nC4O6LaR/TcFxANA8r
         6jmn6JbA5tfCA6DVXqo8EyXBd6wyHkXNViiHs/RWcofNqLTYzQjMrOEhPjVO6yorlVHO
         NL7jzw1GqmdFIeXm5dz71eqI8Lb83FxdCxkF7zEBHa/L7Zagj2UlSfnameAfY0kagyTz
         dXEFqs/cS/iJS73WBhgfc+DIAtmdB89i2uEIpHnT/fT9WmZh8Xe8rzl1oNGRQhdKCpK5
         49dQ==
X-Gm-Message-State: AOAM531qspkERIYkKWiKRFu7SCKeSpGdpIFdcahTi1zeS4ybk5gefNXY
        rWxVNY3DGKgN05LR6XpDx3h2/WYwSoY7Gv/1nuEw/g==
X-Google-Smtp-Source: ABdhPJxkIf4IjyDIAL/AOyg+wZo8KXg00Li3POnr9FoL4MtTk7+2uk0M9RLmtvaFQhBaLJ5ZjvKGrbUA1Og0jd55rz0=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr56745818plb.4.1637169837229; Wed, 17
 Nov 2021 09:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-3-hch@lst.de>
In-Reply-To: <20211109083309.584081-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:23:44 -0800
Message-ID: <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The device mapper DAX support is all hanging off a block device and thus
> can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> be built under CONFIG_FS_DAX now.
>

Applied, fixed the spelling of 'dependent' in the subject and picked
up Mike's Ack from the previous send:

https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com

Christoph, any particular reason you did not pick up the tags from the
last posting?
