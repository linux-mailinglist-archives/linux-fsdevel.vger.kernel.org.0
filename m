Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E6B15962D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgBKRbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:31:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgBKRbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=4o9PB9m+IrGK3QGZcB85cx3hPfCNyy1f4QLXCxJ20so=; b=s2Qm4CYlmVLrKiJ3B5meGqaMuw
        iYaWQtUPnnBkS/wk9a9oLvTi/TcaSPyxSTleSDGPh2MfUqmAXwlUAHRZlkEnBuOX/+fdKRgZxDc8d
        O8M84kaEeeSMsHwHl6tYMd0i4UXW6GdNIX2v9vmUSmIGr/dogFqJlHqJO2CskamMZpIXDEAaotHFU
        CjBssQegvOGv8spzKEIIfbmmi6SahH83wZTjwPBIlRfvnhtt5eVCzoCOyLu0+dNQuPolRLyam6l1F
        nqmABq7IbMaQInJ0yBq4aOnU18cYNuwYcQ3WuWuw67VTNC8w5VTVWfoyRcrnrwe6uLnaU1ewokZ1q
        TqlHpoJg==;
Received: from [2603:3004:32:9a00::c450]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ZNz-0001g0-7U; Tue, 11 Feb 2020 17:31:47 +0000
Subject: Re: [PATCH 01/24] user_namespace: introduce fsid mappings
 infrastructure
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
 <20200211165753.356508-2-christian.brauner@ubuntu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25217d8b-f3e9-7362-e3d9-d8c37bf39558@infradead.org>
Date:   Tue, 11 Feb 2020 09:26:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211165753.356508-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/11/20 8:57 AM, Christian Brauner wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index a34064a031a5..4da082e4f787 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1102,6 +1102,17 @@ config USER_NS
>  
>  	  If unsure, say N.
>  
> +config USER_NS_FSID
> +	bool "User namespace fsid mappings"
> +	depends on USER_NS
> +	default n
> +	help
> +	  This allows containers, to alter their filesystem id mappings.

                   no comma   ^^^^

> +	  With this containers with different id mappings can still share
> +	  the same filesystem.
> +
> +	  If unsure, say N.
> +
>  config PID_NS
>  	bool "PID Namespaces"
>  	default y


-- 
~Randy
