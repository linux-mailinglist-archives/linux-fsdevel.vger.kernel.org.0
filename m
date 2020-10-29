Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07FB29EADF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2LkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 07:40:06 -0400
Received: from smtp-bc0d.mail.infomaniak.ch ([45.157.188.13]:46857 "EHLO
        smtp-bc0d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgJ2LkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:40:05 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CMNll5T2bzljbGk;
        Thu, 29 Oct 2020 12:40:03 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CMNlk5d69zlh8TD;
        Thu, 29 Oct 2020 12:40:02 +0100 (CET)
Subject: Re: [PATCH v22 00/12] Landlock LSM
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20201027200358.557003-1-mic@digikod.net>
 <CAG48ez31oct9c8fkgFHQVb5u-o5cmwdNe2pJnmitnKcidNgfzw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <25f5ec87-5462-9d47-d265-ec442eb50046@digikod.net>
Date:   Thu, 29 Oct 2020 12:40:02 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez31oct9c8fkgFHQVb5u-o5cmwdNe2pJnmitnKcidNgfzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:05, Jann Horn wrote:
> On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>> This new patch series improves documentation, cleans up comments,
>> renames ARCH_EPHEMERAL_STATES to ARCH_EPHEMERAL_INODES and removes
>> LANDLOCK_ACCESS_FS_CHROOT.
> 
> Thanks for continuing to work on this! This is going to be really
> valuable for sandboxing.
> 
> I hadn't looked at this series for a while; but I've now read through
> it, and I don't see any major problems left. :) That said, there still
> are a couple small things...
> 

Thanks Jann, I really appreciate your reviews!
