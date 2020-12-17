Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884F82DD3F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLQPP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLQPP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:15:27 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D2C0617A7;
        Thu, 17 Dec 2020 07:14:47 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id p14so17504810qke.6;
        Thu, 17 Dec 2020 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YutvZo+Sqq4bs2edgHCuJ/pn2rMAD01S5REOBc6/o+I=;
        b=WpzeRVE8GeNTmyAeUx+h8k/UAYGJcXK7iXQWcFf/4Z9Hb3OjtynqgZ4vRI1uzidkgi
         LS6jdGRi7YAZ69Bmeuaf+Yhpkw16M/zM5h/vaVw0slBlqRPIuTMyeFzGUmU6dYFDN+Dg
         Xsj+cFRmyHHDNFn7Ti9LP9cU3Czd8i1hL00qXjh8dSZPPRh8/AnUbAK3iHFW+HvwfxlI
         k1sVJOjSjitJqAApbZLIiFBVo2EXaz3OR32bv7n9Wo45faU25HMe7fCpB6m7M7iTKOhA
         T3H122EXNAYP3Yelnga0X1AXT1YLFJqefGbLS+fS7j7+6fkV3j/dHI8JCD5PcPhlChds
         Y2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YutvZo+Sqq4bs2edgHCuJ/pn2rMAD01S5REOBc6/o+I=;
        b=tze0CfA1SMrN2OzWzCxLsiMUjCsNHUNT7swiIBUH0liwyx/DcVWSI+yDa9S6ylL3El
         V0iK9Eu+MZQZhOlhhV8yuNF6G0rWHjsBjUnog9cqCcVHpoEVjyQRNJBO/JDldLzEIAou
         lQHcwfQQQbw9dNvQ+fOcPXcQY6L+kdz1yGKhYFJyOQtZeJOcEQTeo1HADhM+kIsoGSUo
         1FaTikJt1wJKJINC7DzjN4Zt7LwI0GtUQKFqKScrshBQfT/3zRVp5XAiWvf/EUiTKpub
         6W5iA0Kogj/Fbxao2d+dPGUccZ4+PjzC1jF3bxOPcP9fZPyqvvc4ZBkPr8yovrgAq68P
         YA/g==
X-Gm-Message-State: AOAM5338W9wzKvhebXpVISVWujPvzxShcUafhqjJwLt7Xr+Y9vSNH08Y
        w+QDW7MGK6ZM+Yoa0BHG5Hk=
X-Google-Smtp-Source: ABdhPJyTwoD81Esa8u7MV1gN/LMdQ0z/+OpwOYTq3xqoiS+W2B+m79lTwTs9sCFzkZ7eOGnWGZZy5A==
X-Received: by 2002:a05:620a:406:: with SMTP id 6mr30366893qkp.494.1608218086697;
        Thu, 17 Dec 2020 07:14:46 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id j203sm3538634qke.134.2020.12.17.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 07:14:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 17 Dec 2020 10:14:13 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
References: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
 <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
 <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
 <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
 <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > What could be done is to make the kernfs node attr_mutex
> > a pointer and dynamically allocate it but even that is too
> > costly a size addition to the kernfs node structure as
> > Tejun has said.
> 
> I guess the question to ask is, is there really a need to
> call kernfs_refresh_inode() from functions that are usually
> reading/checking functions.
> 
> Would it be sufficient to refresh the inode in the write/set
> operations in (if there's any) places where things like
> setattr_copy() is not already called?
> 
> Perhaps GKH or Tejun could comment on this?

My memory is a bit hazy but invalidations on reads is how sysfs namespace is
implemented, so I don't think there's an easy around that. The only thing I
can think of is embedding the lock into attrs and doing xchg dance when
attaching it.

Thanks.

-- 
tejun
