Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE57B36DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjI2PdM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2PdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:33:11 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E737B4;
        Fri, 29 Sep 2023 08:33:09 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59108)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFUK-00FzWn-ET; Fri, 29 Sep 2023 09:33:08 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57062 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFUI-009b5s-TR; Fri, 29 Sep 2023 09:33:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230929031716.it.155-kees@kernel.org>
        <20230929032435.2391507-4-keescook@chromium.org>
        <CAKbZUD1ojuNN_+x6gkxEMsmLOd5KbCs-wfJcMM==b8+k8_uD_w@mail.gmail.com>
Date:   Fri, 29 Sep 2023 10:32:59 -0500
In-Reply-To: <CAKbZUD1ojuNN_+x6gkxEMsmLOd5KbCs-wfJcMM==b8+k8_uD_w@mail.gmail.com>
        (Pedro Falcato's message of "Fri, 29 Sep 2023 13:12:13 +0100")
Message-ID: <87y1gp6llg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qmFUI-009b5s-TR;;;mid=<87y1gp6llg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18dXVfN1YAEePbYpFJoWWbpYNcqcNqjTNI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Pedro Falcato <pedro.falcato@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 939 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.5%), b_tie_ro: 3.0 (0.3%), parse: 1.18
        (0.1%), extract_message_metadata: 11 (1.2%), get_uri_detail_list: 1.00
        (0.1%), tests_pri_-2000: 9 (1.0%), tests_pri_-1000: 2.1 (0.2%),
        tests_pri_-950: 1.09 (0.1%), tests_pri_-900: 0.82 (0.1%),
        tests_pri_-200: 0.68 (0.1%), tests_pri_-100: 2.9 (0.3%),
        tests_pri_-90: 47 (5.0%), check_bayes: 46 (4.9%), b_tokenize: 4.5
        (0.5%), b_tok_get_all: 6 (0.7%), b_comp_prob: 1.43 (0.2%),
        b_tok_touch_all: 31 (3.3%), b_finish: 0.59 (0.1%), tests_pri_0: 163
        (17.4%), check_dkim_signature: 0.38 (0.0%), check_dkim_adsp: 4.9
        (0.5%), poll_dns_idle: 683 (72.7%), tests_pri_10: 1.70 (0.2%),
        tests_pri_500: 690 (73.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 4/6] binfmt_elf: Use elf_load() for library
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pedro Falcato <pedro.falcato@gmail.com> writes:

> On Fri, Sep 29, 2023 at 4:24 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> While load_elf_library() is a libc5-ism, we can still replace most of
>> its contents with elf_load() as well, further simplifying the code.
>
> While I understand you want to break as little as possible (as the ELF
> loader maintainer), I'm wondering if we could axe CONFIG_USELIB
> altogether? Since CONFIG_BINFMT_AOUT also got axed. Does this have
> users anywhere?

As I recall:
- libc4 was a.out and used uselib.
- libc5 was elf and used uselib.
- libc6 is elf and has never used uselib.

Anything using libc5 is extremely rare.  It is an entire big process to
see if there are any users in existence.

In the meantime changing load_elf_library to use elf_load removes any
maintenance burden.

Eric

