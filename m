Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9BF21CD17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 04:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGMCTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 22:19:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20545 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGMCTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:19:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200713021933epoutp02161c4146029c22426d2f1eae8690cda9~hLmlsm5vw2668726687epoutp02W
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 02:19:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200713021933epoutp02161c4146029c22426d2f1eae8690cda9~hLmlsm5vw2668726687epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594606773;
        bh=E6/4umsv8LVl+yrK0/Rkj8oHO0Hn6kk7Qn99QrzsZ4k=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=g7aoMsY+SIErb5BieHyGzXV38g26HDXvm1T6YA+CuXhfTTiCN+XcW2FYhFF0fq6mH
         T9rq8wmdXIZK24E6ubcaSk3ID5MVzIgHhIevUBPI+bxuO6rpU73nCxVOOU1Z2vh6vc
         qSuGvkj9k9TYG+fcNonu1EVsxACjIu0IJJ1ruHYw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200713021932epcas1p2c511839ea0023ce2dd2108cb1ad04f8c~hLmlQqc2n2649326493epcas1p2H;
        Mon, 13 Jul 2020 02:19:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B4nQr0GDczMqYlh; Mon, 13 Jul
        2020 02:19:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.5E.19033.2B4CB0F5; Mon, 13 Jul 2020 11:19:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200713021929epcas1p4b187bfc24619bd8044197610ac143e5e~hLmih_wmJ3230532305epcas1p4I;
        Mon, 13 Jul 2020 02:19:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713021929epsmtrp20f454c3528e481e45231bc832e18e53d~hLmihKM9Q2745727457epsmtrp2u;
        Mon, 13 Jul 2020 02:19:29 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-89-5f0bc4b2070d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.8E.08303.1B4CB0F5; Mon, 13 Jul 2020 11:19:29 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200713021929epsmtip21db11a67a6424c1ee107679f22377ecb~hLmiMHZ8A2489824898epsmtip2A;
        Mon, 13 Jul 2020 02:19:29 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200626060947.24709-1-kohada.t2@gmail.com>
Subject: RE: [RFC]PATCH] exfat: integrates dir-entry getting and validation
Date:   Mon, 13 Jul 2020 11:19:29 +0900
Message-ID: <4a6201d658bc$09e3fa80$1dabef80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFeQsEZsKvoo//MXIOVy2EvFQ2xIQIdLCHaqeP/l8A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmnu6mI9zxBot/KVr8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISej5atXwUXZiqM3v7A2MN4Q72Lk5JAQMJG4vHwGC4gtJLCDUWLqc8cuRi4g+xOj
        RN/rHewQic+MEpvO+8A0bFo2jQWiaBejxKLz79khnJeMEpcn7WUEqWIT0JV4cuMnM4gtIqAn
        cfLkdTYQm1mgkUnixMtsEJtTwFJi399VYKuFBbwldv+cBdbLIqAqcXnabLA4L1DN3OM3mSFs
        QYmTM5+wQMyRl9j+dg4zxEUKErs/HWXtYuQA2mUlcXIxH0SJiMTszjZmkNskBOZySJy/eJYF
        ot5FYkrLV1YIW1ji1fEt7BC2lMTnd3vZIOx6if/z17JDNLcwSjz8tI0JZIGEgL3E+0sWICaz
        gKbE+l36EOWKEjt/z2WE2Msn8e5rDytENa9ER5sQRImKxPcPO1lgNl35cZVpAqPSLCSPzULy
        2CwkH8xCWLaAkWUVo1hqQXFuemqxYYERckxvYgSnUS2zHYyT3n7QO8TIxMF4iFGCg1lJhDda
        lDNeiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDE3leSbyhqZGxsbGFiZm5mamxkjjvv7Ps
        8UIC6YklqdmpqQWpRTB9TBycUg1MmSZG7D+nLL2g/UrE7tr3D3/PTN3LfIYrPc5g7Q1jgYUz
        tXNT59xMWx6ZmlbJ5LVXZu4ne9/KVcd3S3zoi17/2e2nqLKjbsO7VeZJ+ZmVl+TddEpOPLwq
        kbbiSlnfyb45MonH4paJNDz9YM82W0/E2qZKtmTilYNaTH7Cm49ctvQ8I//bpJyL7cJEhfte
        +w/eWDz/suKxDv6c3QHXz2k7/b5ROWFr/znf2Ju9Sgdmei+O1Nzh1VwdJ8il5H5r1f+sqx7z
        N75JliifcCX56VIxz5+7rmf+0blmXfTj4TqxlcdqdZk8PtSXHo15VSgWmXLU33S5sotv3uwT
        l1r9XjleSJh32PLVs1tqbyaJ29XUKLEUZyQaajEXFScCAJWFQ/4sBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXnfjEe54g+NdlhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBltHz1KrgoW3H05hfWBsYb4l2MnBwSAiYSm5ZNY+li5OIQ
        EtjBKPHxy0vGLkYOoISUxMF9mhCmsMThw8UQJc8ZJXY8v8YC0ssmoCvx5MZPZhBbREBP4uTJ
        62wgRcwCzUwSrV+amSA6uhglvn5/AFbFKWApse/vKrBuYQFvid0/ZzGC2CwCqhKXp80Gi/MC
        1cw9fpMZwhaUODnzCQvIFcxAG9o2gpUzC8hLbH87hxniAQWJ3Z+OsoKUiAhYSZxczAdRIiIx
        u7ONeQKj8Cwkg2YhDJqFZNAsJB0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
        x5OW1g7GPas+6B1iZOJgPMQowcGsJMIbLcoZL8SbklhZlVqUH19UmpNafIhRmoNFSZz366yF
        cUIC6YklqdmpqQWpRTBZJg5OqQYmz50662tMPu7qi5pmMymvQn/RxE2v+nMP/KmQ2cKwhqMs
        ZKHOjvTZh7yEWH52+Ees2/jMkGuHkX1h4owQo4dOW2zksrRULyT9n2Da87xv2eUy1+0eVd9P
        Spu959I9v/doeMWR1Fm5sTd1H3+N+6gjFTmjTUvFZ1KxvPQXZqHZb6Mj/wvlhuzscsubuotV
        52DflAbtqK+TZp385fS6q7TAONjwj2p2A/fxJd83Pdsk0sl0xdpV5Esus0qy3vz09KTWpO8/
        Dc0Lv2ktnvZ7a1B3QMyTU+4v3//M8vOenZnIm6zAb6kXElzinfnUc8GRivb853tZFDf3N2zP
        mf1UaJJPQI9Cx7tFKUyaPrt/nVFiKc5INNRiLipOBAD64VnTFgMAAA==
X-CMS-MailID: 20200713021929epcas1p4b187bfc24619bd8044197610ac143e5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200626061009epcas1p24585a6472e7103dc878bf9fc1d0f7d12
References: <CGME20200626061009epcas1p24585a6472e7103dc878bf9fc1d0f7d12@epcas1p2.samsung.com>
        <20200626060947.24709-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add validation for num, bh and type on getting dir-entry.
> ('file' and 'stream-ext' dir-entries are pre-validated to ensure success)
> Renamed exfat_get_dentry_cached() to exfat_get_validated_dentry() due to a
> change in functionality.
> 
> Integrate type-validation with simplified.
> This will also recognize a dir-entry set that contains 'benign secondary'
> dir-entries.
> 
> And, rename TYPE_EXTEND to TYPE_NAME.
> 
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c      | 144 ++++++++++++++++++--------------------------
>  fs/exfat/exfat_fs.h |  15 +++--
>  fs/exfat/file.c     |   4 +-
>  fs/exfat/inode.c    |   6 +-
>  fs/exfat/namei.c    |   4 +-
>  5 files changed, 73 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> f4cea9a7fd02..e029e0986edc 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
[snip]
>   */
>  struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block
*sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type)
> +		struct exfat_chain *p_dir, int entry, int max_entries)
>  {
>  	int ret, i, num_bh;
> -	unsigned int off, byte_offset, clu = 0;
> +	unsigned int byte_offset, clu = 0;
>  	sector_t sec;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct exfat_entry_set_cache *es;
>  	struct exfat_dentry *ep;
> -	int num_entries;
> -	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
>  	struct buffer_head *bh;
> 
>  	if (p_dir->dir == DIR_DELETED) {
> @@ -844,13 +815,13 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  		return NULL;
>  	es->sb = sb;
>  	es->modified = false;
> +	es->num_entries = 1;
> 
>  	/* byte offset in cluster */
>  	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
> 
>  	/* byte offset in sector */
> -	off = EXFAT_BLK_OFFSET(byte_offset, sb);
> -	es->start_off = off;
> +	es->start_off = EXFAT_BLK_OFFSET(byte_offset, sb);
> 
>  	/* sector offset in cluster */
>  	sec = EXFAT_B_TO_BLK(byte_offset, sb); @@ -861,15 +832,12 @@ struct
> exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  		goto free_es;
>  	es->bh[es->num_bh++] = bh;
> 
> -	ep = exfat_get_dentry_cached(es, 0);
> -	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> +	if (!ep)
>  		goto free_es;
> +	es->num_entries = min(ep->dentry.file.num_ext + 1, max_entries);
> 
> -	num_entries = type == ES_ALL_ENTRIES ?
> -		ep->dentry.file.num_ext + 1 : type;
> -	es->num_entries = num_entries;
> -
> -	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE,
> sb);
> +	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off  + es->num_entries *
> +DENTRY_SIZE, sb);
>  	for (i = 1; i < num_bh; i++) {
>  		/* get the next sector */
>  		if (exfat_is_last_sector_in_cluster(sbi, sec)) { @@ -889,11
> +857,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct
> super_block *sb,
>  	}
> 
>  	/* validiate cached dentries */
> -	for (i = 1; i < num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))

> +	for (i = 1; i < es->num_entries; i++) {
> +		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
>  			goto free_es;
>  	}
> +	if (!exfat_get_validated_dentry(es, 1, TYPE_STREAM))
> +		goto free_es;

It looks better to move checking TYPE_STREAM above the for-loop.
And then for-loop should start from index 2.

BTW, do you think it is enough to check only TYPE_SECONDARY not TYPE NAME?
As you might know, FILE, STREAM and NAME entries must be consecutive in
order.

> +
>  	return es;
> 

