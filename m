Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7A47D1C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbhLVMes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 07:34:48 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:47206 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbhLVMer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DpfQr3KI1ooUwMp3zPorNiW327z1VEYdfuthn9gjjBA=; b=O2zVTEsKeXFgO5BaAh+iojUSVD
        p8/AAne4P5j1sVsARLJ4voHrGo04JADZUb+3p7j+BPhy2civMV1GdxMhHqOUIqyuk6hXSmS/Quk0Y
        QeFFFqWpJJlb2L+oo1BX5vL7rmXhn6djIibkyidoYOSI5Fs42bXkwKKRM0jDWTh8cshDKCpmC/mmD
        9CtVD+wj+9mzypHRac1wDVfYlz3q/F+V865Eg058w4+MN8D04Q9+T1c/fhNr1Kv6dU1IVK54BZh1o
        rOVAjR9c85fM9v88qCYbWxCMbtgq7zeuZhroxbdmWMQ13RM72UmZ/6DwawYKmJqUOJ75nrEFmDbsY
        DI6S3FjQ==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n00p9-0003aU-Eq; Wed, 22 Dec 2021 13:34:27 +0100
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net,
        kexec@lists.infradead.org
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
Date:   Wed, 22 Dec 2021 09:34:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/12/2021 08:45, Dave Young wrote:
> Hi Guilherme,
> 
> Thanks for you patch.  Could you add kexec list for any following up
> patches?  This could change kdump behavior so let's see if any comments
> from kexec list.
> 
> Kudos for the lore+lei tool so that I can catch this by seeing this
> coming into Andrews tree :)

Hi Dave, I'm really sorry for not adding the kexec list, I forgot. But I
will do next time for sure, my apologies. And thanks for taking a look
after you noticed that on lore, I appreciate your feedback!

> [...]
> People may enable kdump crashkernel and panic_print together but
> they are not aware the extra panic print could cause kdump not reliable
> (in theory).  So at least some words in kernel-parameters.txt would
> help.
>  

That makes sense, I'll improve that in a follow-up patch, how about
that? Indeed it's a good idea to let people be sure that panic_print
might affect kdump reliability, although I consider the risk to be
pretty low. And I'll loop the kexec list for sure!

Cheers,


Guilherme
