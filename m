Return-Path: <linux-fsdevel+bounces-4457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96667FF9C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74038B20D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41915A0F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YNyyzKCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4510DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:00:42 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da819902678so1055047276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701363642; x=1701968442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hky/KzjhYHUu4aS2qxPMLUaAm2fO0s9p6joqU6jYEY=;
        b=YNyyzKCyfsDJEM1CKQHQD+BXpNbAgAxMWeZ5wQamWzzifpi6ycxP+xC9V+xWSbJWEr
         JA0w9sXn1E3nXDzWK5gyQphUs+RGlDzIWuC1qlvh18wfisjwn3Pj9ThWk3bWgtP4HkJP
         5KIAYsUWSk+OI5VVRySmF2laOlvYPrt8cex+kioYbE5n7isyGBdBcLq6WxLhuAnF+joC
         HLxmJ9LbtgjZ9y8uh3MoGFn2xNQByszDC1T6V9yFNClI7uOLVkUWY8AhscSga9ltQyUm
         UHpbvPlQjLYjKqNzH79ApOgtyPPxsQaOES2RMnt2vFuQRdkvLY/ewrOiP/BQOhAxW6qd
         c/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363642; x=1701968442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hky/KzjhYHUu4aS2qxPMLUaAm2fO0s9p6joqU6jYEY=;
        b=BhREjXSTTl8nPoz7a/jFGNf3khCIOWMmNrBimIbNYsegHBUAekbpwJJoGJEeoCPpys
         l5abDeo+PitWubv7LFDqqexDUHe06quuSnQz0WCMLAsRBULO3kHP1RVRwv28CX9Gd+d5
         1GCBp+ewohVd0NMJB4IlgxfPWCuaqrVT5GW/m6L9ENiJihmB5rZxFnVvCAtn8o6CH43I
         kmf0sbi1p3qBvisXBuyjsWRr1ziqXYHt7VLKGS9WacdZS1yVvCBQB0S9hjKLvHFojiaY
         +6Uerrw/GstPS9zYE4C3P/v001Jn0xOxheSUYrW/DJrn0xPfZ/2EYEyaSvIibBeuqVLW
         1n5A==
X-Gm-Message-State: AOJu0YwfnygJXYw3Wl4KH4f6EwigBdEq2wFJ1fqxpGy7Wt/aojy1t0Yh
	QDYyNovmHgTHCVZg6wRlEdKUoqJsuh/nykh7b+gs
X-Google-Smtp-Source: AGHT+IGWeq1u3TY1LG8uphGYW7WlDE5cBTGD3zQC5Dpze48seToweLISJPvMV/SevTHuqk4ZZoykKhlfrHXvZ4kk9d0=
X-Received: by 2002:a25:4f05:0:b0:db0:2b47:aa1 with SMTP id
 d5-20020a254f05000000b00db02b470aa1mr20617458ybb.40.1701363641760; Thu, 30
 Nov 2023 09:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com> <7cb732ea42a221b4b8bbfad941d9dec41a3a35fa.camel@linux.ibm.com>
 <CAHC9VhS28XuVjNX73H9qWZibObCxKCx_M3omQu9+5EdourUc+w@mail.gmail.com>
In-Reply-To: <CAHC9VhS28XuVjNX73H9qWZibObCxKCx_M3omQu9+5EdourUc+w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Nov 2023 12:00:30 -0500
Message-ID: <CAHC9VhRpNc2ih3iwc00sNGsgM_Ogqf8_r=kLGp_Q4+LdAz-J1A@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

A quick note that I'm going to have some networking disruptions at
home and email responses may be delayed for the next few days.

-- 
paul-moore.com

