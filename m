Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE77369615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhDWPXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhDWPXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:23:05 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B1C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 08:22:28 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FRdM55TyDzMrV2C;
        Fri, 23 Apr 2021 17:22:25 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4FRdM160b0zlh8TR;
        Fri, 23 Apr 2021 17:22:21 +0200 (CEST)
Subject: Re: [PATCH v34 00/13] Landlock LSM
To:     James Morris <jmorris@namei.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20210422154123.13086-1-mic@digikod.net>
 <9c775578-627c-e682-873a-ec7b763a7fcd@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <ac26af3b-067b-de01-8c99-687c5de432e5@digikod.net>
Date:   Fri, 23 Apr 2021 17:22:11 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <9c775578-627c-e682-873a-ec7b763a7fcd@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 22/04/2021 21:31, James Morris wrote:
> On Thu, 22 Apr 2021, Mickaël Salaün wrote:
> 
>> Hi,
>>
>> This updated patch series adds a new patch on top of the previous ones.
>> It brings a new flag to landlock_create_ruleset(2) that enables
>> efficient and simple backward compatibility checks for future evolutions
>> of Landlock (e.g. new access-control rights).
> 
> Applied to git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 
> landlock_lsm_v34
> 
> and it replaces the v33 branch in next-testing.

Thanks! It is now in next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20210423
