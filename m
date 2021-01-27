Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA1306198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhA0RKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 12:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhA0RJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:09:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4EC061574;
        Wed, 27 Jan 2021 09:08:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q12so3647989lfo.12;
        Wed, 27 Jan 2021 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJ6Ur9hcDviwQHaKnDtCPzQn/MdiIMBckVUEHQL/w4I=;
        b=dGz+nqcGvTuNQ8TXS9mgIk1S3l9FYZE6qNyuL6oL9eLRgCjcPfEY4x5qO5YpkqFzKP
         WKYRyGsUE/V/eMQ687tX43nBkBNanWsNmiHMXUTeJeIDM3jB69y/JSVvlfZjZ7o6lu34
         yb1tB/wT2VwVuY4TTIw5Ygg/WiWx/cCq3/69U+PWUjFaHLZqehBu2/Ww8BUulpioCqOn
         n+zCniN2fe02oyVwPnX4JpqPXfogbqPizKuxHjPt18uw93so5xNTBUfvgkRMpg1lzs0j
         mB6DZP7FAYYBF93fZaGwEmZGFEy3oKiOp4xiQeH7POWKdBnxy1BK7rgIagBymn0m+FJY
         +QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJ6Ur9hcDviwQHaKnDtCPzQn/MdiIMBckVUEHQL/w4I=;
        b=RJ6RZ1kIe4+7K6TbLMw/MvcTKAX4IFpXPEyC6AREQurOAY+ZWagmtR5W4iaclK5az4
         cHIY4BfPnnYpIlVQ+CfH0NmppRZsFczrNfgnIKgFmSzHu5mREyrHfKA3/ydvy5yB5Psy
         sYL1ABnnruwA6rvEuiw5tgKa+loKvKoSrOrXIHcWm4kMW6g1fk+F7syYirStIRc5eXO2
         4MrZ9ZktALSI6Pt1n+Vh8l1b4Y7st6mlwPi8hWQ0bFvf6w760iMY74mmB4kj/jXaCbSA
         lf2EIllRR3k8IwYDg/T/BxyJ4gmN8XuuvIuf2SHZhNj8F/BUa1a879QWPTXrBNEITR9M
         9qIQ==
X-Gm-Message-State: AOAM530+/D82uAe2ZjYDK8abFuU3kd1paVQXhp8eTQ5pRq0+k5Soy5u1
        VG9bjLL8satef++kSjcT/sytAM/xqG8=
X-Google-Smtp-Source: ABdhPJxxXy6EDu3WqWWY9lhTNbrbTYIi9WJqjht6HGLibrH6mYMj7NTQHPf8k8U2QfwFxQCDJCMYQA==
X-Received: by 2002:a19:341:: with SMTP id 62mr5218949lfd.500.1611767311866;
        Wed, 27 Jan 2021 09:08:31 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id h4sm603742lfe.268.2021.01.27.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:08:30 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:08:28 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
Message-ID: <20210127170828.eydoe7didip7pukr@kari-VirtualBox>
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:58:05PM -0800, Amy Parker wrote:
> This patch updates inode.c for EFS to follow the kernel style guide.

> +++ b/fs/efs/inode.c
> @@ -109,9 +109,9 @@ struct inode *efs_iget(struct super_block *super,
> unsigned long ino)
>        /* this is the number of blocks in the file */
>        if (inode->i_size == 0) {

Still has { here so you didn't even compile this? Also I think you
should make one patch for whole EFS. Just change one type of thing at 
ones. Like

[Patch 1/X] fs/efs: Remove braces from single statments
[Patch 2/X] fs/efs: Add space after C keywords 
[Patch 3/X] fs/efs: Fix code indent levels 

That way it is super easy to review them. Also because there is no
maintainer it is kind of scary to accept patches. Specially when lot of
different kind of things are changed. 

Please also send your patches against cover letter. If you have problem
with your email client plese take a look git send-email. This will work
beautiful for all of this.

And because you are new (i think). Welcome.
