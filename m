Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0223627CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiKNLpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiKNLpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:17 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAE22288
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668426282; x=1699962282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IT/2L3OdUzIphKmGsTXkoNLVFahG8vHvm2cYiMC5dM8=;
  b=XNiJKmk0Cls1OsMpnOlsJ0NVn7GBJJK5KiICacvSATfAArSGSjGYZKid
   IORnT/8FYtevRDui/0f77BZMn/1aiVy/axkvBvVqn6KtTbCmawOGTBwVt
   3pgOMwxvOV4D+vEJ/cT0ANTEljdvgm5+RlxWwZEy4lkiHYXTjujnHU9Us
   AtQrlOF1LqP1NzTshu2FUry8b22Fkx0OPUiOsJzxVFzAFXhKsgpwfiVeO
   k/gtBAB+6g73chwkxYZk1GMam04YXJgPDiM8/j4pxUQOdqdHfnSTY3aHl
   iJzCc4CdoTTzlsAhFTvCKHCClnnV/tOJOoMrWrvulfmAWx4zNEI/9WqzX
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="328316649"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 19:44:41 +0800
IronPort-SDR: ogp9knxP6M6aQY10TYGgbKYXtiJS5SKZt75U8145Gyi29Zu6epkRWP+navQdwPRK4OoYXTdpDD
 UMP8yuC6o34XgY7tYyB9Y6MWFeV4PAi8zJCXYvYtHPe6+b8QSN85BIV+efXGpqB5f85ZQnCExv
 HyS54KA0BESeOgX5Uwi3gIRdeECyn5A8rejiE6T8Pkq6iOSRhfRyTnsGrTdwZuYUhrmgoxL6NF
 HMR7VPyblSDk6mZzNEcO9k6mVaLzH0E7jQm+he0LD+7MLKo3GZHzG3U0H5LAQPhkwmQF9Y+aJM
 UQc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 03:03:40 -0800
IronPort-SDR: 1E0fsB+wFw9iary3pBhVlIdA2du6guBd3E6oW1MdPfjAfXMLYj0vqeS+tW/I5Bhc8YVz12Q0b2
 BzZsLA3dtWRRZqABbowl/d0RPFWKr+v8x/yUNpC3wHyuNMsEjXRtxvwXe4sgFxxiayKH6YfWJ/
 egmuxoqB5bAluaqd0s0EoJhx58ug2iKHw+vA7SN8RvKZVhQ2a0pEqUJ7tCajHsgkCT0MMxf2JO
 08LqiaBiEJkcSaQD2O0QjQKMzSHHuXA22eiHtpx2CZEHrBh7NMZESYmZsY7VouZJXx+f6RXo5y
 DCs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 03:44:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9nXn5G0Sz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668426281; x=1671018282; bh=IT/2L3OdUzIphKmGsTXkoNLVFahG8vHvm2c
        YiMC5dM8=; b=XlIBTCLlW2aedkUSFEy7IfDxLhWcKxKb3WWk6bsJxZZa+hydhwI
        MQsdxNuxJmRWBv9r3ya1WXwuXBfrAjUnftkR2x3dsBbGboYfpl/35eqQotwcZNZd
        FsXt4zQW8ijSyuJ8O4PUXzQvhVXrHDklPdT8yt8bKtb+La6EU0ai99y+rQeqZE/b
        q2optIAjcskI6aggI88GriL20FasRBOj0ng8mST6HeEvA9YtWFodZVV/hIXxAbPB
        I3HOIQpFAYMIDKfgs4Na4U9wvyMWSBuf1E6AvTLrr1UPPSHKh0j5DX7islEqyfaL
        6RuolVwG7HX+oQFPW8p/n/2RRokKZYOE2Kg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LSzidTK2IXPd for <linux-fsdevel@vger.kernel.org>;
        Mon, 14 Nov 2022 03:44:41 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9nXn0188z1RvLy;
        Mon, 14 Nov 2022 03:44:40 -0800 (PST)
Message-ID: <d9376665-7295-8d75-d35f-7e4f63c22cdd@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 20:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] zonefs: add sanity check for aggregated conventional
 zones
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <fe0e42b533442766d941740697cd8e33fcad99ad.1668413972.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fe0e42b533442766d941740697cd8e33fcad99ad.1668413972.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/22 17:19, Johannes Thumshirn wrote:
> When initializing a file inode, check if the zone's size if bigger than
> the number of device zone sectors. This can only be the case if we mount
> the filesystem with the -oaggr_cnv mount option.
> 
> Emit an error in case this case happens and fail the mount.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - Change IS_ERR_OR_NULL() to IS_ERR() (Damien)
> - Add parentheses around 'sbi->s_features & ZONEFS_F_AGGRCNV' (Dan)
> ---
>  fs/zonefs/super.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..143bd018acd2 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1407,6 +1407,14 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	zi->i_ztype = type;
>  	zi->i_zsector = zone->start;
>  	zi->i_zone_size = zone->len << SECTOR_SHIFT;
> +	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
> +	    !(sbi->s_features & ZONEFS_F_AGGRCNV)) {
> +		zonefs_err(sb,
> +			   "zone size %llu doesn't match device's zone sectors %llu\n",
> +			   zi->i_zone_size,
> +			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
> +		return -EINVAL;
> +	}
>  
>  	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
>  			       zone->capacity << SECTOR_SHIFT);
> @@ -1456,11 +1464,11 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
>  	struct inode *dir = d_inode(parent);
>  	struct dentry *dentry;
>  	struct inode *inode;
> -	int ret;
> +	int ret = -ENOMEM;
>  
>  	dentry = d_alloc_name(parent, name);
>  	if (!dentry)
> -		return NULL;
> +		return ERR_PTR(ret);
>  
>  	inode = new_inode(parent->d_sb);
>  	if (!inode)
> @@ -1485,7 +1493,7 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
>  dput:
>  	dput(dentry);
>  
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
>  
>  struct zonefs_zone_data {
> @@ -1523,8 +1531,8 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  		zgroup_name = "seq";
>  
>  	dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
> -	if (!dir) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(dir)) {
> +		ret = PTR_ERR(dir);
>  		goto free;
>  	}
>  
> @@ -1570,8 +1578,9 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  		 * Use the file number within its group as file name.
>  		 */
>  		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
> -		if (!zonefs_create_inode(dir, file_name, zone, type)) {
> -			ret = -ENOMEM;
> +		dir = zonefs_create_inode(dir, file_name, zone, type);

This one is for file inodes but you are overwriting dir, which will
totally mess things up for the next file inode to create.

> +		if (IS_ERR(dir)) {
> +			ret = PTR_ERR(dir);
>  			goto free;
>  		}
>  

-- 
Damien Le Moal
Western Digital Research

