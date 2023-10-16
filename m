Return-Path: <linux-fsdevel+bounces-404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249AD7CA81C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6701C20A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE05273E7;
	Mon, 16 Oct 2023 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgtkUBqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4931F613
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:37:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB3AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697459836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Su8yaNN6gleYsl9c5NRTrh5jb8id9qjQrOt8Qy4EQT8=;
	b=fgtkUBqWajvxpA0bTEPyOVw87UuR+Go4t5HGvlpjL53OiU2KUcNxoUs4DIqADlUQIjU5aP
	4eAqk7SmnEdi4V8ZzSzv2WSxDLnob72K51IiqIjjAaxAkP1+zyA3P2DohRgs/BaqASebS+
	CeTrrpworRslKqpq9jGwl0WR2FxAKZE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-JrGd67O1NLujghmLTj6aUQ-1; Mon, 16 Oct 2023 08:37:14 -0400
X-MC-Unique: JrGd67O1NLujghmLTj6aUQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c15543088aso129943166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459833; x=1698064633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Su8yaNN6gleYsl9c5NRTrh5jb8id9qjQrOt8Qy4EQT8=;
        b=KLT3gvxUbrJceXruOOyjwHOWwP4aq6yYAwI9ghv9xClV0uOgxVl7lA9Ee1zd0kaeqv
         gqWD9/4yJHzIa2ku9JCNxWSvn/dJdARd0BsKQXfSEko/xInkCdChW9Stp3cDM3x4l+yV
         cabxkXfiprsdH+g5zG4s8EsSkkZknHgaCg9NqjxQiElamw3lz54dRLkZKpbvehf8RuIY
         aV3zdgbsqAXWfsfVjAYTbLWl6yE/jICdvoitWEn45PfLsgUlT9OKgs9qiNrlWykFMozl
         DzE9AhrVOhpOgL1ZiEyp83K91aLDDz+W2aDXNdbWr5sdy4TVVt4+me0MybkwUi8TJDZ5
         KuKQ==
X-Gm-Message-State: AOJu0YzxoX6ChJe8MgpXQF9j0IyclxDJRuTwy5DYxqY6BoJhSQHnAFm5
	1mrppDgYDPqIpfqlceKJDCO5HC0Or4pBeRXZfhoECk4LLR0g7B5apbBcPG72ahGjOp9BYeQyg0+
	R8QyYXsXmaaC7Kw/h8e/SoywK
X-Received: by 2002:a17:907:7ea7:b0:9ad:cbc0:9f47 with SMTP id qb39-20020a1709077ea700b009adcbc09f47mr6137025ejc.12.1697459833622;
        Mon, 16 Oct 2023 05:37:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTeQ/M+ycZkOVQebj4aUcWiSA9VpuBVUaM9K8JgYaF1bg0BBb1USApDPF/nmxRKtrWDQwtMg==
X-Received: by 2002:a17:907:7ea7:b0:9ad:cbc0:9f47 with SMTP id qb39-20020a1709077ea700b009adcbc09f47mr6137016ejc.12.1697459833363;
        Mon, 16 Oct 2023 05:37:13 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ck22-20020a170906c45600b009b2d46425absm3979682ejb.85.2023.10.16.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:37:12 -0700 (PDT)
Date: Mon, 16 Oct 2023 14:37:12 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 15/28] xfs: introduce workqueue for post read IO work
Message-ID: <skhqdob6wt3azlx64ndumvk3mxd2bxrbvqxho6ykf3otwed5vj@5bzi44xmh7vs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-16-aalbersh@redhat.com>
 <20231011185558.GS21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011185558.GS21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-11 11:55:58, Darrick J. Wong wrote:
> On Fri, Oct 06, 2023 at 08:49:09PM +0200, Andrey Albershteyn wrote:
> > As noted by Dave there are two problems with using fs-verity's
> > workqueue in XFS:
> > 
> > 1. High priority workqueues are used within XFS to ensure that data
> >    IO completion cannot stall processing of journal IO completions.
> >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> >    path is a potential filesystem livelock/deadlock vector.
> > 
> > 2. The fsverity workqueue is global - it creates a cross-filesystem
> >    contention point.
> > 
> > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > work.
> 
> If we ever want to implement compression and/or fscrypt, can we use this
> pread workqueue for that too?

I think yes.

> Sounds good to me...
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!

-- 
- Andrey


