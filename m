Return-Path: <linux-fsdevel+bounces-22423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C131F916FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE7D283B05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACA178383;
	Tue, 25 Jun 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hiKvAdUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B331459E2;
	Tue, 25 Jun 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338727; cv=none; b=cZXaztWsa3bCNIw0enBbU0A/Xz3b099HG0ckzRWpCUQYKfw1LcZP5QRXgub9RgkNuS6DHd9jsHxawtLfKsf2cciah/GbCQb6rgLlFlW6ZStJIiPd3Jq0FDo/fa1C3EBotxx4AYVLqI/YifvTTGb31e0uEfIRbXl3hIXFeSZuwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338727; c=relaxed/simple;
	bh=XWejeP0g26MRxIPPmiczn1wiUB1URTTUGAZgbY/CHME=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mblHobBwjM5lb6Nhv3Jv2eyGpse0nNMqEgywWrhQI3NdYJlmqwTSug3w6J5oXsGZhzd3/+gy0GDwBzOt96Gzr+X6Bay05y55o0ZnmJ2XYP+S9IcvANZ0Hn6GNQyC5r+ci70aoiygxVwfOxqWD9gdTIyEfU9Wyf23MW1bwdQe7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hiKvAdUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E434BC32781;
	Tue, 25 Jun 2024 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719338727;
	bh=XWejeP0g26MRxIPPmiczn1wiUB1URTTUGAZgbY/CHME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiKvAdUz44Kll7SLtJmVxc/1cAEP2J+v39M9CdyLRPmqO1AcgeVxf9Vq7tuWo/xQQ
	 RqdxWbGeZGNbj0mMb4grr+e1GaL9MESSwXwZ7y44Hp0ReQm2hwcSPFAP4xCytljIWi
	 +PCS8FDw1fCRPkJgXMj+D+eYtckvA+WISDBHSxFg=
Date: Tue, 25 Jun 2024 11:05:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] selftests/proc: fix unused result warning during test
 compilation
Message-Id: <20240625110526.d443fe6d3feb51a50aebf849@linux-foundation.org>
In-Reply-To: <20240625152139.16412-1-jain.abhinav177@gmail.com>
References: <20240625152139.16412-1-jain.abhinav177@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 15:21:39 +0000 Abhinav Jain <jain.abhinav177@gmail.com> wrote:

> Check the return value from write function to get rid of the warning
> during test compilation, shared below.
> Tested by compiling after the change, the warning disappears.
> 
> proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   385 |                 write(1, buf, rv);
> 
> ...
>
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -382,7 +382,12 @@ static int test_proc_pid_statm(pid_t pid)
>  	assert(rv >= 0);
>  	assert(rv <= sizeof(buf));
>  	if (0) {
> -		write(1, buf, rv);
> +		ssize_t bytes_written = write(1, buf, rv);
> +
> +		if (bytes_written != rv) {
> +			perror("write");
> +			return EXIT_FAILURE;
> +		}
>  	}

Thanks.  There's a patch queued which simply deletes this code.

https://lkml.kernel.org/r/20240603124220.33778-1-amer.shanawany@gmail.com

