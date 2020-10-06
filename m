Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D8D284873
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 10:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJFIYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 04:24:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:60750 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgJFIYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:24:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201006082357epoutp013d7fd23504fc9522244dd4fa141cbec6~7WaA-N7FS1211312113epoutp01v
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 08:23:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201006082357epoutp013d7fd23504fc9522244dd4fa141cbec6~7WaA-N7FS1211312113epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601972637;
        bh=CEmnTgcyed9RAomU3ELyjDL9JtVQH2eE3sKWO4ZrQ1Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MYUF5hgkszuuGOZX06MqHhk6NxkBGM7yGjY/8kz3iNiUT5xsVcYCZaN+8P2qOEmaP
         O48ypcwh5ow2KXXAejKjoxBPgaLAUM/70Zj0SM1J+fDgGQjElZU97NV7WgynAs68uJ
         Mx208jqfSA1o9XLEFctJ5C6UJS/f4cgGV05NoGI4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201006082356epcas1p262b5c86bd40766eaf57d386c40791ddc~7WaAsR3GG0392203922epcas1p2G;
        Tue,  6 Oct 2020 08:23:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4C59V41RXdzMqYkk; Tue,  6 Oct
        2020 08:23:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.EC.10463.C992C7F5; Tue,  6 Oct 2020 17:23:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201006082355epcas1p1b16e3b8623ae34ea69c533da042c1326~7WZ-YAMPZ2061120611epcas1p1T;
        Tue,  6 Oct 2020 08:23:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201006082355epsmtrp12a7f3bcc6fd0877d6e7ee7e9873df367~7WZ-W2UZl0812208122epsmtrp1H;
        Tue,  6 Oct 2020 08:23:55 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-b2-5f7c299ca394
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.DB.08745.B992C7F5; Tue,  6 Oct 2020 17:23:55 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201006082355epsmtip28006e7cb430c79633f5783556ada8ff5~7WZ-MP1C03176531765epsmtip2_;
        Tue,  6 Oct 2020 08:23:55 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20201002060505.27449-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3 1/2] exfat: add exfat_update_inode()
Date:   Tue, 6 Oct 2020 17:23:55 +0900
Message-ID: <000b01d69bba$08047320$180d5960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG77KNAqFwZFI6Uq4r1TRBZo631DgHZ9QczqbDDbeA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmnu4czZp4g03POCx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBZb/h1hdWDz+DLnOLtH87GVbB47Z91l9+jbsorR4/MmuQDWqByb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORk7
        J79nKtjJVvH963K2BsYtrF2MnBwSAiYSfzsmM3YxcnEICexglJjbtokNwvnEKPF6SgcThPOZ
        UWLzpm/MMC3d7SehWnYxSvS27mCFcF4ySuy9sJYdpIpNQFfi35/9bCC2iICexMmT18HmMgtc
        ZJR4eXIdUBEHB6eApcTbBdUgNcIC1hJHrm0Eq2cRUJFY3/sdbBsvUMnCXRvYIWxBiZMzn7CA
        2MwC8hLb386BukhB4ufTZawQu6wkJl59xQhRIyIxu7ONGWSvhMBEDokvf9pYIBpcJF7Nb4ey
        hSVeHd/CDmFLSbzsbwO7TUKgWuLjfqj5HYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3
        XKi1fBLvvvawQkzhlehoE4IoUZXou3SYCcKWluhq/8A+gVFpFpLHZiF5bBaSB2YhLFvAyLKK
        USy1oDg3PbXYsMAEObI3MYJTp5bFDsa5bz/oHWJk4mA8xCjBwawkwqsXVhEvxJuSWFmVWpQf
        X1Sak1p8iNEUGNQTmaVEk/OByTuvJN7Q1MjY2NjCxMzczNRYSZz34S2FeCGB9MSS1OzU1ILU
        Ipg+Jg5OqQYmqZMCMW/PNcfn/VXeOjU+6vTSt4fuSlmrTq/c+plb64U8D2+fpMnV7Uu/1j8w
        u2Oq97dy57u73SHaSwO3HroscOvVmb18X/SX7w79ekyn98JG/W8/3+eEv5XzlVr7xrjG6MjU
        L5tNrBf2RV77NulyT9npGRLHrkpwOP433u5xj+vJJr6Ds9f/+lp1OWpq4Xkmme/Xb2VuNgqe
        +841L956R6Uaj+O8lHtTYsR6iuTfdpf4LnYIufRjfVi8rEYJ59Wzp41fFSWaHXWfmFl+lXuB
        74wjtmmxmU+W8GrsrFbss2q7fnql8ZOyOx9+qN6wWXhUetV2f6s8RZfV2apf5k/O/pG89NM1
        tk/NTcW1H35EaCixFGckGmoxFxUnAgDBbhp2JgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO5szZp4gyf/JC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBZb/h1hdWDz+DLnOLtH87GVbB47Z91l9+jbsorR4/MmuQDWKC6b
        lNSczLLUIn27BK6MnZPfMxXsZKv4/nU5WwPjFtYuRk4OCQETie72k4wgtpDADkaJ23sVIOLS
        EsdOnGHuYuQAsoUlDh8u7mLkAip5ziixYvVzFpAaNgFdiX9/9rOB2CICehInT15nAyliFrjM
        KNHbNpEFoqOLUWJG739WkEmcApYSbxdUgzQIC1hLHLm2EayZRUBFYn3vd2YQmxeoZOGuDewQ
        tqDEyZlPWEBamYEWtG0Eu5NZQF5i+9s5zBB3Kkj8fLqMFeIGK4mJV19B1YhIzO5sY57AKDwL
        yaRZCJNmIZk0C0nHAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwfGjpbWDcc+q
        D3qHGJk4GA8xSnAwK4nw6oVVxAvxpiRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2
        ampBahFMlomDU6qByZExyXuF39eaxRcF/mq+4LJ7rfD+7sQDayMLVjz57fSQgzdU2Ylfdf5F
        Gb4LPyaYLIxd7cNta/9S6dEKf63JYovOqsXf8dBeVvp5b6eEc8QtxZZZ2kVKfGW3HvJPvSVR
        c6smaMmkOROOSq8q3dt8gUVYa22gU1/Bs4ZTP14/3PeHM+d67zrtEFmNnrT3U39u6XjlYxM8
        reKQ9tktQm0JXyeKN3rlmMSqHb/9eO554dR5earl4svaKj95yr5++/6xxdZy5QvMh95L6cWf
        rdT8lhAk8CDP3Cd9Q6G1eL118CbGk7Vz+DlMesJrtkwyXBAbV86ZevTSfrsZppdurskO0t13
        SEkxppVvfnHRd495SizFGYmGWsxFxYkA15U7Ng4DAAA=
X-CMS-MailID: 20201006082355epcas1p1b16e3b8623ae34ea69c533da042c1326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201002060529epcas1p2e05b4f565283969f4f2adc337f23a0d2
References: <CGME20201002060529epcas1p2e05b4f565283969f4f2adc337f23a0d2@epcas1p2.samsung.com>
        <20201002060505.27449-1-kohada.t2@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1352,19 +1340,13 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
>  		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
>  	exfat_truncate_atime(&new_dir->i_atime);
> -	if (IS_DIRSYNC(new_dir))
> -		exfat_sync_inode(new_dir);
> -	else
> -		mark_inode_dirty(new_dir);
> +	exfat_update_inode(new_dir);
> 
>  	i_pos = ((loff_t)EXFAT_I(old_inode)->dir.dir << 32) |
>  		(EXFAT_I(old_inode)->entry & 0xffffffff);
>  	exfat_unhash_inode(old_inode);
>  	exfat_hash_inode(old_inode, i_pos);
> -	if (IS_DIRSYNC(new_dir))
> -		exfat_sync_inode(old_inode);
> -	else
> -		mark_inode_dirty(old_inode);
> +	exfat_update_inode(old_inode);
This is checking if old_inode is IS_DIRSYNC, not new_dir.
Is there any reason ?

