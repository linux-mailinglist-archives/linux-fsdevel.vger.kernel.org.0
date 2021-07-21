Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F903D1172
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhGUNzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:55:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57542 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhGUNzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:55:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C245D1FEBA;
        Wed, 21 Jul 2021 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626878142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0kCXBTCbuZTbhG0GdZDl+3489oWG/wz0jjtbgTWj1Y=;
        b=ePybv2pmGQT79Tr0pBcwvpiADKvqrc9FKyyTRJNdAtfwQ7GjHfljQjAdHAexx0YtkTHCbh
        2Nr5LORyLTSsMFh1wUto1EMR0JSNxUog+PrkGV2x/bojbiH0TcbvJq9qRWyaOS0yeF8fNU
        8EUIAZD9KxPYxql1OPwGvnMxV1urFgw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 77CE713BF7;
        Wed, 21 Jul 2021 14:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5rX8Gr4w+GDJJAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 21 Jul 2021 14:35:42 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
Date:   Wed, 21 Jul 2021 17:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPgwATAQBfU2eeOk@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21.07.21 г. 17:32, Christoph Hellwig wrote:
> This seems to have lost the copyright notices from glibc.
> 

I copied over only the code, what else needs to be brought up:

 Copyright (C) 1991-2021 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Torbjorn Granlund (tege@sics.se).

The rest is the generic GPL license txt ?
