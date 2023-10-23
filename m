Return-Path: <linux-fsdevel+bounces-960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EF7D3F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F27BB20EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348921A09;
	Mon, 23 Oct 2023 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTW9qEoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC62219ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:37:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46582CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698086264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u4K65KDxcVBXkTfLaNd9e/KXy3N51yIwtDp59/y0wf0=;
	b=bTW9qEoQBgq2CgBVcXID1wm7+eAOc+tDwMWN/kCVy2j2ogT4sQ2Rmb/35WIGt/gGgWXgNp
	Vuk3yuQm0wxpIsv1XTDhNZ4pbvjmSAMuDZqbkJTHbbzJuc24bb2p6a7TW0xD7hn8rciDvJ
	ma19Ot3xTxpPqZeKcpsD+VrREEHTKH0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-XIQ-p5XEMfWkB7Xd3V2u9A-1; Mon, 23 Oct 2023 14:37:27 -0400
X-MC-Unique: XIQ-p5XEMfWkB7Xd3V2u9A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65623d0075aso11526076d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086246; x=1698691046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4K65KDxcVBXkTfLaNd9e/KXy3N51yIwtDp59/y0wf0=;
        b=RooPCehMy06ySLhUjbtG71fcYXTEQs/pRAQdLDLvy/U2hsNghBSdzNEL4RPfmN5yBE
         1LBdRCl83wksbEjpPBy6R+atnn1LsrTSVZKQDUJ7nAlkLltQTh9e7ZdR7hSeNJlaHxoi
         qgzVThr+zY6n9CscthLqtJFQlqcBwnbMXPqtgt1XyDWGiJXFX5bpCMbPUjiRDQ306t4E
         g40R1x8x1WS0SpTBqgXVxWb0haK21fMDhU8JES8oN45H9yqWt4658eN6LzhR6Y+mSGuA
         OAuwPPx1tWYNNpdzv3VkEx7FzngghnlNqKJ7/prAI1Pbhhvk9AW+wdl3Gmq7X2EVem/s
         ZOvw==
X-Gm-Message-State: AOJu0YzvArCeDXHXe6uXwYSLLNl+GnlY3sspEfEKdgAkaHkyUVxZI7ED
	IsJbRhV3FrjHYyDHyDhsePDbdqryXnVO72bhK9xwmxdxdw9ZdLJQu5by97vmlB7/VuvsKrZa0Be
	Cg5O7iIS7aIaMYFhnYWXqrkkzdQ==
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id y17-20020ad457d1000000b0066d0b23a62emr10149575qvx.6.1698086246653;
        Mon, 23 Oct 2023 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSC2tyow+6AySdZJ7+gMEaJlJb2QTPUAC5dumXqlwlIN8V3DCe/xX12BrSeeNMm9RA8GJlvA==
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id y17-20020ad457d1000000b0066d0b23a62emr10149543qvx.6.1698086246299;
        Mon, 23 Oct 2023 11:37:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id cr14-20020ad456ee000000b0065aff6b49afsm3058368qvb.110.2023.10.23.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:37:25 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:37:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTa9Y++/PCV7HRoM@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <ZShsQzKvQDZW+rRM@x1n>
 <CAJuCfpEtaLs=nQK=oPHe9Nyq1UoqLk1pt2k-5ddDks3Ni2d+cw@mail.gmail.com>
 <ZTVVhkq8uNoQUlQx@x1n>
 <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>

On Mon, Oct 23, 2023 at 10:43:49AM -0700, Suren Baghdasaryan wrote:
> > Maybe we should follow what it does with mremap()?  Then your current code
> > is fine.  Maybe that's the better start.
> 
> I think that was the original intention, basically treating remapping
> as a write operation. Maybe I should add a comment here to make it
> more clear?

Please avoid mention "emulate as a write" - this is not a write, e.g., we
move a swap entry over without faulting in the page.  We also keep the page
states, e.g. on hotness.  A write will change all of that.

Now rethinking with the recently merged WP_ASYNC: we ignore uffd-wp, which
means dirty from uffd-wp async tracking POV, that matches with soft-dirty
always set.  Looks all good.

Perhaps something like "Follow mremap() behavior; ignore uffd-wp for now"
should work?

-- 
Peter Xu


