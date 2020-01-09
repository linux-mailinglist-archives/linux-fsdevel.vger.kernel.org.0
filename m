Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE761359A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgAIM7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 07:59:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIM7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:59:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so7255340wre.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AqcxbkOCLbfDGGIInlBZRcRWhCGcmVCvEWgZGtv+if8=;
        b=M88clX48Uvwaj7ZXu3/zfnStjWcfKQSElwKGjq1LJDP07OYAGfRCc9WT6OF8IskYI3
         HlD9WxxQ+mU/hQqbVvoVifaWuJJi0h/mVp6zbsdOW8bMTUyuHH/sDqz1VX9nqU2yqGub
         t8oLnBOlUGNlZikzTlYSE3XrxOjsIsl5TAiwgtuCmxBIutsTKCK1kYJb7EWX4G8s/fRo
         BltF70mNVvnKo5+/dLX7yiUrSePkkl8/wz/MCzcbV3Up0+GbXn0OS1JZOJzQTP9uQIlR
         rixGEdVpK3dFjVFpGyQ6a3SU/C3tRRdAwxiqAx6oZVH4h5e5H1SfXdInsuV2XiDGW1xa
         zLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AqcxbkOCLbfDGGIInlBZRcRWhCGcmVCvEWgZGtv+if8=;
        b=Wwu+CT5cWGH8RMsznz//wSGfe9saqosaLS9knBYIVBOze/k6E3WmLk78l9iZZLe+jG
         v4vhyOf58FefH6k6uhc/6K9UL9LqZvNzbpy2z6j5DtC+C7IWugrQYIUaxLDGpkJ/k+ai
         03OpzpkH3TJTM6jkjdJMlKmz6MjIckJnpwCYrgKfwkvshJM6BtvLNELRqHxeqWjBGN70
         zww1b6hXlx52GHwpg7doKgpkC7OdzdOYtUz5q8tVpJaw0C72ZqFm+r4bPWQH6GAWkOpm
         yjziNedxeOiBHZJdGvOzllzP8ObjxbEv57ZonnmgyY8wB/tNtdu+qNLwxo2xpFGFGb5k
         aCHg==
X-Gm-Message-State: APjAAAXaLMMVhuTr/Npf2gMWJgrwfmeAH44yp5IYHFCoN4t1wdoVNTAG
        sARhGwJPtYk16WhFRoTE61EmFLR6
X-Google-Smtp-Source: APXvYqxGuXO+U4b3JDzXE0XFTn+4lLQng4bldMt0gs1oMT28nCQERPNKqIRmUw7evk7c45p/Ev7gBg==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr10705591wrs.222.1578574772656;
        Thu, 09 Jan 2020 04:59:32 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n187sm2853402wme.28.2020.01.09.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:59:31 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:59:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] udf: Fix free space reporting for metadata and
 virtual partitions
Message-ID: <20200109125931.bewmdj65vqmpv5mw@pali>
References: <20200109125330.2023-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109125330.2023-1-jack@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 09 January 2020 13:53:30 Jan Kara wrote:
> Free space on filesystems with metadata or virtual partition maps
> currently gets misreported. This is because these partitions are just
> remapped onto underlying real partitions from which keep track of free
> blocks. Take this remapping into account when counting free blocks as
> well.
> 
> Reported-by: Pali Rohár <pali.rohar@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

> ---
>  fs/udf/super.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2d0b90800519..5a4a6fb36819 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2492,17 +2492,29 @@ static unsigned int udf_count_free_table(struct super_block *sb,
>  static unsigned int udf_count_free(struct super_block *sb)
>  {
>  	unsigned int accum = 0;
> -	struct udf_sb_info *sbi;
> +	struct udf_sb_info *sbi = UDF_SB(sb);
>  	struct udf_part_map *map;
> +	unsigned int part = sbi->s_partition;
> +	int ptype = sbi->s_partmaps[part].s_partition_type;
> +
> +	if (ptype == UDF_METADATA_MAP25) {
> +		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
> +							s_phys_partition_ref;
> +	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
> +		/*
> +		 * Filesystems with VAT are append-only and we cannot write to
> + 		 * them. Let's just report 0 here.
> +		 */
> +		return 0;
> +	}
>  
> -	sbi = UDF_SB(sb);
>  	if (sbi->s_lvid_bh) {
>  		struct logicalVolIntegrityDesc *lvid =
>  			(struct logicalVolIntegrityDesc *)
>  			sbi->s_lvid_bh->b_data;
> -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
>  			accum = le32_to_cpu(
> -					lvid->freeSpaceTable[sbi->s_partition]);
> +					lvid->freeSpaceTable[part]);
>  			if (accum == 0xFFFFFFFF)
>  				accum = 0;
>  		}
> @@ -2511,7 +2523,7 @@ static unsigned int udf_count_free(struct super_block *sb)
>  	if (accum)
>  		return accum;
>  
> -	map = &sbi->s_partmaps[sbi->s_partition];
> +	map = &sbi->s_partmaps[part];
>  	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
>  		accum += udf_count_free_bitmap(sb,
>  					       map->s_uspace.s_bitmap);

-- 
Pali Rohár
pali.rohar@gmail.com
