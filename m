Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C923F843
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHHQyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 12:54:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20568 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgHHQyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:54:21 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200808165418epoutp04fe1ac1a962ef993041bc634cf89083e1~pWTxc3Shd0483004830epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2020 16:54:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200808165418epoutp04fe1ac1a962ef993041bc634cf89083e1~pWTxc3Shd0483004830epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596905658;
        bh=9lryJaJU/2KwccJb4MICe609DEgjpkAPMFrPalOZsEY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mezq/gR8ruRbjYu5edvfMdp1l6dmgUXSXzbYVE0W/tU23q+zuqCiHZ5fY0cmrx4E/
         rebwQEOZ7FzVum0v0a3CsKGJr9kcXBoyUg8eXzSQ9s9U2tzcBg9dp39hoXsVNs9TtG
         7kTKCgZw43AZav2S1UPniLdxBGB0P77lcaNcSSXI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200808165417epcas1p13615ef1ab311446983f64c45b8ce27c0~pWTwyp5641200012000epcas1p1S;
        Sat,  8 Aug 2020 16:54:17 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BP7c92khQzMqYlp; Sat,  8 Aug
        2020 16:54:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.41.28581.9B8DE2F5; Sun,  9 Aug 2020 01:54:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200808165416epcas1p2416fb83a1aef85b26e988506ddf40957~pWTvkUjdn2216522165epcas1p29;
        Sat,  8 Aug 2020 16:54:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200808165416epsmtrp255d7f8756d34215ab41c1fe5a8cd87ed~pWTvjnRJk1688716887epsmtrp2e;
        Sat,  8 Aug 2020 16:54:16 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-00-5f2ed8b933a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.84.08303.8B8DE2F5; Sun,  9 Aug 2020 01:54:16 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200808165416epsmtip1980e1ea9177666770531745d722d7eef~pWTvXWP1R2415024150epsmtip1l;
        Sat,  8 Aug 2020 16:54:16 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806055653.9329-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/2] exfat: add NameLength check when extracting name
Date:   Sun, 9 Aug 2020 01:54:16 +0900
Message-ID: <000101d66da4$8d1b5090$a751f1b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIwMLarA2VYI8mxvZxjVR+ndD8PyAGp1IjqqG2T2rA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmge7OG3rxBkev8lv8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISfj1ubvTAXXpSqWzWtgbWCcJtrFyMkhIWAisajlB3sXIxeHkMAORonu/rnMEM4n
        Rok/rauYIJzPjBKz1k5hgmn5u/8WC0RiF6PE177jzCAJIYGXjBJTnvuA2GwCuhJPbvwEi4sI
        6EmcPHmdDcRmFmhkkjjxMhvE5hSwkPjzZxsriC0s4CmxrXUykM3BwSKgInHvXgyIyStgKdE+
        3xWkgldAUOLkzCcsEFPkJba/ncMMcY6CxO5PR1khNllJfH6xFqpGRGJ2ZxtUzVIOiRtrFCBs
        F4kzEzsYIWxhiVfHt7BD2FISn9/tZYOw6yX+z18LDhUJgRZGiYeftjGB3CMhYC/x/pIFiMks
        oCmxfpc+RLmixM7fcxkh1vJJvPvawwpRzSvR0SYEUaIi8f3DThaYTVd+XGWawKg0C8ljs5A8
        NgvJA7MQli1gZFnFKJZaUJybnlpsWGCCHNObGMFpVMtiB+Pctx/0DjEycTAeYpTgYFYS4c16
        oR0vxJuSWFmVWpQfX1Sak1p8iNEUGNATmaVEk/OBiTyvJN7Q1MjY2NjCxMzczNRYSZz34S2F
        eCGB9MSS1OzU1ILUIpg+Jg5OqQYmW96moi82OhWMErfc78Vd0tOYc+hGZm7txpSFOdLmnYlM
        8RtnR5xyEfJ9MNuKV1ZStszizNU6lifsC7Rz1z9Qfyb6+XdEgrm65a5fUUcZJ6bsO7H63ZLN
        iWIVntL3mNOLim08uTKvzj5lmboh/P8Diwgtb5MjclP2RAXd/RU/a7fApnezHx/RPrbHc/ae
        2geGbS0LI1j2zX8hdnMd40qj/2fL7j8ttCubvV9qgQzjlpcu9423qp5lmfecqWAFa6YHy2cj
        jZ63x86yz8sxPars+4azqflX058DW82WO551T+eacPfIYuYXDAI/Nr6y8Drbwu/qKrD8yGTL
        q8fY3qcFzdvp9j7K7pXU+ZsLllTFKbEUZyQaajEXFScCAFe18vQsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTnfHDb14gz1zFC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKuLX5O1PBdamKZfMaWBsYp4l2MXJySAiYSPzdf4uli5GL
        Q0hgB6PElrZP7F2MHEAJKYmD+zQhTGGJw4eLIUqeM0pMnnyAHaSXTUBX4smNn8wgtoiAnsTJ
        k9fZQIqYBZqZJFq/NDNBdHQyStw/84QRpIpTwELiz59trCC2sICnxLbWyawgG1gEVCTu3YsB
        MXkFLCXa57uCVPAKCEqcnPmEBSTMDDS/bSPYEGYBeYntb+cwQ5yvILH701FWiBOsJD6/WMsC
        USMiMbuzjXkCo/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBMeTltYOxj2rPugdYmTiYDzEKMHBrCTCm/VCO16INyWxsiq1KD++qDQntfgQozQHi5I4
        79dZC+OEBNITS1KzU1MLUotgskwcnFINTFuFXe4KXDttfrnMl3PDyzkJ95ova8hpTzx6ViE4
        5b7OsYATS8OFMjkZ/ERPFpyaZZ5psb7+ifj7FS+25p4tq5hlUDpZLpsheP/GF4dLF2bFfWH+
        fuZblfdKn7MzfgcV7izetvzK+tbNsr9NdHrZ2JaV1kmFaDBevhy7NPBNsz3r66VNF2qtby8/
        fM/f3u/uFSGJUJWc3A03TQKeXOMp/Oy7rX2R1kfV2QJCIfrt5qELfWKKLx5NZHvRfl9p3yS/
        nHv3nhmKXomYaHBHiUtJ4NrNUI/VC0VCspjZl+jvePpk1V9WU8+Tl88HmkpO/1Z+8fFF/4eb
        Ze6+ZPaWKl5z4tKvtlBmh8z0T/p7l7PcWK3EUpyRaKjFXFScCADs7RJeFgMAAA==
X-CMS-MailID: 20200808165416epcas1p2416fb83a1aef85b26e988506ddf40957
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806055718epcas1p33009b21ebf96b48d6e3f819065fade28
References: <CGME20200806055718epcas1p33009b21ebf96b48d6e3f819065fade28@epcas1p3.samsung.com>
        <20200806055653.9329-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The current implementation doesn't care NameLength when extracting the
> name from Name dir-entries, so the name may be incorrect.
> (Without null-termination, Insufficient Name dir-entry, etc) Add a
> NameLength check when extracting the name from Name dir-entries to extract
> correct name.
> And, change to get the information of file/stream-ext dir-entries via the
> member variable of exfat_entry_set_cache.
> 
> ** This patch depends on:
>   '[PATCH v3] exfat: integrates dir-entry getting and validation'.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c | 81 ++++++++++++++++++++++++--------------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 91cdbede0fd1..545bb73b95e9 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -28,16 +28,15 @@ static int exfat_extract_uni_name(struct exfat_dentry
> *ep,
> 
>  }
> 
> -static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned short
> *uniname)
> +static int exfat_get_uniname_from_name_entries(struct
> exfat_entry_set_cache *es,
> +		struct exfat_uni_name *uniname)
>  {
> -	int i;
> -	struct exfat_entry_set_cache *es;
> +	int n, l, i;
>  	struct exfat_dentry *ep;
> 
> -	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
> -	if (!es)
> -		return;
> +	uniname->name_len = es->de_stream->name_len;
> +	if (uniname->name_len == 0)
> +		return -EIO;

-EINVAL looks better.

> 
>  	/*
>  	 * First entry  : file entry
> @@ -45,14 +44,15 @@ static void exfat_get_uniname_from_ext_entry(struct
> super_block *sb,
>  	 * Third entry  : first file-name entry
>  	 * So, the index of first file-name dentry should start from 2.
>  	 */
> -
> -	i = 2;
> -	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
> -		exfat_extract_uni_name(ep, uniname);
> -		uniname += EXFAT_FILE_NAME_LEN;
> +	for (l = 0, n = 2; l < uniname->name_len; n++) {
> +		ep = exfat_get_validated_dentry(es, n, TYPE_NAME);
> +		if (!ep)
> +			return -EIO;
> +		for (i = 0; l < uniname->name_len && i <
EXFAT_FILE_NAME_LEN;
> i++, l++)
> +			uniname->name[l] = le16_to_cpu(ep-
> >dentry.name.unicode_0_14[i]);

Looks good.

>  	}
> -
> -	exfat_free_dentry_set(es, false);
> +	uniname->name[l] = 0;
> +	return 0;
>  }
> 
>  /* read a directory entry from the opened directory */ @@ -63,6 +63,7 @@
> static int exfat_readdir(struct inode *inode, struct exfat_dir_entry
> *dir_entry)
[snip]
> -			*uni_name.name = 0x0;
> -			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
> -				uni_name.name);
> +			dir_entry->size = le64_to_cpu(es->de_stream-
> >valid_size);
> +
> +			exfat_get_uniname_from_name_entries(es, &uni_name);

Modified function has a return value.
It would be better to check the return value.

>  			exfat_utf16_to_nls(sb, &uni_name,
>  				dir_entry->namebuf.lfn,
>  				dir_entry->namebuf.lfnbuf_len);
> -			brelse(bh);
> 
> -			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
> -			if (!ep)
> -				return -EIO;
> -			dir_entry->size =
> -				le64_to_cpu(ep->dentry.stream.valid_size);
> -			brelse(bh);
> +			exfat_free_dentry_set(es, false);
> 
>  			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
>  			ei->hint_bmap.clu = clu.dir;
> --
> 2.25.1


