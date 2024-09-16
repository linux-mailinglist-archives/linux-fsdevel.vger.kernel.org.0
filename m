Return-Path: <linux-fsdevel+bounces-29508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA897A3C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7981B29DCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160015C14D;
	Mon, 16 Sep 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="HzdSuzs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D3158874;
	Mon, 16 Sep 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495499; cv=none; b=WOtwXr8tQDkWUFWLgw8DVfpj25sXejpt4WxeyTN4qOUV13CYsR8vJZL9vsZMLO1VSWYOforElNE5aDVJ3AWHqvSsyIXcOBoV8q86AQ0iEaadlZnluKnLpJIu+I1ZQwp4zlPOJDatx1FFGwamg62aBs0argchvcCq1Rkag+El+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495499; c=relaxed/simple;
	bh=2wN8ENtgPuAfZDZPIeEuwNkB6shyLq9MuWWn57uDVsQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYT7lO+xBqX5Zycj7ctLzSISCfdcH5UQUAWLTcDNXB3ZJaIqYlZezU6oLLd9Gfgwt4uigGXJ16K0qJV4rHKOoQBdwW0Hj0t0Qe0YXDTSKZLGAbZUlmxNdr74i2B6d6EdcMEaKHqCC0LCddDBLquaoQjOEr5Ypc3EY8/ju2LVvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=HzdSuzs+; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BA5E697AF;
	Mon, 16 Sep 2024 10:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495497;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=aWZWw4Ic6FJjibHaMmYz5SGWuWp1jS+MbeK/LtZV7N8=;
	b=HzdSuzs+hpn4+o3r1RIX0dcuMo64KGLmgRzK8OuULU0ijgzmuGcAXt5ttoqqAXO2YT9KmF
	OYpPQ343jM16OUFCSRmdCv8gJsCM4rqjIzn8qz0kfcvmdhs4Xs8iopmiVG1XiDmpJsKCAy
	fYv2rFIhRxI5EwO9xjZcJLGCVR5VSJzh6wG8p+ure7pdLVz8h80oQdF6uN9YPK7mHurTWp
	5beBORpQUWJi1OxA1Sk4U7q1kIb+o58GHV6wKf/+9ow98NlXdv5U0mbZaV53jRLUIGtal+
	7D1FnxUXznqhIzwK4peziz+W3sA5hoCRb27d3jLVvNXNrDnvo/Wa7rHzDbAOCw==
Date: Mon, 16 Sep 2024 22:04:51 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 00/24] erofs: introduce Rust implementation
Message-ID: <iy7twdqdmlxtkh5qfwwqqj2zqgn54q7ovlgoqjhvvyfom6gvej@jt33zq6h7ryy>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 16, 2024 at 09:55:17PM GMT, Yiyang Wu via Linux-erofs wrote:
> Greetings,
> 
> So here is a patchset to add Rust skeleton codes to the current EROFS
> implementation. The implementation is deeply inspired by the current C 
> implementation, and it's based on a generic erofs_sys crate[1] written
> by me. The purpose is to potentially replace some of C codes to make
> to make full use of Rust's safety features and better
> optimization guarantees.

Utterly sorry for my mistake.

I forgot CC the LKML when copying the mailing list
so i interrupt the patch sending.

Just delete the first one and use the second patchset,
and it should be OK.

Best Regards
Yiyang Wu,

