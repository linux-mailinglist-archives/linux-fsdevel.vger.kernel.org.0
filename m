Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20464C01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfGJSVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 14:21:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34618 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfGJSVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:21:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1638660plt.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnGBpm29e8ih0nVcemzSumdnrI3YNjI1abxR9imHsCE=;
        b=r54oOfo9tCGgPU7nLvxeuwlcmdrm1W6iXQBTBZuQX3uMd5MEButIOxEC8ZsooBrS22
         XDo3wfladVbiIrIEHAd1Nm+DPdJFk/HTfy0vfc7vqlOmJoQWsAtsV9lgjDhoLXS7165x
         sya+OrBKZmq7S45Xj2EiJugybWH3jnJvSJsVvyUDD6HskfqZNxn78dEhQd3q/VfgptTd
         kNFdqMeSAXscKx3XhFpoKqqrx9qoo/xTN+hEJ+//orXsW7lcODdi6oOkp/sMhNJ7f3DN
         hdJ6f1X/S+eu/F9g8mTz3eA1OsGy9CUSqKRZWYDHeSs+cXWv8sadpOreFTMS07aDYZND
         7Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnGBpm29e8ih0nVcemzSumdnrI3YNjI1abxR9imHsCE=;
        b=bJOXZ17S2nxkhNtG3cRJ/3MpYdPu0UHTezvUhk4HisGlDsvT8T0XjiIflTOAWStOU7
         TNNfSJCIfmrujKfXgZZ/KPog5j5rBSlp2IVR+/QfOyMt42vFFKW4BAZ46QB9d0DVtTJ1
         Y8d9dJg3TZaZpqOqGsV8ql666aHj23C6curwZNGF4VsnpOL1SvkvVsdqoWcy/TSJ3Mop
         y26GA1bAD0SreVzO4BjiHs2iyWbge3T6QtWIu2w/X8ag5ZUlkLOkmUjFnYKUNeEKoxXz
         Om1Xxc8QrMRyfo8c/EB/GB2utpPgIkz44TnYaR4xl2MjaWAE8bDChKLeu+AH0OGgyJu/
         mIPQ==
X-Gm-Message-State: APjAAAUwUCKurTC+GjbEP68/JzoiSounnHVYEI0WeJsIvRQdAqDeMqOb
        zltVvQnOTolxeTpgvKX0WQ7+Tw==
X-Google-Smtp-Source: APXvYqxB3CQ6to2JGHiSbwc0t9tlBi+Ho6PWoIO2Ce1gSNPx5pyEn4b7NBFexyxmsIzvyOnXSOYzfQ==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr40667176plr.285.1562782866693;
        Wed, 10 Jul 2019 11:21:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id i15sm2855950pfd.160.2019.07.10.11.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 11:21:05 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:21:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 4/6] khugepaged: rename collapse_shmem() and
 khugepaged_scan_shmem()
Message-ID: <20190710182104.GE11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-5-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-5-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:44PM -0700, Song Liu wrote:
> Next patch will add khugepaged support of non-shmem files. This patch
> renames these two functions to reflect the new functionality:
> 
>     collapse_shmem()        =>  collapse_file()
>     khugepaged_scan_shmem() =>  khugepaged_scan_file()
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
