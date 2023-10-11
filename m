Return-Path: <linux-fsdevel+bounces-11-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C47C45E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87473281EC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2A384;
	Wed, 11 Oct 2023 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="THVAZbLH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD2369
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:13:22 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20A91
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:13:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso5575663b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696983201; x=1697588001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bXYSMoj+4mDjgRP2mTt2Aa1GtDE1UTVBqHkHte3xwzo=;
        b=THVAZbLHDOGUMC2GecjPMvtCxzk3eiP3aTrvbwVAmZidEWVOrPAXo2r+UHpS7wvTnx
         PtNgVjzST+8AvmbSJzItwpVaMU9pgKBbr3474Gz19CJ+hfC+bKHy9niI6V90QIGw76ue
         0UfiHkTWDez1BRdMrRMN9Fm9KrpVtjGHQyYZRN/x0sUX1Wi75EaJ43K7DffpMCHU7ygz
         dGSg+tvidNXUEc3tcXW/gWJnMtGmyrYyRPsBM6y3eSrlOyRPbe+42vNSDGr8krIWLVt2
         vURLIec4QX8A+NQL4+r/J7pPvH6TaiqPH4fFOmRGyoOG2gx0+RV1NcaUZlqUyGPFD6eH
         giew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983201; x=1697588001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXYSMoj+4mDjgRP2mTt2Aa1GtDE1UTVBqHkHte3xwzo=;
        b=FMYOfk+1e8KXjTZQuYLtwFDLLLgoYbmfw0SP78B4H4i2g3CMUM5JwKvMNsegyNRCvW
         GHBY1ZFrx7+L9uhHg4fgDJv487qEhutK/VAhFXsNci/oPpZihkIl8CbLIx/LhbE48h4E
         YuYoNiP+TRy2xRHJBZd9Q1hBcbpWLvxJ0GF4ov+Wv0zvUT/olJfRaNBOI2dbG41E28AL
         5BpRvD0xnq5WXep55cl93vbhHpSzBqHj7NKoLQehUwbBVg2SiXbaFomYi6izTzgVALCF
         sEL3CgMFkPz0luWSEOvzJrTDTJW0CVVrOJhaTNWDtIYKw9N9q1KkYYtW9jjOuR685n24
         0MbQ==
X-Gm-Message-State: AOJu0YxdoE0wIdMd4mCzH2ItYV8Gl7FCXJArrhZxay/XHWrThTdkU2Us
	6A+nIf+wzbJtDntXnaXWeW6ufQ==
X-Google-Smtp-Source: AGHT+IEhIWc+rwqEXOm79XKP02Vs6tvtegdLCI6fFlAq/EvagoUmMI4WFKDIe3c26N4RyxgWNDKTzA==
X-Received: by 2002:a05:6a20:9385:b0:161:3120:e840 with SMTP id x5-20020a056a20938500b001613120e840mr24937687pzh.2.1696983200909;
        Tue, 10 Oct 2023 17:13:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902eaca00b001b8a85489a3sm12443132pld.262.2023.10.10.17.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:13:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qqMqk-00CB5y-0c;
	Wed, 11 Oct 2023 11:13:18 +1100
Date: Wed, 11 Oct 2023 11:13:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Foster <bfoster@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Bart Van Assche <bvanassche@google.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 0/5] Introduce provisioning primitives
Message-ID: <ZSXono3GkXhgrZ1T@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <ZSNANlreccIVXuo+@dread.disaster.area>
 <CAG9=OMMM3S373Y6UEeXxnOyvMvA9wmAVd4Jrdjt3gzkz9d2yUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMMM3S373Y6UEeXxnOyvMvA9wmAVd4Jrdjt3gzkz9d2yUg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 03:42:53PM -0700, Sarthak Kukreti wrote:
> On Sun, Oct 8, 2023 at 4:50 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 06:28:12PM -0700, Sarthak Kukreti wrote:
> > > Hi,
> > >
> > > This patch series is version 8 of the patch series to introduce
> > > block-level provisioning mechanism (original [1]), which is useful for provisioning
> > > space across thinly provisioned storage architectures (loop devices
> > > backed by sparse files, dm-thin devices, virtio-blk). This series has
> > > minimal changes over v7[2].
> > >
> > > This patch series is rebased from the linux-dm/dm-6.5-provision-support [1] on to
> > > (cac405a3bfa2 Merge tag 'for-6.6-rc3-tag'). In addition, there's an
> > > additional patch to allow passing through an unshare intent via REQ_OP_PROVISION
> > > (suggested by Darrick in [4]).
> >
> > The XFS patches I just posted were smoke tested a while back against
> > loop devices and then forward ported to this patchset. Good for
> > testing that userspace driven file preallocation gets propagated by
> > the filesystem down to the backing device correctly and that
> > subsequent IO to the file then does the right thing (e.g. fio
> > testing using fallocate() to set up the files being written to)....
> >
> 
> Thanks! I've been testing with a WIP patch for ext4, I'll give your
> patches a try. Once we are closer to submitting the filesystem
> support, we can formalize the test into an xfstest (sparse file + loop
> + filesystem, fallocate() file, check the size of the underlying
> sparse file).

That's not really a valid test - there are so many optional filesystem
behaviours that can change the layout of the backing file for the
same upper filesystem operations.

What we actually need to test is the ENOSPC guarantees, not that
fallocate has been called by the loop device. i.e. that ENOSPC is
propagated from the underlying filesystem though the loop device to
the application running on the upper filesystem appropriately.  e.g.
when the lower filesystem is at ENOSPC, the writes into provisioned
space in the loop device backing file continue to succeed without
ENOSPC being reported to the upper filesystem.

i.e. this needs to be tested from the perspective of the API
presented to the upper filesystem, not by running an upper fs
operation and then trying to infer correct behaviour by peering at
the state of the lower filesystem...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

