Return-Path: <linux-fsdevel+bounces-887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4317D23BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D51C209DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469E107B4;
	Sun, 22 Oct 2023 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcuK1kh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770D63B2
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 15:46:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA551733
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697989597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGgrk7U7ziyea5cunTO+IloGn3qNk/rZsIkV0TfaQNg=;
	b=EcuK1kh/ZQPPzsx/eAaDZy6ZkM8gIso0iZA3sjvz9KpW+ajDtnV8yr6JiJ4j/l3HU9uLrM
	MFsvVIj70zP4dmmToGijT1GvKCD+usk7nLEaLtUvW7eLwbipoiDv2GEFA06Yxzde2dBtKh
	3vLETs72EuYoxK1t4lbpiOjfpRhshGg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-4frjd6XdMvC1g9fRtys7HA-1; Sun, 22 Oct 2023 11:46:36 -0400
X-MC-Unique: 4frjd6XdMvC1g9fRtys7HA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d2fdf80beso8870866d6.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989595; x=1698594395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGgrk7U7ziyea5cunTO+IloGn3qNk/rZsIkV0TfaQNg=;
        b=tYMWqkHp0rgTLAMLyhdg4dUntyiwlEaxAyXv5NpnzMmqjonWxQ/HXdhhUC0ub0ddrm
         vp6jD+cVc0Ut7Sy+xtk2OVmr5it+h+0VedV9C8KFh5osOo2TPS2pT4fYngH3AyQwin2d
         XYL0SAVh3tmMp5aLRxQVM+b/zz+9UCjokgr4wHAspfMV8rCMXvBZ9jUNR+U2YbXpL2zc
         qcuojY9SsQMzd3u4IjDs9sepAg+vlGTqOYAAj4+9z4T4y9EwZMbSDZWlelO5KWeLAyi7
         dERy9BtIVWyKmZ9koeDq6bLoOz8N1d3GxftaI5BEwtT/ZotFQ2aLlwrqX3uFDAPNMlmH
         P2zA==
X-Gm-Message-State: AOJu0YxGD2I672c++L8a8bZdL58II98tD+rhd6uXKk9EfolBRS4CRPY4
	XAfmNoM1WaLnP8WnsoDK2kSRykryZEOcYa5uxV9RgYDI+99MikPO7z48c52vcKvJ/XWOsmcMe2R
	fnGMkHeOH5O8pVKpDtStPgkZxEg==
X-Received: by 2002:a05:620a:2b4d:b0:773:b634:b05a with SMTP id dp13-20020a05620a2b4d00b00773b634b05amr6696826qkb.2.1697989595297;
        Sun, 22 Oct 2023 08:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWN6AC503edm3tNF4Vnyfigq1+yBTgZzdwoQzZvT6nDeUnhRhK8Btp6MrUdseV2H9geWSwow==
X-Received: by 2002:a05:620a:2b4d:b0:773:b634:b05a with SMTP id dp13-20020a05620a2b4d00b00773b634b05amr6696793qkb.2.1697989594852;
        Sun, 22 Oct 2023 08:46:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a228800b0076cdc3b5beasm2100836qkh.86.2023.10.22.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:46:33 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:46:31 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTVD18RgBfITsQC4@x1n>
References: <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n>
 <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
 <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
 <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com>

On Fri, Oct 20, 2023 at 07:16:19PM +0200, David Hildenbrand wrote:
> These are rather the vibes I'm getting from Peter. "Why rename it, could
> confuse people because the original patches are old", "Why exclude it if it
> has been included in the original patches". Not the kind of reasoning I can
> relate to when it comes to upstreaming some patches.

You can't blame anyone if you misunderstood and biased the question.

The first question is definitely valid, even until now.  You guys still
prefer to rename it, which I'm totally fine with.

The 2nd question is wrong from your interpretation.  That's not my point,
at least not starting from a few replies already.  What I was asking for is
why such page movement between mm is dangerous.  I don't think I get solid
answers even until now.

Noticing "memcg is missing" is not an argument for "cross-mm is dangerous",
it's a review comment.  Suren can address that.

You'll propose a new feature that may tag an mm is not an argument either,
if it's not merged yet.  We can also address that depending on what it is,
also on which lands earlier.

It'll be good to discuss these details even in a single-mm support.  Anyone
would like to add that can already refer to discussion in this thread.

I hope I'm clear.

-- 
Peter Xu


