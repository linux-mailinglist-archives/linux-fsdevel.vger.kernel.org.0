Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76E116E36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLINzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 08:55:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37406 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLINy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:54:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so10768080lfc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9uxu4I2aG27MOoTnJ8z/Gc+bXBbv38WzXCQqN80oRQ=;
        b=YkEHz6Ht9tPJPmOUHoU1jZ9pqGBJnZLL6YkH2ZXKTWeUN5djftfx7q4EUyauaSE0js
         ul8jZy3tcrF2hiAAlS54kqrmBNSR8AI+KGv8HD8Hcy0uUtbAfqLNVlyF0IqbDcGK/FZj
         vTUfe+l4K5NNBSZGW2q5Eejwu8W2FWeDR3dsbOUXfRN32C/+75fzyHuz6mvbAmh9++Gb
         n81I+WhhHF9ohQSY6Fep42R1YXNblyLur+TZrRyNdJfCaus0x6xT14fQ7JtzOtzdlMOI
         mSDkvp/L/rimtXMS/1u6cr6HAPpYZHpt3BxgCADIwnuXaPcbAutZBrRUNWlzyibKMWWr
         RIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9uxu4I2aG27MOoTnJ8z/Gc+bXBbv38WzXCQqN80oRQ=;
        b=s0WWBcNweV+HpqB7JqUm70IpgnfM2+eC/UX0Zjs6chvsXijsqpiwmfC8XA7O8LKwIK
         a7CpgJoUZY8bRavL2+MW6IOI0u8Tb8lF0npMspVYTfLFPvUKOTFxo3RRjdgMbftRAIq3
         Dl/hT9I+bqHi/C+t85S8tvfRUDDv4VqpOozfHIvxLI3arTE9r3u/DYLOSirA6rjgHLuG
         UMqbk+3F8Zb6AkssT31Movzir33riIvKr+s2p6csfIFWefnxSKvvceJMx2misP7cJOBZ
         6pmnMJiIBcPCJOQEUpW7F05wDTm8n9HrN+eF0WQ6AxudXjIfXvqkx8c2zD9j+dsECb6T
         hbBA==
X-Gm-Message-State: APjAAAUiybk3xjdyjkA3mrg5sldnI+QHB38RlI/ysYujX67tYILCs949
        tB9kDzhkk7QWL1yTXCUTEM4FSn9dP2vG/g==
X-Google-Smtp-Source: APXvYqyafX3xzx4CbMOmCIMs7WsCtkpSQE/VomreImTKVIoBq8dgDzEwxngSRlk+slj1m35P34FCyA==
X-Received: by 2002:ac2:41c8:: with SMTP id d8mr11906075lfi.65.1575899696807;
        Mon, 09 Dec 2019 05:54:56 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id m15sm11463355ljg.4.2019.12.09.05.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 05:54:56 -0800 (PST)
Message-ID: <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
Subject: Re: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Dec 2019 16:54:55 +0300
In-Reply-To: <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
         <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-09 at 11:08 +0000, Russell King wrote:
> Despite ADFS timestamps having centi-second granularity, and Linux
> gaining fine-grained timestamp support in v2.5.48, fs/adfs was never
> updated.
> 
> Update fs/adfs to centi-second support, and ensure that the inode
> ctime
> always reflects what is written in underlying media.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  fs/adfs/inode.c | 40 ++++++++++++++++++++--------------------
>  fs/adfs/super.c |  2 ++
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
> index 124de75413a5..18a1d478669b 100644
> --- a/fs/adfs/inode.c
> +++ b/fs/adfs/inode.c
> @@ -158,6 +158,8 @@ adfs_mode2atts(struct super_block *sb, struct
> inode *inode)
>  	return attr;
>  }
>  
> +static const s64 nsec_unix_epoch_diff_risc_os_epoch =
> 2208988800000000000LL;
> +
>  /*
>   * Convert an ADFS time to Unix time.  ADFS has a 40-bit centi-
> second time
>   * referenced to 1 Jan 1900 (til 2248) so we need to discard
> 2208988800 seconds
> @@ -170,8 +172,6 @@ adfs_adfs2unix_time(struct timespec64 *tv, struct
> inode *inode)
>  	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
>  	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
>  	 */
> -	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
> -							220898880000000
> 0000LL;
>  	s64 nsec;
>  
>  	if (!adfs_inode_is_stamped(inode))
> @@ -204,24 +204,23 @@ adfs_adfs2unix_time(struct timespec64 *tv,
> struct inode *inode)
>  	return;
>  }
>  
> -/*
> - * Convert an Unix time to ADFS time.  We only do this if the entry
> has a
> - * time/date stamp already.
> - */
> -static void
> -adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
> +/* Convert an Unix time to ADFS time for an entry that is already
> stamped. */
> +static void adfs_unix2adfs_time(struct inode *inode,
> +				const struct timespec64 *ts)
>  {
> -	unsigned int high, low;
> +	s64 cs, nsec = timespec64_to_ns(ts);
>  
> -	if (adfs_inode_is_stamped(inode)) {
> -		/* convert 32-bit seconds to 40-bit centi-seconds */
> -		low  = (secs & 255) * 100;
> -		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
> +	/* convert from Unix to RISC OS epoch */
> +	nsec += nsec_unix_epoch_diff_risc_os_epoch;
>  
> -		ADFS_I(inode)->loadaddr = (high >> 24) |
> -				(ADFS_I(inode)->loadaddr & ~0xff);
> -		ADFS_I(inode)->execaddr = (low & 255) | (high << 8);
> -	}
> +	/* convert from nanoseconds to centiseconds */
> +	cs = div_s64(nsec, 10000000);
> +
> +	cs = clamp_t(s64, cs, 0, 0xffffffffff);
> +
> +	ADFS_I(inode)->loadaddr &= ~0xff;
> +	ADFS_I(inode)->loadaddr |= (cs >> 32) & 0xff;
> +	ADFS_I(inode)->execaddr = cs;
>  }
>  
>  /*
> @@ -315,10 +314,11 @@ adfs_notify_change(struct dentry *dentry,
> struct iattr *attr)
>  	if (ia_valid & ATTR_SIZE)
>  		truncate_setsize(inode, attr->ia_size);
>  
> -	if (ia_valid & ATTR_MTIME) {
> -		inode->i_mtime = attr->ia_mtime;
> -		adfs_unix2adfs_time(inode, attr->ia_mtime.tv_sec);
> +	if (ia_valid & ATTR_MTIME && adfs_inode_is_stamped(inode)) {
> +		adfs_unix2adfs_time(inode, &attr->ia_mtime);
> +		adfs_adfs2unix_time(&inode->i_mtime, inode);
>  	}
> +
>  	/*
>  	 * FIXME: should we make these == to i_mtime since we don't
>  	 * have the ability to represent them in our filesystem?
> diff --git a/fs/adfs/super.c b/fs/adfs/super.c
> index 65b04ebb51c3..e0eea9adb4e6 100644
> --- a/fs/adfs/super.c
> +++ b/fs/adfs/super.c
> @@ -391,7 +391,9 @@ static int adfs_fill_super(struct super_block
> *sb, void *data, int silent)
>  	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
>  	if (!asb)
>  		return -ENOMEM;
> +
>  	sb->s_fs_info = asb;
> +	sb->s_time_gran = 10000000;

I believe it's not easy to follow what this granularity means. Maybe,
it makes sense to introduce some constant and to add some comment?

Thanks,
Viacheslav Dubeyko.

>  
>  	/* set default options */
>  	asb->s_uid = GLOBAL_ROOT_UID;

