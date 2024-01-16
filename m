Return-Path: <linux-fsdevel+bounces-8051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA7582ED5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEA7B22FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46681A5B9;
	Tue, 16 Jan 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmqgMWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9361A5A7;
	Tue, 16 Jan 2024 11:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D95C433F1;
	Tue, 16 Jan 2024 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403180;
	bh=uUMkNzEGzC01p9em3PYSihIKIEGIjdqiW4cv0+lcKdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTmqgMWseGzuSl0x3yhZmdg+gDQYoPqmcrVI+df4VL7ogMAlu0ohWdNhkhPxlmsjE
	 zNIXWjhVgYLBpsrm1qA6x7eZz7l6wnck2cbyVPTNnfYpznL+j2IpJbeRhep34oSemX
	 y2zk7+yxwTgy1h+saMuu8tnIrJ48cn1Ji/POtfvJAgCFLYGlX5Cmw7yZPZZrMUAgL+
	 BHy09rIh6rYNWSCPqwfiHEXoEH9aogowPLnKbSi/5v3x6LHoKFCzw2Kp239d/ohIAq
	 KbIGiyfJBC8oBYKzpgORhbCpLOxKvOf9e4V1xyaz8FgTP9ohgpM+jOk8Bdptcrh4ev
	 6ANFlrmIvZvXQ==
Date: Tue, 16 Jan 2024 12:06:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] Remove NTFS classic
Message-ID: <20240116-gutgesinnt-autodidaktisch-d1ac1d2f8253@brauner>
References: <20240115072025.2071931-1-willy@infradead.org>
 <20240116-fernbedienung-vorwort-a21384fd7962@brauner>
 <1B634C72-9768-43E9-93B6-3396CBAA958E@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1B634C72-9768-43E9-93B6-3396CBAA958E@tuxera.com>

On Tue, Jan 16, 2024 at 09:51:47AM +0000, Anton Altaparmakov wrote:
> Hi, 
> 
> It seems there is consensus to remove it so please add: 

Well, we'll try. This is one of those cases where we might end up not
being able to do it. But imho this is a case where there's sufficient
reason to at least try and remove this code precisely because we have an
alternative implementation that's been around for a while.

IOW, this isn't like reiserfs where we're actually getting rid of a
filesystem completely.

