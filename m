Return-Path: <linux-fsdevel+bounces-42213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D71A3EEAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 09:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84BC177FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D6200118;
	Fri, 21 Feb 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsXElGg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1C1FECA2;
	Fri, 21 Feb 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126502; cv=none; b=V10+qVHIUoVbU71WTmMbrI01KTzjzLLfuvOrd7Vo6RXVGdWWB2DiylrH5gvD0ssakmZuyXYgb6ig/7pqavmVJvkDWFUyBdOju4xhGLAiZxen6l2KNmg+XZRgHZOwEZsq3T4PF9hmJsZRdSuOj2qcB5U8750u2AqstzrVEAq4N94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126502; c=relaxed/simple;
	bh=hKnxM0AKR3xnLXrfZbnmPh1C5w3ki4i6kKcv5M82wmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFb2NpnbFnwr+lW6nc2TveD7OJcQidwiB/FaBTslvQStxnPqHzJAgBgFBzYJ8W9aRHj0Hz5zzpHmoLE0Erse2SUuUrbfwli3mrDvAPg1KFEdL3YHWvYEsX4U0jQeTDTSxyjpitEuFlpT+X5OwIB/+ROmgkcUhoJ0m98h4BJHYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsXElGg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F2C4CED6;
	Fri, 21 Feb 2025 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740126502;
	bh=hKnxM0AKR3xnLXrfZbnmPh1C5w3ki4i6kKcv5M82wmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsXElGg/FsSESnmP96QYbS5nUblwp2JcWjys3HU7tY55ZcCddPWKMpnr905J8CBIf
	 1kkQ4kEoR1sS2Br3rTnvZLTxPDCMfZlKtOFa0fT4j+W+peF+51meE6r3Fzlz8oG8ex
	 imda7z6HxZcyUOQF/ZDUIpKFu37vh+H7zmhOOWQfGgl8g9Xh7+qO2iruALJDoxKfo0
	 wyYNhHJtRcGAOMAEtr5PMwppwZ1P6a0Eod9Kcw0FLkeOaa9QYOE6i/j3/6e85tfsyO
	 khX+7TxokjJU6rsp0PxmzLr+tsgaqMV0+gHds0fl/qSs9H2I7xZn+PVUjwzZ7bol3h
	 7tfG8W374PYxQ==
Date: Fri, 21 Feb 2025 09:28:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: kees@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: fix spelling/grammar errors in
 sysctl/sysctl.sh
Message-ID: <6ovppd7jvzh4qscyvr5xq4qah22b336j6fvbfaymenthzubo2v@zckqqh74pkwy>
References: <20250128103853.7806-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128103853.7806-1-chandrapratap3519@gmail.com>

On Tue, Jan 28, 2025 at 04:06:55PM +0530, Chandra Pratap wrote:
> Fix the grammatical/spelling errors in sysctl/sysctl.sh.
> This fixes all errors pointed out by codespell in the file.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 84472b436c07..f6e129a82ffd 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -21,7 +21,7 @@ TEST_FILE=$(mktemp)
>  # ENABLED: 1 if enabled, 0 otherwise
>  # TARGET: test target file required on the test_sysctl module
>  # SKIP_NO_TARGET: 1 skip if TARGET not there
> -#                 0 run eventhough TARGET not there
> +#                 0 run even though TARGET not there
>  #
>  # Once these are enabled please leave them as-is. Write your own test,
>  # we have tons of space.
> @@ -764,7 +764,7 @@ sysctl_test_0007()
>  	fi
>  
>  	if [ ! -f /proc/cmdline ]; then
> -		echo -e "SKIPPING\nThere is no /proc/cmdline to check for paramter"
> +		echo -e "SKIPPING\nThere is no /proc/cmdline to check for parameter"
>  		return $ksft_skip
>  	fi
>  
> @@ -898,7 +898,7 @@ usage()
>  	echo Example uses:
>  	echo
>  	echo "$TEST_NAME.sh            -- executes all tests"
> -	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
> +	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recommended"
>  	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
>  	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
>  	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
> -- 
> 2.48.0-rc1
> 

Applied it to sysctl-next

Thx

-- 

Joel Granados

