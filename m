Return-Path: <linux-fsdevel+bounces-35067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028BB9D0AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5CA281EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B584153BE8;
	Mon, 18 Nov 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRrtDsgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69283BBF2;
	Mon, 18 Nov 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917858; cv=none; b=m3YN152kAQfRgxdFWGV5ud0UVmKS950x4SOGQBa5ScyFXnTudwyVTXDUSgpkbfUknCfSAofqb0wN+hSO9P5N1T9wgDkkfyZZmGhLeZRR9M8bBhX1buK2oRtxTMMX62Ho46Y5wOFd1JrVvbqVQ4FLUJhw3dknYEWPHnuS6U03bXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917858; c=relaxed/simple;
	bh=siOKzvl0gO/qlA1DJbVxPOlPsogCFtqHqXQHhLmbOGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRmsKUOVGzt4vyXO367ldyGDGY8pABGgBCM8DlSD33HOe/rh8v+KmLPDO+H94A8uaCSReuFNfQmLYRUtDQG6DbzlkdZBNEdB3DC+1Sz5aIiHuyrc5GronMt3HI1ILJ1bsnoNhBYT2L+Dq/XXcgc2huNR9mJjXkA2R79dRT4cr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRrtDsgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68FAC4CECF;
	Mon, 18 Nov 2024 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917857;
	bh=siOKzvl0gO/qlA1DJbVxPOlPsogCFtqHqXQHhLmbOGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oRrtDsgnzJO1WeqZqGVjBhgJ7tit/IUbCWW0VvuM0nQPcVL8JkgGeNt8E/oUYo8Mc
	 FcyXSt8oN8gsLoxFs0j6AHfA4p3v1u73h517A0kw1TKoNJLqFNgFMSF6VQCNVxVEQD
	 2Iojy7eZyWjKCadn3H9l1SFMlaqJ8ODAmOfVSBvkuPmn3mea0ocquGOdkfzus3vnVT
	 nzStyi1LX4+g1IBoaCC/IiiJjhnXHhgObmlrooB/llUGWThEA727FfilUdXcp8RGFZ
	 Os55yzjZlJNH6lTnINsZiEKYModkWNu+9k6Pdr7He605G2bpmdRQNQiGgREj1cW+rw
	 e7r6ZYNZJLJ+w==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e607556c83so2205290b6e.1;
        Mon, 18 Nov 2024 00:17:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwprB2zGY7AJ6Q9+MYcuQYf9tDbP3nGLoLxm8AYpCOzOBGV3RtXa3RPODWKq9EmXim6qIQpG2Mi7TEuVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaZsJaAeWpwthEbSYlwsMGK9vxvL8V7heuARrMO3m4kmoUUaF
	FUCmqpDczu/lgG/mSyLTLosZ/WIuoJjtBF3TEeHfVxi7JZUv5TlPdongK3CYaNws7DNQm/c37Y/
	tSNs8UmRnlq7KaYDkivEH8xVYYvI=
X-Google-Smtp-Source: AGHT+IEWPxfKvsZMKJ0z6lSphJ5BoxMDEwkf+0O8TK9Qiwpji/MYjc3339o2No6dZXDb2Cn7K9vRgAByHdLTv3/A5mA=
X-Received: by 2002:a05:6808:16a6:b0:3e5:f9ee:a2b3 with SMTP id
 5614622812f47-3e7bc7a22d9mr7778394b6e.4.1731917857081; Mon, 18 Nov 2024
 00:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67399d6c.050a0220.87769.0005.GAE@google.com>
In-Reply-To: <67399d6c.050a0220.87769.0005.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 Nov 2024 17:17:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-T3gnugL4MyvArK5dONRJsyN3X6skbZWFR43V=h5bOzQ@mail.gmail.com>
Message-ID: <CAKYAXd-T3gnugL4MyvArK5dONRJsyN3X6skbZWFR43V=h5bOzQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in exfat_iterate
To: syzbot <syzbot+84345a1b4057358168d9@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

#syz test: git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git dev

