Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3191E1C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgEZHXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 03:23:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37069 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEZHXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 03:23:09 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200526072305epoutp034975da614a3d23aa84c5256b8eb1e6a2~Sgx6aOkJT0155701557epoutp038
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 07:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200526072305epoutp034975da614a3d23aa84c5256b8eb1e6a2~Sgx6aOkJT0155701557epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590477785;
        bh=muDhJDlkbZ0tlCtDaGGVytLoRJDLRFQkoNGUuFxnJAQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kPa9f+y/nuL8h9Ypl1XD+PngRXBqsCYE2f063lEp8q66K40uaIDfcXnpL88Oz2tEQ
         xbreJcE8cqO5IfopA6pvfw6aIwDLvFWAHSCjoibyrouT2Ky8+93bDu5zzeUu0MVoeN
         OmQHbBot6qExGeuafXtk2A2onK9Q/Iq3fwn+lOWI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200526072305epcas1p34fce9a04cf5a4ab0c9cf4e6832dd0d07~Sgx5-i0VP1566015660epcas1p3N;
        Tue, 26 May 2020 07:23:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49WQRD1tDFzMqYkl; Tue, 26 May
        2020 07:23:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.48.04395.7D3CCCE5; Tue, 26 May 2020 16:23:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200526072303epcas1p2f4598250117d4718b73dd11c7adbf629~Sgx4UmWC70599605996epcas1p2r;
        Tue, 26 May 2020 07:23:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200526072303epsmtrp2c4d152c159272c7de23fd1a3114836e3~Sgx4Twb8l2963929639epsmtrp2c;
        Tue, 26 May 2020 07:23:03 +0000 (GMT)
X-AuditID: b6c32a39-f7bff7000000112b-a0-5eccc3d7f701
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.F2.08382.7D3CCCE5; Tue, 26 May 2020 16:23:03 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200526072303epsmtip193c55d891e3daea8b703395b47fb81c1~Sgx4JZsJL3232332323epsmtip1W;
        Tue, 26 May 2020 07:23:03 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200525115052.19243-3-kohada.t2@gmail.com>
Subject: RE: [PATCH 3/4] exfat: add boot region verification
Date:   Tue, 26 May 2020 16:23:03 +0900
Message-ID: <00d201d6332e$7e6308a0$7b2919e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEl0VwLAqGTGno4seWfP7lwGg+RAAIXHVMxAmZLU4yp9smngA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNY6bTgVB8lgrXYqROxEQj0FJbBwPGoNEm+kFiNOoHdQIjoN2c
        KQY1cQkGKkHj1qgVDBpXXGqUyKKVCApWkQ9Q0RBjXHBBRRQUjVptOzXyd+95595zznuPJpRn
        KDVdbHPygo2zMFQMebVtuja1t60zT/v69xz2e00fyX7wu0n2us9Psj3N1RTb8+cLyZ4a2U+y
        9YFbsnly00h1h9xUvj8gN5W1n6VMTZ6nctPu+jpkGr48OZdaZckq4rkCXtDwtnx7QbGtMJtZ
        vNQ832wwanWpukx2NqOxcVY+m1mwJDd1YbEl6IXRbOAsJUEolxNFJn1ulmAvcfKaIrvozGZ4
        R4HFodM60kTOKpbYCtPy7dY5Oq02wxBkrrYU3e7agRzVcaW+hndR21B7TCWKpgHPgvd/eqlK
        FEMrcSMCt3cvITVfELy83h85+YbAVTZK/hvZ01cWYfkQ1Af65VLzDsEjvxuFWBROhcCvFipU
        q3Aa+P2SCIG3R8HpOyPBcZqOxpngakoKceJxFtw4N0CFYBKnwFCFKgQrgozACWmlAo8H/+FX
        YRMEToaGj9WEZEgDP/pPyUKjKpwDF73REkUFR3aWh30CPkbDnTOBKIm/AKqO1kbCxMNAR71c
        qtUwPOgLWwC8GT63RNa7ELwdzZZqPTzxXgpLEXg6eJvTJXgKNP2sQZJsHAx+rZJJWxTgKldK
        lBTY3d0WMZAElRVD8j2I8YzJ5RmTyzMmgOe/WC0i61AC7xCthbyocxjGPvVlFP6lMzIbUXvX
        klaEacTEKtjz9/KUMm6DuNHaioAmGJUi534QUhRwGzfxgt0slFh4sRUZgre+l1BPyLcH/7zN
        adYZMvR6PTvLONto0DOJCnevJU+JCzknv47nHbzwby6KjlZvQ+6qwe8LG5abP3XGTT25dX37
        YNKKF6YruxLKV7qNO/MOCt2xYvzHASwYXRfUQ7evJdYcyBl+jL42r5qPmxLWNTxHEzl5x9XO
        7Y03W2Krkl2yN96p1nGlPmLRoWktk/bFzfyd8ezBsmu130rvip3JE9z0i7VrUPqW7hUPnx8Y
        rYg/3s2QYhGnm0EIIvcXyywlCrsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTvf64TNxBtt+KFv8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC2KyyYlNSezLLVI3y6BK+PouRbGgjl8FXu3v2RqYDzG1cXIySEhYCIx4XYzcxcj
        F4eQwG5Gid6bLUwQCWmJYyfOACU4gGxhicOHiyFqnjNKfNvylwWkhk1AV+Lfn/1sILaIgJ7E
        yZPX2UCKmAWamSS+PVsCNXU7o8SdW4tYQCZxClhKdOyUBmkQFrCR2Lf6FRtImEVAVeJDuwhI
        mBeo4t+SqYwQtqDEyZlPwDqZgea3bQQLMwvIS2x/O4cZ4kwFiZ9Pl7GClIgIOEmsW88JUSIi
        MbuzjXkCo/AsJINmIQyahWTQLCQdCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
        BEeUluYOxu2rPugdYmTiYDzEKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVx3huF
        C+OEBNITS1KzU1MLUotgskwcnFINTOFVfYcnzy2Z/H7jDskjLp77LFVN9+86rflphdTez1pN
        v7qTolZ1RXSfWFW7b+3+1Jv6130ctq3ZybZ3QQJ72LMFPL1xvdvnpXR5GLq9NZA8OEn35Ktd
        Z1sf6m7RnnwwvYS/rECcO+iEQfPTYxez/5yZ/Ny995NViGXgLofDv1ezmHyNn9p+SK+mW2xq
        GI+n0K/Dv+0/sjG9Pjfzu/ZBozmP3+ytFbq1rzCovvPHrINRF4yOyjEmvboSN/dGaLH4HAUD
        3v3L2fTP1fO43JWYIyfKeV24ZdWXGIvlqmLX/DwSEovezLZ8X3Rr7oJj0u9kj4bujTB+LC+t
        Orm99chM667mHTNk/0hwrD96rOho5z0lluKMREMt5qLiRAD5naEiFwMAAA==
X-CMS-MailID: 20200526072303epcas1p2f4598250117d4718b73dd11c7adbf629
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200525115119epcas1p381d6e579b478e05e007a1521c2a103f8
References: <20200525115052.19243-1-kohada.t2@gmail.com>
        <CGME20200525115119epcas1p381d6e579b478e05e007a1521c2a103f8@epcas1p3.samsung.com>
        <20200525115052.19243-3-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[snip]
> +static int exfat_verify_boot_region(struct super_block *sb) {
> +	struct buffer_head *bh = NULL;
> +	u32 chksum = 0, *p_sig, *p_chksum;
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
> +			p_sig = (u32 *)&bh->b_data[sb->s_blocksize - 4];
> +			if (le32_to_cpu(*p_sig) != EXBOOT_SIGNATURE) {
> +				exfat_err(sb, "no exboot-signature");
                                exfat_warn(sb, "Invalid exboot-signature(sector = %d): 0x%08x", sn, *p_sig);
> +				brelse(bh);
> +				return -EINVAL;
Don't make mount error, Just print warning message.
> +			}
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
> +		p_chksum = (u32 *)&bh->b_data[i];
> +		if (le32_to_cpu(*p_chksum) != chksum) {
> +			exfat_err(sb, "mismatch checksum");
Print invalid checksum value also.
> +			brelse(bh);
> +			return -EINVAL;
> +		}
> +	}
> +	brelse(bh);
> +	return 0;
> +}
> +
>  /* mount the file system volume */
>  static int __exfat_fill_super(struct super_block *sb)  { @@ -498,6 +542,12 @@ static int
> __exfat_fill_super(struct super_block *sb)
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


