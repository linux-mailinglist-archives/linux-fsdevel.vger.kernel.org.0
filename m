Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31E7B0D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjI0UZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0UZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:25:33 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBF10E;
        Wed, 27 Sep 2023 13:25:29 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34862)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qlb68-004E9A-TM; Wed, 27 Sep 2023 14:25:28 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:55018 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qlb67-00DYm2-Qk; Wed, 27 Sep 2023 14:25:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Ott <sebott@redhat.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230927033634.make.602-kees@kernel.org>
Date:   Wed, 27 Sep 2023 15:25:21 -0500
In-Reply-To: <20230927033634.make.602-kees@kernel.org> (Kees Cook's message of
        "Tue, 26 Sep 2023 20:42:17 -0700")
Message-ID: <87il7v8itq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qlb67-00DYm2-Qk;;;mid=<87il7v8itq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18Gql5jFySccJ7lzoWBXWBHedBRO+fGkGw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 487 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 0.90
        (0.2%), extract_message_metadata: 15 (3.1%), get_uri_detail_list: 1.14
        (0.2%), tests_pri_-2000: 21 (4.3%), tests_pri_-1000: 2.5 (0.5%),
        tests_pri_-950: 1.31 (0.3%), tests_pri_-900: 1.07 (0.2%),
        tests_pri_-200: 0.86 (0.2%), tests_pri_-100: 3.7 (0.8%),
        tests_pri_-90: 67 (13.8%), check_bayes: 66 (13.5%), b_tokenize: 6
        (1.3%), b_tok_get_all: 6 (1.3%), b_comp_prob: 1.99 (0.4%),
        b_tok_touch_all: 47 (9.7%), b_finish: 0.90 (0.2%), tests_pri_0: 200
        (41.1%), check_dkim_signature: 0.51 (0.1%), check_dkim_adsp: 2.4
        (0.5%), poll_dns_idle: 148 (30.4%), tests_pri_10: 2.2 (0.4%),
        tests_pri_500: 157 (32.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 0/4] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Hi,
>
> This is the continuation of the work Eric started for handling
> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> BSS, segment). I've added the suggested changes:
>
>  - drop unused "elf_bss" variable
>  - report padzero() errors when PROT_WRITE is present
>  - refactor load_elf_interp() to use elf_load()
>
> This passes my quick smoke tests, but I'm still trying to construct some
> more complete tests...

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

You might also consider using elf_load in load_elf_library.

The code in load_elf_library only supports files with a single program
header, and I think is only needed for libc5.

The advantage is that load_elf_library would be using well tested code,
vm_brk would have no callers, and padzero would only be called by
elf_load, and load_elf_library would do little more than just call
load_elf_library.

Eric

>
> -Kees
>
> Eric W. Biederman (1):
>   binfmt_elf: Support segments with 0 filesz and misaligned starts
>
> Kees Cook (3):
>   binfmt_elf: elf_bss no longer used by load_elf_binary()
>   binfmt_elf: Provide prot bits as context for padzero() errors
>   binfmt_elf: Use elf_load() for interpreter
>
>  fs/binfmt_elf.c | 192 ++++++++++++++++++------------------------------
>  1 file changed, 71 insertions(+), 121 deletions(-)
