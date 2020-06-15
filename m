Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E811F8BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 02:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgFOASt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 20:18:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:37670 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgFOASs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:18:48 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200615001845epoutp01e3154c10afe1a4603988b75ce082deca~Yj5IALXQW0915309153epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:18:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200615001845epoutp01e3154c10afe1a4603988b75ce082deca~Yj5IALXQW0915309153epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592180325;
        bh=V6/8DezWH8PzYjBA5puOibvXVjWNyGR5RWHz/aMlgVg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fLVmanDIXzvbg6vdX01N2KDCqygi51UOSIxFRcSyaPhBdSyWOvGgCZ1zRyHVZPWVx
         /MvuurAgQ080g75UjQSZ11TDqdFEuDkhQP6i8ssuU8/KtMsUI0FbOOdaNLhkto9ySp
         648lIwH/BddoqpTsT0uIQv8KFLhCy0+TY18JCY+U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200615001845epcas1p157e0e1390fb1ce353f7f1e3f88f2b2b1~Yj5HoCEqW2119221192epcas1p1i;
        Mon, 15 Jun 2020 00:18:45 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49lX4M0RrczMqYkr; Mon, 15 Jun
        2020 00:18:43 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.8D.29173.26EB6EE5; Mon, 15 Jun 2020 09:18:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200615001842epcas1p261adde276bcab86b90a73e0a1e58a0c9~Yj5FSRzcO0252602526epcas1p2K;
        Mon, 15 Jun 2020 00:18:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615001842epsmtrp1455dddd390f33f20cc4f551eb4947939~Yj5FNl_vq0743407434epsmtrp1O;
        Mon, 15 Jun 2020 00:18:42 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-d1-5ee6be62299a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.E0.08382.26EB6EE5; Mon, 15 Jun 2020 09:18:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200615001842epsmtip2bfd10b61dc137cb2c491c470a28335e6~Yj5FGFFm80266502665epsmtip2S;
        Mon, 15 Jun 2020 00:18:42 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <20200612094250.9347-2-hyc.lee@gmail.com>
Subject: RE: [PATCH 2/2] exfat: allow to change some mount options for
 remount
Date:   Mon, 15 Jun 2020 09:18:42 +0900
Message-ID: <001501d642aa$8699aca0$93cd05e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLoIJeKvN4MET9VoLaZYw+wi+h82gKmMzPjAhLrcmemj0pOMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmrm7yvmdxBvNjLa7df89usWfvSRaL
        y7vmsFls+XeE1YHFY+esu+wefVtWMXp83iQXwByVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxv
        amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtExJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquU
        WpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTcfHSGpaCtaIVD1rfMTYwHhHsYuTkkBAw
        kfg/cxVzFyMXh5DADkaJ1UemsIEkhAQ+MUq8P+YLkfjGKPG86wcjTMefBX/YIBJ7GSUWfz3P
        BOG8BHJ+b2MCqWIT0JX492c/2CgRAQ2JfycfgcWZBQok1u49wwpicwqYSZzfsBtsqrBAgMT2
        pQvB4iwCqhKHj0xnB7F5BSwldvXuZ4KwBSVOznzCAjFHXmL72znMEBcpSPx8uowVYpeTxK+p
        M1ghakQkZne2gf0mIfCVXWLKux6oBheJG7eWMEHYwhKvjm9hh7ClJF72twHZHEB2tcTH/VDl
        HYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3XEaItXwS7772sEJM4ZXoaBOCKFGV6Lt0
        GGqptERX+wf2CYxKs5A8NgvJY7OQPDALYdkCRpZVjGKpBcW56anFhgXGyHG9iRGcDrXMdzBO
        e/tB7xAjEwfjIUYJDmYlEd7utCdxQrwpiZVVqUX58UWlOanFhxhNgUE9kVlKNDkfmJDzSuIN
        TY2MjY0tTMzMzUyNlcR5fa0uxAkJpCeWpGanphakFsH0MXFwSjUwCZrn1VYFlS38r87PJJ8e
        yO436bXFlYysuMTsC2xihYnJk+vPKpa5rCiYnrPCUKjgSWPaTa5/iSu235HWSsnoyfzQ8ll3
        n+HH1w9+WtQ8jTB4vpN7945Z6lv36k1/wKOwcx3r9vo7O+yFeT67mjM/4loyNUqxWK90l3CQ
        f9XaWMu1Z+3W2klJlc29e09M4EhuZcrLUqkVWiVtyxtTfOYZXpSPZPkguaDxY/2rkrMWe47d
        cpu+JfZy4k+z3ZYBRdumPT558s1yY+VbOyz2N8ecld2+5ELrKf8n8264Lzshxbrcef0bCyvG
        c72n3rv8OBphLfFtzp5bRUzdKiLcQQZbgt7fvOTrdE3k5sOEyrk3lFiKMxINtZiLihMBDKxE
        zRAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvG7SvmdxBh/Pylhcu/+e3WLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvj4qU1LAVrRSse
        tL5jbGA8ItjFyMkhIWAi8WfBH7YuRi4OIYHdjBJXV29ghUhISxw7cYa5i5EDyBaWOHy4GKLm
        OaPEtIU7GUFq2AR0Jf792c8GYosIaEj8O/mICcRmFiiSuN97nh2iYSOjxMV329lBEpwCZhLn
        N+wGaxYW8JOYdnUCWAOLgKrE4SPTwWp4BSwldvXuZ4KwBSVOznzCAnIEs4CeRNtGRoj58hLb
        385hhrhTQeLn02WsEDc4SfyaOoMVokZEYnZnG/MERuFZSCbNQpg0C8mkWUg6FjCyrGKUTC0o
        zk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4MLc0djNtXfdA7xMjEwXiIUYKDWUmEtzvtSZwQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1MLUotgskwcnFINTG61s74kTNx1
        dd2RQgsbjy9f5/Bm97kGmy/Y1SYSFVGseKM71Sxsr/DUop9Jxh9TMuTfd86fMtVA1FXz/4q7
        GTFW7v9Wf8h6WBZqulqN9cb/jW46zZfY2WYUyPjcnJD46ULA/F3eswVbpB9yxfB3z7tfOKXj
        HL9JdIbtn2NSapluUebz17E8bhZ65c/Y9PTsno9X+WNbufo0eHJvMD6bYNAjeE7Id6nIVpX5
        NTKvZNcG3nAv04pbO3Pl5Q0Zcs/tXxueivGbPv+cx1Wpa84h3OtDPexdppi4xf/7OG/S8epp
        u0QTgs7FzzxsVbqLY5WQddwnRtOOp+45jVHhHAlSBQ6T50UfzxTb/YKtyzJKiaU4I9FQi7mo
        OBEA3iyFQvsCAAA=
X-CMS-MailID: 20200615001842epcas1p261adde276bcab86b90a73e0a1e58a0c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612094318epcas1p30139d60fdcfc3672fede8977c536a5a8
References: <20200612094250.9347-1-hyc.lee@gmail.com>
        <CGME20200612094318epcas1p30139d60fdcfc3672fede8977c536a5a8@epcas1p3.samsung.com>
        <20200612094250.9347-2-hyc.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Allow to change permission masks, allow_utime, errors. But ignore other options.
> 
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/exfat/super.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index 61c6cf240c19..3c1d47289ba2 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -696,9 +696,13 @@ static void exfat_free(struct fs_context *fc)  static int
> exfat_reconfigure(struct fs_context *fc)  {
>  	struct super_block *sb = fc->root->d_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_mount_options *new_opts;
>  	int ret;
>  	bool new_rdonly;
> 
> +	new_opts = &((struct exfat_sb_info *)fc->s_fs_info)->options;
> +
>  	new_rdonly = fc->sb_flags & SB_RDONLY;
>  	if (new_rdonly != sb_rdonly(sb)) {
>  		if (new_rdonly) {
> @@ -708,6 +712,12 @@ static int exfat_reconfigure(struct fs_context *fc)
>  				return ret;
>  		}
>  	}
> +
> +	/* allow to change these options but ignore others */
> +	sbi->options.fs_fmask = new_opts->fs_fmask;
> +	sbi->options.fs_dmask = new_opts->fs_dmask;
> +	sbi->options.allow_utime = new_opts->allow_utime;
> +	sbi->options.errors = new_opts->errors;
Is there any reason why you allow a few options on remount ?
>  	return 0;
>  }
> 
> @@ -726,17 +736,25 @@ static int exfat_init_fs_context(struct fs_context *fc)
>  	if (!sbi)
>  		return -ENOMEM;
> 
> -	mutex_init(&sbi->s_lock);
> -	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
> -			DEFAULT_RATELIMIT_BURST);
> -
> -	sbi->options.fs_uid = current_uid();
> -	sbi->options.fs_gid = current_gid();
> -	sbi->options.fs_fmask = current->fs->umask;
> -	sbi->options.fs_dmask = current->fs->umask;
> -	sbi->options.allow_utime = -1;
> -	sbi->options.iocharset = exfat_default_iocharset;
> -	sbi->options.errors = EXFAT_ERRORS_RO;
> +	if (fc->root) {
> +		/* reconfiguration */
> +		memcpy(&sbi->options, &EXFAT_SB(fc->root->d_sb)->options,
> +			sizeof(struct exfat_mount_options));
> +		sbi->options.iocharset = exfat_default_iocharset;
> +	} else {
> +		mutex_init(&sbi->s_lock);
> +		ratelimit_state_init(&sbi->ratelimit,
> +				DEFAULT_RATELIMIT_INTERVAL,
> +				DEFAULT_RATELIMIT_BURST);
> +
> +		sbi->options.fs_uid = current_uid();
> +		sbi->options.fs_gid = current_gid();
> +		sbi->options.fs_fmask = current->fs->umask;
> +		sbi->options.fs_dmask = current->fs->umask;
> +		sbi->options.allow_utime = -1;
> +		sbi->options.iocharset = exfat_default_iocharset;
> +		sbi->options.errors = EXFAT_ERRORS_RO;
> +	}
> 
>  	fc->s_fs_info = sbi;
>  	fc->ops = &exfat_context_ops;
> --
> 2.17.1


