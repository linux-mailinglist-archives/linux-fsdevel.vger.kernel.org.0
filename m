Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67E643A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiLFAlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 19:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiLFAl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:41:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD15112D
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 16:41:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 65so404649pfx.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 16:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1HJHevNxrj1Nq/NT7g6yR6y+nhBZjMl2neMxR4W590=;
        b=m5t9TolEhunsnLAs8ghRCY5jduXJTUVrI828QMb9aaMDHIl9N52I0BcpPgXmJWJwHJ
         8O/axD8BEanTUffxKBpeoT/71MR//Ncm3X2gdqz7aFSVJrBM1Wbfryc+Rv8pyLm6oklN
         hdck+j11IhNQpknHmA6Td97jo/v98RGjlHlkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1HJHevNxrj1Nq/NT7g6yR6y+nhBZjMl2neMxR4W590=;
        b=fN9QPC8yoPukebPguM3tF2YcPJazLQ2vungUS/QVfgX4kfg8JLG8XMEs7BGHsMsnWf
         w3fkxZJL4qRFtFFUDDeU4HSLxGtgp9ILWzaDT1BR4W8HeU9wCgP76d3lMpe3LRvEws6m
         DaKo0ZUmjtsF/a2vDKI5egvq6UMhs2LDOUPrFtJLdxX0JblC8skUbpWxNofxgu3I6viC
         NmtVlh6v9C6zBzzb3MbD4v3Lg3/QuCUB128/nUJxbvZdzERtXNjD/0y26EJz9uU2lW4d
         hBd/KYTXi0PF83LdEnShwrcno1NzoqTd2hhlwkCWOPThayCNWd9X5X2anlIZ0BNAo8fw
         wv7g==
X-Gm-Message-State: ANoB5pnGYjBSW7mBaUdcwmb76B9IpZTcyZrv8b2Rb34jckeq0ECUcfHu
        Xl6vKS4iN5jyy8Ldka/WWcn6JQ==
X-Google-Smtp-Source: AA0mqf7bocP7PDul7rRtHY2oLz5aO8HTy1YdBhNhRPTn1YaCEYjEKUj/QL8QuzpT2xX9GPdxtsjU/w==
X-Received: by 2002:a63:1824:0:b0:46e:baf4:ab7a with SMTP id y36-20020a631824000000b0046ebaf4ab7amr79923468pgl.37.1670287284417;
        Mon, 05 Dec 2022 16:41:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00186b549cdc2sm11187939plk.157.2022.12.05.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:41:24 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:41:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Andrei Vagin <avagin@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Bo Liu <liubo03@inspur.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Liu Shixin <liushixin2@huawei.com>,
        Li Zetao <lizetao1@huawei.com>, Rolf Eike Beer <eb@emlix.com>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [GIT PULL] execve updates for v6.2-rc1
Message-ID: <202212051637.93142F409@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these execve updates for v6.2-rc1. Most are small
refactorings and bug fixes, but three things stand out: switching timens
(which got reverted before) looks solid now, FOLL_FORCE has been removed
(no failures seen yet across several weeks in -next), and some
whitespace cleanups (which are long overdue). The latter does end up
conflicting with changes from Al[1], but should be trivial to resolve.

Thanks!

-Kees

[1] https://lore.kernel.org/linux-next/20221128143704.3fe8f7b1@canb.auug.org.au/

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.2-rc1

for you to fetch changes up to 6a46bf558803dd2b959ca7435a5c143efe837217:

  binfmt_misc: fix shift-out-of-bounds in check_special_flags (2022-12-02 13:57:04 -0800)

----------------------------------------------------------------
execve updates for v6.2-rc1

- Add timens support (when switching mm). This version has survived
  in -next for the entire cycle (Andrei Vagin).

- Various small bug fixes, refactoring, and readability improvements
  (Bernd Edlinger, Rolf Eike Beer, Bo Liu, Li Zetao Liu Shixin).

- Remove FOLL_FORCE for stack setup (Kees Cook).

- Whilespace cleanups (Rolf Eike Beer, Kees Cook).

----------------------------------------------------------------
Andrei Vagin (2):
      fs/exec: switch timens when a task gets a new mm
      selftests/timens: add a test for vfork+exit

Bernd Edlinger (1):
      exec: Copy oldsighand->action under spin-lock

Bo Liu (1):
      binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()

Kees Cook (3):
      exec: Add comments on check_unsafe_exec() fs counting
      binfmt: Fix whitespace issues
      exec: Remove FOLL_FORCE for stack setup

Li Zetao (1):
      fs/binfmt_elf: Fix memory leak in load_elf_binary()

Liu Shixin (1):
      binfmt_misc: fix shift-out-of-bounds in check_special_flags

Rolf Eike Beer (4):
      ELF uapi: add spaces before '{'
      exec: simplify initial stack size expansion
      binfmt_elf: fix documented return value for load_elf_phdrs()
      binfmt_elf: simplify error handling in load_elf_phdrs()

Wang Yufen (1):
      binfmt: Fix error return code in load_elf_fdpic_binary()

 fs/binfmt_elf.c                             |  35 +++----
 fs/binfmt_elf_fdpic.c                       |   7 +-
 fs/binfmt_misc.c                            |   8 +-
 fs/exec.c                                   |  38 +++++---
 include/linux/nsproxy.h                     |   1 +
 include/uapi/linux/elf.h                    |  14 +--
 kernel/fork.c                               |   9 --
 kernel/nsproxy.c                            |  23 ++++-
 tools/testing/selftests/timens/.gitignore   |   1 +
 tools/testing/selftests/timens/Makefile     |   2 +-
 tools/testing/selftests/timens/vfork_exec.c | 139 ++++++++++++++++++++++++++++
 11 files changed, 219 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/timens/vfork_exec.c

-- 
Kees Cook
