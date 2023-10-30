Return-Path: <linux-fsdevel+bounces-1580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB57DC106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7704E1C20AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC61B264;
	Mon, 30 Oct 2023 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="attmn29X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE41A73B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:14:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3DFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698696897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
	b=attmn29XAl7x+L5yTUgpH7AFi4IroT9fHxHR33wbHMp5/gSCLSKJP6Xxx96zDsbVGoK/HF
	3+k1voa/f5ZtAgoTuh0sdPJ3dcvrjS0W0DxXmOanQp0AhfiYrqKeflHh63PoiyJZAXOGBc
	oGE2GVJGUHHNo/xk+jLtVl4KJCtH8KM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Jbe9cBaSNguMphMhN2tidA-1; Mon, 30 Oct 2023 16:14:46 -0400
X-MC-Unique: Jbe9cBaSNguMphMhN2tidA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-79499607027so438009241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696886; x=1699301686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
        b=OTZ4UB+8bMn5le3nEv6AtmHFXVW5RUXQ634Mu0LKbA+5ICjDWMyey80EUMDmOHmRLq
         rCuKFO+ulz1mVz2M5KwrkltWpU2CB3E2iuDAMjGA50ss8hVNyLb8DKAFMJze9fCaWOzC
         a54taaK03GKUkeGia2qL7rlQtQi9DpJBlrwYOjrzai3FSXXOPqsROr5nmlIq3rdVkf9e
         tMkO9f+RvG+ZnifALpYXir3OnsmI0PxA21mGsZCIBOHZnys9Esd41sbES7Ha5WpwtjR2
         OqdLhK1zCBoF+AY/wxmXdSlLgPDLhvrBUJ6rVYF2sNc28yqaIlQi+ThYBP8Wy3nwxcKG
         tr4g==
X-Gm-Message-State: AOJu0YyIzHZdNxLn297giiOeHFdBqqLTiGTZBQmkHRVuWOngKidUd1zd
	2VG7NEmQurGDr8HKD4g7DhX0ugnkImNFDiRFustErixzULgrVLqIZwa9GMw2A/ojC+2681/lthO
	TOCTp0OylqTZeX1DeLWLW1oqSwA==
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263791vsh.0.1698696885454;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpG5KIh6bv0/spHSBWngU4H0SaI7+Bd7c85laDovrwWadeNA9ZKAwXd1Hhen8C8UCCLPNlZQ==
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263776vsh.0.1698696885190;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfc0b000000b006564afc5908sm3707026qvo.111.2023.10.30.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:14:44 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:14:42 -0400
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
Subject: Re: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end
 of the test
Message-ID: <ZUAOsn9Fj/qCo+xg@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-4-surenb@google.com>

On Fri, Oct 27, 2023 at 05:38:13PM -0700, Suren Baghdasaryan wrote:
> uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
> areas used in the previous test run. This approach is problematic because
> while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
> which might differ from one test run to another.
> Fix this by calling uffd_test_ctx_clear() after each test is done.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


