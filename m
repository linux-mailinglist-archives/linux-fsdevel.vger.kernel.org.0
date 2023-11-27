Return-Path: <linux-fsdevel+bounces-3922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B517F9EFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D23B2109D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F01A730;
	Mon, 27 Nov 2023 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhxXVhL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561E1A5B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293D2C433C8;
	Mon, 27 Nov 2023 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701085902;
	bh=yqKoh/FBOGIuWXwBmJjs57/vho6H6ZG3DzozvWP5h9U=;
	h=From:Subject:Date:To:Cc:From;
	b=JhxXVhL/STwEQ4kf2OETTLvPSqeKhD0+Nwlg1AqMl69RfNXUOZfQZGKqGFUjvxAjv
	 SCsCMjiX4orsl0cJq+o+oGezgltfIu6B6zij007gWKmvodjznoog6IJgnPRvXxvZD1
	 MyMrQG31bHHqixbDwc5IJIQJ6fHlYpcJfexOEEW7QRXPszHScmmOtna9KEl00yOBLp
	 HMPb6QeJUG6wIJwIVchy0pX0AApcIdeUrSfTuMwpzKjU5yoYYUd5TlvilTfvIg6WEb
	 o/nrZljI3wyZpaH3WxPSG+vqmEGNfKCYlg62jsONxLPerHbw1pmTq4Ddvdm3gfmpcc
	 K76uXu6Lr1sQA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] super: small tweaks
Date: Mon, 27 Nov 2023 12:51:29 +0100
Message-Id: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGCZGUC/x3MQQ6CQAyF4auQrq2xQyTGqxgXBTrShSNpBU0Id
 6ew/JP3vgVcTMXhXi1gMqvrp0TQqYJu4PIS1D4a0iXVRHTDOTv6NIrhm905Bj/WLzbcU2qYck1
 XiPNokvV/wI9ndMsu2BqXbti5UM6HAuu6AS42RrCEAAAA
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=210; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yqKoh/FBOGIuWXwBmJjs57/vho6H6ZG3DzozvWP5h9U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSmNJ0JlGifl2W8f7rznCN5s0P+a/z/dprpp4nd1LmvP
 K92rbRk7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIvq2MDDOsXz5KUZHefOqe
 n0xarlCLm/+j8zx6XkcfzrKK6Ft+2pnhf9peec6vCYKsH7jDVSdOFND3tLxq1BnVm51Y95n9apg
 YCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Just two minor hopefully uncontroversial simplifications.

Thanks!
Christian


---
base-commit: afde134b5bd02a5c719336ca1d0d3cb7e4def70e
change-id: 20231118-vfs-super-massage-wait-6ad126a1f315


