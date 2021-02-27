Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66875326EDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0ULE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 15:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhB0ULC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 15:11:02 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Feb 2021 12:10:21 PST
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F624C06174A
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 12:10:21 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614456236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KtlqUDPweEFDLQTeMQQChambd9jgChj9RHAVkzpC4=;
        b=fXUtjO/7Wvb58jjVauEA5KdiVrqxb5H+lO/AUyB6cr4dNKPqcOIKXe5aYfQGl1SRObaQyz
        M7V8952DhBZSJwQ3tHdDlbmK/Pec8f1cGBFNDY4malkfzbMDcpdUI0t/m6pOuS2+kbJP9f
        4LJhtGiXRY9jb7cZRjUTXsaQEoeqqd/nuViVr8e3fq+4MDBfgX0UzjqtprRwRC0ziUNegC
        edL0uGGiA2Ge2K5Ky0MKwe014T7idlMrOcDBKcTA6LSP+1bpOQucvN1+ozD8R2EhSA1jLb
        3FO3Z/8CJNX0xAZ2RatDsEYxoZm49pa8xH7eMWVdFo1yPttPdb8yL+ReF2Q1gg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Feb 2021 15:03:54 -0500
Message-Id: <C9KKYZ4T5O53.338Y48UIQ9W3H@taiga>
Cc:     <linux-fsdevel@vger.kernel.org>
Subject: Re: openat, mkdirat, and TOCTOU for directory creation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Aleksa Sarai" <cyphar@cyphar.com>
References: <C9KDTRDMTBR4.2JFWCA79LXA9X@taiga>
 <20210227175833.qgj4qrzz7aqe4zah@yavin.dot.cyphar.com>
In-Reply-To: <20210227175833.qgj4qrzz7aqe4zah@yavin.dot.cyphar.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat Feb 27, 2021 at 12:58 PM EST, Aleksa Sarai wrote:
> Maybe a mkdirat2(2) (which takes a flags argument -- sigh) that can be
> told to return a handle to the new directory would be a nicer API.

That seems appropriate. Hear hear on the sigh.

> Changing the semantics of open scares me a fair bit -- you could
> probably change openat2(2) since it's not as widely used yet.

Seems agreeable, at least for a start.
