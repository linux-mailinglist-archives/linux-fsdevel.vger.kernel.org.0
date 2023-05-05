Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D336F7E21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjEEHrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEEHro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 03:47:44 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B1156BE;
        Fri,  5 May 2023 00:47:43 -0700 (PDT)
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.0.90
From:   Sam James <sam@gentoo.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
Date:   Fri, 05 May 2023 08:46:41 +0100
In-reply-to: <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
Message-ID: <87pm7f9q3q.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain


David Hildenbrand <david@redhat.com> writes:

> On 04.05.23 23:30, Michael McCracken wrote:
>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
>> sysctl to 0444 to disallow all runtime changes. This will prevent
>> accidental changing of this value by a root service.
>> The config is disabled by default to avoid surprises.
>
> Can you elaborate why we care about "accidental changing of this value
> by a root service"?
>
> We cannot really stop root from doing a lot of stupid things (e.g.,
> erase the root fs), so why do we particularly care here?

(I'm really not defending the utility of this, fwiw).

In the past, I've seen fuzzing tools and other debuggers try to set
it, and it might be that an admin doesn't realise that. But they could
easily set other dangerous settings unsuitable for production, so...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZFS0mV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZAf4wEAz3Kkey3pguBXyIJfqK+FI8qjiLI6X7SH6YJt
YEPU6oUBAMssaGW+4GhiA6nNxReLZcz2PFxEEi9/os6YSrEBD9UP
=65gP
-----END PGP SIGNATURE-----
--=-=-=--
