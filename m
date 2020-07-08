Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE421821F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGHIXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 04:23:36 -0400
Received: from smtp-190f.mail.infomaniak.ch ([185.125.25.15]:54711 "EHLO
        smtp-190f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbgGHIXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:23:36 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B1sl84TSxzlhWDS;
        Wed,  8 Jul 2020 10:23:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B1sl50LZfzlh8TT;
        Wed,  8 Jul 2020 10:23:28 +0200 (CEST)
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200707180955.53024-1-mic@digikod.net>
 <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
 <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
 <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <956a05c8-529b-bf97-99ac-8958cceb35f3@digikod.net>
Date:   Wed, 8 Jul 2020 10:23:28 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/07/2020 09:47, Arnd Bergmann wrote:
> On Wed, Jul 8, 2020 at 9:31 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 08/07/2020 09:22, Arnd Bergmann wrote:
>>> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>>> index f4a01305d9a6..a63a411a74d5 100644
>>>> --- a/include/uapi/asm-generic/unistd.h
>>>> +++ b/include/uapi/asm-generic/unistd.h
>>
>> OK, I'll rebase the next series on linux-next.
> 
> Just change the number to the next free one, without actually rebasing.
> It's always a bit messy to have multiple syscalls added, but I think that
> causes the least confusion.

OK, but this will lead to two merge conflicts: patch 8 (asmlinkage) and
patch 9 (tbl files).

Do you want me to update the tools/perf/arch/*.tbl too?
