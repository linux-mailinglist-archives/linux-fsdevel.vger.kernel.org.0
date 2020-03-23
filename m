Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1618F5DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgCWNhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:37:45 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:59810 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgCWNhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:37:45 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2020 09:37:44 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8A3273F571;
        Mon, 23 Mar 2020 14:30:22 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rW9Z8fL1;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jYeB1Hkf84eV; Mon, 23 Mar 2020 14:30:18 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 24C7D3F44A;
        Mon, 23 Mar 2020 14:30:17 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5CF2636019D;
        Mon, 23 Mar 2020 14:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1584970217; bh=o74YyBwiZy95kxk4hXa0iDzbeSVNayzuvbQ1L06JVbc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=rW9Z8fL1az+mx6uWgRduFzR6TBjcsdAMKq/Iq7w9t3SguJbC4fgRHqXfw6dXqnOrM
         eAS7pHPMo7G4CBHLZs+7hVv9fTV2nmC7f9zyS2K9vJ/IYWhH8O1HVAyPGbHzlwKPwA
         uT9DOohKtTQnFITtAQktqCiWQYUriRYZpN5ezs+E=
Subject: Re: Ack to merge through DRM? WAS [PATCH v5 1/9] fs: Constify vma
 argument to vma_is_dax
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200303102247.4635-1-thomas_os@shipmail.org>
 <4a49f27b-71a6-0e61-70d9-5fcb6cd58c3f@shipmail.org>
Organization: VMware Inc.
Message-ID: <0b19b68b-0bbd-f51c-67da-bd6983ae45b2@shipmail.org>
Date:   Mon, 23 Mar 2020 14:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4a49f27b-71a6-0e61-70d9-5fcb6cd58c3f@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping?


On 3/3/20 11:28 AM, Thomas Hellström (VMware) wrote:
> Alexander,
>
> Could you ack merging the below patch through a DRM tree?
>
> Thanks,
>
> Thomas Hellstrom
>
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
>
> The function is used by upcoming vma_is_special_huge() with which we want
> to use a const vma argument. Since for vma_is_dax() the vma argument is
> only dereferenced for reading, constify it.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
> include/linux/fs.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..2b38ce5b73ad 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3391,7 +3391,7 @@ static inline bool io_is_direct(struct file *filp)
> return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> }
> -static inline bool vma_is_dax(struct vm_area_struct *vma)
> +static inline bool vma_is_dax(const struct vm_area_struct *vma)
> {
> return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> }
>

