Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3674036A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjF0ScI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjF0Sbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:31:37 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78D430CF;
        Tue, 27 Jun 2023 11:31:12 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so1702148241.3;
        Tue, 27 Jun 2023 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687890671; x=1690482671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+O48OjU/IUexRRWWS35B+8H7eX2rz5tEnV5kqlvttg=;
        b=qdsBwFXzDTaJXiWEmH2Zr6L/JDkoanKXKWWghL0NJLXdodQewlEnZEerjKpjY/lm7y
         v+ewLUhmHd1LazXL2ZPc7UdBpTgkqsw6JpHnRJXEf0v3BK+xKisylNXicCK6DaAomnO3
         dTOSmabrdGASfElfJnoxlE0iVi5gJOVgX9qySUR2Ulqzm+Nr423BBmlHWvEcsdcmbsXJ
         lHsQ21qLWm3Pxk58dm07mlIeMNcnYbRpPJbW0SBc3nnzWDoWY4rSZGUXdpfAdxWe2O7D
         hz8vYFpBNeMhQ1tUKcAsYLyNLDNBSiOdcaUFH2/KGB5nZWane5eupKfI+xd5/FYeLO4I
         WBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890671; x=1690482671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+O48OjU/IUexRRWWS35B+8H7eX2rz5tEnV5kqlvttg=;
        b=TQ5PirdqgEuU8Jkas7hMkLI8A5Z3huUR60C56aODzae8lVQz6xsKbyvLvKKcgLeOIH
         5Crh4+LK1oQLMTUB1ugg0vo4u9GhZnjzyP43I1NMNya7tvXZ64XIq1V1xoxkNVwg5wo4
         UJ0WrSUsGiYKBXBvuZxFkE/w3BOFAsYay2W0CdgtK5GB2fPfp74Fo2+kNisU/u3eEplQ
         44cqFI19ciyMXW5crOSahKjXaW4rmLtN4l/znDCfxlzhpcHDKIEMh/Lp1fUm5QK04805
         n8KHkYfZHOjbPY6/mmhXxnl87VTmcaLcMYA3/vKmXXbPZf8OT+BD7w67jl1+u/wTFEBr
         n+ug==
X-Gm-Message-State: AC+VfDy7wDXpmqi/DmNFJ1kZC7bQqWwSot1JM4spDmdD5E9vGEPV+GVF
        HV0ANxO19uciAN+21XQfz1e4D6V6NhHJcJ45pkM=
X-Google-Smtp-Source: ACHHUZ5VMexi5Z2Qng12sy4+UBcuvqmM66S+2Lj0H4iJzEwVkyl60PgkOiAzZS9sZHP1l7NApuJrhq3buU055G744og=
X-Received: by 2002:a05:6102:11f6:b0:443:59e3:f4f8 with SMTP id
 e22-20020a05610211f600b0044359e3f4f8mr3889523vsg.29.1687890671553; Tue, 27
 Jun 2023 11:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz> <44neh3sog5jaskc4zy6lwnld7hussp5sslx4fun47fr45mxe3a@q2jgkjwlq74f>
In-Reply-To: <44neh3sog5jaskc4zy6lwnld7hussp5sslx4fun47fr45mxe3a@q2jgkjwlq74f>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 21:31:00 +0300
Message-ID: <CAOQ4uxifYoKdup6gzyW0iV=KFBzTWu5T8=zq8s8pFw2X3+5xRg@mail.gmail.com>
Subject: Re: [LTP PATCH] inotify13: new test for fs/splice.c functions vs
 pipes vs inotify
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:57=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> The only one that passes on 6.1.27-1 is sendfile_file_to_pipe.
>
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
> Formatted to clang-format defaults. Put the original Fixes:ed SHA in the
> metadata, that's probably fine, right?

No. The git commit is for the commits that fix the problem.
This can only be added after your fixes are merged.

I will let the LPT developers comment about style,
but I think LTP project wants tab indents.
I am personally unable to read this patch with so little indentation
and so much macroing.

>
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 246 ++++++++++++++++++
>  2 files changed, 247 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c
>
> diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/ker=
nel/syscalls/inotify/.gitignore
> index f6e5c546a..b597ea63f 100644
> --- a/testcases/kernel/syscalls/inotify/.gitignore
> +++ b/testcases/kernel/syscalls/inotify/.gitignore
> @@ -10,3 +10,4 @@
>  /inotify10
>  /inotify11
>  /inotify12
> +/inotify13
> diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/ke=
rnel/syscalls/inotify/inotify13.c
> new file mode 100644
> index 000000000..c34f1dc9f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*\
> + * Verify splice-family functions (and sendfile) generate IN_ACCESS
> + * for what they read and IN_MODIFY for what they write.
> + *
> + * Regression test for 983652c69199 and
> + * https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <inttypes.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <sys/sendfile.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "inotify.h"
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +
> +static int pipes[2] =3D {-1, -1};
> +static int inotify =3D -1;
> +static int memfd =3D -1;
> +static int data_pipes[2] =3D {-1, -1};
> +
> +static void watch_rw(int fd) {
> +  char buf[64];
> +  sprintf(buf, "/proc/self/fd/%d", fd);
> +  SAFE_MYINOTIFY_ADD_WATCH(inotify, buf, IN_ACCESS | IN_MODIFY);
> +}
> +
> +static int compar(const void *l, const void *r) {
> +  const struct inotify_event *lie =3D l;
> +  const struct inotify_event *rie =3D r;
> +  return lie->wd - rie->wd;
> +}
> +
> +static void get_events(size_t evcnt, struct inotify_event evs[static evc=
nt]) {
> +  struct inotify_event tail, *itr =3D evs;
> +  for (size_t left =3D evcnt; left; --left)
> +    SAFE_READ(true, inotify, itr++, sizeof(struct inotify_event));
> +
> +  TEST(read(inotify, &tail, sizeof(struct inotify_event)));
> +  if (TST_RET !=3D -1)
> +    tst_brk(TFAIL, "expect %zu events", evcnt);
> +  if (TST_ERR !=3D EAGAIN)
> +    tst_brk(TFAIL | TTERRNO, "expected EAGAIN");
> +
> +  qsort(evs, evcnt, sizeof(struct inotify_event), compar);
> +}
> +
> +static void expect_event(struct inotify_event *ev, int wd, uint32_t mask=
) {
> +  if (ev->wd !=3D wd)
> +    tst_brk(TFAIL, "expect event for wd %d got %d", wd, ev->wd);
> +  if (ev->mask !=3D mask)
> +    tst_brk(TFAIL, "expect event with mask %" PRIu32 " got %" PRIu32 "",=
 mask,
> +            ev->mask);
> +}
> +
> +#define F2P(splice)                                                     =
       \
> +  SAFE_WRITE(SAFE_WRITE_RETRY, memfd, __func__, sizeof(__func__));      =
       \
> +  SAFE_LSEEK(memfd, 0, SEEK_SET);                                       =
       \
> +  watch_rw(memfd);                                                      =
       \
> +  watch_rw(pipes[0]);                                                   =
       \
> +  TEST(splice);                                                         =
       \
> +  if (TST_RET =3D=3D -1)                                                =
           \
> +    tst_brk(TBROK | TERRNO, #splice);                                   =
       \
> +  if (TST_RET !=3D sizeof(__func__))                                    =
         \
> +    tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);                   =
       \
> +                                                                        =
       \
> +  /*expecting: IN_ACCESS memfd, IN_MODIFY pipes[0]*/                    =
       \
> +  struct inotify_event events[2];                                       =
       \
> +  get_events(ARRAY_SIZE(events), events);                               =
       \
> +  expect_event(events + 0, 1, IN_ACCESS);                               =
       \
> +  expect_event(events + 1, 2, IN_MODIFY);                               =
       \
> +                                                                        =
       \
> +  char buf[sizeof(__func__)];                                           =
       \
> +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                     =
       \
> +  if (memcmp(buf, __func__, sizeof(__func__)))                          =
       \
> +    tst_brk(TFAIL, "buf contents bad");
> +static void splice_file_to_pipe(void) {
> +  F2P(splice(memfd, NULL, pipes[1], NULL, 128 * 1024 * 1024, 0));
> +}
> +static void sendfile_file_to_pipe(void) {
> +  F2P(sendfile(pipes[1], memfd, NULL, 128 * 1024 * 1024));
> +}
> +
> +static void splice_pipe_to_file(void) {
> +  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
> +  watch_rw(pipes[0]);
> +  watch_rw(memfd);
> +  TEST(splice(pipes[0], NULL, memfd, NULL, 128 * 1024 * 1024, 0));
> +  if(TST_RET =3D=3D -1)
> +               tst_brk(TBROK | TERRNO, "splice");
> +       if(TST_RET !=3D sizeof(__func__))
> +               tst_brk(TBROK, "splice: %" PRId64 "", TST_RET);
> +
> +       // expecting: IN_ACCESS pipes[0], IN_MODIFY memfd
> +       struct inotify_event events[2];
> +       get_events(ARRAY_SIZE(events), events);
> +       expect_event(events + 0, 1, IN_ACCESS);
> +       expect_event(events + 1, 2, IN_MODIFY);
> +
> +  char buf[sizeof(__func__)];
> +  SAFE_LSEEK(memfd, 0, SEEK_SET);
> +  SAFE_READ(true, memfd, buf, sizeof(__func__));
> +  if (memcmp(buf, __func__, sizeof(__func__)))
> +                tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +#define P2P(splice)                                                     =
       \
> +  SAFE_WRITE(SAFE_WRITE_RETRY, data_pipes[1], __func__, sizeof(__func__)=
);     \
> +  watch_rw(data_pipes[0]);                                              =
       \
> +  watch_rw(pipes[1]);                                                   =
       \
> +  TEST(splice);                                                         =
       \
> +  if (TST_RET =3D=3D -1)                                                =
           \
> +                tst_brk(TBROK | TERRNO, #splice);                       =
       \
> +  if (TST_RET !=3D sizeof(__func__))                                    =
         \
> +                tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);       =
       \
> +                                                                        =
       \
> +  /* expecting: IN_ACCESS data_pipes[0], IN_MODIFY pipes[1] */          =
       \
> +  struct inotify_event events[2];                                       =
       \
> +  get_events(ARRAY_SIZE(events), events);                               =
       \
> +  expect_event(events + 0, 1, IN_ACCESS);                               =
       \
> +  expect_event(events + 1, 2, IN_MODIFY);                               =
       \
> +                                                                        =
       \
> +  char buf[sizeof(__func__)];                                           =
       \
> +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                     =
       \
> +  if (memcmp(buf, __func__, sizeof(__func__)))                          =
       \
> +                tst_brk(TFAIL, "buf contents bad");
> +static void splice_pipe_to_pipe(void) {
> +  P2P(splice(data_pipes[0], NULL, pipes[1], NULL, 128 * 1024 * 1024, 0))=
;
> +}
> +static void tee_pipe_to_pipe(void) {
> +  P2P(tee(data_pipes[0], pipes[1], 128 * 1024 * 1024, 0));
> +}
> +
> +static char vmsplice_pipe_to_mem_dt[32 * 1024];
> +static void vmsplice_pipe_to_mem(void) {
> +  memcpy(vmsplice_pipe_to_mem_dt, __func__, sizeof(__func__));
> +  watch_rw(pipes[0]);
> +  TEST(vmsplice(pipes[1],
> +                &(struct iovec){.iov_base =3D vmsplice_pipe_to_mem_dt,
> +                                .iov_len =3D sizeof(vmsplice_pipe_to_mem=
_dt)},
> +                1, SPLICE_F_GIFT));
> +  if (TST_RET =3D=3D -1)
> +    tst_brk(TBROK | TERRNO, "vmsplice");
> +  if (TST_RET !=3D sizeof(vmsplice_pipe_to_mem_dt))
> +    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
> +
> +  // expecting: IN_MODIFY pipes[0]
> +  struct inotify_event event;
> +  get_events(1, &event);
> +  expect_event(&event, 1, IN_MODIFY);
> +
> +  char buf[sizeof(__func__)];
> +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));
> +  if (memcmp(buf, __func__, sizeof(__func__)))
> +    tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +static void vmsplice_mem_to_pipe(void) {
> +  char buf[sizeof(__func__)];
> +  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
> +  watch_rw(pipes[1]);
> +  TEST(vmsplice(pipes[0],
> +                &(struct iovec){.iov_base =3D buf, .iov_len =3D sizeof(b=
uf)}, 1,
> +                0));
> +  if (TST_RET =3D=3D -1)
> +    tst_brk(TBROK | TERRNO, "vmsplice");
> +  if (TST_RET !=3D sizeof(buf))
> +    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
> +
> +  // expecting: IN_ACCESS pipes[1]
> +  struct inotify_event event;
> +  get_events(1, &event);
> +  expect_event(&event, 1, IN_ACCESS);
> +  if (memcmp(buf, __func__, sizeof(__func__)))
> +    tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +typedef void (*tests_f)(void);
> +#define TEST_F(f) { f, #f }
> +static const struct {
> +        tests_f f;
> +        const char *n;
> +} tests[] =3D {
> +    TEST_F(splice_file_to_pipe),  TEST_F(sendfile_file_to_pipe),
> +    TEST_F(splice_pipe_to_file),  TEST_F(splice_pipe_to_pipe),
> +    TEST_F(tee_pipe_to_pipe),     TEST_F(vmsplice_pipe_to_mem),
> +    TEST_F(vmsplice_mem_to_pipe),
> +};
> +
> +static void run_test(unsigned int n)
> +{
> +       tst_res(TINFO, "%s", tests[n].n);
> +
> +       SAFE_PIPE2(pipes, O_CLOEXEC);
> +       SAFE_PIPE2(data_pipes, O_CLOEXEC);
> +       inotify =3D SAFE_MYINOTIFY_INIT1(IN_NONBLOCK | IN_CLOEXEC);
> +       if((memfd =3D memfd_create(__func__, MFD_CLOEXEC)) =3D=3D -1)
> +               tst_brk(TCONF | TERRNO, "memfd");
> +       tests[n].f();

Normally, a test cases table would encode things like
the number of expected events and type of events.
The idea is that the test template has parametrized code
and not just a loop for test cases subroutines, but there
are many ways to write tests, so as long as it gets the job
done and is readable to humans, I don't mind.

Right now this test may do the job, but it is not readable
for this human ;-)
mostly because of the huge macros -
LTP is known for pretty large macros, but those are
for generic utilities and you have complete test cases
written as macros (templates).

> +       tst_res(TPASS, "=D0=BE=D0=BA");
> +}
> +
> +static void cleanup(void)
> +{
> +       if (memfd !=3D -1)
> +               SAFE_CLOSE(memfd);
> +       if (inotify !=3D -1)
> +               SAFE_CLOSE(inotify);
> +       if (pipes[0] !=3D -1)
> +               SAFE_CLOSE(pipes[0]);
> +       if (pipes[1] !=3D -1)
> +               SAFE_CLOSE(pipes[1]);
> +       if (data_pipes[0] !=3D -1)
> +               SAFE_CLOSE(data_pipes[0]);
> +       if (data_pipes[1] !=3D -1)
> +               SAFE_CLOSE(data_pipes[1]);
> +}
> +

This cleanup does not happen for every test case -
it happens only at the end of all the tests IIRC.

> +static struct tst_test test =3D {
> +       .max_runtime =3D 10,
> +       .cleanup =3D cleanup,
> +       .test =3D run_test,
> +       .tcnt =3D ARRAY_SIZE(tests),
> +       .tags =3D (const struct tst_tag[]) {
> +               {"linux-git", "983652c69199"},

Leave this out for now.

Thanks,
Amir.
