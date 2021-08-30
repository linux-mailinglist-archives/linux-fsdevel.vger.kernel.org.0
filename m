Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8903FBAAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhH3ROO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3ROM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:14:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CEDC061575;
        Mon, 30 Aug 2021 10:13:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c12so27161300ljr.5;
        Mon, 30 Aug 2021 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUPwfutq3p7gRWJvfB60/NPXvXQ2A50TJJGc7tlQfuw=;
        b=JJT9ce0mfNp3+ygIakwtMiwX+OOwlY3n374crFaEkg5Ussedn1qSooGZCaIky4uC1s
         13bCBCEiwYukyD0Po6kQ7Q4RDPkYe+3BTbcucXlFu783+EFZ5ytc/FQFtalitcZcIwfu
         CK5gpdxfb4+rup74dxxFWBI5KURKN0AoXjSFjw2iFZFqsjoRLDTaENp4CFUgGyNRg9Kj
         nZ8tNl7UGL01OqB2irasylknj2ek8HESvZFx+NGeyP7mhdTbRqNSB1F6xZD00dNVFZlM
         d8aEZLrqy3yAs3RofEur4SKeNKkIlhT/yKfsk+brXoaCAilvXuTSQw+1bEE32mOBnxxI
         m+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUPwfutq3p7gRWJvfB60/NPXvXQ2A50TJJGc7tlQfuw=;
        b=YW6q2atmGEuoHwh1BRqUSXQ7PM5JKW1dEhQzCESQQUJByv3CRB1pR/FOapOPiA+vWk
         YUS7v3Q2J2kcaNDty2Emh4ZNkEBIex+CVkJhsL2AZQoCf4xFbKVd0bdatBuviSD34NU6
         7KCZ6Y6x10lurspyFPG9TAr4ZqBiBtApoFBtbKXUvNEkuFt3M/X9a4llW/qarVwaIxY1
         0DD0j5YZT5KETgjD1BRyf1MLuNZPvu7zAmzOaNaVwW8HCDmEzNpv1Xmv5v2IOzrEpYJN
         QkjaAXKv+RAt6NWAYmTk8udT11DrTIMjYUQQRdehfpwltV/GBFK/n20HythvxrIjG/MY
         XrEQ==
X-Gm-Message-State: AOAM533XHdQCMrGkpDpBBRVqfCR3L6PqgxMcwMnJ3sk7a4ws4DPOsBQa
        4Uz2W0Lwz0CXkdBzVMY67iDETqWOctxXeg==
X-Google-Smtp-Source: ABdhPJymPs3gpej4uKd2UGNXGH7ZX8Tj+PkEwiRTJBibfw29wJu3rmodCV/735hhtIK83N/esjv7KA==
X-Received: by 2002:a2e:1514:: with SMTP id s20mr21972764ljd.34.1630343597104;
        Mon, 30 Aug 2021 10:13:17 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i5sm1908829ljm.33.2021.08.30.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:13:16 -0700 (PDT)
Date:   Mon, 30 Aug 2021 20:13:14 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com, willy@infradead.org,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH] Restyle comments to better align with kernel-doc
Message-ID: <20210830171314.hya2vn3vyohcn4dk@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
 <22f979ec-95e5-e95a-0d58-9eb43f2038aa@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f979ec-95e5-e95a-0d58-9eb43f2038aa@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:10:36PM +0300, Konstantin Komarov wrote:
> 
> 
> On 03.08.2021 14:57, Kari Argillander wrote:
> > Capitalize comments and end with period for better reading.
> > 
> > Also function comments are now little more kernel-doc style. This way we
> > can easily convert them to kernel-doc style if we want. Note that these
> > are not yet complete with this style. Example function comments start
> > with /* and in kernel-doc style they start /**.
> > 
> > Use imperative mood in function descriptions.
> > 
> > Change words like ntfs -> NTFS, linux -> Linux.
> > 
> > Use "we" not "I" when commenting code.
> > 
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > ---
> > Yes I know that this patch is quite monster. That's why I try to send this
> > now before patch series get merged. After that this patch probebly needs to
> > be splitted more and sended in patch series.
> > 
> > If someone thinks this should not be added now it is ok. I have try to read
> > what is kernel philosophy in case "patch to patch" but haven't found any
> > good information about it. It is no big deal to add later. In my own mind I
> > do not want to touch so much comments after code is in.
> > 
> > I also don't know how easy this kind of patch is apply top of the patch
> > series.
> 
> Thanks for the patch. I've applied it to create uniform style of comments.

There where probably lot of merge conflicts as this patch was made for
v27. Also lot of changes since v28 in the code base. You can always ask
submitter to rebase patch and resend. Also there where quite lot of nack
about this patch so I though this should be dropped, but maintainer
decision I guess.

> Also removed double line addition from patch:

Just ask and submitter will do it for you.

> 
> @@ -269,22 +260,28 @@ enum RECORD_FLAG {
>  	RECORD_FLAG_UNKNOWN	= cpu_to_le16(0x0008),
>  };
> 
> -/* MFT Record structure */
> +/* MFT Record structure, */
>  struct MFT_REC {
>  	struct NTFS_RECORD_HEADER rhdr; // 'FILE'
> 
> -	__le16 seq;		// 0x10: Sequence number for this record
> -	__le16 hard_links;	// 0x12: The number of hard links to record
> -	__le16 attr_off;	// 0x14: Offset to attributes
> -	__le16 flags;		// 0x16: See RECORD_FLAG
> -	__le32 used;		// 0x18: The size of used part
> -	__le32 total;		// 0x1C: Total record size
> +	__le16 seq;		// 0x10: Sequence number for this record.
> +	__le16 hard_links;	// 0x12: The number of hard links to record.
> +	__le16 attr_off;	// 0x14: Offset to attributes.
> +	__le16 flags;		// 0x16: See RECORD_FLAG.
> +	__le32 used;		// 0x18: The size of used part.
> +	__le32 total;		// 0x1C: Total record size.
> +
> +	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
> +	__le16 next_attr_id;	// 0x28: The next attribute Id.
> 
> -	struct MFT_REF parent_ref; // 0x20: Parent MFT record
> -	__le16 next_attr_id;	// 0x28: The next attribute Id
> +	__le32 used;		// 0x18: The size of used part.
> +	__le32 total;		// 0x1C: Total record size.
> 
> -	__le16 res;		// 0x2A: High part of mft record?
> -	__le32 mft_record;	// 0x2C: Current mft record number
> +	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
> +	__le16 next_attr_id;	// 0x28: The next attribute Id.
> +
> +	__le16 res;		// 0x2A: High part of MFT record?
> +	__le32 mft_record;	// 0x2C: Current MFT record number.
>  	__le16 fixups[];	// 0x30:
>  };
> 
