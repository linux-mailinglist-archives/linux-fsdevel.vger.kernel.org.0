Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A544D1DD234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgEUPoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 11:44:30 -0400
Received: from sandeen.net ([63.231.237.45]:51480 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgEUPoa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 11:44:30 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 26B55323C1A;
        Thu, 21 May 2020 10:44:00 -0500 (CDT)
Subject: Re: [PATCH v2] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
To:     Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <20200521140502.2409-1-linkinjeon@kernel.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
Date:   Thu, 21 May 2020 10:44:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521140502.2409-1-linkinjeon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/21/20 9:05 AM, Namjae Jeon wrote:
> As Ubuntu and Fedora release new version used kernel version equal to or
> higher than v5.4, They started to support kernel exfat filesystem.
> 
> Linus Torvalds reported mount error with new version of exfat on Fedora.
> 
> 	exfat: Unknown parameter 'namecase'
> 
> This is because there is a difference in mount option between old
> staging/exfat and new exfat.
> And utf8, debug, and codepage options as well as namecase have been
> removed from new exfat.
> 
> This patch add the dummy mount options as deprecated option to be backward
> compatible with old one.

Wow, it seems wild that we'd need to maintain compatibility with options
which only ever existed in a different codebase in a staging driver
(what's the point of staging if every interface that makes it that far has
to be maintained in perpetuity?)

Often, when things are deprecated, they are eventually removed.  Perhaps a
future removal date stated in this commit, or in Documentation/..../exfat.txt
would be good as a reminder to eventually remove this?

-Eric

> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
> v2:
>  - fix checkpatch.pl warning(Missing Signed-off-by).
> 
>  fs/exfat/super.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 0565d5539d57..26b0db5b20de 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -203,6 +203,12 @@ enum {
>  	Opt_errors,
>  	Opt_discard,
>  	Opt_time_offset,
> +
> +	/* Deprecated options */
> +	Opt_utf8,
> +	Opt_debug,
> +	Opt_namecase,
> +	Opt_codepage,
>  };
>  
>  static const struct constant_table exfat_param_enums[] = {
> @@ -223,6 +229,10 @@ static const struct fs_parameter_spec exfat_parameters[] = {
>  	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
>  	fsparam_flag("discard",			Opt_discard),
>  	fsparam_s32("time_offset",		Opt_time_offset),
> +	fsparam_flag("utf8",			Opt_utf8),
> +	fsparam_flag("debug",			Opt_debug),
> +	fsparam_u32("namecase",			Opt_namecase),
> +	fsparam_u32("codepage",			Opt_codepage),
>  	{}
>  };
>  
> @@ -278,6 +288,18 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		opts->time_offset = result.int_32;
>  		break;
> +	case Opt_utf8:
> +		pr_warn("exFAT-fs: 'utf8' mount option is deprecated and has no effect\n");
> +		break;
> +	case Opt_debug:
> +		pr_warn("exFAT-fs: 'debug' mount option is deprecated and has no effect\n");
> +		break;
> +	case Opt_namecase:
> +		pr_warn("exFAT-fs: 'namecase' mount option is deprecated and has no effect\n");
> +		break;
> +	case Opt_codepage:
> +		pr_warn("exFAT-fs: 'codepage' mount option is deprecated and has no effect\n");
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> 
