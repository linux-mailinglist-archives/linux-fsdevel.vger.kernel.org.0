Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9F73B447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFWJ7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFWJ7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D287E75;
        Fri, 23 Jun 2023 02:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A82619E6;
        Fri, 23 Jun 2023 09:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59253C433C0;
        Fri, 23 Jun 2023 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687514371;
        bh=4Sre3Xe85q5AdiCISxJI7jZ0ap6BzfWgIsXsmS9GAeg=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
        b=qF0FqNbgti2kUjCNRZktFY/T7IkOS0lKFWJ9d35XUkpV//Dbgvb/A+EveLG/fgnVo
         UBdskociHfOd35HYD5d9Ejx+hHn5FlaaMy1ZxRFsCZxAIRQMdjXNjn/LhxbPPpS4be
         BwZ1+tg5L/ix1eyqDu0EpvEBHyMUsxCZMm5YLzXAE4Rg/2NbYGcaow+8cYsmm97kTk
         AAWHCTCDYVo4rlXoCnoAy2LoQo9yGxuh3RbXT04+6Yc6HrBRpFZVUJ5Tq0X8HQNY8L
         CVrz3xO+Qv32lcWcKkaFiQ3SLSVKXTK1PTXOcgc1jqkceav+NXiglVIbSD3TFJl6zl
         chQQUgcz8Krmw==
Message-ID: <3719669bc40890e3a8221593ff8a178411ad749b.camel@kernel.org>
Subject: Re: [PATCH] fcntl.2: document F_UNLCK F_OFD_GETLK extension
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
In-Reply-To: <20230621152214.2720319-4-stsp2@yandex.ru>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
         <20230621152214.2720319-4-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Thu, 22 Jun 2023 08:03:53 -0400
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-06-21 at 20:22 +0500, Stas Sergeev wrote:
> F_UNLCK has the special meaning when used as a lock type on input.
> It returns the information about any lock found in the specified
> region on that particular file descriptor. Locks on other file
> descriptors are ignored by F_UNLCK.
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>=20
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> CC: linux-api@vger.kernel.org
>=20
> ---
>  man2/fcntl.2 | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index 7b5604e3a..e3e3e7b8c 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -604,6 +604,13 @@ then details about one of these locks are returned v=
ia
>  .IR lock ,
>  as described above for
>  .BR F_GETLK .
> +.B F_UNLCK
> +has the special meaning when put into
> +.I l_type
> +as an input. It returns the information about any lock in the specified
> +range on that particular file descriptor. The locks on other file
> +descriptors are ignored by
> +.BR F_UNLCK .
>  .PP
>  In the current implementation,
>  .\" commit 57b65325fe34ec4c917bc4e555144b4a94d9e1f7


We need to be pedantic for manpages. A "file description" is the
representation of the open file in the kernel (basically, the "struct
file" in the kernel). A file _descriptor_ is the numeric identifier
returned by open() and similar functions.

The locks are owned by the file description, so that would be the better
term to use here. I think you want something like:

"When the l_type is set to F_UNLCK, returned locks are limited to ones
set on the given file description. Locks set on other file descriptions
are ignored on F_GETLK requests with the l_type set to F_UNLCK."

--=20
Jeff Layton <jlayton@kernel.org>
