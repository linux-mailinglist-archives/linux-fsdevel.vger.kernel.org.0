Return-Path: <linux-fsdevel+bounces-51-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F47C5123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E501C20F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281371DDCB;
	Wed, 11 Oct 2023 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG+c8Z1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246E1DA58
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:09:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E5A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697022563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7i0TJFI9d4XbjTdESSdpldcYJIKaHsNys5HjyA4API=;
	b=XG+c8Z1ePB7bjB+wvPI1kK3mjmQhW7LzLFkQ0y3JAuDdBZBtPr4C3//NA7HROtyBqvBqPL
	/aXGYkT3CNgMsctY7yrRp0jheRAc4cU+hcxrTmWHkb0u494GKbpXo3k+bZqUhQWfP0Lg/F
	YwpX0Mg0UmaOQCo4xEoRfta722UCY9U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-IFdl3Yw8NxuL19YSd6x06Q-1; Wed, 11 Oct 2023 07:09:21 -0400
X-MC-Unique: IFdl3Yw8NxuL19YSd6x06Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c12c3e4595so57655921fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022560; x=1697627360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7i0TJFI9d4XbjTdESSdpldcYJIKaHsNys5HjyA4API=;
        b=nFJdBGEyqFqRnL3uS2d7SKuS9Te+lL7I6t6MxFA4Zb4pZamyTtDSSclmjG2tzwtv3q
         JriKSW2hWaALK5mtZytIy3YLfZA4DSAkzP6c+/iq4BPAlp6z9qyU+4rbDa7cA/KJ8a4+
         +ZUPg6K/hcwZEgbvm2Mf+QVQQ2gokXi8YTQyJOjj+eCaPf1h6GgA8rcmONr3qjHRccHf
         /WAyC+mdj0jgVYuXRkzwSWZZBDifoAxeudHruVR2T3+IZOze5MgtidKgE8sNw8VcCd8b
         nJMjzyC0HZjFzsFMWTI3iUW1+GNw9KciKp6Y2mMjE/us0X5zMkM3M5y3Sy7Nr5kUR2ZK
         JeXw==
X-Gm-Message-State: AOJu0YxFqPi3Ch1hdNaPZSXfbsKznLLhQCyX7nL9icjzzwl5NEI6s9k0
	hcGJHYNW3zI0fipWgpoXMMXvfPx194IL1b09zjfJ/MLMGNr58UI3+TetTSXFWSS8B/kuSUd0rXz
	5/wunJN9JKbYzxRbGwWs4QzDC
X-Received: by 2002:a05:6512:131b:b0:503:3421:4ebd with SMTP id x27-20020a056512131b00b0050334214ebdmr17941161lfu.63.1697022560032;
        Wed, 11 Oct 2023 04:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrllkG05Ach5liC9J7rG6Cgh0JKuFlyZ1Ps6tj2NTHIqGbPHXOS23Vt7t0IiuUT2NNIcszvQ==
X-Received: by 2002:a05:6512:131b:b0:503:3421:4ebd with SMTP id x27-20020a056512131b00b0050334214ebdmr17941144lfu.63.1697022559604;
        Wed, 11 Oct 2023 04:09:19 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id l21-20020aa7d955000000b00537f44827a8sm8753240eds.64.2023.10.11.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:09:19 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:09:18 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com, 
	Allison Henderson <allison.henderson@oracle.com>
Subject: Re: [PATCH v3 04/28] xfs: Add xfs_verify_pptr
Message-ID: <6g3pgk5lne5otglajnnt6badujg2x45uwevv63j5hxngnomqmr@6clv7xn6x2zd>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-5-aalbersh@redhat.com>
 <20231011010143.GH21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011010143.GH21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 18:01:43, Darrick J. Wong wrote:
> Could you take a look at the latest revision of the parent pointers
> patchset, please?  Your version and mine have drifted very far apart
> over the summer...
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-fsck
> 

Sure thing, sorry, haven't checked if they changed.

-- 
- Andrey


