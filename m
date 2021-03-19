Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67734213C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhCSPwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 11:52:10 -0400
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175]:56971 "EHLO
        smtp-8faf.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230348AbhCSPvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:51:51 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F27g962FxzMqCNw;
        Fri, 19 Mar 2021 16:51:49 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F27g65j8Qzlh8TH;
        Fri, 19 Mar 2021 16:51:46 +0100 (CET)
Subject: Re: [PATCH v30 00/12] Landlock LSM
To:     James Morris <jmorris@namei.org>
Cc:     Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210316204252.427806-1-mic@digikod.net>
 <651a1034-c59f-1085-d3f6-c5a41f6fbbb@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <39a58eb2-7cd8-9cc9-cbf1-829b6ee59f6b@digikod.net>
Date:   Fri, 19 Mar 2021 16:52:02 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <651a1034-c59f-1085-d3f6-c5a41f6fbbb@namei.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 00:26, James Morris wrote:
> I've queued this patchset here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git landlock_lsm
> 
> and pulled it into next-testing, which will get it coverage in linux-next.
> 
> All going well, I'll aim to push this to Linus in the next merge window. 
> More review and testing during that time will be helpful.

Good, thanks! The syzkaller changes are now merged and up-to-date with
linux-next:
https://github.com/google/syzkaller/commits/3d01c4de549b4e4bddba6102715c212bbcff2fbb
