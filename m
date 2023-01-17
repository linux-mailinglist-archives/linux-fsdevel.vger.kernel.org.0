Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9766D689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjAQGz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 01:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjAQGz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:55:27 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2A2312A;
        Mon, 16 Jan 2023 22:55:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id n5so31661567ljc.9;
        Mon, 16 Jan 2023 22:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fsyWypeAMY0JG1EEfmucwsYJ8Jkxy8QnCP30FOG3DM=;
        b=ge9qmfNZOKrTVbnhqKB41V/JLvba3r8CnvOXqwvE3ZvreVy36aGGsxectcEDl8PMpX
         Isn1UQykNLwm+TVO2Z2N42rEqNOmnNYVDlRABbg9iLrBgiGgHNnaRxjfeU0qk5tA/oeK
         mmBy9LICe4UrFoMh6o4X/dr/dVYxxEnDZccGsaSeJC4eYlKX5x3gKacoGZ6gxGOppCXu
         KsFVnqHm40yaZcmC1rmVgplvnKl2eGtGbGrOykPkmNpQ93g9kPBmGdMCfvmRneFBP9oN
         dX8B6N2BgLGo+S9lGMoLyLfNc04ID6AbsF8wG1dtP2bDskFa+X+4fqxTPin3TTKYcOuJ
         HXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fsyWypeAMY0JG1EEfmucwsYJ8Jkxy8QnCP30FOG3DM=;
        b=DimcfJ6rMjam2yK6Y5XuwjOTvB8A33NE3UynVuzz8cPwNanJi2f0szMP43k1L48JRP
         Ljx1u7Zp6zx9hNqoZnVuFocRvcR1qxkK032QCg1SUGNOmEwSDjJ1i6He9RuVQ8CqfDbC
         pnNCrm7kcqt6+pMlHe5Nx+MvVX6h2yMba9vQAIjHodz0YNXG+CV4qJSUfM4wRMeot91S
         Rv5wW2QHLZKgHraYWTAjnGiT4BVBOShS6EKxAPaqKvEvAyE1zGESGNM0EoIHvnCWZ+BP
         kmiri5SUjOrmwASfMhAaRA81byXX49zsKzUig/13ItLWheDI0ap5Cgqeimsa/DN0b90Z
         4j0w==
X-Gm-Message-State: AFqh2kq09xlmLjYu7K26k57nMSKgfJVmblrMmVJ9TGoNMIUlXAWLjujF
        ZBJQn6r7e/4S5A1A8gGLBrQ4LV4FFshi3W72oC4=
X-Google-Smtp-Source: AMrXdXvmBNPQO9jgbltbUh91NFG7RZih0v//EXtq4LQgVpuBF6K8m+DGKok+S1Wwy5EVGU9wVEPiIZI2RZFzcncQXSM=
X-Received: by 2002:a2e:9645:0:b0:28b:9588:55a4 with SMTP id
 z5-20020a2e9645000000b0028b958855a4mr221382ljh.238.1673938524528; Mon, 16 Jan
 2023 22:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn> <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
 <Y8TUqcSO5VrbYfcM@casper.infradead.org> <Y8W9TR5ifZmRADLB@ZenIV> <20230116141608.a72015bdd8bbbedd5c50cc3e@linux-foundation.org>
In-Reply-To: <20230116141608.a72015bdd8bbbedd5c50cc3e@linux-foundation.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 17 Jan 2023 07:54:46 +0100
Message-ID: <CA+icZUXN-6TRq1CO3O5i+0WAs91mk8iM-kASgPCjMzVv9yragA@mail.gmail.com>
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        maobibo <maobibo@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        David Howells <dhowells@redhat.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000021993605f2702fe0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000021993605f2702fe0
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 16, 2023 at 11:16 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 16 Jan 2023 21:10:37 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > On Mon, Jan 16, 2023 at 04:38:01AM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 16, 2023 at 11:16:13AM +0800, maobibo wrote:
> > > > Hongchen,
> > > >
> > > > I have a glance with this patch, it simply replaces with
> > > > spinlock_irqsave with mutex lock. There may be performance
> > > > improvement with two processes competing with pipe, however
> > > > for N processes, there will be complex context switches
> > > > and ipi interruptts.
> > > >
> > > > Can you find some cases with more than 2 processes competing
> > > > pipe, rather than only unixbench?
> > >
> > > What real applications have pipes with more than 1 writer & 1 reader?
> > > I'm OK with slowing down the weird cases if the common cases go faster.
> >
> > >From commit 0ddad21d3e99c743a3aa473121dc5561679e26bb:
> >     While this isn't a common occurrence in the traditional "use a pipe as a
> >     data transport" case, where you typically only have a single reader and
> >     a single writer process, there is one common special case: using a pipe
> >     as a source of "locking tokens" rather than for data communication.
> >
> >     In particular, the GNU make jobserver code ends up using a pipe as a way
> >     to limit parallelism, where each job consumes a token by reading a byte
> >     from the jobserver pipe, and releases the token by writing a byte back
> >     to the pipe.
>
> The author has tested this patch with Linus's test code from 0ddad21d3e
> and the results were OK
> (https://lkml.kernel.org/r/c3cbede6-f19e-3333-ba0f-d3f005e5d599@loongson.cn).
>

Yesterday, I had some time to play with and without this patch on my
Debian/unstable AMD64 box.

[ TEST-CASE ]

BASE: Linux v6.2-rc4

PATCH: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock

TEST-CASE: Taken from commit 0ddad21d3e99

RUN: gcc-12 -o 0ddad21d3e99 0ddad21d3e99.c

Link: https://lore.kernel.org/all/20230107012324.30698-1-zhanghongchen@loongson.cn/
Link: https://git.kernel.org/linus/0ddad21d3e99


[ INSTRUCTIONS ]

echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid

10 runs: /usr/bin/perf stat --repeat=10 ./0ddad21d3e99

echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid


[ BEFORE ]

Performance counter stats for './0ddad21d3e99' (10 runs):

        23.985,50 msec task-clock                       #    3,246
CPUs utilized            ( +-  0,20% )
        1.112.822      context-switches                 #   46,696
K/sec                    ( +-  0,30% )
          403.033      cpu-migrations                   #   16,912
K/sec                    ( +-  0,28% )
            1.508      page-faults                      #   63,278
/sec                     ( +-  2,95% )
   39.436.000.959      cycles                           #    1,655 GHz
                     ( +-  0,22% )
   29.364.329.413      stalled-cycles-frontend          #   74,91%
frontend cycles idle     ( +-  0,24% )
   22.139.448.400      stalled-cycles-backend           #   56,48%
backend cycles idle      ( +-  0,23% )
   18.565.538.523      instructions                     #    0,47
insn per cycle
                                                 #    1,57  stalled
cycles per insn  ( +-  0,17% )
    4.059.885.546      branches                         #  170,359
M/sec                    ( +-  0,17% )
       59.991.226      branch-misses                    #    1,48% of
all branches          ( +-  0,19% )

           7,3892 +- 0,0127 seconds time elapsed  ( +-  0,17% )


[ AFTER ]

Performance counter stats for './0ddad21d3e99' (10 runs):

        24.175,94 msec task-clock                       #    3,362
CPUs utilized            ( +-  0,11% )
        1.139.152      context-switches                 #   47,119
K/sec                    ( +-  0,12% )
          407.994      cpu-migrations                   #   16,876
K/sec                    ( +-  0,26% )
            1.555      page-faults                      #   64,319
/sec                     ( +-  3,11% )
   40.904.849.091      cycles                           #    1,692 GHz
                     ( +-  0,13% )
   30.587.623.034      stalled-cycles-frontend          #   74,84%
frontend cycles idle     ( +-  0,15% )
   23.145.533.537      stalled-cycles-backend           #   56,63%
backend cycles idle      ( +-  0,16% )
   18.762.964.037      instructions                     #    0,46
insn per cycle
                                                 #    1,63  stalled
cycles per insn  ( +-  0,11% )
    4.057.182.849      branches                         #  167,817
M/sec                    ( +-  0,09% )
       63.887.806      branch-misses                    #    1,58% of
all branches          ( +-  0,25% )

          7,19157 +- 0,00644 seconds time elapsed  ( +-  0,09% )


[ RESULT ]

seconds time elapsed: - 2,67%

The test-case c-file is attached and for the case the above lines were
truncated I have attached as a README file.

Feel free to add a...

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM v15.0.3 (x86-64)

If you need further information, please let me know.

-Sedat-

> I've been stalling on this patch until Linus gets back to his desk,
> which now appears to have happened.
>
> Hongchen, when convenient, please capture this discussion (as well as
> the testing results with Linus's sample code) in the changelog and send
> us a v4, with Linus on cc?
>

--00000000000021993605f2702fe0
Content-Type: text/x-csrc; charset="US-ASCII"; name="0ddad21d3e99.c"
Content-Disposition: attachment; filename="0ddad21d3e99.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lczvlfim0>
X-Attachment-Id: f_lczvlfim0

Ly8gVGVzdC1jYXNlOiBCZW5jaG1hcmsgcGlwZSBwZXJmb3JtYW5jZQovLyAgICBBdXRob3I6IExp
bnVzIFRvcnZhbGRzCi8vICAgICAgTGluazogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9saW51cy8w
ZGRhZDIxZDNlOTkKLy8KLy8gICBDb21waWxlOiBnY2MtMTIgLW8gMGRkYWQyMWQzZTk5IDBkZGFk
MjFkM2U5OS5jCi8vCiNpbmNsdWRlIDx1bmlzdGQuaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikKICAgIHsKICAgICAgICBpbnQgZmRbMl0sIGNvdW50ZXJzWzJdOwoKICAgICAgICBw
aXBlKGZkKTsKICAgICAgICBjb3VudGVyc1swXSA9IDA7CiAgICAgICAgY291bnRlcnNbMV0gPSAt
MTsKICAgICAgICB3cml0ZShmZFsxXSwgY291bnRlcnMsIHNpemVvZihjb3VudGVycykpOwoKICAg
ICAgICAvKiA2NCBwcm9jZXNzZXMgKi8KICAgICAgICBmb3JrKCk7IGZvcmsoKTsgZm9yaygpOyBm
b3JrKCk7IGZvcmsoKTsgZm9yaygpOwoKICAgICAgICBkbyB7CiAgICAgICAgICAgICAgICBpbnQg
aTsKICAgICAgICAgICAgICAgIHJlYWQoZmRbMF0sICZpLCBzaXplb2YoaSkpOwogICAgICAgICAg
ICAgICAgaWYgKGkgPCAwKQogICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAg
ICAgICAgICAgIGNvdW50ZXJzWzBdID0gaSsxOwogICAgICAgICAgICAgICAgd3JpdGUoZmRbMV0s
IGNvdW50ZXJzLCAoMSsoaSAmIDEpKSAqc2l6ZW9mKGludCkpOwogICAgICAgIH0gd2hpbGUgKGNv
dW50ZXJzWzBdIDwgMTAwMDAwMCk7CiAgICAgICAgcmV0dXJuIDA7CiAgICB9Cg==
--00000000000021993605f2702fe0
Content-Type: application/octet-stream; 
	name=README_zhanghongchen-pipe-v3-0ddad21d3e99
Content-Disposition: attachment; 
	filename=README_zhanghongchen-pipe-v3-0ddad21d3e99
Content-Transfer-Encoding: base64
Content-ID: <f_lczvmufq1>
X-Attachment-Id: f_lczvmufq1

WyBURVNULUNBU0UgXQoKQkFTRTogTGludXggdjYuMi1yYzQKClBBVENIOiBbUEFUQ0ggdjNdIHBp
cGU6IHVzZSBfX3BpcGVfe2xvY2ssdW5sb2NrfSBpbnN0ZWFkIG9mIHNwaW5sb2NrCgpURVNULUNB
U0U6IFRha2VuIGZyb20gY29tbWl0IDBkZGFkMjFkM2U5OQoKUlVOOiBnY2MtMTIgLW8gMGRkYWQy
MWQzZTk5IDBkZGFkMjFkM2U5OS5jCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzAxMDcwMTIzMjQuMzA2OTgtMS16aGFuZ2hvbmdjaGVuQGxvb25nc29uLmNuLwpMaW5rOiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL2xpbnVzLzBkZGFkMjFkM2U5OQoKClsgSU5TVFJVQ1RJT05T
IF0KCmVjaG8gMCB8IHN1ZG8gdGVlIC9wcm9jL3N5cy9rZXJuZWwva3B0cl9yZXN0cmljdCAvcHJv
Yy9zeXMva2VybmVsL3BlcmZfZXZlbnRfcGFyYW5vaWQKCjEwIHJ1bnM6IC91c3IvYmluL3BlcmYg
c3RhdCAtLXJlcGVhdD0xMCAuLzBkZGFkMjFkM2U5OQoKZWNobyAxIHwgc3VkbyB0ZWUgL3Byb2Mv
c3lzL2tlcm5lbC9rcHRyX3Jlc3RyaWN0IC9wcm9jL3N5cy9rZXJuZWwvcGVyZl9ldmVudF9wYXJh
bm9pZAoKClsgQkVGT1JFIF0KCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnLi8wZGRh
ZDIxZDNlOTknICgxMCBydW5zKToKCiAgICAgICAgIDIzLjk4NSw1MCBtc2VjIHRhc2stY2xvY2sg
ICAgICAgICAgICAgICAgICAgICAgICMgICAgMywyNDYgQ1BVcyB1dGlsaXplZCAgICAgICAgICAg
ICggKy0gIDAsMjAlICkKICAgICAgICAgMS4xMTIuODIyICAgICAgY29udGV4dC1zd2l0Y2hlcyAg
ICAgICAgICAgICAgICAgIyAgIDQ2LDY5NiBLL3NlYyAgICAgICAgICAgICAgICAgICAgKCArLSAg
MCwzMCUgKQogICAgICAgICAgIDQwMy4wMzMgICAgICBjcHUtbWlncmF0aW9ucyAgICAgICAgICAg
ICAgICAgICAjICAgMTYsOTEyIEsvc2VjICAgICAgICAgICAgICAgICAgICAoICstICAwLDI4JSAp
CiAgICAgICAgICAgICAxLjUwOCAgICAgIHBhZ2UtZmF1bHRzICAgICAgICAgICAgICAgICAgICAg
ICMgICA2MywyNzggL3NlYyAgICAgICAgICAgICAgICAgICAgICggKy0gIDIsOTUlICkKICAgIDM5
LjQzNi4wMDAuOTU5ICAgICAgY3ljbGVzICAgICAgICAgICAgICAgICAgICAgICAgICAgIyAgICAx
LDY1NSBHSHogICAgICAgICAgICAgICAgICAgICAgKCArLSAgMCwyMiUgKQogICAgMjkuMzY0LjMy
OS40MTMgICAgICBzdGFsbGVkLWN5Y2xlcy1mcm9udGVuZCAgICAgICAgICAjICAgNzQsOTElIGZy
b250ZW5kIGN5Y2xlcyBpZGxlICAgICAoICstICAwLDI0JSApCiAgICAyMi4xMzkuNDQ4LjQwMCAg
ICAgIHN0YWxsZWQtY3ljbGVzLWJhY2tlbmQgICAgICAgICAgICMgICA1Niw0OCUgYmFja2VuZCBj
eWNsZXMgaWRsZSAgICAgICggKy0gIDAsMjMlICkKICAgIDE4LjU2NS41MzguNTIzICAgICAgaW5z
dHJ1Y3Rpb25zICAgICAgICAgICAgICAgICAgICAgIyAgICAwLDQ3ICBpbnNuIHBlciBjeWNsZSAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMgICAgMSw1NyAgc3RhbGxlZCBjeWNsZXMgcGVyIGluc24gICggKy0gIDAsMTclICkKICAgICA0
LjA1OS44ODUuNTQ2ICAgICAgYnJhbmNoZXMgICAgICAgICAgICAgICAgICAgICAgICAgIyAgMTcw
LDM1OSBNL3NlYyAgICAgICAgICAgICAgICAgICAgKCArLSAgMCwxNyUgKQogICAgICAgIDU5Ljk5
MS4yMjYgICAgICBicmFuY2gtbWlzc2VzICAgICAgICAgICAgICAgICAgICAjICAgIDEsNDglIG9m
IGFsbCBicmFuY2hlcyAgICAgICAgICAoICstICAwLDE5JSApCgogICAgICAgICAgICA3LDM4OTIg
Ky0gMCwwMTI3IHNlY29uZHMgdGltZSBlbGFwc2VkICAoICstICAwLDE3JSApCgoKWyBBRlRFUiBd
CgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJy4vMGRkYWQyMWQzZTk5JyAoMTAgcnVu
cyk6CgogICAgICAgICAyNC4xNzUsOTQgbXNlYyB0YXNrLWNsb2NrICAgICAgICAgICAgICAgICAg
ICAgICAjICAgIDMsMzYyIENQVXMgdXRpbGl6ZWQgICAgICAgICAgICAoICstICAwLDExJSApCiAg
ICAgICAgIDEuMTM5LjE1MiAgICAgIGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAgICAgICAgICMg
ICA0NywxMTkgSy9zZWMgICAgICAgICAgICAgICAgICAgICggKy0gIDAsMTIlICkKICAgICAgICAg
ICA0MDcuOTk0ICAgICAgY3B1LW1pZ3JhdGlvbnMgICAgICAgICAgICAgICAgICAgIyAgIDE2LDg3
NiBLL3NlYyAgICAgICAgICAgICAgICAgICAgKCArLSAgMCwyNiUgKQogICAgICAgICAgICAgMS41
NTUgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICAgICAgICAjICAgNjQsMzE5IC9zZWMg
ICAgICAgICAgICAgICAgICAgICAoICstICAzLDExJSApCiAgICA0MC45MDQuODQ5LjA5MSAgICAg
IGN5Y2xlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICMgICAgMSw2OTIgR0h6ICAgICAgICAg
ICAgICAgICAgICAgICggKy0gIDAsMTMlICkKICAgIDMwLjU4Ny42MjMuMDM0ICAgICAgc3RhbGxl
ZC1jeWNsZXMtZnJvbnRlbmQgICAgICAgICAgIyAgIDc0LDg0JSBmcm9udGVuZCBjeWNsZXMgaWRs
ZSAgICAgKCArLSAgMCwxNSUgKQogICAgMjMuMTQ1LjUzMy41MzcgICAgICBzdGFsbGVkLWN5Y2xl
cy1iYWNrZW5kICAgICAgICAgICAjICAgNTYsNjMlIGJhY2tlbmQgY3ljbGVzIGlkbGUgICAgICAo
ICstICAwLDE2JSApCiAgICAxOC43NjIuOTY0LjAzNyAgICAgIGluc3RydWN0aW9ucyAgICAgICAg
ICAgICAgICAgICAgICMgICAgMCw0NiAgaW5zbiBwZXIgY3ljbGUgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjICAgIDEsNjMgIHN0YWxs
ZWQgY3ljbGVzIHBlciBpbnNuICAoICstICAwLDExJSApCiAgICAgNC4wNTcuMTgyLjg0OSAgICAg
IGJyYW5jaGVzICAgICAgICAgICAgICAgICAgICAgICAgICMgIDE2Nyw4MTcgTS9zZWMgICAgICAg
ICAgICAgICAgICAgICggKy0gIDAsMDklICkKICAgICAgICA2My44ODcuODA2ICAgICAgYnJhbmNo
LW1pc3NlcyAgICAgICAgICAgICAgICAgICAgIyAgICAxLDU4JSBvZiBhbGwgYnJhbmNoZXMgICAg
ICAgICAgKCArLSAgMCwyNSUgKQoKICAgICAgICAgICA3LDE5MTU3ICstIDAsMDA2NDQgc2Vjb25k
cyB0aW1lIGVsYXBzZWQgICggKy0gIDAsMDklICkKCgpbIFJFU1VMVCBdCgpzZWNvbmRzIHRpbWUg
ZWxhcHNlZDogLSAyLDY3JQoKCi1kaWxla3MgLy8gMTYtSmFuLTIwMjMK
--00000000000021993605f2702fe0--
