Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1A6FCC63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjEIRIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjEIRIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 13:08:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015C5FE6;
        Tue,  9 May 2023 10:06:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BBE11FD64;
        Tue,  9 May 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683651970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGYB0TfAr9UhNrbW7xAWWS8j78JvSLyZTQQBZmz0qEc=;
        b=Rg9eOMs0pZvnCKGWPLW7znPpNzcAhDp/AMST4wjfVLnkNe5RsUeLNueKv3kw1GKz+ByLoA
        ytLrdTSsM6g635DjPipux+sq3AZlMC1qE+Rdcrbh024I/uHClLjVWgpMl01NjG6urhUHK+
        GWgEgSIlqZbAWChMjXxyw0dCN6oIiVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683651970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGYB0TfAr9UhNrbW7xAWWS8j78JvSLyZTQQBZmz0qEc=;
        b=7PXfVapbUGdU87U7FYeodNru60h2Z8vNwzBT/g0uTccGY//Th+TgqnMbwpfaQB7cYVqNAQ
        A3lmUYwy426syMAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2696E13581;
        Tue,  9 May 2023 17:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rkUNOYB9WmRBYwAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 09 May 2023 17:06:08 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 16/32] MAINTAINERS: Add entry for closures
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20230509165657.1735798-17-kent.overstreet@linux.dev>
Date:   Wed, 10 May 2023 01:05:56 +0800
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <106B2DFE-5516-49E2-9EEB-2759CE35D465@suse.de>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-17-kent.overstreet@linux.dev>
To:     Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8810=E6=97=A5 00:56=EF=BC=8CKent Overstreet =
<kent.overstreet@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> closures, from bcache, are async widgets with a variety of uses.
> bcachefs also uses them, so they're being moved to lib/; mark them as
> maintained.
>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Coly Li <colyli@suse.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
> MAINTAINERS | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fc37de3d6..5d76169140 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5044,6 +5044,14 @@ T: git =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> F: Documentation/devicetree/bindings/timer/
> F: drivers/clocksource/
>=20
> +CLOSURES:
> +M: Kent Overstreet <kent.overstreet@linux.dev>
> +L: linux-bcachefs@vger.kernel.org
> +S: Supported
> +C: irc://irc.oftc.net/bcache
> +F: include/linux/closure.h
> +F: lib/closure.c
> +
> CMPC ACPI DRIVER
> M: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> M: Daniel Oliveira Nascimento <don@syst.com.br>
> --=20
> 2.40.1
>=20

