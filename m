Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D053288A87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbgJIOSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgJIOSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:18:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2020 07:18:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o21so8036633qtp.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CcKsaaPzQT2ESj6YOvwBkh06P5IZh1MGDwlgLgs4VHo=;
        b=NlLNJz0gReMZ2olYoTwOI71Q3J7hZ4eCjDSLwfxrDsINskB/uRN0RJ63/6e4mp7rWK
         8HBBtYSi0tq6rQFBsNjlT8Imwpm8kDcN4jK2nSy7e062CLRT5RQCSFjHf1lN8ImYUGqc
         /vhv7tZjTIgwahWg6NDlOfjzYJ70RBtTYFaUtayjCmBbBlk6KxW8RzL4UWdAG77v2I9N
         A7UYx+wU+9EnXtsWlWiz3jQTPpdXvIdYWAVVCCCHPiVwb88OgPGRxAtC9APpf83BXrog
         jD06zR6/j/9ASrwFeC4hcqIdoEkQl6E5WRGzyO2rSgnCpr/6ATUZ0Ujgycjt3F5z1/Cd
         Sd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CcKsaaPzQT2ESj6YOvwBkh06P5IZh1MGDwlgLgs4VHo=;
        b=tJb8KxNfgFa8nzLt8QBTeS0QCCqDxN8ytEoitX8guqPwRWNryfp8RD5jsiNyDWSpzz
         R/jRnpdBtm/yeco28UbDmJ5ju8bZV9ire+tY6TOn6eMRmMziHYCAa++CYAE99HecnUxN
         lbKkvco8unIo9dyWXAynMbhePvYAt7QNXB1g09qgePdgcjsbnlgDn61ohR43aXEJ4Poz
         xrnRs2sVJQjIKHA8DdWha5ZV4okUez7yQPVXUxXCZqkbwi11Pu5TgAmD5cUgLGfGHG/m
         beuzX9Lg7TWi6fhXwbR2erF4xsjAukyekMzg38Aw9nhOf98WphU5hLssPyPHPqFMNhx6
         VMcg==
X-Gm-Message-State: AOAM533F86130lk4Z6+PB9hiW11RPJSzvvaixm3wiAX3oiKG8CnqWZBc
        ysvtpR3yLEeZ6Oz1umsE6ywlEw==
X-Google-Smtp-Source: ABdhPJxkUTamFkDclFTulS7UVScV42JPT3TSQbrdjQZFe2ID/ahDqSFwMiv5AdzptTI3yxVlMZazyg==
X-Received: by 2002:ac8:5d04:: with SMTP id f4mr13754639qtx.290.1602253085840;
        Fri, 09 Oct 2020 07:18:05 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id f3sm6216160qtp.57.2020.10.09.07.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:18:03 -0700 (PDT)
Subject: Re: [PATCH 5/7] btrfs: Promote to unsigned long long before shifting
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     ericvh@gmail.com, lucho@ionkov.net, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, idryomov@gmail.com, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        stable@vger.kernel.org
References: <20201004180428.14494-1-willy@infradead.org>
 <20201004180428.14494-6-willy@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b36885cc-0c4b-ee03-bcd3-56f94800d84e@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:18:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201004180428.14494-6-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/20 2:04 PM, Matthew Wilcox (Oracle) wrote:
> On 32-bit systems, this shift will overflow for files larger than 4GB.
> 
> Cc: stable@vger.kernel.org
> Fixes: df480633b891 ("btrfs: extent-tree: Switch to new delalloc space reserve and release")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
