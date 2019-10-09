Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2777D125F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfJIPZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 11:25:33 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com ([77.238.176.163]:44287
        "EHLO sonic311-31.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729471AbfJIPZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1570634731; bh=r22YyVdESdI8UBnaOO+ZTb7TAeu5wDT6G7wAVwTxI1Q=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=PofpZTz+nSRYwC5vDwyxwW11tm6aqqKHmUeBOwSbd71400ZkljG5bZBvVs/gD+clkwjjoSi6JO6Hhf2KAeABdDV+E1NS9fYY8FHnSC8k7W0usM/spqRA48CW26FFxi/k74U+XV+tlniWiKsyl6uFiKH3FZLeeRCrctIpw2HZtGgctUUwOTPujwcPMxS8FrDFgbNeODvS43XsbLGAJKcuX/t3arZljxpYbR+GbwCmt2LaGvDhTLZI+X6maWWCHv2hFr3o0p/KPmmFQes8VCOuQXEN09DJ8mQKzmJ4YOyVGrEPmp5Jhi/OtMAy+XfrSDyjf+RrJob6KgSIi98kDX5gug==
X-YMail-OSG: ia.BOc4VM1ld0YyJCOQknQnEC0aCM.hokKpQV9MngbGcpnC_PlFdwicfRFB4UrW
 Q0DXqD0B6dozSaooFkm_H2B90hyap8DTgc4FLAgzVdlM6nwosS_yvofju6nBtRFD1k9fJbNFh9lM
 HNaG3hkZfqmwcmyuqDfLE.XQBo_tCMj7_xG9n65SEEzfqquBDfR0iWq.Udk0KxtK_V9jIdwpRldZ
 JgF8q5yiFLQYhr7b1rw_uMr8tQ7R6AsaTH7ZhnHd17nQuLjapf5d1GCW3NQVm2NGUmv3lZ_QIYFA
 TVxgc4wkOF1AqiYVDIFmxNTrLlofDQv8Ci8gnZDapjyVOWc3HuM68BsTNFnP0rcxVkNvtFUjps1d
 6luyjSosTDBBvFQP7KewKsQAUpA4bmLnQpsMcmNh.8Xh7E4U1rBMAIlQhN6PIOvTGj4M5O9bMgqX
 lIda4m5ncRNOuLNyH7Ifvj.SO49U3qH8vgVURfQXBd9hInmsXCJwTeoWVv1.szOi1YspAyHnX1h3
 x.TDn.FXWmU62TclUdshKBySaiD1tz7HRAxj0_9W7zO5xHCuzbRu30Y3n9h4S1D_sIbikoLff2YG
 Yo9JDw9p_o9Scx6e1AwJCfmArgWUsOChBQnRRRk_eD4mGATwRuQKttI6qVUDOZcKbVuzuL0pPybe
 Je3Tl4WuP6AsgbVzSxE1X3prCRw.3B84KsTWUvzYWpcquV1Ex6.reChfMs2KEisEVSNEgcjEStct
 LoVqb1fA07MsN8vZSEwJkjELc2US4i6FgBOrpRdLZyF04qCSOeVnrrsQ1QEhvQ.ReM2UPwdua_bj
 JLv.lYC3hv_aqjtAvkU4jdTUlhIlA0r0mJV6xIYGkh7_kJ9wbMeTApWJxrgzkPg86twySPahHopg
 3yW6wDaOm4dmCzRyAeV83XUIWE3w8PL2Fk52kIaiEfrlqfD3AwXh0w_14C9tdu6JDJBPgXYuk.8.
 eiia4_qnW6pzg8WRYtrSsK1wwL.WrzQ8GPdpbZlpYZPpNheIR6EIc0uRA3hvPx_Vc8aSjFfuMKU_
 Tp1SFZ3pJTxxMNqCvHmk1jhyfn8ccrwyJAHtMD_8YysYECIjjyAtiX9yte82UgmVT2v4JCn61WVC
 RRCGR38nUXUEgkt1pI22vVHfmv71i3QJWWm5wRMv2E.vtsjST4DTFT2JGzhevtTIz2tRxyLaHxJs
 WrhAVkP.JD_6L0T1QitrtlCDc93fmdj6CA6S9sU1_5wSY8dRlyHPzUhP62iIME_TzWj.EDazOUno
 LmRWhx6bfoLEwCpgxBfv7qYwpPZGi4zq0KSpdCikkNLTRMi0URh3hVWHHgAevDW35ukXQCscQod_
 WeY0rQmE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 9 Oct 2019 15:25:31 +0000
Received: by smtp431.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 290fdf2fee8b55d3e11b2a706bb6aa81;
          Wed, 09 Oct 2019 15:25:30 +0000 (UTC)
Date:   Wed, 9 Oct 2019 23:25:21 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     philipp.ammann@posteo.de
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Schneider <asn@cryptomilk.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 3/6] Check that the new path while moving a file is not
 too long
Message-ID: <20191009150034.GA31739@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
 <20191009133157.14028-4-philipp.ammann@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009133157.14028-4-philipp.ammann@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:31:54PM +0200, philipp.ammann@posteo.de wrote:
> From: Andreas Schneider <asn@cryptomilk.org>

[no subject prefix, and maybe use scripts/get_maintainer.pl... ]

> 
> Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
> ---
>  drivers/staging/exfat/exfat_super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 5f6caee819a6..b63186a67af6 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -1300,6 +1300,9 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
>  	}
>  
>  	/* check the validity of directory name in the given new pathname */
> +	if (strlen(new_path) >= MAX_NAME_LENGTH)
> +		return FFS_NAMETOOLONG;
> +

odd here, AFAIK, namelen should be checked in ->lookup()
for many filesystems (why such dentries exist?) and
the length can be also gotten by dentry->d_name.len
(it's also stable here).

Maybe sort out what original problem here is better and
not blindly get patches from random github repos...

Thanks,
Gao Xiang

>  	ret = resolve_path(new_parent_inode, new_path, &newdir, &uni_name);
>  	if (ret)
>  		goto out2;
> -- 
> 2.21.0
> 

