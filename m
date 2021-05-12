Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE937B60C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 08:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhELG1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 02:27:09 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:57746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229626AbhELG1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 02:27:08 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 02:27:08 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 20DBD18006AF3;
        Wed, 12 May 2021 06:20:33 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 07E56182CED5B;
        Wed, 12 May 2021 06:20:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 716C42EBFA0;
        Wed, 12 May 2021 06:20:29 +0000 (UTC)
Message-ID: <3caa40b3096bba9ff0d3ff8bc57bb44c4c891f76.camel@perches.com>
Subject: Re: [PATCH v3 10/15] MAINTAINERS: Add myself as designated reviewer
 for generic string library
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 11 May 2021 23:20:27 -0700
In-Reply-To: <20210504180819.73127-11-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
         <20210504180819.73127-11-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 716C42EBFA0
X-Spam-Status: No, score=-1.42
X-Stat-Signature: mmr7rt1c9ib5fkzh4z6z4ndd6md9jumf
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/mNT6DZHem5Pp4uPqG8vt9EsESzdSq7RI=
X-HE-Tag: 1620800429-817224
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-05-04 at 21:08 +0300, Andy Shevchenko wrote:
> Add myself as designated reviewer for generic string library.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1783372a608a..2c5797fc462c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7650,6 +7650,14 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/input/touchscreen/resistive-adc-touch.c
>  
> 
> +GENERIC STRING LIBRARY
> +R:	Andy Shevchenko <andy@kernel.org>
> +S:	Maintained
> +F:	lib/string.c
> +F:	lib/string_helpers.c
> +F:	lib/test_string.c
> +F:	lib/test-string_helpers.c

How can something be maintained if it has only a reviewer?


