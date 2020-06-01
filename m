Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB661EA3AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgFAMVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:21:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28071 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFAMVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:21:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200601122119epoutp04d98c2b70ca9f2c79f12cfa25924185f5~UauAsdp9j0883508835epoutp04o
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 12:21:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200601122119epoutp04d98c2b70ca9f2c79f12cfa25924185f5~UauAsdp9j0883508835epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591014079;
        bh=cR8G8UhJZH1vpmm89wdfJzNuLbJHxWQnLT4AHHIGFhw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LVc2NgNnJdMb4MuMac3Ozw7e7DmXyLwN8at65NswqyG6psTqn5opog18bXH19+pPy
         HMWR9g8TwehaNCczreHaeya9ZNirD9S1gF0T+If7v/9U0YDfybyShepnFwcLr0w+Xn
         RwqMdowwSTHpk5IYF7rEYb4oZ7A1Zv8Y0IVRqcJw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601122118epcas1p1312c035b95997411345eaee29996d610~UauACbal72984029840epcas1p1X;
        Mon,  1 Jun 2020 12:21:18 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49bDmY4YgmzMqYlp; Mon,  1 Jun
        2020 12:21:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.24.19033.DB2F4DE5; Mon,  1 Jun 2020 21:21:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200601122117epcas1p46da0a6d26a916248d900b32f5a8d81c5~Uat_cUVJP0208002080epcas1p4X;
        Mon,  1 Jun 2020 12:21:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601122116epsmtrp1b66076f047bf5cb9ed58cae420b956c8~Uat_bvIcp1229312293epsmtrp1B;
        Mon,  1 Jun 2020 12:21:16 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-00-5ed4f2bdf975
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.73.08303.CB2F4DE5; Mon,  1 Jun 2020 21:21:16 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601122116epsmtip265605eeb427b92056df51552e2a076dc~Uat_QSYYe0351103511epsmtip2Z;
        Mon,  1 Jun 2020 12:21:16 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200531093017.12318-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 3/4 v4] exfat: add boot region verification
Date:   Mon, 1 Jun 2020 21:21:16 +0900
Message-ID: <200001d6380f$260adf80$72209e80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJWqZqndQR6yzMz7HjQ16/s2RR9CAIQqkuNp7JFjkA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvu7eT1fiDFbtU7b4Mfc2i8Wbk1NZ
        LPbsPclicXnXHDaLy/8/sVgs+zKZxeLH9HoHdo8vc46ze7RN/sfu0XxsJZvHzll32T36tqxi
        9Pi8SS6ALSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoFCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWh
        gYGRKVBlQk7G0VP/WAoeK1bM27qEuYFxt1QXIyeHhICJxNYXn9i6GLk4hAR2MErsmvaCCcL5
        xCjxYsc0dgjnM6PE5nMP2GBapjW/Y4VI7GKUOLf+DVTLS0aJIye2M4FUsQnoSjy58ZMZxBYR
        0JM4efI6WDezQCOTxImX2SA2p4ClxOw3z4EmcXAIC9hLLOirBQmzCKhI/Du+kBHE5gUq6bz/
        mQ3CFpQ4OfMJC8QYeYntb+cwQxykILH701FWiFVWEusXv2KEqBGRmN3Zxgxym4TAQg6JE3fv
        skM0uEjceLqSBcIWlnh1fAtUXEriZX8blN3MKNF31xOiuYVRYtWOJqj3jSU+ff7MCHI0s4Cm
        xPpd+hBhRYmdv+dCLeaTePe1B+wvCQFeiY42IYgSFYnvH3aywKy68uMq0wRGpVlIXpuF5LVZ
        SF6YhbBsASPLKkax1ILi3PTUYsMCI+TY3sQITqdaZjsYJ739oHeIkYmD8RCjBAezkgjvZPVL
        cUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5jQ80riDU2NjI2NLUzMzM1MjZXEedVkLsQJ
        CaQnlqRmp6YWpBbB9DFxcEo1MKVPvsHxf3tR8pfcyNyAVcJaJvK17Rw6dxc7HUkVUJizgy/x
        mOCPaKPTP0rn3Fhw//8lx5vLgzNZ4y915wnkuSgXsnFcubOtmOVaG/O6kj/KHaUpR3xaC0J4
        vaJPhR8ofsaeF+KyT1Xf/ETXae+7s56vfXRz1d6GK8esHPdn35QslJSf/73t3a9SobrV9T5v
        jC7yRi6qvNWsFx5ifEJzmfP2xF+C3EZv7lS1d1yS98rYu3xP2/NvW7fN0jT6/LZzn0VwzeW/
        whbabUs7LR6EstwKtn8lwplk9vKSX0R0cdsWDx+fOK1rZ5pM3GUr5P6czPdTtTKzPHd3qtHn
        D7ePsN3uPmUV6Cfwj1E10JZNiaU4I9FQi7moOBEAPYDzDTAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXnfPpytxBqt2mVn8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFsVlk5Kak1mWWqRvl8CVcfTUP5aCx4oV87YuYW5g3C3VxcjJISFgIjGt+R1rFyMX
        h5DADkaJR2tXsXcxcgAlpCQO7tOEMIUlDh8uhih5zijxbe8idpBeNgFdiSc3fjKD2CICehIn
        T15nAyliFmhmkmj90swE0dHFKHH/0VEWkCpOAUuJ2W+es4JMFRawl1jQVwsSZhFQkfh3fCEj
        iM0LVNJ5/zMbhC0ocXLmExaQcmagBW0bwUqYBeQltr+dwwxxv4LE7k9HWSFusJJYv/gVVI2I
        xOzONuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJ
        ERxRWlo7GPes+qB3iJGJg/EQowQHs5II72T1S3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb/O
        WhgnJJCeWJKanZpakFoEk2Xi4JRqYFrf/fi82bng+KhDItqPyzMO84dzP53SPGupQIbd5Vk9
        yvtF2b8crl08Ic7rpMOObY3Ga+pex05rtl5Y9Tzz3x7RFyaP59rv5F11M5J7u02S98c5KnF7
        2dOaJ7dkTZQqL/RxUpnafe7JFTcFJsuLWTcf3nFSSX0794Z4W03eT+NFtUEyrzZt3Dojmy/w
        +42HKoXxjQfTe64efrJuX/uxY0LVd1dcva2xfsvOuH2HprC0Br++Y9P0rH6laKXuLZEQAfdH
        OhasvPue/JUw8jmwQTLHoVF6fdbOWYt/fmPsjr9t1pkl+9VoTZ/fusXLeT5dWLr47J85k1dc
        ivV8yfK+LqWikjuUyVJFpmd194b9q2uVWIozEg21mIuKEwGzH0+KFwMAAA==
X-CMS-MailID: 20200601122117epcas1p46da0a6d26a916248d900b32f5a8d81c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200531093027epcas1p114ae71536b54ddf42882831cceb007c9
References: <CGME20200531093027epcas1p114ae71536b54ddf42882831cceb007c9@epcas1p1.samsung.com>
        <20200531093017.12318-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add Boot-Regions verification specified in exFAT specification.
> Note that the checksum type is strongly related to the raw structure, so
> the'u32 'type is used to clarify the number of bits.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes in v2:
>  - rebase with patch 'optimize dir-cache' applied
>  - just print a warning when invalid exboot-signature detected
>  - print additional information when invalid boot-checksum detected
> Changes in v3:
>  - based on '[PATCH 2/4 v3] exfat: separate the boot sector analysis'
> Changes in v4:
>  - fix type of p_sig/p_chksum to __le32
> 
>  fs/exfat/exfat_fs.h |  1 +
>  fs/exfat/misc.c     | 14 +++++++++++++
>  fs/exfat/super.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> 9673e2d31045..eebbe5a84b2b 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -514,6 +514,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,
>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);  unsigned
> short exfat_calc_chksum_2byte(void *data, int len,
>  		unsigned short chksum, int type);
> +u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
>  void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int
> sync);  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags); diff --git
> a/fs/exfat/misc.c b/fs/exfat/misc.c index ab7f88b1f6d3..b82d2dd5bd7c
> 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -151,6 +151,20 @@ unsigned short exfat_calc_chksum_2byte(void *data,
> int len,
>  	return chksum;
>  }
> 
> +u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type) {
> +	int i;
> +	u8 *c = (u8 *)data;
> +
> +	for (i = 0; i < len; i++, c++) {
> +		if (unlikely(type == CS_BOOT_SECTOR &&
> +			     (i == 106 || i == 107 || i == 112)))
> +			continue;
> +		chksum = ((chksum << 31) | (chksum >> 1)) + *c;
> +	}
> +	return chksum;
> +}
> +
>  void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int
> sync)  {
>  	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state); diff --git
> a/fs/exfat/super.c b/fs/exfat/super.c index 6a1330be5a9a..405717e4e3ea
> 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -491,6 +491,50 @@ static int exfat_read_boot_sector(struct super_block
> *sb)
>  	return 0;
>  }
> 
> +static int exfat_verify_boot_region(struct super_block *sb) {
> +	struct buffer_head *bh = NULL;
> +	u32 chksum = 0;
> +	__le32 *p_sig, *p_chksum;
> +	int sn, i;
> +
> +	/* read boot sector sub-regions */
> +	for (sn = 0; sn < 11; sn++) {
> +		bh = sb_bread(sb, sn);
> +		if (!bh)
> +			return -EIO;
> +
> +		if (sn != 0 && sn <= 8) {
> +			/* extended boot sector sub-regions */
> +			p_sig = (__le32 *)&bh->b_data[sb->s_blocksize - 4];
> +			if (le32_to_cpu(*p_sig) != EXBOOT_SIGNATURE)
> +				exfat_warn(sb, "Invalid
exboot-signature(sector
> = %d): 0x%08x",
> +					   sn, le32_to_cpu(*p_sig));
> +		}
> +
> +		chksum = exfat_calc_chksum32(bh->b_data, sb->s_blocksize,
> +			chksum, sn ? CS_DEFAULT : CS_BOOT_SECTOR);
> +		brelse(bh);
> +	}
> +
> +	/* boot checksum sub-regions */
> +	bh = sb_bread(sb, sn);
> +	if (!bh)
> +		return -EIO;
> +
> +	for (i = 0; i < sb->s_blocksize; i += sizeof(u32)) {
> +		p_chksum = (__le32 *)&bh->b_data[i];
> +		if (le32_to_cpu(*p_chksum) != chksum) {
> +			exfat_err(sb, "Invalid boot checksum (boot checksum
:
> 0x%08x, checksum : 0x%08x)",
> +				  le32_to_cpu(*p_chksum), chksum);
> +			brelse(bh);
> +			return -EINVAL;
> +		}
> +	}
> +	brelse(bh);
> +	return 0;
> +}
> +
>  /* mount the file system volume */
>  static int __exfat_fill_super(struct super_block *sb)  { @@ -503,6
> +547,12 @@ static int __exfat_fill_super(struct super_block *sb)
>  		goto free_bh;
>  	}
> 
> +	ret = exfat_verify_boot_region(sb);
> +	if (ret) {
> +		exfat_err(sb, "invalid boot region");
> +		goto free_bh;
> +	}
> +
>  	ret = exfat_create_upcase_table(sb);
>  	if (ret) {
>  		exfat_err(sb, "failed to load upcase table");
> --
> 2.25.1


