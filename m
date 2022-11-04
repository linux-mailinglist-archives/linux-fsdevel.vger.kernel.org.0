Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF2618D2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 01:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDA0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 20:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKDA0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:26:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02111A10
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667521596; x=1699057596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OY/l0gOXnAD+HMGxqT3s5iBrAc5CDJHwlamXq/buh2w=;
  b=COB5XjrOHaHtqhpr16VlkKihpZq5Z2iNgjuffc79t9ek3g96nMNprqxB
   Dbh7TZDMUV8oMihM2KWV4aZm/L2VHDfD7xTYTb9MzbdaYm8stqu0IBfVM
   YNis39ntzUUyBNLxhsk/cAz1lnZByruapykQLBuScY/OMOzfBsQm8+xLi
   +22xazf7B5MEKzGZKLImRdGxcwyE+7IrfSJ96ctaccvsYEGdxMqFkCG4g
   n09GvGy+zhCqHd+t6AUGhpWX/pw5QT5kNoDtcThpYT+sOzsXE8gPAOJ86
   QC7gfH7ESdB9NcWnIEu17WCLMWdyfcN7Ocv+69nXEBtqx2KLFj/4hvqJR
   A==;
X-IronPort-AV: E=Sophos;i="5.96,135,1665417600"; 
   d="scan'208";a="213738122"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 08:26:35 +0800
IronPort-SDR: zNchagwYrwHYhced+DOsGS19q9GcMGvGpgwg53yxcLaN6p9KNB0Y2OC2DWboU0n1z/g7d3XZNY
 CIAXLjzkMCqdQUeP/WQ9V+0aS8dXFWf6wyJi+Z7E3ywU4kNSDGTFy2JI4wnz59RwzLGNJx2Mx3
 uYVZzsoSaUIfozo58OvqPEu0yEHg4SiI+vUG8pNPIjwZqJdSwnZFGpTFvrSX8o957z5TfHyY6w
 OGuWMN6VfN4hrTf5pHlDwUQGwEFJL7lwH/8q5/MuHslbpFRlxdwvzbvTO1PLK9WAp7ttFOkbXR
 ZUo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 16:45:46 -0700
IronPort-SDR: jNwyWFVYaqyexp06zBJY03cEay3GfQT+r9AcapF89O5ooCeRrKF+Jctd2kLu7xDuNHm6jiTIAl
 eBo0uCCzwr/pyjtezTZLdlCU3LdYTHQUw3jlzzCXeTg8XRkBj63UYGRWncS77iwwKLgVO22TOq
 LFulqGlKGZriF9TwtF6fsQ70kXIJJdFmnGI5JLwvNM8OXZCM+9kXgjoCWTgC4ASFj3Sgku5WCB
 PIBQxkTCIKlT4EYN1/ZZcxjYezYmIZ7OQ8cJ9oPPcasgfL/UCKgFWVj+sXawaZNrR4q7DeK7Wu
 DHg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 17:26:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N3Lyz3YSdz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:26:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667521594; x=1670113595; bh=OY/l0gOXnAD+HMGxqT3s5iBrAc5CDJHwlam
        Xq/buh2w=; b=WH/v5EZUyIr+v+iNaGeFa9D2kULbXnlci/v9THgbg3tXe0jq3Cw
        DP1MCMCV1/OR9ern/fztQte0rUZMng9v2Ny+mRiiNwzmzIJjtSl8WPrsYHXp2GLC
        SaB1eb9rNW92LbQdvDsns6oQBCzUdSEnfuZbyx6wom8LHzGu758OvokxqnwK0MDl
        h/VSZVUvB+pc2Ps9cJRJuywjA/DViNLL2Kynn7c0FMMa7ppHXPPuTpAQRXTyixz0
        Kb+BnQW49EB4FwXgVc7Tfp1VKfhEjcQjXs/ywHa197c14oPFu2MvYu6oWTUPivsb
        An/l6E573kUTtwWlIOsEthoHL7kPJmkQLQA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ju8AtuRY88kq for <linux-fsdevel@vger.kernel.org>;
        Thu,  3 Nov 2022 17:26:34 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N3Lyy2djtz1RvLy;
        Thu,  3 Nov 2022 17:26:34 -0700 (PDT)
Message-ID: <085f1e1f-0810-1850-44d0-2704250799a3@opensource.wdc.com>
Date:   Fri, 4 Nov 2022 09:26:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
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

On 11/3/22 19:32, Johannes Thumshirn wrote:
> When initializing a file inode, check if the zone's size if bigger than
> the number of device zone sectors. This can only be the case if we mount
> the filesystem with the -oaggr_cnv mount option.
> 
> Emit an error in case this case happens and fail the mount.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..605364638720 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1407,6 +1407,14 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	zi->i_ztype = type;
>  	zi->i_zsector = zone->start;
>  	zi->i_zone_size = zone->len << SECTOR_SHIFT;
> +	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
> +	    !sbi->s_features & ZONEFS_F_AGGRCNV) {
> +		zonefs_err(sb,
> +			   "zone size %llu doesn't match device's zone sectors %llu\n",
> +			   zi->i_zone_size,
> +			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
> +		return -EINVAL;
> +	}
>  
>  	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
>  			       zone->capacity << SECTOR_SHIFT);
> @@ -1485,7 +1493,7 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
>  dput:
>  	dput(dentry);
>  
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
>  
>  struct zonefs_zone_data {
> @@ -1505,7 +1513,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  	struct blk_zone *zone, *next, *end;
>  	const char *zgroup_name;
>  	char *file_name;
> -	struct dentry *dir;
> +	struct dentry *dir, *ret2;
>  	unsigned int n = 0;
>  	int ret;
>  
> @@ -1523,8 +1531,11 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  		zgroup_name = "seq";
>  
>  	dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
> -	if (!dir) {
> -		ret = -ENOMEM;
> +	if (IS_ERR_OR_NULL(dir)) {
> +		if (!dir)
> +			ret = -ENOMEM;

It would be cleaner to return ERR_PTR(-ENOMEM) instead of NULL in
zonefs_create_inode(). This way, this can simply be:
		if (IS_ERR(dir)) {
			ret = PTR_ERR(dir);
			goto free;
		}

And the hunk below would be similar too.

> +		else
> +			ret = PTR_ERR(dir);
>  		goto free;
>  	}
>  
> @@ -1570,8 +1581,12 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>  		 * Use the file number within its group as file name.
>  		 */
>  		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
> -		if (!zonefs_create_inode(dir, file_name, zone, type)) {
> -			ret = -ENOMEM;
> +		ret2 = zonefs_create_inode(dir, file_name, zone, type);
> +		if (IS_ERR_OR_NULL(ret2)) {
> +			if (!ret2)
> +				ret = -ENOMEM;
> +			else
> +				ret = PTR_ERR(ret2);
>  			goto free;
>  		}
>  

-- 
Damien Le Moal
Western Digital Research

