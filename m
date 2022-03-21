Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A974E260F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbiCUMGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347194AbiCUMGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:06:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475355239;
        Mon, 21 Mar 2022 05:04:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o8so10155797pgf.9;
        Mon, 21 Mar 2022 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wM5oc/qGqPRm9eHrVGn9VhXD+Ebt8HaLEMG+j1FPV8=;
        b=ANwYR1851LYRyUzlBy9yCDmefbcw+dtz9Weiw2IAsUWMgwWNOt7vqjSFesvZczXjTM
         r6akG55ZFfWp0xPYfsEuEH+CgYKuiLbDP+hfvrkNrQontaVz7b0QbnA9sjRBhFOC4Hwf
         hb+GOAcJ953ZzFPhNKQxGZsnOs64gpkoEIX5j1eVjjMfTBIjXljiyNVZw4KRDIugj9Bk
         4PORPHLKkWNNU5qJSEncrZU4hOFOX/PMggb9hgqGTfg2loBKWc9ULZPhBY7zUwTs6jvi
         zK/hVNAwwU65aVXLN+nVsP2ovH9JR83K4FwmPI7AELysmbfv2dCawHfbchU8LUeju3fs
         Lsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wM5oc/qGqPRm9eHrVGn9VhXD+Ebt8HaLEMG+j1FPV8=;
        b=fidWlx1VvVHJP4UXazzznd9A66PG+sp+MRitk3BbaqnHP2qK/WRpdJehkvLLmxcj7j
         1DnU7GV4RJz234L4XC0poPI0D5QR6jqnBFHXDASI+fJNaVraHO/MR1wrVAvJnu75ELgg
         g7Tj6/s+Z+mrTRDhStT/ytq1aG5u0VMkBtmJeBHC6j3WS74RSEfnk401dqenbpIWjZjm
         uWa4HjnhDO4FnKQSuVjIreA1eSK6GJIsps+9K/xtb2WQR3Y1icNkYT95I+TJ77RWWv9V
         DfacnU7/j9/yGsMQ906iGW93klxOwQyGhUryuwmesiQQ2Cj8kTfDHWp6uggUarUbkiHI
         YpaQ==
X-Gm-Message-State: AOAM5319wHwvYsf4b//l/XbXlwf4+8sSfBg0Qs7TACh18Gj6ARTsebIx
        gujB4v8kGti24ZOHlRAl+I0=
X-Google-Smtp-Source: ABdhPJwBB3ljMvE9r8NOHjfHQSD3f80I1d97dhOe/XDW23sYrRkWY/cojiGqY43lJTgSmaB1KzP1rA==
X-Received: by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP id m25-20020aa79019000000b004fa75329551mr15275981pfo.26.1647864267445;
        Mon, 21 Mar 2022 05:04:27 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id o3-20020a639203000000b003810e49ff4fsm15683589pgd.1.2022.03.21.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:04:26 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:04:20 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/8] mm: khugepaged: skip DAX vma
Message-ID: <YjhpxDKJFtztdTCb@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220317234827.447799-1-shy828301@gmail.com>
 <20220317234827.447799-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317234827.447799-4-shy828301@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:48:22PM -0700, Yang Shi wrote:
> The DAX vma may be seen by khugepaged when the mm has other khugepaged
> suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
> it will fail due to page sanity check, for example, page is not
> on LRU.
> 
> So it is not harmful, but it is definitely pointless to run khugepaged
> against DAX vma, so skip it in early check.

in fs/xfs/xfs_file.c:
1391 STATIC int
1392 xfs_file_mmap(
1393         struct file             *file,
1394         struct vm_area_struct   *vma)
1395 {
1396         struct inode            *inode = file_inode(file);
1397         struct xfs_buftarg      *target = xfs_inode_buftarg(XFS_I(inode));
1398 
1399         /*
1400          * We don't support synchronous mappings for non-DAX files and
1401          * for DAX files if underneath dax_device is not synchronous.
1402          */
1403         if (!daxdev_mapping_supported(vma, target->bt_daxdev))
1404                 return -EOPNOTSUPP;
1405 
1406         file_accessed(file);
1407         vma->vm_ops = &xfs_file_vm_ops;
1408         if (IS_DAX(inode))
1409                 vma->vm_flags |= VM_HUGEPAGE;

Are xfs and other filesystems setting VM_HUGEPAGE flag even if it can
never be collapsed?

1410         return 0;
1411 }


> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 82c71c6da9ce..a0e4fa33660e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -448,6 +448,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (vm_flags & VM_NO_KHUGEPAGED)
>  		return false;
>  
> +	/* Don't run khugepaged against DAX vma */
> +	if (vma_is_dax(vma))
> +		return false;
> +
>  	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>  				vma->vm_pgoff, HPAGE_PMD_NR))
>  		return false;
> -- 
> 2.26.3
> 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
