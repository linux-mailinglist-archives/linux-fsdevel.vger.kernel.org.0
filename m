Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D031038A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 12:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfKTLXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 06:23:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38565 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfKTLXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:23:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id f7so3983402pjw.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2Xo/a4CE3Y8LwPp0U+2KlzLXKiFkdTHaNAt0710fdc=;
        b=l/kP8sv8rbBonNJD5hfKwtBrBCw261ACJMV1fHVcQI6eYOt80p4FGOcVz4f9hcnqt6
         OznLYjU7zaT84MGfk6rlbz4Ri0l4NKpU48k/ejqZ3GbZq2Oq7IVfPNSnIRSnMxI9L/Hf
         JiGF0x/3sof5R4YkndvPZCO36yesES8MGjAv7O4IfUt2spkEHJ8iG7zcqrYqx9oijjdf
         QGX0Bhc6Sg8sD7B93/+xNoLH7HuV8HWhG01k8ZVhZOI4weyk1l3VCHzolQ5zcu4J6cP/
         0P8CBYnr0fzdo5BPILwAd3tpoInZImFoOwBuK3CDUmsC/FrOecrpjjxYSjX8dnwSD2I/
         Fv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2Xo/a4CE3Y8LwPp0U+2KlzLXKiFkdTHaNAt0710fdc=;
        b=L6ZFbCJg0Kje2EnCi+Zvi4Bc8pQiYmLfywpq2/KYLPJuC51pnreZObHVJEpiEbmwgM
         0gQAl1r35JXEDrO5M++GF51IV36P+Ht7MsqeFSCHPWiA/lOv7S6DHzFoPOYD7v7DePnm
         0RsZwl2IU+PIAZWT+srjPOYd5Xmiqu768Z0/zK4IPy9AMMVRsmb90nupWjO5d9MJDWiM
         veTshYQ+QogoeFaiiVcNs/QoTQK/Hy/oKWGm/OxT+IXLrmlfWsMm0I0VmunclPJSrjaL
         x6n7CKPNu/lMj7wE0cIvkUDDgbdymPy42Pua0uwq7x5DQwlNkj6nDkY58q+x27gbEjI9
         XBmA==
X-Gm-Message-State: APjAAAV/lsirGz3kNnJ2lVD3dVbkX1RcXX8xl4cShKGSh545+uiXdovc
        2NxbKIqLBNBd/Oc7vEdlNGZI
X-Google-Smtp-Source: APXvYqx4Lr40eT5S9gLyG3JOIwZD9HlkuClpOeh6sa+6dH2KgMDPTZuINDIm+9AJ1rLFf+FuLyZrbg==
X-Received: by 2002:a17:90b:908:: with SMTP id bo8mr3493332pjb.1.1574249027381;
        Wed, 20 Nov 2019 03:23:47 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id j4sm7144530pjf.25.2019.11.20.03.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:23:46 -0800 (PST)
Date:   Wed, 20 Nov 2019 22:23:40 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 2/4] ext4: Add ext4_ilock & ext4_iunlock API
Message-ID: <20191120112339.GB30486@bobrowski>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-3-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-3-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:30:22AM +0530, Ritesh Harjani wrote:
> This adds ext4_ilock/iunlock types of APIs.
> This is the preparation APIs to make shared
> locking/unlocking & restarting with exclusive
> locking/unlocking easier in next patch.

*scratches head*

A nit, but what's with the changelog wrapping at like ~40 characters?

> +#define EXT4_IOLOCK_EXCL	(1 << 0)
> +#define EXT4_IOLOCK_SHARED	(1 << 1)
>
> +static inline void ext4_ilock(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		inode_lock(inode);
> +	else
> +		inode_lock_shared(inode);
> +}
> +
> +static inline void ext4_iunlock(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		inode_unlock(inode);
> +	else
> +		inode_unlock_shared(inode);
> +}
> +
> +static inline int ext4_ilock_nowait(struct inode *inode, unsigned int iolock)
> +{
> +	if (iolock == EXT4_IOLOCK_EXCL)
> +		return inode_trylock(inode);
> +	else
> +		return inode_trylock_shared(inode);
> +}

Is it really necessary for all these helpers to actually have the
'else' statement? Could we not just return/set whatever takes the
'else' branch directly from the end of these functions? I think it
would be cleaner that way.

/me doesn't really like the naming of these functions either.

What's people's opinion on changing these for example:
   - ext4_inode_lock()
   - ext4_inode_unlock()

Or, better yet, is there any reason why we've never actually
considered naming such functions to have the verb precede the actual
object that we're performing the operation on? In my opinion, it
totally makes way more sense from a code readability standpoint and
overall intent of the function. For example:
   - ext4_lock_inode()
   - ext4_unlock_inode()

> +static inline void ext4_ilock_demote(struct inode *inode, unsigned int iolock)
> +{
> +	BUG_ON(iolock != EXT4_IOLOCK_EXCL);
> +	downgrade_write(&inode->i_rwsem);
> +}
> +

Same principle would also apply here.

On an ending note, I'm not really sure that I like the name of these
macros. Like, for example, expand the macro 'EXT4_IOLOCK_EXCL' into
plain english words as if you were reading it. This would translate to
something like 'EXT4 INPUT/OUPUT LOCK EXCLUSIVE' or 'EXT4 IO LOCK
EXCLUSIVE'. Just flipping the words around make a significant
improvement for overall readability i.e. 'EXT4_EXCL_IOLOCK', which
would expand out to 'EXT4 EXCLUSIVE IO LOCK'. Speaking of, is there
any reason why we don't mention 'INODE' here seeing as though that's
the object we're actually protecting by taking one of these locking
mechanisms?

/M
