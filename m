Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56B1F58F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgFJQYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 12:24:41 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:45633
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728077AbgFJQYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591806279; bh=y7p0TOMskohV4y8o6I9R5+0Ol7GlCV1QSUh85Q/4IZI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=iyJcMZ5SOJl9/RVf24JPAW6EwOaWH/onJtrNrp0WasNGdWJjCzNv/o0LuaWHxd7CQpmag7qXNaiuto5mYjqAcnIDWiCfmuii8Z0wBU+krGKeIRE/PnqZKV952BIjRfa4B10tPdkm8RkmF44Vm8qSZhaM6QFViCS/tn78dCv5QD2V1Q75VV3Nrxik37C8dyfpkoEE/2EE3ZJIBcRaEis5kakKuB+h+qainvF52hsMDPwsgIYZIuyOF46o9X8oh9glCUWzMKasDYmrg69Q7hLdhOPSnht8ZYd/euY45z4QkzlPkm5Ru6srgMD6tgUuzg1FK6MGUlbWxX8nOsagD3mSaw==
X-YMail-OSG: f6TYtoEVM1kso.KIMlr8jG8QP4p2ZNjXQrVHZTN_1a0b1fpctI.FvhUckAubguU
 1Yenh.L1_NrBLk745q0O2D0OMQQmiL1gGEe96j6K4mTu.xTBA_cYZhaFRgZpz7rX68UOzxKQC8CQ
 GHLmmR8CqZktyuHOcOxXDDWhm1dB2twfD2iUZvhDN842ZNrKJYtpGgGE4K7Gy4AmkAymppvPgVsF
 NjEdpQBCbk0PWH8xO1F5ZiBM0q_NyRt6W6D7amq1lQV4yoWKLfWCiNn2kWPEzcwMtE5FnglZCOBI
 .fo84G7gycmwiVLQEvgGzqZh4uk8z5_BRgIioQrDYEPQvD42YfOoVUwQoD75_uUqTEqPx8_po8IN
 pMX.P6cGcOg8RVp9o9AuoZ4u7aobPZCAm.enlKcORj4Djj876oQ8FMktO6XiFcaG.AEDfL0vKeO8
 drMRMEK3mCrRGRGTsoTJlyUbz.PycAMLNiBYcsvQWWvzL83zk.fTFBIiv2IOiJVFvsO4p3qmDptX
 XVLEDZUT_CYTJz4Xk4Y7FUFs.nUIIISqOfTHfnd7zbl48g7kCTlJZE139IjEoS7qKC3xkJCFYSLa
 xjNCVC7CKo2xG2D6lpzhLMp1eF6__vjNbulM_ZN69emwg2EgzlvXUl6SXgdQmVZ_zvQDkHqf11DA
 AaszuW5jgwoIrMOt8B_QpIT4iifU5.Jez0C3IuZeL58KVt5h94QP4PvwOJ6vTAHWis6mG95jS2fx
 8rKW07VccIJGOqJumsQ_d5v9FRlARUXqwJm75GRsJmUhyAj0zpp9tVBCtUiNqJPAaM_cURmBwdtx
 63d1JrlOE0z_h_VtZdxvoXhRRae4QuMkvgZxn67NbFEAAEo4wvcxi5LgLqNY0hA59B3Fz7BseGdo
 0dcpn_arCSAiWMTA8AZXlQf7HqwP78cOeLJXjUQ3on2jdX2XPFWLobdf.r9cpZo5zPDjDnsWL4T7
 syDyCr2tlzHKquH6DQ2bpNb.0feoRY7cX2vmqY5lmociV9YVoLRJIc85ZS1py2vO1xR05o7qZOMW
 lbeR7NsLkgmjkAxsc19NQ0n69Kmf1e5qyFW5DcgYVU1Z8A2gZdQTOy3hjU5kXA5IWyHc8LxyI90f
 ud7q1efL4yMrPbh3t37bR2ni5rvFxkvCw0rq9lbDoHAfcRetLvuw34OZaaE5sVXk8P1OvNFI4AKH
 7k6NaXeT3bGMr9k5vaIrG5oNawnwjaA18l97GPasWWDzJTwn1AvsUvkkm7xJn3O.hrGbWEtkVu5m
 DZjaS6z2p9QY2NzXqAxrAVwlMM4HikUpIZoMJzuBocqT0q4JTZMreaB7f0z0zcj4jwXgD3ED094a
 EIpy8p7qpYBFVi7ENflrTAHWWrO.0c_40HVJ6lLYinYf5BiI_9lGFGGTl.q1.T2MSGj9q2kL1FJJ
 fuGfsrt6.OPxOY36agXHOmUlzsfVyBdeCmQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jun 2020 16:24:39 +0000
Received: by smtp419.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9d6d50c7647decbc09a13b327f91c2e1;
          Wed, 10 Jun 2020 16:24:36 +0000 (UTC)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
 <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
 <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
 <1be571d2-c517-d7a7-788e-3bcc07afa858@i-love.sakura.ne.jp>
 <20200610033256.xkv5a7l6vtb2jiox@ast-mbp.dhcp.thefacebook.com>
 <c9828709-c8e1-06a2-8643-e09e2e555b81@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ba722761-ae29-9f1d-b851-ee2b75e0bb91@schaufler-ca.com>
Date:   Wed, 10 Jun 2020 09:24:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c9828709-c8e1-06a2-8643-e09e2e555b81@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/2020 12:30 AM, Tetsuo Handa wrote:
> Forwarding to LSM-ML. Security people, any comments?
>
> On 2020/06/10 12:32, Alexei Starovoitov wrote:
>> On Wed, Jun 10, 2020 at 12:08:20PM +0900, Tetsuo Handa wrote:
>>> On 2020/06/10 9:05, Alexei Starovoitov wrote:
>>>> I think you're still missing that usermode_blob is completely fs-les=
s.
>>>> It doesn't need any fs to work.
>>> fork_usermode_blob() allows usage like fork_usermode_blob("#!/bin/sh"=
).
>>> A problem for LSMs is not "It doesn't need any fs to work." but "It c=
an access any fs and
>>> it can issue arbitrary syscalls.".
>>>
>>> LSM modules switch their security context upon execve(), based on ava=
ilable information like
>>> "What is the !AT_SYMLINK_NOFOLLOW pathname for the requested program =
passed to execve()?",
>>> "What is the AT_SYMLINK_NOFOLLOW pathname for the requested program p=
assed to execve()?",
>>> "What are argv[]/envp[] for the requested program passed to execve()?=
", "What is the inode's
>>> security context passed to execve()?" etc. And file-less execve() req=
uest (a.k.a.
>>> fork_usermode_blob()) makes pathname information (which pathname-base=
d LSMs depend on)
>>> unavailable.
>>>
>>> Since fork_usermode_blob() can execute arbitrary code in userspace, f=
ork_usermode_blob() can
>>> allow execution of e.g. statically linked HTTP server and statically =
linked DBMS server, without
>>> giving LSM modules a chance to understand the intent of individual fi=
le-less execve() request.
>>> If many different statically linked programs were executed via fork_u=
sermode_blob(), how LSM
>>> modules can determine whether a syscall from a file-less process shou=
ld be permitted/denied?
>> What you're saying is tomoyo doesn't trust kernel modules that are bui=
lt-in
>> as part of vmlinux and doesn't trust vmlinux build.
>> I cannot really comprehend that since it means that tomoyo doesn't tru=
st itself.

That's not a rational conclusion.

>>> By the way, TOMOYO LSM wants to know meaningful AT_SYMLINK_NOFOLLOW p=
athname and !AT_SYMLINK_NOFOLLOW
>>> pathname, and currently there is no API for allow obtaining both path=
names atomically. But that is a
>>> different problem, for what this mail thread is discussing would be w=
hether we can avoid file-less
>>> execve() request (i.e. get rid of fork_usermode_blob()).
>> tomoyo does path name resolution as a string and using that for securi=
ty?
>> I'm looking at tomoyo_realpath*() and tomoyo_pathcmp(). Ouch.
>> Path based security is anti pattern of security.
>> I didn't realize tomoyo so broken.

A lawyer would respond "asked and answered". This argument is
old. We had it in the 1980's with Unix systems. While you can't
identify a *object* using a path name, you can and must use a
path name to identify *user intentions*. If that were not the case
the audit system would be massively less sophisticated. Whether
path name based controls are valuable on a system with the
namespace characteristics of Linux (complete anarchy) is in the
eye of the beholder.

We have Linux Security Modules (LSM) because, as Linus put it,
"security people are insane" and incapable of agreeing on anything.
Security is inherently subjective. AppArmor make some people feel safe,
while others like SELinux. I understand that eBPF is now the cat's
pajamas. We don't go ripping out existing security just because
someone thinks poorly of it. Security features don't go in all that
often without some malice aforethought.


