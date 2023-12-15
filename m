Return-Path: <linux-fsdevel+bounces-6225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF928150DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A31C23DF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11141857;
	Fri, 15 Dec 2023 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h2Lk16+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092B46547
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e2be6dde31so6559677b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702670667; x=1703275467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exiy3fhjNmaW92ZKP4zYBUYMUSk7ilu3za3LoAmGFxk=;
        b=h2Lk16+QJldvotZ1DWJzCfrGibiA2O8HSvc+RYoZJDF/0hG0GmJ3eOP/yslKUnm7J9
         yEx6ZBB4JfSR5SOENXlUCEh3Vns+aCKSAErk8i4LuIM2IVqov7LycE6UVFb3vNEPIoBX
         Ttr3Vg+gdMoQVu+SxATn8cZUVDbcFhFuxlg04R4UHM9yQTIle28RvDn0vfq6aEGsHo1F
         rH2RsKsHgUW0yq2bqEQo5A9z+yomQaY+If+i/HykPdHvKwrvBsMBkEaZceYup1djQZrV
         JUlY7KlhSxFCfpomEB7iD4kLEGZKM9JbTD8GWzuhu2DsaNfh+MaMzx/SzG7iow6sCZHg
         Bc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702670667; x=1703275467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exiy3fhjNmaW92ZKP4zYBUYMUSk7ilu3za3LoAmGFxk=;
        b=aDp3hfIMJ03pDUX2h9xp/7j95sjttKNqbMpNGBs0x5jcQL2W9bAZC3qGPqs7KbndRj
         43GwDmPRrVMULp/NKYwd3rHihDlsg2xZNEEaG844UpIQSe1W5PplUP6AWqk2muaKoZTi
         DsseqrqphXXZfos2VD9l405V5yNjEc/hhavJX4ykjmmrnG8ng1FVBEXhSpSSyqmgg71L
         670tGQpUW3Eywbfnth0spWd8bhqT/eOpcyaBRZHAZjLuo+g2B4AoAXkF69UWtFz8Fo1u
         cnFJXLxBt9MX9Q35WrBfZoUpWXJzQjOxabRYsD8mz7vgLSiolbXDd5sNQGcEves1QPZ/
         EF8w==
X-Gm-Message-State: AOJu0YyqQmPve3JgdN7T9+SdXE/ZdAW5QPjA7FNfT6OspvePQcAnHcrp
	jaNqdxKQYMK5wzfl4dzJkTsVsg==
X-Google-Smtp-Source: AGHT+IEM2fPmXfDxJBZLFq7DaDqq0GPgM0sTJEaqLR/F7cuvuDGKNotk/wMlH860PKeNGF4yn80SGw==
X-Received: by 2002:a0d:eacd:0:b0:5e4:e7ae:10ad with SMTP id t196-20020a0deacd000000b005e4e7ae10admr510023ywe.27.1702670666843;
        Fri, 15 Dec 2023 12:04:26 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x125-20020a817c83000000b005a4da74b869sm6585980ywc.139.2023.12.15.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:04:26 -0800 (PST)
Date: Fri, 15 Dec 2023 15:04:23 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Prepare for fsnotify pre-content permission events
Message-ID: <20231215200423.GA774497@perftesting>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207215105.GA94859@localhost.localdomain>
 <CAOQ4uxiBGNmHcYCg2r_=pWFJVwx0WPmdmqQyrzDQdgWsiUTNYA@mail.gmail.com>
 <CAOQ4uxj5GuOk7FdrZYdDVMmvp+CSBJty0SzsHN2T50NUBRFV4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj5GuOk7FdrZYdDVMmvp+CSBJty0SzsHN2T50NUBRFV4Q@mail.gmail.com>

On Fri, Dec 15, 2023 at 07:00:08PM +0200, Amir Goldstein wrote:
> On Fri, Dec 8, 2023 at 9:34 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Dec 7, 2023 at 11:51 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Thu, Dec 07, 2023 at 02:38:21PM +0200, Amir Goldstein wrote:
> > > > Hi Jan & Christian,
> > > >
> > > > I am not planning to post the fanotify pre-content event patches [1]
> > > > for 6.8.  Not because they are not ready, but because the usersapce
> > > > example is not ready.
> > > >
> > > > Also, I think it is a good idea to let the large permission hooks
> > > > cleanup work to mature over the 6.8 cycle, before we introduce the
> > > > pre-content events.
> > > >
> > > > However, I would like to include the following vfs prep patches along
> > > > with the vfs.rw PR for 6.8, which could be titled as the subject of
> > > > this cover letter.
> > > >
> > > > Patch 1 is a variant of a cleanup suggested by Christoph to get rid
> > > > of the generic_copy_file_range() exported symbol.
> > > >
> > > > Patches 2,3 add the file_write_not_started() assertion to fsnotify
> > > > file permission hooks.  IMO, it is important to merge it along with
> > > > vfs.rw because:
> > > >
> > > > 1. This assert is how I tested vfs.rw does what it aimed to achieve
> > > > 2. This will protect us from new callers that break the new order
> > > > 3. The commit message of patch 3 provides the context for the entire
> > > >    series and can be included in the PR message
> > > >
> > > > Patch 4 is the final change of fsnotify permission hook locations/args
> > > > and is the last of the vfs prerequsites for pre-content events.
> > > >
> > > > If we merge patch 4 for 6.8, it will be much easier for the development
> > > > of fanotify pre-content events in 6.9 dev cycle, which be contained
> > > > within the fsnotify subsystem.
> > >
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > >
> > > Can you get an fstest added that exercises the freeze deadlock?
> >
> > I suppose that you mean a test that exercises the lockdep assertion?
> > This is much easier to do, so I don't see the point in actually testing
> > the deadlock. The only thing is that the assertion will not be backported
> > so this test would protect us from future regression, but will not nudge
> > stable kernel users to backport the deadlock fix, which I don't think they
> > should be doing anyway.
> >
> > It is actually already exercised by tests overlay/068,069, but I can add
> > a generic test to get wider testing coverage.
> 
> Here is a WIP test:
> https://github.com/amir73il/xfstests/commits/start-write-safe
> 
> I tested it by reverting "fs: move file_start_write() into
> direct_splice_actor()"
> and seeing that it triggers the assert.

Perfect, this is exactly the sort of thing I was hoping for.  Thanks,

Josef

