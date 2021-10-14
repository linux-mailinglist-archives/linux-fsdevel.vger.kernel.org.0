Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2942D8C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJNMF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 08:05:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNMF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:05:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 880A821A73;
        Thu, 14 Oct 2021 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634213032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YGJuSqWqu59dVsZM1qiITmFVB7M/5Ic0w3O/Npa1J8=;
        b=t7JfgZx9AcyViYDnaFyHmmIK5wV1csQJIKNELDQoQJEGJ1rii59CiyGH7Dskm5KjnEO8Wb
        Z7/7Y4B4R4/1OKKthOp4pJ5IiDfWU5GXEi2Twvel/iz3A18E7rTDZvn0W+hte0LMkKDZgd
        DqgUdLftR4mb7hNIefltIODpIFdUQRI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4393713D8D;
        Thu, 14 Oct 2021 12:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8bgDDqgcaGGsMQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 12:03:52 +0000
Subject: Re: [PATCH v11 02/14] fs: export variant of generic_write_checks
 without iov_iter
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <119d77ad1d63aac1c02e88d750e7e35721c67c97.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e5941260-9dd1-ce5d-1610-6e2fcceb0495@suse.com>
Date:   Thu, 14 Oct 2021 15:03:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <119d77ad1d63aac1c02e88d750e7e35721c67c97.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:00, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Encoded I/O in Btrfs needs to check a write with a given logical size
> without an iov_iter that matches that size (because the iov_iter we have
> is for the compressed data). So, factor out the parts of
> generic_write_check() that don't need an iov_iter into a new
> generic_write_checks_count() function and export that.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
