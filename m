Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87886B9DF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCNSMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNSME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:12:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81B26854;
        Tue, 14 Mar 2023 11:12:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0823344A;
        Tue, 14 Mar 2023 18:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0823344A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678817522; bh=hZIB3fXbwJyV05G1DqnBxpSsaRU2qVB2wPhuKl4K2+M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H0hHeZaKWaEdQZDneY6d4KftcMJ5qnrBC0HkBJZxOMRMiJ6jrM5MV8S4byzRmPWFA
         eRlH+fggJT06S7QC9EighIoEMm6e5Kcy3uw+khhldE9N/gTfql/zC6EX/eZmjthHRy
         M5oDWukWVfaWX1zMSLTE7SQj0ztrj5t5JvnI22l2HMfDS/vGcJpd7wgRFJdeoPBpaz
         7wDpb00DlmsKZPHsUfqHF6yVXVvVKB7IBtv0J4QaBzKc+EgR82mNjJzjPAoOlQdz+D
         ZBz0fcRDXn7c+qZZqUdxDQ2zeZcJLdQtIChCfPF0Sw3SE2C7kz0pLiDRN/Cl0Xu8Yw
         NtsCHLdn/57bQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fs/proc: corrections and update
In-Reply-To: <20230314060347.605-1-rdunlap@infradead.org>
References: <20230314060347.605-1-rdunlap@infradead.org>
Date:   Tue, 14 Mar 2023 12:12:01 -0600
Message-ID: <87zg8frymm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Update URL for the latest online version of this document.
> Correct "files" to "fields" in a few places.
> Update /proc/scsi, /proc/stat, and /proc/fs/ext4 information.
> Drop /usr/src/ from the location of the kernel source tree.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  Documentation/filesystems/proc.rst |   44 ++++++++++++++-------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Applied, thanks.

jon
