Return-Path: <linux-fsdevel+bounces-42141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B530DA3D0D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF335189D98E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6A1E284C;
	Thu, 20 Feb 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcQcFc6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53E524F;
	Thu, 20 Feb 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029722; cv=none; b=MPau/kqzhYjmt2BlpYp1AU3IFbvIXNaEIR59S3e0maUUAAFKYhkullJgzBnhWVbA3tWPUkqeIGDESsoE5gaqC9JBsScHxXVh7rcrxPCuBS7grNROPbHnBVBthsUt2lRNtDSs4kpxSb7gKNnAc/TPzBUcoBAGgvejUGXQPS/6DIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029722; c=relaxed/simple;
	bh=XQ508VSSFA97njrwo7AFNEChjQJ70/G58Y0criKE2Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5t8mwOZNU3PGji8ObUiEFAGCS4iISVlyoWduL7PYqtP9ZGZ9wi845nuY2326WfZOmya3wYhnw4GcwlCgz3vzuNZFtW/z2GyxrxxqUYZyEokPSD9GQz1iECHZsjYm+XR/cvTnYODH7HWMIsYGO+Q90bM4rzVMhYg3i6YDxvLPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcQcFc6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9285C4CED1;
	Thu, 20 Feb 2025 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740029722;
	bh=XQ508VSSFA97njrwo7AFNEChjQJ70/G58Y0criKE2Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcQcFc6k7bwz5ZFusHhNK9TWljz9mmJJqPobwzpDeLGDURG4YxXgfG4ujqmex0bRy
	 WHxrkmAdzen0xyZtgd5ONLjZYq+brEQDsY8ygCZOhcZq1gCtXWVfToaeEHOjHmoFUw
	 uB4W9uU0dXDutW16dAO53aFk5cUuLtkY5S2Os5TI=
Date: Thu, 20 Feb 2025 06:35:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumya Hoque <sumyahoque2012@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests:sysctl:Fix minor typos in sysctl test
Message-ID: <2025022055-cubicle-kebab-b9b6@gregkh>
References: <202502190912.CA03B56796@keescook>
 <20250219193301.46563-1-sumyahoque2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219193301.46563-1-sumyahoque2012@gmail.com>

On Wed, Feb 19, 2025 at 07:33:01PM +0000, Sumya Hoque wrote:
> 
> Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 84472b436c07..323468653327 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -891,11 +891,11 @@ usage()
>  	echo "    -l      List all test ID list"
>  	echo " -h|--help  Help"
>  	echo
> -	echo "If an error every occurs execution will immediately terminate."
> +	echo "If an error ever occurs execution will immediately terminate."
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
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

