Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F334ABB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCZPm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 11:42:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38098 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhCZPm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:42:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F6R726b1Pz1s3k6;
        Fri, 26 Mar 2021 16:42:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F6R724zYRz1qqkC;
        Fri, 26 Mar 2021 16:42:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id S2EB9622yI-b; Fri, 26 Mar 2021 16:42:21 +0100 (CET)
X-Auth-Info: S2S6qKqa1JBY7en7lQ/hprRzwbod0Z6h69H/YSf2KQ33QJwiZYazVXSNSJyHZShR
Received: from igel.home (ppp-46-244-160-134.dynamic.mnet-online.de [46.244.160.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 26 Mar 2021 16:42:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id D57982C361D; Fri, 26 Mar 2021 16:42:20 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] exec: remove compat_do_execve
References: <20210326143831.1550030-1-hch@lst.de>
        <20210326143831.1550030-3-hch@lst.de>
X-Yow:  Intra-mural sports results are filtering through th' plumbing...
Date:   Fri, 26 Mar 2021 16:42:20 +0100
In-Reply-To: <20210326143831.1550030-3-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 26 Mar 2021 15:38:29 +0100")
Message-ID: <87v99dexb7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mär 26 2021, Christoph Hellwig wrote:

> Just call compat_do_execve instead.

ITYM compat_do_execveat here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
