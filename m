Return-Path: <linux-fsdevel+bounces-1584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE267DC13F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE9B20E1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979741C2A9;
	Mon, 30 Oct 2023 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFZ8w83a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858718AFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:35:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42775F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698698133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQqQywcIq3pleqCdkmZJnvq+aD96AGHUCBNW1Pk+bxA=;
	b=HFZ8w83a8uh/pxxjf+G5cwo3dFA0HkrRrFOabM87Ze9mO6pTdRD1SxcH5fI4VQPjmEUIJ7
	5iwKQ3b/WJ+m3d5soo2PGM9e2hfg9vYxKbvFFEBjTJ1djk8Wd/34nrnNuqMoetTndeWmgS
	W11HADr153CPknUU06z3de5rrzGk+20=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-oVaJEcZVP2SPsD0l8S7Nog-1; Mon, 30 Oct 2023 16:35:31 -0400
X-MC-Unique: oVaJEcZVP2SPsD0l8S7Nog-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-637948b24bdso15294376d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698131; x=1699302931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQqQywcIq3pleqCdkmZJnvq+aD96AGHUCBNW1Pk+bxA=;
        b=Ihuu26LLPKSCAjzQxrrqujsAOFUsPgi5ynsjK1+wBZB4YgpGu9bsQXXkO2Mx4u7rX4
         icquf04jqg9AF1Bis1X6Ru9v9bNn4vokTO3yl2Q+bbuPybsZmh2EqYMU4SUaj/yLRSkR
         bKqT46MgGzuy9/wVXm/c5AFgEY++kvMucrRVkbZD0VbJCzPNjrfEDcGm1xcZS057d0D1
         WwMBXPnnWogw0uVCBLCZ61hrOxanvH7zK5C0eAl3ePECt1Jw6zv74eik/Ty0PeichXOH
         wnsx0F7HYEwmkqVW/OdaW5bKBKRen/n0b0UfrdsQ5Cm27aRY9RJi1KpGuAmJYOkeeK0N
         L40A==
X-Gm-Message-State: AOJu0Yz8/3QeWQ/AfPnUwOiKqB+qGVT9pytrvtpRTBFLx9ng7YmniRBx
	k9T3dMrwQazKVcVWB3UuQjPgGq5YMoRDnKz97hOFO4BqS4uzVBaLsj6qFZpEFJm9MQ/WFGUGDgB
	EOE4Q65PvuaNyfN3GEkYroVALZw==
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id s12-20020a0cf78c000000b0066d61115c5cmr11465045qvn.3.1698698130993;
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoHYJYrlsiTilKNNDCIy4gwl3kNblk99zpaZUZAXSFQUfkN4dW93Dg1VUo6nUBxJv7RxuZhg==
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id s12-20020a0cf78c000000b0066d61115c5cmr11465017qvn.3.1698698130723;
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id cx15-20020a056214188f00b0066cfadfb796sm2362777qvb.107.2023.10.30.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:35:27 -0400
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
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZUATjxr2i7zVfL8I@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-6-surenb@google.com>
 <ZUAOpmVO3LMmge3S@x1n>
 <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>

On Mon, Oct 30, 2023 at 01:22:02PM -0700, Suren Baghdasaryan wrote:
> > > +static int adjust_page_size(void)
> > > +{
> > > +     page_size = default_huge_page_size();
> >
> > This is hacky too, currently page_size is the real page_size backing the
> > memory.
> >
> > To make thp test simple, maybe just add one more test to MOVE a large chunk
> > to replace the thp test, which may contain a few thps?  It also doesn't
> > need to be fault based.
> 
> Sorry, I didn't get your suggestion. Could you please clarify? Which
> thp test are you referring to?

The new "move-pmd" test.

I meant maybe it makes sense to have one separate MOVE test for when one
ioctl(MOVE) covers a large range which can cover some thps.  Then that will
trigger thp paths.  Assuming the fault paths are already covered in the
generic "move" test.

Thanks,

-- 
Peter Xu


