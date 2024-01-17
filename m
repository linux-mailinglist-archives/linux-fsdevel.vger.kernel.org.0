Return-Path: <linux-fsdevel+bounces-8185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888C830B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AC1B240DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F548224F5;
	Wed, 17 Jan 2024 16:52:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8284224D6;
	Wed, 17 Jan 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510320; cv=none; b=sp90fCAdjRGYgLzcDwX+X2+JZnKHN6ZYov+ccuAXPKvzDsP9TNTmbR3XNn5R+aEI7cc9XMQNJ9m8L9A7akyO0zXYCgKLHjSEG72UYlG/wUIm4BimJ1m6noGeQi9IQUTc2DP88ZHRdqmQCfGXRZyOkJaPKQb8dAshAZQdufcTVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510320; c=relaxed/simple;
	bh=/MO/EiEiyuqafKAOteDF8mFDYGfee9/3z57wVlNcZ+Y=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=QY2wmZNkWwLbCv9KMKWaTflz6rF0pNHtwbE7KsuUcvxH0Zn8o3YcfJvV7ZmUsPAxsaL9u7TSjh8RCgs0Eq6ZUWcu33nRo0BjSV+EvrN7/7mEYNOHc4PLbTdC3NjAjAkPxSSwR8SQo4VegY42wJAp5fLjDPKRbvR5/yVunheZP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559b3ee02adso2393941a12.3;
        Wed, 17 Jan 2024 08:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705510317; x=1706115117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MO/EiEiyuqafKAOteDF8mFDYGfee9/3z57wVlNcZ+Y=;
        b=k9+kXhjRXBiMYEkZECn7Adb0JcXvb5uyEySGhEVz6m7tk7eeOoxVoKvWOjYVWkKn7Q
         fYnBjNfA8DalfrOpKNdHHxiygxh4zyJI8V5NjCsENCk4ddqw2dsDVq4EpwBk8uakeE9B
         GeiMnL7DywYxQci3xFMAHHV7yV9+m1UPrz9oJExGMaLtYsEY6T2bgIwZYH7f6VABfEi7
         WsJLE2ciP7kBCS40+M2MmEu4PoHq4pnQuhSZXADCZUBko4AvljjPT3imazDMFMQL+Mcd
         qlKTlOGDQXe9mv7Y0ZWmi0dBa5V2XiHsCM/eSXyCYaR9T0QJ05aVVAhn0xPlXktnA54F
         pvHA==
X-Gm-Message-State: AOJu0Ywf2S4htSKHcFHbUUxKedqdeuM33Yqy8rhHG5J9xcWanaK8dLdJ
	X5g14wkcSmq2e1RTMniNmrr9+7Y3bSa3UA==
X-Google-Smtp-Source: AGHT+IEaOzWXhyWLBy8CSyyXKVdkEUG87Vb1LXXQfW5Y9Ua2bAGMGy4jyKApG1X1Pro4wEVR+GAlow==
X-Received: by 2002:aa7:da4e:0:b0:559:d09d:8702 with SMTP id w14-20020aa7da4e000000b00559d09d8702mr592930eds.120.1705510316672;
        Wed, 17 Jan 2024 08:51:56 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z3-20020aa7c643000000b00559b4df9f06sm2057016edr.65.2024.01.17.08.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 08:51:56 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso13752596a12.0;
        Wed, 17 Jan 2024 08:51:56 -0800 (PST)
X-Received: by 2002:a17:907:1115:b0:a28:f816:c4bb with SMTP id
 qu21-20020a170907111500b00a28f816c4bbmr3124469ejb.117.1705510316339; Wed, 17
 Jan 2024 08:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2929034.1705508082@warthog.procyon.org.uk> <2929563.1705508462@warthog.procyon.org.uk>
In-Reply-To: <2929563.1705508462@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Wed, 17 Jan 2024 12:51:44 -0400
X-Gmail-Original-Message-ID: <CAB9dFduVrz=-bb8YSmJq4Ec7Nr3K49ubznoTa0sdCyZzkddyRA@mail.gmail.com>
Message-ID: <CAB9dFduVrz=-bb8YSmJq4Ec7Nr3K49ubznoTa0sdCyZzkddyRA@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix missing/incorrect unlocking of RCU read lock
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in b=
oth
> > places before returning (and not lock it again).
> >
> > Fixes: f94f70d39cc2 ("afs: Provide a way to configure address prioritie=
s")
> > Reported-by: Marc Dionne <marc.dionne@auristor.com>
>
> Actually:
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@=
intel.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: linux-afs@lists.infradead.org
> > cc: linux-fsdevel@vger.kernel.org
>
> David

The fix looks fine.

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

