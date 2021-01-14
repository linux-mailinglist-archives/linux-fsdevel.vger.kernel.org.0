Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3ED2F6A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbhANTEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 14:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbhANTEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:04:48 -0500
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jan 2021 11:04:27 PST
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E1C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 11:04:27 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DGty40K9jzMq8Xg;
        Thu, 14 Jan 2021 20:03:40 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DGty16Bhkzlh8T2;
        Thu, 14 Jan 2021 20:03:37 +0100 (CET)
Subject: Re: [PATCH v26 00/12] Landlock LSM
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
References: <20201209192839.1396820-1-mic@digikod.net>
 <CAG48ez3DE8xgr_etVGV5eNjH2CXXo9MR7jTcu+_LCkJUchLXcQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <92df89c9-3442-0761-224a-ab53bb917850@digikod.net>
Date:   Thu, 14 Jan 2021 20:03:47 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez3DE8xgr_etVGV5eNjH2CXXo9MR7jTcu+_LCkJUchLXcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/01/2021 04:22, Jann Horn wrote:
> On Wed, Dec 9, 2020 at 8:28 PM Mickaël Salaün <mic@digikod.net> wrote:
>> This patch series adds new built-time checks, a new test, renames some
>> variables and functions to improve readability, and shift syscall
>> numbers to align with -next.
> 
> Sorry, I've finally gotten around to looking at v26 - I hadn't
> actually looked at v25 either yet. I think there's still one remaining
> small issue in the filesystem access logic, but I think that's very
> simple to fix, as long as we agree on what the expected semantics are.
> Otherwise it basically looks good, apart from some typos.
> 
> I think v27 will be the final version of this series. :) (And I'll try
> to actually look at that version much faster - I realize that waiting
> for code reviews this long sucks.)
> 

I'm improving the tests, especially with bind mounts and overlayfs
tests. The v27 will also contains a better documentation to clarify the
semantic and explain how these mounts are handled. Thanks!
