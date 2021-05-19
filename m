Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFF3888E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhESIBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 04:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239564AbhESIB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 04:01:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B6C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 01:00:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so2896048wmk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LQxYHlpQlKzbVy7Qs+DZ8b8cOO6vCYLqnE0OUJbqO1U=;
        b=yzeGv/BUCDTAG4K7Xj6Q59o2Grqt+YdTNA3vK535i9ipWxVppRJnFemU2Dy1tO6K8/
         +HzTFy63yLu1tcxorUcLVHwGNLbfEk+H82EDibPbw2XUkGIey3u+oUT409bXFJKuwvbk
         O2e/ucFwvQ2xRlQGpfPBvt4MgXNf7jEbXb1UffNizZv32Al361n1MNn1O1aXWmD7dDKA
         G95DPJNuV0cfJpW74NSPaXL7Venkqtp+Fr1GP9dDxe9ka+eQ1srRkcZ0R4tpUM0DQZ6o
         MnfsUDwsZEe7JMRl1Tp8GcAwU5U/tZo49sbARRHga2J5DrMRY9ir/iURjcDMnZrw88hV
         GX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=LQxYHlpQlKzbVy7Qs+DZ8b8cOO6vCYLqnE0OUJbqO1U=;
        b=gnxwXo2cx1mdG/WNXn9InA2HP0/Er9SArCS3sYs/uWRpL+rU/6k5Njyes+woB9H4A1
         vKg+lrSTphqINuSFnCHzgX8xG9rO12wl4/j3twwpXZdajckGwaoc5qX2X0N+n4Pq1H2G
         +hr7W4v+sV6tQVPJ8GvdM1SflBs89IsCjeMMNDvgys+LlFmUOMg5gjGiv9LF2VXnemuY
         uIBqnkFib0RYr5QV4dCfxL9caGnzQQ4ziuQn9epjzF4aKfhqNsFuLrtsCvkqi/FOYAZm
         2gF6T9Ms/2476xWMegWHpWT5JZYCHnVZCbPMfdkt3SHxnay9tvgjwQmiD0GdQim4p9kE
         Qj9A==
X-Gm-Message-State: AOAM5336lYyBeOPdMnCMsdk62+hBQ1Jl5G4IaW4ALU0BmAw/8K0BSYKs
        bGDEf714oMYNfhOV+IKtZLRRRA==
X-Google-Smtp-Source: ABdhPJxnRUZ2yc4qyUeE2swRcrRWqusKm5GVl93f2H70honYjIvEhAbIfNuoGyJsqfwYmYwZjdX5vw==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr9976713wmg.158.1621411205505;
        Wed, 19 May 2021 01:00:05 -0700 (PDT)
Received: from avi.scylladb.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id m9sm4485432wmq.40.2021.05.19.01.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 01:00:05 -0700 (PDT)
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
To:     Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <206078.1621264018@warthog.procyon.org.uk>
 <20210517232237.GE2893@dread.disaster.area>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <ad2e8757-41ce-41e3-a22e-0cf9e356e656@scylladb.com>
Date:   Wed, 19 May 2021 11:00:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517232237.GE2893@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/05/2021 02.22, Dave Chinner wrote:
>
>> What I'd like to do is remove the fanout directories, so that for each logical
>> "volume"[*] I have a single directory with all the files in it.  But that
>> means sticking massive amounts of entries into a single directory and hoping
>> it (a) isn't too slow and (b) doesn't hit the capacity limit.
> Note that if you use a single directory, you are effectively single
> threading modifications to your file index. You still need to use
> fanout directories if you want concurrency during modification for
> the cachefiles index, but that's a different design criteria
> compared to directory capacity and modification/lookup scalability.


Something that hit us with single-large-directory and XFS is that XFS 
will allocate all files in a directory using the same allocation group. 
If your entire filesystem is just for that one directory, then that 
allocation group will be contended. We saw spurious ENOSPC when that 
happened, though that may have related to bad O_DIRECT management by us.


We ended up creating files in a temporary directory and moving them to 
the main directory, since for us the directory layout was mandated by 
compatibility concerns.


We are now happy with XFS large-directory management, but are nowhere 
close to a million files.


