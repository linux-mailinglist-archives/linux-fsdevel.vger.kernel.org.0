Return-Path: <linux-fsdevel+bounces-20278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA908D0EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A480D28306E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF516132E;
	Mon, 27 May 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="SQy5Nhjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D68161306;
	Mon, 27 May 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842467; cv=none; b=CaoNmuA3Qkj0BXtc+lNbi59dAB8/KaQ8SU49aD6umpNQ3Ff9Z0LRnNIahd8/gGSJkwYv3gJPm8JVcNFAAZYGxsAYfBH0bbBBZrbEgHcYiptJPhNngW2CuGzbQ3UOtn+wfcJ4CKcXVw+Kv+MO3LdmcKLstQJKQYDyuWN69o5dlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842467; c=relaxed/simple;
	bh=NbXY2Kk4FGwSPszns2tNOssIhDlhmg+90rK9jIm+aWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2E8Z5lLGjGRnfP9oTqF4+gdCjriWvSTZx8XBKQlmBKEQItS9sHJ7x0dlubnuW+2XBadjsRDsuVT/2KLl/M1xjQmRtD8RsTb4l/7BiALMnAe3jC+gG4a9vtrnKYG7OfgJHQ3OTJmDigwKaXHoY/sCPwaqa5OwofqMt+zwkNV7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=SQy5Nhjr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58AB11C0002;
	Mon, 27 May 2024 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1716842460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfH6b5pwYJEOTT3sLSjSrRNYvJ7fdHrC/cOseFcXPFE=;
	b=SQy5NhjrknphnSRui48ouVOppbA5yPQyJceM4GNRtWRx8km0pI4ni/fN8rt7xB+jSThrGd
	VsB42Z4aZU5hlx4SN5aCESYYaIrnGobEq6fWLhOTACQQHKzcAZUMQ15MaaqjpqSQhtmYa+
	fDfJpdZGgQrM9SJCvif4Hf6+7qKADy7Oc1wvkqnlS4psCsVn/Xc/LmrHirx2R5xpJqlLyj
	4ThlDYLuzkaOg7Al0UTJRuHFRXlqw6lUt699TnIcwudJo8uIAkQ7WGGGzI0J3hK+g5XkFL
	CAHWnlLn0qPJTX7sT+fsEuLlbjbkgaaoXCNSGyQyR3SW4Mk0Tw0Gb1poA3vnsw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] unicode: add MODULE_DESCRIPTION() macros
In-Reply-To: <20240524-md-unicode-v1-1-e2727ce8574d@quicinc.com> (Jeff
	Johnson's message of "Fri, 24 May 2024 11:48:09 -0700")
References: <20240524-md-unicode-v1-1-e2727ce8574d@quicinc.com>
Date: Mon, 27 May 2024 16:40:47 -0400
Message-ID: <87y17vng34.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> Currently 'make W=1' reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
>
> Add a MODULE_DESCRIPTION() to utf8-selftest.c and utf8data.c_shipped,
> and update mkutf8data.c to add a MODULE_DESCRIPTION() to any future
> generated utf8data file.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Note that I verified that REGENERATE_UTF8DATA creates a file with
> the correct MODULE_DESCRIPTION(), but that file has significantly
> different contents than utf8data.c_shipped using the current:
> https://www.unicode.org/Public/UNIDATA/UCD.zip

Thanks for reporting this.  I'll investigate and definitely regenerate
the file.

The patch is good, I'll apply it to the unicode code tree
following the fix to the above issue.

> ---
>  fs/unicode/mkutf8data.c       | 1 +
>  fs/unicode/utf8-selftest.c    | 1 +
>  fs/unicode/utf8data.c_shipped | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
> index bc1a7c8b5c8d..77b685db8275 100644
> --- a/fs/unicode/mkutf8data.c
> +++ b/fs/unicode/mkutf8data.c
> @@ -3352,6 +3352,7 @@ static void write_file(void)
>  	fprintf(file, "};\n");
>  	fprintf(file, "EXPORT_SYMBOL_GPL(utf8_data_table);");
>  	fprintf(file, "\n");
> +	fprintf(file, "MODULE_DESCRIPTION(\"UTF8 data table\");\n");
>  	fprintf(file, "MODULE_LICENSE(\"GPL v2\");\n");
>  	fclose(file);
>  }
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
> index eb2bbdd688d7..f955dfcaba8c 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-selftest.c
> @@ -307,4 +307,5 @@ module_init(init_test_ucd);
>  module_exit(exit_test_ucd);
>  
>  MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
> +MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
>  MODULE_LICENSE("GPL");
> diff --git a/fs/unicode/utf8data.c_shipped b/fs/unicode/utf8data.c_shipped
> index d9b62901aa96..dafa5fed761d 100644
> --- a/fs/unicode/utf8data.c_shipped
> +++ b/fs/unicode/utf8data.c_shipped
> @@ -4120,4 +4120,5 @@ struct utf8data_table utf8_data_table = {
>  	.utf8data = utf8data,
>  };
>  EXPORT_SYMBOL_GPL(utf8_data_table);
> +MODULE_DESCRIPTION("UTF8 data table");
>  MODULE_LICENSE("GPL v2");
>
> ---
> base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
> change-id: 20240524-md-unicode-48357fb5cd99
>

-- 
Gabriel Krisman Bertazi

