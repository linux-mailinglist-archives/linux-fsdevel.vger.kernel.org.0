Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7613635A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 23:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgAIWn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 17:43:26 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38196 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgAIWn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:43:26 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109224322epoutp04e8060af0d2e0cdacccf508bc78d6fc4e~oWUB4U48A2442124421epoutp047
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 22:43:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109224322epoutp04e8060af0d2e0cdacccf508bc78d6fc4e~oWUB4U48A2442124421epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578609802;
        bh=gEVerhfmDcrpF2fBfxGX/Y87GU5rY5JiHRqAs9I1nNY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=THXwpFL7g8pcCJW2vz6rD4d7fRT8DRHu5qDeHCza/TnALQzYACpyuw+fRQ0MjJ5iG
         D/7JNn0NqOV84OkQI3F2qlu8qHuaOmvQ2E7FvdaftV9tHABe3IVRLR4k2h17AzNkuG
         +GpXCBsgHFZ71Z3Yus+I42Ka7u5F5LiY/Q/Qbe9E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200109224322epcas1p3731ce63dd73c57f9223a461b0062bc2a~oWUBSpT330671706717epcas1p3S;
        Thu,  9 Jan 2020 22:43:22 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v1Nn2GDrzMqYkV; Thu,  9 Jan
        2020 22:43:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.AA.51241.98CA71E5; Fri, 10 Jan 2020 07:43:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109224320epcas1p282e8caab4abc6b98a4f062bfc43a28c8~oWUAJM1Yt0443104431epcas1p2y;
        Thu,  9 Jan 2020 22:43:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200109224320epsmtrp22060f7ed08d2cd0ae8910af511d2c975~oWUAIgy-i1043510435epsmtrp2i;
        Thu,  9 Jan 2020 22:43:20 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-64-5e17ac89a097
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.F4.10238.88CA71E5; Fri, 10 Jan 2020 07:43:20 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109224320epsmtip20c3f23d0cfb5b80732ff45debfef1118~oWT--DJmS1908619086epsmtip2C;
        Thu,  9 Jan 2020 22:43:20 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <pali.rohar@gmail.com>
In-Reply-To: <20200108170840.GB13388@lst.de>
Subject: RE: [PATCH v9 01/13] exfat: add in-memory and on-disk structures
 and headers
Date:   Fri, 10 Jan 2020 07:43:20 +0900
Message-ID: <001601d5c73e$316b19e0$94414da0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwFfDCJbAb+UN2ABfmorMqbFXjag
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3b27u0q3btPawb7WrYxF0805u5ZWkMkifwj9iAKdF71s0r7a
        3aQPqVVkKmWN+lHTshKiLFiFtbLEUMu+KFL7UNCU9aXkR0WlFdq2a+S/55zznPM8530Picn9
        RBxZaHPxThtnYYho/GazSqMuu6LI1byeoNgDNX6CvXT5voR93d2FsXcbHuFse30VwXqf/Jaw
        deMtUrZteARfSxpu+7plhsbTV2SGO50ewlBRV4sM367PNzQFPhPZxFZLmpnnCninkrfl2wsK
        baZ0ZuMm4zqjPkWjVWtT2RWM0sZZ+XQmIytbnVloCRlilEWcxR1KZXOCwCSuTnPa3S5eabYL
        rnSGdxRYHFqNI0HgrILbZkrIt1tXajWaJH2ImWcx945vcPxgdlS+PIp70JG55SiKBDoZzvie
        4eUompTTtxCM9AdlYvAVQWPFKCEGPxA8/PQY+9dyrrV2stCAwFPzXSIG/Qg+nLiJwiyCVsP4
        n0YijGPpeHg6VhKZi9GPEUzc8EYKUfRyOH+yTRLGMfRm6HneEcnj9BLo7PkYkaPoVPC0+5GI
        Z8KjU+/wMMboBRAYrJq0pISx9xekolgm1D70yEROLFSWlWBhYaAnCPBWjUrEhgxoGXqORBwD
        A611MhHHwbehhpAJMoR3w5fGyfmlCD79TBexDjr9V6VhCkarwF+fKKYXwu3fp5EoOx2Gvh+W
        ilMoKC2Ri5QlUNHWPGlgDpQfGpEdQ4xvymK+KYv5pizg+y92FuG1aDbvEKwmXtA69FM/+zqK
        HOuy1FvowbOsJkSTiJlGmWMUuXIpVyTstDYhIDEmlrr/ZnaunCrgdu7inXaj023hhSakD727
        F4ublW8Pnb7NZdTqk3Q6HZucsiJFr2MUFDn6IkdOmzgXv43nHbzzX5+EjIrzoDXXrhoPars6
        tlwzmavfts5o3j9W104Nzu0q3twr9eRt/zXvxMdFxwZK6vtz+oJKyn9wcaClWJUQ3PMkCEuj
        q+dE9xGmUm+OJevig9aAouzur5Z9ezPy3Hvv+eqLY+O54VcmfdH6ryeP9wqqPhU7nMApXr1c
        1RG8HD+wUp0WqMQZXDBz2mWYU+D+Ao8n+U/CAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvG7HGvE4g0v9ZhbNi9ezWaxcfZTJ
        4vrdW8wWe/aeZLG4vGsOm8XE07+ZLLb8O8Jqcen9BxYHDo+ds+6ye+yfu4bdY/fNBjaPvi2r
        GD0+b5LzOLT9DVsAWxSXTUpqTmZZapG+XQJXxoN/ngXflCpmX+1naWDsleli5OSQEDCRWHh8
        FVsXIxeHkMBuRolnbWeYIRLSEsdOgNgcQLawxOHDxRA1zxklJl2/yQJSwyagK/Hvz342EFtE
        QE3izM82dpAiZoFLjBITepuYITruM0p8vXWPHaSKU0BHYtGMS0wgtrBAqER3z21GEJtFQFXi
        5r3nYJt5BSwlGi6vZ4SwBSVOznzCAnIFs4CeRNtGsDCzgLzE9rdzoA5VkPj5dBkrxBFuEqtO
        NLBD1IhIzO5sY57AKDwLyaRZCJNmIZk0C0nHAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnp
        esn5uZsYwfGlpbmD8fKS+EOMAhyMSjy8GcLicUKsiWXFlbmHGCU4mJVEeI/eEIsT4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgZGjkslC4Unf1b2C09dm
        fBOcWPP0KlfhhdbfU1b92P+/6CzjkrX2hcKbWe0THV7deDebT9bOL2LnFrbLcid3SLqdfdG7
        5sCc0H0hP+ort34/tUCb+465gfRv77v7Lvnxlu/a/rx9lv8pe/U5ziem8ty9+iTwTrYRm0mg
        dnjnv+uLDj1eHh60dWOlEktxRqKhFnNRcSIAWV+X1asCAAA=
X-CMS-MailID: 20200109224320epcas1p282e8caab4abc6b98a4f062bfc43a28c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082400epcas1p4cd0ad14967bd8d231fc0efcede8bd99c
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082400epcas1p4cd0ad14967bd8d231fc0efcede8bd99c@epcas1p4.samsung.com>
        <20200102082036.29643-2-namjae.jeon@samsung.com>
        <20200108170840.GB13388@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Jan 02, 2020 at 04:20:24PM +0800, Namjae Jeon wrote:
> > This adds in-memory and on-disk structures and headers.
> >
> > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> This looks good modulo a few cosmetic nitpicks below.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

> 
> > --- /dev/null
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -0,0 +1,569 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> > + */
> > +
> > +#ifndef _EXFAT_H
> > +#define _EXFAT_H
> 
> This should probably be _EXFAT_FS_H to match the actual file name.
Right, Will fix it on v10.
> 
> > +
> > +#include <linux/fs.h>
> > +#include <linux/ratelimit.h>
> > +
> > +#define EXFAT_SUPER_MAGIC       (0x2011BAB0UL)
> 
> No need for the braces.
Yes.

> 
> > +/*
> > + * exfat common MACRO
> > + */
> 
> Not sure this comment is all that helpful.
Will remove it.

> 
> > +#define CLUSTER_32(x)			((unsigned int)((x) &
0xFFFFFFFFU))
> 
> This could just use lower_32_bits().
Okay.
> 
> > +#define EXFAT_BAD_CLUSTER		(0xFFFFFFF7U)
> > +#define EXFAT_FREE_CLUSTER		(0)
> > +/* Cluster 0, 1 are reserved, the first cluster is 2 in the cluster
> heap. */
> > +#define EXFAT_RESERVED_CLUSTERS		(2)
> > +#define EXFAT_FIRST_CLUSTER		(2)
> 
> No need for the braces.
Okay.
> 
> > +/* type values */
> > +#define TYPE_UNUSED		0x0000
> > +#define TYPE_DELETED		0x0001
> > +#define TYPE_INVALID		0x0002
> > +#define TYPE_CRITICAL_PRI	0x0100
> > +#define TYPE_BITMAP		0x0101
> > +#define TYPE_UPCASE		0x0102
> > +#define TYPE_VOLUME		0x0103
> > +#define TYPE_DIR		0x0104
> > +#define TYPE_FILE		0x011F
> > +#define TYPE_CRITICAL_SEC	0x0200
> > +#define TYPE_STREAM		0x0201
> > +#define TYPE_EXTEND		0x0202
> > +#define TYPE_ACL		0x0203
> > +#define TYPE_BENIGN_PRI		0x0400
> > +#define TYPE_GUID		0x0401
> > +#define TYPE_PADDING		0x0402
> > +#define TYPE_ACLTAB		0x0403
> > +#define TYPE_BENIGN_SEC		0x0800
> > +#define TYPE_ALL		0x0FFF
> 
> Shouldn't this go into exfat_raw.h?
Yes, These are not.

> Maybe check if a few other values should as well if they define an on-disk
format.
Right, I found a few values which should be move to exfat_raw.h.
Will fix.

> 
> > +static inline sector_t exfat_cluster_to_sector(struct exfat_sb_info
> *sbi,
> > +		unsigned int clus)
> > +{
> > +	return ((clus - EXFAT_RESERVED_CLUSTERS) << sbi->sect_per_clus_bits)
> > +		+ sbi->data_start_sector;
> 
> Nitpick: normally we put the operators at the of the previous line in
> Linux code.
Okay.
> 
> > +#define EXFAT_DELETE		~(0x80)
> 
> The braces would more useful outside the ~.
Okay.
> 
> > +#define file_num_ext			dentry.file.num_ext
> > +#define file_checksum			dentry.file.checksum
> > +#define file_attr			dentry.file.attr
> > +#define file_create_time		dentry.file.create_time
> > +#define file_create_date		dentry.file.create_date
> > +#define file_modify_time		dentry.file.modify_time
> > +#define file_modify_date		dentry.file.modify_date
> > +#define file_access_time		dentry.file.access_time
> > +#define file_access_date		dentry.file.access_date
> > +#define file_create_time_ms		dentry.file.create_time_ms
> > +#define file_modify_time_ms		dentry.file.modify_time_ms
> > +#define file_create_tz			dentry.file.create_tz
> > +#define file_modify_tz			dentry.file.modify_tz
> > +#define file_access_tz			dentry.file.access_tz
> > +#define stream_flags			dentry.stream.flags
> > +#define stream_name_len			dentry.stream.name_len
> > +#define stream_name_hash		dentry.stream.name_hash
> > +#define stream_start_clu		dentry.stream.start_clu
> > +#define stream_valid_size		dentry.stream.valid_size
> > +#define stream_size			dentry.stream.size
> > +#define name_flags			dentry.name.flags
> > +#define name_unicode			dentry.name.unicode_0_14
> > +#define bitmap_flags			dentry.bitmap.flags
> > +#define bitmap_start_clu		dentry.bitmap.start_clu
> > +#define bitmap_size			dentry.bitmap.size
> > +#define upcase_start_clu		dentry.upcase.start_clu
> > +#define upcase_size			dentry.upcase.size
> > +#define upcase_checksum			dentry.upcase.checksum
> 
> Personally I don't find these defines very helpful - directly seeing the
> field name makes the code much easier to read.
Okay, Will remove them.

Thanks for your review!

