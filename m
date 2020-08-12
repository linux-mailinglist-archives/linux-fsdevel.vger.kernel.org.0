Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A289B242E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHLRXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:23:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B060C061383;
        Wed, 12 Aug 2020 10:23:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so2096384qto.2;
        Wed, 12 Aug 2020 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1/lSRDVVen4Akj0ArLSHpTeWWjBzyPT/lPcsGI8nVw=;
        b=dFJ4Hzkpz3+oD1F3BYZ++5nv2ELEguPwduttYcpO1TmDrzJuM9Ax88Q79LrVI8bY5T
         ztlS80pGOR3RNeVGI+aJwJVw/s6i3L7vzx2gpE8EqA0TBKcfIwNMlH7RgMxGbN9W7+kl
         0YiS7cWhlEEfudI/HDdLT8nnRL7SdDmV2bhMP2cDGc3UKjou0/0dfmbqmgdibZaO3wU0
         9jMJ/97QpQJURODplJipq3Oo6vOsr5Fv8Sj9yJtLoTXX2i2PNpzJrU+gDXxm9o/drWMZ
         XcVA0E1RwH8ce3jYImuE6NWeigHLURnv7ZdNqGUMQdyWYQ5Jxqkf5lil3GiOvTVlsSLA
         kIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1/lSRDVVen4Akj0ArLSHpTeWWjBzyPT/lPcsGI8nVw=;
        b=UhT8Xr3y4FbRhsWXfcysmEOs3sNtYIOb8Qfk4AnjfeTxojFG5DTXLqRIhVDuKGfbQP
         ogQvJEVtnk2VQK/oZGWyz/py9o7Zn4P0QlyXhg2wt0VapThdNcC/YtxGtQnqkkcNcGGE
         I5rrOxMRBkwJn+7qJ0T+zA7H1LcDNGce8bHvYoqTY3nbOdYDojYZqYrI09cWsKYVSaWO
         kpY1y5arDuMPCnDq9ladrR+4RllJMmpN9yvqBKFwJd2h9JaiX9J9yptCFeGOfKUikPmC
         IBJm+UnbroODNsA/H7hsWInmw89P0UZgM5GoLzmRVauwnJ0fTKzU/ER1yEpNTUalptEh
         7XYQ==
X-Gm-Message-State: AOAM533aImqqPGnoBtDkcUknHvTbpp5ovR1/g+6TjeFmP1Vv4ZW/FF/W
        LGqN5ZxRdm38VmZ/NM26Jw==
X-Google-Smtp-Source: ABdhPJwBXCZnKid7yfKC88qAPcPezTXpTDi6LExmqjV/8+GD1684vmXYr/g16EHecwgYqZTah22aFA==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr756292qtp.44.1597253017585;
        Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id i14sm3140849qtq.33.2020.08.12.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
Date:   Wed, 12 Aug 2020 13:23:35 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812172335.GA897567@PWN>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
 <20200812085904.GA16441@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812085904.GA16441@kadam>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 11:59:04AM +0300, Dan Carpenter wrote:
> Yeah, the patch doesn't work at all.  I looked at one call tree and it
> is:
> 
> hfs_mdb_get() tries to allocate HFS_SB(sb)->ext_tree.
> 
> 	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
>                     ^^^^^^^^
> 
> hfs_btree_open() calls page = read_mapping_page(mapping, 0, NULL);
> read_mapping_page() calls mapping->a_ops->readpage() which leads to
> hfs_readpage() which leads to hfs_ext_read_extent() which calls
> res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
>                                          ^^^^^^^^

Thank you for pointing this out! I will try to come up with a better way
to fix it.

Peilin Ye

> So we need ->ext_tree to be non-NULL before we can set ->ext_tree to be
> non-NULL...  :/
> 
> I wonder how long this has been broken and if we should just delete the
> AFS file system.
> 
> regards,
> dan carpenter
> 
