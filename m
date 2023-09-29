Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000EE7B3702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjI2PkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjI2PkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:40:01 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88ADD;
        Fri, 29 Sep 2023 08:39:59 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43516)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFaw-007Gkh-87; Fri, 29 Sep 2023 09:39:58 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35744 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFat-00H6Yy-NC; Fri, 29 Sep 2023 09:39:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230929031716.it.155-kees@kernel.org>
        <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
Date:   Fri, 29 Sep 2023 10:39:48 -0500
In-Reply-To: <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
        (Pedro Falcato's message of "Fri, 29 Sep 2023 12:58:18 +0100")
Message-ID: <87jzs96la3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qmFat-00H6Yy-NC;;;mid=<87jzs96la3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1978eUsRurBCHqZn1jQUDAnUa0SmxZia2o=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Pedro Falcato <pedro.falcato@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1958 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (0.6%), b_tie_ro: 11 (0.5%), parse: 1.48
        (0.1%), extract_message_metadata: 28 (1.4%), get_uri_detail_list: 5
        (0.3%), tests_pri_-2000: 18 (0.9%), tests_pri_-1000: 2.6 (0.1%),
        tests_pri_-950: 1.27 (0.1%), tests_pri_-900: 1.05 (0.1%),
        tests_pri_-200: 0.86 (0.0%), tests_pri_-100: 7 (0.4%), tests_pri_-90:
        68 (3.5%), check_bayes: 66 (3.4%), b_tokenize: 14 (0.7%),
        b_tok_get_all: 12 (0.6%), b_comp_prob: 3.0 (0.2%), b_tok_touch_all: 34
        (1.7%), b_finish: 0.87 (0.0%), tests_pri_0: 459 (23.4%),
        check_dkim_signature: 0.63 (0.0%), check_dkim_adsp: 2.6 (0.1%),
        poll_dns_idle: 1334 (68.1%), tests_pri_10: 2.9 (0.1%), tests_pri_500:
        1352 (69.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pedro Falcato <pedro.falcato@gmail.com> writes:

> On Fri, Sep 29, 2023 at 4:24 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> Hi,
>>
>> This is the continuation of the work Eric started for handling
>> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
>> BSS, segment). I've added the suggested changes:
>>
>>  - drop unused "elf_bss" variable
>>  - refactor load_elf_interp() to use elf_load()
>>  - refactor load_elf_library() to use elf_load()
>>  - report padzero() errors when PROT_WRITE is present
>>  - drop vm_brk()
>>
>> Thanks!
>>
>> -Kees
>>
>> v4:
>>  - refactor load_elf_library() too
>>  - don't refactor padzero(), just test in the only remaining caller
>>  - drop now-unused vm_brk()
>> v3: https://lore.kernel.org/all/20230927033634.make.602-kees@kernel.org
>> v2: https://lore.kernel.org/lkml/87sf71f123.fsf@email.froward.int.ebiederm.org
>> v1: https://lore.kernel.org/lkml/87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org
>>
>> Eric W. Biederman (1):
>>   binfmt_elf: Support segments with 0 filesz and misaligned starts
>>
>> Kees Cook (5):
>>   binfmt_elf: elf_bss no longer used by load_elf_binary()
>>   binfmt_elf: Use elf_load() for interpreter
>>   binfmt_elf: Use elf_load() for library
>>   binfmt_elf: Only report padzero() errors when PROT_WRITE
>>   mm: Remove unused vm_brk()
>>
>>  fs/binfmt_elf.c    | 214 ++++++++++++++++-----------------------------
>>  include/linux/mm.h |   3 +-
>>  mm/mmap.c          |   6 --
>>  mm/nommu.c         |   5 --
>>  4 files changed, 76 insertions(+), 152 deletions(-)
>
> Sorry for taking so long to take a look at this.
> While I didn't test PPC64 (I don't own PPC64 hardware, and I wasn't
> the original reporter), I did manage to craft a reduced test case of:
>
> a.out:
>
> Program Headers:
>  Type           Offset             VirtAddr           PhysAddr
>                 FileSiz            MemSiz              Flags  Align
>  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
>                 0x00000000000001f8 0x00000000000001f8  R      0x8
>  INTERP         0x0000000000000238 0x0000000000000238 0x0000000000000238
>                 0x0000000000000020 0x0000000000000020  R      0x1
>      [Requesting program interpreter: /home/pfalcato/musl/lib/libc.so]
>  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000000428 0x0000000000000428  R      0x1000
>  LOAD           0x0000000000001000 0x0000000000001000 0x0000000000001000
>                 0x00000000000000cd 0x00000000000000cd  R E    0x1000
>  LOAD           0x0000000000002000 0x0000000000002000 0x0000000000002000
>                 0x0000000000000084 0x0000000000000084  R      0x1000
>  LOAD           0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
>                 0x00000000000001c8 0x00000000000001c8  RW     0x1000
>  DYNAMIC        0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
>                 0x0000000000000180 0x0000000000000180  RW     0x8
>  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000000000 0x0000000000000000  RW     0x10
>  GNU_RELRO      0x0000000000002e50 0x0000000000003e50 0x0000000000003e50
>                 0x00000000000001b0 0x00000000000001b0  R      0x1
>
> /home/pfalcato/musl/lib/libc.so:
> Program Headers:
>  Type           Offset             VirtAddr           PhysAddr
>                 FileSiz            MemSiz              Flags  Align
>  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
>                 0x0000000000000230 0x0000000000000230  R      0x8
>  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000049d9c 0x0000000000049d9c  R      0x1000
>  LOAD           0x0000000000049da0 0x000000000004ada0 0x000000000004ada0
>                 0x0000000000057d30 0x0000000000057d30  R E    0x1000
>  LOAD           0x00000000000a1ad0 0x00000000000a3ad0 0x00000000000a3ad0
>                 0x00000000000005f0 0x00000000000015f0  RW     0x1000
>  LOAD           0x00000000000a20c0 0x00000000000a60c0 0x00000000000a60c0
>                 0x0000000000000428 0x0000000000002f80  RW     0x1000
>  DYNAMIC        0x00000000000a1f38 0x00000000000a3f38 0x00000000000a3f38
>                 0x0000000000000110 0x0000000000000110  RW     0x8
>  GNU_RELRO      0x00000000000a1ad0 0x00000000000a3ad0 0x00000000000a3ad0
>                 0x00000000000005f0 0x0000000000002530  R      0x1
>  GNU_EH_FRAME   0x0000000000049d10 0x0000000000049d10 0x0000000000049d10
>                 0x0000000000000024 0x0000000000000024  R      0x4
>  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000000000 0x0000000000000000  RW     0x0
>  NOTE           0x0000000000000270 0x0000000000000270 0x0000000000000270
>                 0x0000000000000018 0x0000000000000018  R      0x4
>
> Section to Segment mapping:
>  Segment Sections...
>   00
>   01     .note.gnu.build-id .dynsym .gnu.hash .hash .dynstr .rela.dyn
> .rela.plt .rodata .eh_frame_hdr .eh_frame
>   02     .text .plt
>   03     .data.rel.ro .dynamic .got .toc
>   04     .data .got.plt .bss
>   05     .dynamic
>   06     .data.rel.ro .dynamic .got .toc
>   07     .eh_frame_hdr
>   08
>   09     .note.gnu.build-id
>
>
> So on that end, you can take my
>
> Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
>
> Although this still doesn't address the other bug I found
> (https://github.com/heatd/elf-bug-questionmark), where segments can
> accidentally overwrite cleared BSS if we end up in a situation where
> e.g we have the following segments:
>
> Program Headers:
>  Type           Offset             VirtAddr           PhysAddr
>                 FileSiz            MemSiz              Flags  Align
>  LOAD           0x0000000000001000 0x0000000000400000 0x0000000000400000
>                 0x0000000000000045 0x0000000000000045  R E    0x1000
>  LOAD           0x0000000000002000 0x0000000000401000 0x0000000000401000
>                 0x000000000000008c 0x000000000000008c  R      0x1000
>  LOAD           0x0000000000000000 0x0000000000402000 0x0000000000402000
>                 0x0000000000000000 0x0000000000000801  RW     0x1000
>  LOAD           0x0000000000002801 0x0000000000402801 0x0000000000402801
>                 0x0000000000000007 0x0000000000000007  RW     0x1000
>  NOTE           0x0000000000002068 0x0000000000401068 0x0000000000401068
>                 0x0000000000000024 0x0000000000000024         0x4
>
> Section to Segment mapping:
>  Segment Sections...
>   00     .text
>   01     .rodata .note.gnu.property .note.gnu.build-id
>   02     .bss
>   03     .data
>   04     .note.gnu.build-id
>
> since the mmap of .data will end up happening over .bss.

This is simply invalid userspace, doubly so with the alignment set to
0x1000.

The best the kernel can do is have a pre-pass through the elf program
headers (before the point of no-return) and if they describe overlapping
segments or out of order segments, cause execve syscall to fail.

Eric



