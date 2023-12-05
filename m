Return-Path: <linux-fsdevel+bounces-4911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647F806383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FB51C20CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698A650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gzIB6miw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8BA5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:48:51 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-58d3c9badf5so4167957eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701816530; x=1702421330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNz5/nmIgw73PzOL4qC22vg/C9KyFpqsJcvJUz5BlTw=;
        b=gzIB6miw7yoSJmeGvwOFfe6uHrtY7H8N6E6jjWa5wLL8xQwhqpGKqdu5Vi1HB0ulsO
         0vVBjPl49DfwXVPCKBdmgHV7ixF7v05xdD23x3/8Z7fr+iBGo3QmPIibXTxB76uUFFJL
         kg0fh/aP638JZLGjS0S3cJYk1cxhIdD3/dDdqbG/tss37RhD/Wwrwo+TGQJ+nQUU84y/
         nutBJYTR+qt4wzK00HWSB4xGa6WBlYsDGN4K79krMS98x3M2ylSf+nuuagDwPv0IEV+I
         LedFDUhTQHeJODg/aCsbC8nUKdySWTf9OyV2bJAv3MelXkfsuEir5Vu7LLNUdIGH3VbQ
         oFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816530; x=1702421330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNz5/nmIgw73PzOL4qC22vg/C9KyFpqsJcvJUz5BlTw=;
        b=dwmsSdEY9PrAJmRmNfcWFA1lT0wYAG9SuWx4Yq7R/7CRs4L7vCmvQLCDk3cf5SD/Yh
         7uPj6mAdyvWCIZYJG9ZZzD5OSyDOXlPUYvQXX7YXrE1xaZ1rDxB/Ocq8Pd23aF3xFxFh
         oGN83i2uIKMyE31v9buTAdi6xwrQwGfTxhYsfJdCchtEIPDBr1E61rHFZbrI7ixv/6w9
         L2Zg1/u0mYOi+3LhMcNl+zMPtQvhfAkcibpM63eDq0eJM+ugz1hgT+O+eTb3UNvCR8YM
         XHGmhen72s7u7vvcWBmyyl5bCTzWMdNybQXlhxLqK1NkRVQXtccmDxEPXTDlFcyT8ddy
         BnLQ==
X-Gm-Message-State: AOJu0YypZTBLMiyONIUFG6WNE3EkHUl/OnRrFIUezHOQIiGR22HNy7L+
	9RxCo62kxQsASEKS7yaprnVAt2Mq6+LWGZun5wU=
X-Google-Smtp-Source: AGHT+IEExi5L8fy5shMOHH2k0sgzJYIPQGe6h8JuSIdqbD7nIZVfoIuMN3/9riOL6bL5z3UAi+usHw==
X-Received: by 2002:a05:6359:294:b0:170:17eb:2055 with SMTP id ek20-20020a056359029400b0017017eb2055mr28833rwb.62.1701816530456;
        Tue, 05 Dec 2023 14:48:50 -0800 (PST)
Received: from localhost ([2620:10d:c090:600::2:8f7b])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78496000000b006bf83e892e9sm161582pfn.155.2023.12.05.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:48:49 -0800 (PST)
Date: Tue, 5 Dec 2023 17:48:48 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/46] fs: move fscrypt keyring destruction to after
 ->put_super
Message-ID: <20231205224848.GB15355@localhost.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <122a3db06dbf6ac1ece5660895a69039fe45f50d.1701468306.git.josef@toxicpanda.com>
 <20231205015800.GC1168@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205015800.GC1168@sol.localdomain>

On Mon, Dec 04, 2023 at 05:58:00PM -0800, Eric Biggers wrote:
> On Fri, Dec 01, 2023 at 05:10:58PM -0500, Josef Bacik wrote:
> > btrfs has a variety of asynchronous things we do with inodes that can
> > potentially last until ->put_super, when we shut everything down and
> > clean up all of our async work.  Due to this we need to move
> > fscrypt_destroy_keyring() to after ->put_super, otherwise we get
> > warnings about still having active references on the master key.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/super.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 076392396e72..faf7d248145d 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -681,12 +681,6 @@ void generic_shutdown_super(struct super_block *sb)
> >  		fsnotify_sb_delete(sb);
> >  		security_sb_delete(sb);
> >  
> > -		/*
> > -		 * Now that all potentially-encrypted inodes have been evicted,
> > -		 * the fscrypt keyring can be destroyed.
> > -		 */
> > -		fscrypt_destroy_keyring(sb);
> > -
> >  		if (sb->s_dio_done_wq) {
> >  			destroy_workqueue(sb->s_dio_done_wq);
> >  			sb->s_dio_done_wq = NULL;
> > @@ -695,6 +689,12 @@ void generic_shutdown_super(struct super_block *sb)
> >  		if (sop->put_super)
> >  			sop->put_super(sb);
> >  
> > +		/*
> > +		 * Now that all potentially-encrypted inodes have been evicted,
> > +		 * the fscrypt keyring can be destroyed.
> > +		 */
> > +		fscrypt_destroy_keyring(sb);
> > +
> 
> This patch will cause a NULL dereference on f2fs, since f2fs_put_super() frees
> ->s_fs_info, and then fscrypt_destroy_keyring() can call f2fs_get_devices() (via
> fscrypt_operations::get_devices) which dereferences it.  (ext4 also frees
> ->s_fs_info in its ->put_super, but ext4 doesn't implement ->get_devices.)
> 
> I think we need to move the fscrypt keyring destruction into ->put_super for
> each filesystem.

I can do this, I'll send a separate series for this since this should be
straightforward and we can get that part done.  Thanks,

Josef

