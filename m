Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9283338E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCJJgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 04:36:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhCJJfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:35:40 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lJvFj-00086w-DD
        for linux-fsdevel@vger.kernel.org; Wed, 10 Mar 2021 09:35:39 +0000
Received: by mail-ed1-f72.google.com with SMTP id o15so8102817edv.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 01:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftVdUr9F7AHKavJWsV/WnPi5WDLeKje7PJ4qiKh1hck=;
        b=kmNjP9Qnuu5fkvQ5hQh5k57TnlhmRg1pnwLpnW4XjRpk3GK4u2HhuYHkmksh3GGb4e
         Q69fVF9S2zKHO/F5prtg9wtSgJcQKbyG8flo/xpdP7wOP0GmnNAUoJHm9NZMgRDD32nf
         5+d47SDnfDdchqDiPId/6ovDrRB37VW/NCgY47nbeoP06XB5+2Y/F4QDkABfzCOevBFj
         u028Z+aFCJEGEovbRck+/VoYk9jAvC18Am9lTPTwFwDatMSS4mHKJKWMQykkfH+BeMx1
         KXZo8GRcZQ7sh0k89E4K2WYizLplpDt0Kiw0FfuNMweuZl8lZdBpg7Twrh+osF9TpwOh
         AeZg==
X-Gm-Message-State: AOAM533EIScCIgFx8j70P1gmOADSSocfxk7nV+lLF8d/IlZymZclh7i6
        7kiniCsiEAPe574jI7BA4nbvLHeKYgCM36upQEuybaZKGV5VOrEnzVBV6iVp4mJ61bOahOjiId0
        SeN6ZUhqu+NNaLTDp2n61USdWfLY0tEmWeUWY4spraiE=
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231946edt.249.1615368938786;
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKM4jWVMgAtlSQkiU252tjiKuhRmDMSNYvDzZOnsMhIIvOmtcr+xfyqFDOCgMHfGsUcv8k2Q==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr2231923edt.249.1615368938641;
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id dg26sm10364101edb.88.2021.03.10.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:35:38 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:35:37 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Message-ID: <20210310093537.7azjgcywllkda7lg@gmail.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:41PM +0100, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
