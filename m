Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03ACA842F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfIDNMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 09:12:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41250 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDNMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:12:53 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so2639785ioh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=D5+6p8WKki8bdeiP7IsS1mocY3fBV5t3woAf8hzPtLs=;
        b=XV/0phGJRu/p/srS3puWnA4JMqVro4A8B3nSDmbwhu9mx/UyOnPBw8vzqvizQ8GpMG
         u7kerkpHWrcW00SuyakTLEF5IQZHaiQ9btjSmUp11wGqNWDjDSLard28ZfrK2bSphvCn
         +Pi1rYjPBeft7/7YpBXWoAvdGJKpx3AtMNylQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D5+6p8WKki8bdeiP7IsS1mocY3fBV5t3woAf8hzPtLs=;
        b=DUyMNMJxfNpg5Blgm5Mo2cxYAoiJxXylBiiadi+dqC7nGlqMQbFQ/R3EEBAJTj75h2
         PVE6u5ZaV16LAhnrx68zlWxm9kWVaDlQIfJbSuI5qpAifgraGMulgSFzgBqryaTWqRFu
         /JMhbILflRkYoNOYfKHIo2XDQ7TscFGPpPtgz7OKaXADHMxEM1vTq4EwH/mGeLL8YHOx
         2uCcljoH9WrmCIBR2MRq7RSZktbgwXki+p0cCh5zI504j5Lo8uHaxMwTMEadyDNV0kxY
         1zlwtaC001olWgLLSQ3ZXQbtt6FDJUBY+MX93+4KzRHNxrL07nbBXSxRkwKSGqlK47Yq
         IhBg==
X-Gm-Message-State: APjAAAVKDCPtlpCSlB6mY5rQNN5g9qSf6AL1dIRqz9QsxmL0DvKROXSn
        T8rdqCmXk3fg+Y5ggBrduUTT5osu6hQ=
X-Google-Smtp-Source: APXvYqy7cuGRPfgX1rVe7CewtJm/fM912MQeBqoWsPSnZVPGItpkTdAR7NrSA6q5OzqGd399sSbTlw==
X-Received: by 2002:a5d:9c0b:: with SMTP id 11mr2791763ioe.192.1567602771937;
        Wed, 04 Sep 2019 06:12:51 -0700 (PDT)
Received: from [10.10.7.153] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id k21sm18085877iob.49.2019.09.04.06.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 06:12:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] udf: Verify domain identifier fields
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
References: <20190829122543.22805-1-jack@suse.cz>
 <20190829122543.22805-2-jack@suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <f260ecfb-271d-6533-06c5-1de25c462501@digidescorp.com>
Date:   Wed, 4 Sep 2019 08:12:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829122543.22805-2-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan -

Tested-by: Steven J. Magnani <steve@digidescorp.com>

Reviewed-by: Steven J. Magnani <steve@digidescorp.com>

On 8/29/19 7:25 AM, Jan Kara wrote:
> OSTA UDF standard defines that domain identifier in logical volume
> descriptor and file set descriptor should contain a particular string
> and the identifier suffix contains flags possibly making media
> write-protected. Verify these constraints and allow only read-only mount
> if they are not met.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/udf/ecma_167.h | 14 +++++++++
>   fs/udf/super.c    | 91 ++++++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 78 insertions(+), 27 deletions(-)
>
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index 9f24bd1a9f44..fb7f2c7bec9c 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -88,6 +88,20 @@ struct regid {
>   #define ENTITYID_FLAGS_DIRTY		0x00
>   #define ENTITYID_FLAGS_PROTECTED	0x01
>   
> +/* OSTA UDF 2.1.5.2 */
> +#define UDF_ID_COMPLIANT "*OSTA UDF Compliant"
> +
> +/* OSTA UDF 2.1.5.3 */
> +struct domainEntityIDSuffix {
> +	uint16_t	revision;
> +	uint8_t		flags;
> +	uint8_t		reserved[5];
> +};
> +
> +/* OSTA UDF 2.1.5.3 */
> +#define ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT 0
> +#define ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT 1
> +
>   /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
>   #define VSD_STD_ID_LEN			5
>   struct volStructDesc {
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index a14346137361..42db3dd51dfc 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -94,8 +94,8 @@ static int udf_remount_fs(struct super_block *, int *, char *);
>   static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
>   static int udf_find_fileset(struct super_block *, struct kernel_lb_addr *,
>   			    struct kernel_lb_addr *);
> -static void udf_load_fileset(struct super_block *, struct buffer_head *,
> -			     struct kernel_lb_addr *);
> +static int udf_load_fileset(struct super_block *, struct fileSetDesc *,
> +			    struct kernel_lb_addr *);
>   static void udf_open_lvid(struct super_block *);
>   static void udf_close_lvid(struct super_block *);
>   static unsigned int udf_count_free(struct super_block *);
> @@ -757,28 +757,27 @@ static int udf_find_fileset(struct super_block *sb,
>   {
>   	struct buffer_head *bh = NULL;
>   	uint16_t ident;
> +	int ret;
>   
> -	if (fileset->logicalBlockNum != 0xFFFFFFFF ||
> -	    fileset->partitionReferenceNum != 0xFFFF) {
> -		bh = udf_read_ptagged(sb, fileset, 0, &ident);
> -
> -		if (!bh) {
> -			return 1;
> -		} else if (ident != TAG_IDENT_FSD) {
> -			brelse(bh);
> -			return 1;
> -		}
> -
> -		udf_debug("Fileset at block=%u, partition=%u\n",
> -			  fileset->logicalBlockNum,
> -			  fileset->partitionReferenceNum);
> +	if (fileset->logicalBlockNum == 0xFFFFFFFF &&
> +	    fileset->partitionReferenceNum == 0xFFFF)
> +		return -EINVAL;
>   
> -		UDF_SB(sb)->s_partition = fileset->partitionReferenceNum;
> -		udf_load_fileset(sb, bh, root);
> +	bh = udf_read_ptagged(sb, fileset, 0, &ident);
> +	if (!bh)
> +		return -EIO;
> +	if (ident != TAG_IDENT_FSD) {
>   		brelse(bh);
> -		return 0;
> +		return -EINVAL;
>   	}
> -	return 1;
> +
> +	udf_debug("Fileset at block=%u, partition=%u\n",
> +		  fileset->logicalBlockNum, fileset->partitionReferenceNum);
> +
> +	UDF_SB(sb)->s_partition = fileset->partitionReferenceNum;
> +	ret = udf_load_fileset(sb, (struct fileSetDesc *)bh->b_data, root);
> +	brelse(bh);
> +	return ret;
>   }
>   
>   /*
> @@ -939,19 +938,53 @@ static int udf_load_metadata_files(struct super_block *sb, int partition,
>   	return 0;
>   }
>   
> -static void udf_load_fileset(struct super_block *sb, struct buffer_head *bh,
> -			     struct kernel_lb_addr *root)
> +static int udf_verify_domain_identifier(struct super_block *sb,
> +					struct regid *ident, char *dname)

The latter two can be 'const'.

>   {
> -	struct fileSetDesc *fset;
> +	struct domainEntityIDSuffix *suffix;
>   
> -	fset = (struct fileSetDesc *)bh->b_data;
> +	if (memcmp(ident->ident, UDF_ID_COMPLIANT, strlen(UDF_ID_COMPLIANT))) {
> +		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
> +		goto force_ro;
> +	}
> +	if (ident->flags & (1 << ENTITYID_FLAGS_DIRTY)) {
> +		udf_warn(sb, "Possibly not OSTA UDF compliant %s descriptor.\n",
> +			 dname);
> +		goto force_ro;
> +	}
> +	suffix = (struct domainEntityIDSuffix *)ident->identSuffix;
> +	if (suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT) ||
> +	    suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT)) {
> +		if (!sb_rdonly(sb)) {
> +			udf_warn(sb, "Descriptor for %s marked write protected."
> +				 " Forcing read only mount.\n", dname);
> +		}
> +		goto force_ro;
> +	}
> +	return 0;
>   
> -	*root = lelb_to_cpu(fset->rootDirectoryICB.extLocation);
> +force_ro:
> +	if (!sb_rdonly(sb))
> +		return -EACCES;
> +	UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
> +	return 0;
> +}
>   
> +static int udf_load_fileset(struct super_block *sb, struct fileSetDesc *fset,
> +			    struct kernel_lb_addr *root)
> +{
> +	int ret;
> +
> +	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set");
> +	if (ret < 0)
> +		return ret;
> +
> +	*root = lelb_to_cpu(fset->rootDirectoryICB.extLocation);
>   	UDF_SB(sb)->s_serial_number = le16_to_cpu(fset->descTag.tagSerialNum);
>   
>   	udf_debug("Rootdir at block=%u, partition=%u\n",
>   		  root->logicalBlockNum, root->partitionReferenceNum);
> +	return 0;
>   }
>   
>   int udf_compute_nr_groups(struct super_block *sb, u32 partition)
> @@ -1364,6 +1397,10 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
>   		goto out_bh;
>   	}
>   

FYI just a little above this there is a 'BUG_ON(ident != TAG_IDENT_LVD)'
that would probably be better coded as 'ret = -EINVAL; goto out_bh;'

> +	ret = udf_verify_domain_identifier(sb, &lvd->domainIdent,
> +					   "logical volume");
> +	if (ret)
> +		goto out_bh;
>   	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
>   	if (ret)
>   		goto out_bh;
> @@ -2216,9 +2253,9 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
>   		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
>   	}
>   
> -	if (udf_find_fileset(sb, &fileset, &rootdir)) {
> +	ret = udf_find_fileset(sb, &fileset, &rootdir);
> +	if (ret < 0) {

Consider making the "No fileset found" warning conditional on ret != -EACCES,
it's a little confusing to see this in the log:

   UDF-fs: warning (device loop0): udf_verify_domain_identifier: Descriptor for file set marked write protected. Forcing read only mount.
   UDF-fs: warning (device loop0): udf_fill_super: No fileset found

>   		udf_warn(sb, "No fileset found\n");
> -		ret = -EINVAL;
>   		goto error_out;
>   	}
>   

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

