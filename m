Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F383D32611D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBZKPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 05:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBZKN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:13:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A68C06174A;
        Fri, 26 Feb 2021 02:13:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o10so749575wmc.1;
        Fri, 26 Feb 2021 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UcwXbjPspvdQ4b6hP2yUf/RnFbzT9dnV8toQVcT9t0Q=;
        b=W/Z3NYQvkwE7RJz0m8fThZtcPXZa52gGx5QJa1TIfz7B1mvKdmTy7955/+wL9msJN/
         U1qAMheJC4I/zW3KnQ7gaLaQhEw3Kcm/VA0SO1OjuyX6jsUE4g03vSfkty0u6jvT+w0o
         0YxboNCAWX2b/ws6rvL0bkQSA6RQ0cKU7wx81r8vJMRZGav0LhWse6BUS+jmju/k62tx
         Ssvmn6mh+FPePI1qiiQ6EnJTLXa/Pw4oDiD/ZuwepvNAVjTgwwAqSG3rf9Y+lOe6+RjH
         ewGEosyyc751yQfq+/5p018C0U2kOUpZUerF3ds6fXNGnbSnh5AM8rSaAOPHkFxivLrp
         oDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UcwXbjPspvdQ4b6hP2yUf/RnFbzT9dnV8toQVcT9t0Q=;
        b=Uxr6m2VZv/WpsfeIcL6CPhsYmqJL//ZFd21rsbVaYrTsSmfJC8weFPWwmoavssBLcZ
         9TYIkOqPvea8IXbb5qCWS6OtV+kINxbjopUzgxAg9bmvVQdGl53H7GNqC1t8McH9CRCM
         0U0ukm5R6I4k1+6vHBwQ2gjNDgtKFwCeHf9k7DJD5B3HZWtuDq2dh4NTYAK0qx87GbuB
         X1CCayrMlxKh1YlPQkduo/rDyBPuW8PpkuY25YP+cEuq12vwOdtLAUDE8k7gl1GHOvYp
         cnLsUx5p3rQDmgTuI4NuDQl/AgJZMG+OKP4a/QkaMv19ieMwpr/oA3fYyk0PR8rOg4EE
         FBPQ==
X-Gm-Message-State: AOAM533Pol4bnyePSiZl5x3F1QUp+K4T9P928fihhJmMHm9NnWC0bTZJ
        rxMSQTNbyWbW439ubNsczJ2hwhz5vCgEJw==
X-Google-Smtp-Source: ABdhPJz+kl3sKdVAUjZUW1w6qXbEODQ2vpK+v7Ynjy6o1JFRa9VgJCMlLmgI9oC0gBY/DWPSryH7NA==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr2088010wmc.181.1614334397997;
        Fri, 26 Feb 2021 02:13:17 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id v9sm12426835wrt.76.2021.02.26.02.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 02:13:17 -0800 (PST)
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Luis Henriques <lhenriques@suse.de>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20210222102456.6692-1-lhenriques@suse.de>
 <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
 <YDd6EMpvZhHq6ncM@suse.de>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
Date:   Fri, 26 Feb 2021 11:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDd6EMpvZhHq6ncM@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Luis,

On 2/25/21 11:21 AM, Luis Henriques wrote:
> On Wed, Feb 24, 2021 at 06:10:45PM +0200, Amir Goldstein wrote:
>> If it were me, I would provide all the details of the situation to
>> Michael and ask him
>> to write the best description for this section.
> 
> Thanks Amir.
> 
> Yeah, it's tricky.  Support was added and then dropped.   Since stable
> kernels will be picking this patch,  maybe the best thing to do is to no
> mention the generic cross-filesystem support at all...?  Or simply say
> that 5.3 temporarily supported it but that support was later dropped.
> 
> Michael (or Alejandro), would you be OK handling this yourself as Amir
> suggested?

Could you please provide a more detailed history of what is to be 
documented?

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
