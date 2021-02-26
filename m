Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0E3261D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBZLP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBZLPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:15:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9521C061574;
        Fri, 26 Feb 2021 03:15:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id x16so7108633wmk.3;
        Fri, 26 Feb 2021 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k9sgvuu+Qg7wjNtisoO7UUJtH7RFCSXcGRmLfuSyvbk=;
        b=OAzPZsAKVzOOVk/lVwdaN7WCTeTKAS+mUNsholcGXOu+X8jjx7HMZ8C3pqb6iDPL17
         gFQzW+tyuhdZTIMcw6kK9dDvlxagLHfNyy0+3/VXGekWkABdR/RtJ1lJQ7m37E9IaXV+
         ObcCxwk8GacZFucrwObVzBobJwVvQirVAzUJVomaeXMIGmSAa7CRRI8aLPex3mmI4nRZ
         8ai7sEXyxpF/JGSLrLvhAx/CXWqMkZcTGXlXWcfeKWDge74fGEYiFwa2kw5FrG0x1mWC
         Wl4w8UwwPD9Zr1fu6oEIjEsSpQQSAGRpANKf57sBTH/xj3VbKoziVY5ayS1wTdLMimVx
         zY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9sgvuu+Qg7wjNtisoO7UUJtH7RFCSXcGRmLfuSyvbk=;
        b=oCwGnKlouDZna3L3VPpYTMMs2xNqtbs7RVOaea84jRFdsJp8Cek/4gByMdw3iaOVlw
         W7pBo93hscPMNQzPrarAEU47cFcUdZl/26DtVY9+r+Epn6YquaDXItG4uvRhvmgHjzkv
         psQpckPHBupJgUwwSuJXs88YH7QSd2eTQLbZ5cFw4j0Yf8/WYhmSa4GJZ6McOq2RxBZj
         p4ZuemdNid0ffyVN/8B5Uxil3XGKUzfFq6eb+MYZNyLq5LVtTpYkHlTxe6I3YPtguCi0
         CeRNPTwfyEcesdTHjBUoU1s4vWBBCd46rarYXb/mf7xldVUpCD8cGtj7sENhFJAI2Ndv
         5w3w==
X-Gm-Message-State: AOAM5331APQQlglaqxp6lEq6urRUNvhoweJwDawX6M41RJjRfgEzx5l6
        mgUsJSe2nrbfp5kuYVPmEXhhZt1IvXuWlQ==
X-Google-Smtp-Source: ABdhPJw53tMXBEIgjj5Ydx1dx2zknCtn2TrKdJOPUiAyxh8gwjNqu3cCzVaxU88Bf3Vqq3INSHd1wQ==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr2366345wmj.67.1614338112576;
        Fri, 26 Feb 2021 03:15:12 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id r9sm10358838wmq.26.2021.02.26.03.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 03:15:11 -0800 (PST)
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
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
 <YDd6EMpvZhHq6ncM@suse.de> <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
 <CAOQ4uxiVxEwvgFhdHGWLpdCk==NcGXgu52r_mXA+ebbLp_XPzQ@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <abf61760-2099-634a-7519-2138bb75e41b@gmail.com>
Date:   Fri, 26 Feb 2021 12:15:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiVxEwvgFhdHGWLpdCk==NcGXgu52r_mXA+ebbLp_XPzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir,

On 2/26/21 11:34 AM, Amir Goldstein wrote:
> Is this detailed enough? ;-)
> 
> https://lwn.net/Articles/846403/

I'm sorry I can't read it yet:

[
Subscription required
The page you have tried to view (How useful should copy_file_range() 
be?) is currently available to LWN subscribers only. Reader 
subscriptions are a necessary way to fund the continued existence of LWN 
and the quality of its content.
[...]
(Alternatively, this item will become freely available on March 4, 2021)
]

However, the 4th of March is close enough, i guess.

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
