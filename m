Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE412E581
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgABLGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 06:06:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51199 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgABLGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:06:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so5265782wmb.0;
        Thu, 02 Jan 2020 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Lx8trOypKQcB3y7G9t8RQ7ZtmJO0XBo/XDVCMeieuM=;
        b=gt3FMueaB+AhgbDkLj71qvp44aOePSn6wkT3UZWKUQTq9AMuCy+FRnfoctQTiVX5Z6
         Vqxq9Vc76uXJL6HZY2S2HdnpnyNFYlfc3xtuPGS2gbCFtYhh9+XN8judloYDsV45Exoo
         A8p7SOZHUui1evb25IKfkhNjFbHeGcfuLv2uJ19UItTVf2SRisFzNfTwCErymyYQfAdO
         Cp72gvSSvKJSSZkDC7PjDKarPcO6UbV1k+9M2nsMPeG4IB6FmZWgApKxXmtv/DP26TAH
         DUGCC2YLzs3BF2MVqJyoSi11mbuifkn4PTrk1D5J8FlQYMKFEjJGd7e4kO9gugVl70E+
         9fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Lx8trOypKQcB3y7G9t8RQ7ZtmJO0XBo/XDVCMeieuM=;
        b=kPTHLf9kQk8W+vsC+hgMJ5nbF0XrjGwp1nYAHvC4kSWnhXm5Mvuwclqo3I0t7UlFzt
         Z03krkZNJ+QwCj+8rRXexIT3H9I5xlTrnZaA41k/2FDRuGb7BQCpbZOExMb+/wIkBJ+Y
         zL0diFsvgjfPx1F33Z1UHWWtJHHZlCcuYtOTD2zgaiMGLtED9l7gJIWlFZlNAO1Hl25M
         HJ0A8qQTkX4YI1O0zTPVyd2BHuBfU8HMh2/GN2KrB0kxLI130X4xpgSj0vSL+bZt7II1
         4eb9wLoo2QbI2vaOPhZsWS4AvATfypu40cxl6qLeuTwxlO5cXaVfGhq7YUv5qXFzz+mT
         APDA==
X-Gm-Message-State: APjAAAV6/kGcuRjak+NFAgyUZ602UxdwXzi/WLFRBN0tC1y+/Vjk5AJp
        zkKFkaNDzOO3vZlmScRqIy0=
X-Google-Smtp-Source: APXvYqzxCGHyDbLBKe1cZQSNENybsYymPUSmy4c38rEUpvoUe6xyNcpaJpJEXPAAuAYSxCgpm7bclA==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr13963943wme.108.1577963165465;
        Thu, 02 Jan 2020 03:06:05 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v8sm55528052wrw.2.2020.01.02.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 03:06:04 -0800 (PST)
Date:   Thu, 2 Jan 2020 12:06:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and
 headers
Message-ID: <20200102110604.acdilxek5w22q5bg@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062732epcas1p17f3b1066fb4d6496559f349f950e1751@epcas1p1.samsung.com>
 <20191220062419.23516-2-namjae.jeon@samsung.com>
 <20191229141108.ufnu6lbu7qvl5oxj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191229141108.ufnu6lbu7qvl5oxj@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, just remainder for question below, so it would not be lost.

I guess that if comment for structure says that it needs to have exact
size then structure should be marked as packed to prevent any unexpected
paddings added by compiler (as IIRC compiler is free to add any padding
between any structure members).

On Sunday 29 December 2019 15:11:08 Pali Rohár wrote:
> On Friday 20 December 2019 01:24:07 Namjae Jeon wrote:
> > +
> > +#define JUMP_BOOT_LEN			3
> > +#define OEM_NAME_LEN			8
> > +#define MUST_BE_ZERO_LEN		53
> > +#define EXFAT_FILE_NAME_LEN		15
> > +
> > +/* EXFAT BIOS parameter block (64 bytes) */
> > +struct bpb64 {
> > +	__u8 jmp_boot[JUMP_BOOT_LEN];
> > +	__u8 oem_name[OEM_NAME_LEN];
> > +	__u8 res_zero[MUST_BE_ZERO_LEN];
> > +};
> > +
> > +/* EXFAT EXTEND BIOS parameter block (56 bytes) */
> > +struct bsx64 {
> > +	__le64 vol_offset;
> > +	__le64 vol_length;
> > +	__le32 fat_offset;
> > +	__le32 fat_length;
> > +	__le32 clu_offset;
> > +	__le32 clu_count;
> > +	__le32 root_cluster;
> > +	__le32 vol_serial;
> > +	__u8 fs_version[2];
> > +	__le16 vol_flags;
> > +	__u8 sect_size_bits;
> > +	__u8 sect_per_clus_bits;
> > +	__u8 num_fats;
> > +	__u8 phy_drv_no;
> > +	__u8 perc_in_use;
> > +	__u8 reserved2[7];
> > +};
> 
> Should not be this structure marked as packed? Also those two below.
> 
> > +/* EXFAT PBR[BPB+BSX] (120 bytes) */
> > +struct pbr64 {
> > +	struct bpb64 bpb;
> > +	struct bsx64 bsx;
> > +};
> > +
> > +/* Common PBR[Partition Boot Record] (512 bytes) */
> > +struct pbr {
> > +	union {
> > +		__u8 raw[64];
> > +		struct bpb64 f64;
> > +	} bpb;
> > +	union {
> > +		__u8 raw[56];
> > +		struct bsx64 f64;
> > +	} bsx;
> > +	__u8 boot_code[390];
> > +	__le16 signature;
> > +};
> 

-- 
Pali Rohár
pali.rohar@gmail.com
