Return-Path: <linux-fsdevel+bounces-49116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D14AB8379
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5BF7AA7B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98D28CF43;
	Thu, 15 May 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/ATPH7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD718DB37;
	Thu, 15 May 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303338; cv=none; b=Qe+fSOHiFq7krlNwR7zhGT9I7Whgorp2rZ/fuuc26DmI22RtjQg8au7Pok9kR4QmjRj0k0BItqTR88z5+xTMiyZpjCkGhZ+M13+7qWkMoikwxlJadJF73gtVfon74xEICfB5Kn05PZeisstDb1TbvDr9sTcZZZ7fTkZJZ5VundA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303338; c=relaxed/simple;
	bh=VAwkJz+vo/HqYAzE0MQzT88tHyPxa/O6ci1Z/aG2ZBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDPp+TMexzOQcZhDjif8LbI5GmtEFijlzAE3dWHluvkbYGTEli19NNaH1T4xs4yuqSJV6nKfMyQZXwdwcYNRp30hNc6I3hCqOTxD8y0AQ5PgxCvIVkQz3Fsv0dlRsFUmmBCD1Fhsd96s2BhYgIBjTZ23NtiZmm8PCxXnQklyQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/ATPH7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2936FC4CEE9;
	Thu, 15 May 2025 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747303338;
	bh=VAwkJz+vo/HqYAzE0MQzT88tHyPxa/O6ci1Z/aG2ZBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/ATPH7TZiZirh+2hn9+2i8rEUzBKn+Uz0rtRJpU+5JE6B6RXL8aBF1oYp4cp5GWB
	 n9rW/wNeMXGdPV/3fAvPWoZIlGc0/C1lhUYK7Tw00Wevzfl9BqxUFQZfl1ybXpYEFZ
	 nXNTCeBQczHjzlKeVsK6BEYNQSvxO7djmbvlJByyeQH4XNxaAFDjlCX8iKBDFCyI60
	 ilhMcXxnYxi6PKM7n7svciCHYTGrFKeYBoicUsgRPhsbxd/Q5u9HIHuY8E1pR0qr9e
	 mvE6JdSMNS1xVRsY9Yg813COOYXXZSP1NRYKL/YJqf8/AoIVHS3H4/hDe2s3lruoAt
	 QZ2vjXHCkK6gQ==
Date: Thu, 15 May 2025 12:02:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Seth Forshee <sforshee@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: remove duplicated function definition
Message-ID: <20250515-antlitz-unheil-2ea64f1e76be@brauner>
References: <20250514020203.198681-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514020203.198681-1-chenlinxuan@uniontech.com>

On Wed, May 14, 2025 at 10:02:02AM +0800, Chen Linxuan wrote:
> I failed to build this test on Ubuntu 24.04. Compiler complains that
> function sys_open_tree has already been defined in
> "../filesystems/overlayfs/wrappers.h".
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---

This is already fixed in the next vfs tree. Thanks though!

