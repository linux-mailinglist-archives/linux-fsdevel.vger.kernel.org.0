Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8E3ED7A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhHPNkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbhHPNjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:39:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676ADC061155;
        Mon, 16 Aug 2021 06:19:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d4so34302643lfk.9;
        Mon, 16 Aug 2021 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4xjy2k/+Hr19yNQ4XBrfvelrlltpvX1jEjhtBSNo+VM=;
        b=EI1iN9/WimUKqzMZTG8PvwiDfzmpgSiLseyzGHdfhYt30zb02LS8FhQjawjCw73REI
         bl5A9GD8GeVHAeYpp1nxWJ6mRUe3NTRFrAFXiPfvhaBLJ9UtdbLACNWRi4HR8msEo0yW
         6bC7HZ33/ZP+D48JF3+jxrfdLiCAeur61DLOzjgTgdczQFFxScEQOeW8KLHSlPb2i9IN
         tzHXCtyx6wWQgnklo4WlXgjPhqbUIx22Tcc2qkkRYTZ89n7zQImRUErYbVkeLUW/ydXo
         edWkV56Ed2nCo9btO4zlWnQE950IUo5j7dr+/3tW4A0/+7hl35wyChYN8jzwFWB7Q/OR
         UWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xjy2k/+Hr19yNQ4XBrfvelrlltpvX1jEjhtBSNo+VM=;
        b=qNeyDKWUZ2hEfcF2XKZ9L5pmm8oU0d4kDJAxWO5z5oN2ffGInYEVqqIwl0OHW3oz6J
         fylFkJk4gaDry/5rV3aTpIRZFt1sRvL76fqkVeyk8s6kzZNAKV4j75IPF5y1ch7lNblN
         mERaSsw3MQj+rFVcC6xGQQj2OfAl0/y26eaZFGtdmQ479TzqGzI5P3gX4m9fI4D8psYr
         WTNnPwis6A521sNuVifaBw2JAmKWqu7eC34AtftoR7bDmM8AL7MNov1n8Jl8y6i22BVf
         kH6a9/VQzqxoXdqgz0y11OgYZ+Oy2xwk8cjIXMrXbjY7BbOGRKuGNBKB32GnqFumCnJ7
         y/CA==
X-Gm-Message-State: AOAM5310RujQ1b8q/knINNL5qH3Ad75Ph3dHa18HpNMnynRVv8NiDkNE
        gzZ5+d1apidsAfWG90XbTr0=
X-Google-Smtp-Source: ABdhPJy/UQO+uCDnyVfenOBhD7j6LKkn57XI/lwxIEuysHSGfmkvQ7BHpIXw0NbJ9cgQ0wTusKLw6g==
X-Received: by 2002:ac2:5192:: with SMTP id u18mr11820985lfi.527.1629119975363;
        Mon, 16 Aug 2021 06:19:35 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id v1sm921776lfg.106.2021.08.16.06.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:19:34 -0700 (PDT)
Date:   Mon, 16 Aug 2021 16:19:32 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816131932.ri2fpog5tncd4xbt@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-2-kari.argillander@gmail.com>
 <20210816032351.yo7lkfrwsio3qvjw@kari-VirtualBox>
 <20210816121752.GA16815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816121752.GA16815@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:17:52PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 06:23:51AM +0300, Kari Argillander wrote:
> > > Nls loading is changed a little bit because new api not have default
> > > optioni for mount parameters. So we need to load nls table before and
> > > change that if user specifie someting else.
> > > 
> > > Also try to use fsparam_flag_no as much as possible. This is just nice
> > > little touch and is not mandatory but it should not make any harm. It
> > > is just convenient that we can use example acl/noacl mount options.
> >  
> > I would like that if someone can comment can we do reconfigure so that
> > we change mount options? Can we example change iocharset and be ok after
> > that? I have look some other fs drivers and in my eyes it seems to be
> > quite random if driver should let reconfigure all parameters. Right now
> > code is that we can reconfigure every mount parameter but I do not know
> > if this is right call.
> 
> Reconfiguring non-trivial mount parameters is hard.  In general I'd
> recommend to only allow reconfiguring paramters that
> 
>  a) have user demand for that
>  b) you know what you're actually doing.
> 
> Something like the iocharset clearly isn't something that makes sense
> to be changed.

I will probably do this series so that nothing can be changed but that
there will be easy way to enable changing in code. So after I can send
small patch which will enable changing and I can test each option
separately. 

If Konstantin can comment if there is some parameters which have real
demand then I will of course implement those.

Thanks for comments.

