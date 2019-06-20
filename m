Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3A4C64B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 06:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfFTEkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 00:40:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54593 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfFTEkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:40:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B8CFF21C46;
        Thu, 20 Jun 2019 00:40:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Jun 2019 00:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        bO10TrMSXc4cbtBZ1aAhOLsOyVdLkD26hY7cPj0wvnE=; b=Nx/xu37GMJogDhyr
        wSOnM+xusi5GPCusW0P1Pz5jFe+2V5NuAmqTkNPTQHcU+usEKfo2X/phETiLmPfm
        tZtt19ity+lbdyqBUvnle32A4v21mNwUEADW7CQHY755hNETux9CUviyXbolLFll
        iLkwpHWTgP7cOz9s+mb3sXl+B6PfUAhEXsRvK5EoKmZcxLjmUyE0Hj3S4jiusZx9
        SwzogYBeuUlxa1dDw4uUWTR8uppM/GuPFbD87aBJCPShqJs5cVtXZqxkU7Z8R42J
        Y+fSJccm/wrj/UvQl1GC/CGPnRmuROLpjSIkWuXydu/SP7QYfio0oWxzmXsS7bHS
        L11wuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=bO10TrMSXc4cbtBZ1aAhOLsOyVdLkD26hY7cPj0wv
        nE=; b=vlWmNlaG3ecVfiAoyzfKSQOfD51jf7K3puGsMZAeuYKwng3bIBW0S2MvO
        Iv73UNlQs+Ej2RWc3f+Q/IZaq6UQg6vvJS5ZwZX51Y4SGHrkpnRTSV0stYeBV0hP
        VaKCc+EfK9CdjYMxKn2Ra0Ww5qiW1T8bAZadhnYoHkPVm3j+cjD3272vU0W5faTi
        w8299pFh7K7mrJ2P/w5u1nLFQGROmtu++8cWRl7PEDoC06PYQHV6rPCHMlta6nhj
        7NogVMfwP0pMev0Uh6Or9PrXZzYVPEBUV8FAYtEMIfmRDvrTB+x8E37JPvulM75Q
        098GJfuCXiH0NYkVfZxjUlGDh5R6Q==
X-ME-Sender: <xms:Pw4LXSM169v8bVLKq7WbMyXhs8CvOZxjARXRfpRUUmBKGqTpZuFcMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dujeefrdefgeenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Pw4LXSRrb-fX_TE7HXFI95QtvWgAtWNiCy-7bGGmAahgR4ABdklPwQ>
    <xmx:Pw4LXbs9DXASFjh8jQZ-B1gxDl1FdIpe49UnGLJXVLt0mt2gdae3ww>
    <xmx:Pw4LXYWKOvaIt1xou2CWzrFv870ti-5T7mN2dTFLVTYKZIbfYZyYKw>
    <xmx:Pw4LXWqqZUuMrhD2uSGmH9Ou9ISH0VrokJ10V_o2fNTI-w70nuBivg>
Received: from pluto.themaw.net (unknown [118.209.173.34])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4188380079;
        Thu, 20 Jun 2019 00:40:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 09B2A1C00FC;
        Thu, 20 Jun 2019 12:40:27 +0800 (AWST)
Message-ID: <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jun 2019 12:40:26 +0800
In-Reply-To: <20190619123019.30032-5-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
         <20190619123019.30032-5-mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-06-19 at 14:30 +0200, Miklos Szeredi wrote:
> While this is a standard option as documented in mount(8), it is ignored by
> most filesystems.  So reject, unless filesystem explicitly wants to handle
> it.
> 
> The exception is unconverted filesystems, where it is unknown if the
> filesystem handles this or not.
> 
> Any implementation, such as mount(8) that needs to parse this option
> without failing should simply ignore the return value from fsconfig().

In theory this is fine but every time someone has attempted
to change the handling of this in the past autofs has had
problems so I'm a bit wary of the change.

It was originally meant to tell the file system to ignore
invalid options such as could be found in automount maps that
are used with multiple OS implementations that have differences
in their options.

That was, IIRC, primarily NFS although NFS should handle most
(if not all of those) cases these days.

Nevertheless I'm a bit nervous about it, ;)

> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fs_context.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 49636e541293..c26b353aa858 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] =
> {
>  	{ "nolazytime",	SB_LAZYTIME },
>  	{ "nomand",	SB_MANDLOCK },
>  	{ "rw",		SB_RDONLY },
> -	{ "silent",	SB_SILENT },
>  };
>  
>  /*
> @@ -535,6 +534,9 @@ static int legacy_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  	if (ret != -ENOPARAM)
>  		return ret;
>  
> +	if (strcmp(param->key, "silent") == 0)
> +		fc->sb_flags |= SB_SILENT;
> +
>  	if (strcmp(param->key, "source") == 0) {
>  		if (param->type != fs_value_is_string)
>  			return invalf(fc, "VFS: Legacy: Non-string source");

