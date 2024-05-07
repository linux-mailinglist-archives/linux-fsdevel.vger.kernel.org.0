Return-Path: <linux-fsdevel+bounces-18940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F828BEBAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD171C223D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1216EBE5;
	Tue,  7 May 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpNd/Ja2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03716D9C4;
	Tue,  7 May 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107481; cv=none; b=CURbYCpSWlfplWWlxCZc+kwHvYo5lvCRqExny2/ybk5Z4X04N/WxpyDpJ1LQydf6m/WtmJa+DqeO/WEkrpn3qABPS3ctAsSocWr7lFMydcFTNKOFs+iUKWeBKYl5Z2jUehFQEONI+7sJDrEvkjtH074doeh4utRO8q3NSj1RdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107481; c=relaxed/simple;
	bh=E9XMpXDc4GOLixsNa+tnFmNYImN3ywdXtqA8m4WFyPw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LkiWqLoj8ecazHOVL7wk/9er98Dd623c4o7Cj4lM07m7N7LqTeL9qMdrjhK2HaWX7KK69od4sRBbNFIVBDy64xCzAjStcTRgfWwYRY3FbIr2EtUIHIM58WX+WC2T7qHifck9mJYxHbKqqv7uJGRsS+proWundqdEQWvNpC5chZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpNd/Ja2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48ABC4AF63;
	Tue,  7 May 2024 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715107480;
	bh=E9XMpXDc4GOLixsNa+tnFmNYImN3ywdXtqA8m4WFyPw=;
	h=From:Date:Subject:To:Cc:From;
	b=MpNd/Ja2Vh2gjAHIPag6uTHw64TRJyQonnhrzPu5n5tSQjDrrWbOiI5bN0azYmhSW
	 sKQrP+rmYF3tjbwC6rUIQGwEla3h7yzNk8oMMgDA0gyugo5gHY1NyypBZmuJLl086B
	 qIHVAaFwwWbhTGiVCUOj1Hk/nUQFR/7hpGuGkFJdaPjUd36m3VWZlFG9B30qsfnrs1
	 Om/n29YfBxfdiLN2LDlVLWdPzEJOzOiluGEeiWbNhCDuL2KkCYlDtS+Ug8YFLeI/HH
	 XevNrTboghPqmWMikEFzLTegknE3kIu5EupZDipffwUrLdly+BUH0P6d9d+szc6P17
	 pjl+tpR4PGFvA==
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34db9a38755so3245600f8f.1;
        Tue, 07 May 2024 11:44:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdGcvVs9vFS3uQzyJSvOuAaSkoxtSTWuA47D81248OCnRBfcHfY9F44CZQbHhgmKHn8nj3qAoX8QQcK/7WEj1pkhGx0kq7OiqVNviXgedp+m9qebLZTo2r17bq3rCHfrUQF6ar/jA30g==
X-Gm-Message-State: AOJu0YxqPOfsxFdrYWc4pyY0AuMs7vkVQB678h5VnZLDyIrT6jNCsc9L
	V2RGGcPYLNBovTK2jnxY9yESZavMpADfRsifoO6/kDduSoBHhaFIqsReNKXjYSQ5Y4sIFClY6+7
	JI1CaZL0NFThI/dGgACPsLFQs33E=
X-Google-Smtp-Source: AGHT+IGHhSVsi6e3fyUfKOWCT5TUwxTG1IqviacHiKVUDhQeNmsktRO8HZtHvMkPNpakpL2fH5o5lva4DU45TSZnZEg=
X-Received: by 2002:a5d:5288:0:b0:34d:a159:48e6 with SMTP id
 ffacd0b85a97d-34fc9893babmr655329f8f.0.1715107479251; Tue, 07 May 2024
 11:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 7 May 2024 11:44:26 -0700
X-Gmail-Original-Message-ID: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
Message-ID: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
Subject: kdevops BoF at LSFMM
To: lsf-pc@lists.linux-foundation.org
Cc: kdevops@lists.linux.dev, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear LPC session leads,

We'd like to gather together and talk about current ongoing
developments / changes on kdevops at LSFMM. Those interested in
automation on complex workflows with kdevops are also welcomed. This
is best addressed informally, but since I see an open slot for at
10:30am for Tuesday, figured I'd check to see if we can snatch it.
BoFs for filesystems are scheduled towards the end of the conference
on Wednesday it seems, so ideally this would just take place then, but
the last BoF for XFS at Linux Plumbers took... 4 hours, and if such
filesystem BoFs take place I suspect each FS developer would also want
to attend their own respective FS BoF... so perhaps best we get a
kdevops BoF out of the way before the respective filesystem BoFs.

Agenda items?

Guestfs migration progress - have we killed vagrant?
Automation on testing filesystem baselines
xarray / maple tree testing and userspace testing
OpenTofu
kdevops-results-archive split

Any others?

 Luis

