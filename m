Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED373E4A28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhHIQow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhHIQov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:44:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1311C061798;
        Mon,  9 Aug 2021 09:44:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x9so22563636ljj.2;
        Mon, 09 Aug 2021 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpEWz534OsgT+S/+zzsUJlMKIuL7cZyoZ2sxdUZSi1o=;
        b=nGfm8WTfRJdlHrYoiLUYviBthJiZMqRMU7uKrvBLgzU8gFJI8dXWaD/ayqAVym74x5
         ozKdgu8Wl76NfVQF2YfA8e/iytRMa9kxRxZA9XsoJNrgFWm73xfWUh2z5yuBW6tMTdTu
         ET0YAcc2eiaODfG588hRRB9+FZjZf7I6iaG3OOJFwPGJJNlI00vswi+QKv2WbhU6n3yX
         fSNfPn0JeZhUQ9nCDq7ZSxhnb7TLeZphT6TPGpkmNG/dV1nwbYS6B5Kb84VLoCshIsOH
         fsjUNy+lfJ/U9QZAYc++gn23QHD8LhUYVHm4/2EHIbxOKOt65bpIq1+0rfth3aDppUUP
         A4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpEWz534OsgT+S/+zzsUJlMKIuL7cZyoZ2sxdUZSi1o=;
        b=XETWEl18ab3Sejbl5d/UKVSxWKIfg8F8giMxBCJc3vdqMY7itGyqolthAJqmqzNgoY
         e247vpaThWf++Y0UKVfJEDRsV67ehTvozoZ6e4QtvVDGP/r4XKFafjW6TrBgOCe2rBNA
         ZGKzYR3iS6NjVg/qARD3ZrMzU0SEMHc6jTODj37LKXXhiMabSpNNGdvmWnfjWQCbrTNO
         W8DroqpcpnO3pZ0DIusF2Vv9Q97j9OZC+R3FAAyVP3Zs4sOmeto5Wb7pr3ZdfAfptFdY
         mZi3rFzBS1tlN7s2hG6N7lhHw8s6SQ3JG1LmxLyYM8NVL6kCs5jjGwlNiDmTvGVfFUuI
         R47A==
X-Gm-Message-State: AOAM5321ysafupxUgZPlxNeAv55SKg6CONCDxQxX/WLDbqB6gOpQCn0G
        kkZbSey8RMXusOBI5vMnveI=
X-Google-Smtp-Source: ABdhPJw7MdzaSJlhLLJ8k/n37LOQtIUuUrruhZEwQusjBzu109XtuZWOvcVYHeH7MsRb0G/s5KW6eQ==
X-Received: by 2002:a2e:a4a7:: with SMTP id g7mr9381926ljm.330.1628527468314;
        Mon, 09 Aug 2021 09:44:28 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id h17sm1784795lfc.191.2021.08.09.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:44:27 -0700 (PDT)
Date:   Mon, 9 Aug 2021 19:44:25 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
Message-ID: <20210809164425.rcxtftvb2dq644k5@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
 <20210809105652.GK5047@twin.jikos.cz>
 <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:16:32PM +0000, Konstantin Komarov wrote:
> From: David Sterba <dsterba@suse.cz>
> Sent: Monday, August 9, 2021 1:57 PM
> > On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
> > > This adds MAINTAINERS
> > >
> > > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > ---
> > >  MAINTAINERS | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9c3428380..3b6b48537 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13279,6 +13279,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
> > >  F:	Documentation/filesystems/ntfs.rst
> > >  F:	fs/ntfs/
> > >
> > > +NTFS3 FILESYSTEM
> > > +M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > +S:	Supported
> > > +W:	http://www.paragon-software.com/
> > > +F:	Documentation/filesystems/ntfs3.rst
> > > +F:	fs/ntfs3/
> > 
> > Can you please add a git tree and mailing list entries?

> Hi David, I'll add the git tree link for the sources to MAINTAINERS in the next patch. As for the mailing list,
> apologies for the newbie question here, but will it possible to have the @vger.kernel.org list for the ntfs3,
> or it must be external for our case?
> Thanks!

Good question and I also do not have absolute truth about it but I try
to help. It should be possible. I think you can request new list from
postmaster@vger.kernel.org

If you need public git tree then kernel.org can maybe provide that. They
also host ntfs so I think no problem with ntfs3. This way you self
do not have to worry public list. But I'm not sure how strict is now
days get account. But if you say that it would be nice that you need
kernel git then maybe someone can help with that.
See more info https://www.kernel.org/faq.html

