Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDC3F8416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhHZJEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 05:04:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbhHZJEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:04:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 570551FE68;
        Thu, 26 Aug 2021 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629968604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGs8P9c7NG5tXLKcRLwkhDpYXDkytUmmOPmA4s52z3A=;
        b=nH9l2Ag+NSNyhE+Y+6E/C0KpurfUbX9vNHKkb7ApNCgGI1lQpktmT07ui6o/5ffD+YDobO
        KnCYNRMSHCWhnIVIYMprqNNuwgwnR7SdVw3P/wyuYdVWT8cuuyekYAODH53fF60/eGbmKF
        sYoHi4vnWwepw4wQ3HiuMRXSbl9CKMc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0612213AA5;
        Thu, 26 Aug 2021 09:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 932eOttYJ2GBFQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 26 Aug 2021 09:03:23 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
 <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
 <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
 <eef30b51-c69f-0e70-11a8-c35f90aeca67@gmail.com>
 <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <78aab96b-aa95-2f7b-89aa-f6f4b2071c69@suse.com>
Date:   Thu, 26 Aug 2021 12:03:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 22.07.21 г. 19:40, Linus Torvalds wrote:
> So would you mind reminding me about this patch the next merge window?
> Unless there was some big extrernal reason why the performance of
> memcmp() mattered to you so much (ie some user that actually noticed
> and complained) and we really want to prioritize this..


I'm reminding you of spinning this patch up for 5.15 :)
