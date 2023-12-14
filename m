Return-Path: <linux-fsdevel+bounces-6049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4E812D62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6028297B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389093D3B1;
	Thu, 14 Dec 2023 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjW7wdE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778643C494;
	Thu, 14 Dec 2023 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C00C433C8;
	Thu, 14 Dec 2023 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702551052;
	bh=B3Uzhdrf3xm+8hmipnGveC7xOj8Hsd8r5ig/mSxdums=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjW7wdE0wJKpOB85/uTrRUZDMYAzvL5sJeBifjJFoP9i7NGE5Oi7a+4FO7v2ai+l4
	 nVbRAw9ZKZd5dfjc2HHHRBrOLhKc+W2RUxZ4nkoftoeW/uaTBN4SDGKYEV1zvjHXBL
	 vdM9RbsYQqhNyz+LHodwpS4E7AsD7curbtBCxaF6IrSytdaPiViHD+B+tuyNslANj6
	 TMEXUovKVZxIZF0dnS+NXydDH/xos7XtdhqYb+NOMcJcVui3XOw9SHU7I0wbxG1AQx
	 Nom7GRyNXKt/X6L98kcxe2/PAfWM98PoFAJW4gkP3+9ecSqwycW81aSFJb0dYjmvS5
	 3/1ugywDFRH4Q==
Date: Thu, 14 Dec 2023 11:50:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Lu <tonylu@linux.alibaba.com>,
	Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
 <20231213162854.4acfbd9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213162854.4acfbd9f@kernel.org>

> Let's figure that out before we get another repost.

I'm just waiting for Jens to review it as he had comments on this
before.

