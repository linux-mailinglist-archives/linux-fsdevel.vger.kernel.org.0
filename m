Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8C2C439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE1KZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 06:25:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60057 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1KZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 06:25:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45CqjM1bQhz1rZ07;
        Tue, 28 May 2019 12:25:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45CqjL64ZDz1qqkH;
        Tue, 28 May 2019 12:25:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ipmAkLzaT_pN; Tue, 28 May 2019 12:25:09 +0200 (CEST)
X-Auth-Info: 2hslSmEGTPLoyKNKYOOmViG/Dyfm+220WIVpGrKlHlvIBaw9uFUuecR4QmL82tBJ
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 28 May 2019 12:25:09 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] [RFC] Remove bdflush syscall stub
References: <20190528101012.11402-1-chrubis@suse.cz>
X-Yow:  I'm working under the direct orders of WAYNE NEWTON to deport
 consenting adults!
Date:   Tue, 28 May 2019 12:25:09 +0200
In-Reply-To: <20190528101012.11402-1-chrubis@suse.cz> (Cyril Hrubis's message
        of "Tue, 28 May 2019 12:10:12 +0200")
Message-ID: <mvmr28idgfu.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mai 28 2019, Cyril Hrubis <chrubis@suse.cz> wrote:

> I've tested the patch on i386. Before the patch calling bdflush() with
> attempt to tune a variable returned 0 and after the patch the syscall
> fails with EINVAL.

Should be ENOSYS, doesn't it?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
