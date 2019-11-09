Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A5F5CB9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 02:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfKIB3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 20:29:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35372 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfKIB3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:29:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id p2so9049049wro.2;
        Fri, 08 Nov 2019 17:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGP1mRt6HvkIHdUHLfILh9IOfF49YboAHeR6gZm7mIk=;
        b=r2cjSGJ9qPWPBj+dKmeqFCTpvfAjISqy97GsxpwNvXoYX8YHEqgztVmZv/zGkNxTM5
         9KxXYQB2k2Bb2GLVadnfQe5GbCjnFIGGoJxP/sjpoWQsUSKznqtHiQ29icXVOJ3vhH76
         5eSkAUeYIkFXVTurK116vpc4ocvXKt4A2wQgQ9xs1oPuncZGhhEpyyUPp3MdWeeC/fpn
         hyTzKxe1Pid+WwHdNY4XWJbSehHFNCmB8Xz7XKw0n0bz4eNpYUHNw/SIfS98ZyAjdUFc
         LyCLRPxK4hRGknNZbL7GigYon/o6peKad52tCOJNE+S1Y8ngWj4DWfKY/D2S5jwOBZyF
         k6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGP1mRt6HvkIHdUHLfILh9IOfF49YboAHeR6gZm7mIk=;
        b=cXsk+/NNd9vhue1mexMqVXBguzcvF82Mj3JHZm2iw5fjvS99E3rz43GFoHu0kb/uYD
         zPwvviMgzlJtUs8fDHdOXZ2vBZCmljnb2Gk0IeYK5GCsGqiCrbsP1bi2CDRPoyVRGQqI
         MfqljA9I0b9miSeSwVPQL4vsYBbtUeuymkfq3wVZix5jmvlZniErSbGQrZlBI/GwBIs9
         Eq2TLDV5igFhX1xiLm+UtLaGXrsh8KpzasN6h0hPZ6cEjMmd9KmiSjMC5Ac/T9E4K5JX
         34xZQttYGeDF4zLRx9iD4r0Lnqw2clghJn1GDlEjj5cTVfEmJSBEeL5GhwGN0qmA7Apt
         aHZA==
X-Gm-Message-State: APjAAAVR07F1GH180NW7vE/NYCWPGDKa0oUAbDjMmCNKMFxQbq725B14
        FnAM2BxOWei6vwYGZ7NqJZQ=
X-Google-Smtp-Source: APXvYqw/AszSb29O0bMVElK9vbU1TWC0CKx+HLQAl57LKW8EZ5dEvRpIn0z8uFjc6J7dMh+qf3CBNQ==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr4783754wrx.309.1573262978063;
        Fri, 08 Nov 2019 17:29:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d4sm7197882wrw.83.2019.11.08.17.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 17:29:37 -0800 (PST)
Date:   Sat, 9 Nov 2019 01:29:36 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/userfaultfd.c: remove a redundant check on end
Message-ID: <20191109012936.fkqdczhl3sykius7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190912213110.3691-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912213110.3691-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 13, 2019 at 05:31:08AM +0800, Wei Yang wrote:
>For the ending vma, there is a check to make sure the end is huge page
>aligned.
>
>The *if* check makes sure vm_start < end <= vm_end. While the first half
>is not necessary, because the *for* clause makes sure vm_start < end.
>
>This patch just removes it.
>

Does this one look good?

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> fs/userfaultfd.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>index 653d8f7c453c..9ce09ac619a2 100644
>--- a/fs/userfaultfd.c
>+++ b/fs/userfaultfd.c
>@@ -1402,8 +1402,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> 		 * If this vma contains ending address, and huge pages
> 		 * check alignment.
> 		 */
>-		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end &&
>-		    end > cur->vm_start) {
>+		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end) {
> 			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> 
> 			ret = -EINVAL;
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
