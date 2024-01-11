Return-Path: <linux-fsdevel+bounces-7789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2D82AC10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C83E1F236C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455614F68;
	Thu, 11 Jan 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChDoKCRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21314F60
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6810751e1fdso21721896d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969207; x=1705574007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzL7Ban9DyGedAwsTsbPI4XJ7XL2g8NymZ5hTxWXIVg=;
        b=ChDoKCRC+xjluQyEIPpbGNK/TPOJkSHPoGrG2YyYQAddOvP8kh6kFdHVSTk5VKc0Jj
         iA8ofMEobQWFERmk/k9L4l//3+9xJhmgzGYUgVYp1Q0ztvi0kxP4LYrm2ffPjLFeIECk
         V+6t9szdg0kJ5NX1O+R8PINrm5C9Mvo9+k1pGs3wZNhlURN/6/egX6nCwtYVP59weYAh
         ttzsx1YBNeuhSXBPP7F0boVUegDxWPN0oVoz5N9N59RCVMdifefGYHp4sQ2sRXMhtLbA
         byGQIdQxShjSm68tzccJXCXpU+BsbQywnRPy4xwP/RAhCYFlU9mjXXAT72HB0AYy60ZI
         4CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969207; x=1705574007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzL7Ban9DyGedAwsTsbPI4XJ7XL2g8NymZ5hTxWXIVg=;
        b=EZKb/x8xiCJ+B4wg+2KM9OiQugKXPuLhpOcfvufhKBZYn9agGI5EWDJFEkEyQx9rfo
         teAAMQr72WbCYomBT5/1RsPGeboQXT+T1kcz2CuaeGvdIoCoYWJwssuVV3PPxYmjdiDs
         npk5OH59tcW+S/btUAeaevu507BU4SWjecU7Or3gge2uabKLVovJ5Ar4VDlb/gL7jhfI
         ADzLRTV97zeEhZ4FU/ow38pe27ma7YrKxQ1A6sWmDzlU/u6heTcCggI/YaAsZGhZK5Yh
         u4wq2kDV9Q5MoMs7iUvEsAn0lTiLg8LVXTbaz84VrfT+ThfzFY1Gn5RlK2tJiPXD2XTI
         hzVQ==
X-Gm-Message-State: AOJu0YzawElzrTPOsHjdzvl3VkEDVrZxhzTh64nE6S+UHwmxOXVXirg/
	k4AgbQ6BtHwjLB11dm1dIeme1qHM1ZCB4jp+Z5g=
X-Google-Smtp-Source: AGHT+IGAZcPTtq7r5JaQ2Uh4oTRNdOoOE+rFKDs8VPMWcunL0J1zP28TyC/DN1zIwvxpWz1FbVZcpW9uqbdHBMcdXRE=
X-Received: by 2002:a05:6214:3d85:b0:680:f782:b838 with SMTP id
 om5-20020a0562143d8500b00680f782b838mr1037804qvb.2.1704969206953; Thu, 11 Jan
 2024 02:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109194818.91465-1-amir73il@gmail.com> <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
 <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk> <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>
 <20240111-gesponnen-runter-f97e0526abb8@brauner>
In-Reply-To: <20240111-gesponnen-runter-f97e0526abb8@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Jan 2024 12:33:15 +0200
Message-ID: <CAOQ4uxhKRSdKtif8D8SYMimReQeSDajhOHbaAz4x5EVQm5onhw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Jan,
> >
> > What are your thoughts about this optimization patch?
> >
> > My thoughts are that the optimization is clearly a win, but do we
> > really want to waste a full long in super_block for counting access
> > event watchers that may never exist?
>
> Meh, not too excited about it. Couldn't you use a flag in s_fsnotify_mask?
> Maybe that's what you mean below.
>

Yes, for my v2 I will use a "taint" flag in s_fsnotify_mask instead
of keeping count of content monitors.

> >
> > Should we perhaps instead use a flag to say that "access watchers
> > existed"?
> >
> > We could put s_fsnotify_access_watchers inside a struct
> > fsnotify_sb_mark_connector and special case alloc/free of
> > FSNOTIFY_OBJ_TYPE_SB connector.
>
> Would it make sense without incurring performance impact to move
> atomic_long_t s_fsnotify_connectors and your new atomic_long_t into a
> struct fsnotify_data that gets allocated when an sb is created? Then we
> don't waste space in struct super_block. This is basically a copy-paste
> of the LSM sb->s_security approach.

Not as trivial to move s_fsnotify_connectors, but I think it should be possible,
because basically, I don't think we need to ever detach an sb connector
once it is attached.

I did already look at this when writing the above suggestion, but it was
not straightforward so left it for later.

This change would be relevant for another feature that I need for HSM
called "default event mask" (sort of like the default iptables rule), so
I will look into making those changes when I get to this feature.

Thanks,
Amir.

