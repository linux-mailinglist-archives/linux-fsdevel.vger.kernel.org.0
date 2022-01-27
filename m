Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3C49E820
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiA0QyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:54:24 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:54616 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbiA0QyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z5kdi/2vnGbJelc6HiI/gkWTGI7eeIgVJi2FH4beUag=; b=ngq+lWePz30tCeB65IcaTJtT8K
        UcVukCW4mUq3DnFnY5W5Cu1z/WyCyo5a3Wdk1aGTv5moZXid4YoD9lucPO3YfCXM+b0d5JY/WD13O
        68GxmVFoyAfqJQQpjentRJKpRE08CrMZgcIb8R49mww+APimNi5HWwLCuDFqTo0XJ6a3WvSaCdh1b
        tnc8lVu1eQyhxwwzRIKs9sqwgGhr3m5SulMYr+FLbfoxsv7yvHvB9qd/8H99yvKbsVQLHTmN83MiF
        i1l074yw6YZC1XTuGUCebt49P1lgmKDSHKaawSzbbMXn4UOgKrpfljVz4DW9l2OfIr8ewFB/+n1Oa
        fAEZt1rg==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nD82H-0006sM-TV; Thu, 27 Jan 2022 17:54:14 +0100
Message-ID: <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
Date:   Thu, 27 Jan 2022 13:53:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com> <Yd/qmyz+qSuoUwbs@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yd/qmyz+qSuoUwbs@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew, can I ask you to please remove this patch from linux-next?

It shows here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=56439cb78293

Baoquan has concerns, and we're discussing that in another thread [0],
after I submit another change on top of this one. So, I guess it's
simpler to just drop it.

My apologies for this, I should have definitely loop the kexec list in
this one , but I forgot.

Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/7b93afff-66a0-44ee-3bb7-3d1e12dd47c2@igalia.com/
