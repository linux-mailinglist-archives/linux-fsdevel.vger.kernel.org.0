Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29D51408B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAQLNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:13:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52559 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQLNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:13:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so7050699wmc.2;
        Fri, 17 Jan 2020 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qFTk+qkvssr9/lPwmpPoe3V1diPdn3Y+j3Sr4+YpcMg=;
        b=Wa4jPA9CwV2uSVDyVxMRrFgqcQ8egcUvKSmig8qQDCwYy6AHSD0E5Oadr/XOXnX/nV
         sHlCNPycJaMq5bvoyvcDw2jjgHCpkExwjuDqGRb739aXMDi0J/40N2eNR2NfMEKQdBVm
         5gXQV4FrrqMY5hPpEAkDwbTD50o1h4stxFOVnDcyuMRglmLrM4ciFybaOCWb6ZeUnK+V
         Z7cNrVtd2GpIn1/EblYQjROB6mglIBAXUpu7H+T4Ya245atVx/hMEPBtvJ+CkKba1OV6
         VrLap5xZTNpBQPPSsec+wUwGh9c4TAbDtskHwkF+HDjSrfZ6157CAdRZyeJ9rXqnsO04
         LmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qFTk+qkvssr9/lPwmpPoe3V1diPdn3Y+j3Sr4+YpcMg=;
        b=a5aX6Q1UL7kt8Fgs7xxhCYi8hlCowA7As+9dresFY9saay3qrJyv6gFHu7jLC+b0CK
         wWYGB83bwJnfQWeIrOh2CD3FC15sxtpQDQNSSnlvh9/s4TNIKTygtIgZicBzPDx++IiX
         xMHs4byRgF+55132nc3L3i4o9cthG+7WYYVRB/+OKvx/a5hUy0KKhwE00sf0ErbeRbJ7
         DsOknXImwvP2aI609aJDPp8Ixrc2TWsSsoqXqrJ6KS/Wms1DntL3KB98Q6aQbXg/fYxY
         DVjWlS4T/VauOLb58ePP6GmgEYCuBzdcpyFmR3KyR3UtE898C1RlNPsaKVOolT4z4rDG
         6vSw==
X-Gm-Message-State: APjAAAUyCJT90TM8Y5RBPdbm4GwVjEhPCjHV8WgCRrJhJ6CgvkHyetpB
        f2GQHDEvKZRgwzjTwlkkj8LRRV1Z
X-Google-Smtp-Source: APXvYqwW6HwTc7jDhAgRED/9uDvOlPHI5SiDM36Kn7Jlrnfv45wr/hLJpAQXQULapHcXHegqXM+1rw==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr4211019wmm.180.1579259624393;
        Fri, 17 Jan 2020 03:13:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d8sm34241132wre.13.2020.01.17.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:13:43 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:13:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 04/14] exfat: add directory operations
Message-ID: <20200117111342.nijcivt4z6io6xtt@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082821epcas1p3db1f70cf53185c40934c3a754c65e648@epcas1p3.samsung.com>
 <20200115082447.19520-5-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115082447.19520-5-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 17:24:37 Namjae Jeon wrote:
> This adds the implementation of directory operations for exfat.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/dir.c | 1244 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1244 insertions(+)
>  create mode 100644 fs/exfat/dir.c
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> new file mode 100644
> index 000000000000..81a95557a6a3
> --- /dev/null
> +++ b/fs/exfat/dir.c

...

> +/* read a directory entry from the opened directory */
> +static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
> +{

...

> +	while (clu.dir != EXFAT_EOF_CLUSTER) {
> +		i = dentry & (dentries_per_clu - 1);
> +
> +		for ( ; i < dentries_per_clu; i++, dentry++) {
> +			ep = exfat_get_dentry(sb, &clu, i, &bh, &sector);
> +			if (!ep)
> +				return -EIO;
> +
> +			type = exfat_get_entry_type(ep);
> +			if (type == TYPE_UNUSED) {
> +				brelse(bh);
> +				break;
> +			}
> +
> +			if (type != TYPE_FILE && type != TYPE_DIR) {
> +				brelse(bh);
> +				continue;
> +			}
> +
> +			dir_entry->attr = le16_to_cpu(ep->dentry.file.attr);
> +			exfat_get_entry_time(sbi, &dir_entry->ctime,
> +					ep->dentry.file.create_time,
> +					ep->dentry.file.create_date,
> +					ep->dentry.file.create_tz);

Hello, here is missing processing of create_time_ms entry. I think that
exfat_get_entry_time() should be extended to take (optional) time_ms
parameter. time_ms is only for create_time nad modify_time (not for
access_time).

> +			exfat_get_entry_time(sbi, &dir_entry->mtime,
> +					ep->dentry.file.modify_time,
> +					ep->dentry.file.modify_date,
> +					ep->dentry.file.modify_tz);

Similarly there is missing processing of modify_time_ms entry.

> +			exfat_get_entry_time(sbi, &dir_entry->atime,
> +					ep->dentry.file.access_time,
> +					ep->dentry.file.access_date,
> +					ep->dentry.file.access_tz);
> +
> +			*uni_name.name = 0x0;
> +			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
> +				uni_name.name);
> +			exfat_utf16_to_nls(sb, &uni_name,
> +				dir_entry->namebuf.lfn,
> +				dir_entry->namebuf.lfnbuf_len);
> +			brelse(bh);
> +
> +			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
> +			if (!ep)
> +				return -EIO;
> +			dir_entry->size =
> +				le64_to_cpu(ep->dentry.stream.valid_size);
> +			brelse(bh);
> +
> +			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
> +			ei->hint_bmap.clu = clu.dir;
> +
> +			ei->rwoffset = ++dentry;
> +			return 0;
> +		}
> +

-- 
Pali Rohár
pali.rohar@gmail.com
