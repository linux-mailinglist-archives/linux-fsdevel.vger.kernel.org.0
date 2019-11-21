Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A552310482A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKUBmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 20:42:20 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:48739 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUBmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:42:20 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121014216epoutp01aad18c6ede1f941576c25c9d9e683075~ZCf8qYwsV0914709147epoutp01B
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 01:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121014216epoutp01aad18c6ede1f941576c25c9d9e683075~ZCf8qYwsV0914709147epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574300536;
        bh=XDt3NEv3tS3F+MHLl2VQ/5MdacFRFlCQcvRW128QAoU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=he6m7ZXFInl0CVdquKN+tnmracBN5vJbgpoiX8SP+bEYZaUdhE8Zt4t6sNaRVApJj
         zICEREoPuGnS1anktDrPRpIGBhyx6kwa+dk/Pqyd7cqyNrNDFDIQ83/A2LNen0aKM4
         JV/+l19iiv8JNe1jWfX11dkqrGu2re+YmOPAJZpo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191121014215epcas1p4e6dba93392b89a02dc92dd4b87ed12af~ZCf8ST2gb0187501875epcas1p46;
        Thu, 21 Nov 2019 01:42:15 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47JMkH1PnmzMqYkn; Thu, 21 Nov
        2019 01:42:15 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.EE.04406.67BE5DD5; Thu, 21 Nov 2019 10:42:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191121014214epcas1p4aa0e7148bd6e5b7a412a2294205cf900~ZCf6mOOhk0777007770epcas1p4e;
        Thu, 21 Nov 2019 01:42:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121014214epsmtrp2a1afccb106310128863152fd2e536bd6~ZCf6lfamH2549525495epsmtrp2o;
        Thu, 21 Nov 2019 01:42:14 +0000 (GMT)
X-AuditID: b6c32a38-947ff70000001136-d1-5dd5eb76f859
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.F4.03654.57BE5DD5; Thu, 21 Nov 2019 10:42:13 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121014213epsmtip17570d3b9b427482e46f4a2c9853036fe~ZCf6Zo3K_2005320053epsmtip1P;
        Thu, 21 Nov 2019 01:42:13 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Nikolay Borisov'" <nborisov@suse.com>
Cc:     <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <hch@lst.de>, <linkinjeon@gmail.com>, <Markus.Elfring@web.de>,
        <sj1557.seo@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <398eeca9-e59f-385b-791d-561e56567026@suse.com>
Subject: RE: [PATCH v2 05/13] exfat: add file operations
Date:   Thu, 21 Nov 2019 10:42:13 +0900
Message-ID: <00d201d5a00c$e6273ac0$b275b040$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQEo1XJlLzywHhHshRBLsQkFEP9+bwE2rzOUAX+3+6QCnhKN6qjDyqqg
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0hTYRjm2zk7O4qr07R8M6h1wrSLtjlnp9KKrqcyNAqCQuwwD07aztbO
        NLUg6TJLyrKicGlZUpJdrCVppgxmGhLdTFMLIaK7ly5iNzPbOov893zP+zzf+7zfhcRUt4kw
        MkOw8zaBM9FEIH6zcUZ0VFZPe4qmYjiU2VNeRTAXLzXJmI7uZxhT39CCM0/qSghmxPlWzoz0
        7sWZ6t935Ezrx0/44gD2lrNbwbpLLyvY2115BFtYXYnYqup2nB1wTWY9Nb0E+/zNTTyZ3GSK
        N/JcGm9T84LBkpYhpCfQa9anLk3Vx2m0Udp5zFxaLXBmPoFelpgctSLD5M1Hq7M4U6aXSuZE
        kZ6zMN5mybTzaqNFtCfQvDXNZNVqrNEiZxYzhfRog8U8X6vRxOi9yi0m48jJC4T1DJX9ZOQI
        ykN1QQUogAQqFpqH9sgKUCCpomoRHB08h/sKKuoLgvf7VkqFrwhqfhxD/xytN174HQ0ITgw/
        QNLiAwLnz3KZT0VQUfD7l5vw4RBqFpQffPSXx6guBI8/Gnw4gIqHTleR10ySwRQDTfnTfTRO
        hcOBtrcKH1ZS82D4hEsu4XHQUvwKl7aZAjV9JZgUSA2193uQxIfAqQMOTGq7Aq64e/2aYwpo
        OzRWwsug7WWhTMLB8OFutULCYTDQ30D44gC1Az67/db9CN59S5CwDrqqrsl9EoyaAVV1cyR6
        KtwaKvUnGAP9gwfl0i5K2O9QSZJwKGxt9DedBAX5nxRHEO0cNZdz1FzOUbM4/zcrQ3glmsBb
        RXM6L2qtsaNv2oX+PtyZTC2qf5DoQRSJ6CClMbI9RSXnssQcswcBidEhyvqOthSVMo3LyeVt
        llRbpokXPUjvPfYiLGy8weL9BoI9VauP0el0TGzc3Di9jg5Vkt8fp6iodM7Ob+V5K2/755OR
        AWF5qGjd7n7BPBx52XovqeJMX0Og21lmZDr3dl9X5hY7lg/VxU7c/Zq+hDUvUOwa3N5zpbAn
        /3iuvvtptGbB2o0PM0pn447Gwxv6B05rDJ9Lk3p3nozom57N5niWbnOJQmXEluBrcTnaq02r
        fhYnnV3EnSvzxGRPO7+kVXVct2jVQsfqzTQuGjntTMwmcn8AnxZtys4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnG7p66uxBs93W1k0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfj/poXFYsu/I6wWl95/YHHg9Ng56y67x/65a9g9dt9s
        YPPo27KK0WP9lqssHp83yXkc2v6GzeP2s20sARxRXDYpqTmZZalF+nYJXBn/py9jK5gvUHH5
        /wTGBsZdPF2MnBwSAiYSlzY/YOpi5OIQEtjNKLF9bgMLREJa4tiJM8xdjBxAtrDE4cPFEDUv
        GCWu73nEDlLDJqAr8e/PfjYQW0RAW2JxzwUmEJtZ4DGjxL69thANbxklzv/byAqS4BSwkbix
        aSIjyFBhAQuJo+1qIGEWAVWJzivPwWbyClhK/J22iRXCFpQ4OfMJC8RMbYneh62MELa8xPa3
        c5gh7lSQ2HH2NVRcRGJ2ZxszxD1uEmv3v2GewCg8C8moWUhGzUIyahaS9gWMLKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjT0tzB+PlJfGHGAU4GJV4eDM0rsYKsSaWFVfmHmKU
        4GBWEuHdc/1KrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTByc
        Ug2MHRfvP2KT7uGW+Od8UDKOLfQ5o8X8Rpua7n0xuvOmMtaw81vOOdu78L6MURR7VdYCxnlN
        j0PZfZ4eYn2/p0Jo+pXu5UaJ1b/fM6++0bSJr9a0u/GL7rQv9+Z7Xzu68r7BTkNv8XJ/CQkn
        XouGR8o3GdgeXos6bfD26TTv/LIzmdsEZfU0OqWVWIozEg21mIuKEwHZkmFGuwIAAA==
X-CMS-MailID: 20191121014214epcas1p4aa0e7148bd6e5b7a412a2294205cf900
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6@epcas1p4.samsung.com>
        <20191119071107.1947-6-namjae.jeon@samsung.com>
        <398eeca9-e59f-385b-791d-561e56567026@suse.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> > +static int exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode
> *inode)
> > +{
> > +	mode_t allow_utime = sbi->options.allow_utime;
> > +
> > +	if (!uid_eq(current_fsuid(), inode->i_uid)) {
> > +		if (in_group_p(inode->i_gid))
> > +			allow_utime >>= 3;
> > +		if (allow_utime & MAY_WRITE)
> > +			return 1;
> > +	}
> > +
> > +	/* use a default check */
> > +	return 0;
> 
> this function can be made to return bool.
Okay.
> 
> > +}
> > +
> 
> <snip>
> 
> > +/* resize the file length */
> > +int __exfat_truncate(struct inode *inode, loff_t new_size)
> > +{
> > +	unsigned int num_clusters_new, num_clusters_phys;
> > +	unsigned int last_clu = FREE_CLUSTER;
> > +	struct exfat_chain clu;
> > +	struct exfat_timestamp tm;
> > +	struct exfat_dentry *ep, *ep2;
> > +	struct super_block *sb = inode->i_sb;
> > +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> > +	struct exfat_inode_info *ei = EXFAT_I(inode);
> > +	struct exfat_entry_set_cache *es = NULL;
> > +	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
> > +
> > +	/* check if the given file ID is opened */
> > +	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
> > +		return -EPERM;
> > +
> > +	exfat_set_vol_flags(sb, VOL_DIRTY);
> > +
> > +	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);
> > +	num_clusters_phys =
> > +		EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk, sbi);
> > +
> > +	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);
> > +
> > +	if (new_size > 0) {
> > +		/*
> > +		 * Truncate FAT chain num_clusters after the first cluster
> > +		 * num_clusters = min(new, phys);
> > +		 */
> > +		unsigned int num_clusters =
> > +			min(num_clusters_new, num_clusters_phys);
> > +
> > +		/*
> > +		 * Follow FAT chain
> > +		 * (defensive coding - works fine even with corrupted FAT table
> > +		 */
> > +		if (clu.flags == 0x03) {
> 
> That 0x03 is magic constant, better define actual flags and check
> clu.flag == (FLAG1|FLAG2)
Okay, Will fix it on v4.

Thanks for your review!

