Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5D32D966
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 19:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhCDSZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhCDSYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:24:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE906C061574;
        Thu,  4 Mar 2021 10:24:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so15879787wrx.9;
        Thu, 04 Mar 2021 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOtCkSuP3/sSeDKbXtcuyFbcQjnAEtPQvMYWbEo0RWc=;
        b=YfKywlVxA2OwkHFlyyqrfje5azAqfgnYnUxA9d2jP0QvhjMAlxLR3r6C/Elzp9q92h
         qyNvO+EX+nMI++2Pa08tB3EF/iDL28VoGHPvvuo83KL7wz5rIqdO4IYtJ/E2EM8HjKns
         RTj1wCLR3uGl9uaqG3daUJn2+peqIV5Gsj4O4DYbgjLbrNCM7vrdoRaYmAhEOi1gJ0Ul
         OIkZ50/qDGctum/YlbqL4IeRhcdDcXO+Ll0CO1+kK09Rh7em/N+JV2ZBNcbz0Sa4hHfQ
         Pasn8ntj+5g6E+Ahcl84DTVVDaAxmkqSZX5p/SxvajryIPc639gS0VB5UWev/7NlpPao
         Zx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOtCkSuP3/sSeDKbXtcuyFbcQjnAEtPQvMYWbEo0RWc=;
        b=BueaABldXxSdpMgmg4C8ssYiArOin/qNCbEIwAdduBGxI92PaNKOJVV2PxNAjzabwT
         NEWfpmBG9EVdWb2wB1x64TN6StxVGfBcbuwjYL2LgIdID/LPvgSEEw0CBzPCtYmmBV6+
         kEFCS/l4DOWwLQ8ImuM6hnGQyVkJes0HThE7aJLVrApa54H7EReBtMF/2TSrOhC1Pz6T
         DTydRewHDlKW0dphHl37kxyCyLmjEf4cLCBTLY4vqh71p/4QNWhjWIWaBImIwdBvUk4N
         rih3M3It45uaIi56niyCOtKBDI7ak1x7tyVj0kFigjhxFugDa4doOFI8o1SCf1lj67S5
         6zQw==
X-Gm-Message-State: AOAM531llen+U9r2ZvBcXaMeOz/X+a9vXYauK3tGvRIRVMzmbr5MOCPt
        FBGvUYZeLMyVgOs4bt4NW3Y=
X-Google-Smtp-Source: ABdhPJw9IGXfIEwP2LVQ0WhlSyUoO96IZPZPEYenv21JjYYT4AGCNBo1c0TUm4fQXkse7RWu/AHxvQ==
X-Received: by 2002:adf:a1ce:: with SMTP id v14mr5534243wrv.228.1614882244603;
        Thu, 04 Mar 2021 10:24:04 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id w18sm143376wrr.7.2021.03.04.10.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 10:24:04 -0800 (PST)
Subject: Re: [RFC v4] copy_file_range.2: Update cross-filesystem support for
 5.12
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-man@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Steve French <sfrench@samba.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
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
        Walter Harms <wharms@bfs.de>
References: <20210224142307.7284-1-lhenriques@suse.de>
 <20210304093806.10589-1-alx.manpages@gmail.com>
 <20210304171350.GC7267@magnolia>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <37df00f9-a88e-3f16-d0b4-3297248aee66@gmail.com>
Date:   Thu, 4 Mar 2021 19:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304171350.GC7267@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On 3/4/21 6:13 PM, Darrick J. Wong wrote:
> On Thu, Mar 04, 2021 at 10:38:07AM +0100, Alejandro Colomar wrote:
>> +However, on some virtual filesystems,
>> +the call failed to copy, while still reporting success.
> 
> ...success, or merely a short copy?

Okay.

> 
> (The rest looks reasonable (at least by c_f_r standards) to me.)

I'm curious, what does "c_f_r standards" mean? :)

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
