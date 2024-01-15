Return-Path: <linux-fsdevel+bounces-7933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F582D81B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F82B21584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21F27701;
	Mon, 15 Jan 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp514pR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFE1E867
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso9652601e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705316911; x=1705921711; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8zZPv16a04c2JrdAylXruCjxboLXHW/YtOK6cugPVg=;
        b=Sp514pR8VQZceOOmNIHrZ2aT1/poR8nPNTliEVOC5NkghlP1XLJIYWcW+geI4nqQCJ
         HTcIMv1eeDFese6ySz+lh6G4IfaPwIW3FCnb6xJ3rwCbcLkFMazHt+Ic9QKtmw+WYqOO
         qi8kimZ/m7523Wiflu+bzC4hIXgeqrxxgfh/M8jOmkadDEGM31mCb60LPDWizil3shLE
         oeBG6yD5I6NOmD5ZK08YzxfUMbK5TGSFkC7Z2vehJOevQDEc/9AC+Zj0ev2VeAk8FTgk
         YATXyJeqemWFTbtrqeFSAmxVLhlOxCP7yZPFiTgqjeUNHnn5mOcPw9HpDDMKGjChdWhj
         NVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705316911; x=1705921711;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8zZPv16a04c2JrdAylXruCjxboLXHW/YtOK6cugPVg=;
        b=WBKKhv1N1Upy+nl0CAqeJB+SxbM/M5lPEMqL9ybQ1messXPVBjnGUDG1+qnGmkT1K3
         F8avSdn0vIZJHlHzQjOBtXObokLsPLxO/9AnY23rUZrY+uVYGW04muSJJbsZNbtB97OR
         MmWqnSFisLq3W4Nef/xjYSPojk1/RB/bP+vR6+n65awX1EvF7K+EP1Q5+uY+0jhm4DM2
         /jNw1gZ4F8ED3aTU3gvfXT/61qftR4WYIdRqjfQtTU+GkHn+XwYGLHmIerh4VbSUoRNX
         jRlQtHMyNH5NX3WfcSHG+2+CYJLIhCNxXmifDrLgpXlf0u0g7MAvzxkxSKoaVY7Tmrpg
         fjsw==
X-Gm-Message-State: AOJu0YwhtV14c7x18YsR/mNcf6xuaUB9rQqUbG6NegsgvSUhCx/E9a+K
	7CAN4g8yfacVcACtV3grtqI=
X-Google-Smtp-Source: AGHT+IGgAdKBX9EYgL2//c8WYkYqgwnBhB0dF1GytNx0iq9EFmXcKA0+uYVXLhqreQWLJzhUle94nQ==
X-Received: by 2002:ac2:5b1a:0:b0:50e:e1dc:9f20 with SMTP id v26-20020ac25b1a000000b0050ee1dc9f20mr2285955lfn.28.1705316910442;
        Mon, 15 Jan 2024 03:08:30 -0800 (PST)
Received: from rivendell (static.167.156.21.65.clients.your-server.de. [65.21.156.167])
        by smtp.gmail.com with ESMTPSA id dw13-20020a0565122c8d00b0050e7bc67cf7sm1444188lfb.138.2024.01.15.03.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 03:08:29 -0800 (PST)
Date: Mon, 15 Jan 2024 12:08:29 +0100 (CET)
From: Enrico Mioso <mrkiko.rs@gmail.com>
To: Anton Altaparmakov <anton@tuxera.com>
cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
    Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] fs: Remove NTFS classic
In-Reply-To: <8a5d4fcb-f6dc-4c7e-a26c-0b0e91430104@tuxera.com>
Message-ID: <00906203-9df2-ee5b-da37-b45073373ee0@gmail.com>
References: <20240115072025.2071931-1-willy@infradead.org> <8a5d4fcb-f6dc-4c7e-a26c-0b0e91430104@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, 15 Jan 2024, Anton Altaparmakov wrote:

> Date: Mon, 15 Jan 2024 12:00:35
> From: Anton Altaparmakov <anton@tuxera.com>
> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
>     Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
>     ntfs3@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>
> Subject: Re: [PATCH] fs: Remove NTFS classic
> 
> Hi Matthew,
>
> On 15/01/2024 07:20, Matthew Wilcox (Oracle) wrote:
>> The replacement, NTFS3, was merged over two years ago.  It is now time to
>> remove the original from the tree as it is the last user of several APIs,
>> and it is not worth changing.
>
> It was my impression that people are complaining ntfs3 is causing a whole lot 
> of problems including corrupting people's data.  Also, it appears the 
> maintainer has basically disappeared after it got merged.

To be fair - it's more like "intermittent" maintenance rather than "no maintenance".
Konstantin - would it be OK for you to have a co-maintainer to help out?

Enrico

>
> Is it really such a good idea to remove the original ntfs driver which 
> actually works fine and does not cause any problems when the replacement is 
> so poor and unmaintained?
>
> Also, which APIs are you referring to?  I can take a look into those.
>
> Best regards,
>
> 	Anton
> -- 
> Anton Altaparmakov <anton at tuxera.com> (replace at with @)
> Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
> Linux NTFS maintainer
>
>

