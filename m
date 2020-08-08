Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029723F850
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHHRTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 13:19:23 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16176 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHRTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:19:16 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200808171913epoutp01162b6b845a53fdb8167499a7fed2366d~pWphws4oZ0422004220epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2020 17:19:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200808171913epoutp01162b6b845a53fdb8167499a7fed2366d~pWphws4oZ0422004220epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596907153;
        bh=Maph2+9eU8UGURrBHVNh/awFTHY6ZDtHaXDwhs5jWno=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JrXR5rqvDJ0ehVF+8HEcMyftdjycxK8mulSVnubf+nJfshvUZXF6ALsbJ7zqhCJbZ
         WPPj61vfWEKulLIx9axgYvhYidwbyooznWT+2vDSdCbRfCKt+q4IJvpVvcZO625ylA
         BBgsP/UNl6PnN9iu4qUJke9mHUFUuctyw0OosKnA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200808171912epcas1p37f8f0c2c144b8ba05187c6f998c21439~pWpgZp1Ij2713927139epcas1p36;
        Sat,  8 Aug 2020 17:19:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BP88v22dpzMqYkV; Sat,  8 Aug
        2020 17:19:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.F9.28578.F8EDE2F5; Sun,  9 Aug 2020 02:19:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200808171910epcas1p1ffc9984fce920ad0e00e589c5676a2e8~pWpe_btbF1675516755epcas1p1g;
        Sat,  8 Aug 2020 17:19:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200808171910epsmtrp15a4c0762f5b2197d4dd73027f5db953e~pWpe93Cqa1286512865epsmtrp1C;
        Sat,  8 Aug 2020 17:19:10 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-51-5f2ede8fd551
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.B4.08303.E8EDE2F5; Sun,  9 Aug 2020 02:19:10 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200808171910epsmtip17f402df95c66d39688b798639607e214~pWpe0fyI-1027610276epsmtip1B;
        Sat,  8 Aug 2020 17:19:10 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806055653.9329-2-kohada.t2@gmail.com>
Subject: RE: [PATCH 2/2] exfat: unify name extraction
Date:   Sun, 9 Aug 2020 02:19:10 +0900
Message-ID: <000201d66da8$07a2c750$16e855f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGp1IjqD1H8gBd2v567dvdPOf7sigI0j+eiAeStLz2pZtYrsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmnm7/Pb14g80r2S1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJMxedNOloL3ihVnbq9gb2C8LdXFyMkhIWAicfzFFbYuRi4OIYEdjBIPbh1jBkkI
        CXxilLjWUAaR+MwosevNMXaYjhPdRxkhErsYJa6cO8AE4bxklJjR9husnU1AV+LJjZ9gtoiA
        nsTJk9fZQGxmgUYmiRMvs0FsTgELiY3nF7GC2MICphKTtz8Cq2ERUJFYdOclWJxXwFLizIyp
        ULagxMmZT1gg5shLbH87hxniIgWJ3Z+OAtVwAO1ykrh4iBuiRERidmcbM8htEgJzOSTeb13G
        DFIjIeAicfehCUSrsMSr41ugHpOSeNnfBmXXS/yfv5YdoreFUeLhp21MEL32Eu8vWYCYzAKa
        Eut36UOUK0rs/D2XEWItn8S7rz2sENW8Eh1tQhAlKhLfP+xkgdl05cdVpgmMSrOQ/DULyV+z
        kDwwC2HZAkaWVYxiqQXFuempxYYFpshRvYkRnEi1LHcwTn/7Qe8QIxMH4yFGCQ5mJRHerBfa
        8UK8KYmVValF+fFFpTmpxYcYTYEhPZFZSjQ5H5jK80riDU2NjI2NLUzMzM1MjZXEeR/eUogX
        EkhPLEnNTk0tSC2C6WPi4JRqYNK+zNP24MW6pWc/m39yl3cr2V1i51Lue7PpgpS+o3t886Lt
        udGsz17uCPRss5TYPdFDTPfVVJ20DrmZJQvVdHNtTBiuSxZ0GZ97GmbHwnlR7ev914JOwmXn
        wkN7RZe2Vr/f7RM1iW/ZuvyVp/8tOqG1KSDCd+u26G7zxDt3xcRZZzEZsc/6zzhr2e4pwYtK
        J/Fd17vDy33hr92vyuKzXgzbe6ee7/7dHM72ZtO6Pc7ZjDXVLmF34lb/mbaSo+3RAdcf3f06
        b3MeH8/1i8x5Lf3UJEZlQVTiIuNHF73/L7HNm/I64lHioqhpa96lft8YFjhD86RybPHS+E01
        XRbmMs2JZUd0BE4t9ziwf94GeSWW4oxEQy3mouJEAIfNqEgtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTrfvnl68wee5ShY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlTN60k6XgvWLFmdsr2BsYb0t1MXJySAiYSJzoPsoIYgsJ
        7GCU6Jul28XIARSXkji4TxPCFJY4fLi4i5ELqOI5o0T7rBXsIOVsAroST278ZAaxRQT0JE6e
        vM4GUsQs0Mwk0fqlmQmiYyujxIXvrWALOAUsJDaeX8QKYgsLmEpM3v6IDcRmEVCRWHTnJVic
        V8BS4syMqVC2oMTJmU9YQK5gBtrQthFsDLOAvMT2t3OYIe5XkNj96SgrSImIgJPExUPcECUi
        ErM725gnMArPQjJoFsKgWUgGzULSsYCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4m
        RnA8aWntYNyz6oPeIUYmDsZDjBIczEoivFkvtOOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ836d
        tTBOSCA9sSQ1OzW1ILUIJsvEwSnVwHSFLcGo9YXaX92IeRn6s2adtt/8/OuXevbph5b13rVs
        D+04flHcNCt+YvZcsU+zFFctW35y2rGc6I1KX7Ydtu+rfWDDkL5vihjjDMPz5Vmxn/rUr779
        +yLt/WJbReallYKRH5+5K6pfXaZoxmPKIOHp8GGbV3NXe7/cX7tjwh5O1y9K3sxP0NZhZc5v
        6Ij2vlbHmlF6bO/CQ+/a9eoVy5T0jObd9JZq9OysM2DIZwmSuz9N/eWFV7O3fTbubdU42MZ5
        M0i5taNn3qosjsTyyUfZj2Vm7zq06+KfknNsjq1b/5jILzulLTwhIFjcJIjfxWbbncuGgnNO
        +roccjbt31+cc9L3wdrJPVYrVsQ+UGIpzkg01GIuKk4EAGSn+JQWAwAA
X-CMS-MailID: 20200808171910epcas1p1ffc9984fce920ad0e00e589c5676a2e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d
References: <20200806055653.9329-1-kohada.t2@gmail.com>
        <CGME20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d@epcas1p2.samsung.com>
        <20200806055653.9329-2-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Name extraction in exfat_find_dir_entry() also doesn't care NameLength, so
> the name may be incorrect.
> Replace the name extraction in exfat_find_dir_entry() with using
> exfat_entry_set_cache and exfat_get_uniname_from_name_entries(),
> like exfat_readdir().
> Replace the name extraction with using exfat_entry_set_cache and
> exfat_get_uniname_from_name_entries(), like exfat_readdir().
> And, remove unused functions/parameters.
> 
> ** This patch depends on:
>   '[PATCH v3] exfat: integrates dir-entry getting and validation'.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c      | 161 ++++++++++----------------------------------
>  fs/exfat/exfat_fs.h |   2 +-
>  fs/exfat/namei.c    |   4 +-
>  3 files changed, 38 insertions(+), 129 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 545bb73b95e9..c9715c7a55a1 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -10,24 +10,6 @@
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
[snip]
> @@ -963,80 +942,38 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  			num_empty = 0;
>  			candi_empty.eidx = EXFAT_HINT_NONE;
> 
[snip]
> 
> -			if (entry_type &
> -					(TYPE_CRITICAL_SEC |
TYPE_BENIGN_SEC)) {
> -				if (step == DIRENT_STEP_SECD) {
> -					if (++order == num_ext)
> -						goto found;
> -					continue;
> -				}
> +			exfat_get_uniname_from_name_entries(es, &uni_name);

It is needed to check a return value.

> +			exfat_free_dentry_set(es, false);
> +
> +			if (!exfat_uniname_ncmp(sb,
> +						p_uniname->name,
> +						uni_name.name,
> +						name_len)) {
> +				/* set the last used position as hint */
> +				hint_stat->clu = clu.dir;
> +				hint_stat->eidx = dentry;

eidx and clu of hint_stat should have one for the next entry we'll start
looking for.
Did you intentionally change the concept?

> +				return dentry;
>  			}
> -			step = DIRENT_STEP_FILE;
>  		}
> 
>  		if (clu.flags == ALLOC_NO_FAT_CHAIN) { @@ -1069,32 +1006,6
> @@ int exfat_find_dir_entry(struct super_block *sb, struct
> exfat_inode_info *ei,
>  	hint_stat->clu = p_dir->dir;
>  	hint_stat->eidx = 0;
>  	return -ENOENT;
> -
> -found:
> -	/* next dentry we'll find is out of this cluster */
> -	if (!((dentry + 1) & (dentries_per_clu - 1))) {
> -		int ret = 0;
> -
> -		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
> -			if (--clu.size > 0)
> -				clu.dir++;
> -			else
> -				clu.dir = EXFAT_EOF_CLUSTER;
> -		} else {
> -			ret = exfat_get_next_cluster(sb, &clu.dir);
> -		}
> -
> -		if (ret || clu.dir == EXFAT_EOF_CLUSTER) {
> -			/* just initialized hint_stat */
> -			hint_stat->clu = p_dir->dir;
> -			hint_stat->eidx = 0;
> -			return (dentry - num_ext);
> -		}
> -	}
> -
> -	hint_stat->clu = clu.dir;
> -	hint_stat->eidx = dentry + 1;
> -	return dentry - num_ext;
>  }
> 
>  int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain
> *p_dir, diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> b88b7abc25bd..62a4768a4f6e 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -456,7 +456,7 @@ void exfat_update_dir_chksum_with_entry_set(struct
> exfat_entry_set_cache *es);  int exfat_calc_num_entries(struct
> exfat_uni_name *p_uniname);  int exfat_find_dir_entry(struct super_block
> *sb, struct exfat_inode_info *ei,
>  		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
> -		int num_entries, unsigned int type);
> +		int num_entries);
>  int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
> int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
>  		int entry, sector_t *sector, int *offset); diff --git
> a/fs/exfat/namei.c b/fs/exfat/namei.c index a65d60ef93f4..c59d523547ca
> 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -625,9 +625,7 @@ static int exfat_find(struct inode *dir, struct qstr
> *qname,
>  	}
> 
>  	/* search the file name for directories */
> -	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
> -			num_entries, TYPE_ALL);
> -
> +	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
> num_entries);
>  	if ((dentry < 0) && (dentry != -EEXIST))
>  		return dentry; /* -error value */
> 
> --
> 2.25.1


