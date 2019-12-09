Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDF116F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLIOuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:50:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59324 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726522AbfLIOuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575903016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmXv5r+jYXphY7BscO2smGv5aBXrs+fMMrRQn1IS66s=;
        b=TjxSg61EfD3gLj53JH44aLGAXVwUZczH8Pa6DL81zINORypwv4Fd9D3u3CCsqA8Oiijw8+
        nsVWpehN14Lb7dLKHsmP0aVFcYI6TiTHlXO2wqj3HX1exW1xdjd4riTiZjEk0SOqsKW/EQ
        ytNPKQtFJS+HF51cuDaTKrdmJD8CeAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-8AOHaACzNHykRZiTyBwvQg-1; Mon, 09 Dec 2019 09:49:10 -0500
Received: by mail-wm1-f72.google.com with SMTP id p5so3062377wmc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 06:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LTG1mZGmZ9hcbwqZAQIUO+xcTEzvZOPY6N77kDf6jfs=;
        b=enRbGko1uH3o7FgwpkXG7C4xqhimedvr6CuuA7s/G1B0LCYQE+l54/MPkQr7CRngHN
         Eg+R6Dt2g8TcrB79UnoatttHSWnYKy1Agbyb9RE0RGHfX73RA1A43nuZTypW9sgy6mZz
         /5mNlkLXWuK/JnoLgMnSW5alaA3PTHSXAv3qiSVrkWi4d8HcPkVEH5KjnHu/Msm1pXXz
         qcK6VPGfkKgRTknZmAIBvom/y6oJXZohy3xb9doGd4llOa9pNPGMd+AX3Jlh7EL2jNWh
         lkGJRDfrXZjhfRec7EJA21fSlAe8/02VvFLcQM33dp7i19G2zn3c34MJKN7SeN4ALtrf
         5DqQ==
X-Gm-Message-State: APjAAAU63MI/FIK9wIsf0un2hI2xjdP3hirOvSoBJSkxaFt9L/rLs4Ip
        GByT4/yZRnDgSI4kxXPk0V0zD2bUO/f2YFxYc9kBSjFT2YOnH9KVMA0LIDQ/yA9X6JzAgPCiZWm
        A9AmvWjtWRE8rbVlzZLjuIDuE2Q==
X-Received: by 2002:adf:f108:: with SMTP id r8mr2640092wro.390.1575902948959;
        Mon, 09 Dec 2019 06:49:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeyuo2wJ8z5YlI5WtkiEPJHJQh87qKQlY3/8QtSaJHx1DoZzLAqxIrGtET/Y+H06nEwDhd7A==
X-Received: by 2002:adf:f108:: with SMTP id r8mr2640058wro.390.1575902948744;
        Mon, 09 Dec 2019 06:49:08 -0800 (PST)
Received: from orion (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id k4sm14506803wmk.26.2019.12.09.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:49:08 -0800 (PST)
Date:   Mon, 9 Dec 2019 15:49:06 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix Sphinx documentation warning
Message-ID: <20191209144906.u3hllhe5ekkqsvva@orion>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <bd3c7d7e-2859-06b0-a209-7d19f7c2e79f@infradead.org>
MIME-Version: 1.0
In-Reply-To: <bd3c7d7e-2859-06b0-a209-7d19f7c2e79f@infradead.org>
X-MC-Unique: 8AOHaACzNHykRZiTyBwvQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 08, 2019 at 08:14:36PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Fix Sphinx documentation format warning by not indenting so much.
>=20
> Documentation/admin-guide/xfs.rst:257: WARNING: Block quote ends without =
a blank line; unexpected unindent.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> ---
>  Documentation/admin-guide/xfs.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good, you can add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

>=20
> --- linux-next-20191209.orig/Documentation/admin-guide/xfs.rst
> +++ linux-next-20191209/Documentation/admin-guide/xfs.rst
> @@ -253,7 +253,7 @@ The following sysctls are available for
>  =09pool.
> =20
>    fs.xfs.speculative_prealloc_lifetime
> -=09=09(Units: seconds   Min: 1  Default: 300  Max: 86400)
> +=09(Units: seconds   Min: 1  Default: 300  Max: 86400)
>  =09The interval at which the background scanning for inodes
>  =09with unused speculative preallocation runs. The scan
>  =09removes unused preallocation from clean inodes and releases
>=20

--=20
Carlos

