Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB84F4205
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfKHIXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 03:23:13 -0500
Received: from mx01-fr.bfs.de ([193.174.231.67]:34635 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHIXM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:23:12 -0500
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id EEE4C2034D;
        Fri,  8 Nov 2019 09:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1573201385; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ovMpTZlO+mqX1NztFF4Z8RNfQdHNbliQo84EBCeKmM=;
        b=knPojPheDaPBcYO0QNEKA99SLOrrQ33XMHG3MG3K0LZOwxHE4616BDh2Y7CMpi5TGf/aKT
        ZZK+HPeJZmjLdyhNaKHlvbUovd4cCrlP6h/VsOx+sp5mVwxPBDYQ5lUiLKN4B95XMlPyZZ
        FFXGmOmmP2VITXOXVD/TSHndOHwV9lKrvg1X/X0mkRjOYKCpum4vFlr7QueAnpx47CWRGU
        tfsUWVeTSm3JyzAfXwj+0WXx+HX03nuSeY9XbjykjbSRtDigR/BV7TaDdOuT2HzQQ3J05U
        RF6vzt535kfv/BlYy/tMieg+LO3CQrgMNgiSq6jOyBR+bM1QpviXF8g6XMguzg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 8E220BEEBD;
        Fri,  8 Nov 2019 09:23:05 +0100 (CET)
Message-ID: <5DC525E8.4060705@bfs.de>
Date:   Fri, 08 Nov 2019 09:23:04 +0100
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Eric Biggers <ebiggers@kernel.org>
CC:     linux-man@vger.kernel.org, darrick.wong@oracle.com,
        dhowells@redhat.com, jaegeuk@kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
Subject: Re: [man-pages RFC PATCH] statx.2: document STATX_ATTR_VERITY
References: <20191107014420.GD15212@magnolia> <20191107220248.32025-1-ebiggers@kernel.org>
In-Reply-To: <20191107220248.32025-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.60
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-1.60 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         NEURAL_HAM(-0.00)[-0.998,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 07.11.2019 23:02, schrieb Eric Biggers:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the verity attribute for statx().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  man2/statx.2 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> RFC since the kernel patches are currently under review.
> The kernel patches can be found here:
> https://lkml.kernel.org/linux-fscrypt/20191029204141.145309-1-ebiggers@kernel.org/T/#u
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index d2f1b07b8..713bd1260 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -461,6 +461,10 @@ See
>  .TP
>  .B STATX_ATTR_ENCRYPTED
>  A key is required for the file to be encrypted by the filesystem.
> +.TP
> +.B STATX_ATTR_VERITY
> +The file has fs-verity enabled.  It cannot be written to, and all reads from it
> +will be verified against a Merkle tree.

Using "Merkle tree" opens a can of worm and what will happen when the methode will change ?
Does it matter at all ? i would suggest "filesystem" here.

re,
 wh

>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
