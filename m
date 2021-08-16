Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41B13ECCF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 05:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhHPDEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 23:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhHPDEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:04:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA3C061764;
        Sun, 15 Aug 2021 20:03:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u22so451781lfq.13;
        Sun, 15 Aug 2021 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UagkBO5dswM1A7N/GzHlKRMWthTHW5ve4NkRn5WU5fM=;
        b=OJVfAWKUqcnkopr/6j3qy9w8O6+JfjlMVq/VBqZGvI/h17ShVWEu8o6VqJeZR6NgAq
         WRZuxkOEZrSgsI2xafwHgriZseIAezM2oHHrsjMpqLZHW5MgtZDWZnYcNwHqngEwSjP9
         ZqKgN2UBFKXBYovxwcmF1BDfSDhnraPs8CokzYX47wQ6Qh8UMjsO9G0dINgxnoPokb/6
         PvoDdhNKpEnW/G1yBNo6hjkfDQkHrovCAnnzASLHQQbMpXUO94WAM1pFVIicNNnBi4LP
         6t1erJru6F8Stb9aFbMuYRG7KRjicPUIILihO7ZVzg8Z9iGNaWQaDDRpujpWw8QJ+XrK
         GZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UagkBO5dswM1A7N/GzHlKRMWthTHW5ve4NkRn5WU5fM=;
        b=UuPHMNXyOXTIvVzQGvQejiJEwcLQsvh+HX6SY0i57nptxYHr5bMovQg+Pcs0gmX+iC
         EWlDVET0O/BIcqmQK2J2+9RNW/QCH2gVgT0TgKtxe1RIDyFydkCilnZ5TuijSrmAXm7O
         01vMBgPtCL0m8I8lZNHIBRpGTztnmTm63fRxvO0OW7YgDWDZ+XaQ+9muvQ7rPMuyWUym
         LUKui8jfHyO3VyYXu3HVwarlQ0YIC/yGYOfTYViQLFT5swHjrNOoZd4pjRldE6KThJpe
         5zeRF1fw9zxukR8YbD5sX5CFkT3tynGz2Z+onhCGklhghboX33Ud/y4a840eMDUms+rl
         RqTg==
X-Gm-Message-State: AOAM532hbtQeCCIMUCoUSeV6IgMuy8S3VMHO3iSJAe29ZvKNkByjuVuj
        Ckym5xiJLBdfZ2hQGci/y3Q=
X-Google-Smtp-Source: ABdhPJylRB53Yr/AWRJ9H48QfdHep+FldPT22PKddb4Evv1U/zWMpElywPYtV+fT3wLGvz2tqRptZw==
X-Received: by 2002:ac2:505a:: with SMTP id a26mr1701151lfm.56.1629083030632;
        Sun, 15 Aug 2021 20:03:50 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m4sm1019379ljq.96.2021.08.15.20.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 20:03:50 -0700 (PDT)
Date:   Mon, 16 Aug 2021 06:03:48 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/4] fs/ntfs3: Use new mount api and change some opts
Message-ID: <20210816030348.tjws4ce3uvn6qben@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-1-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As I screw up subject with this one I resend this with replay.

On Mon, Aug 16, 2021 at 05:46:59AM +0300, Kari Argillander wrote:
> This series modify ntfs3 to use new mount api as Christoph Hellwig wish
> for.
> https://lore.kernel.org/linux-fsdevel/20210810090234.GA23732@lst.de/
> 
> It also modify mount options noatime (not needed) and make new alias
> for nls because kernel is changing to use it as described in here
> https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/
> 
> I would like really like to get fsparam_flag_no also for no_acs_rules
> but then we have to make new name for it. Other possibility is to
> modify mount api so it mount option can be no/no_. I think that would
> maybe be good change. 
> 
> I did not quite like how I did nls table loading because now it always
> first load default table and if user give option then default table is
> dropped and if reconfigure is happening and this was same as before then
> it is dropped. I try to make loading in fill_super and fs_reconfigure
> but that just look ugly. This is quite readible so I leave it like this.
> We also do not mount/remount so often that this probebly does not
> matter. It seems that if new mount api had possibility to give default
> value for mount option then there is not this kind of problem.
> 
> I would hope that these will added top of the now going ntfs3 patch
> series. I do not have so many contributions to kernel yet and I would
> like to get my name going there so that in future it would be easier to
> contribute kernel.
> 
> Kari Argillander (4):
>   fs/ntfs3: Use new api for mounting
>   fs/ntfs3: Remove unnecesarry mount option noatime
>   fs/ntfs3: Make mount option nohidden more universal
>   fs/ntfs3: Add iocharset= mount option as alias for nls=
> 
>  Documentation/filesystems/ntfs3.rst |   4 -
>  fs/ntfs3/super.c                    | 391 ++++++++++++++--------------
>  2 files changed, 196 insertions(+), 199 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
