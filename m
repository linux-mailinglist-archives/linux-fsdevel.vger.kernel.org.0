Return-Path: <linux-fsdevel+bounces-22041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D01369116F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872681F22CDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024021509BC;
	Thu, 20 Jun 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="dRy3d1Xo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC943ABC;
	Thu, 20 Jun 2024 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926930; cv=none; b=ntXGK1RzjEQSfckpj+j5qUFfdaKIQD0Ug8JYZfiSvqhHxmSXVUXjVXv/49saBxNG8TyIBAuZhCzB9BI3HyfyQp89ZqfE8bHrwq/NcAEwHPl1VYhLmt7CoEAVtjmZTGzyRozjWftXRgVDbqYKn1L/B2nswBtWeQ6mPjnY6rr9DEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926930; c=relaxed/simple;
	bh=ZUy9KkXRtxbe3yLApS1C4yViX20c0hmWF1eeEmohgAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fv3FfCAXhFzhn1xsbwa+AdKMeY7ErokJiXW4qWG9idEi3qzNYOYM7zYNZ5YDIUr5Epk+2fxrQKnlOpMoX+2+3z7QynZ6Q4HDUHZRWCBbGN3w4eIFl9OqZeU7udn0QSl0j9Fk7gPUB3ikqQ8LFtt8aSl5//bBOOQpNZpbLPL2rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=dRy3d1Xo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EA4AC0002;
	Thu, 20 Jun 2024 23:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1718926919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqyvJ/RXIDEJ6K5Q9ZLLPg4KNgiAv+nZHrmU+1Tftb0=;
	b=dRy3d1XoSgAirW+QpGaX2TNhVencRtlnrIXx9Xf35BbaDkKTW4IQyDB0iewlvhjLdAlXb7
	ghff9GPto4i60+8ixXPrfuUv3CyicNfzGXD8XUPSOxwlzYBRl8cJtsg7NKFXu3gw7wUTvm
	MSPH0q5ELASiyAarb6iK1THAc3B7yUoxABNQ1C/me9guRNGgpLIHjUJ/xDq95keW9WkZFx
	XuexQhIE1ZDZHQRK4qK9QSVJuF4FmJgNcG3SVEZAweNHA9gWYkrYdIRSb786OdBS+v8m5o
	8LBVhAWAwNrL7SUAha5Qfl3s637zGLy7zFA3JGAQ96xQlSp9z71k/ounmr6zVg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
  <linux-fsdevel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] unicode: add MODULE_DESCRIPTION() macros
In-Reply-To: <87y17vng34.fsf@mailhost.krisman.be> (Gabriel Krisman Bertazi's
	message of "Mon, 27 May 2024 16:40:47 -0400")
References: <20240524-md-unicode-v1-1-e2727ce8574d@quicinc.com>
	<87y17vng34.fsf@mailhost.krisman.be>
Date: Thu, 20 Jun 2024 19:41:50 -0400
Message-ID: <87v823npvl.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be


> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> Currently 'make W=1' reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
>>
>> Add a MODULE_DESCRIPTION() to utf8-selftest.c and utf8data.c_shipped,
>> and update mkutf8data.c to add a MODULE_DESCRIPTION() to any future
>> generated utf8data file.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Note that I verified that REGENERATE_UTF8DATA creates a file with
>> the correct MODULE_DESCRIPTION(), but that file has significantly
>> different contents than utf8data.c_shipped using the current:
>> https://www.unicode.org/Public/UNIDATA/UCD.zip
>
> Thanks for reporting this.  I'll investigate and definitely regenerate
> the file.

Now that I investigated it, I realized there is perhaps a
misunderstanding and not an issue. I just tried regenerating utf8data.c
and the file is byte-per-byte equal utf8data_shipped.c, so all is
good.

Considering the link you posted, I suspect you used the latest
unicode version and not version 12.1, which we support.  So there is no
surprise the files won't match.

> The patch is good, I'll apply it to the unicode code tree
> following the fix to the above issue.

Applied!

ty,

-- 
Gabriel Krisman Bertazi

