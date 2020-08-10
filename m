Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E072401F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHJGTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 02:19:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26464 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgHJGTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:19:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200810061917epoutp04f3287d1d3da8fcc55c448a692aed1b08~p075gvY7v0109901099epoutp04S
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 06:19:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200810061917epoutp04f3287d1d3da8fcc55c448a692aed1b08~p075gvY7v0109901099epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597040357;
        bh=pl/vEqyNjLEKOCD7oTujFun7nuCZY4kYMueXZFaegQM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pB3dJ4AQ20Hqfnu6Cc3OczED5hJxKv/71DBb1Fa/i58gZEfSjQ4DlK6MNuFvRGbEt
         ldBy38dhGMd2wGdzwpELZeOLjjZs0gU8L/CxnnqOL+45LE9+VKSsVOlrJyXmjCMYV7
         j+vz3RU3JS6mW+0AElDQsx9PXLJhZZhPw9ROXMPQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200810061917epcas1p48d74d72d3de45310ea8076bf1de9ceb0~p075OLRDW1771417714epcas1p4B;
        Mon, 10 Aug 2020 06:19:17 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BQ5QX1rGrzMqYkt; Mon, 10 Aug
        2020 06:19:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.AE.29173.4E6E03F5; Mon, 10 Aug 2020 15:19:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200810061915epcas1p167bead5d44e5038f0ba5c7cc472f2ba4~p07386pIy1084210842epcas1p1I;
        Mon, 10 Aug 2020 06:19:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200810061915epsmtrp16003c7318a60fa7d5ca4e502567e5676~p0738LOLe0465504655epsmtrp1r;
        Mon, 10 Aug 2020 06:19:15 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-f4-5f30e6e454a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.EE.08382.3E6E03F5; Mon, 10 Aug 2020 15:19:15 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200810061915epsmtip2262d7bb9731e5b5216cfa16f58d71e42~p073zuWOI1954919549epsmtip2Y;
        Mon, 10 Aug 2020 06:19:15 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807073049.24959-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/2] exfat: add dir-entry set checksum validation
Date:   Mon, 10 Aug 2020 15:19:15 +0900
Message-ID: <003e01d66ede$2c2fe620$848fb260$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLsnZ32wlxHCUqEzWOkR1uvxcSCrQHsAWFWpvUfkPA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmge6TZwbxBofWc1v8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxtLnbgV/RCsmz+5nbWB8LtjFyMkhIWAiceLDNLYuRi4OIYEdjBJntrSzgiSE
        BD4xSjy/VwSR+MYocWPuK2aYjul/j7JDJPYCJRZsZ4FwXjJK/H7ygQWkik1AV+Lfn/1sILaI
        gJ7EyZPXwXYwCzQySSw/8QVsFKeApcSW+bPB9gkLuErcu7cFrJlFQFVi3+ErjCA2L1DNlEmP
        mSFsQYmTM5+A1TALyEtsfzsH6iQFiZ9PlwHN4QBaZiXxdYIiRImIxOzONmaQvRICCzkkZnVN
        hap3kei4fZcJwhaWeHV8CzuELSXxsr+NHWSOhEC1xMf9UOUdjBIvvttC2MYSN9dvAFvFLKAp
        sX6XPkRYUWLn77mMEGv5JN597WGFmMIr0dEmBFGiKtF36TDUUmmJrvYP7BMYlWYh+WsWkr9m
        IXlgFsKyBYwsqxjFUguKc9NTiw0LjJGjehMjOJVqme9gnPb2g94hRiYOxkOMEhzMSiK8dnf1
        44V4UxIrq1KL8uOLSnNSiw8xmgJDeiKzlGhyPjCZ55XEG5oaGRsbW5iYmZuZGiuJ8z68pRAv
        JJCeWJKanZpakFoE08fEwSnVwDQ9WyLzfFmNdd+ckLXz7Zatm+riwXNi7YSMOAuvpPbUxyeu
        n/9dzud5ZOfMpbN3bw7z2bqgZG7M2U5r9SmuglWXNa8wP2H81+JkGKOh+7qCg/sk2y2huNov
        7RuE97p/dzvIUZc36Vfi8w889fGnu48dnzyr+P5Tu+qE2nX6/o4vJ4X+Svf5rBrGvVXhZ7ZN
        yZ9plUf4BMJer5jIL8Hf2XBIdq322qS6w1czNqwWrUrIu8GynFsmRyv/Zn9Y47384x7Rc+ax
        aleb/2Hb1t6XIiYjf/iGZuMBFZFfJnxbWKbqX5a4nvBoYUbg3YZs/jlav7ddjpSprv9Z6n7a
        2f+uTccytvWpKzPOJOv2eeyMVWIpzkg01GIuKk4EAOsYJT0uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXvfxM4N4gwO/9Cx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlbH0uVvBH9GKybP7WRsYnwt2MXJySAiYSEz/e5S9i5GL
        Q0hgN6PEps13mCES0hLHTpwBsjmAbGGJw4eLIWqeM0p8aL/GAlLDJqAr8e/PfjYQW0RAT+Lk
        yetsIEXMAs1MEt+eLWGG6OhilHhwupkVpIpTwFJiy/zZYLawgKvEvXtbwCaxCKhK7Dt8hRHE
        5gWqmTLpMTOELShxcuYTFpArmIE2tG0EK2EWkJfY/nYO1KEKEj+fLmMFKRERsJL4OkERokRE
        YnZnG/MERuFZSAbNQhg0C8mgWUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93E
        CI4pLc0djNtXfdA7xMjEwXiIUYKDWUmE1+6ufrwQb0piZVVqUX58UWlOavEhRmkOFiVx3huF
        C+OEBNITS1KzU1MLUotgskwcnFINTNPMKoTeaczetunHXNstCwPn/AtvXXlC4OPBu9+El31u
        E5gatC1O8l30p7+5QrxVeySKb53mjHXcvIUjfY24zY8Ohe8tZ46rmBbbzH/nMtHZoFHnZvOF
        hvitH8X4PjzZURDI8TdZcO3+K9dn5Qa8eGe/rNZISNLrRZrUPVPRvU3L+7dMa/h7YLZW3keN
        CW/VbR6nbfQ6/uRS8u0SNbFrNU+CH//6UNRUI+Fx8bfP/5meHM4qe00bnTzuPUt/uv5+2/oy
        pk/rOdiTmdySHCxDPItbLXe/qc46Wi5genfeQdfUe7f7376Zctvhg/LUvBcdQvEKfQYO/x36
        lyvNWO94bd1hA6572ff2aHyuO/A4hFGJpTgj0VCLuag4EQD6M1sCGAMAAA==
X-CMS-MailID: 20200810061915epcas1p167bead5d44e5038f0ba5c7cc472f2ba4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200807073101epcas1p43ba30d0ff54cb09f90b7dc69c746d3e6
References: <CGME20200807073101epcas1p43ba30d0ff54cb09f90b7dc69c746d3e6@epcas1p4.samsung.com>
        <20200807073049.24959-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add checksum validation for dir-entry set when getting it.
> exfat_calc_dir_chksum_with_entry_set() also validates entry-type.
> 
> ** This patch depends on:
>   '[PATCH v3] exfat: integrates dir-entry getting and validation'
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index c9715c7a55a1..2e79ac464f5f 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -563,18 +563,27 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
>  	return 0;
>  }
> 
> -void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
> +static int exfat_calc_dir_chksum_with_entry_set(struct
> +exfat_entry_set_cache *es, u16 *chksum)
>  {
> -	int chksum_type = CS_DIR_ENTRY, i;
> -	unsigned short chksum = 0;
>  	struct exfat_dentry *ep;
> +	int i;
> 
> -	for (i = 0; i < es->num_entries; i++) {
> -		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
> -		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
> -					     chksum_type);
> -		chksum_type = CS_DEFAULT;
> +	ep = container_of(es->de_file, struct exfat_dentry, dentry.file);
> +	*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
> +	for (i = 0; i < es->de_file->num_ext; i++) {
> +		ep = exfat_get_validated_dentry(es, 1 + i, TYPE_SECONDARY);
> +		if (!ep)
> +			return -EIO;
> +		*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, *chksum, CS_DEFAULT);
>  	}
> +	return 0;
We can return checksum after removing u16 *chksum argument.
> +}
> +
> +void exfat_update_dir_chksum_with_entry_set(struct
> +exfat_entry_set_cache *es) {
> +	u16 chksum;
> +
> +	exfat_calc_dir_chksum_with_entry_set(es, &chksum);
>  	es->de_file->checksum = cpu_to_le16(chksum);
>  	es->modified = true;
>  }
> @@ -775,6 +784,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  	struct exfat_entry_set_cache *es;
>  	struct exfat_dentry *ep;
>  	struct buffer_head *bh;
> +	u16 chksum;
> 
>  	if (p_dir->dir == DIR_DELETED) {
>  		exfat_err(sb, "access to deleted dentry"); @@ -839,10 +849,10 @@ struct
> exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  		goto free_es;
>  	es->de_stream = &ep->dentry.stream;
> 
> -	for (i = 2; i < es->num_entries; i++) {
> -		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
> -			goto free_es;
> -	}
> +	if (max_entries == ES_ALL_ENTRIES &&
> +	    ((exfat_calc_dir_chksum_with_entry_set(es, &chksum) ||
> +	      chksum != le16_to_cpu(es->de_file->checksum))))
Please add error print log if checksum mismatch error happen.
> +		goto free_es;
> 
>  	return es;
> 
> --
> 2.25.1


