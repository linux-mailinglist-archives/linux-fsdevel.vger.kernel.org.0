Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4D14A22A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgA0Knk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:43:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50114 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgA0Knk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:43:40 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00RAh5iL081253;
        Mon, 27 Jan 2020 19:43:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Mon, 27 Jan 2020 19:43:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00RAgwbk081074
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 27 Jan 2020 19:43:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        ssaner@redhat.com, atomlin@redhat.com, oleksandr@redhat.com,
        vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20200127101100.92588-1-ghalat@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <063e702f-dc5f-b0ca-fe26-508a9f1e8e9a@I-love.SAKURA.ne.jp>
Date:   Mon, 27 Jan 2020 19:42:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127101100.92588-1-ghalat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/27 19:11, Grzegorz Halat wrote:
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..2fecd6b2547e 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -61,6 +61,7 @@ show up in /proc/sys/kernel:
>  - overflowgid
>  - overflowuid
>  - panic
> +- panic_on_mm_error

Maybe panic_on_inconsistent_mm is better, for an MM error sounds too generic
(e.g. is page allocation failure an error, is OOM killer an error,
is NULL pointer dereference an error, is use-after-free access an error) ?

Also, should this be in /proc/sys/vm/ than /proc/sys/kernel/ ?

>  - panic_on_oops
>  - panic_on_stackoverflow
>  - panic_on_unrecovered_nmi
