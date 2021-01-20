Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F12FCB67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 08:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhATHVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbhATHVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:21:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF676C061575;
        Tue, 19 Jan 2021 23:20:50 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f11so24863813ljm.8;
        Tue, 19 Jan 2021 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkwpiRhcbAY/Xrd8puZlohXc8HqWP1iUu7DJdV7kfmc=;
        b=aVGobaf0ycMJLbgf0f4UyuTWvrUUAtp+mY6iFDdZLI0xMORlP8OBvXhnIwMJOvQmDc
         /5yFMUMMES0ORDIsRLMzhQB+N3CxQg0+1LG9j0fd04TFKMiabxZwdaoWLPaMYvC8yFb4
         7FYFunesP6et8SvXL0Pc9Ct4nyLdVgNQziDmNHkf0Tio88KsA6Xfm+zyA9CchhsGzo0f
         ifcVABwBKo/7Cbx1eNzMq1M+5OJw1bySGd9d1TFba81CyTFBaMlE5/tjMQFENCDxCGfI
         ks09hALb3xSpNfkgurG6gmNiS8313eGyPwUNpRI6Wlln/NnVXiDvYwkewrIHVpn7qcnd
         c7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkwpiRhcbAY/Xrd8puZlohXc8HqWP1iUu7DJdV7kfmc=;
        b=O+fDc2rxjFlq0z7uhAN7I+meYsXghFsX+gofs1uD6yOTywN0MQOpgblpqwfrYGwvjN
         ShWA50m1Z59Rbdca0klEG5d5WbHew9xcPLnIXkZxaIu6kShDZXRXV+wPIt/QLBQAyqCH
         3ZvZWyekRsvtOwwOJf2+FU510MNxstGPXr5llErv+Lndcw6Ehcf6eT5axrBX/5W94CXq
         0iuD6Wdv9vlWLKMcZoYnV9Ksuu+WiFV8UtCE2vWf/DoIy3cNTn3009M7hxaHdCQzSE9v
         EBdmqCNxqhRzDN9y9KRGQjdELU0PukGtzKCv/fYLte0FGGi+vs1jf+CiPcWhOm3oHAsh
         sCRw==
X-Gm-Message-State: AOAM531mJfnMfOAzpQBVT6FSXaINpCluFWiDQWlUbMxy8eeP0UzP2AX8
        sPEHpVCyUW5mm7ZfbM6ovyA=
X-Google-Smtp-Source: ABdhPJyc6hbY0x8yj+/thIn/8laQ02tnHOZuDloG7PvHASPSyzPfEzks74VFN5SJkJOpuLpvdZaUog==
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr2741420ljp.269.1611127249385;
        Tue, 19 Jan 2021 23:20:49 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id j2sm120324lfe.134.2021.01.19.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 23:20:48 -0800 (PST)
Date:   Wed, 20 Jan 2021 09:20:46 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210120072046.p26xlv33ul4lr2vs@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
 <20210119040306.54lm6oyeiarjrb2w@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119040306.54lm6oyeiarjrb2w@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:03:06AM +0200, Kari Argillander wrote:
> On Thu, Dec 31, 2020 at 06:23:53PM +0300, Konstantin Komarov wrote:
> > diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c

> > +struct ntfs_fnd *fnd_get(struct ntfs_index *indx)
> > +{
> > +	struct ntfs_fnd *fnd = ntfs_alloc(sizeof(struct ntfs_fnd), 1);
> > +
> > +	if (!fnd)
> > +		return NULL;
> > +
> > +	return fnd;
> > +}
> 
> This should be initilized. What about that indx. Is that neccasarry?
> Also no need to check NULL because if it is NULL we can just return it. 

Sorry about initilized part. Didn't notice it was kzalloc. Other parts
are still relevent.

