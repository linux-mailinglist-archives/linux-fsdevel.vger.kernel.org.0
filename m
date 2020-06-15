Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1471F8BD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFOAOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 20:14:48 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17494 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgFOAOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:14:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200615001443epoutp027dbb373844051a9e8d83691e5d217c2d~Yj1m_mZVj0404304043epoutp020
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:14:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200615001443epoutp027dbb373844051a9e8d83691e5d217c2d~Yj1m_mZVj0404304043epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592180083;
        bh=Akp5EA8etJhHAQSlM/rwn2tsGZ7YAFRwkc7IVXdPecw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OGvwz0GxLP+fwlBLxpFix4yPJO3jaGfoGNiC8bJt//4iP5su7MsPj0/9HgHexTZNA
         STevVUhiEngGZ05jTxPxy/DpYAoZJKwjDdYKkkvzUXlmq9++74OsFVOixFA/YLpgMC
         jbzT9XjUUEfjYka/xRNvQE0jh929OKyvEfLy56/8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200615001443epcas1p15f84268d828bfb43e91e867a26b64fbd~Yj1mnC0vA0833108331epcas1p1j;
        Mon, 15 Jun 2020 00:14:43 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49lWzk6KvJzMqYkr; Mon, 15 Jun
        2020 00:14:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.3C.29173.27DB6EE5; Mon, 15 Jun 2020 09:14:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200615001442epcas1p2a1a4ae1b8ed916cf31223b6cde27a8f2~Yj1lZgitp1309013090epcas1p20;
        Mon, 15 Jun 2020 00:14:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615001442epsmtrp1c930b86e083243841f8c0ee3a6258ea3~Yj1lY0O4v0486504865epsmtrp1E;
        Mon, 15 Jun 2020 00:14:42 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-bb-5ee6bd725a8e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.A0.08382.27DB6EE5; Mon, 15 Jun 2020 09:14:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200615001441epsmtip29f4f17c796cbdaa755668efabd641006~Yj1lLuYQI0202702027epsmtip28;
        Mon, 15 Jun 2020 00:14:41 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <20200612094250.9347-1-hyc.lee@gmail.com>
Subject: RE: [PATCH 1/2] exfat: call sync_filesystem for read-only remount
Date:   Mon, 15 Jun 2020 09:14:41 +0900
Message-ID: <001401d642a9$f74c3040$e5e490c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIBJJ4yXVc624qtmpPir+DFyChZQwLoIJeKqGvGHHA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmvm7R3mdxBj9v6lpcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5KscmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ2Nm602mghk8FXf797I0MB7k7GLk5JAQ
        MJGYuescSxcjF4eQwA5Gif0Nm6CcT4wSP7b/YIZwvjFK/D3ymLGLkQOs5fQxQYj4XkaJ5e9v
        M4OMEhJ4ySjx604yiM0moCvx789+NhBbREBD4t/JR0wgNrNAgcTavWdYQWxOATOJf5dugcWF
        BbwkrnXsA6tnEVCV6Pv5GqyGV8BS4uaqacwQtqDEyZlPWCDmyEtsfzuHGeIFBYmfT5exgtwm
        ImAlcaAzD6JERGJ2ZxtUyVd2ielzRSFsF4l3f6axQNjCEq+Ob2GHsKUkXva3sUO8WC3xcT9U
        awejxIvvthC2scTN9RvANjELaEqs36UPEVaU2Pl7LiPEVj6Jd197WCGm8Ep0tAlBlAD9dOkw
        E4QtLdHV/oF9AqPSLCRvzULy1iwk989CWLaAkWUVo1hqQXFuemqxYYExckRvYgSnQi3zHYzT
        3n7QO8TIxMF4iFGCg1lJhLc77UmcEG9KYmVValF+fFFpTmrxIUZTYEBPZJYSTc4HJuO8knhD
        UyNjY2MLEzNzM1NjJXFeX6sLcUIC6YklqdmpqQWpRTB9TBycUg1MHId3u55dL/TRylz1gxzr
        K7PoKrvrzev+Z1zjU9sXFfdSnHutRJSF+eepfz5uWcoVXljR7pYdlWhx6KTs5+MKYSof5y1X
        L+RdHrb8csXlZ3LTvFf5zrwQKDitc0mN7qv8hfWl6YECLReMDAW7zW+7be6eLaFz7snfZ6Ze
        +UmnLrhOPcNQu31W5J5F15b6awa2iF+IXMfWceT5xdiCE3ba6WfEHxZx7Ff6LdHXEhvAmClr
        5Dv3tZaexZM/a78uXLNKemr8tLs7qu6WRyzbKh2t8EdiQ/lxuUNPHlostpf+MWGt7rN1wl2b
        tx0OfPLD93d800e+gxaPdvjfq/Rp4cm77Wwob+b37npacP3z14f4lViKMxINtZiLihMBj1iI
        Uw4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvG7R3mdxBodOsVpcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugStjZutNpoIZPBV3
        +/eyNDAe5Oxi5OCQEDCROH1MsIuRi0NIYDejxLKp79m7GDmB4tISx06cYYaoEZY4fLgYouY5
        o8Trw5tZQGrYBHQl/v3ZzwZiiwhoSPw7+YgJxGYWKJK433ueHaKhnVFi77yPYEWcAmYS/y7d
        AisSFvCSuNaxDyzOIqAq0ffzNSuIzStgKXFz1TRmCFtQ4uTMJywgRzAL6Em0bWSEmC8vsf3t
        HGaIOxUkfj5dxgpSIiJgJXGgMw+iRERidmcb8wRG4VlIBs1CGDQLyaBZSDoWMLKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgotzR2M21d90DvEyMTBeIhRgoNZSYS3O+1JnBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTBycUg1M23jW5v/cvLv4
        6bObzDt+8Gju99mgeHR+5YI//g5Xi0/5Fs9bOycqzqp65gq156IvPLrDbrqJH+fIedTDObHa
        3iHMXDEz8mho2crvBn5Jtx6XW3ybvPhbgWu39N6T2+d0zxXjnFpvOM+m9t92x6I53ZcXXBTY
        p7vg2YXsZ4/Fazr99eapHnJlcEmJX7JzhphP35pJgVxNlz0PfEtr3h7z9COvqd9W/R2bvgXO
        XRLG/u/XdhWbm3W3jVIX1p+crdujvbL+Xd2Dh/d2l6vcPb9T0nKxQ1ywz8XLthUPKpd/e8Fp
        W9f73cr1o+WCmz3Vp/q57OZlPO9ZOVOt4OYV9+zYJU2ht7zmfn64YdqH2uJ1JkosxRmJhlrM
        RcWJADo9abH5AgAA
X-CMS-MailID: 20200615001442epcas1p2a1a4ae1b8ed916cf31223b6cde27a8f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612094312epcas1p1d8be51e8ab6e26b622e3c8437a20cfcf
References: <CGME20200612094312epcas1p1d8be51e8ab6e26b622e3c8437a20cfcf@epcas1p1.samsung.com>
        <20200612094250.9347-1-hyc.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hyunchul,
> We need to commit dirty metadata and pages to disk before remounting exfat as read-only.
> 
> This fixes a failure in xfstests generic/452
Could you please elaborate more the reason why generic/452 in xfstests failed ?
> 
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/exfat/super.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index e650e65536f8..61c6cf240c19 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -693,10 +693,29 @@ static void exfat_free(struct fs_context *fc)
>  	}
>  }
> 
> +static int exfat_reconfigure(struct fs_context *fc) {
> +	struct super_block *sb = fc->root->d_sb;
> +	int ret;
int ret = 0;
> +	bool new_rdonly;
> +
> +	new_rdonly = fc->sb_flags & SB_RDONLY;
> +	if (new_rdonly != sb_rdonly(sb)) {
If you modify it like this, would not we need new_rdonly?
        if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb))

> +		if (new_rdonly) {
> +			/* volume flag will be updated in exfat_sync_fs */
> +			ret = sync_filesystem(sb);
> +			if (ret < 0)
> +				return ret;
I think that this ret check can be removed by using return ret; below ?
> +		}
> +	}
> +	return 0;
return ret;
> +}
> +
>  static const struct fs_context_operations exfat_context_ops = {
>  	.parse_param	= exfat_parse_param,
>  	.get_tree	= exfat_get_tree,
>  	.free		= exfat_free,
> +	.reconfigure	= exfat_reconfigure,
>  };
> 
>  static int exfat_init_fs_context(struct fs_context *fc)
> --
> 2.17.1


