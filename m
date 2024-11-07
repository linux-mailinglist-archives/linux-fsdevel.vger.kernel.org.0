Return-Path: <linux-fsdevel+bounces-33946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3539C0DFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9604283235
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08721731D;
	Thu,  7 Nov 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wSR1Jxk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5C18F2C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005016; cv=none; b=XD38UnqFL6OWUfbEVZF6qottxXJlDQqOMGyLprgBJAsa06WjipxXuL1bwiOm47YfHQyk2D9t0V8a5MvxwUbnGzOOL5OJsOISdv4DDBKBGTjtR8Pmn1ks6v6ZHYuTktAj8Qdb/Fng6VjDKs2U0N7b+dkqqEI/Pa9OxO/IqrkOxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005016; c=relaxed/simple;
	bh=LnM2i5iHpMyx76qbizXXkeFTp45ZF8No6yJH1OATCfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUuWtQAhep6wWx2g0kXecWE4PRWT7qtWPTDGTROlaVoHycFRJC8PGUR8fuPWnewZUdMDTEBbbab+9XDjxAhWWX4zZQz3srPw1GZsgiKpYQyYDCn6OaJcjTdT8HPVC8bd0mjYE+n8VUYMnCugE2+GZwtwwgnyouA+YCZJf1WHBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wSR1Jxk2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Nov 2024 10:43:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731005012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN7ppjSl5NrWL94TOJ8Rsf6n0UV1JNOurCJmTruhpog=;
	b=wSR1Jxk2M2iDL0nYmozOeTOx5v/p7joRmWS7gYq9Hx28tykH20FigoYnvqcY+wfcEcORs+
	TKynLKVvJAIu0n9fCtB3syEVfucSFPtl881XtfGHWtTL7XWH3cwj1CNB3c28NwLdSsJDX/
	beozCsZpAp2wIwglz7y2RIDd5pf2tPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, dakr@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/firmware/fw_namespace.c: sanity check on
 initialization
Message-ID: <20241107184319.vstzt6z4hhxmhzdv@4VRSMR2-DT.corp.robot.car>
References: <20241105013056.3711427-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105013056.3711427-1-mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 05:30:56PM -0800, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> The fw_namespace.c test runs in a pretty self contained environment.
> It can easily fail with false positive if the DUT does not have the
> /lib/firmware directory created though, and CI tests will use minimal
> guests which may not have the directory created. Although this can
> be fixed by the test runners, it is also easy to just ensure the
> directory is created by the test itself.
> 
> While at it, clarify that the test is expected to run in the same
> namespace as the first process, this will save folks trying to debug
> this test some time in terms of context. The mounted tmpfs later will
> use the same init namespace for some temporary testing for this test.
> 
> Fixes: 901cff7cb9614 ("firmware_loader: load files from the mount namespace of init")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  .../testing/selftests/firmware/fw_namespace.c | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 04757dc7e546..9f4199a54a38 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -112,6 +112,40 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>  	exit(EXIT_SUCCESS);
>  }
>  
> +static void verify_init_ns(void)
> +{
> +    struct stat init_ns, self_ns;
> +
> +    if (stat("/proc/1/ns/mnt", &init_ns) != 0)
> +        die("Failed to stat init mount namespace: %s\n",
> +            strerror(errno));
> +
> +    if (stat("/proc/self/ns/mnt", &self_ns) != 0)
> +        die("Failed to stat self mount namespace: %s\n",
> +            strerror(errno));
> +
> +    if (init_ns.st_ino != self_ns.st_ino)
> +        die("Test must run in init mount namespace\n");
> +}
> +
> +static void ensure_firmware_dir(void)
> +{
> +    struct stat st;
> +
> +    if (stat("/lib/firmware", &st) == 0) {
> +        if (!S_ISDIR(st.st_mode))
> +            die("/lib/firmware exists but is not a directory\n");
> +        return;
> +    }
> +
> +    if (errno != ENOENT)
> +        die("Failed to stat /lib/firmware: %s\n", strerror(errno));
> +
> +    if (mkdir("/lib/firmware", 0755) != 0)
> +        die("Failed to create /lib/firmware directory: %s\n",
> +            strerror(errno));
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	const char *fw_name = "test-firmware.bin";
> @@ -119,6 +153,9 @@ int main(int argc, char **argv)
>  	if (argc != 2)
>  		die("usage: %s sys_path\n", argv[0]);
>  
> +	verify_init_ns();
> +	ensure_firmware_dir();
> +
>  	/* Mount tmpfs to /lib/firmware so we don't have to assume
>  	   that it is writable for us.*/
>  	if (mount("test", "/lib/firmware", "tmpfs", 0, NULL) == -1)
> -- 
> 2.43.0
> 

