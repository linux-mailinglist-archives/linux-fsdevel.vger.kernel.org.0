Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF00247F9EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 04:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhL0DOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 22:14:55 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:49020 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhL0DOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j9oVpDXMLf5UTVTj+LUGAgLKZZxdeOo7rBjpxsDl9Qw=; b=ITVtqcKgqplAhsuCYkF9p+QvDZ
        LvwW3Y9oKo/apL5zTXRynWUs+UniJum2buHMJa8qkLJT5pudXnVGoUcMqFqaIe1bzPu+hh1Bo+FAz
        S9FNc3yDoXPjRLxTWqimqqoVg6EoQSUyYZvNQ/0wFoJWHULSSwDyrRYpx31QVEHPtFZW7sSJSicfa
        NEgMRNy6jg+4Dw0eO9jbmEl5zFASUDAxbAJgO6K2AyNwTiuaM/UZtfMOep2hE0oY9eKkuKdMpzg6y
        0Sd7G0lB6NWig7A6Eer8EakRiMHBll/utLbDkAcndl9ljzFBZsUKasrOf5A/jAk1/DWZJu1cpZCHD
        bunD6lEw==;
Received: from [187.39.124.208] (helo=[192.168.0.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n1gSq-000A6b-9L; Mon, 27 Dec 2021 04:14:20 +0100
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
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
 <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
 <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <f4ca2296-f1fe-8836-9040-6025062f0a8b@igalia.com>
Date:   Mon, 27 Dec 2021 00:14:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/12/2021 22:45, Dave Young wrote:
> On 12/25/21 at 04:21pm, Guilherme G. Piccoli wrote:
> [...] 
> Hi Guilherme, yes, I have the same concern.  But there could be more
> things like the panic_print in the future, it looks odd to have more
> kernel cmdline params though.
> 

Agreed! We're on the same page here, definitely.


> [...] 
> It is definitely a good idea, I'm more than glad to see this if you
> would like to work on this! 
> 

Awesome! I'll try to give it a shot this week, let's see how complex
that'd be.

Thanks again for the great feedback!
Cheers,


Guilherme



