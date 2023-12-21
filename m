Return-Path: <linux-fsdevel+bounces-6612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122F81AC07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 02:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CA4B2471C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881023D9F;
	Thu, 21 Dec 2023 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="saPof4eA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DE3C0A;
	Thu, 21 Dec 2023 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=pEPpD4dmfElTiGXw6Zj243xnyc4gVN73hFCiMm9Smlk=; b=saPof4eAgLmRVvEW4hZhfaHulr
	og+SlewR5XGO7oTiUdlLunfYbfgiQNeJUsSJJduniQvJnqOMcV+0r3CNwbPbCWimCnAupyIvdZGQT
	5wBKs85ZuKnFBV1XlxAS8Ifn4xYCPrQ8QASoH719SQILUkfDKxWzKqFq94s++rv5PBdnTVmZB0veb
	4DntG3vzX7A053B+6thoiZC7MqHPCed4bRSc+WrQcS80hu9CnpGXzalwg20WCzlIByMvB6LlFpydU
	laNEf/PzCE1DP8bYY8X90cWb6gSzFzMHUJqMe2AgcIWIua15L3S++k9xDhoRJIV3/Lr4M5B778lq4
	tHGNi6vA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rG7bW-000xuD-02;
	Thu, 21 Dec 2023 01:12:02 +0000
Date: Thu, 21 Dec 2023 01:12:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xiubo Li <xiubli@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 17/22] get rid of passing callbacks to ceph
 __dentry_leases_walk()
Message-ID: <20231221011201.GY1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
 <20231220052925.GP1674809@ZenIV>
 <446cf570-4d3d-4bdb-978c-a61d801a8c32@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446cf570-4d3d-4bdb-978c-a61d801a8c32@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 21, 2023 at 08:45:18AM +0800, Xiubo Li wrote:
> Al,
> 
> I think these two ceph patches won't be dependent by your following
> patches,  right ?
> 
> If so we can apply them to ceph-client tree and run more tests.

All of them are mutually independent, and if you are willing to take
them through your tree - all the better.

