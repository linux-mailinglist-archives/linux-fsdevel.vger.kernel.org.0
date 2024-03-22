Return-Path: <linux-fsdevel+bounces-15040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB2886458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23590283828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 00:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44885184E;
	Fri, 22 Mar 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux/nyWo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0621854;
	Fri, 22 Mar 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067415; cv=none; b=AerLcebugvLt3ReTGCrGDhoHn2OrigLhlYT1owvoxzPd/SgXt1iGJoPnmV4oxAOblMvwnRo+uboZ1al3stVNrLV04nlGF6UbPMiteP1rnyKB4h23Lg2f2B1ieWo8ImhHjXUAGBKC8R6nK2xVCf365ulD+hUIfXKLa7UvCUmdIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067415; c=relaxed/simple;
	bh=2oS5/+OU7q2OVdHinwRnMsJrZA2/4MZ9QA2WdIlydEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct2HSBNxpMBJOqj5ZubH71ffjM8UHl1JZgaIA4mPi1kLnp/5E1IDxVWfWc/zODrxJF87NJH060zgrFnefVXLDkCXK3qdZEUvBpGzzY6VDt/JLyGCnbbrswr+HIrzJ6O1tNE5UpSf0Q5qZGwRhgPOaQ8fm2J5CvcQQBsFzX7i7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux/nyWo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E89C433C7;
	Fri, 22 Mar 2024 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711067415;
	bh=2oS5/+OU7q2OVdHinwRnMsJrZA2/4MZ9QA2WdIlydEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ux/nyWo9nNAkSf12AXlufQGQjR6V7ttQc9xl9gx/p5iTArqdmZXMBGtPgW8LmpqcJ
	 QIWqdxP1xrH5fRJExj42Go19TsNTxsKnB9AIRR5PCqlNICsGBz6jCu3cd2Bf7hRV9k
	 ERf8kU4Nx3BFNcHF8u94UrUcAyD4ZNebUcWKdJxCd0lwA6fQMObMjvneicaGrv25an
	 oY44zmBPfcHaeAFUGHdH1NsNQqbQboZKYdm6HaRvR6wVuQ+kid18nZzsf4QbJvJsMS
	 Z+ObLWcyu25o5ufHXi32nlxr9HqVemAB26AE+MdcJvdQVvMUfBxLGwiHhZDIFHc2qr
	 UsDG6VlfVFZeQ==
Date: Thu, 21 Mar 2024 17:30:13 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY=?= =?utf-8?Q?=3A?= f2fs
 F2FS_IOC_SHUTDOWN hang issue
Message-ID: <ZfzRFU_cXkToBoQ0@google.com>
References: <0000000000000b4e27060ef8694c@google.com>
 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
 <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <ZftBxmBFmGCFg35I@google.com>
 <SI2PR03MB526094D44AB0A536BD0D1F5B84332@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <ZfuBt1QbfFfJ-IKz@google.com>
 <SI2PR03MB52605816252C9ABA3D8550F084322@SI2PR03MB5260.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR03MB52605816252C9ABA3D8550F084322@SI2PR03MB5260.apcprd03.prod.outlook.com>

On 03/21, Light Hsieh (謝明燈) wrote:
> Do you mean:
> 
> +           /* Avoid the deadlock from F2FS_GOING_DOWN_NOSYNC. */
> +           if (!sb_start_intwrite_trylock(sbi->sb))
> +                 continue;
> 
> After failure of trylock,  the 'continue'  make code flow goto the line:
>       } while (!kthread_should_stop());
> Since  kthrad_should_stop() is true now, so the issue_discard_thread will end?

Yes, but now I'm confused who is taking write_sem. :(

> 
> Light
> ________________________________
> 寄件者: Jaegeuk Kim <jaegeuk@kernel.org>
> 寄件日期: 2024年3月21日 上午 08:39
> 收件者: Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>
> 副本: Ed Tsai (蔡宗軒) <Ed.Tsai@mediatek.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-f2fs-devel@lists.sourceforge.net <linux-f2fs-devel@lists.sourceforge.net>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; Chun-Hung Wu (巫駿宏) <Chun-hung.Wu@mediatek.com>
> 主旨: Re: 回覆: f2fs F2FS_IOC_SHUTDOWN hang issue
> 
> 
> External email : Please do not click links or open attachments until you have verified the sender or the content.
> 
> 
> On 03/20, Light Hsieh (謝明燈) wrote:
> > On 2024/3/20 8:14, Jaegeuk Kim wrote:
> > > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> > >   - mnt_want_write_file()
> > >     - sb_start_write(SB_FREEZE_WRITE)
> > >                                               - sb_start_intwrite(SB_FREEZE_FS);
> > >   - f2fs_stop_checkpoint(sbi, false,            : waiting
> > >      STOP_CP_REASON_SHUTDOWN);
> > >   - f2fs_stop_discard_thread(sbi);
> > >     - kthread_stop()
> > >       : waiting
> > >
> > >   - mnt_drop_write_file(filp);
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >
> > The case I encounter is f2fs_ic_shutdown with arg  F2FS_GOING_DOWN_FULLSYNC, not  F2FS_GOING_DOWN_NOSYNC.
> >
> > Or you are meaning that: besides the kernel patch, I need to change the invoked F2FS_IOC_SHUTDOWN to use arg F2FS_GOING_DOWN_NOSYNC?
> 
> I think this patch also addresses your case by using trylock.
> 
> >
> >
> >
> 

