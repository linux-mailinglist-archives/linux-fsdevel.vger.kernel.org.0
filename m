Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941BF432676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhJRSgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhJRSge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:36:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D97C061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:34:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so95131pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CjOwIptKeKsZnI5vzYVx5BgqxckJRuqKx1EwqJ4NJDI=;
        b=3azx8wpbBtf3cl3apwemP/uh5UOczovYVTfRBB5d4efvu+icz/O8Gn84bIEoj+za7v
         tfTQimBqXZWrq7KtbDoEnUrNPlIlp38inkFxhf90wYVn2h64KakCpu7jy6wDWDPlUWBG
         Ui8h9Wq3lUsUPRDZOGd7eyQ8+oUI2BMhiXad6QUW0UZTKCcm4As8OOLwvYcNHhTCtC6i
         J2SY59uCP+cZDwFJVULho9xcKQ67BMwxBMugVQjOyJOPK7uemO73tKo3CT7AQTH5V3w4
         drbqQ+5qzVqji8uk1wGYOow8JTbXDYjYdiBk1oWvbpxzM+aJXQnzYUfgJSkr7HpN2Ydu
         XE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CjOwIptKeKsZnI5vzYVx5BgqxckJRuqKx1EwqJ4NJDI=;
        b=sysshiSZbauVJZVLfve3xZSsXIDcWbbrooFX9Cykey+JNlWtcNhxT3NjsaVDKbVr3H
         LEGLm+dJbWA5XDzJHq//zocNx6a4ukMeFAzZaKllOxQWrLGJJf1qChfi/VBYNBazl61J
         ftFNg00fpLgECxaCHHTZLAf3teqW41cv/IeaPMCgSfQUHKmnAPEF5rcKAl/wUfTpwtPu
         A6SuRTqGm+igwVHL4Cz3yjAYzGLEYlQpSIWl9/BFqOYjmNPRviMJ40Sj9XHbTYCHfM/2
         JU/007jNwyWEqF2D0Sggm0sSzQBZxxUy3ZGFphhelcuWk+MOxJTAh4D+qGCq7VhjH/tb
         KUzw==
X-Gm-Message-State: AOAM532ejnAj7RQ6JekynxzYOGxyCxUUV8/PGINoadT8nh+MEXwwnTTD
        bwoMClSFWVmP82DjvxuX/wSC+w==
X-Google-Smtp-Source: ABdhPJyiHjGppllTTLxnipWJuQLz3iJKxTegYQcLsvAV40uJ/nyi1epoaJqN7l1rBZagyOA2yIkdtw==
X-Received: by 2002:a17:90a:1a12:: with SMTP id 18mr634959pjk.113.1634582062129;
        Mon, 18 Oct 2021 11:34:22 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id s7sm14623302pfu.139.2021.10.18.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:34:21 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:34:19 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 14/14] btrfs: send: enable support for stream v2 and
 compressed writes
Message-ID: <YW2+Kw/auX5ORioI@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <61a4a5b6bf694c7441b2ba04b724d012997fa3f7.1630514529.git.osandov@fb.com>
 <878b7f1f-a160-0b88-2048-37c64413ca3d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878b7f1f-a160-0b88-2048-37c64413ca3d@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 03:44:23PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now that the new support is implemented, allow the ioctl to accept the
> > flags and update the version in sysfs.
> 
> This seems like an appropriate place to bring up the discussion about
> versioned streams. SO instead of adding a BTRFS_SEND_FLAG_STREAM_V2
> flag, which implies that for the next version we have to add
> BTRFS_SEND_FLAG_STREAM_V3 etc. Why not generalize the flag to
> BTRFS_SEND_FLAG_STREAM_VERSIONED and carve an u32 from one of the
> reserved fields so that in the future we simply increment the version field?

Yes, that definitely sounds better.
