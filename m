Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A259D288CFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbgJIPkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgJIPkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:40:40 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEBC0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2020 08:40:40 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id de3so4961662qvb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uG0C0Sa5d/EV+r7s4IDWcIQ0m7O5lJfSJN14EIaqPY0=;
        b=zmcVajOjR2McQG+oPd+lOgsdzPDVTSVOFWjJe+EJ5O4VjRne5A7aJJPWred2Ayyytk
         6BkgxKEjLnsv4ygFgcnAgDLcWnE6MpsR+PzPJeMV0EILwcTbWoJKYgwvBQ9sdwOpE1uH
         SBYewU0RQVEUMjbGlRMiLuOYDcc/ZDYYwiNm+6t+b0yTyL5QJJsfOrOW/gjHn0cFKEGW
         YEHonCDRAy87k0W1oAuJ45cr+5LTT8EK9DDAbHr9C8do/Ls41yy2I+4scfim1GjGw1Bf
         rm26TS4YPmzC1bTBeAB9C4wSx0tUgSSaZZc5LPfw2Wsui+0FiqRaqGK2f3Pf7hpT1/KY
         Lbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uG0C0Sa5d/EV+r7s4IDWcIQ0m7O5lJfSJN14EIaqPY0=;
        b=UI4leHNBRdEKOXxVM1U231V9ZguxGGi/7QU/jagIuf0mNn3qrXTL6gjsXUnHRdJRRY
         0GZfK34ttbU3M2heBikABj5qq0ZAPCHA/+Nlte9nohQIDJmHKYKFRbpu3/o3KzWkVkad
         AA0bYkDpYed+BkbxFC1r5Y/Oqu1EEXP2XIq3XInwP2ZzaSefx8o6r3mUngwiOAsP8pBy
         B6HNIYSHLU+r2it2IvksqW4LZu6k03gQ5xi1zQz4X5/t2UQAc2HCAvwfXP56Hy3QWNW9
         ueKFe1RsaGhP10MUzG8cZw39VBUW/vDZxssCuUVLPG6wu6ahAuX3vN+H+2udPZf1/zJk
         s98A==
X-Gm-Message-State: AOAM530g/Q3HevY3TSzfgxbc7KbgfMeH1FgpI0j/rqOXWWlPl9S0RX5A
        9YQLr2JPpuy5pBYaUX6kBB4cfRHNHtQBig==
X-Google-Smtp-Source: ABdhPJzr8O6NaYzPu2U5bUUQFDoUjuoHXtGV/RQv5/N8OzkUR4/ZDKy//TtrP6qUJPktU426Jynhww==
X-Received: by 2002:a05:6214:a94:: with SMTP id ev20mr2646145qvb.4.1602258038973;
        Fri, 09 Oct 2020 08:40:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id q135sm5036575qka.93.2020.10.09.08.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:40:37 -0700 (PDT)
Subject: Re: [PATCH v8 00/41] btrfs: zoned block device support
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <cover.1601572459.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a20cbf8-9049-6e6f-b618-9b4be7633f82@toxicpanda.com>
Date:   Fri, 9 Oct 2020 11:40:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1601572459.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/20 2:36 PM, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.
> 
> Changes from v7:
>   - Use bio_add_hw_page() to build up bio to honor hardware restrictions
>     - add bio_add_zone_append_page() as a wrapper of the function
>   - Split file extent on submitting bio
>     - If bio_add_zone_append_page() fails, split the file extent and send
>       out bio
>     - so, we can ensure one bio == one file extent
>   - Fix build bot issues
>   - Rebased on misc-next
> 

This is too big of a patch series for it to not conflict with some change to 
misc-next after a few days.  I finally sat down to run this through xfstests 
locally and I couldn't get the patches to apply cleanly.  Could you push this to 
a git branch publicly somewhere so I can just pull from that branch to do the 
xfstests testing I want to do while I'm reviewing it?  Thanks,

Josef
