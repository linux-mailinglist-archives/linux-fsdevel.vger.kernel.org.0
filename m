Return-Path: <linux-fsdevel+bounces-42090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC44A3C5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0711888778
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DE2144CF;
	Wed, 19 Feb 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVJIOehH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BB214230;
	Wed, 19 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985188; cv=none; b=Cl6IOLUew90ZxEKudCiv9tahpJtqrBZJPTwDE5/LmCAKVe5ADBWrp+7D0EoKWc9SmFp7iDJB4r4v5F/P6QC0o5fePX0pxVOJHTDeTDbKw3gftHVuUv0Yz6cPyXeWWTz9F0ErhuQIn5ds5A3+LvI/QLhhqt7uLHvrTm5F8TkRJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985188; c=relaxed/simple;
	bh=L/QYV+Qom79g9HuHBK43mFl7f5J5yQqARQ5i2sJ4WKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD0hkMfPTiVJ3bO/PjvxTBL8icNPTyl1u5tfFC/knx03MIX26wPXL1gj5j63d01XeEMgFTud+O9n7JANsfJQX4rozX16tABVjg/mMzrdIgeOmiRktUo1+b4zde1NKWVC0zG8mKwXntwcZJZREHTND8iamVdCQfUrrQSEM0drtlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVJIOehH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093CC4CED1;
	Wed, 19 Feb 2025 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985187;
	bh=L/QYV+Qom79g9HuHBK43mFl7f5J5yQqARQ5i2sJ4WKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVJIOehHSqr8PKdEefVAoXdXxWoapJRSOxmVK3UoxthHWmfMSOMEMGCr7xaDzEF6o
	 Is5xIokYrUnXoeRayJe7O2SZ42wr51wSr6SxMOhXttVT0KxLJuIohuHF6dlwMMx5Qj
	 xCQdOVVGTq5rWzu0QYppjX1UM3PJxjjetCo6ozhsNGHe1QPbLp23NFx+9HCRMdTJH5
	 eWYIa9cAcoSxHY1nmbzrXdGRgvTwDZhD5EMXwqlXf2jIZrko1nqOY9ZH0RdrHOSPnS
	 eeFOFR2Ycd6Rz+cyS0qSWyak0G9/68xiw1Em0Fd7tWDFbbUnNjJ7gCq4PEZ+zOEOPQ
	 y6DiYo85VJqFg==
Date: Wed, 19 Feb 2025 09:13:04 -0800
From: Kees Cook <kees@kernel.org>
To: Sumya Hoque <sumyahoque2012@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests:sysctl:Fix minor grammers in sysctl test
Message-ID: <202502190912.CA03B56796@keescook>
References: <20250219030451.39782-1-sumyahoque2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219030451.39782-1-sumyahoque2012@gmail.com>

On Wed, Feb 19, 2025 at 03:04:51AM +0000, Sumya Hoque wrote:
> Hello everyone,
> Some minor grammer issues that I have fixed:
> 1. echo "If an error every occurs -->  echo "If an error occurs, every execution
> 2. Example uses --> Example Usage 
> 
> Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 84472b436c07..a4d76147ed8a 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -891,11 +891,11 @@ usage()
>  	echo "    -l      List all test ID list"
>  	echo " -h|--help  Help"
>  	echo
> -	echo "If an error every occurs execution will immediately terminate."
> +	echo "If an error occurs, every execution will immediately terminate."

I think the typo here is just "every" -> "ever"

>  	echo "If you are adding a new test try using -w <test-ID> first to"
>  	echo "make sure the test passes a series of tests."
>  	echo
> -	echo Example uses:
> +	echo Example usage:
>  	echo
>  	echo "$TEST_NAME.sh            -- executes all tests"
>  	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
> -- 
> 2.34.1
> 

-- 
Kees Cook

