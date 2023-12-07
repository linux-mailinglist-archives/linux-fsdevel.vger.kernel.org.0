Return-Path: <linux-fsdevel+bounces-5272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274F809606
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E071C20BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C857309
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1YLqTHlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C2A9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:51:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso1087491a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 13:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701985873; x=1702590673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FS0jBFymMa7HReVXi3dbw6dnmNGPkS0D8kaKk4GXJv0=;
        b=1YLqTHlgpjCPDrbTw3XDG1XJYp2aAV+vGWWKYi09Mqgf/DDrML0ALT6VciiO+fFVB6
         lKhOFSClGjPuUxsnO/UJeRn9AGU37YKpPOvRBMrb8TdHLiM8SsB4m97s2WBjJhJd7gBe
         fyO4lsXsJILg/ZQ/T48jdSwkyzrufNj25CWBxvXtT2df2qIabU9s6E0BIPE9/8Nii+lv
         M2VEHH3wgD5pgTjb+6jSp+lex3aCqwOdwzt8a6ZzF7y6rvlMSuyg/1DA0f2thtOQ94QO
         bcIb044svBg/pnSta7aqfIOZjY5EimqDgdSx7PWIf2Wmf28+bHGFwD1ZGg/IRuF7u4Bv
         v6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985873; x=1702590673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS0jBFymMa7HReVXi3dbw6dnmNGPkS0D8kaKk4GXJv0=;
        b=jmVGvUMpHynuXG2G61CLO+MH1qSBCfsZnqGlCD3WzInul2VQuuf4E0ZjmgA0H9Epy4
         1wi4fQcvsB95STvQr/pPopfXIwtP3+RkNP0lwV6XeMOkLn0Uu94smok2Kq5dyM5YfCvJ
         9eE7/8JWecD3k5Fcatyr8eF1Jg7hiDVvdrFTksw7H2mzAGQT0UGhftOISta7c+kAhSdk
         GcTO6zM4ADkwQNkITQMAX19coj2zsGdxtEa+4ai1NVeyKDMJHGR4x0ckIcNzdA6dPVTy
         /6BvroWCUcyVYDJ/DOXsWIB5GOMcpYLRh1y7j7kSnaCIp055E/+V/1cQD7EqCcwKjz6Z
         Au8Q==
X-Gm-Message-State: AOJu0YwB2CWVD536LYZpG/Rr2ZQ0Iav8/gdjk4ACkBGosRnlFYneHwh7
	2IALvk6F/pKSsqYcauiX9XBflQ==
X-Google-Smtp-Source: AGHT+IGc5epmrDb8r3TwSbjLSJ3/Vby88DdTTxcemvPTnQXR1hOFYEeqkkDSU0rD5N6Pw+q/LXXoFg==
X-Received: by 2002:a17:90b:380d:b0:286:e021:f982 with SMTP id mq13-20020a17090b380d00b00286e021f982mr2629423pjb.51.1701985873116;
        Thu, 07 Dec 2023 13:51:13 -0800 (PST)
Received: from localhost ([2620:10d:c090:600::2:3287])
        by smtp.gmail.com with ESMTPSA id rr13-20020a17090b2b4d00b00263f41a655esm377722pjb.43.2023.12.07.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:51:12 -0800 (PST)
Date: Thu, 7 Dec 2023 13:51:05 -0800
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Prepare for fsnotify pre-content permission events
Message-ID: <20231207215105.GA94859@localhost.localdomain>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>

On Thu, Dec 07, 2023 at 02:38:21PM +0200, Amir Goldstein wrote:
> Hi Jan & Christian,
> 
> I am not planning to post the fanotify pre-content event patches [1]
> for 6.8.  Not because they are not ready, but because the usersapce
> example is not ready.
> 
> Also, I think it is a good idea to let the large permission hooks
> cleanup work to mature over the 6.8 cycle, before we introduce the
> pre-content events.
> 
> However, I would like to include the following vfs prep patches along
> with the vfs.rw PR for 6.8, which could be titled as the subject of
> this cover letter.
> 
> Patch 1 is a variant of a cleanup suggested by Christoph to get rid
> of the generic_copy_file_range() exported symbol.
> 
> Patches 2,3 add the file_write_not_started() assertion to fsnotify
> file permission hooks.  IMO, it is important to merge it along with
> vfs.rw because:
> 
> 1. This assert is how I tested vfs.rw does what it aimed to achieve
> 2. This will protect us from new callers that break the new order
> 3. The commit message of patch 3 provides the context for the entire
>    series and can be included in the PR message
> 
> Patch 4 is the final change of fsnotify permission hook locations/args
> and is the last of the vfs prerequsites for pre-content events.
> 
> If we merge patch 4 for 6.8, it will be much easier for the development
> of fanotify pre-content events in 6.9 dev cycle, which be contained
> within the fsnotify subsystem.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Can you get an fstest added that exercises the freeze deadlock?  I feel like
we're going to break that at some point and I'd rather find out in testing than
in production.  Thanks,

Josef

